-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/friend/controller/FriendController.lua

module("logic.extensions.friend.controller.FriendController", package.seeall)

local FriendController = class("FriendController", BaseController)

FriendController.KeyTopFriendIds = "FriendController.KeyTopFriendIds_1"

function FriendController:ctor()
	FriendController.super.ctor(self)

	self._selectedId = nil
end

function FriendController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.FriendRemove, self._OnFriendRemove, self)
	GlobalDispatcher:addListener(GlobalNotify.StrangerRemove, self._OnStrangerRemove, self)
	GlobalDispatcher:addListener(GlobalNotify.BlackListRemove, self._OnBlacklistRemove, self)
	self:addListenerAboutAllRelationshipChange()

	self._selectedGroup = GameEnum.FriendGroup.Friend
	self._applyedIds = {}

	self:onReset()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyRefresh, self)
end

function FriendController:_dailyRefresh()
	if ViewMgr.instance:isOpen(ViewName.Friend) then
		self:LoadFriends()
	else
		self._needReloadFriend = true
	end
end

function FriendController:isNeedReloadFriendData()
	if self._needReloadFriend then
		self._needReloadFriend = false

		return true
	end

	return false
end

function FriendController:onReset()
	self._sortValues = {}
	self._needReloadFriend = false
	self.selectIdx = nil
	self._lastRefreshTime = nil
	self._topFriendIdList = nil
	self._isTopFold = false
end

function FriendController:RefreshRecommendBuddies(handler, target)
	FriendAgent.instance:sendRefreshRecommendBuddiesReq(handler, target)
end

function FriendController:addFriend(friendId)
	if checknumber(friendId) == checknumber(LoginModel.instance.userId) then
		FloatWordMgr.instance:show("无法添加自己为好友")
	elseif FriendModel.instance:getIsGroupFull(GameEnum.FriendGroup.Friend) then
		FloatWordMgr.instance:show("您的好友已达数量上限")
	else
		FriendModel.instance:SetMyApply(friendId)
		FriendAgent.instance:sendRequestAddBuddyReq(friendId)
	end
end

function FriendController:isApplyed(friendId)
	return FriendModel.instance:GetIsInMyApplyList(friendId)
end

function FriendController:handleBuddyRequest(id, isAgree)
	local friendMo = FriendModel.instance:getFriendMo(id)

	if isAgree ~= true then
		FriendAgent.instance:sendHandleBuddyRequestReq(id, isAgree)

		return
	end

	if friendMo and friendMo:IsFriend() then
		FriendModel.instance:removeRequest(id)
		self:localNotify("FriendApplyUpdate")
		FloatWordMgr.instance:show("已和该玩家成为好友")

		return
	end

	if FriendModel.instance:getIsGroupFull(GameEnum.FriendGroup.Friend) and isAgree then
		FloatWordMgr.instance:show("您的好友已达数量上限")
	else
		FriendAgent.instance:sendHandleBuddyRequestReq(id, isAgree)
	end
end

