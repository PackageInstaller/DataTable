-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameResultViewContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameResultViewContainer", package.seeall)

local AiZiLaGameResultViewContainer = class("AiZiLaGameResultViewContainer", BaseViewContainer)

function AiZiLaGameResultViewContainer:buildViews()
	local views = {}

	self._resultView = AiZiLaGameResultView.New()

	table.insert(views, self._resultView)

	return views
end

return AiZiLaGameResultViewContainer
