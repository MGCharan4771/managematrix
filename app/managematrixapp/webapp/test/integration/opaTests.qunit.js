sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'managematrixapp/test/integration/FirstJourney',
		'managematrixapp/test/integration/pages/CommMatrixListList',
		'managematrixapp/test/integration/pages/CommMatrixListObjectPage'
    ],
    function(JourneyRunner, opaJourney, CommMatrixListList, CommMatrixListObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('managematrixapp') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCommMatrixListList: CommMatrixListList,
					onTheCommMatrixListObjectPage: CommMatrixListObjectPage
                }
            },
            opaJourney.run
        );
    }
);