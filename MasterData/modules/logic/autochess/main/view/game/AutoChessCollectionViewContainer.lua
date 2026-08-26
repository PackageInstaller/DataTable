-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCollectionViewContainer.lua

module("modules.logic.autochess.main.view.game.AutoChessCollectionViewContainer", package.seeall)

local AutoChessCollectionViewContainer = class("AutoChessCollectionViewContainer", BaseViewContainer)

function AutoChessCollectionViewContainer:buildViews()
	local views = {}

	table.insert(views, AutoChessCollectionView.New())

	return views
end

return AutoChessCollectionViewContainer
