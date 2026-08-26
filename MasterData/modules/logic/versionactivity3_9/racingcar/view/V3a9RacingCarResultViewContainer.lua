-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarResultViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarResultViewContainer", package.seeall)

local V3a9RacingCarResultViewContainer = class("V3a9RacingCarResultViewContainer", BaseViewContainer)

function V3a9RacingCarResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarResultView.New())

	return views
end

return V3a9RacingCarResultViewContainer
