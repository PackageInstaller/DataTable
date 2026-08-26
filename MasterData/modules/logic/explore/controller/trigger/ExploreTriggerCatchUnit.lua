-- chunkname: @modules/logic/explore/controller/trigger/ExploreTriggerCatchUnit.lua

module("modules.logic.explore.controller.trigger.ExploreTriggerCatchUnit", package.seeall)

local ExploreTriggerCatchUnit = class("ExploreTriggerCatchUnit", ExploreTriggerBase)
local catchParams = ExploreEnum.TriggerEvent.CatchUnit .. "#1"
local cancelParams = ExploreEnum.TriggerEvent.CatchUnit .. "#0"

function ExploreTriggerCatchUnit:handle(id, unit)
	if ExploreModel.instance:hasUseItemOrUnit() then
		self:onDone(false)
		logError("catchUnit fail inusing id:" .. ExploreModel.instance:getUseItemUid())

		return
	end

	self:sendTriggerRequest(catchParams)
end

function ExploreTriggerCatchUnit:cancel(id, unit)
	local map = ExploreController.instance:getMap()
	local hero = map:getHero()
	local dirXY = ExploreHelper.dirToXY(hero.dir)
	local nodePos = hero.nodePos
	local params = cancelParams .. "#" .. nodePos.x + dirXY.x .. "#" .. nodePos.y + dirXY.y

	self:sendTriggerRequest(params)
end

function ExploreTriggerCatchUnit:onReply(cmd, resultCode, msg)
	if resultCode == 0 then
		local arr = string.splitToNumber(msg.params, "#")

		ExploreModel.instance:setUseItemUid((arr[2] == 1 or nil) and self.unitId)
		self:onStepDone(true)
	else
		self:onDone(false)
	end
end

return ExploreTriggerCatchUnit
