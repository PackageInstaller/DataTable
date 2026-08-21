-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/welfare/model/weekend_supply/WeekendSupplyItemMo.lua

module("logic.extensions.welfare.model.weekend_supply.WeekendSupplyItemMo", package.seeall)

local M = class("WeekendSupplyItemMo")

function M:ctor()
	self._id = nil
	self._status = nil
	self._cfgId = nil
	self._rewardDataList = {}
end

function M:setGifgItemMo(moTable)
	if moTable ~= nil then
		self._id = moTable.id
		self._cfgId = moTable.cfgId
		self._status = moTable.status
		self._time = moTable.time
	end
end

function M:setRwardStatus(num)
	self._status = num
end

function M:getRewardStatus()
	return self._status
end

function M:getCfgID()
	return self._cfgId
end

function M:getId()
	return self._id
end

function M:getRewardItemDataList()
	if #self._rewardDataList == 0 then
		if self._id == ActivityExtension_pb.Day.SATURDAY then
			local rewardInfo = WeekendSupplyConfig.instance:getSaturDayRewardInfo(self._cfgId)

			self._rewardDataList = self:_getRewardList(rewardInfo)
		elseif self._id == ActivityExtension_pb.Day.SUNDAY then
			local rewardInfo = WeekendSupplyConfig.instance:getSunDayRewardInfo(self._cfgId)

			self._rewardDataList = self:_getRewardList(rewardInfo)
		elseif self._id == ActivityExtension_pb.Day.MONDAY then
			local rewardInfo = WeekendSupplyConfig.instance:getMonDayRewardInfo(self._cfgId)

			self._rewardDataList = self:_getRewardList(rewardInfo)
		elseif self._id == ActivityExtension_pb.Day.EXTRA then
			local rewardInfo = WeekendSupplyConfig.instance:getExtraRewardInfo(self._cfgId)
			local itemID1 = rewardInfo.reward[1].code
			local count1 = rewardInfo.reward[1].num
			local item1 = ItemUtil.createItemData({
				itemId = itemID1
			})

			item1:setCount(count1)

			self._rewardDataList[1] = item1
		end
	end

	return self._rewardDataList
end

function M:_getRewardList(rewardInfo)
	local itemID1 = rewardInfo.reward[1].code
	local itemID2 = rewardInfo.reward[2].code
	local count1 = rewardInfo.reward[1].num
	local count2 = rewardInfo.reward[2].num
	local tempTable = {}
	local item1 = ItemUtil.createItemData({
		itemId = itemID1
	})

	item1:setCount(count1)

	local item2 = ItemUtil.createItemData({
		itemId = itemID2
	})

	item2:setCount(count2)

	tempTable[1] = item1
	tempTable[2] = item2

	return tempTable
end

return M
