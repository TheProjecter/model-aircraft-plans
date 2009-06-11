package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;

    import mx.containers.Canvas;
    import mx.containers.ViewStack;

    import net.moocowstudio.modelaircraft.database.DatabaseFacade;
    import net.moocowstudio.modelaircraft.database.Helper;
    import net.moocowstudio.modelaircraft.database.sqlite.Query;
    import net.moocowstudio.modelaircraft.view.AddAircraft;

    public class MaintenanceClass extends Canvas {
        /* Properties */
        public var viewStack : ViewStack;
        public var viewAddAircraft : AddAircraft;
        public var addAircraft_query : Query;


        public function MaintenanceClass() {
            super();
        }

        /* Event Handlers */
        public function onItemClick_viewStack(event : Event) : void {
            if (this.viewStack.selectedIndex == 0) {
                this.viewAddAircraft.loadDataProviders();
            }
        }

        public function clearFormFields() : void {
            if (this.viewStack.selectedIndex == 0) {
                this.viewAddAircraft.clearFormFields();
            }
        }


        public function onAddAircraft() : void {
            var id : int = DatabaseFacade.getInstance().database.getCountFor(1);
            this.addAircraft_query.parameters = [
                id,
                this.viewAddAircraft.txtName.text,
                this.viewAddAircraft.comboBoxPublication.selectedItem.id,
                this.viewAddAircraft.comboBoxDesigner.selectedItem.id,
                this.viewAddAircraft.comboBoxType.selectedItem.id,
                this.viewAddAircraft.txtYear.text,
                int(new Number(this.viewAddAircraft.txtWingspan.text)),
                Helper.byteArrayToBase64(this.viewAddAircraft.imagePicker.imageAsByteArray)
                ]
            this.addAircraft_query.execute();
        }

    }
}