-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonlords/view/DragonOverChallengView.lua

module("logic.extensions.dragonlords.view.DragonOverChallengView", package.seeall)

local DragonOverChallengView = class("DragonOverChallengView", ViewComponent)

function DragonOverChallengView:ctor()
	DragonOverChallengView.super.ctor(self)
end

function DragonOverChallengView:unbindEvents()
	DragonOverChallengView.super.unbindEvents(self)
	self._btn:RemoveClickListener()
end

function DragonOverChallengView:bindEvents()
	DragonOverChallengView.super.bindEvents(self)
	self._btn:AddClickListener(function()
		self:close()
	end)
end

function DragonOverChallengView:onExit()
	DragonOverChallengView.super.onExit(self)
	BattleController.instance:endBattle()
end

function DragonOverChallengView:buildUI()
	DragonOverChallengView.super.buildUI(self)

	self._btn = self:getBtn("btn")
	self._score = self:getTxt("score/txt")
end

function DragonOverChallengView:onEnter()
	DragonOverChallengView.super.onEnter(self)

	local info = DrogonLordsModel.instance:getNormalChallengeEnd()

	self._score.text = info.curScore .. "积分"

	local msg = {}

	DrogonLordsModel.instance:setNormalChallengeEnd(msg)
end

return DragonOverChallengView
