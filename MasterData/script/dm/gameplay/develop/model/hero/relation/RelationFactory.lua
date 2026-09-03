-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/relation/RelationFactory.lua

require("dm.gameplay.develop.model.hero.relation.HeroRelation")
require("dm.gameplay.develop.model.hero.relation.EquipRelation")
require("dm.gameplay.develop.model.hero.relation.GlobalRelation")

RelationFactory = class("RelationFactory", objectlua.Object, _M)
RelationType = {
	kHero = "HERO",
	kGlobal = "GLOBAL",
	kEquip = "EQUIP"
}

function RelationFactory.class:getInstance()
	if __relationFactory == nil then
		__relationFactory = RelationFactory:new()
	end

	return __relationFactory
end

function RelationFactory:initialize()
	return
end

function RelationFactory:createRelationByID(relationId)
	local relationConfig = self:getRelationConfig(relationId)

	if not relationConfig then
		return
	end

	local relation

	if relationConfig.Type == RelationType.kHero then
		relation = HeroRelation:new(relationId)
	elseif relationConfig.Type == RelationType.kEquip then
		relation = EquipRelation:new(relationId)
	elseif relationConfig.Type == RelationType.kGlobal then
		relation = GlobalRelation:new(relationId)
	end

	return relation
end

function RelationFactory:getRelationConfig(id)
	return ConfigReader:getRecordById("HeroRelation", tostring(id))
end
