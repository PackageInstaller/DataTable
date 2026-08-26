-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkageBaseViewContainer.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkageBaseViewContainer", package.seeall)

local V3a9_BDuckLinkageBaseViewContainer = class("V3a9_BDuckLinkageBaseViewContainer", BaseViewContainer)

function V3a9_BDuckLinkageBaseViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BDuckLinkageBaseView.New())

	return views
end

return V3a9_BDuckLinkageBaseViewContainer
