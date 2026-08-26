-- chunkname: @modules/logic/versionactivity3_9/racingcar/view/V3a9RacingCarRecordViewContainer.lua

module("modules.logic.versionactivity3_9.racingcar.view.V3a9RacingCarRecordViewContainer", package.seeall)

local V3a9RacingCarRecordViewContainer = class("V3a9RacingCarRecordViewContainer", BaseViewContainer)

function V3a9RacingCarRecordViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9RacingCarRecordView.New())

	return views
end

return V3a9RacingCarRecordViewContainer
