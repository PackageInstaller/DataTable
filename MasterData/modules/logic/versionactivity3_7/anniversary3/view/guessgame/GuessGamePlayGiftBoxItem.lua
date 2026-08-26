-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayGiftBoxItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayGiftBoxItem", package.seeall)

local GuessGamePlayGiftBoxItem = class("GuessGamePlayGiftBoxItem", LuaCompBase)

function GuessGamePlayGiftBoxItem:init(go)
	self.go = go
	self._imageicon = gohelper.findChildImage(self.go, "image_icon")
	self._txtcount = gohelper.findChild(self.go, "txt_count")

	gohelper.setActive(self.go, true)
	self:_addEvents()
end

function GuessGamePlayGiftBoxItem:_addEvents()
	return
end

function GuessGamePlayGiftBoxItem:_removeEvents()
	return
end

function GuessGamePlayGiftBoxItem:refresh(mo)
	self._mo = mo
end

function GuessGamePlayGiftBoxItem:destroy()
	self:_removeEvents()
end

return GuessGamePlayGiftBoxItem
