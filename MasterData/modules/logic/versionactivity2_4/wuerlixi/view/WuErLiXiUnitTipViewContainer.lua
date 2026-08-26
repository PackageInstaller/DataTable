-- chunkname: @modules/logic/versionactivity2_4/wuerlixi/view/WuErLiXiUnitTipViewContainer.lua

module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiUnitTipViewContainer", package.seeall)

local WuErLiXiUnitTipViewContainer = class("WuErLiXiUnitTipViewContainer", BaseViewContainer)

function WuErLiXiUnitTipViewContainer:buildViews()
	return {
		WuErLiXiUnitTipView.New()
	}
end

return WuErLiXiUnitTipViewContainer
