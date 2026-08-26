-- chunkname: @modules/logic/gm/view/GM_ArcadeViewContainer.lua

module("modules.logic.gm.view.GM_ArcadeViewContainer", package.seeall)

local GM_ArcadeViewContainer = class("GM_ArcadeViewContainer", BaseViewContainer)

function GM_ArcadeViewContainer:buildViews()
	local views = {}

	table.insert(views, GM_ArcadeView.New())

	return views
end

return GM_ArcadeViewContainer
