-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkageFullViewContainer.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkageFullViewContainer", package.seeall)

local V3a9_BDuckLinkageFullViewContainer = class("V3a9_BDuckLinkageFullViewContainer", V3a9_BDuckLinkageBaseViewContainer)

function V3a9_BDuckLinkageFullViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BDuckLinkageFullView.New())

	return views
end

return V3a9_BDuckLinkageFullViewContainer
