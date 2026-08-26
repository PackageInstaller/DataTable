-- chunkname: @modules/logic/battlepass/view/BpReceiveRewardViewContainer.lua

module("modules.logic.battlepass.view.BpReceiveRewardViewContainer", package.seeall)

local BpReceiveRewardViewContainer = class("BpReceiveRewardViewContainer", BaseViewContainer)

function BpReceiveRewardViewContainer:buildViews()
	return {
		BpReceiveRewardView.New()
	}
end

return BpReceiveRewardViewContainer
