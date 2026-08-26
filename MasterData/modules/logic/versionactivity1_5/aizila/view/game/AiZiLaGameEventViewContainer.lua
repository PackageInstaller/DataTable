-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameEventViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventViewContainer", package.seeall)

local AiZiLaGameEventViewContainer = class("AiZiLaGameEventViewContainer", BaseViewContainer)

function AiZiLaGameEventViewContainer:buildViews()
	local views = {}

	self._gameEventview = AiZiLaGameEventView.New()

	table.insert(views, self._gameEventview)

	return views
end

function AiZiLaGameEventViewContainer:playViewAnimator(animName)
	self._gameEventview:playViewAnimator(animName)
end

return AiZiLaGameEventViewContainer
