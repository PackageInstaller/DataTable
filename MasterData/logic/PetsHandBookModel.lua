-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petshandbook/model/PetsHandBookModel.lua

module("logic.extensions.petshandbook.model.PetsHandBookModel", package.seeall)

local PetsHandBookModel = class("PetsHandBookModel")

function PetsHandBookModel:ctor()
	self._hang = 4
	self._lie = 5
	self._itemNum = self._hang * self._lie
	self._curPage = 2
	self._petsItems = {}
	self._petCfg = nil
	self._filterPetCfg = nil
	self._selectJob = 0
	self._selectAtrr = 0
	self._searchText = nil
	self._userPetInfoList = nil
	self._selectGod = true
end

function PetsHandBookModel:onReset()
	self._dataInit = false
end

function PetsHandBookModel:getIsDataInit()
	return self._dataInit == true
end

function PetsHandBookModel:getPages()
	local pageNum = math.ceil(#self:getPetCfgFilter() / self._itemNum)

	pageNum = pageNum + math.fmod(pageNum, 2)

	return math.max(pageNum, 2)
end

function PetsHandBookModel:getPetCfg()
	self._petCfg = CharacterConfig.instance:getPetCfg()
end

function PetsHandBookModel:getPetCfgFilter(isForce)
	if self._filterPetCfg == nil or isForce == true then
		self._filterPetCfg = {}

		local cf = CharacterConfig.instance:getPetCfg()

		for i, v in ipairs(cf) do
			if self:_PetFilter(v) then
				table.insert(self._filterPetCfg, v)
			end
		end

		ArraySort.sortOn(self._filterPetCfg, "bookIds", ArraySort.NUMERIC)
	end

	return self._filterPetCfg
end

function PetsHandBookModel:setSelectGod()
	self._selectGod = not self._selectGod

	return self._selectGod
end

function PetsHandBookModel:setSelectJob(Job, value)
	local jobTbl = TableUtil.d2b(self._selectJob)

	jobTbl[Job] = value and value == -1 and 0 or 1
	self._selectJob = TableUtil.b2d(jobTbl)
end

function PetsHandBookModel:setSelectAttr(attr, value)
	local attrTbl = TableUtil.d2b(self._selectAtrr)

	attrTbl[attr] = value and value == -1 and 0 or 1
	self._selectAtrr = TableUtil.b2d(attrTbl)
end

function PetsHandBookModel:setSearchText(text)
	self._searchText = text
end

function PetsHandBookModel:_PetFilter(petCo)
	if petCo == nil then
		return false
	end

	if string.nilorempty(petCo.bookIds) then
		return false
	end

	if not string.nilorempty(self._searchText) then
		local str = StringUtil.RelpaceEscapeChar(self._searchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	if self._selectJob ~= 0 then
		local jobTbl = TableUtil.d2b(self._selectJob)
		local firstJobIdx = PetSkinConfig.instance:getFirstJobIdx(petCo.raceId)

		if jobTbl[firstJobIdx] ~= 1 then
			return false
		end
	end

	local firstEle = PetSkinConfig.instance:getFisrtEleAttrIdx(petCo.raceId)

	if firstEle > 0 and self._selectGod == false then
		return false
	end

	if self._selectAtrr ~= 0 then
		local attrTbl = TableUtil.d2b(self._selectAtrr)

		if attrTbl[firstEle] ~= 1 then
			return false
		end
	end

	return true
end

function PetsHandBookModel:setNextPage()
	self._curPage = self._curPage + 2
end

function PetsHandBookModel:setPrePage()
	self._curPage = self._curPage - 2
end

function PetsHandBookModel:resetPage()
	self._curPage = 2
end

function PetsHandBookModel:getCurPage()
	return self._curPage
end

function PetsHandBookModel:addPetItem(item)
	table.insert(self._petsItems, item)
end

function PetsHandBookModel:getPetItem(idx)
	if idx then
		return self._petsItems[idx]
	else
		return self._petsItems
	end
end

function PetsHandBookModel:getAboutPets(raceData)
	local aboutPets = {}
	local findRaceID = raceData.raceId
	local raceIdsBeforeEvolveId = raceData.raceIdsBeforeEvolve

	while raceIdsBeforeEvolveId ~= "" do
		local petCo = CharacterConfig.instance:getPetCo(checknumber(raceIdsBeforeEvolveId))

		if petCo then
			table.insert(aboutPets, petCo)

			raceIdsBeforeEvolveId = petCo.raceIdsBeforeEvolve
		else
			raceIdsBeforeEvolveId = ""
		end
	end

	for i, v in ipairs(CharacterConfig.instance:getPetCfg()) do
		if checknumber(v.raceIdsBeforeEvolve) == findRaceID then
			table.insert(aboutPets, v)

			findRaceID = checknumber(v.raceId)
		end
	end

	return aboutPets
end

function PetsHandBookModel:setUserPetInfoList(list)
	print("set userPetInfoList")

	for i, v in ipairs(list) do
		table.insert(self._userPetInfoList, v)
	end
end

function PetsHandBookModel:getPetsWay(raceId)
	local ways_tbl = {}
	local cfg = HandBookConfig.instance:getPetWaysCfgId(raceId)

	if cfg == nil then
		return ways_tbl
	end

	local wayTable = TableUtil.split(cfg.ways, "#")

	for i, v in ipairs(wayTable) do
		local waysCfg = HandBookConfig.instance:getWaysCfgById(tonumber(v))

		table.insert(ways_tbl, waysCfg)
	end

	return ways_tbl
end

function PetsHandBookModel:getPetMaxPower(raceId)
	do return FightingPowerFormula.instance:getPetMaxFightingPower(raceId) end

	local power = 0
	local petCfg = CharacterConfig.instance:getPetCo(raceId)

	power = petCfg.zdlRadix / 2 * petCfg.maxLv / 100

	local attr = {
		"phyAtk",
		"magAtk",
		"ultAtk",
		"phyDef",
		"magDef",
		"ultDef",
		"speed",
		"hp"
	}
	local attrValue = 0

	for i, v in ipairs(attr) do
		attrValue = attrValue + petCfg[v]
	end

	power = power + attrValue * 1.5 * petCfg.maxLv / 100

	return power
end

function PetsHandBookModel:initPetInfoList(list)
	print("init userPetInfoList")

	self._userPetInfoList = list
end

function PetsHandBookModel:getPetInfoList()
	self._userFilter = {}

	for i, v in ipairs(self._userPetInfoList) do
		if self:_PetFilter(CharacterConfig.instance:getPetCo(v)) then
			table.insert(self._userFilter, v)
		end
	end

	return self._userFilter
end

local specialIds = {}

specialIds[10001] = 10210
specialIds[10002] = 10220
specialIds[10003] = 10230
specialIds[10004] = 10240
specialIds[10005] = 10250
specialIds[10006] = 10260

function PetsHandBookModel:isHasPet(raceId)
	return HandbookModel.instance:isHasPet(raceId)
end

function PetsHandBookModel:insertPetId(raceId)
	if checknumber(raceId) <= 0 then
		return
	end

	if not self:isHasPet(raceId) then
		table.insert(self._userPetInfoList, raceId)
	end
end

function PetsHandBookModel:onCheckEgg(raceId)
	return false
end

PetsHandBookModel.instance = PetsHandBookModel.New()

return PetsHandBookModel
