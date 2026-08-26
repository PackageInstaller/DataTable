-- chunkname: @modules/logic/battlepass/view/BPFaceViewContainer.lua

module("modules.logic.battlepass.view.BPFaceViewContainer", package.seeall)

local BPFaceViewContainer = class("BPFaceViewContainer", BaseViewContainer)

function BPFaceViewContainer:buildViews()
	return {
		BPFaceView.New()
	}
end

return BPFaceViewContainer
