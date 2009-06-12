package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;

    import mx.containers.Canvas;
    import mx.controls.ComboBox;
    import mx.controls.TextArea;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.database.sqlite.Query;
    import net.moocowstudio.modelaircraft.view.ImagePicker;

    public class AddAircraftBase extends Canvas {
        /* Properties */
        [Bindable] public var comboboxDesignerData : Array = new Array();
        [Bindable] public var comboBoxTypeData : Array = new Array();
        [Bindable] public var comboBoxPublicationData : Array = new Array();
        [Bindable] public var comboBoxPlanKeyData : Array = new Array();

        /* Components */
        public var comboBoxDesigner : ComboBox;
        public var comboBoxType : ComboBox;
        public var comboBoxPublication : ComboBox;
        public var comboBoxPlanKey : ComboBox;
        public var txtYear : TextInput;
        public var txtWingspan : TextInput;
        public var txtName : TextInput;
        public var imagePicker : ImagePicker;
        public var txtComment : TextArea;
        public var txtPlanNumber : TextInput;

        /* Queries */
        public var querySelectAllFromDesigner : Query;
        public var querySelectAllFromAircraftType : Query;
        public var querySelectAllFromPublication : Query;
        public var querySelectAllFromPlanKey : Query;

        public function AddAircraftBase() {
            super();
        }

        /* Functions */
        public function loadDataProviders() : void {
            this.querySelectAllFromAircraftType.execute();
            this.querySelectAllFromDesigner.execute();
            this.querySelectAllFromPublication.execute();
            this.querySelectAllFromPlanKey.execute();
        }

        public function clearFormFields() : void {
            this.txtName.text = "";
            this.txtWingspan.text = "";
            this.txtYear.text = "";
            this.txtPlanNumber.text = "";
            this.txtComment.text = "";
        }

        /* Event Handlers */
        public function onCreationComplete(event : Event) : void {
            this.loadDataProviders();
        }

        public function onLabelFunction_comboBoxDesigner(item : Object) : String {
            var text : String = item.first_name + " " + item.last_name;
            return text;
        }

        public function onLabelFunction_comboBoxTypes(item : Object) : String {
            var text : String = item.title;
            return text;
        }

        public function onLabelFunction_comboBoxPublication(item : Object) : String {
            var text : String = item.title;
            return text;
        }

        public function onQuerySelectAllFromDesigner() : void {
            try {
                this.comboboxDesignerData = querySelectAllFromDesigner.data;
            } catch (e : *) {
                trace("onQuerySelectAllFromDesigner error: " + e);
            }
        }

        public function onQuerySelectAllFromAircraftType() : void {
            try {
                this.comboBoxTypeData = querySelectAllFromAircraftType.data;
            } catch (e : *) {
                trace("onQuerySelectAllFromAircraftType error: " + e);
            }
        }

        public function onQuerySelectAllFromPublication() : void {
            try {
                this.comboBoxPublicationData = querySelectAllFromPublication.data;
            } catch (e : *) {
                trace("onQuerySelectAllFromPublication error: " + e);
            }
        }

        public function onQuerySelectAllFromPlanKey() : void {
            try {
                this.comboBoxPlanKeyData = querySelectAllFromPlanKey.data;
            } catch (e : *) {
                trace("onQuerySelectAllFromPlanKey error: " + e);
            }
        }


    /*public function onClick_btnAdd(event : MouseEvent) : void {
       var facade : DatabaseFacade = DatabaseFacade.getInstance();
       var aircraft : Aircraft = new Aircraft();
       aircraft.designerId = this.comboBoxDesigner.selectedItem.id;
       aircraft.name = this.txtName.text;
       aircraft.publicationId = this.comboBoxPublication.selectedItem.id;
       aircraft.typeId = this.comboBoxType.selectedItem.id;
       aircraft.wingSpan = new Number(this.txtWingspan.text);
       aircraft.year = this.txtYear.text;
       aircraft.image = this.imagePicker.imageAsByteArray;
       facade.add(aircraft);
     }*/
    }
}