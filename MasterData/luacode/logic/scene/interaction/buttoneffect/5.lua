local Future = require("logic.scene.luaevent.effect.future")
return function(sceneobject)
  local switch = SwitchManager.GetSwitchByObject(sceneobject:GetObj())
  if switch then
    local req = LuaNetManager.CreateProtocol("protocol.battle.cexploreoption")
    req.id = switch:GetID()
    req.instanceid = switch:GetInstanceID()
    req:Send()
    DialogManager.CreateSingletonDialog("login.eventreconnectdialog")
    local future = switch:ToNextState()
    future:Then(function()
      LuaNotificationCenter.PostNotification(Common.n_SwitchEffectEnd, switch, nil)
    end)
    future:Run()
    return future
  else
    print("no such switch", sceneobject)
  end
end
