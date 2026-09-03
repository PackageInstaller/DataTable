-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroSoulList.lua

require("dm.gameplay.develop.model.hero.HeroSoul")

HeroSoulList = class("HeroSoulList", objectlua.Object, _M)

HeroSoulList:has("_hero", {
	is = "r"
})
HeroSoulList:has("_soulMap", {
	is = "r"
})
HeroSoulList:has("_soulArray", {
	is = "r"
})

function HeroSoulList:initialize(ids, hero)
	self._soulIdList = ids
	self._hero = hero

	self:initHeroSoulList()
end

function HeroSoulList:initHeroSoulList()
	self._soulMap = {}
	self._soulArray = {}

	for i = 1, #self._soulIdList do
		local heroSoulId = self._soulIdList[i]
		local heroSoul = HeroSoul:new(heroSoulId, i, self)

		if self._hero then
			heroSoul:createAttrEffect(self._hero, self._hero:getPlayer())
		end

		self._soulMap[heroSoulId] = heroSoul
		self._soulArray[#self._soulArray + 1] = heroSoul
	end
end

function HeroSoulList:synchronize(diffData)
	for soulId, data in pairs(diffData) do
		local soul = self:getSoulById(soulId)

		if soul then
			soul:synchronize(data)
		end
	end
end

function HeroSoulList:getSoulById(id)
	return self._soulMap[id]
end
