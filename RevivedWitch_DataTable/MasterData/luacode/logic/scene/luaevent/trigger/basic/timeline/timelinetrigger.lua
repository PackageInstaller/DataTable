-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/timeline/timelinetrigger.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerBase = require("logic.scene.luaevent.trigger.triggerbase")
local TimelineTrigger = class("TimelineTrigger", TriggerBase)
TimelineTrigger.Ctor = function(self, type, id, eventid, directorNum)
  -- function num : 0_0 , upvalues : TimelineTrigger, _ENV
  ((TimelineTrigger.super).Ctor)(self, type, id, eventid, directorNum)
  if (_G.type)(directorNum) == "number" then
    self._director = ((((SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeon))._sceneRef).timelineObjects)[directorNum]
    assert(self._director, "timeline " .. directorNum .. " not found")
  else
    self._director = directorNum
  end
end

TimelineTrigger.OnCheck = function(self, director)
  -- function num : 0_1
  if self._director == director then
    return true
  else
    return false
  end
  return false
end

return TimelineTrigger

