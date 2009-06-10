package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;

    import mx.containers.Canvas;
    import mx.containers.ViewStack;

    import net.moocowstudio.modelaircraft.view.AddAircraft;

    public class MaintenanceClass extends Canvas {
        /* Properties */
        public var viewStack : ViewStack;
        public var viewAddAircraft : AddAircraft;

        public function MaintenanceClass() {
            super();
        }

        /* Event Handlers */
        public function onItemClick_viewStack(event : Event) : void {
            if (this.viewStack.selectedIndex == 0) {
                this.viewAddAircraft.loadDataProviders();
            }
        }

    }
}