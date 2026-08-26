-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameOpenEffectViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameOpenEffectViewContainer", package.seeall)

local AiZiLaGameOpenEffectViewContainer = class("AiZiLaGameOpenEffectViewContainer", BaseViewContainer)

function AiZiLaGameOpenEffectViewContainer:buildViews()
	local views = {}

	self._gameEffectView = AiZiLaGameOpenEffectView.New()

	table.insert(views, self._gameEffectView)

	return views
end

function AiZiLaGameOpenEffectViewContainer:playViewAnimator(animName)
	self._gameEffectView:playViewAnimator(animName)
end

function AiZiLaGameOpenEffectViewContainer:startViewOpenBlock()
	return
end

function AiZiLaGameOpenEffectViewContainer:startViewCloseBlock()
	return
end

return AiZiLaGameOpenEffectViewContainer
