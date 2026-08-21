-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/controller/multiple_drop/MultipleDropController.lua

module("logic.extensions.welfare.controller.multiple_drop.MultipleDropController", package.seeall)

local M = class("MultipleDropController", BaseController)

function M:onInit()
	self:_setEvent(true)
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._everyDayFive, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_IMPORTANT_INSTANT_PUSH, self._everyDayFive, self)
	end
end

function M:_everyDayFive()
	ActivityAgent.instance:sendGetActivityInfoRequest()
end

function M:getShowList()
	return MultipleDropModel.instance:getShowList()
end

function M:getLeftNumberByTypeAndReward(type, rewradList)
	return MultipleDropModel.instance:getLeftNumberByTypeAndReward(type, rewradList)
end

function M:getLeftNumberByType(type)
	return MultipleDropModel.instance:getLeftNumberByType(type)
end

function M:getAnDinIsOpen()
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		for j, h in pairs(CommEnum.AnDingType) do
			if tonumber(v) == h then
				return true
			end
		end
	end

	return false
end

function M:getDungeonOpenByType(type)
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == type then
			return true
		end
	end

	return false
end

function M:equipIsOpen()
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == CommEnum.DungeonType.EquipExplore then
			return true
		end
	end

	return false
end

function M:mainLineIsOpen()
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == CommEnum.DungeonType.Mainline then
			return true
		end
	end

	return false
end

function M:prisonIsOpen()
	local redPointMultiple = RedDotModel.instance:getRedDotDetailList(GameEnum.RedPointEnum.DungeonRewardUp) or {}

	for k, v in ipairs(redPointMultiple) do
		if tonumber(v) == CommEnum.DungeonType.ControlAction then
			return true
		end
	end

	return false
end

function M:setMultipleDropController(msg)
	MultipleDropModel.instance:setMultipleDropController(msg)
end

function M:getTimesBy()
	return
end

M.instance = M.New()

return M
