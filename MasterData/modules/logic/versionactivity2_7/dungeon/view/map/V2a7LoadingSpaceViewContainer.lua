-- chunkname: @modules/logic/versionactivity2_7/dungeon/view/map/V2a7LoadingSpaceViewContainer.lua

module("modules.logic.versionactivity2_7.dungeon.view.map.V2a7LoadingSpaceViewContainer", package.seeall)

local V2a7LoadingSpaceViewContainer = class("V2a7LoadingSpaceViewContainer", BaseViewContainer)

function V2a7LoadingSpaceViewContainer:buildViews()
	return {
		V2a7LoadingSpaceView.New()
	}
end

return V2a7LoadingSpaceViewContainer
