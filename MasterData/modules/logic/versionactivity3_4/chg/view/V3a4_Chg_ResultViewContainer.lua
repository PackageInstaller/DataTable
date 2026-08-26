-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_ResultViewContainer.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_ResultViewContainer", package.seeall)

local V3a4_Chg_ResultViewContainer = class("V3a4_Chg_ResultViewContainer", ChgViewBaseContainer)

function V3a4_Chg_ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4_Chg_ResultView.New())

	return views
end

return V3a4_Chg_ResultViewContainer
