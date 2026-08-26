-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseTripleDropFullViewContainer.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseTripleDropFullViewContainer", package.seeall)

local CruiseTripleDropFullViewContainer = class("CruiseTripleDropFullViewContainer", BaseViewContainer)

function CruiseTripleDropFullViewContainer:buildViews()
	local views = {}

	table.insert(views, CruiseTripleDropFullView.New())

	return views
end

return CruiseTripleDropFullViewContainer
