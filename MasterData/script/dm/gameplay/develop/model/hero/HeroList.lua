-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/model/hero/HeroList.lua

require("dm.gameplay.develop.model.hero.Hero")
require("dm.gameplay.develop.model.RemoteObjectRegistry")

HeroList = class("HeroList", objectlua.Object, _M)

function HeroList:initialize(player)
	self._heros = {}
	self._player = player
	self._ids = {}
end

function HeroList:synchronize(data)
	if data == nil then
		return
	end

	for heroId, heroData in pairs(data) do
		self:synHero(heroId, heroData)
	end
end

function HeroList:synHero(heroId, heroData)
	local hero

	if self:hasHero(heroId) then
		hero = self:getHeroById(heroId)
	else
		hero = Hero:new(heroId, self._player)

		local clone = Hero:new(heroId, self._player)

		hero:setClone(clone)
		hero:rCreateEffect()
		self:addHero(hero)
	end

	hero:synchronize(heroData)
end

function HeroList:synchronizeDelEquip(data)
	for heroId, v in pairs(data) do
		if v.heroEquip then
			local hero = self:getHeroById(heroId)

			hero:synchronizeDelEquip(v.heroEquip)
		end

		if v.tsoul then
			local hero = self:getHeroById(heroId)

			hero:synchronizeDelTsoul(v.tsoul)
		end
	end
end

function HeroList:clearAttrsFlag()
	for heroId, hero in pairs(self._heros) do
		hero:clearAttrsFlag()
	end
end

function HeroList:syncAttrEffect()
	for i, hero in pairs(self._heros) do
		hero:syncAttrEffect()
	end
end

function HeroList:hasHero(heroId)
	return self._heros[tostring(heroId)] ~= nil
end

function HeroList:addHero(hero)
	if hero == nil then
		return
	end

	local id = hero:getId()

	self._ids[#self._ids + 1] = id
	self._heros[id] = hero

	hero:setGroup(self)
	RemoteObjectRegistry:getInstance():registerObject(id, hero)
end

function HeroList:getHeroById(heroId)
	return self._heros[tostring(heroId)]
end

function HeroList:getHeros()
	return self._heros
end

function HeroList:getAllHeroIds()
	return self._ids
end

function HeroList:getHeroCount()
	return table.capacity(self._heros)
end
