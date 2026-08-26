-- chunkname: @modules/logic/versionactivity1_6/act147/view/FurnaceTreasureBuyViewContainer.lua

module("modules.logic.versionactivity1_6.act147.view.FurnaceTreasureBuyViewContainer", package.seeall)

local FurnaceTreasureBuyViewContainer = class("FurnaceTreasureBuyViewContainer", BaseViewContainer)

function FurnaceTreasureBuyViewContainer:buildViews()
	return {
		FurnaceTreasureBuyView.New()
	}
end

return FurnaceTreasureBuyViewContainer
