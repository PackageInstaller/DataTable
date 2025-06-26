-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/yardfsm/init.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV
  LogInfo("YardFSM", "Init Enter")
  if lastState ~= "" then
    controller:SetRootGameObjectActive(true)
    controller:EnterYard()
    local value = (controller._yardFSM):GetParameter("cameraAnimatorState")
    if value ~= 0 then
      (controller._yardFSM):SetNumber("cameraAnimatorState", 0)
      controller:SetCameraAnimatorState(value)
    end
  end
end

State.Update = function()
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV
  LogInfo("YardFSM", "Init Exit")
  controller:SetRootGameObjectActive(false)
  while (controller._lightEffectGameObjects)[#controller._lightEffectGameObjects] do
    ((((CS.PixelNeko).Common).GameObjectHelper).DestroyObject)((controller._lightEffectGameObjects)[#controller._lightEffectGameObjects])
    ;
    (table.remove)(controller._lightEffectGameObjects, #controller._lightEffectGameObjects)
  end
end

return State

