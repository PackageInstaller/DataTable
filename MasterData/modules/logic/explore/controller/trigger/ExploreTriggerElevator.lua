-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerElevator.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerElevator", package.seeall)

local ExploreTriggerElevator = class("ExploreTriggerElevator", ExploreTriggerBase)

function ExploreTriggerElevator:handle(param, unit)
	local arr = string.splitToNumber(param, "#")
	local id = arr[1]

	if id ~= 0 then
		local tmpUnit = ExploreMapTriggerController.instance:getMap():getUnit(id)

		tmpUnit:movingElevator(arr[2], arr[3])
	end

	self:onStepDone(true)
end

function ExploreTriggerElevator:clearWork()
	return
end

return ExploreTriggerElevator
