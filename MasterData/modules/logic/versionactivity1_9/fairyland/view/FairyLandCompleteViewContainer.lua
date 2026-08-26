-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/FairyLandCompleteViewContainer.lua

module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteViewContainer", package.seeall)

local FairyLandCompleteViewContainer = class("FairyLandCompleteViewContainer", BaseViewContainer)

function FairyLandCompleteViewContainer:buildViews()
	local views = {}

	table.insert(views, FairyLandCompleteView.New())

	return views
end

return FairyLandCompleteViewContainer
