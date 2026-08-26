-- chunkname: @modules/logic/seasonver/act166/view/Season166ResultViewContainer.lua

module("modules.logic.seasonver.act166.view.Season166ResultViewContainer", package.seeall)

local Season166ResultViewContainer = class("Season166ResultViewContainer", BaseViewContainer)

function Season166ResultViewContainer:buildViews()
	local views = {}

	table.insert(views, Season166ResultView.New())

	return views
end

return Season166ResultViewContainer
