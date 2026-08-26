-- chunkname: @modules/logic/battlepass/view/BpLevelupTipViewContainer.lua

module("modules.logic.battlepass.view.BpLevelupTipViewContainer", package.seeall)

local BpLevelupTipViewContainer = class("BpLevelupTipViewContainer", BaseViewContainer)

function BpLevelupTipViewContainer:buildViews()
	return {
		BpLevelupTipView.New()
	}
end

return BpLevelupTipViewContainer
