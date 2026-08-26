-- chunkname: @modules/logic/versionactivity3_4/chg/view/V3a4_Chg_GameStartViewContainer.lua

module("modules.logic.versionactivity3_4.chg.view.V3a4_Chg_GameStartViewContainer", package.seeall)

local V3a4_Chg_GameStartViewContainer = class("V3a4_Chg_GameStartViewContainer", ChgViewBaseContainer)

function V3a4_Chg_GameStartViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a4_Chg_GameStartView.New())

	return views
end

return V3a4_Chg_GameStartViewContainer
