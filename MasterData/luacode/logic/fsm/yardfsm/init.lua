local State = {}

function State.OnEnter(controller, lastState)
  LogInfo("YardFSM", "Init Enter")
  if lastState ~= "" then
    controller:SetRootGameObjectActive(true)
    controller:EnterYard()
    local value = controller._yardFSM:GetParameter("cameraAnimatorState")
    if value ~= 0 then
      controller._yardFSM:SetNumber("cameraAnimatorState", 0)
      controller:SetCameraAnimatorState(value)
    end
  end
end

function State.Update()
end

function State.OnExit(controller, nextState)
  LogInfo("YardFSM", "Init Exit")
  controller:SetRootGameObjectActive(false)
  while controller._lightEffectGameObjects[#controller._lightEffectGameObjects] do
    CS.PixelNeko.Common.GameObjectHelper.DestroyObject(controller._lightEffectGameObjects[#controller._lightEffectGameObjects])
    table.remove(controller._lightEffectGameObjects, #controller._lightEffectGameObjects)
  end
end

return State
