-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/house/model/hero/HeroHouseFeatureMO.lua

module("logic.extensions.house.model.hero.HeroHouseFeatureMO", package.seeall)

local M = class("HeroHouseFeatureMO")
local WorkStatus = HouseEnum.WorkStatus

function M:ctor(heroId)
	self._heroId = heroId
	self._arraySkill = {}
	self._arrayBuff = {}
	self._arrayMoodRecord = {}
	self._mood = 0
	self._moodCost = 0
	self._moodRecover = 0
	self._thoughtEduFormula = 0
	self._thoughtEdu = true

	local cfgCharacter = CharacterConfig.instance:getCharacterItemInfo(heroId)

	if cfgCharacter then
		self._thoughtEduFormula = cfgCharacter.thoughtEdu
	else
		printError(string.format("无法从[t_%s]找到[%s]的配置", ConfigName.Character, heroId))
	end
end

function M:updateByAgent(NO)
	table.clear(self._arraySkill)

	for _, skillNO in ipairs(NO.skills or {}) do
		local mo = HeroHouseSkillMO.New(skillNO.skillId)

		mo:updateByAgent(skillNO)
		table.insert(self._arraySkill, mo)
	end

	table.clear(self._arrayBuff)

	for _, buffNO in ipairs(NO.buffs or {}) do
		local mo = HeroHouseBuffMO.New(buffNO.buffId)

		mo:updateByAgent(buffNO)
		table.insert(self._arrayBuff, mo)
	end

	table.clear(self._arrayMoodRecord)

	local tempTable = {}

	for idx, recordNO in ipairs(NO.moodRecords or {}) do
		local mo = HeroHouseMoodRecord.New()

		mo:updateByAgent(idx, recordNO)
		table.insert(tempTable, mo)
	end

	for i = #tempTable, 1, -1 do
		table.insert(self._arrayMoodRecord, tempTable[i])
	end

	self._mood = 0
	self._moodCost = 0
	self._moodRecover = 0

	for _, AttrNO in ipairs(NO.attrs) do
		if AttrNO.attrTYpe == HouseExtension_pb.Attr.MOOD then
			self:setMood(AttrNO.value)
		elseif AttrNO.attrTYpe == HouseExtension_pb.Attr.MOOD_COST then
			self:setMoodCost(AttrNO.value)
		elseif AttrNO.attrTYpe == HouseExtension_pb.Attr.MOOD_RECOVER then
			self:setMoodRecover(AttrNO.value)
		end
	end

	self._thoughtEdu = NO.thoughtEdu
end

function M:getSkills()
	return self._arraySkill
end

function M:getBuffs()
	return self._arrayBuff
end

function M:setMood(mood)
	self._mood = mood or 0
end

function M:getMood(numDigits)
	if numDigits then
		return MathUtil.preciseDecimal(self._mood, numDigits)
	end

	return self._mood
end

function M:setMoodCost(cost)
	self._moodCost = cost or 0
end

function M:getMoodCost()
	return self._moodCost
end

function M:setMoodRecover(recover)
	self._moodRecover = recover or 0
end

function M:getMoodRecover()
	return self._moodRecover
end

function M:isMoodCostStatus(status)
	local costTable = {
		WorkStatus.Work
	}

	if table.indexof(costTable, status) then
		return true
	end

	return false
end

function M:getMoodRecords()
	return self._arrayMoodRecord
end

function M:getThoughtEduFormula()
	return self._thoughtEduFormula
end

function M:getIsThoughtEdu()
	if self:getThoughtEduFormula() > 0 then
		return self._thoughtEdu
	end

	return true
end

function M:setIsThoughtEdu(thoughtEdu)
	self._thoughtEdu = thoughtEdu
end

return M
