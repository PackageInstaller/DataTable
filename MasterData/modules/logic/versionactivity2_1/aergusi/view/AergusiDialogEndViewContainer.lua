-- chunkname: @modules/logic/versionactivity2_1/aergusi/view/AergusiDialogEndViewContainer.lua

module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogEndViewContainer", package.seeall)

local AergusiDialogEndViewContainer = class("AergusiDialogEndViewContainer", BaseViewContainer)

function AergusiDialogEndViewContainer:buildViews()
	local views = {}

	table.insert(views, AergusiDialogEndView.New())

	return views
end

return AergusiDialogEndViewContainer
