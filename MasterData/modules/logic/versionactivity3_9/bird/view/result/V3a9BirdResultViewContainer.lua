-- chunkname: @modules/logic/versionactivity3_9/bird/view/result/V3a9BirdResultViewContainer.lua

module("modules.logic.versionactivity3_9.bird.view.result.V3a9BirdResultViewContainer", package.seeall)

local V3a9BirdResultViewContainer = class("V3a9BirdResultViewContainer", BaseViewContainer)

function V3a9BirdResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9BirdResultView.New())

	return views
end

return V3a9BirdResultViewContainer
