-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/lightking/LightKingCareerView.lua

module("logic.extensions.timelimitedchallenge.view.lightking.LightKingCareerView", package.seeall)

local LightKingCareerView = class("LightKingCareerView", ViewComponent)

function LightKingCareerView:ctor()
	LightKingCareerView.super.ctor(self)
end

function LightKingCareerView:destroyUI()
	LightKingCareerView.super.destroyUI(self)
end

function LightKingCareerView:onExitFinished()
	LightKingCareerView.super.onExitFinished(self)
end

function LightKingCareerView:onEnterFinished()
	LightKingCareerView.super.onEnterFinished(self)
end

function LightKingCareerView:unbindEvents()
	LightKingCareerView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function LightKingCareerView:bindEvents()
	LightKingCareerView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
end

function LightKingCareerView:onExit()
	LightKingCareerView.super.onExit(self)
end

function LightKingCareerView:buildUI()
	LightKingCareerView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
end

function LightKingCareerView:onEnter()
	LightKingCareerView.super.onEnter(self)
end

function LightKingCareerView:_onClickClose()
	self:close()
end

return LightKingCareerView
