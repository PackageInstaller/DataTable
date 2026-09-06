local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local SceneDestroyTriggerController = class("SceneDestroyTriggerController", TriggerControllerBase)
local SceneDestroyTrigger = require("logic.scene.luaevent.trigger.basic.scenedestroy.scenedestroytrigger")

function SceneDestroyTriggerController:Ctor(...)
  SceneDestroyTriggerController.super.Ctor(self, ...)
end

function SceneDestroyTriggerController:CreateTriggerInstance(id, eventid, sceneId)
  return SceneDestroyTrigger.Create("scenedestroy", id, eventid, sceneId)
end

function SceneDestroyTriggerController:OnSceneDestroy(sceneId)
  for _, trigger in ipairs(self._triggers) do
    trigger:Check(sceneId)
  end
end

return SceneDestroyTriggerController
