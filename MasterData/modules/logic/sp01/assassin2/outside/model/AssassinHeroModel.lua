-- chunkname: @modules/logic/sp01/assassin2/outside/model/AssassinHeroModel.lua

module("modules.logic.sp01.assassin2.outside.model.AssassinHeroModel", package.seeall)

local AssassinHeroModel = class("AssassinHeroModel", BaseModel)

function AssassinHeroModel:onInit()
	self:clearAll()
end

function AssassinHeroModel:reInit()
	self:clearData()
end

function AssassinHeroModel:clearAll()
	self:clear()
	self:clearData()
end

function AssassinHeroModel:clearData()
	return
end

function AssassinHeroModel:updateAllInfo(heroInfo)
	self:clearAll()

	local assassinHeroList = AssassinConfig.instance:getAssassinHeroIdList()

	for _, assassinHeroId in ipairs(assassinHeroList) do
		local heroMo = AssassinHeroMO.New(assassinHeroId)

		self:addAtLast(heroMo)
	end

	self:updateAssassinHeroInfoByList(heroInfo.heros)
end

function AssassinHeroModel:updateAssassinHeroInfoByList(heroInfoList)
	for _, assassinHeroInfo in ipairs(heroInfoList) do
		self:updateAssassinHeroInfo(assassinHeroInfo)
	end
end

function AssassinHeroModel:updateAssassinHeroInfo(assassinHeroInfo)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroInfo.heroId, true)

	if assassinHeroMo then
		assassinHeroMo:updateServerInfo(assassinHeroInfo)
	end
end

local function _sorHeroList(idA, idB)
	local heroMoA = AssassinHeroModel.instance:getAssassinHeroMo(idA, true)
	local heroMoB = AssassinHeroModel.instance:getAssassinHeroMo(idB, true)
	local isUnlockA = heroMoA and heroMoA:isUnlocked()
	local isUnlockB = heroMoB and heroMoB:isUnlocked()

	if isUnlockA ~= isUnlockB then
		return isUnlockA
	end

	return idB < idA
end

function AssassinHeroModel:getAssassinHeroIdList()
	local result = {}
	local assassinHeroList = self:getList()

	for _, assassinHeroMo in ipairs(assassinHeroList) do
		result[#result + 1] = assassinHeroMo:getAssassinHeroId()
	end

	table.sort(result, _sorHeroList)

	return result
end

function AssassinHeroModel:getAssassinHeroMo(assassinHeroId, nilError)
	local assassinHeroMo = self:getById(assassinHeroId)

	if not assassinHeroMo and nilError then
		logError(string.format("AssassinHeroModel:getAssassinHeroMo error, not find assassinHeroMo, assassinHeroId:%s", assassinHeroId))
	end

	return assassinHeroMo
end

function AssassinHeroModel:getHeroMo(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getHeroMo()
end

function AssassinHeroModel:isUnlockAssassinHero(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:isUnlocked()
end

function AssassinHeroModel:getHeroId(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getHeroId()
end

function AssassinHeroModel:getAssassinHeroName(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)
	local nameCN, nameEN = "", ""

	if assassinHeroMo then
		nameCN, nameEN = assassinHeroMo:getAssassinHeroName()
	end

	return nameCN, nameEN
end

function AssassinHeroModel:getAssassinHeroSkin(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinHeroSkin()
end

function AssassinHeroModel:getAssassinHeroShowLevel(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)
	local showLevel, rank

	if assassinHeroMo then
		showLevel, rank = assassinHeroMo:getAssassinHeroShowLevel()
	end

	return showLevel, rank
end

function AssassinHeroModel:getAssassinHeroSkillLevel(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinHeroSkillLevel() or 0
end

function AssassinHeroModel:getAssassinHeroEquipMo(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinHeroEquipMo()
end

function AssassinHeroModel:getAssassinHeroAttributeList(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinHeroAttributeList()
end

function AssassinHeroModel:getAssassinHeroCommonCareer(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinHeroCommonCareer()
end

function AssassinHeroModel:getAssassinCareerId(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getAssassinCareerId()
end

function AssassinHeroModel:getCarryItemId(assassinHeroId, index)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getCarryItemId(index)
end

function AssassinHeroModel:getItemCarryIndex(assassinHeroId, targetItemId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:getItemCarryIndex(targetItemId)
end

function AssassinHeroModel:isCarryItemFull(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return (assassinHeroMo or nil) and assassinHeroMo:isCarryItemFull()
end

function AssassinHeroModel:findEmptyItemGridIndex(assassinHeroId)
	local assassinHeroMo = self:getAssassinHeroMo(assassinHeroId, true)

	return assassinHeroMo and assassinHeroMo:findEmptyItemGridIndex()
end

function AssassinHeroModel:isUnlockCareer(careerId)
	local needHeroList = AssassinConfig.instance:getAssassinCareerUnlockNeedHeroList(careerId)

	for _, assassinHeroId in ipairs(needHeroList) do
		local isUnlock = self:isUnlockAssassinHero(assassinHeroId)

		if isUnlock then
			return true
		end
	end
end

function AssassinHeroModel:isRequiredAssassin(assassinHeroId)
	local requireAssassinHeroId = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.RequireAssassinHeroId, true)

	return assassinHeroId == requireAssassinHeroId
end

AssassinHeroModel.instance = AssassinHeroModel.New()

return AssassinHeroModel
