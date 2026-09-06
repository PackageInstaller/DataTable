-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/view/TianYanMatchMainView.lua

module("logic.extensions.tianyanmatch.view.TianYanMatchMainView", package.seeall)

local TianYanMatchMainView = class("TianYanMatchMainView", ViewComponent)

function TianYanMatchMainView:ctor()
	TianYanMatchMainView.super.ctor(self)
end

function TianYanMatchMainView:unbindEvents()
	TianYanMatchMainView.super.unbindEvents(self)
end

function TianYanMatchMainView:bindEvents()
	TianYanMatchMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTips, self)
	GameUtil.addClickHandler(self._btnMatchOnline, self._onClickMatchOnline, self)
	GameUtil.addClickHandler(self._btnMatchFriend, self._onClickMatchFriend, self)
	GameUtil.addClickHandler(self._btnRank, self._onClickRank, self)
	GameUtil.addClickHandler(self._btnShop, self._onClickShop, self)
	GameUtil.addClickHandler(self._btnBook, self._onClickBook, self)
	GameUtil.addClickHandler(self._btnGame, self._onClickGame, self)
	GameUtil.addClickHandler(self._btnMyEmpty, self._onClickMyChange, self)
	GameUtil.addClickHandler(self._btnMyChange, self._onClickMyChange, self)
	GameUtil.addClickHandler(self._btnFriendship, self._onClickFriendship, self)
	GameUtil.addClickHandler(self._btnMatchEmpty, self._onClickMatchChange, self)
	GameUtil.addClickHandler(self._btnMatchChange, self._onClickMatchChange, self)
end

function TianYanMatchMainView:buildUI()
	TianYanMatchMainView.super.buildUI(self)

	self._btnTip = self:getGo("btnTip")
	self._btnClose = self:getGo("btnClose")
	self._btnMatchOnline = self:getGo("btnMatchOnline")
	self._btnMatchFriend = self:getGo("btnMatchFriend")
	self._btnRank = self:getGo("btnRank")
	self._btnShop = self:getGo("btnShop")
	self._btnBook = self:getGo("btnBook")
	self._redPointBook = self:getGo("btnBook/redpoint")
	self._btnGame = self:getGo("btnGame")
	self._imgMyToy = self:getGo("myToy/imgToy")
	self._myEmpty = self:getGo("myToy/empty")
	self._btnMyEmpty = self:getGo("myToy/empty/btnEmpty")
	self._btnMyChange = self:getGo("myToy/btnChange")
	self._btnFriendship = self:getGo("myToy/btnFriendship")
	self._txtMyName = self:getTxt("myToy/title/txtName")
	self._txtFriendship = self:getTxt("myToy/friendship/txtFriendship")
	self._friendshipGo = self:getGo("myToy/friendship")
	self._imgMatchToy = self:getGo("matchToy/imgToy")
	self._matchEmpty = self:getGo("matchToy/empty")
	self._btnMatchEmpty = self:getGo("matchToy/empty/btnEmpty")
	self._btnMatchChange = self:getGo("matchToy/btnChange")
	self._txtMatchName = self:getTxt("matchToy/title/txtName")
	self._matchLock = self:getGo("matchToy/lock")
	self._txtGameTime = self:getTxt("btnGame/txtGameTime")
	self._txtOpenTime = self:getTxt("txtOpenTime")
	self._txtMatchTime = self:getTxt("txtMatchTime")
	self._txtTime = self:getTxt("time/txtTime")
end

function TianYanMatchMainView:onExit()
	TianYanMatchMainView.super.onExit(self)
end

