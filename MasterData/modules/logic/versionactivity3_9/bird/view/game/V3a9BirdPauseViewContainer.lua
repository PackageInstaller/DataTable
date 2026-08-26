-- chunkname: @modules/logic/versionactivity3_9/bird/view/game/V3a9BirdPauseViewContainer.lua

module("modules.logic.versionactivity3_9.bird.view.game.V3a9BirdPauseViewContainer", package.seeall)

local V3a9BirdPauseViewContainer = class("V3a9BirdPauseViewContainer", BaseViewContainer)

function V3a9BirdPauseViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9BirdPauseView.New())

	return views
end

return V3a9BirdPauseViewContainer
