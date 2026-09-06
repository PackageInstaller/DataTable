-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmmclg/view/OriginDarkMMClgFmtView.lua

module("logic.extensions.origindarkmmclg.view.OriginDarkMMClgFmtView", package.seeall)

local OriginDarkMMClgFmtView = class("OriginDarkMMClgFmtView", ViewComponent)

function OriginDarkMMClgFmtView:ctor()
	OriginDarkMMClgFmtView.super.ctor(self)
end

function OriginDarkMMClgFmtView:unbindEvents()
	OriginDarkMMClgFmtView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btn, self)
end

function OriginDarkMMClgFmtView:bindEvents()
	OriginDarkMMClgFmtView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btn, self._onClickBtn, self)
end

function OriginDarkMMClgFmtView:buildUI()
	OriginDarkMMClgFmtView.super.buildUI(self)

	self._btn = self:getGo("btn")
	self._effRoot = self:getGo("btn/effRoot")
end

function OriginDarkMMClgFmtView:onExit()
	OriginDarkMMClgFmtView.super.onExit(self)
end

function OriginDarkMMClgFmtView:onEnter()
	OriginDarkMMClgFmtView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_NotifyAssignActionValue, self._showEffect, self)

	self._fmtMo = self:getFirstParam()
	self._activityId = self._fmtMo:getActivityId()
	self._stageId = self._fmtMo:getStageId()
end

function OriginDarkMMClgFmtView:_onClickBtn()
	UIStateManager.instance:push(ViewName.OriginDarkMMClgActionValueView, self._fmtMo)
end

function OriginDarkMMClgFmtView:_showEffect()
	self:playViewEffectUniGo("common/fx_ui_zhiyin_quan_03.prefab", self._effRoot, self._effRoot, false)
end

return OriginDarkMMClgFmtView
