-- chunkname: @modules/logic/roomfishing/model/FishingFriendListModel.lua

module("modules.logic.roomfishing.model.FishingFriendListModel", package.seeall)

local FishingFriendListModel = class("FishingFriendListModel", ListScrollModel)

function FishingFriendListModel:onInit()
	self:clear()
	self:clearData()
end

function FishingFriendListModel:reInit()
	self:clearData()
end

function FishingFriendListModel:clearData()
	self._selectedTab = nil
	self.unFishingFriendList = {}
end

function FishingFriendListModel:updateFriendListInfo(notFishingFriendInfo)
	self.unFishingFriendList = {}

	if notFishingFriendInfo then
		self.unFishingFriendList = GameUtil.rpcInfosToList(notFishingFriendInfo, FishingFriendInfoMO)
	end

	self:setFriendList()
end

function FishingFriendListModel:onSelectFriendTab(selectedTab)
	if self._selectedTab == selectedTab then
		return
	end

	self._selectedTab = selectedTab

	self:setFriendList()
end

local function _sortFriend(aFriendInfo, bFriendInfo)
	if not aFriendInfo.userId then
		local aUserId = 0

		if not bFriendInfo.userId then
			local bUserId = 0
			local curPoolUserId = FishingModel.instance:getCurShowingUserId()
			local isVisitA = aUserId == curPoolUserId
			local isVisitB = bUserId == curPoolUserId

			if isVisitA ~= isVisitB then
				return isVisitA
			end

			local aProgress = FishingModel.instance:getMyFishingProgress(aUserId)
			local bProgress = FishingModel.instance:getMyFishingProgress(bUserId)

			if aProgress ~= bProgress then
				return bProgress < aProgress
			end

			return aUserId < bUserId
		end
	end
end

function FishingFriendListModel:setFriendList()
	self:clear()

	local list = {}

	if self._selectedTab == FishingEnum.FriendListTag.UnFishing then
		list = self.unFishingFriendList
	elseif self._selectedTab == FishingEnum.FriendListTag.Fishing then
		list = FishingModel.instance:getMyFishingFriendList()
	end

	table.sort(list, _sortFriend)
	self:setList(list)
end

function FishingFriendListModel:getSelectedTab()
	return self._selectedTab
end

FishingFriendListModel.instance = FishingFriendListModel.New()

return FishingFriendListModel
