-- chunkname: @modules/logic/herogroup/model/HeroSingleGroupModel.lua

module("modules.logic.herogroup.model.HeroSingleGroupModel", package.seeall)

local HeroSingleGroupModel = class("HeroSingleGroupModel", ListScrollModel)

function HeroSingleGroupModel:onInit()
	self:_buildMOList()
end

function HeroSingleGroupModel:reInit()
	self:_buildMOList()
end

function HeroSingleGroupModel:_buildMOList()
	self:setMaxHeroCount()
end

function HeroSingleGroupModel:isTemp()
	return self.temp
end

function HeroSingleGroupModel:setMaxHeroCount(maxHeroCount, groupMoCls)
	local moList = {}

	maxHeroCount = maxHeroCount or ModuleEnum.MaxHeroCountInGroup
	groupMoCls = groupMoCls or HeroSingleGroupMO

	for i = 1, maxHeroCount do
		table.insert(moList, groupMoCls.New())
	end

	self:clear()
	self:setList(moList)
end

function HeroSingleGroupModel:setSingleGroup(heroGroupMO, setTrial)
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

			if heroGroupMO.trialDict and heroGroupMO.trialDict[i] then
				list[i]:setTrial(unpack(heroGroupMO.trialDict[i]))
			else
				list[i]:setTrial()
			end
		end
	end
end

function HeroSingleGroupModel:setHeroList(newHeroUids)
	for i = 1, HeroGroupModel.instance:getBattleRoleNum() do
		local heroUid = newHeroUids[i]

		if heroUid ~= nil then
			self:addTo(heroUid, i)

			local singleGroupMO = self:getByIndex(i)

			if tonumber(heroUid) < 0 then
				local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

				if heroMO then
					singleGroupMO:setTrial(heroMO.trialCo.id, heroMO.trialCo.trialTemplate)
				else
					singleGroupMO:setTrial()
				end
			else
				singleGroupMO:setTrial()
			end
		end
	end
end

function HeroSingleGroupModel:addToEmpty(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEmpty() then
			mo:setHeroUid(heroUid)

			break
		end
	end
end

function HeroSingleGroupModel:addTo(heroUid, id)
	local mo = self:getById(id)

	if mo then
		mo:setHeroUid(heroUid)
	end
end

function HeroSingleGroupModel:remove(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			mo:setEmpty()

			break
		end
	end
end

function HeroSingleGroupModel:removeFrom(id)
	local mo = self:getById(id)

	if mo then
		mo:setEmpty()
	end
end

function HeroSingleGroupModel:swap(id1, id2)
	local mo1 = self:getById(id1)
	local mo2 = self:getById(id2)

	if mo1 and mo2 then
		if mo1.aid == -1 or mo2.aid == -1 then
			return
		end

		local _, assistMo = HeroGroupModel.instance:getAssistMo()
		local assistHeroUid = assistMo and assistMo.heroUid
		local temp = mo1.heroUid

		if not assistHeroUid or assistHeroUid ~= mo2.heroUid then
			mo1:setHeroUid(mo2.heroUid)
		end

		if not assistHeroUid or assistHeroUid ~= temp then
			mo2:setHeroUid(temp)
		end

		local tempAid = mo1.aid

		mo1:setAid(mo2.aid)
		mo2:setAid(tempAid)

		local tempTrialId = mo1.trial
		local tempTrialTemplate = mo1.trialTemplate
		local tempTrialPos = mo1.trialPos

		mo1:setTrial(mo2.trial, mo2.trialTemplate, mo2.trialPos, true)
		mo2:setTrial(tempTrialId, tempTrialTemplate, tempTrialPos, true)

		if assistMo then
			if assistMo.id == id1 then
				assistMo:swapAssist(assistMo.assistMo, id2)
			elseif assistMo.id == id2 then
				assistMo:swapAssist(assistMo.assistMo, id1)
			end
		end
	end
end

function HeroSingleGroupModel:move(from, to)
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

function HeroSingleGroupModel:isInGroup(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			return true
		end
	end
end

function HeroSingleGroupModel:isEmptyById(id)
	local mo = self:getById(id)

	return mo and mo:isEmpty()
end

function HeroSingleGroupModel:isEmptyExcept(id)
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

function HeroSingleGroupModel:isFull()
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:canAddHero() and HeroGroupModel.instance:isPositionOpen(mo.id) then
			return false
		end
	end

	return true
end

function HeroSingleGroupModel:getHeroUids()
	local list = {}
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		table.insert(list, mo.heroUid)
	end

	return list
end

function HeroSingleGroupModel:getHeroUid(id)
	local mo = self:getById(id)

	return (mo or nil) and mo.heroUid
end

function HeroSingleGroupModel:hasHeroUids(heroUid, id)
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

function HeroSingleGroupModel:hasHero()
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

function HeroSingleGroupModel:isAidConflict(heroId)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isAidConflict(heroId) then
			return true
		end
	end

	return false
end

function HeroSingleGroupModel:getTeamLevel()
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

HeroSingleGroupModel.instance = HeroSingleGroupModel.New()

return HeroSingleGroupModel
