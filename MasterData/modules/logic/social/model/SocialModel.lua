-- chunkname: @modules/logic/social/model/SocialModel.lua

module("modules.logic.social.model.SocialModel", package.seeall)

local SocialModel = class("SocialModel", BaseModel)

function SocialModel:onInit()
	self._friendsMODict = {}
	self._blackListMODict = {}
	self._requestMODict = {}
	self._searchMODict = {}
	self._recommendMODict = {}
	self._friendUserIdDict = {}
	self._blackListUserIdDict = {}
	self._tempMODict = {}
	self._playerSelfMO = nil
	self._selectFriend = nil
	self.playSearchItemAnimDt = 0
	self.leftSendRecommendReqDt = 0
	self._hasGetInfo = false
end

function SocialModel:reInit()
	SocialListModel.instance:reInit()

	self._friendsMODict = {}
	self._blackListMODict = {}
	self._requestMODict = {}
	self._searchMODict = {}
	self._recommendMODict = {}
	self._friendUserIdDict = {}
	self._blackListUserIdDict = {}
	self._tempMODict = {}
	self._playerSelfMO = nil
	self._selectFriend = nil
	self._hasGetInfo = false
end

function SocialModel:checkGetInfo()
	return self._hasGetInfo
end

function SocialModel:getFriendIdDict()
	return self._friendUserIdDict
end

function SocialModel:updateSocialInfosList(friendIds, blackListIds)
	self._friendUserIdDict = {}
	self._blackListUserIdDict = {}

	if friendIds and #friendIds > 0 then
		for i, friendId in ipairs(friendIds) do
			self._friendUserIdDict[friendId] = true
		end
	end

	if blackListIds and #blackListIds > 0 then
		for i, blackListId in ipairs(blackListIds) do
			self._blackListUserIdDict[blackListId] = true
		end
	end

	SocialMessageModel.instance:ensureDeleteSocialMessage()
end

function SocialModel:updateFriendList(friendInfos)
	self._hasGetInfo = true
	self._friendsMODict = {}
	self._friendUserIdDict = {}

	if friendInfos and #friendInfos > 0 then
		for i, friendInfo in ipairs(friendInfos) do
			local playerMO = SocialPlayerMO.New()

			playerMO:init(friendInfo, SocialEnum.Type.Friend)

			self._friendsMODict[playerMO.userId] = playerMO
			self._friendUserIdDict[playerMO.userId] = true

			self:_addTempMO(playerMO)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, self._friendsMODict)
end

function SocialModel:updateBlackList(blackInfos)
	self._blackListMODict = {}
	self._blackListUserIdDict = {}

	if blackInfos and #blackInfos > 0 then
		for i, blackInfo in ipairs(blackInfos) do
			local playerMO = SocialPlayerMO.New()

			playerMO:init(blackInfo, SocialEnum.Type.Black)

			self._blackListMODict[playerMO.userId] = playerMO
			self._blackListUserIdDict[playerMO.userId] = true

			self:_addTempMO(playerMO)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, self._blackListMODict)
end

function SocialModel:updateRequestList(requestInfos)
	self._requestMODict = {}

	if requestInfos and #requestInfos > 0 then
		for i, requestInfo in ipairs(requestInfos) do
			local playerMO = SocialPlayerMO.New()

			playerMO:initWithPlayCard(requestInfo, SocialEnum.Type.Request)

			self._requestMODict[playerMO.userId] = playerMO

			self:_addTempMO(playerMO)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, self._requestMODict)
end

function SocialModel:updateRecommendList(recommendInfos)
	self._recommendMODict = {}

	if recommendInfos and #recommendInfos > 0 then
		for i, requestInfo in ipairs(recommendInfos) do
			local playerMO = SocialPlayerMO.New()

			playerMO:initWithPlayCard(requestInfo, SocialEnum.Type.Recommend)

			self._recommendMODict[playerMO.userId] = playerMO

			self:_addTempMO(playerMO)
		end
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, self._recommendMODict)
end

function SocialModel:updateSearchList(searchInfos)
	self._searchMODict = {}

	if searchInfos and #searchInfos > 0 then
		for i, searchInfo in ipairs(searchInfos) do
			local playerMO = SocialPlayerMO.New()

			playerMO:initWithPlayCard(searchInfo, SocialEnum.Type.Search)

			self._searchMODict[playerMO.userId] = playerMO

			self:_addTempMO(playerMO)
		end
	else
		GameFacade.showToast(ToastEnum.SocialNoSearch)
	end

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, self._searchMODict)
end

function SocialModel:addFriendsByUserIds(userIds)
	local noPlayerMo = false

	if userIds and #userIds > 0 then
		for i, userId in ipairs(userIds) do
			local playerMO = self:getPlayerMO(userId)

			if playerMO and not self._friendsMODict[playerMO.userId] then
				self._friendsMODict[playerMO.userId] = playerMO
			else
				noPlayerMo = true
			end

			self._friendUserIdDict[userId] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, self._friendsMODict)
	end

	return noPlayerMo
end

