-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/ultimatewar/view/UltimateWarTowerBossResultPopView.lua

module("logic.extensions.ultimatewar.view.UltimateWarTowerBossResultPopView", package.seeall)

local UltimateWarTowerBossResultPopView = class("UltimateWarTowerBossResultPopView", ViewComponent)

function UltimateWarTowerBossResultPopView:buildUI()
	UltimateWarTowerBossResultPopView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtCurDamage = self:getTxt("txtCurDamage")
	self._txtMaxDamage = self:getTxt("txtMaxDamage")
	self._tips = self:getGo("tips")
	self._btnPush = self:getGo("tips/btnPush")
	self._txtDesc = self:getTxt("tips/bubble/txtDesc")
	self._strTxtDesc = self._txtDesc.text
end

function UltimateWarTowerBossResultPopView:bindEvents()
	UltimateWarTowerBossResultPopView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._endBattle, self)
	GameUtil.addClickHandler(self._btnSure, self._endBattle, self)
	GameUtil.addClickHandler(self._btnPush, self._onClickBtnPush, self)
end

function UltimateWarTowerBossResultPopView:unbindEvents()
	UltimateWarTowerBossResultPopView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnPush)
end

function UltimateWarTowerBossResultPopView:onEnter()
	UltimateWarTowerBossResultPopView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local mo = UltimateWarController.instance:getUltimateWarMo(self._activityId)
	local msg = mo:getTowerBossMsg()

	self._isHasPush = false

	self.addGEvent(self, GlobalNotify.HandlePM_UltimateWarSubmitTowerBossFormRes, self._handlePM_UltimateWarSubmitTowerBossFormRes, self)

	self._txtCurDamage.text = string.format("%d", msg.curDamage)
	self._txtMaxDamage.text = string.format("%d", msg.bossMaxDamage)

	GameUtil.SetActive(self._tips, msg.canSubmitForm)
	GameUtil.SetGray(self._btnPush, false)

	local rank = UltimateWarConfig.instance:getSecondStepSubmitFormRank(self._activityId)

	self._txtDesc.text = string.format(self._strTxtDesc, rank)
end

function UltimateWarTowerBossResultPopView:onExit()
	UltimateWarTowerBossResultPopView.super.onExit(self)
end

function UltimateWarTowerBossResultPopView:_handlePM_UltimateWarSubmitTowerBossFormRes()
	self._isHasPush = true

	GameUtil.SetGray(self._btnPush, true)
end

function UltimateWarTowerBossResultPopView:_endBattle()
	BattleController.instance:endBattle()
end

function UltimateWarTowerBossResultPopView:_onClickBtnPush()
	if self._isHasPush then
		FloatWordMgr.instance:show("已分享")

		return
	end

	local rank = UltimateWarConfig.instance:getSecondStepSubmitFormRank(self._activityId)
	local tipsContent = string.format("恭喜您本次对BOSS的伤害刷新前%s名的记录，\n是否将本次挑战的阵容分享给全服奥奇参考？", rank)

	local function okFunc()
		UltimateWarController.instance:sendPM_UltimateWarSubmitTowerBossFormReq(self._activityId)
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, nil, "确定", "取消")
end

return UltimateWarTowerBossResultPopView
