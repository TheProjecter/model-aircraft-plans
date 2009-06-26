package net.moocowstudio.modelaircraftplanlibrary.controller {
    import flash.events.Event;
    import flash.events.SQLEvent;

    import net.moocowstudio.modelaircraftplanlibrary.database.sqlite.Query;
    import net.moocowstudio.modelaircraftplanlibrary.database.sqlite.SQLite;
    import net.moocowstudio.modelaircraftplanlibrary.database.vo.PlanVO;
    import net.moocowstudio.modelaircraftplanlibrary.domain.Plan;
    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanDesigner;
    import net.moocowstudio.modelaircraftplanlibrary.domain.PlanType;
    import net.moocowstudio.modelaircraftplanlibrary.domain.Publication;
    import net.moocowstudio.modelaircraftplanlibrary.events.DatabaseEvent;
    import net.moocowstudio.modelaircraftplanlibrary.events.PlanEvent;
    import net.moocowstudio.modelaircraftplanlibrary.modellocator.ModelLocator;

    public class Controller {
        /* Properties */
        private static var _instance : Controller = null;

        private var sqlLite : SQLite = new SQLite();
        private var query : Query = new Query();
        private var queryLoadPlanTypes : Query = new Query();
        private var queryLoadDesigners : Query = new Query();
        private var queryLoadPublications : Query = new Query();

        private var objectForSaving : Object;
        private var objectTypeForSaving : String;
        private var objectForSavingOriginator : Object;

        private var objectTypeForLoading : String;

        private var modelLocator : ModelLocator = ModelLocator.getInstance();

        public function Controller() {
            trace("Loading the database file.");
            sqlLite.file = "library.db";
        }

        public static function getInstance() : Controller {
            if (_instance == null) {
                _instance = new Controller();
            }
            return _instance;
        }

        /* Event Handlers */
        public function onSave(event : PlanEvent) : void {
            trace("Event recieved: " + event.type);
            this.objectForSaving = event.data;
            this.objectTypeForSaving = event.type;
            this.objectForSavingOriginator = event.originator;
            switch (event.type) {
                case PlanEvent.onSavePlanType:
                    var planType : PlanType = event.data as PlanType;
                    query.sql = "INSERT INTO plan_types(plan_type_description) VALUES(:PLAN_TYPE_DESCRIPTION)"
                    query.parameters = [planType.plan_type_description];
                    query.connection = sqlLite.connection;
                    query.addEventListener(SQLEvent.RESULT, didSaveToDatabase);
                    query.execute();
                    break;
                case PlanEvent.onSavePublication:
                    var object : Publication = event.data as Publication;
                    query.sql = "INSERT INTO publications(publication_name) VALUES(:PUBLICATION_NAME)"
                    query.parameters = [object.name];
                    query.connection = sqlLite.connection;
                    query.addEventListener(SQLEvent.RESULT, didSaveToDatabase);
                    query.execute();
                    break;
                case PlanEvent.onSaveDesigner:
                    var plandDesigner : PlanDesigner = event.data as PlanDesigner;
                    query.sql = "INSERT INTO designers(designer_first_name, designer_last_name) VALUES(:DESIGNER_FIRST_NAME, :DESIGNER_LAST_NAME)"
                    query.parameters = [plandDesigner.designer_first_name,
                        plandDesigner.designer_last_name];
                    query.connection = sqlLite.connection;
                    query.addEventListener(SQLEvent.RESULT, didSaveToDatabase);
                    query.execute();
                    break;
                case PlanEvent.onSavePlan:
                    var plan : PlanVO = event.data as PlanVO;
                    query.sql = "INSERT INTO plans(plan_comments, plan_designer_id," +
                        " plan_publication_id, plan_name, plan_wingspan," +
                        " plan_year, plan_type_id) VALUES(:PLAN_COMMENTS," +
                        " :PLAN_DESIGNER_ID, :PLAN_PUBLICATION_ID, :PLAN_NAME," +
                        " :PLAN_WINGSPAN, :PLAN_YEAR, :PLAN_TYPE_ID)"
                    query.parameters = [plan.plan_comments,
                        plan.plan_designer_id,
                        plan.plan_publication_id,
                        plan.plan_name,
                        plan.plan_wingspan,
                        plan.plan_year,
                        plan.plan_type_id];
                    query.connection = sqlLite.connection;
                    query.addEventListener(SQLEvent.RESULT, didSaveToDatabase);
                    query.execute();
                    break;
            }
        }

        public function didSaveToDatabase(event : Event) : void {
            var dbEvent : DatabaseEvent = new DatabaseEvent(DatabaseEvent.didSaveToDatabase);
            this.objectForSavingOriginator.dispatchEvent(dbEvent);
        }

    }
}