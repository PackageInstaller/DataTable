-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/Goods.lua

require("dm.gameplay.develop.model.bag.item.Item")
require("dm.gameplay.develop.model.bag.item.ItemPrototype")

Goods = class("Goods", Item, _M)

function Goods:initialize(itemPrototype)
	super.initialize(self, itemPrototype)
end

function Goods:synchronize(itemData, id)
	super.synchronize(self, itemData)

	if itemData == nil then
		return
	end
end

GoodsPrototype = class("GoodsPrototype", ItemPrototype, _M)

function GoodsPrototype:initialize(tag)
	super.initialize(self, tag)
end
