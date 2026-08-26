-- chunkname: @modules/logic/versionactivity3_7/wmz/view/V3a7_Wmz_ResultViewContainer.lua

module("modules.logic.versionactivity3_7.wmz.view.V3a7_Wmz_ResultViewContainer", package.seeall)

local V3a7_Wmz_ResultViewContainer = class("V3a7_Wmz_ResultViewContainer", WmzViewBaseContainer)

function V3a7_Wmz_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a7_Wmz_ResultView.New())

	return views
end

return V3a7_Wmz_ResultViewContainer
