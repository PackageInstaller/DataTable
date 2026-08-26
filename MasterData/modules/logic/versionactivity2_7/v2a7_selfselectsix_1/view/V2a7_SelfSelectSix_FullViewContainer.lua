-- chunkname: @modules/logic/versionactivity2_7/v2a7_selfselectsix_1/view/V2a7_SelfSelectSix_FullViewContainer.lua

module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_FullViewContainer", package.seeall)

local V2a7_SelfSelectSix_FullViewContainer = class("V2a7_SelfSelectSix_FullViewContainer", BaseViewContainer)

function V2a7_SelfSelectSix_FullViewContainer:buildViews()
	local views = {}

	table.insert(views, V2a7_SelfSelectSix_FullView.New())

	return views
end

return V2a7_SelfSelectSix_FullViewContainer
