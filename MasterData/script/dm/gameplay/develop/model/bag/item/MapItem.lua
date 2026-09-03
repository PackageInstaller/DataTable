-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/MapItem.lua

require("dm.gameplay.develop.model.bag.item.Item")
require("dm.gameplay.develop.model.bag.item.ItemPrototype")

MapItem = class("MapItem", Item, _M)

function MapItem:initialize(itemPrototype)
	super.initialize(self, itemPrototype)
end

function MapItem:synchronize(itemData)
	super.synchronize(self, itemData)

	if itemData == nil then
		return
	end
end

MapItemPrototype = class("MapItemPrototype", ItemPrototype, _M)

function MapItemPrototype:initialize(tag)
	super.initialize(self, tag)
end
