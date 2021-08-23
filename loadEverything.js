var mirador = Mirador.viewer({
  "id": "my-mirador",
  "manifests": {
    "https://purl.stanford.edu/td069xt8810/iiif/manifest": {
      "provider": "Stanford University"
    }
  },
  "window": {
    allowClose: false,
    allowWindowSideBar: true,
    allowTopMenuButton: false,
    allowMaximize: false,
    hideWindowTitle: true,
    panels: { // Configure which panels are visible in WindowSideBarButtons
        info: false,
        attribution: false,
        canvas: true,
        annotations: false,
        search: false,
        layers: false,
      }
  },
  workspaceControlPanel: {
    enabled: false, // Configure if the control panel should be rendered.  Useful if you want to lock the viewer down to only the configured manifests
  },
  "windows": [
    {
      "loadedManifest": "https://purl.stanford.edu/td069xt8810/iiif/manifest",
      "canvasIndex": 1,
      "thumbnailNavigationPosition": 'off'
    }
  ]
});

$(function(){
    function documentLoader(){
            $.when($.get("golshiri.xml"), $.get("transform-app.xsl"))
            .done(function(xml_doc, xsl_doc) {
                var xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xsl_doc[0]);
                resultDocument = xsltProcessor.transformToFragment(xml_doc[0], document);
                $("#critical").html(resultDocument);
            });
    }

    $(documentLoader());
    $(function () {
      $('[data-toggle="popover"]').popover()
    })

    function documentChanger(layer){
            $.when($.get("golshiri.xml"), $.get("change-layers.xsl"))
            .done(function(xml_doc, xsl_doc) {
                var xsltProcessor = new XSLTProcessor();
                xsltProcessor.importStylesheet(xsl_doc[0]);
                xsltProcessor.setParameter(null, "layer", layer);
                resultDocument = xsltProcessor.transformToFragment(xml_doc[0], document);
                $("#critical").html(resultDocument);
            });
    }


    $('#sel1').on('change', function() {
      if (this.value == 'final-state') {
        $(documentLoader());
        $(function () {
          $('[data-toggle="popover"]').popover()
        })
      }
      else {
        $(documentChanger(this.value));
      }
    });
});
