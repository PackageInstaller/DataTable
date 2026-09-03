-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/AbstractHero.lua

AbstractHero = class("AbstractHero", objectlua.Object, _M)

AbstractHero:has("_id", {
	is = "r"
})
AbstractHero:has("_level", {
	is = "rw"
})
AbstractHero:has("_exp", {
	is = "rw"
})
AbstractHero:has("_quality", {
	is = "r"
})
AbstractHero:has("_star", {
	is = "rw"
})
AbstractHero:has("_heroPrototype", {
	is = "r"
})

function AbstractHero:initialize(heroPrototype)
	super.initialize(self)

	self._heroPrototype = heroPrototype
	self._level = 0
	self._exp = 0
	self._quality = 10
	self._star = 1
	self._skillList = {}
end

function AbstractHero:synchronize(data)
	return
end

function AbstractHero:getHp()
	assert(false, "override")
end

function AbstractHero:getAttack()
	assert(false, "override")
end

function AbstractHero:getDefense()
	assert(false, "override")
end

function AbstractHero:getSkillList()
	return self._skillList
end

function AbstractHero:getAllSkillId()
	local skillIdList = {}

	for skillId, skill in pairs(self._skillList) do
		skillIdList[#skillIdList + 1] = skillId
	end

	return skillIdList
end

function AbstractHero:getSkillById(skillId)
	return self._skillList[skillId]
end
