-- chunkname: @modules/logic/versionactivity2_8/wuerlixigift/view/V2a8_WuErLiXiGiftMainBtnItem.lua

module("modules.logic.versionactivity2_8.wuerlixigift.view.V2a8_WuErLiXiGiftMainBtnItem", package.seeall)

local V2a8_WuErLiXiGiftMainBtnItem = class("V2a8_WuErLiXiGiftMainBtnItem", Activity101SignViewBtnBase)

function V2a8_WuErLiXiGiftMainBtnItem:onRefresh()
	self:_setMainSprite("v1a6_act_icon3")
end

function V2a8_WuErLiXiGiftMainBtnItem:onClick()
	local viewName, _ = self:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	V2a8_WuErLiXiGiftController.instance:openV2a8_WuErLiXiGiftView()
end

return V2a8_WuErLiXiGiftMainBtnItem
