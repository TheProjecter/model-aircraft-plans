package net.moocowstudio.modelaircraft.view.codebehind {
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.containers.Canvas;
    import mx.controls.ComboBox;
    import mx.controls.TextInput;

    import net.moocowstudio.modelaircraft.Aircraft;
    import net.moocowstudio.modelaircraft.database.DatabaseFacade;
    import net.moocowstudio.modelaircraft.model.AircraftType;
    import net.moocowstudio.modelaircraft.model.Designer;
    import net.moocowstudio.modelaircraft.model.Publication;
    import net.moocowstudio.modelaircraft.view.ImagePicker;

    public class AddAircraftBase extends Canvas {
        /* Properties */
        [Bindable] public var comboboxDesignerData : ArrayCollection = new ArrayCollection();
        [Bindable] public var comboBoxTypeData : ArrayCollection = new ArrayCollection();
        [Bindable] public var comboBoxPublicationData : ArrayCollection = new ArrayCollection();

        /* Components */
        public var comboBoxDesigner : ComboBox;
        public var comboBoxType : ComboBox;
        public var comboBoxPublication : ComboBox;
        public var txtYear : TextInput;
        public var txtWingspan : TextInput;
        public var txtName : TextInput;
        public var imagePicker : ImagePicker;

        public function AddAircraftBase() {
            super();
        }

        /* Functions */
        public function loadDataProviders() : void {
            var database : DatabaseFacade = new DatabaseFacade();
            this.comboboxDesignerData = database.getAllDesigners();
            this.comboBoxTypeData = database.getAllAircraftTypes();
            this.comboBoxPublicationData = database.getAllPublications();
        }

        /* Event Handlers */
        public function onCreationComplete(event : Event) : void {
            this.loadDataProviders();
        }

        public function onLabelFunction_comboBoxDesigner(item : Designer) : String {
            var text : String = item.firstName + " " + item.lastName;
            return text;
        }

        public function onLabelFunction_comboBoxTypes(item : AircraftType) : String {
            var text : String = item.title;
            return text;
        }

        public function onLabelFunction_comboBoxPublication(item : Publication) : String {
            var text : String = item.title;
            return text;
        }

        public function onClick_btnAdd(event : MouseEvent) : void {
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
        }
    }
}