function FriendController:batchHandleBuddyRequest(isAgree)
	if FriendModel.instance:getIsGroupFull(GameEnum.FriendGroup.Friend) and isAgree then
		FloatWordMgr.instance:show("您的好友已达数量上限")
	else
		local applies = FriendModel.instance:getRequests()
		local t = {}

		for _, v in ipairs(applies) do
			table.insert(t, v.headInfo.userId)
		end

		print("+appliesapplies", applies, #applies)
		FriendAgent.instance:sendBatchHandleBuddyRequestReq(t, isAgree)
	end
end

function FriendController:getCurSelectedId()
	return self._curSelectedId
end

function FriendController:setCurSelctedId(id)
	self._curSelectedId = id
end

function FriendController:getGroupIdx()
	return self.selectIdx
end

function FriendController:setGroupIdx(id)
	self.selectIdx = id
end

function FriendController:onClickItemFriend(id)
	if id and id ~= self._curSelectedId then
		local preId = self._curSelectedId

		self:setCurSelctedId(id)
		self:localNotify("SelectedIdChange", preId)
	end
end

function FriendController:showInfoView(userId, _btnIcon, isShield, content)
	if tostring(userId) == tostring(LoginModel.instance.userId) then
		RoleController.instance:openMyInfoCard()
	else
		FriendAgent.instance:sendSearchUserReq(nil, userId, function()
			local mos = FriendModel.instance:GetSearchs()
			local groupType = FriendModel.instance:getGroupTypeById(userId)

			if #mos == 1 then
				local go

				UIStateManager.instance:open(ViewName.playerInfo, mos[1], groupType, (_btnIcon ~= nil or nil) and _btnIcon.gameObject, isShield, content)
			end
		end)
	end
end

function FriendController:setSelectedGroup(group)
	self._selectedGroup = group
end

function FriendController:getSelectedGroup()
	return self._selectedGroup or -1
end

function FriendController:OpenFriendView(...)
	UIStateManager.instance:push(ViewName.Friend, ...)
end

function FriendController:LoadFriendsInfo()
	self:LoadFriends()
	self:sendGetBuddyRelationshipReq({
		0
	})
end

function FriendController:LoadFriends()
	local now = ServerTime.now()

	if self._lastRefreshTime == nil or now - self._lastRefreshTime < 600 then
		self._lastRefreshTime = now

		FriendAgent.instance:sendGetBuddyInfoReq()
	end
end

function FriendController:DeleteFriend(id)
	local result, tips = self:getDeleteResultAndTips(id)

	if result ~= GameEnum.ResultCode.Success then
		FloatWordMgr.instance:show(tips)

		return
	end

	FriendAgent.instance:sendRemoveBuddyReq({
		id
	})
end

function FriendController:DeleteFriendList(idList)
	local isHaveError = false
	local list = {}

	for _, id in ipairs(idList) do
		local result, tips = self:getDeleteResultAndTips(id)

		if result == GameEnum.ResultCode.Success then
			table.insert(list, id)
		else
			isHaveError = true
		end
	end

	if isHaveError then
		FloatWordMgr.instance:show("存在无法解除的好友关系")
	end

	if #list > 0 then
		FriendAgent.instance:sendRemoveBuddyReq(list)
	end
end

function FriendController:getDeleteResultAndTips(id)
	local result = GameEnum.ResultCode.Success
	local tips = ""
	local relTypeList = FriendModel.instance:getRelTypeList(id)

	for _, relType in ipairs(relTypeList) do
		if relType == GameEnum.RelTypeByFriend.Tutor then
			result = GameEnum.ResultCode.Error
			tips = "师徒关系无法解除"

			break
		end
	end

	return result, tips
end

function FriendController:AddBlacklist(id)
	FriendAgent.instance:sendAddBlackListReq(id)
end

function FriendController:AddBlacklistByMo(mo)
	local function finishCall()
		FriendModel.instance:AddBlacklistByMo(mo)
	end

	FriendAgent.instance:sendAddBlackListReq(mo.headInfo.userId, finishCall)
end

function FriendController:RemoveBlacklist(id)
	FriendAgent.instance:sendRemoveBlackListReq(id)
end

function FriendController:GetFriendList()
	local function sortFunc(aId, bId)
		local channel = GameEnum.ChatChannel.Private
		local isAllRead_a = ChatModel.instance:IsAllRead(channel, aId)
		local isAllRead_b = ChatModel.instance:IsAllRead(channel, bId)

		if isAllRead_a ~= isAllRead_b then
			return isAllRead_a == false
		end

		if isAllRead_a == false then
			local msg_a = ChatModel.instance:GetLastMsg(channel, aId)
			local msg_b = ChatModel.instance:GetLastMsg(channel, bId)

			return msg_a:GetTimestamp() > msg_b:GetTimestamp()
		end

		local friendMo_a = FriendModel.instance:getFriendMo(aId)
		local friendMo_b = FriendModel.instance:getFriendMo(bId)

		if friendMo_a:Online() ~= friendMo_b:Online() then
			return friendMo_a:Online() == true
		end

		return friendMo_a:lastOpTime() > friendMo_b:lastOpTime()
	end

	local list = FriendModel.instance:GetFriends()

	table.sort(list, sortFunc)

	return list
end

function FriendController:GetStrangerList()
	local function sortFunc(aId, bId)
		local channel = GameEnum.ChatChannel.Private
		local isAllRead_a = ChatModel.instance:IsAllRead(channel, aId)
		local isAllRead_b = ChatModel.instance:IsAllRead(channel, bId)

		if isAllRead_a ~= isAllRead_b then
			return isAllRead_a == false
		end

		if isAllRead_a == false then
			local msg_a = ChatModel.instance:GetLastMsg(channel, aId)
			local msg_b = ChatModel.instance:GetLastMsg(channel, bId)

			return msg_a:GetTimestamp() > msg_b:GetTimestamp()
		end

		local friendMo_a = FriendModel.instance:getFriendMo(aId)
		local friendMo_b = FriendModel.instance:getFriendMo(bId)

		if friendMo_a:Online() ~= friendMo_b:Online() then
			return friendMo_a:Online() == true
		end

		return friendMo_a:lastOpTime() > friendMo_b:lastOpTime()
	end

	local list = FriendModel.instance:GetStrangers()

	table.sort(list, sortFunc)

	return list
end

function FriendController:GetBlackList()
	local function sortFunc(aId, bId)
		local friendMo_a = FriendModel.instance:getFriendMo(aId)
		local friendMo_b = FriendModel.instance:getFriendMo(bId)

		return friendMo_a:lastOpTime() > friendMo_b:lastOpTime()
	end

	local list = FriendModel.instance:GetBlackList()

	table.sort(list, sortFunc)

	return list
end

function FriendController:_OnFriendRemove(id)
	if id == self._selectedId then
		self:SetSelectedId()
	end
end

function FriendController:_OnStrangerRemove(id)
	if id == self._selectedId then
		self:SetSelectedId()
	end
end

function FriendController:_OnBlacklistRemove(id)
	if id == self._selectedId then
		self:SetSelectedId()
	end
end

function FriendController:AddStrangerFromChat(mo)
	FriendModel.instance:AddStrangerFromChat(mo)
end

function FriendController:setSortValue(i, value)
	self._sortValues[i] = value
end

function FriendController:getSortValue(i)
	return self._sortValues[i] == true
end

function FriendController:getOnekeyRedActive()
	local ins = FriendModel.instance
	local t = ins:getGroupDatas(GameEnum.FriendGroup.Friend)
	local sendedHearts = ins:getSendedHearts()
	local maxSendCount = ins:getMaxSendHeartOneDay()
	local canGainHearts = ins:getCanGainHearts()
	local maxGainCount = ins:getMaxGainHeartOneDay()
	local leftSendCount = maxSendCount - ins:getSendedHeartNum()
	local leftGainCount = maxGainCount - ins:getGainedHeartNum()

	for i = 1, math.min(#t, leftSendCount) do
		local friendId = t[i]._id

		if sendedHearts[friendId] ~= true then
			return true
		end
	end

	for i = 1, math.min(#t, leftGainCount) do
		local friendId = t[i]._id

		if canGainHearts[friendId] == true then
			return true
		end
	end

	return false
end

function FriendController:onekeyHeart(handler, handlerTarget)
	self._handler = handler
	self._handlerTarget = handlerTarget

	local ins = FriendModel.instance
	local t = ins:getGroupDatas(GameEnum.FriendGroup.Friend)
	local sendedHearts = ins:getSendedHearts()
	local maxSendCount = ins:getMaxSendHeartOneDay()
	local canGainHearts = ins:getCanGainHearts()
	local maxGainCount = ins:getMaxGainHeartOneDay()
	local sendFriendIds = {}
	local gainFriendIds = {}
	local leftSendCount = maxSendCount - ins:getSendedHeartNum()
	local leftGainCount = maxGainCount - ins:getGainedHeartNum()

	for i = 1, #t do
		local friendId = t[i]._id

		if leftSendCount <= #sendFriendIds then
			break
		end

		if sendedHearts[friendId] ~= true then
			table.insert(sendFriendIds, friendId)
		end
	end

	for i = 1, #t do
		local friendId = t[i]._id

		if leftGainCount <= #gainFriendIds then
			break
		end

		if canGainHearts[friendId] == true then
			table.insert(gainFriendIds, friendId)
		end
	end

	if leftSendCount == 0 and leftGainCount == 0 then
		FloatWordMgr.instance:show("今日领取和赠送已达上限")
	elseif #sendFriendIds == 0 and #gainFriendIds == 0 then
		FloatWordMgr.instance:show("当前已没有可领取或赠送的友情点")
	else
		self._sendIds = sendFriendIds
		self._gainIds = gainFriendIds
		self._changeSetIds = {}

		GlobalDispatcher:addListener(GlobalNotify.SendOrGainHeart, self._tryOnekeyReq, self)
		self:_tryOnekeyReq()

		return true
	end

	return false
end

function FriendController:_tryOnekeyReq(isSend, msg)
	if msg and checknumber(msg.changeSetId) > 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		table.insert(self._changeSetIds, msg.changeSetId)
	end

	local friendIds = {}

	if #self._sendIds > 0 then
		for i = 1, math.min(#self._sendIds, 5) do
			table.insert(friendIds, self._sendIds[1])
			table.remove(self._sendIds, 1)
		end

		FriendAgent.instance:sendSendHeartsReq(friendIds)
	elseif #self._gainIds > 0 then
		for i = 1, math.min(#self._gainIds, 5) do
			table.insert(friendIds, self._gainIds[1])
			table.remove(self._gainIds, 1)
		end

		FriendAgent.instance:sendGainHeartsReq(friendIds)
	else
		self:_onOnekeyFinished()
	end
end

function FriendController:_onOnekeyFinished()
	print("on one key finished")
	GlobalDispatcher:removeListener(GlobalNotify.SendOrGainHeart, self._tryOnekeyReq, self)

	if #self._changeSetIds > 0 then
		MaterialController.instance:showChangeSetInTemp(self._changeSetIds)
	end

	self._sendIds = {}
	self._gainIds = {}
	self._changeSetIds = {}

	self:localNotify("OneKeySendOrGainHearts")
end

function FriendController:sendRefreshRecommend()
	local now = ServerTime.now()
	local time = checknumber(self.sendRefreshRecommendTime)
	local list = FriendModel.instance:getRecommends()

	if now - time >= 5 or #list <= 3 then
		self.sendRefreshRecommendTime = now

		FriendAgent.instance:sendRefreshRecommendBuddiesReq()
	else
		FriendModel.instance:randRecommends()
		FriendController.instance:localNotify("RefreshRecomend")
	end
end

function FriendController:getBuddyFetterInfo(buddyId)
	local mo = FriendModel.instance:getFriendMo(buddyId)
	local group = mo._groupType

	if group == GameEnum.FriendGroup.Friend then
		FriendAgent.instance:sendGetFetterInfoReq(buddyId)
	end
end

function FriendController:handleGetBuddyFetterInfo(msg)
	local infoList = msg.infoList
	local dataList = {}

	for k, v in ipairs(infoList) do
		dataList[v.id] = checkint(v.dailyAddValue)
	end

	local tip = langPara("BuddyFetterExplain", unpack(dataList))

	TipsFacade.instance:openTipWindowNoX(lang("羁绊值说明"), tip)
end

function FriendController:handleNotifyBuddyLogin(msg)
	local userName = msg.buddy.simpleInfo.headInfo.userName
	local tip = langPara("BuddyOnlineTip", userName)

	FloatWordMgr.instance:show(tip)
end

function FriendController:handleUdateBuddyFetter(msg)
	local infoList = msg.infoList

	for k, info in ipairs(infoList) do
		local mo = FriendModel.instance:getFriendMo(info.buddyId)

		if mo then
			mo:setCurFetter(info.fetter)
		end
	end

	GlobalDispatcher:dispatch(GlobalNotify.FriendFetterChange)
end

function FriendController:checkWelfareRdState()
	local cfgs = FriendConfig.instance:getFetterWelfareCfgs()

	for k, cfg in pairs(cfgs) do
		local isOpen = false

		if not string.nilorempty(cfg.startTime) then
			local timeNow = ServerTime.now()

			isOpen = timeNow > GameUtil.string2time(cfg.startTime)
		end

		if isOpen and (checkint(cfg.funcId) > 0 or nil) and FuncOpenModel.instance:getFuncIsOpen(cfg.funcId) then
			local isShowFirst = checkint(GameUtil.getUserData(ViewName.FriendWelfare .. "_" .. cfg.id)) <= 0
			local isShowRd = false

			if not string.nilorempty(cfg.redpiont) then
				local rdIds = string.splitToNumber(cfg.redpiont, "#")

				for k, v in ipairs(rdIds) do
					if RedPointModel.instance:isActive(v) then
						isShowRd = true

						break
					end
				end
			end

			return isShowFirst or isShowRd
		end
	end

	return false
end

function FriendController:addListenerAboutAllRelationshipChange()
	GlobalDispatcher:addListener(GlobalNotify.NotifyTutorRelationShipChange, function()
		FriendController.instance:sendGetBuddyRelationshipReq({
			GameEnum.RelTypeByFriend.Tutor
		})
	end, self)
end

function FriendController:sendGetBuddyRelationshipReq(relTypeList)
	FriendAgent.instance:sendGetBuddyRelationshipReq(relTypeList)
end

function FriendController:handleGetBuddyRelationshipRes(msg)
	FriendModel.instance:handleGetBuddyRelationshipRes(msg)
	GlobalDispatcher:dispatch(GlobalNotify.FriendBuddyRelationshipRes)
end

function FriendController:addTopFriendId(userId)
	self:_initTopFriendIds()

	local numberUserId = checknumber(userId)

	if numberUserId <= 0 then
		return
	end

	local isHit = false

	for i, v in ipairs(self._topFriendIdList) do
		if v.userId == numberUserId then
			v.time = ServerTime.now()
			isHit = true

			break
		end
	end

	if not isHit then
		table.insert(self._topFriendIdList, {
			userId = numberUserId,
			time = ServerTime.now()
		})
	end

	GameUtil.saveUserData(FriendController.KeyTopFriendIds, self._topFriendIdList)
	GlobalDispatcher:dispatch(GlobalNotify.TopFriendChange)
end

function FriendController:removeTopFriendId(userId)
	self:_initTopFriendIds()

	local numberUserId = checknumber(userId)

	if numberUserId <= 0 then
		return
	end

	local idx = -1

	for i, v in ipairs(self._topFriendIdList) do
		if v.userId == numberUserId then
			v.time = ServerTime.now()
			idx = i

			break
		end
	end

	if idx ~= -1 then
		table.remove(self._topFriendIdList, idx)
	end

	GameUtil.saveUserData(FriendController.KeyTopFriendIds, self._topFriendIdList)
	GlobalDispatcher:dispatch(GlobalNotify.TopFriendChange)
end

function FriendController:isTopFriendId(userId)
	self:_initTopFriendIds()

	local numberUserId = checknumber(userId)

	if numberUserId <= 0 then
		return false
	end

	for i, v in ipairs(self._topFriendIdList) do
		if v.userId == numberUserId then
			return true
		end
	end
end

function FriendController:_initTopFriendIds()
	self._topFriendIdList = self._topFriendIdList or GameUtil.getUserData(FriendController.KeyTopFriendIds) or {}
end

function FriendController:sortTopFriendList(list)
	if not list or #list <= 0 then
		return
	end

	self:_initTopFriendIds()

	local map = {}

	for i, v in ipairs(self._topFriendIdList) do
		map[v.userId] = v.time
	end

	table.sort(list, function(a, b)
		return (map[checknumber(a:GetId())] or 0) > (map[checknumber(b:GetId())] or 0)
	end)
end

function FriendController:getIsTopFold()
	return self._isTopFold
end

function FriendController:changeTopFold()
	self._isTopFold = not self._isTopFold

	return self._isTopFold
end

function FriendController:changeFriendSortTimeIfIsTop(userId, time)
	self:_initTopFriendIds()

	local numberUserId = checknumber(userId)

	if numberUserId <= 0 then
		return false
	end

	for i, v in ipairs(self._topFriendIdList) do
		if v.userId == numberUserId then
			v.time = checknumber(time)

			GlobalDispatcher:dispatch(GlobalNotify.TopFriendChange)

			break
		end
	end
end

FriendController.instance = FriendController.New()

return FriendController
