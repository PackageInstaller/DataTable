-- chunkname: @modules/logic/versionactivity1_9/semmelweisgift/view/SemmelWeisGiftMainBtnItem.lua

module("modules.logic.versionactivity1_9.semmelweisgift.view.SemmelWeisGiftMainBtnItem", package.seeall)

local SemmelWeisGiftMainBtnItem = class("SemmelWeisGiftMainBtnItem", Activity101SignViewBtnBase)

function SemmelWeisGiftMainBtnItem:onRefresh()
	self:_setMainSprite("v1a6_act_icon3")
end

function SemmelWeisGiftMainBtnItem:onClick()
	local viewName, _ = self:onGetViewNameAndParam()

	if ViewMgr.instance:isOpen(viewName) then
		return
	end

	SemmelWeisGiftController.instance:openSemmelWeisGiftView()
end

return SemmelWeisGiftMainBtnItem
