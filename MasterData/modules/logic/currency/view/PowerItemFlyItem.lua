-- chunkname: @modules/logic/currency/view/PowerItemFlyItem.lua

module("modules.logic.currency.view.PowerItemFlyItem", package.seeall)

local PowerItemFlyItem = class("PowerItemFlyItem", LuaCompBase)
local FlyAnimName = "powerview_fly"

function PowerItemFlyItem:init(go)
	self.go = go
	self.animPlayer = SLFramework.AnimatorPlayer.Get(go)
	self.isFlying = false
end

function PowerItemFlyItem:fly(delayTime)
	self.isFlying = true

	gohelper.setActive(self.go, false)
	TaskDispatcher.cancelTask(self._playFlyAnim, self)
	TaskDispatcher.runDelay(self._playFlyAnim, self, delayTime)
end

function PowerItemFlyItem:_playFlyAnim()
	gohelper.setActive(self.go, true)
	self.animPlayer:Play(FlyAnimName, self._flyCallback, self)
end

function PowerItemFlyItem:_flyCallback()
	self.isFlying = false

	gohelper.setActive(self.go, false)
end

function PowerItemFlyItem:isCanfly()
	return not self.isFlying
end

function PowerItemFlyItem:onDestroy()
	TaskDispatcher.cancelTask(self._playFlyAnim, self)

	self.isFlying = false
end

return PowerItemFlyItem
