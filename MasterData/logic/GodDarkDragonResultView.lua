-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddarkdragon/view/GodDarkDragonResultView.lua

module("logic.extensions.goddarkdragon.view.GodDarkDragonResultView", package.seeall)

local GodDarkDragonResultView = class("GodDarkDragonResultView", ViewComponent)

function GodDarkDragonResultView:ctor()
	GodDarkDragonResultView.super.ctor(self)
end

function GodDarkDragonResultView:unbindEvents()
	GodDarkDragonResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.rmClickHandler(self._btnRechallenge)
	GameUtil.rmClickHandler(self._btnClose)
end

function GodDarkDragonResultView:bindEvents()
	GodDarkDragonResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnRechallenge, self._onClickRechallenge, self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GodDarkDragonResultView:buildUI()
	GodDarkDragonResultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._btnRechallenge = self:getGo("btnRechallenge")
	self._txtResultMy_1 = self:getTxt("txtResultMy_1")
	self._txtResultMy_2 = self:getTxt("txtResultMy_2")
	self._txtResultEnemy_1 = self:getTxt("txtResultEnemy_1")
	self._txtResultEnemy_2 = self:getTxt("txtResultEnemy_2")
end

function GodDarkDragonResultView:onExit()
	GodDarkDragonResultView.super.onExit(self)
	BattleController.instance:endBattle()
end

function GodDarkDragonResultView:onEnter()
	GodDarkDragonResultView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.handlePM_GodDarkDragonBuffConfirmRes, self.close, self)

	local params = self:getOpenParam()

	self._actId = params[1]
	self._day = params[2]
	self._stageId = params[3]
	self._myBuffLimit = params[4]
	self._emenyBuffLimit = params[5]

	local stageCfg = GodDarkDragonConfig.instance:getBuffStageCfg(self._actId, self._day, self._stageId)

	self._txtResultMy_1.text = langPara("%s：<color=#147351FF>%d</color>", stageCfg.myBuffDesc, self._myBuffLimit)
	self._txtResultMy_2.text = langPara("己阵星宇限制：我方可上阵精灵%d只", self._myBuffLimit)
	self._txtResultEnemy_1.text = langPara("%s：<color=#147351FF>%d</color>", stageCfg.enemyBuffDesc, self._emenyBuffLimit)
	self._txtResultEnemy_2.text = langPara("敌阵星宇限制：敌方可上阵精灵%d只", self._emenyBuffLimit)
end

function GodDarkDragonResultView:_onClickSure()
	if self._emenyBuffLimit == 0 or self._myBuffLimit == 0 then
		FloatWordMgr.instance:show(lang("结果不可为0，请重新挑战"))
	else
		GodDarkDragonController.instance:sendPM_GodDarkDragonBuffConfirmReq(self._actId, true)
	end
end

function GodDarkDragonResultView:_onClickRechallenge()
	GodDarkDragonController.instance:sendPM_GodDarkDragonBuffConfirmReqByRechallenge(self._actId, false)
end

function GodDarkDragonResultView:_onClickClose()
	GodDarkDragonController.instance:sendPM_GodDarkDragonBuffConfirmReq(self._actId, false)
end

return GodDarkDragonResultView
