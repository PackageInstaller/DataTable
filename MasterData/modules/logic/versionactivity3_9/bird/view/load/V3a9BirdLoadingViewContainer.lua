-- chunkname: @modules/logic/versionactivity3_9/bird/view/load/V3a9BirdLoadingViewContainer.lua

module("modules.logic.versionactivity3_9.bird.view.load.V3a9BirdLoadingViewContainer", package.seeall)

local V3a9BirdLoadingViewContainer = class("V3a9BirdLoadingViewContainer", BaseViewContainer)

function V3a9BirdLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9BirdLoadingView.New())

	return views
end

return V3a9BirdLoadingViewContainer
