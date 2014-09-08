library dart_route_checker;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'dart:async';

class MyAppModule extends Module {
  MyAppModule() {
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
    bind(RouteInitializerFn, toImplementation: Routes);
    bind(Route1);
    bind(Route2);
  }
}

void main() {
  applicationFactory()
    .addModule(new MyAppModule())
    .run();
}

@Injectable()
class Routes
{
  void call(Router router, RouteViewFactory views) {
    views.configure({
    'route1': ngRoute(path: '/route1', defaultRoute: true, viewHtml: '<route1></route1>'),
    'route2': ngRoute(path: '/route2/:id', viewHtml: '<route2></route2>')
});
  }
}

int count = 1;

@Component(selector: 'route1', publishAs: 'cmp', template: '''<h1>ROUTE 1 - {{cmp.Count}}</h1>''', useShadowDom: false)
class Route1{
	int get Count => count;

	Route1(Router router){
		new Future.delayed(new Duration(milliseconds: 200)).then((_){
			count++;
			router.go("route2",{"id":1});
		});
	}
}

@Component(selector: 'route2', publishAs: 'cmp', template: '''<h1>ROUTE 2 - {{cmp.Count}}</h1>''', useShadowDom: false)
class Route2{

int get Count => count;

Route2(Router router){
		new Future.delayed(new Duration(milliseconds: 200)).then((_){
			count++;
            			router.go("route1",{});
		});
	}
}