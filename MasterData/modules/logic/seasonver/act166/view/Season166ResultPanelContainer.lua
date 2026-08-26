-- chunkname: @modules/logic/seasonver/act166/view/Season166ResultPanelContainer.lua

module("modules.logic.seasonver.act166.view.Season166ResultPanelContainer", package.seeall)

local Season166ResultPanelContainer = class("Season166ResultPanelContainer", BaseViewContainer)

function Season166ResultPanelContainer:buildViews()
	local views = {}

	table.insert(views, Season166ResultPanel.New())

	return views
end

return Season166ResultPanelContainer
