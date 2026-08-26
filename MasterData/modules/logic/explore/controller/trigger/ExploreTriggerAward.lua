-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerAward.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerAward", package.seeall)

local ExploreTriggerAward = class("ExploreTriggerAward", ExploreTriggerBase)

function ExploreTriggerAward:handle(param, unit)
	local id = tonumber(param) or 0

	ExploreSimpleModel.instance:setBonusIsGet(ExploreModel.instance:getMapId(), id)
	self:onDone(true)
end

return ExploreTriggerAward
