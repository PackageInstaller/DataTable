-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/model/TeachingChapterMO.lua

module("logic.extensions.dungeon.model.TeachingChapterMO", package.seeall)

local M = class("TeachingChapterMO")

function M:ctor(chapterCo)
	self._chapterCo = chapterCo
	self._chapterId = chapterCo.chapterId
	self._difficulty = 1
	self._name = chapterCo.name
	self._dungeonIds = chapterCo.dungeonIds or {}
	self._preChapter = chapterCo.preChapter
	self._chapterReward = chapterCo.chapterReward or {}
	self._level = chapterCo.level
	self._rate = chapterCo.rate
	self._rewardTaken = {}
end

function M:setRewardTaken(index)
	self._rewardTaken[index] = true
end

function M:initRewardTaken(stars)
	for i = 1, 10 do
		self._rewardTaken[i] = stars % 2^i >= 2^(i - 1)
	end
end

function M:getRewardTakenStatusByIndex(index)
	return self._rewardTaken[index]
end

function M:getChapterReward()
	return self._chapterReward
end

function M:getChapterId()
	return self._chapterId
end

function M:getChapterCO()
	return self._chapterCo
end

function M:getName()
	return self._name
end

function M:getLevel()
	return self._level
end

function M:getRate()
	return self._rate
end

function M:getDungeonIds()
	return self._dungeonIds
end

function M:getPassedDungeonCount()
	local count = 0

	for i, v in ipairs(self._dungeonIds) do
		if DungeonModel.instance:getDungeonPassDataByDungeonId(v) then
			count = count + 1
		end
	end

	return count
end

function M:getFirstNotPassedDungeonIndex()
	for i, v in ipairs(self._dungeonIds) do
		if not DungeonModel.instance:getDungeonPassDataByDungeonId(v) then
			return i
		end
	end

	return 1
end

function M:getIsChapterUnlock()
	if self:getIsPreChapterFinished() then
		return true
	end

	for i, v in ipairs(self._dungeonIds) do
		local dungeonMo = DungeonModel.instance:getDungeonMoById(v)

		if dungeonMo and dungeonMo:getIsUnlock() then
			return true
		end
	end
end

function M:getIsPreChapterFinished()
	if self._preChapter == 0 then
		return true
	end

	local chapterMo = DungeonTeachingChapterModel.instance:getChapterMoByChapterId(self._preChapter)

	if chapterMo and chapterMo:getChapterFinished() then
		return true
	end

	return false
end

function M:getChapterFinished()
	if DungeonModel.instance:getDungeonPassDataByDungeonId(self._dungeonIds[#self._dungeonIds]) then
		return true
	else
		return false
	end
end

return M
