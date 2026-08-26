-- chunkname: @modules/logic/battlepass/view/BPSPFaceViewContainer.lua

module("modules.logic.battlepass.view.BPSPFaceViewContainer", package.seeall)

local BPSPFaceViewContainer = class("BPSPFaceViewContainer", BaseViewContainer)

function BPSPFaceViewContainer:buildViews()
	return {
		BPSPFaceView.New()
	}
end

return BPSPFaceViewContainer
