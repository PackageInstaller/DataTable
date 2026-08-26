-- chunkname: @modules/logic/currency/view/PowerItemFlyGroup.lua

module("modules.logic.currency.view.PowerItemFlyGroup", package.seeall)

local PowerItemFlyGroup = class("PowerItemFlyGroup", LuaCompBase)

function PowerItemFlyGroup:init(go)
	self.go = go
	self._itemPrefab = gohelper.findChild(go, "item")

	gohelper.setActive(self._itemPrefab, false)

	self._items = self:getUserDataTb_()
end

function PowerItemFlyGroup:flyItems(count)
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)

	if count and count > 0 then
		gohelper.setActive(self.go, true)

		for i = 1, count do
			local item = self:_getCanFlyItem(i)

			item:fly((i - 1) * 0.13)
		end

		TaskDispatcher.runDelay(self._delayPlayAudio, self, 0.5)
	end
end

function PowerItemFlyGroup:_delayPlayAudio()
	AudioMgr.instance:trigger(AudioEnum3_1.Power.play_ui_tili_candy)
end

function PowerItemFlyGroup:_getCanFlyItem()
	for _, item in ipairs(self._items) do
		if item:isCanfly() then
			return item
		end
	end

	local go = gohelper.cloneInPlace(self._itemPrefab, #self._items + 1)
	local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, PowerItemFlyItem)

	table.insert(self._items, item)

	return item
end

function PowerItemFlyGroup:onDestroy()
	self:cancelTask()
end

function PowerItemFlyGroup:cancelTask()
	TaskDispatcher.cancelTask(self._delayPlayAudio, self)
end

return PowerItemFlyGroup
