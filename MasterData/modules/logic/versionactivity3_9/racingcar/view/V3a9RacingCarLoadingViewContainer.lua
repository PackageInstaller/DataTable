-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarLoadingViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarLoadingViewContainer", package.seeall)

local V3a9RacingCarLoadingViewContainer = class("V3a9RacingCarLoadingViewContainer", BaseViewContainer)

function V3a9RacingCarLoadingViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarLoadingView.New())

	return views
end

return V3a9RacingCarLoadingViewContainer
