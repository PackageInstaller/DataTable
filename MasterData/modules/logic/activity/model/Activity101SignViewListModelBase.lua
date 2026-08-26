-- chunkname: @modules/logic/activity/model/Activity101SignViewListModelBase.lua

module("modules.logic.activity.model.Activity101SignViewListModelBase", package.seeall)

local Activity101SignViewListModelBase = class("Activity101SignViewListModelBase", ListScrollModel)

function Activity101SignViewListModelBase:getViewportItemCount()
	return 7.2
end

function Activity101SignViewListModelBase:setList(dataList)
	local oldDataList = self:getList()

	for i, oldMo in ipairs(oldDataList) do
		local newMo = dataList[i]

		if newMo then
			newMo.__isPlayedOpenAnim = oldMo.__isPlayedOpenAnim
		end
	end

	Activity101SignViewListModelBase.super.setList(self, dataList)
end

function Activity101SignViewListModelBase:setDefaultPinStartIndex(dataList, awardIndex)
	awardIndex = awardIndex or 1

	if not dataList or #dataList == 0 then
		self:setStartPinIndex(1)

		return
	end

	local maxItemCount = #dataList
	local inActiveItemCount = math.max(1, math.ceil(maxItemCount - self:getViewportItemCount()))

	self:setStartPinIndex(inActiveItemCount < awardIndex and inActiveItemCount or 1)
end

function Activity101SignViewListModelBase:setStartPinIndex(index)
	self._startPinIndex = index
end

function Activity101SignViewListModelBase:getStartPinIndex()
	return self._startPinIndex or 1
end

return Activity101SignViewListModelBase
