-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originan/view/OriginAnNormalResultView.lua

module("logic.extensions.originan.view.OriginAnNormalResultView", package.seeall)

local OriginAnNormalResultView = class("OriginAnNormalResultView", ViewComponent)

function OriginAnNormalResultView:buildUI()
	OriginAnNormalResultView.super.buildUI(self)

	self._txtCur = self:getTxt("txtCur")
	self._txtHistory = self:getTxt("txtHistory")
	self._btnSure = self:getGo("btnSure")
end

function OriginAnNormalResultView:bindEvents()
	OriginAnNormalResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OriginAnNormalResultView:unbindEvents()
	OriginAnNormalResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginAnNormalResultView:onEnter()
	OriginAnNormalResultView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local msg = params[1]

	self._activityId = msg.activityId
	self._stageId = msg.stageId
	self._blockHealTimes = msg.blockHealTimes
	self._subMo = OriginAnController.instance:getSubMo(self._activityId)
	self._txtCur.text = self._blockHealTimes
	self._txtHistory.text = self._subMo:getNormalStageMaxBlockHealTimes(self._stageId)
end

function OriginAnNormalResultView:onExit()
	OriginAnNormalResultView.super.onExit(self)
end

function OriginAnNormalResultView:_onClickSure()
	self:close()
	BattleController.instance:endBattle()
end

return OriginAnNormalResultView
