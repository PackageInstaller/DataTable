-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/view/OriginPowersClgNormalResultView.lua

module("logic.extensions.originpowersclg.view.OriginPowersClgNormalResultView", package.seeall)

local OriginPowersClgNormalResultView = class("OriginPowersClgNormalResultView", ViewComponent)

function OriginPowersClgNormalResultView:ctor()
	OriginPowersClgNormalResultView.super.ctor(self)
end

function OriginPowersClgNormalResultView:unbindEvents()
	OriginPowersClgNormalResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnSure)
end

function OriginPowersClgNormalResultView:bindEvents()
	OriginPowersClgNormalResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
end

function OriginPowersClgNormalResultView:buildUI()
	OriginPowersClgNormalResultView.super.buildUI(self)

	self._txtTodayTime = self:getTxt("resultInfo/todayTime/txtTodayTime")
	self._txtCurTime = self:getTxt("resultInfo/curTime/txtCurTime")
	self._btnSure = self:getGo("btnSure")
end

function OriginPowersClgNormalResultView:onExit()
	OriginPowersClgNormalResultView.super.onExit(self)
end

function OriginPowersClgNormalResultView:onEnter()
	OriginPowersClgNormalResultView.super.onEnter(self)

	local resultInfo = OriginPowersClgModel.instance:getTempBattleResult()

	self._txtCurTime.text = resultInfo.buffNum

	local stageInfo = OriginPowersClgModel:getNormalStageInfo(resultInfo.activityId, resultInfo.index)

	self._txtTodayTime.text = stageInfo.buffNum
end

function OriginPowersClgNormalResultView:_onClickSure()
	OriginPowersClgModel.instance:resestBattleResult()
	BattleController.instance:endBattle()
end

return OriginPowersClgNormalResultView
