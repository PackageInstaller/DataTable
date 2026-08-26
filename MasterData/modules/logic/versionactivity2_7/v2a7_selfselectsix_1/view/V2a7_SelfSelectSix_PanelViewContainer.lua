-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_PanelViewContainer.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PanelViewContainer", package.seeall)

local V2a7_SelfSelectSix_PanelViewContainer = class("V2a7_SelfSelectSix_PanelViewContainer", BaseViewContainer)

function V2a7_SelfSelectSix_PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a7_SelfSelectSix_PanelView.New())

	return views
end

return V2a7_SelfSelectSix_PanelViewContainer
