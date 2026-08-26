-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftBuyTipViewContainer.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftBuyTipViewContainer", package.seeall)

local NationalGiftBuyTipViewContainer = class("NationalGiftBuyTipViewContainer", BaseViewContainer)

function NationalGiftBuyTipViewContainer:buildViews()
	return {
		NationalGiftBuyTipView.New()
	}
end

return NationalGiftBuyTipViewContainer
