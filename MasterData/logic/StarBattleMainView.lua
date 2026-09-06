-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/starbattle/view/StarBattleMainView.lua

module("logic.extensions.starbattle.view.StarBattleMainView", package.seeall)

local StarBattleMainView = class("StarBattleMainView", ViewComponent)

function StarBattleMainView:ctor()
	StarBattleMainView.super.ctor(self)
end

function StarBattleMainView:unbindEvents()
	StarBattleMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnJumpRank)
	GameUtil.rmClickHandler(self._btnJumpChange)

	for i, cell in ipairs(self._switchBtns) do
		GameUtil.rmClickHandler(cell.go)
	end
end

function StarBattleMainView:bindEvents()
	StarBattleMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnJumpRank, self._onClickJumpRank, self)
	GameUtil.addClickHandler(self._btnJumpChange, self._onClickJumpChange, self)

	for i, cell in ipairs(self._switchBtns) do
		GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickSwitchBtn, self, i))
	end
end

function StarBattleMainView:buildUI()
	StarBattleMainView.super.buildUI(self)

	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._contentCol = self:getGo("contentCol")
	self._btnJumpRank = self:getGo("jumpBtnCol/btnJumpRank")
	self._btnJumpChange = self:getGo("jumpBtnCol/btnJumpChange")
	self._switchBtns = {}

	for i = 1, 3 do
		local cell = {}

		cell.go = self:getGo("switchBtns/btn_" .. i)
		cell.rp = goutil.findChild(cell.go, "rp")
		cell.changeGroup = cell.go:GetComponent("UIChangeGroup")

		table.insert(self._switchBtns, cell)
	end
end

function StarBattleMainView:onExit()
	StarBattleMainView.super.onExit(self)

	for i, cell in ipairs(self._switchBtns) do
		RedPointController.instance:unregRedPoint(cell.rp)
	end
end

function StarBattleMainView:onEnter()
	StarBattleMainView.super.onEnter(self)

	self._activityId = 510001
	self._periodId = 1

	local params = self:getOpenParam()

	if params then
		if params[1] then
			self._activityId = checknumber(params[1])
		end

		self._periodId = StarBattleController.instance:getCurrentPeriodId(self._activityId)
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.PM_StarBattleGetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	self:_updateUIByInfo()
	StarBattleController.instance:getInfo(self._activityId, self._periodId)

	self._curTabId = nil

	local tabId = StarBattleController.instance:getLastTab(self._activityId, self._periodId)

	if tabId <= 0 then
		tabId = 1
	end

	self:_onClickSwitchBtn(tabId)
	StarBattleController.instance:showCI()
	RedPointController.instance:regRedPoint(self._switchBtns[1].rp, RedPointModel.ID_STAR_BATTLE_DEF_PRIZE)
	RedPointController.instance:regRedPoint(self._switchBtns[2].rp, RedPointModel.ID_STAR_BATTLE_BUFF)
	RedPointController.instance:regRedPoint(self._switchBtns[3].rp, RedPointModel.ID_STAR_BATTLE_BOSS_PRIZE)
end

function StarBattleMainView:_updateUIByCfg()
	self._curActCfg = StarBattleConfig.instance:getActCfg(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
end

function StarBattleMainView:_updateUIByInfo()
	self._isNewHand = false

	local info = StarBattleModel.instance:getBaseInfo(self._activityId, self._periodId)

	if info then
		self._isNewHand = info.isBeginner
	end
end

function StarBattleMainView:_onClickTip()
	local key = self._curActCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function StarBattleMainView:_onClickJumpRank()
	UIStateManager.instance:push(ViewName.StarBattleRankMainView, self._isNewHand and 2 or 1)
end

function StarBattleMainView:_onClickJumpChange()
	local gotoStr = self._curActCfg.changeJump

	if not GameUtil.isEmptyString(gotoStr) then
		GotoMgr.gotoByString(gotoStr)
	end
end

function StarBattleMainView:_onClickSwitchBtn(index)
	for i, cell in ipairs(self._switchBtns) do
		if i == index then
			cell.changeGroup:SetState(1)
		else
			cell.changeGroup:SetState(0)
		end
	end

	if self._curTabId == index then
		return
	end

	self._curTabId = index

	self:showTabAt(self._contentCol, "")

	if index == 1 then
		self:showTabAt(self._contentCol, ViewName.StarBattleDefView, self._activityId)
	elseif index == 2 then
		self:showTabAt(self._contentCol, ViewName.StarBattleStageView, self._activityId)
	elseif index == 3 then
		self:showTabAt(self._contentCol, ViewName.StarBattleBossView, self._activityId)
	end
end

return StarBattleMainView
