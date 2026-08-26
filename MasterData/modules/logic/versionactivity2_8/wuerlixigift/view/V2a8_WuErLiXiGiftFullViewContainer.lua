-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/view/V2a8_WuErLiXiGiftFullViewContainer.lua

module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftFullViewContainer", package.seeall)

local V2a8_WuErLiXiGiftFullViewContainer = class("V2a8_WuErLiXiGiftFullViewContainer", BaseViewContainer)

function V2a8_WuErLiXiGiftFullViewContainer:buildViews()
	return {
		V2a8_WuErLiXiGiftFullView.New()
	}
end

return V2a8_WuErLiXiGiftFullViewContainer
