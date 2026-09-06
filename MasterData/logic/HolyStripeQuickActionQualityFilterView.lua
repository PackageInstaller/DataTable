-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionQualityFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionQualityFilterView", package.seeall)

local HolyStripeQuickActionQualityFilterView = class("HolyStripeQuickActionQualityFilterView", HolyStripeQualityFilterView)

function HolyStripeQuickActionQualityFilterView:_onClickPosBtn(posType)
	GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.Quality, posType)
	self:close()
end

return HolyStripeQuickActionQualityFilterView
