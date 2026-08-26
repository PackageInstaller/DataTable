-- chunkname: @modules/logic/herogrouppreset/model/HeroGroupPresetSingleGroupModel.lua

module("modules.logic.herogrouppreset.model.HeroGroupPresetSingleGroupModel", package.seeall)

local HeroGroupPresetSingleGroupModel = class("HeroGroupPresetSingleGroupModel", ListScrollModel)

function HeroGroupPresetSingleGroupModel:onInit()
	self:_buildMOList()
end

function HeroGroupPresetSingleGroupModel:reInit()
	self:_buildMOList()
end

function HeroGroupPresetSingleGroupModel:_buildMOList()
	self:setMaxHeroCount()
end

function HeroGroupPresetSingleGroupModel:isTemp()
	return self.temp
end

function HeroGroupPresetSingleGroupModel:setMaxHeroCount(maxHeroCount, groupMoCls)
	local moList = {}

	maxHeroCount = maxHeroCount or ModuleEnum.MaxHeroCountInGroup
	groupMoCls = groupMoCls or HeroSingleGroupPresetMO

	for i = 1, maxHeroCount do
		table.insert(moList, groupMoCls.New())
	end

	self:clear()
	self:setList(moList)
end

function HeroGroupPresetSingleGroupModel:setSingleGroup(heroGroupMO, setTrial)
	local moList = self:getList()

	for i = 1, #moList do
		local heroUid = heroGroupMO and heroGroupMO.heroList[i]

		moList[i]:init(i, heroUid)
	end

	self.temp = heroGroupMO and heroGroupMO.temp

	self:setList(moList)

	if setTrial and heroGroupMO then
		local list = self:getList()

		for i = 1, #list do
			list[i]:setAid(heroGroupMO.aidDict and heroGroupMO.aidDict[i])
			list[i]:setHeroGroup(heroGroupMO)

			if heroGroupMO.trialDict and heroGroupMO.trialDict[i] then
				list[i]:setTrial(unpack(heroGroupMO.trialDict[i]))
			else
				list[i]:setTrial()
			end
		end
	end
end

function HeroGroupPresetSingleGroupModel:addToEmpty(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEmpty() then
			mo:setHeroUid(heroUid)

			break
		end
	end
end

function HeroGroupPresetSingleGroupModel:addTo(heroUid, id)
	local mo = self:getById(id)

	if mo then
		mo:setHeroUid(heroUid)
	end
end

function HeroGroupPresetSingleGroupModel:remove(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			mo:setEmpty()

			break
		end
	end
end

function HeroGroupPresetSingleGroupModel:removeFrom(id)
	local mo = self:getById(id)

	if mo then
		mo:setEmpty()
	end
end

function HeroGroupPresetSingleGroupModel:swap(id1, id2)
	local mo1 = self:getById(id1)
	local mo2 = self:getById(id2)

	if mo1 and mo2 then
		if mo1.aid == -1 or mo2.aid == -1 then
			return
		end

		local temp = mo1.heroUid

		mo1:setHeroUid(mo2.heroUid)
		mo2:setHeroUid(temp)

		local tempAid = mo1.aid

		mo1:setAid(mo2.aid)
		mo2:setAid(tempAid)

		local tempTrialId = mo1.trial
		local tempTrialTemplate = mo1.trialTemplate
		local tempTrialPos = mo1.trialPos

		mo1:setTrial(mo2.trial, mo2.trialTemplate, mo2.trialPos, true)
		mo2:setTrial(tempTrialId, tempTrialTemplate, tempTrialPos, true)
	end
end

function HeroGroupPresetSingleGroupModel:move(from, to)
	local moList = self:getList()
	local newList = {}

	for i, mo in ipairs(moList) do
		local result = i

		if i ~= from then
			if i < from and to <= i then
				result = i + 1
			elseif from < i and i <= to then
				result = i - 1
			end
		else
			result = to
		end

		newList[result] = mo
		mo.id = result
	end

	self:setList(newList)
end

function HeroGroupPresetSingleGroupModel:isInGroup(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			return true
		end
	end
end

function HeroGroupPresetSingleGroupModel:isEmptyById(id)
	local mo = self:getById(id)

	return mo and mo:isEmpty()
end

function HeroGroupPresetSingleGroupModel:isEmptyExcept(id)
	local moList = self:getList()

	for i = 1, ModuleEnum.HeroCountInGroup do
		if i ~= id then
			local mo = moList[i]

			if not mo:isEmpty() then
				return false
			end
		end
	end

	return true
end

function HeroGroupPresetSingleGroupModel:isFull()
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:canAddHero() and HeroGroupPresetModel.instance:isPositionOpen(mo.id) then
			return false
		end
	end

	return true
end

function HeroGroupPresetSingleGroupModel:getHeroUids()
	local list = {}
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		table.insert(list, mo.heroUid)
	end

	return list
end

function HeroGroupPresetSingleGroupModel:getHeroUid(id)
	local mo = self:getById(id)

	return (mo or nil) and mo.heroUid
end

function HeroGroupPresetSingleGroupModel:hasHeroUids(heroUid, id)
	if heroUid == "0" then
		return false
	end

	local moList = self:getList()

	for i, mo in ipairs(moList) do
		if mo.heroUid == heroUid and mo.id ~= id then
			return true, i
		end
	end

	return false
end

function HeroGroupPresetSingleGroupModel:hasHero()
	local moList = HeroModel.instance:getList()

	if moList and #moList > 0 then
		for _, mo in ipairs(moList) do
			if not self:hasHeroUids(mo.uid) then
				return true
			end
		end
	end

	return false
end

function HeroGroupPresetSingleGroupModel:isAidConflict(heroId)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isAidConflict(heroId) then
			return true
		end
	end

	return false
end

function HeroGroupPresetSingleGroupModel:getTeamLevel()
	local moList = self:getList()
	local allLev, heroCount = 0, 0

	for i, mo in ipairs(moList) do
		if tonumber(mo.heroUid) < 0 and mo.trial > 0 then
			if lua_hero_trial.configDict[mo.trial] then
				local trialCo = lua_hero_trial.configDict[mo.trial][0]

				allLev = allLev + trialCo.level
				heroCount = heroCount + 1
			end
		else
			local heroMo = HeroModel.instance:getById(mo.heroUid)

			if heroMo then
				allLev = allLev + heroMo.level
				heroCount = heroCount + 1
			end
		end
	end

	return (heroCount ~= 0 or nil) and math.floor(allLev / heroCount)
end

HeroGroupPresetSingleGroupModel.instance = HeroGroupPresetSingleGroupModel.New()

return HeroGroupPresetSingleGroupModel
