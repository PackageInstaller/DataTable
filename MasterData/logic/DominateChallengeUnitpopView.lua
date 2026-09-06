-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingdragonchallenge/view/dominatechallenge/DominateChallengeUnitpopView.lua

module("logic.extensions.kingdragonchallenge.view.dominatechallenge.DominateChallengeUnitpopView", package.seeall)

local DominateChallengeUnitpopView = class("DominateChallengeUnitpopView", KdChallengeUnitPopView)

function DominateChallengeUnitpopView:ctor()
	DominateChallengeUnitpopView.super.ctor(self)
end

function DominateChallengeUnitpopView:unbindEvents()
	DominateChallengeUnitpopView.super.unbindEvents(self)
end

function DominateChallengeUnitpopView:bindEvents()
	DominateChallengeUnitpopView.super.bindEvents(self)
end

function DominateChallengeUnitpopView:onExit()
	DominateChallengeUnitpopView.super.onExit(self)
end

function DominateChallengeUnitpopView:buildUI()
	DominateChallengeUnitpopView.super.buildUI(self)
end

function DominateChallengeUnitpopView:onEnter()
	self._challengeId = KdChallengeConfig.instance:getNuoyaCurChallengeId()

	self:_onSetUI()
	self:_onUpdate()
	GlobalDispatcher:addListener(GlobalNotify.KDChallengeResultConfirmRes, self._handleConfirmRes, self)
end

return DominateChallengeUnitpopView
