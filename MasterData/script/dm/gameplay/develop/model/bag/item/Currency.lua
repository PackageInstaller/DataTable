-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/Currency.lua

require("dm.gameplay.develop.model.bag.item.Item")
require("dm.gameplay.develop.model.bag.item.ItemPrototype")

Currency = class("Currency", Item, _M)

Currency:has("_lastRecoverTime", {
	is = "rw"
})

function Currency:initialize(itemPrototype)
	super.initialize(self, itemPrototype)

	self._lastRecoverTime = 0
end

function Currency:synchronize(itemData, id)
	super.synchronize(self, itemData)

	if itemData.updateTime then
		self._lastRecoverTime = itemData.updateTime
	end
end

CurrencyPrototype = class("CurrencyPrototype", ItemPrototype, _M)

function CurrencyPrototype:initialize(tag)
	super.initialize(self, tag)
end
