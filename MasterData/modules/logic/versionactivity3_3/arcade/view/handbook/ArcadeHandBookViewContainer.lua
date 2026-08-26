-- chunkname: @modules/logic/versionactivity3_3/arcade/view/handbook/ArcadeHandBookViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.handbook.ArcadeHandBookViewContainer", package.seeall)

local ArcadeHandBookViewContainer = class("ArcadeHandBookViewContainer", BaseViewContainer)

function ArcadeHandBookViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeHandBookView.New())
	table.insert(views, ArcadeHandBookInfoView.New())

	return views
end

return ArcadeHandBookViewContainer
