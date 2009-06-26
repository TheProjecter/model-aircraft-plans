package net.moocowstudio.modelaircraftplanlibrary.modellocator {

    /* < < S I N G L E T O N > > */
    public class ModelLocator {
        /* Properties */
        private static var _instance : ModelLocator = null;
        private var dpm : DataProviderManager = new DataProviderManager();

        /* Functions */
        public function ModelLocator() : void {
            this.dpDesigners;
            this.dpPlans;
            this.dpPlanTypes;
            this.dpPublications;
        }

        public static function getInstance() : ModelLocator {
            if (_instance == null) {
                _instance = new ModelLocator();
            }
            return _instance;
        }



        [Bindable] public function get dpPlanTypes() : Array {
            return this.dpm.getDataProviderValueForKey("dpPlanTypes", "SELECT * FROM plan_types");
        }

        [Bindable] public function get dpDesigners() : Array {
            return this.dpm.getDataProviderValueForKey("dpDesigners", "SELECT * FROM designers");
        }

        [Bindable] public function get dpPublications() : Array {
            return this.dpm.getDataProviderValueForKey("dpPublications", "SELECT * FROM publications");
        }

        [Bindable] public function get dpPlans() : Array {
            return this.dpm.getDataProviderValueForKey("dpPlans",
                "SELECT " +
                "    p.plan_id," +
                "    p.plan_type_id," +
                "    p.plan_name," +
                "    p.plan_designer_id," +
                "    p.plan_year," +
                "    p.plan_wingspan," +
                "    p.plan_comments," +
                "    pt.plan_type_description," +
                "    d.designer_first_name," +
                "    d.designer_last_name," +
                "    pub.publication_name " +
                "FROM" +
                "    plans p," +
                "    plan_types pt," +
                "    designers d," +
                "    publications pub " +
                "WHERE p.plan_type_id = pt.plan_type_id " +
                "AND p.plan_designer_id = d.designer_id " +
                "AND p.plan_publication_id = pub.publication_id");
        }
    }
}