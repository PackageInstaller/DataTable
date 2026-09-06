local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local SceneDestroyTrigger = class("SceneDestroyTrigger", TriggerBase)

function SceneDestroyTrigger:Ctor(triggertype, id, eventid, sceneID)
  SceneDestroyTrigger.super.Ctor(self, triggertype, id, eventid)
  self._sceneId = sceneID
end

function SceneDestroyTrigger:OnCheck(destroySceneId)
  return false
end

return SceneDestroyTrigger
