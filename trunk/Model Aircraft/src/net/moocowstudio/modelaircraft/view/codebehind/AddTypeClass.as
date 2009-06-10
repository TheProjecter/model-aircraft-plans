package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.MouseEvent;

    import mx.containers.Canvas;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.database.DatabaseFacade;
    import net.moocowstudio.modelaircraft.model.AircraftType;

    public class AddTypeClass extends Canvas {
        /* Properties */
        public var txtTitle : TextInput;

        public function AddTypeClass() {
        }

        /* Event Handlers */
        public function onClick_btnAdd(event : MouseEvent) : void {
            var facade : DatabaseFacade = new DatabaseFacade();
            var aircraftType : AircraftType = new AircraftType();
            aircraftType.id = 1;
            aircraftType.title = this.txtTitle.text;
            facade.addAircraftType(aircraftType);
        }
    }
}