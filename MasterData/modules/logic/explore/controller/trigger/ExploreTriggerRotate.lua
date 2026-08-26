-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerRotate.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerRotate", package.seeall)

local ExploreTriggerRotate = class("ExploreTriggerRotate", ExploreTriggerBase)

function ExploreTriggerRotate:handle(dir, unit)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetRotateUnit, unit)
	self:onDone(false)
end

return ExploreTriggerRotate
