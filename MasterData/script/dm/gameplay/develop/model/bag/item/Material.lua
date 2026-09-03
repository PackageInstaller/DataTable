-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/Material.lua

require("dm.gameplay.develop.model.bag.item.Item")
require("dm.gameplay.develop.model.bag.item.ItemPrototype")

Material = class("Material", Item, _M)

function Material:initialize(itemPrototype)
	super.initialize(self, itemPrototype)
end

function Material:synchronize(itemData)
	super.synchronize(self, itemData)

	if itemData == nil then
		return
	end
end

MaterialPrototype = class("MaterialPrototype", ItemPrototype, _M)

function MaterialPrototype:initialize(tag)
	super.initialize(self, tag)
end
