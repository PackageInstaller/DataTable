-- chunkname: @modules/logic/versionactivity3_9/bducklinkage/view/V3a9_BDuckLinkagePatFaceViewContainer.lua

module("modules.logic.versionactivity3_9.bducklinkage.view.V3a9_BDuckLinkagePatFaceViewContainer", package.seeall)

local V3a9_BDuckLinkagePatFaceViewContainer = class("V3a9_BDuckLinkagePatFaceViewContainer", V3a9_BDuckLinkageBaseViewContainer)

function V3a9_BDuckLinkagePatFaceViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a9_BDuckLinkagePatFaceView.New())

	return views
end

return V3a9_BDuckLinkagePatFaceViewContainer
