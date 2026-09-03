-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/HeroRelationList.lua

require("dm.gameplay.develop.model.hero.relation.HeroRelation")
require("dm.gameplay.develop.model.hero.relation.EquipRelation")
require("dm.gameplay.develop.model.hero.relation.GlobalRelation")
require("dm.gameplay.develop.model.hero.relation.RelationFactory")

HeroRelationList = class("HeroRelationList", objectlua.Object, _M)

HeroRelationList:has("_relationMap", {
	is = "rw"
})
HeroRelationList:has("_relationArr", {
	is = "rw"
})
HeroRelationList:has("_owner", {
	is = "rw"
})

function HeroRelationList:initialize(list, owner)
	super.initialize(self)

	self._owner = owner

	self:createRelationList(list)
end

function HeroRelationList:createRelationList(list)
	self._relationMap = {}
	self._relationArr = {}

	for i = 1, #list do
		local relationId = list[i]
		local relation = RelationFactory:getInstance():createRelationByID(relationId)

		if relation then
			if self._owner then
				relation:createAttrEffect(self._owner, self._owner:getPlayer())
			end

			self._relationMap[relationId] = relation
			self._relationArr[#self._relationArr + 1] = relation
		end
	end

	table.sort(self._relationArr, function(a, b)
		return a:getSort() < b:getSort()
	end)
end

function HeroRelationList:synchronize(data)
	for id, data in pairs(data) do
		local relation = self._relationMap[id]

		if relation then
			relation:synchronize(data)
		end
	end
end

function HeroRelationList:getRelationById(id)
	if self._relationMap[id] then
		return self._relationMap[id]
	end
end

function HeroRelationList:getRelationByIndex(index)
	if self._relationArr[index] then
		return self._relationArr[index]
	end
end

function HeroRelationList:getSubLevel()
	local subLevel = 0

	for _, relation in pairs(self._relationMap) do
		subLevel = subLevel + relation:getLevel()
	end

	return subLevel
end

function HeroRelationList:getHeroRelationList()
	local list = {}

	for i = 1, #self._relationArr do
		local relation = self._relationArr[i]

		if relation:getType() == RelationType.kHero then
			list[#list + 1] = relation
		end
	end

	return list
end

function HeroRelationList:getEquipRelationList()
	local list = {}

	for i = 1, #self._relationArr do
		if self._relationArr[i]:getType() == RelationType.kEquip then
			list[#list + 1] = self._relationArr[i]
		end
	end

	return list
end
