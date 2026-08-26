-- chunkname: @modules/logic/versionactivity2_2/act173/view/Activity173PanelViewContainer.lua

module("modules.logic.versionactivity2_2.act173.view.Activity173PanelViewContainer", package.seeall)

local Activity173PanelViewContainer = class("Activity173PanelViewContainer", BaseViewContainer)

function Activity173PanelViewContainer:buildViews()
	local views = {}

	table.insert(views, Activity173PanelView.New())

	return views
end

return Activity173PanelViewContainer
