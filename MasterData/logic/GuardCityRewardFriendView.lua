-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/view/GuardCityRewardFriendView.lua

module("logic.extensions.guardcity.view.GuardCityRewardFriendView", package.seeall)

local GuardCityRewardFriendView = class("GuardCityRewardFriendView", ViewComponent)

function GuardCityRewardFriendView:ctor()
	GuardCityRewardFriendView.super.ctor(self)
end

function GuardCityRewardFriendView:buildUI()
	GuardCityRewardFriendView.super.buildUI(self)

	self._tableView = self:getGo("rewardCol/tableview")
	self._tableCell = self:getGo("rewardCol/rewardCell")
	self._emptyGo = self:getGo("rewardCol/empty")
end

function GuardCityRewardFriendView:bindEvents()
	GuardCityRewardFriendView.super.buildUI(self)
end

function GuardCityRewardFriendView:unbindEvents()
	GuardCityRewardFriendView.super.unbindEvents(self)
end

function GuardCityRewardFriendView:onEnter()
	GuardCityRewardFriendView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self.refreshView, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_GuardCityGainFriendPrizeRes, self._PM_GuardCityGainFriendPrizeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.GuardCityRewardRecvieAll, self._onClickOneKey, self)

	self._tabScroll = ScrollerList.create(self._tableView, self._tableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._activityId = self:getFirstParam()

	self:refreshView()
	GuardCityAgent.instance:sendPM_GuardCityViewFriendScoreReq(self._activityId)
end

function GuardCityRewardFriendView:onExit()
	GuardCityRewardFriendView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityViewFriendScoreRes, self.refreshView, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_GuardCityGainFriendPrizeRes, self._PM_GuardCityGainFriendPrizeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.GuardCityRewardRecvieAll, self._onClickOneKey, self)
	self._tabScroll:dispose()
end

function GuardCityRewardFriendView:refreshView()
	local list = GuardCiytModel.instance:getFriendScoreList()

	self._tabScroll:reloadData(list)
	GameUtil.SetActive(self._emptyGo, #list <= 0)
end

function GuardCityRewardFriendView:_updateCell(view, cell, data, tag)
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

	if checknumber(data.score) > 0 and data.rank <= GuardCityConfig.instance:getCommonValue("INHERIT_FRIEND_RANK", true) then
		scoreNum = math.ceil(data.score * 0.0001 * GuardCityConfig.instance:getCommonValue("INHERIT_FRIEND_SCORE_RATIO", true))

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

function GuardCityRewardFriendView:_clearCell(cell)
	local go = cell.gameObject
	local imgIcon = goutil.findChild(go, "head")
	local btnReceive = GameUtil.asBtn(goutil.findChild(go, "btnReceive"))

	HeadItemController.instance:resetHeadCell(imgIcon)
	btnReceive:RemoveClickListener()
end

function GuardCityRewardFriendView:_onClickReceive(friendId)
	local friendIds = {
		friendId
	}

	GuardCityAgent.instance:sendPM_GuardCityGainFriendPrizeReq(self._activityId, friendIds)
end

function GuardCityRewardFriendView:onHeadClick(userId, imgIcon)
	FriendController.instance:showInfoView(userId, imgIcon)
end

function GuardCityRewardFriendView:_onClickOneKey(tabId)
	if tabId ~= 1 then
		return
	end

	local dataList = GuardCiytModel.instance:getFriendScoreList()
	local friendIds = {}

	for i, v in ipairs(dataList) do
		if checknumber(v.score) > 0 and v.rank <= GuardCityConfig.instance:getCommonValue("INHERIT_FRIEND_RANK", true) and not v.gain then
			table.insert(friendIds, v.headInfo.userId)
		end
	end

	if #friendIds > 0 then
		GuardCityAgent.instance:sendPM_GuardCityGainFriendPrizeReq(self._activityId, friendIds)
	else
		FloatWordMgr.instance:show(lang("无可领取对象"))
	end
end

function GuardCityRewardFriendView:_PM_GuardCityGainFriendPrizeRes()
	GuardCityAgent.instance:sendPM_GuardCityViewFriendScoreReq(self._activityId)
end

return GuardCityRewardFriendView
