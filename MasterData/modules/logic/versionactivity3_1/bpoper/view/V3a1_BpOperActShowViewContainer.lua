-- chunkname: @modules/logic/versionactivity3_1/bpoper/view/V3a1_BpOperActShowViewContainer.lua

module("modules.logic.versionactivity3_1.bpoper.view.V3a1_BpOperActShowViewContainer", package.seeall)

local V3a1_BpOperActShowViewContainer = class("V3a1_BpOperActShowViewContainer", BaseViewContainer)

function V3a1_BpOperActShowViewContainer:buildViews()
	local views = {}

	table.insert(views, V3a1_BpOperActShowView.New())

	return views
end

return V3a1_BpOperActShowViewContainer
