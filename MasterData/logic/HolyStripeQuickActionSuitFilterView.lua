-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionSuitFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionSuitFilterView", package.seeall)

local HolyStripeQuickActionSuitFilterView = class("HolyStripeQuickActionSuitFilterView", HolyStripeSuitFilterView)

function HolyStripeQuickActionSuitFilterView:_onItemClick(itemType)
	GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.Suit, itemType)
	self:close()
end

return HolyStripeQuickActionSuitFilterView
