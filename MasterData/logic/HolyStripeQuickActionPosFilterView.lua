-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holystripe/view/HolyStripeQuickActionPosFilterView.lua

module("logic.extensions.holystripe.view.HolyStripeQuickActionPosFilterView", package.seeall)

local HolyStripeQuickActionPosFilterView = class("HolyStripeQuickActionPosFilterView", HolyStripePosFilterView)

function HolyStripeQuickActionPosFilterView:_onClickPosBtn(posType)
	GlobalDispatcher:dispatch(HolyStripeQuickActionFilterEvent.Pos, posType)
	self:close()
end

return HolyStripeQuickActionPosFilterView
