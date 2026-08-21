-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseCharacterCollectData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseCharacterCollectData", package.seeall)

local M = class("CourseCharacterCollectData")

function M:ctor(heros, camps, heroNum)
	local characters = {}

	for i, v in ipairs(heros) do
		local character = CourseCharacterData.buildFromMsg(v)

		character.sortIndex = i

		table.insert(characters, character)
	end

	self._heroInfos = characters
	self._collectNum = heroNum
	self._completeCamps = camps
	self._heroDetails = {}
end

function M:updateContent(heroIds)
	local characters = {}

	for i, v in ipairs(heroIds) do
		local hero = HeroDepotModel.instance:getHeroInfoByID(v)

		if hero then
			local character = CourseCharacterData.buildFromDepot(hero)

			character.sortIndex = i

			table.insert(characters, character)
		end
	end

	self._heroInfos = characters
end

function M:getHeroCollectNum()
	return self._collectNum
end

function M:getDisplayHero()
	return self._heroInfos
end

function M:getUnlockCamps()
	local res = {}

	for _, v in ipairs(self._completeCamps) do
		res[v] = true
	end

	return res
end

function M:createHeroDetail(msg)
	local heroId = msg.hero.id

	if not self._heroDetails[heroId] then
		local hero = CharacterDataOthers.New(msg)

		self._heroDetails[heroId] = hero
	end

	return self._heroDetails[heroId]
end

function M:getHeroDetail(heroId)
	return self._heroDetails[heroId]
end

function M:clear()
	self._heroInfos = nil
	self._heroDetails = nil
end

return M
