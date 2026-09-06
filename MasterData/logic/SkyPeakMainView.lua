-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/skypeak/view/SkyPeakMainView.lua

module("logic.extensions.skypeak.view.SkyPeakMainView", package.seeall)

local SkyPeakMainView = class("SkyPeakMainView", ViewComponent)

function SkyPeakMainView:ctor()
	SkyPeakMainView.super.ctor(self)
end

function SkyPeakMainView:unbindEvents()
	SkyPeakMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnJump1)
	GameUtil.rmClickHandler(self._btnJump2)
	GameUtil.rmClickHandler(self._btnJump3)
	GameUtil.rmClickHandler(self._btnJump4)
	GameUtil.rmClickHandler(self._btnClg)
	GameUtil.rmClickHandler(self._btnBuff)
end

function SkyPeakMainView:bindEvents()
	SkyPeakMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnJump1, GameUtil.handler(self._onClickBtnJump, self, 1))
	GameUtil.addClickHandler(self._btnJump2, GameUtil.handler(self._onClickBtnJump, self, 2))
	GameUtil.addClickHandler(self._btnJump3, GameUtil.handler(self._onClickBtnJump, self, 3))
	GameUtil.addClickHandler(self._btnJump4, GameUtil.handler(self._onClickBtnJump, self, 4))
	GameUtil.addClickHandler(self._btnClg, self._onClickBtnClg, self)
	GameUtil.addClickHandler(self._btnBuff, self._onClickBtnBuff, self)
end

function SkyPeakMainView:buildUI()
	SkyPeakMainView.super.buildUI(self)

	self._btnJump1 = self:getGo("jumpBtnCol/btnJump1")
	self._btnJump2 = self:getGo("jumpBtnCol/btnJump2")
	self._btnJump4 = self:getGo("jumpBtnCol/btnJump4")
	self._btnJump3 = self:getGo("jumpBtnCol/btnJump3")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._btnClg = self:getGo("btnClg")
	self._btnBuff = self:getGo("btnBuff")
	self._rd = self:getGo("btnClg/rd")
	self._txtTipsStage = self:getTxt("tipsStage/txt")
end

function SkyPeakMainView:onExit()
	SkyPeakMainView.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._rd)
end

function SkyPeakMainView:onEnter()
	SkyPeakMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_SkyPeakGetInfoRes, self._updateUIByInfo, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = SkyPeakController.instance:getDefaultActivityId() or 0
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	SkyPeakController.instance:getInfo(self._activityId)
	RedPointController.instance:regRedPoint(self._rd, "c53")
end

function SkyPeakMainView:_updateUIByCfg()
	self._actCfg = SkyPeakConfig.instance:getActivityCfg(self._activityId) or {}
	self._gotoStrs = self._actCfg.jumptoStrs or {}
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)
	self._numStages = SkyPeakConfig.instance:getStageNum(self._activityId)
end

function SkyPeakMainView:_updateUIByInfo()
	local curMaxPassStageId = SkyPeakModel.instance:getMaxPassStageId(self._activityId)

	self._txtTipsStage.text = langPara("最高挑战至\n第<color=#eb4642>%s/%s</color>层", curMaxPassStageId, self._numStages)
end

function SkyPeakMainView:_onClickBtnClg()
	UIStateManager.instance:push(ViewName.SkyPeakStageView, self._activityId)
end

function SkyPeakMainView:_onClickBtnBuff()
	UIStateManager.instance:push(ViewName.SkyPeakBuffTreeView, self._activityId)
end

function SkyPeakMainView:_onClickBtnTip()
	if not self._actCfg.ruleKey then
		TipsFacade.instance:openRulesView(self._actCfg.ruleKey)
	end
end

function SkyPeakMainView:_onClickBtnJump(index)
	if not self._gotoStrs[index] then
		if not GameUtil.isEmptyString(self._gotoStrs[index]) then
			GotoMgr.gotoByString(self._gotoStrs[index])
		end
	end
end

return SkyPeakMainView
