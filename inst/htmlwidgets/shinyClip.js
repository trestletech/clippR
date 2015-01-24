HTMLWidgets.widget({
  name: 'shinyClip',
  type: 'output',
  initialize: function(el, width, height) {
    var ShinyClip = function(){
      var actionStack = [];
      var agent = null;
      var initializing = false;

      return {
        do: function(act){
          if (!agent){
            actionStack.push(act);
          } else {
            act(agent);
          }
        },
        init: function(agt){
          initializing = false;
          agent = agt;

          $(el).data('shinyClip-agent', agent);

          while (actionStack.length > 0){
            var a = actionStack.shift();
            a(agent);
          }
        },
        startInit: function(){
          initializing = true;
        },
        hasStartedInit: function(){
          return initializing || agent !== null;
        }
      }
    }();

    return ShinyClip;
  },

  renderValue: function(el, x, instance) {
    var $el = $(el);

    // Init, if needed
    if (!instance.hasStartedInit()){
      clippy.load(x.agent, function(agent){
        instance.init(agent);
      });

      instance.do(function(agt){
        agt.show();
      });
    }

    instance.do(function(agt){
    });
  },

  resize: function(el, width, height, instance) {
    console.log("Resize");
  }
})


Shiny.addCustomMessageHandler('shinyClip', function(data) {
  var agt = $('#'+data.id).data('shinyClip-agent');

  if (!agt){
    // Agent not ready yet.
    return
  }

  agt.stop();

  if (data.speak){
    agt.speak(data.speak);
  }

  if (data.moveTo){
    agt.moveTo.apply(agt, data.moveTo);
  }
});
