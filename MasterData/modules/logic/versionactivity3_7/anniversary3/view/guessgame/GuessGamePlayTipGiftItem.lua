-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayTipGiftItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayTipGiftItem", package.seeall)

local GuessGamePlayTipGiftItem = class("GuessGamePlayTipGiftItem", LuaCompBase)

function GuessGamePlayTipGiftItem:init(go)
	self.go = go
	self._imagegift = gohelper.findChildImage(self.go, "image_gift")
	self._txtnum = gohelper.findChildText(self.go, "txt_num")

	gohelper.setActive(self.go, true)
end

function GuessGamePlayTipGiftItem:refresh(mo)
	self._mo = mo
	self._config = Activity234Config.instance:getBoxGiftCo(self._mo[1])

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagegift, self._config.iconsmall)
	self:refreshCount()
end

function GuessGamePlayTipGiftItem:refreshCount()
	local unlockCount = GuessGameModel.instance:getGiftUnlockCount(self._mo[1])

	self._txtnum.text = self._mo[2] - unlockCount
end

function GuessGamePlayTipGiftItem:destroy()
	return
end

return GuessGamePlayTipGiftItem
