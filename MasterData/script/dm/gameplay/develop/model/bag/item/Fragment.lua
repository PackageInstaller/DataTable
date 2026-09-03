-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/bag/item/Fragment.lua

require("dm.gameplay.develop.model.bag.item.Item")
require("dm.gameplay.develop.model.bag.item.ItemPrototype")

Fragment = class("Fragment", Item, _M)

function Fragment:initialize(itemPrototype)
	super.initialize(self, itemPrototype)
end

function Fragment:synchronize(itemData, id)
	super.synchronize(self, itemData)

	if itemData == nil then
		return
	end
end

FragmentPrototype = class("FragmentPrototype", ItemPrototype, _M)

function FragmentPrototype:initialize(tag)
	super.initialize(self, tag)
end

function FragmentPrototype:getComposeCount()
	assert(false, "override")
end

function FragmentPrototype:getOriginName()
	assert(false, "override")
end

EquipmentFragmentPrototype = class("EquipmentFragmentPrototype", ItemPrototype, _M)

EquipmentFragmentPrototype:has("_mirrorConfig", {
	is = "r"
})

function EquipmentFragmentPrototype:initialize(tag)
	super.initialize(self, tag)

	self._mirrorConfig = ItemPrototype:new(self:getSubType())
end

function EquipmentFragmentPrototype:getComposeCount()
	local equipData = self:getMirrorConfig()

	if equipData then
		local itemData = string.split(equipData:getFragmentID(), "_")

		return itemData[2] or 0
	end
end

function EquipmentFragmentPrototype:getOriginName()
	local equipData = self:getMirrorConfig()

	if equipData then
		return equipData:getName()
	end
end

HeroFragmentPrototype = class("HeroFragmentPrototype", ItemPrototype, _M)

HeroFragmentPrototype:has("_mirrorConfig", {
	is = "r"
})

function HeroFragmentPrototype:initialize(tag)
	super.initialize(self, tag)

	self._mirrorConfig = HeroPrototype:new(self:getSubType())
end

function HeroFragmentPrototype:getComposeCount()
	local heroData = self:getMirrorConfig()

	if heroData then
		local needPieceNum = 0
		local heroConfig = ConfigReader:getRecordById("HeroBase", heroData:getId())

		for index = 1, heroData:getStar() do
			needPieceNum = needPieceNum + heroConfig.StarUpFactor[index]
		end

		return needPieceNum
	end
end

function HeroFragmentPrototype:getOriginName()
	local heroData = self:getMirrorConfig()

	return heroData:getName()
end
