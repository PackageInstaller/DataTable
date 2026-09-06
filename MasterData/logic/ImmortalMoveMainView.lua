-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/immortalmovement/view/ImmortalMoveMainView.lua

module("logic.extensions.immortalmovement.view.ImmortalMoveMainView", package.seeall)

local ImmortalMoveMainView = class("ImmortalMoveMainView", ViewComponent)

function ImmortalMoveMainView:ctor()
	ImmortalMoveMainView.super.ctor(self)
end

function ImmortalMoveMainView:unbindEvents()
	ImmortalMoveMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnUnlock)
	GameUtil.rmClickHandler(self._btnChallenge)
end

function ImmortalMoveMainView:bindEvents()
	ImmortalMoveMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnUnlock, self._onClickBtnUnlock, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
end

function ImmortalMoveMainView:buildUI()
	ImmortalMoveMainView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnUnlock = self:getGo("unlock/btn")
	self._showCon = self:getGo("unlock/bubble/showCon")
	self._btnChallenge = self:getGo("challenge/btn")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._con = self:getGo("con")
	self._rdUnlock = self:getGo("unlock/btn/rd")
end

function ImmortalMoveMainView:onExit()
	ImmortalMoveMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._showCon)
	RedPointController.instance:unregRedPoint(self._rdUnlock)
end

function ImmortalMoveMainView:onEnter()
	ImmortalMoveMainView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self._activityId = 484001
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self.addGEvent(self, GlobalNotify.ImmortalMovementGetInfo, self._updateUIByInfo, self)
	self:_updateUIByCfg()
	ImmortalMovementController.instance:getInfo(self._activityId)
end

function ImmortalMoveMainView:_updateUIByCfg()
	self._actCfg = ImmortalMovementConfig.instance:getActCfgById(self._activityId)
	self._curSkinId = self._actCfg.skinId
	self._role = RoleObjectPool.instance:addRoleToParent(self._role, self._curSkinId, self._con, nil, nil, true, nil, nil)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	MaterialMgr.setCellByCfg(self._actCfg.bubblePrize, self._showCon)
	RedPointController.instance:regRedPoint(self._rdUnlock, self._actCfg.redPointId)
end

function ImmortalMoveMainView:_updateUIByInfo()
	return
end

function ImmortalMoveMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function ImmortalMoveMainView:_onClickBtnUnlock()
	UIStateManager.instance:push(ViewName.ImmortalMoveUnlockView, self._activityId)
end

function ImmortalMoveMainView:_onClickBtnChallenge()
	UIStateManager.instance:push(ViewName.ImmortalMoveStageView, self._activityId)
end

return ImmortalMoveMainView
