-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/model/coursedata/CourseCharacterData.lua

module("logic.extensions.playerinfo.model.coursedata.CourseCharacterData", package.seeall)

local M = class("CourseCharacterData")

function M:ctor()
	self._characterCo = nil
	self._skinCo = nil
	self.sortIndex = 0
end

function M.buildFromMsg(msg)
	local data = CourseCharacterData.New()

	data._heroId = msg.heroId
	data._level = msg.level
	data._skinId = msg.skinId
	data._characterCo = CharacterConfig.instance:getCfgInfoByID(msg.heroId)

	if msg.skinId then
		data._skinCo = HeroSkinConfig.instance:getInfo(msg.skinId)
	end

	return data
end

function M.buildFromDepot(character)
	local data = CourseCharacterData.New()

	data._heroId = character:getId()
	data._level = character:getLevel()
	data._characterCo = character:getCharacterCo()
	data._sortMo = character

	if character:getSkinId() then
		data._skinCo = HeroSkinConfig.instance:getInfo(character:getSkinId())
	end

	return data
end

function M:getId()
	return self._heroId
end

function M:getLv()
	return self._level
end

function M:getCharacterCo()
	return self._characterCo
end

function M:getSkinCo()
	return self._skinCo
end

function M:getDetailInfo()
	return self._sortMo
end

function M:addCharacterCo(characterCo)
	self._characterCo = characterCo
end

function M:getSortMo()
	return self._sortMo
end

return M
