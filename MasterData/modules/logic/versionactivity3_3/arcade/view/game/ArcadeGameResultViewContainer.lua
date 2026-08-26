-- chunkname: @modules/logic/versionactivity3_3/arcade/view/game/ArcadeGameResultViewContainer.lua

module("modules.logic.versionactivity3_3.arcade.view.game.ArcadeGameResultViewContainer", package.seeall)

local ArcadeGameResultViewContainer = class("ArcadeGameResultViewContainer", BaseViewContainer)

function ArcadeGameResultViewContainer:buildViews()
	local views = {}

	table.insert(views, ArcadeGameResultView.New())

	return views
end

return ArcadeGameResultViewContainer