function TianYanMatchMainView:onEnter()
	TianYanMatchMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.TianYanMatchGetInfo, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.TianYanMatchSelectToy, self._onSelectEnd, self)
	self.addGEvent(self, GlobalNotify.ClearStarGameGetInfo, self._refreshGameInfo, self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchGainMatchPrizeRes, self._refreshView, self)
	self.addGEvent(self, GlobalNotify.PM_TianYanMatchNotifyMatchSucRes, self._PM_TianYanMatchNotifyMatchSucRes, self)
	self.addGEvent(self, GlobalNotify.FriendSelected, self._onSelectFriend, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = 503001
	end

	self._activityCfg = TianYanMatchConfig.instance:getActivityCfg(self._activityId)

	TianYanMatchAgent.instance:sendPM_TianYanMatchGetInfoReq(self._activityId)
	ClearStarGameController.instance:getInfo(self._activityCfg.gameActivityId)

	self._txtOpenTime.text = self._activityCfg.matchOpenTime
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
end

function TianYanMatchMainView:_refreshView()
	self._myToyId = TianYanMatchModel.instance:getMyToyId(self._activityId)

	GameUtil.SetActive(self._btnFriendship, self._myToyId > 0)
	GameUtil.SetActive(self._imgMyToy, self._myToyId > 0)
	GameUtil.SetActive(self._myEmpty, self._myToyId < 0)
	GameUtil.SetActive(self._friendshipGo, self._myToyId > 0)

	local friendship = TianYanMatchModel.instance:getFriendship(self._activityId)

	GameUtil.SetActive(self._btnMyChange, self._myToyId > 0)

	if self._myToyId > 0 then
		local toyCfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, self._myToyId)

		uGuiUtil.setSpriteToImage(self._imgMyToy, nil, toyCfg.res)

		self._txtMyName.text = toyCfg.desc
		self._txtFriendship.text = langPara("友情值：%d", friendship)
	else
		uGuiUtil.clearImage(self._imgMyToy)

		self._txtMyName.text = lang("选择自己的玩偶")
	end

	self._matchToyId = TianYanMatchModel.instance:getMatchToyId(self._activityId)

	GameUtil.SetActive(self._btnMatchChange, self._matchToyId > 0)
	GameUtil.SetActive(self._imgMatchToy, self._matchToyId > 0)
	GameUtil.SetActive(self._matchEmpty, self._matchToyId < 0)

	if self._matchToyId > 0 then
		local toyCfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, self._matchToyId)

		uGuiUtil.setSpriteToImage(self._imgMatchToy, nil, toyCfg.res)

		self._txtMatchName.text = toyCfg.desc
	else
		uGuiUtil.clearImage(self._imgMatchToy)

		self._txtMatchName.text = lang("选择想配对的玩偶")
	end

	GameUtil.SetActive(self._matchLock, friendship < self._activityCfg.friendshipLimit)

	if TianYanMatchModel.instance:getMatchResultInfo(self._activityId) ~= nil then
		UIStateManager.instance:push(ViewName.TianYanMatchSuccessView, self._activityId)
	end

	local todayMatchTime = TianYanMatchModel.instance:getMatchTime(self._activityId)

	self._txtMatchTime.text = langPara("今日次数：%d/%d", self._activityCfg.dailyToyCount - todayMatchTime, self._activityCfg.dailyToyCount)

	GameUtil.SetActive(self._redPointBook, TianYanMatchController.instance:hasManualPrize(self._activityId))
end

function TianYanMatchMainView:_refreshGameInfo()
	local actCfg = ClearStarGameConfig.instance:getActivityCfgById(self._activityCfg.gameActivityId)
	local info = ClearStarGameModel.instance:getInfo(self._activityCfg.gameActivityId)

	if info == nil then
		return
	end

	local times = actCfg.dailyTime - checknumber(info.todayTimes)

	self._txtGameTime.text = langPara("今日次数：%d/%d", times, actCfg.dailyTime)
end

function TianYanMatchMainView:_isCanMatchWithTime()
	if TianYanMatchController.instance:isCanMatch(self._activityId, false) == false then
		return false
	end

	local openTimes = string.split(self._activityCfg.matchOpenTime, "-")
	local startHour, startMin, startSec = ServerTimeUtil.getHMSFromString(openTimes[1])
	local endHour, endMin, endSec = ServerTimeUtil.getHMSFromString(openTimes[2])
	local isPassStart = ServerTimeUtil.isHMSPass(startHour, startMin, checknumber(startSec))
	local isPassEnd = ServerTimeUtil.isHMSPass(endHour, endMin, checknumber(endSec))

	if isPassStart == true and not isPassEnd then
		return true
	else
		FloatWordMgr.instance:show(lang("未开放"))

		return false
	end
end

function TianYanMatchMainView:_onClickTips()
	TipsFacade.instance:openRulesView("tian_yan_match_rule")
end

