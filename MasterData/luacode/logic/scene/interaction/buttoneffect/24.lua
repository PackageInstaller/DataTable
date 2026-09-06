local Future = require("logic.scene.luaevent.effect.future")
return function(sceneobject)
  local switch = SwitchManager.GetSwitchByObject(sceneobject:GetObj())
  if switch then
    switch:ToState(1):Run()
  else
    print("no such switch", sceneobject)
  end
end
