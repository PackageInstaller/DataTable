-- chunkname: @modules/logic/versionactivity1_5/aizila/view/game/AiZiLaGameEventResultContainer.lua

module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGameEventResultContainer", package.seeall)

local AiZiLaGameEventResultContainer = class("AiZiLaGameEventResultContainer", BaseViewContainer)

function AiZiLaGameEventResultContainer:buildViews()
	local views = {}

	table.insert(views, AiZiLaGameEventResult.New())

	return views
end

return AiZiLaGameEventResultContainer