function TianYanMatchMainView:_onClickMatchOnline()
	if TianYanMatchModel.instance:getMatchResultInfo(self._activityId) ~= nil then
		FloatWordMgr.instance:show(lang("仍有未完成的配对"))
		UIStateManager.instance:push(ViewName.TianYanMatchSuccessView, self._activityId)
	end

	if self:_isCanMatchWithTime() then
		UIStateManager.instance:push(ViewName.TianYanMatchRunningView, self._activityId)
	end
end

function TianYanMatchMainView:_onClickMatchFriend()
	local waitTime = TianYanMatchController.SEND_FRIEND_INVITE_CD + TianYanMatchController.instance:getSendInviteFriendTime() - ServerTime.now()

	if waitTime > 0 then
		FloatWordMgr.instance:show(langPara("发送太频繁了，请%d秒后再试", waitTime))

		return
	end

	if TianYanMatchModel.instance:getMatchResultInfo(self._activityId) ~= nil then
		FloatWordMgr.instance:show(lang("仍有未完成的配对"))
		UIStateManager.instance:push(ViewName.TianYanMatchSuccessView, self._activityId)
	end

	if TianYanMatchController.instance:isCanMatch(self._activityId, true) == true then
		UIStateManager.instance:open(ViewName.FriendSelect, 0, 5, lang("请选择想要邀请的好友"))
	end
end

function TianYanMatchMainView:_onClickRank()
	UIStateManager.instance:push(ViewName.TianYanMatchRankView, self._activityId)
end

function TianYanMatchMainView:_onClickShop()
	if not string.nilorempty(self._activityCfg.jumpTo) then
		GotoMgr.gotoByString(self._activityCfg.jumpTo)
	end
end

function TianYanMatchMainView:_onClickBook()
	UIStateManager.instance:push(ViewName.TianYanMatchManualView, self._activityId)
end

function TianYanMatchMainView:_onClickGame()
	TianYanMatchController.instance:_openClearStarGame(self._activityCfg.gameActivityId)
end

function TianYanMatchMainView:_onClickMyChange()
	local toyCfgs = TianYanMatchConfig.instance:getToyCfgs(self._activityId)
	local list = {}

	for i, v in ipairs(toyCfgs) do
		table.insert(list, v)
	end

	GameUtil.permuteArray(list)
	UIStateManager.instance:push(ViewName.TianYanMatchSelectView, self._activityId, false, list)
end

function TianYanMatchMainView:_onClickFriendship()
	local friendship = TianYanMatchModel.instance:getFriendship(self._activityId)

	if friendship >= self._activityCfg.friendshipLimit then
		FloatWordMgr.instance:show(lang("已培养至满友情值"))
	else
		UIStateManager.instance:push(ViewName.TianYanMatchFriendshipView, self._activityId)
	end
end

function TianYanMatchMainView:_onClickMatchChange()
	local friendship = TianYanMatchModel.instance:getFriendship(self._activityId)

	if friendship < self._activityCfg.friendshipLimit then
		FloatWordMgr.instance:show(lang("先把自己的玩偶培养至满友情值，再来选择想要配对的玩偶吧"))

		return
	end

	local selectList = {}
	local toyCfgs = TianYanMatchConfig.instance:getToyCfgs(self._activityId)
	local curToyCfg = TianYanMatchConfig.instance:getToyCfg(self._activityId, self._myToyId)

	for i, v in ipairs(toyCfgs) do
		if curToyCfg.type ~= v.type then
			table.insert(selectList, v)
		end
	end

	UIStateManager.instance:push(ViewName.TianYanMatchSelectView, self._activityId, true, selectList)
end

function TianYanMatchMainView:_onSelectEnd(toyId, isMatch)
	if isMatch == true then
		TianYanMatchAgent.instance:sendPM_TianYanMatchSetWishToyReq(self._activityId, toyId)
	else
		TianYanMatchAgent.instance:sendPM_TianYanMatchSelectToyReq(self._activityId, toyId)
	end
end

function TianYanMatchMainView:_onSelectFriend(userIds)
	TianYanMatchController.instance:sendInviteFriend(self._activityId, userIds)
end

function TianYanMatchMainView:_PM_TianYanMatchNotifyMatchSucRes()
	UIStateManager.instance:push(ViewName.TianYanMatchSuccessView, self._activityId)
end

return TianYanMatchMainView
