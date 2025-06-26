-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/interaction/buttoneffect/24.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Future = require("logic.scene.luaevent.effect.future")
return function(sceneobject)
  -- function num : 0_0 , upvalues : _ENV
  local switch = (SwitchManager.GetSwitchByObject)(sceneobject:GetObj())
  if switch then
    (switch:ToState(1)):Run()
  else
    print("no such switch", sceneobject)
  end
end


