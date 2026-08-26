-- chunkname: @modules/logic/battlepass/view/BpBonusSelectViewContainer.lua

module("modules.logic.battlepass.view.BpBonusSelectViewContainer", package.seeall)

local BpBonusSelectViewContainer = class("BpBonusSelectViewContainer", BaseViewContainer)

function BpBonusSelectViewContainer:buildViews()
	return {
		BpBonusSelectView.New()
	}
end

return BpBonusSelectViewContainer