function SocialModel:addFriendsByUserInfos(userInfos)
	if userInfos and #userInfos > 0 then
		for i, userInfo in ipairs(userInfos) do
			if not self._friendsMODict[userInfo.userId] then
				local playerMO = SocialPlayerMO.New()

				playerMO:init(userInfo, SocialEnum.Type.Friend)

				self._friendsMODict[playerMO.userId] = playerMO

				self:_addTempMO(playerMO)
			else
				local playerMO = self._friendsMODict[userInfo.userId]

				playerMO:init(userInfo)
				self:_addTempMO(playerMO)
			end

			self._friendUserIdDict[userInfo.userId] = true
		end

		SocialListModel.instance:setModelList(SocialEnum.Type.Friend, self._friendsMODict)
	end
end

function SocialModel:removeFriendByUserId(userId)
	SocialMessageModel.instance:deleteSocialMessage(SocialEnum.ChannelType.Friend, userId)

	self._friendsMODict[userId] = nil
	self._friendUserIdDict[userId] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Friend, self._friendsMODict)
end

function SocialModel:addBlackListByUserId(userId)
	local playerMO = self:getPlayerMO(userId)

	if playerMO and not self._blackListMODict[playerMO.userId] then
		self._blackListMODict[playerMO.userId] = playerMO
	end

	self._blackListUserIdDict[userId] = true

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, self._blackListMODict)
end

function SocialModel:removeBlackListByUserId(userId)
	self._blackListMODict[userId] = nil
	self._blackListUserIdDict[userId] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Black, self._blackListMODict)
end

function SocialModel:clearRequestList()
	self._requestMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, self._requestMODict)
end

function SocialModel:removeRequestByUserId(userId)
	self._requestMODict[userId] = nil

	SocialListModel.instance:setModelList(SocialEnum.Type.Request, self._requestMODict)
end

function SocialModel:clearSearchList()
	self._searchMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Search, self._searchMODict)
end

function SocialModel:clearRecommendList()
	self._recommendMODict = {}

	SocialListModel.instance:setModelList(SocialEnum.Type.Recommend, self._recommendMODict)
end

function SocialModel:isMyFriendByUserId(userId)
	return self._friendUserIdDict[userId] or self._friendsMODict[userId]
end

function SocialModel:isMyBlackListByUserId(userId)
	return self._blackListUserIdDict[userId] or self._blackListMODict[userId]
end

function SocialModel:_addTempMO(playerMO)
	if not playerMO then
		return
	end

	self._tempMODict[playerMO.userId] = playerMO
end

function SocialModel:clearSelfPlayerMO()
	self._playerSelfMO = nil
end

function SocialModel:getPlayerMO(userId)
	local myUserId = PlayerModel.instance:getMyUserId()

	if myUserId == userId then
		if not self._playerSelfMO then
			local playerDetailInfo = PlayerModel.instance:getPlayinfo()

			self._playerSelfMO = SocialPlayerMO.New()

			local info = {}

			info.userId = playerDetailInfo.userId
			info.name = playerDetailInfo.name
			info.level = playerDetailInfo.level
			info.portrait = playerDetailInfo.portrait
			info.time = 0
			info.bg = playerDetailInfo.bg

			self._playerSelfMO:init(info)
		end

		return self._playerSelfMO
	end

	return self._friendsMODict[userId] or self._searchMODict[userId] or self._recommendMODict[userId] or self._requestMODict[userId] or self._blackListMODict[userId] or self._tempMODict[userId]
end

function SocialModel:getFriendsCount()
	return tabletool.len(self._friendUserIdDict)
end

function SocialModel:getRequestCount()
	return tabletool.len(self._requestMODict)
end

function SocialModel:getBlackListCount()
	return tabletool.len(self._blackListUserIdDict)
end

function SocialModel:getSearchCount()
	return tabletool.len(self._searchMODict)
end

function SocialModel:getRecommendCount()
	return tabletool.len(self._recommendMODict)
end

function SocialModel:setSelectFriend(userId)
	self._selectFriend = userId

	SocialController.instance:dispatchEvent(SocialEvent.SelectFriend)
end

function SocialModel:getSelectFriend()
	if self:isMyFriendByUserId(self._selectFriend) then
		return self._selectFriend
	else
		return nil
	end
end

function SocialModel:isSelectSocialBg()
	local skinkey = PlayerPrefsKey.SocialFriendsViewSelectOwnSkin .. tostring(PlayerModel.instance:getPlayinfo().userId)

	return PlayerPrefsHelper.getNumber(skinkey, SocialEnum.SelectEnum.Self) == SocialEnum.SelectEnum.Self
end

function SocialModel:setSelectSocialBg(isSelf)
	local skinkey = PlayerPrefsKey.SocialFriendsViewSelectOwnSkin .. tostring(PlayerModel.instance:getPlayinfo().userId)

	PlayerPrefsHelper.setNumber(skinkey, (isSelf or nil) and (SocialEnum.SelectEnum.Self or SocialEnum.SelectEnum.Friend))
end

SocialModel.instance = SocialModel.New()

return SocialModel
