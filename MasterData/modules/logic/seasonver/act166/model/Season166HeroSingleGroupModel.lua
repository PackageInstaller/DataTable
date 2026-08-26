-- chunkname: @modules/logic/seasonver/act166/model/Season166HeroSingleGroupModel.lua

module("modules.logic.seasonver.act166.model.Season166HeroSingleGroupModel", package.seeall)

local Season166HeroSingleGroupModel = class("Season166HeroSingleGroupModel", ListScrollModel)

function Season166HeroSingleGroupModel:onInit()
	return
end

function Season166HeroSingleGroupModel:reInit()
	self.assistMO = nil
end

function Season166HeroSingleGroupModel:_buildMOList()
	local moList = {}

	for i = 1, ModuleEnum.MaxHeroCountInGroup do
		table.insert(moList, Season166HeroSingleGroupMO.New())
	end

	self:setList(moList)
end

function Season166HeroSingleGroupModel:isTemp()
	return self.temp
end

function Season166HeroSingleGroupModel:getCurGroupMO()
	return self._heroGroupMO
end

function Season166HeroSingleGroupModel:setMaxHeroCount(maxHeroCount)
	local moList = {}

	for i = 1, maxHeroCount do
		table.insert(moList, Season166HeroSingleGroupMO.New())
	end

	self:setList(moList)
end

function Season166HeroSingleGroupModel:setSingleGroup(heroGroupMO, setTrial)
	self._heroGroupMO = heroGroupMO

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
			elseif self.assistMO and self.assistMO.heroUid == list[i].heroUid then
				list[i] = self.assistMO
			else
				list[i]:setTrial()
			end
		end
	end
end

function Season166HeroSingleGroupModel:addToEmpty(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEmpty() then
			mo:setHeroUid(heroUid)

			break
		end
	end
end

function Season166HeroSingleGroupModel:addTo(heroUid, id)
	local mo = self:getById(id)

	if mo then
		mo:setHeroUid(heroUid)
	end
end

function Season166HeroSingleGroupModel:remove(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			mo:setEmpty()

			break
		end
	end
end

function Season166HeroSingleGroupModel:removeFrom(id)
	local mo = self:getById(id)

	if mo then
		mo:setEmpty()
	end
end

function Season166HeroSingleGroupModel:swap(id1, id2)
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

function Season166HeroSingleGroupModel:move(from, to)
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

function Season166HeroSingleGroupModel:isInGroup(heroUid)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isEqual(heroUid) then
			return true
		end
	end
end

function Season166HeroSingleGroupModel:isEmptyById(id)
	local mo = self:getById(id)

	return mo and mo:isEmpty()
end

function Season166HeroSingleGroupModel:isFull()
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:canAddHero() then
			return false
		end
	end

	return true
end

function Season166HeroSingleGroupModel:getHeroUids()
	local list = {}
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		table.insert(list, mo.heroUid)
	end

	return list
end

function Season166HeroSingleGroupModel:getHeroUid(id)
	local mo = self:getById(id)

	return (mo or nil) and mo.heroUid
end

function Season166HeroSingleGroupModel:hasHeroUids(heroUid, id)
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

function Season166HeroSingleGroupModel:hasHero()
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

function Season166HeroSingleGroupModel:isAidConflict(heroId)
	local moList = self:getList()

	for _, mo in ipairs(moList) do
		if mo:isAidConflict(heroId) then
			return true
		end
	end

	return false
end

function Season166HeroSingleGroupModel:setAssistHeroGroupMO(assistMO)
	self.assistMO = assistMO

	if self.assistMO then
		local curHeroGroup = self:getCurGroupMO()

		curHeroGroup.heroList[assistMO.id] = assistMO.heroUid
	end
end

function Season166HeroSingleGroupModel:checkIsMainHero(heroUid)
	local moList = self:getList()
	local posIndex = 0

	for index, mo in ipairs(moList) do
		if mo.heroUid == heroUid then
			posIndex = index

			break
		end
	end

	if posIndex == 0 then
		return false, posIndex
	end

	local maxHeroCount = Season166HeroGroupModel.instance:getMaxHeroCountInGroup()

	return posIndex <= maxHeroCount / 2, posIndex
end

function Season166HeroSingleGroupModel:isAssistHeroInTeam()
	if not self.assistMO then
		return false
	else
		local moList = self:getList()

		for _, mo in ipairs(moList) do
			if mo.heroUid == self.assistMO.heroUid then
				return true
			end
		end
	end

	return false
end

Season166HeroSingleGroupModel.instance = Season166HeroSingleGroupModel.New()

return Season166HeroSingleGroupModel
