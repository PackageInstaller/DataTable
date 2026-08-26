-- chunkname: @modules/logic/versionactivity3_7/selfselect/view/V3a7SelfSelectFullViewContainer.lua

module("modules.logic.versionactivity3_7.selfselect.view.V3a7SelfSelectFullViewContainer", package.seeall)

local V3a7SelfSelectFullViewContainer = class("V3a7SelfSelectFullViewContainer", BaseViewContainer)

function V3a7SelfSelectFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a7SelfSelectFullView.New())

	return views
end

return V3a7SelfSelectFullViewContainer
