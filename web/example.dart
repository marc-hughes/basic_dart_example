library examplebug;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:angular/animate/module.dart';
import 'dart:async';

class ChildModel {
  String name;
  int id;
  bool visible = false;

  ChildModel(String this.name, this.id) {}
}


@Component(selector: 'parent-component',
  publishAs: 'ctrl',
  templateUrl: 'parent.html',
  useShadowDom: false
  )
class ParentControl {

  Scope scope;
  List<ChildModel> myChildren = new List<ChildModel>();
  ParentControl(this.scope) {
  }

  void add() {
    myChildren.add(new ChildModel("Test", 0));
  }
  void remove() {
    myChildren.removeAt(0);
  }


}

@Component(selector: 'child-component',
publishAs: 'ctrl',
templateUrl: 'child.html',
useShadowDom: false
)
class ChildControl {
  @NgOneWay('child')
  set model(ChildModel model) { _model = model; }
  ChildModel get model { return _model; }
  ChildModel _model;

  String childName() {
    return model.name;
  }
}


class ExampleModule extends Module {
  ExampleModule() {
    type(ParentControl);
    type(ChildControl);
    install(new AnimationModule() );
  }

}

main() {
  applicationFactory().addModule(new ExampleModule()).run();
}