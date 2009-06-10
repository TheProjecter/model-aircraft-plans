package net.moocowstudio.modelaircraft.database {
    import mx.collections.ArrayCollection;

    import net.moocowstudio.modelaircraft.Aircraft;
    import net.moocowstudio.modelaircraft.model.AircraftType;
    import net.moocowstudio.modelaircraft.model.Designer;
    import net.moocowstudio.modelaircraft.model.Publication;

    public class DatabaseFacade {
        private var database : Database = new Database();
        private static var _instance : DatabaseFacade = null;

        public static function getInstance() : DatabaseFacade {
            if (_instance == null) {
                _instance = new DatabaseFacade();
            }
            return _instance;
        }

        public function add(aircraft : Aircraft) : void {
            this.database.addAircraft(
                aircraft.name,
                aircraft.wingSpan,
                aircraft.year,
                aircraft.publicationId,
                aircraft.designerId,
                aircraft.typeId,
                aircraft.image);
        }

        public function getAircraftForKey(key : int) : Aircraft {
            return new Aircraft();
        }

        public function save(aircraft : Aircraft) : void {

        }

        public function removeAircraft(forAircraft : Aircraft) : void {

        }

        public function addDesginer(designer : Designer) : void {
            this.database.addDesigner(
                designer.firstName,
                designer.lastName);
        }

        public function addAircraftType(type : AircraftType) : void {
            this.database.addType(
                type.title);
        }

        public function addPublication(publication : Publication) : void {
            this.database.addPublication(
                publication.title);
        }

        public function getAllDesigners() : ArrayCollection {
            var databaseResults = this.database.getAllDesigners();
            return databaseResults;
        }

        public function getAllAircraftTypes() : ArrayCollection {
            var databaseResults = this.database.getAllAircraftTypes();
            return databaseResults;
        }

        public function getAllPublications() : ArrayCollection {
            var databaseResults = this.database.getAllPublications();
            return databaseResults;
        }

        public function valuesForKey(keyName : String, keyValue : int, onTable : String) : Object {
            var result : Array = this.database.valuesForKey(keyName, keyValue, onTable);

            var object : Object;
            try {
                if (result.length > 0) {
                    var object : Object = result[0];
                }
            } catch (e : *) {
                trace(e);
            }
            return object;
        }

        public function getAllAircraft() : Array {
            var results : Array = this.database.getAllAircraft();
            for each (var aircraft : Aircraft in results) {
                try {
                    var object : Object = this.valuesForKey(
                        "publication_id",
                        aircraft.publicationId,
                        "publication");
                    var title : String = object.title;
                    aircraft.publication = title;

                    object = this.valuesForKey(
                        "designer_id",
                        aircraft.designerId,
                        "designer");
                    var designer : String = object.first_name + " " + object.last_name;
                    aircraft.designer = designer;

                    object = this.valuesForKey(
                        "type_id",
                        aircraft.typeId,
                        "type");
                    var aircraftType : String = object.title;
                    aircraft.type = aircraftType;
                } catch (e : *) {
                    trace(e);
                }
            }
            return results;
        }
    }
}