-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142GetCollectionViewContainer.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142GetCollectionViewContainer", package.seeall)

local Activity142GetCollectionViewContainer = class("Activity142GetCollectionViewContainer", BaseViewContainer)

function Activity142GetCollectionViewContainer:buildViews()
	return {
		Activity142GetCollectionView.New()
	}
end

return Activity142GetCollectionViewContainer
