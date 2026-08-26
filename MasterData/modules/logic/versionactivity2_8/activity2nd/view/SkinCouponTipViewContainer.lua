-- chunkname: @modules/logic/versionactivity2_8/activity2nd/view/SkinCouponTipViewContainer.lua

module("modules.logic.versionactivity2_8.activity2nd.view.SkinCouponTipViewContainer", package.seeall)

local SkinCouponTipViewContainer = class("SkinCouponTipViewContainer", BaseViewContainer)

function SkinCouponTipViewContainer:buildViews()
	local views = {}

	table.insert(views, SkinCouponTipView.New())

	return views
end

return SkinCouponTipViewContainer
