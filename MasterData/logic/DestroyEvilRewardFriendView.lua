-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/destroyevil/view/DestroyEvilRewardFriendView.lua

module("logic.extensions.destroyevil.view.DestroyEvilRewardFriendView", package.seeall)

local DestroyEvilRewardFriendView = class("DestroyEvilRewardFriendView", ViewComponent)

function DestroyEvilRewardFriendView:buildUI()
	DestroyEvilRewardFriendView.super.buildUI(self)

	self._tableView = self:getGo("rewardCol/tableview")
	self._tableCell = self:getGo("rewardCol/rewardCell")
	self._emptyGo = self:getGo("rewardCol/empty")
end

function DestroyEvilRewardFriendView:bindEvents()
	DestroyEvilRewardFriendView.super.buildUI(self)
end

function DestroyEvilRewardFriendView:unbindEvents()
	DestroyEvilRewardFriendView.super.unbindEvents(self)
end

function DestroyEvilRewardFriendView:onEnter()
	DestroyEvilRewardFriendView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilGainBuddyPrizeRes, self.onDestroyEvilGainBuddyPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.DestroyEvilRewardRecvieAll, self._onClickOneKey, self)

	self._tabScroll = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()
	self._cfgActivity = DestroyEvilConfig.instance:getActivityCfg(self._activityId)

	self:refreshView()
	DestroyEvilAgent.instance:sendPM_DestroyEvilViewBuddyScoreReq(self._activityId)
end

function DestroyEvilRewardFriendView:onExit()
	DestroyEvilRewardFriendView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilViewBuddyScoreRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilGainBuddyPrizeRes, self.onDestroyEvilGainBuddyPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.DestroyEvilRewardRecvieAll, self._onClickOneKey, self)
	self._tabScroll:dispose()
end

function DestroyEvilRewardFriendView:refreshView()
	local list = DestroyEvilModel.instance:getFriendScoreList()

	self._tabScroll:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function DestroyEvilRewardFriendView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local txtName = goutil.findChildTextComponent(go, "txtName")
	local txtLevel = goutil.findChildTextComponent(go, "txtLevel")
	local txtRank = goutil.findChildTextComponent(go, "txtRank")
	local txtTotalScore = goutil.findChildTextComponent(go, "txtTotalScore")
	local imgScore = goutil.findChildComponent(go, "scoreCol/imgScore", "UIImgNumeralText")
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))
	local receiveGo = goutil.findChild(go, "receive")
	local proxy = HeadItemController.instance:setHeadCellByInfo(imgIcon, data.headInfo)

	if proxy then
		proxy:setCallBack(function()
			if data.headInfo.userId then
				self:onHeadClick(data.headInfo.userId, imgIcon)
			end
		end)
	end

	txtName.text = data.headInfo.userName
	txtLevel.text = langPara("Lv.%d", data.headInfo.playerLv)
	txtRank.text = langPara("NO.%d", data.rank)

	GameUtil.SetActive(btnReceive, false)
	GameUtil.SetActive(receiveGo, false)

	txtTotalScore.text = data.score

	local scoreNum = 0

	if checknumber(data.score) > 0 and data.rank <= self._cfgActivity.inheritBuddyRank then
		scoreNum = math.ceil(data.score * 0.0001 * self._cfgActivity.inheritBuddyRatio)

		if data.gain == true then
			GameUtil.SetActive(receiveGo, true)
		elseif not data.gain then
			GameUtil.SetActive(btnReceive, true)
		end
	else
		scoreNum = 0
	end

	imgScore:SetNum(scoreNum)
	btnReceive:AddClickListener(function()
		self:_onClickReceive(data.headInfo.userId)
	end, self)
end

function DestroyEvilRewardFriendView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))

	HeadItemController.instance:resetHeadCell(imgIcon)
	btnReceive:RemoveClickListener()
end

function DestroyEvilRewardFriendView:_onClickReceive(friendId)
	local friendIds = {
		friendId
	}

	DestroyEvilAgent.instance:sendPM_DestroyEvilGainBuddyPrizeReq(self._activityId, friendIds)
end

function DestroyEvilRewardFriendView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function DestroyEvilRewardFriendView:_onClickOneKey(tabId)
	if tabId ~= 1 then
		return
	end

	local dataList = DestroyEvilModel.instance:getFriendScoreList()
	local friendIds = {}

	for i, v in ipairs(dataList) do
		if checknumber(v.score) > 0 and v.rank <= self._cfgActivity.inheritBuddyRank and not v.gain then
			table.insert(friendIds, v.headInfo.userId)
		end
	end

	if #friendIds > 0 then
		DestroyEvilAgent.instance:sendPM_DestroyEvilGainBuddyPrizeReq(self._activityId, friendIds)
	else
		FloatWordMgr.instance:show(lang("无可领取对象"))
	end
end

function DestroyEvilRewardFriendView:onDestroyEvilGainBuddyPrizeRes()
	DestroyEvilAgent.instance:sendPM_DestroyEvilViewBuddyScoreReq(self._activityId)
end

return DestroyEvilRewardFriendView
