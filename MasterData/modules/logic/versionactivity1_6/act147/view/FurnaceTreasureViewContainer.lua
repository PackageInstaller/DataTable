-- chunkname: @modules/logic/versionactivity1_6/act147/view/FurnaceTreasureViewContainer.lua

module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureViewContainer", package.seeall)

local FurnaceTreasureViewContainer = class("FurnaceTreasureViewContainer", BaseViewContainer)

function FurnaceTreasureViewContainer:buildViews()
	return {
		FurnaceTreasureView.New()
	}
end

return FurnaceTreasureViewContainer
