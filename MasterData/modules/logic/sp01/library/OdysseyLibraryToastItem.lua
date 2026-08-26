-- chunkname: @modules/logic/sp01/library/OdysseyLibraryToastItem.lua

module("modules.logic.sp01.library.OdysseyLibraryToastItem", package.seeall)

local OdysseyLibraryToastItem = class("OdysseyLibraryToastItem", AssassinLibraryToastItem)

function OdysseyLibraryToastItem:init(go)
	OdysseyLibraryToastItem.super.init(self, go)
end

function OdysseyLibraryToastItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function OdysseyLibraryToastItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function OdysseyLibraryToastItem:_btnclickOnClick()
	return
end

return OdysseyLibraryToastItem
