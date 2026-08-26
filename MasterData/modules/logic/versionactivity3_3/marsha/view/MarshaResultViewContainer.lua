-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaResultViewContainer.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaResultViewContainer", package.seeall)

local MarshaResultViewContainer = class("MarshaResultViewContainer", BaseViewContainer)

function MarshaResultViewContainer:buildViews()
	local views = {}

	table.insert(views, MarshaResultView.New())

	return views
end

return MarshaResultViewContainer
