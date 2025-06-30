-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/buttoneffect/5.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Future = require("logic.scene.luaevent.effect.future")
return function(sceneobject)
  -- function num : 0_0 , upvalues : _ENV
  local switch = (SwitchManager.GetSwitchByObject)(sceneobject:GetObj())
  if switch then
    local req = (LuaNetManager.CreateProtocol)("protocol.battle.cexploreoption")
    req.id = switch:GetID()
    req.instanceid = switch:GetInstanceID()
    req:Send()
    ;
    (DialogManager.CreateSingletonDialog)("login.eventreconnectdialog")
    local future = switch:ToNextState()
    future:Then(function()
    -- function num : 0_0_0 , upvalues : _ENV, switch
    (LuaNotificationCenter.PostNotification)(Common.n_SwitchEffectEnd, switch, nil)
  end
)
    future:Run()
    return future
  else
    do
      print("no such switch", sceneobject)
    end
  end
end


