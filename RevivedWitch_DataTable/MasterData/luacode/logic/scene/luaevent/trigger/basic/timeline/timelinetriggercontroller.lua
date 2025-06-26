-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/trigger/basic/timeline/timelinetriggercontroller.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TriggerControllerBase = require("logic.scene.luaevent.trigger.triggercontrollerbase")
local TimelineTriggerController = class("TimelineTriggerController", TriggerControllerBase)
local TimelineTrigger = require("logic.scene.luaevent.trigger.basic.timeline.timelinetrigger")
TimelineTriggerController.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TimelineTriggerController
  ((TimelineTriggerController.super).Ctor)(self, ...)
end

TimelineTriggerController.CreateTriggerInstance = function(self, id, eventid, director)
  -- function num : 0_1 , upvalues : TimelineTrigger
  return (TimelineTrigger.Create)("timeline", id, eventid, director)
end

TimelineTriggerController.OnTimelineEnd = function(self, director)
  -- function num : 0_2
  self:CheckImpl(nil, director)
end

return TimelineTriggerController

