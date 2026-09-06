local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TimelineTrigger = class("TimelineTrigger", TriggerBase)

function TimelineTrigger:Ctor(type, id, eventid, directorNum)
  TimelineTrigger.super.Ctor(self, type, id, eventid, directorNum)
  if _G.type(directorNum) == "number" then
    self._director = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeon)._sceneRef.timelineObjects[directorNum]
    assert(self._director, "timeline " .. directorNum .. " not found")
  else
    self._director = directorNum
  end
end

function TimelineTrigger:OnCheck(director)
  if self._director == director then
    return true
  else
    return false
  end
  return false
end

return TimelineTrigger
