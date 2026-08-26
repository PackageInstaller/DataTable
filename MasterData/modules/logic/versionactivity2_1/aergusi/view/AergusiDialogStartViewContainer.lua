-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogStartViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogStartViewContainer", package.seeall)

local AergusiDialogStartViewContainer = class("AergusiDialogStartViewContainer", BaseViewContainer)

function AergusiDialogStartViewContainer:buildViews()
	local views = {}

	table.insert(views, AergusiDialogStartView.New())

	return views
end

return AergusiDialogStartViewContainer
