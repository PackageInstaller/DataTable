-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recommendfmt/config/PetNoticeConfig.lua

module("logic.extensions.recommendfmt.config.PetNoticeConfig", package.seeall)

local PetNoticeConfig = class("PetNoticeConfig", BaseConfig)

PetNoticeConfig.LocalUserDataKey = "PetNoticeConfig"

function PetNoticeConfig:onInit()
	PetNoticeConfig.super.onInit(self)

	self.petNoticCfgMap = {}
end

function PetNoticeConfig:getNames()
	return {
		"new_pet",
		"regression_pet",
		"pet_contract",
		"new_skin",
		"regression_skin",
		"skill_adjustment",
		"fight_creeps_time",
		"artifact_awaken",
		"pet_notice_big_tab",
		"pet_notice_small_tab",
		"regression_pet_2",
		"regression_pet_3",
		"regression_pet_4",
		"regression_pet_5",
		"regression_pet_6",
		"regression_pet_7",
		"regression_pet_8",
		"regression_pet_9",
		"regression_pet_10",
		"regression_pet_11",
		"regression_pet_12"
	}
end

function PetNoticeConfig:handleConfig(name, content)
	self.petNoticCfgMap[name] = content

	if name == "new_pet" then
		self._petnewCfg = content
	elseif name == "regression_pet" then
		self._petregressionCfg = content
	elseif name == "skill_adjustment" then
		self._petskilladjustCfg = content
	elseif name == "pet_contract" then
		self._petcontractCfg = content
	elseif name == "new_skin" then
		self._petnewskinCfg = content
	elseif name == "regression_skin" then
		self._petregressionskinCfg = content
	elseif name == "fight_creeps_time" then
		self._petsnewdateCfg = content
	elseif name == "artifact_awaken" then
		self.artifact_awaken = content
	elseif name == "pet_notice_big_tab" then
		self.pet_notice_big_tabCfg = content
	elseif name == "pet_notice_small_tab" then
		self.pet_notice_small_tabCfg = content
	end
end

function PetNoticeConfig:getPetNoticCfgs(name)
	local showTab = self.petNoticCfgMap[name]

	if showTab == nil then
		if enableDebug then
			printError(">>>>>>>>>>>>请叫开发在PetNoticeConfig:getNames添加新配置表名:" .. name)
		end

		showTab = {}
	end

	local tab = {}
	local starPetIds = GameUtil.getUserData(PetNoticeConfig.LocalUserDataKey)
	local isMatch = checknumber(string.find(name, "new_pet")) > 0 or checknumber(string.find(name, "regression_pet")) > 0

	for i, v in ipairs(showTab) do
		local isShow = not v.startTime or not v.endTime

		isShow = isShow or GameUtil.getTimePeriodType(v.startTime, v.endTime, false) ~= GameUtil.afterTimePeriod

		local isStar = false

		if isMatch and starPetIds then
			for _, v2 in ipairs(starPetIds) do
				if v2 == v.skinId then
					isStar = true

					break
				end
			end
		end

		if isMatch then
			v.isStar = isStar and 1 or 0
		end

		if isShow then
			table.insert(tab, v)
		end
	end

	if isMatch then
		table.sort(tab, function(a, b)
			if a.isStar ~= b.isStar then
				return a.isStar > b.isStar
			end

			return a.sort < b.sort
		end)
	end

	return tab
end

function PetNoticeConfig:getBigTabList()
	return self.pet_notice_big_tabCfg.dataList
end

function PetNoticeConfig:getBigTabSortList()
	if self._sort_pet_notice_big_tabCfg then
		return self._sort_pet_notice_big_tabCfg
	end

	self._sort_pet_notice_big_tabCfg = {}

	local dataList = self.pet_notice_big_tabCfg.dataList

	for i, v in ipairs(dataList) do
		table.insert(self._sort_pet_notice_big_tabCfg, v)
	end

	table.sort(self._sort_pet_notice_big_tabCfg, function(a, b)
		return a.sortIndex < b.sortIndex
	end)

	return self._sort_pet_notice_big_tabCfg
end

function PetNoticeConfig:getBigTabCfg(id)
	return self.pet_notice_big_tabCfg[id]
end

function PetNoticeConfig:getSmallTabList()
	return self.pet_notice_small_tabCfg.dataList
end

function PetNoticeConfig:getSmallTabCfg(id)
	return self.pet_notice_small_tabCfg[id]
end

function PetNoticeConfig:getPetNewCfgs(index)
	local childCfg = self:getSmallTabCfg(index)

	return self:getPetNoticCfgs(childCfg.config_name)
end

function PetNoticeConfig:getOpenDateById(raceId)
	if self._petsnewdateCfg[raceId] then
		return self._petsnewdateCfg[raceId].startTime
	end
end

function PetNoticeConfig:getSkillCfgs()
	local tab = {}

	for i, v in pairs(self._petskilladjustCfg) do
		if v.showType == 1 then
			table.insert(tab, 1, v)
		end
	end

	ArraySort.sortOn(tab, "sort", ArraySort.DESCENDING)

	return tab
end

function PetNoticeConfig:getSkillCfgsOnPetId()
	local cfgs = self:getSkillCfgs()
	local dic = {}

	for i, v in ipairs(cfgs) do
		dic[v.petId] = dic[v.petId] or {}

		table.insert(dic[v.petId], v)
	end

	return dic
end

function PetNoticeConfig:getContractCfgs()
	local tab = {}

	for i, v in pairs(self._petcontractCfg) do
		if v.showType == 1 then
			if v.cPets == nil then
				v.cPets = string.splitToNumber(v.contractPet, "#")
				v.nPets = string.splitToNumber(v.newPet, "#")
			end

			table.insert(tab, v)
		end
	end

	return tab
end

function PetNoticeConfig:getArtifactAwakenCfgs()
	local tab = {}

	for i, v in pairs(self.artifact_awaken) do
		if v.showType == 1 then
			table.insert(tab, 1, v)
		end
	end

	ArraySort.sortOn(tab, "sort", ArraySort.DESCENDING)

	return tab
end

function PetNoticeConfig:getBigTabCfgBySmallTabIndex(smallTabIndex)
	local bigTabListCfgs = self:getBigTabList()

	for i1, v1 in ipairs(bigTabListCfgs) do
		if v1.childIndex and #v1.childIndex > 0 then
			for i2, smallIndex in ipairs(v1.childIndex) do
				if smallIndex == smallTabIndex then
					return v1
				end
			end
		end
	end

	return bigTabListCfgs[1]
end

PetNoticeConfig.instance = PetNoticeConfig.New()

return PetNoticeConfig
