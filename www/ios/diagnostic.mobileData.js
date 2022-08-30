/* globals cordova, require, exports, module */

/**
 *  Diagnostic Mobile Data plugin for iOS
 *
 *  Copyright (c) 2015 Working Edge Ltd.
 *  Copyright (c) 2012 AVANTIC ESTUDIO DE INGENIEROS
 **/
 var Diagnostic_Mobile_Data = (function(){
    /***********************
     *
     * Internal properties
     *
     *********************/
    var Diagnostic_Mobile_Data = {};

    var Diagnostic = require("cordova.plugins.diagnostic.Diagnostic");

    /********************
     *
     * Public properties
     *
     ********************/
    
    /********************
     *
     * Internal functions
     *
     ********************/

    /*****************************
     *
     * Protected member functions
     *
     ****************************/

    /**********************
     *
     * Public API functions
     *
     **********************/

    /**
     * Checks if mobile data is allowed for this app.
     * On iOS this returns true if the per app Mobile Data setting is set to enabled (regardless of whether it's connected to a network).
     *
     * @param {Function} successCallback -  The callback which will be called when the operation is successful.
     * This callback function is passed a single boolean parameter which is TRUE if per app Mobile Data is enabled.
     * @param {Function} errorCallback -  The callback which will be called when the operation encounters an error.
     *  This callback function is passed a single string parameter containing the error message.
     */
     Diagnostic_Mobile_Data.isMobileDataAuthorized = function(successCallback, errorCallback) {
        return cordova.exec(Diagnostic._ensureBoolean(successCallback),
            errorCallback,
            'Diagnostic_Mobile_Data',
            'isMobileDataAuthorized',
            []);
    };

    return Diagnostic_Mobile_Data;
});
module.exports = new Diagnostic_Mobile_Data();