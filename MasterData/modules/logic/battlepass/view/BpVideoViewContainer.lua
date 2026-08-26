-- chunkname: @modules/logic/battlepass/view/BpVideoViewContainer.lua

module("modules.logic.battlepass.view.BpVideoViewContainer", package.seeall)

local BpVideoViewContainer = class("BpVideoViewContainer", BaseViewContainer)

function BpVideoViewContainer:buildViews()
	return {
		BpVideoView.New()
	}
end

return BpVideoViewContainer
