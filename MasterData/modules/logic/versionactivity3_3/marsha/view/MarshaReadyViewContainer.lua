-- chunkname: @modules/logic/versionactivity3_3/marsha/view/MarshaReadyViewContainer.lua

module("modules.logic.versionactivity3_3.marsha.view.MarshaReadyViewContainer", package.seeall)

local MarshaReadyViewContainer = class("MarshaReadyViewContainer", BaseViewContainer)

function MarshaReadyViewContainer:buildViews()
	local views = {}

	table.insert(views, MarshaReadyView.New())

	return views
end

return MarshaReadyViewContainer
