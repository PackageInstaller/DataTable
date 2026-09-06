-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/character/config/CharacterConfig.lua

module("logic.extensions.character.config.CharacterConfig", package.seeall)

local CharacterConfig = class("CharacterConfig", BaseConfig)
local defaultModelCfg = {
	0,
	0,
	1
}

CharacterConfig.MAX_AWAKE_LVL = 6
CharacterConfig.MIN_TALENT_LVL = 0
CharacterConfig.MIN_AWAKE_LVL = 0
CharacterConfig.MAX_STAR_LVL = 6
CharacterConfig.MAX_STAR_SLOT_COUNT = 4

function CharacterConfig:onInit()
	self._modelCfg = nil
	self._petCfg = nil
	self._formationPetCfg = nil
	self._petInfoCfg = nil
	self._petExpCfg = nil
	self._petCvCfg = nil
	self._petTalent = nil
	self._petBondsOnFrom = nil
	self._petBondsCollect = nil
	self._maxTalentLv = 0
end

function CharacterConfig:getNames()
	return {
		"model",
		"pet",
		"formation_pets",
		"pet_info",
		"pet_lvup_strategy",
		"pet_cv",
		"model_configs",
		"pet_job",
		"pet_awaken",
		"pet_talent",
		"pet_skill_level_info",
		"pet_star_equipment",
		"pet_awaken_cost_strategy",
		"pet_awaken_strategy",
		"pet_formation_onekey",
		"pet_formation_onekey_pos",
		"pet_awaken_rare",
		"pet_property_strategy",
		"pet_property_zdl",
		"pet_relation_ship_collect",
		"pet_relation_ship_on_form",
		"formation_grade",
		"formation_grade_content",
		"formation_location_kezhi",
		"pet_skill_level_strategy",
		"followedpet_words",
		"poster_model",
		"pet_initial_strength"
	}
end

function CharacterConfig:handleConfig(name, content)
	if name == "model" then
		self._modelCfg = content
	elseif name == "model_configs" then
		self._modelUICfg = content
	elseif name == "pet" then
		self._petCfg = content

		self:_handlePets()
	elseif name == "formation_pets" then
		self._formationPetCfg = content
	elseif name == "pet_info" then
		self._petInfoCfg = content
	elseif name == "pet_lvup_strategy" then
		self._talentLimits = {}

		table.sort(content.dataList, function(a, b)
			return a.petLv < b.petLv
		end)

		for _, v in ipairs(content.dataList) do
			if v.petLv > 100 then
				break
			end

			local temp = checknumber(self._talentLimits[v.talentLevel])

			self._talentLimits[v.talentLevel] = math.max(temp, v.petLv)
			self._maxTalentLv = math.max(self._maxTalentLv, v.talentLevel)
		end

		self._petExpCfg = content
	elseif name == "pet_cv" then
		self._petCvCfg = content
	elseif name == "pet_job" then
		self._petJob = content
	elseif name == "pet_awaken" then
		self._petAwaken = content
	elseif name == "pet_talent" then
		self._petTalent = content
	elseif name == "pet_star_equipment" then
		self._petEquip = content
	elseif name == "pet_awaken_cost_strategy" then
		self._awakenCost = content
	elseif name == "pet_awaken_strategy" then
		self._awakenStrategy = content
	elseif name == "pet_awaken_rare" then
		self._awakenRare = content
	elseif name == "formation_grade" then
		self.formation_grade = content
	elseif name == "formation_grade_content" then
		self.formation_grade_content = content
	elseif name == "formation_location_kezhi" then
		self.formation_location_kezhi = content
	elseif name == "pet_formation_onekey" then
		self.formation_onekey = content
	elseif name == "pet_formation_onekey_pos" then
		self.formation_onekey_pos = content
	elseif name == "pet_property_strategy" then
		self._pet_property_strategy = content
	elseif name == "pet_property_zdl" then
		self._pet_property_zdl = content
	elseif name == "pet_relation_ship_collect" then
		self._pet_relation_ship_collect = content
		self._petBondsCollect = {}

		for _, v in ipairs(content.dataList) do
			if v.show then
				self._petBondsCollect[tonumber(v.raceId)] = self._petBondsCollect[tonumber(v.raceId)] or {}

				table.insert(self._petBondsCollect[tonumber(v.raceId)], v)
			end
		end

		self._attrMap = {}

		for i, v in ipairs(GameEnum.AttrTypeName) do
			self._attrMap[v] = i
		end

		self._formulaPropertyTypeMap = {}

		for _, data in ipairs(content.dataList) do
			local propertyTypes = string.split(data.formulaPropertyType, "#")
			local typeMap = {}

			for i, v in ipairs(propertyTypes) do
				local type = self._attrMap[v]

				typeMap[type] = true
			end

			self._formulaPropertyTypeMap[data.id] = typeMap
		end
	elseif name == "pet_relation_ship_on_form" then
		self.pet_relation_ship_on_form = content
		self._petBondsOnFrom = {}

		for _, v in ipairs(content.dataList) do
			if v.show then
				self._petBondsOnFrom[tonumber(v.raceId)] = self._petBondsOnFrom[tonumber(v.raceId)] or {}

				table.insert(self._petBondsOnFrom[tonumber(v.raceId)], v)
			end
		end
	elseif name == "pet_skill_level_strategy" then
		self._petSkillStrategyCfg = content
	elseif name == "pet_skill_level_info" then
		self._petSkillInfoCfg = content
	elseif name == "followedpet_words" then
		self._followPetWords = content
	elseif name == "poster_model" then
		self.poster_modelCfg = content
	elseif name == "pet_initial_strength" then
		self.pet_initial_strengthCfg = content
	end
end

function CharacterConfig:getInitStrengthCfg(raceId)
	return self.pet_initial_strengthCfg[raceId] or {}
end

function CharacterConfig:getPropZdlValue(attribute)
	if self._pet_property_zdl[attribute] then
		return self._pet_property_zdl[attribute].zdlUnit
	end

	return 0
end

function CharacterConfig:getFormationOnekey(attr, pos)
	return self.formation_onekey[attr][pos]
end

function CharacterConfig:getFormationOnekeyPos(attr, idx)
	return self.formation_onekey_pos[attr]["p" .. idx]
end

function CharacterConfig:getFormationGradeList()
	return self.formation_grade.dataList
end

function CharacterConfig:getFormationGradeContent(key)
	return self.formation_grade_content[key]
end

function CharacterConfig:getFormationLocKezhi(key)
	if key and self.formation_location_kezhi[key] then
		return self.formation_location_kezhi[key].de_location
	end
end

function CharacterConfig:_handlePets()
	for k, v in pairs(self._petCfg.dataList) do
		local modelCo = self:getModelCo(checknumber(v.faceIds))

		if modelCo then
			v.icon = modelCo.headName
		end
	end
end

function CharacterConfig:getJobCo(id)
	return self._petJob[id]
end

function CharacterConfig:getPetCfg()
	return self._petCfg.dataList
end

function CharacterConfig:getPetCo(raceId)
	return self._petCfg[raceId]
end

function CharacterConfig:getPetLvlStrategyCoByLvl(raceId, lvl)
	local cfg = self._pet_property_strategy[raceId]

	if cfg then
		return cfg[lvl]
	end
end

function CharacterConfig:getPetCfgs()
	return self._petCfg
end

function CharacterConfig:getModelCo(id)
	local cfg = PetSkinConfig.instance:getPetSkinCfg(id)

	if cfg and cfg.skinGroup > 0 then
		return self._modelCfg[cfg.skinGroup]
	end

	return self._modelCfg[id]
end

function CharacterConfig:getPosterModelCo(id)
	return self.poster_modelCfg[id]
end

function CharacterConfig:getPosterModelCos()
	return self.poster_modelCfg.dataList
end

function CharacterConfig:getPosterModelCosNoHidden()
	local posterModelCosCfg = {}

	for i, cfg in ipairs(self.poster_modelCfg.dataList) do
		if cfg.isHideInPreview == 0 then
			table.insert(posterModelCosCfg, cfg)
		end
	end

	return posterModelCosCfg
end

function CharacterConfig:getFormationPetCfg()
	return self._formationPetCfg.dataList
end

function CharacterConfig:getFormationPetCo(id)
	return self._formationPetCfg[id]
end

function CharacterConfig:getPetInfoCfg()
	return self._petInfoCfg
end

function CharacterConfig:getPetInfoCo(id)
	return self._petInfoCfg[id] or {}
end

function CharacterConfig:CheckHasTowAsset(faceId)
	local cfg = self:getModelCo(checknumber(faceId))

	if cfg ~= nil then
		local bustName = cfg.bustName
		local resName = cfg.resName

		return not string.nilorempty(bustName) and not string.nilorempty(resName)
	end

	return false
end

function CharacterConfig:GetCharacterResIdx(faceId, isAtuo)
	local cfg = self:getModelCo(checknumber(faceId))
	local resPath

	if cfg ~= nil then
		local bustName = cfg.bustName
		local resName = cfg.resName

		if isAtuo then
			if not string.nilorempty(bustName) then
				resPath = GameUrl.getLihuiSpineUIUrl(bustName)

				return 2, resPath
			end

			if not string.nilorempty(resName) then
				resPath = GameUrl.getSpineUIUrl(resName)

				return 1, resPath
			end

			if Framework.OSDef.isEditor then
				return 999, GameUrl._checkDefultSpineUIPath("***布阵的" .. faceId .. "资源***")
			end
		else
			if not string.nilorempty(resName) then
				resPath = GameUrl.getSpineUIUrl(resName)

				return 1, resPath
			end

			if Framework.OSDef.isEditor then
				return 999, GameUrl._checkDefultSpineUIPath("**布阵的" .. faceId .. "资源**")
			end
		end
	end

	return nil, nil
end

function CharacterConfig:GetCharacterAsset(faceId, cb)
	local resName = self:getModelCo(checknumber(faceId)).resName
	local resPath = GameUrl.getSpineUrl(resName)

	local function onLoaded(res)
		if res.IsSuccess ~= true then
			return
		end

		local asset = res:GetAsset(nil, nil)

		if cb then
			cb(asset)
		end
	end

	getres(resPath, onLoaded, nil, ResType.AssetBundle, true)
end

function CharacterConfig:GetCharacterUIAsset(faceId, cb)
	local resPath = ""
	local bustName = self:getModelCo(checknumber(faceId)).bustName

	if not string.nilorempty(bustName) then
		resPath = GameUrl.getLihuiSpineUIUrl(bustName)
	else
		local resName = self:getModelCo(checknumber(faceId)).resName

		resPath = GameUrl.getSpineUIUrl(resName)
	end

	local function onLoaded(res)
		if res.IsSuccess ~= true then
			return
		end

		local asset = res:GetAsset(nil, nil)

		if cb then
			cb(asset)
		end
	end

	getres(resPath, onLoaded, nil, ResType.AssetBundle, true)
end

function CharacterConfig:GetOtherCharacterUIAsset(faceId, cb)
	local resPath = ""
	local resName = self:getModelCo(checknumber(faceId)).resName

	if not string.nilorempty(resName) then
		resPath = GameUrl.getSpineUIUrl(resName)

		local function onLoaded(res)
			if res.IsSuccess ~= true then
				return
			end

			local asset = res:GetAsset(nil, nil)

			if cb then
				cb(asset)
			end
		end

		getres(resPath, onLoaded, nil, ResType.AssetBundle, true)
	end
end

function CharacterConfig:GetSkeletondata(id)
	local resName = self:getModelCo(checknumber(id)).resName

	return GameUrl.getSpineAssetRrl(resName)
end

function CharacterConfig:GetCurLevelExp(raceId, curLv)
	local cfg = self:getPetCo(raceId)
	local maxLv = cfg.maxLv

	if maxLv < curLv then
		return 0
	end

	local lvUpStrategy = cfg.lvUpStrategy
	local key = "s" .. lvUpStrategy

	return tonumber((self._petExpCfg[curLv] ~= nil or nil) and self._petExpCfg[curLv][key]) or 0
end

function CharacterConfig:GetLevelExpByLevel(raceId, curLv)
	local nextExp = self:GetCurLevelExp(raceId, curLv + 1)

	if nextExp == 0 then
		return 0
	end

	local curExp = self:GetCurLevelExp(raceId, curLv)

	return nextExp - curExp
end

function CharacterConfig:getTalentLevelByLevel(curLv)
	local lvCfg = self._petExpCfg[curLv]

	return lvCfg.talentLevel
end

function CharacterConfig:GetMaxLevel(faceId)
	local cfg = self:getPetCo(faceId)

	return cfg.maxLv
end

function CharacterConfig:GetCurExpLevel(raceId, curExp)
	local cfg = self:getPetCo(raceId)
	local maxLv = cfg.maxLv
	local lvUpStrategy = cfg.lvUpStrategy
	local key = "s" .. lvUpStrategy
	local lvl = 0
	local lvlExp = 0

	for i = maxLv, 1, -1 do
		lvl = i

		local exp = 0

		if self._petExpCfg[lvl] ~= nil then
			exp = tonumber(self._petExpCfg[lvl][key])

			if exp ~= nil and exp <= curExp then
				lvlExp = exp

				break
			end
		end
	end

	return lvl, curExp - lvlExp
end

function CharacterConfig:getPetExpCfg(level)
	return self._petExpCfg[level]
end

function CharacterConfig:getPetCvCfg(raceId)
	return self._petCvCfg[raceId]
end

function CharacterConfig:getModelUIPosAndScale(viewName, modelId, spareViewname)
	modelId = checknumber(modelId)

	local cfg = PetSkinConfig.instance:getPetSkinCfg(modelId)

	if cfg and cfg.skinGroup > 0 then
		modelId = cfg.skinGroup
	end

	if not self._modelUICfg then
		return defaultModelCfg
	end

	local modeUICo = self._modelUICfg[modelId]

	if not modeUICo then
		return defaultModelCfg
	end

	if not modeUICo[viewName] then
		local cfg = modeUICo[spareViewname]

		if cfg then
			return cfg
		end

		return defaultModelCfg
	end
end

function CharacterConfig:getMaxAwaken(raceId)
	local cfg = MaterialMgr.getMatCfg(MatType.Pet, raceId)
	local maxAwaken = 0
	local initAwakenLv = 0

	if cfg and cfg.awakenCostStrategyId > 0 then
		initAwakenLv = checknumber(cfg.initAwakenLv)

		local t = self:getPetAwakenCfgs(cfg.awakenStrategyId)

		for _, v in pairs(t) do
			maxAwaken = math.max(v.awakenLevel, maxAwaken)
		end
	end

	return maxAwaken, initAwakenLv
end

function CharacterConfig:getPetAwakenCostCfg(id, lv)
	if self._awakenCost and self._awakenCost[id] then
		return self._awakenCost[id][lv]
	end

	return nil
end

function CharacterConfig:getPetAwakenCostListCfgs(id)
	return self._awakenCost[id]
end

function CharacterConfig:getPetAwakenStrategyCfg(id, lv)
	if self._awakenStrategy and self._awakenStrategy[id] then
		return self._awakenStrategy[id][lv]
	end

	return nil
end

function CharacterConfig:getPetAwakenCfg(raceId, lv)
	raceId = checknumber(raceId)
	lv = checknumber(lv)

	if self._petAwaken and self._petAwaken[raceId] then
		return self._petAwaken[raceId][lv]
	else
		return nil
	end
end

function CharacterConfig:getPetAwakenCost(raceId, fromLvl, toLvl)
	if self._petAwaken and self._petAwaken[raceId] then
		local cost = 0

		for i = fromLvl + 1, toLvl do
			if self._petAwaken[raceId][i] then
				cost = cost + self._petAwaken[raceId][i].costCoinNum
			end
		end

		return cost
	end

	return 0
end

function CharacterConfig:getPetAwakenCfgs(id)
	if self._awakenStrategy then
		return self._awakenStrategy[id] or {}
	end

	return {}
end

function CharacterConfig:getPetTalentCfg(raceId, lv)
	raceId = checknumber(raceId)
	lv = checknumber(lv)

	if self._petTalent and self._petTalent[raceId] then
		return self._petTalent[raceId][lv]
	else
		return nil
	end
end

function CharacterConfig:getPetTalentCfgByRaceId(raceId)
	if self._petTalent then
		return self._petTalent[raceId]
	else
		return nil
	end
end

function CharacterConfig:getSkillMaxLv(raceId, skillType)
	local petCo = CharacterConfig.instance:getPetCo(raceId)

	return CharacterConfig.instance:getMaxSkillLevelCfgById(petCo.skillLevelStrategyId, skillType)
end

function CharacterConfig:getPetTalentSkillAddDes(raceId, lv, skinId)
	local t = self:getPetTalentSkillAdd(raceId, lv, skinId)
	local titles = {}

	for _, v in pairs(t) do
		table.insert(titles, v.title)
	end

	return titles
end

function CharacterConfig:getPetTalentSkillAdd(raceId, lv, skinId)
	local cfg = self:getPetTalentCfg(raceId, lv)
	local petCfg = self:getPetCo(raceId)
	local petSkinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)
	local skillIds = {}

	if not string.nilorempty(cfg.normalDesc) then
		local mo = {}

		mo.level = cfg.normalLv
		mo.desc = cfg.normalDesc
		skillIds[petSkinCfg.normalSkillId] = mo
	end

	if not string.nilorempty(cfg.ultDesc) then
		local mo = {}

		mo.level = cfg.ultLv
		mo.desc = cfg.ultDesc
		skillIds[petSkinCfg.ultSkillId] = mo
	end

	local t = {}

	for skillId, mo in pairs(skillIds) do
		local skillCfg = BattleConfig.instance:getSkillCo(skillId, skinId)

		if skillCfg ~= nil then
			local data = {}

			data.title = string.format("【%s】等级提升至%s级", skillCfg.name, mo.level)
			data.desc = mo.desc
			data.level = mo.level
			t[skillId] = data
		end
	end

	return t
end

function CharacterConfig:getPetEquipCfg(raceId)
	if self._petEquip ~= nil then
		return self._petEquip[raceId]
	end

	return nil
end

function CharacterConfig:getPetEquipByLvlCfg(raceId, starLevel)
	if self._petEquip ~= nil and self._petEquip[raceId] then
		return self._petEquip[raceId][starLevel]
	end

	return nil
end

function CharacterConfig:getRecommendEquipIds(raceId, starLevel, slotIndex)
	starLevel = math.min(CharacterConfig.MAX_STAR_LVL - 1, starLevel)

	local cfg = self:getPetEquipByLvlCfg(raceId, starLevel)

	if cfg ~= nil then
		local slots = cfg.slots

		if slots[slotIndex] ~= nil then
			return slots[slotIndex]
		end
	end

	return {}
end

function CharacterConfig:getRecommendEquipId(raceId, starLevel, slotIndex)
	local equipIds = self:getRecommendEquipIds(raceId, starLevel, slotIndex)

	if #equipIds > 0 then
		return checknumber(equipIds[1])
	end

	return 0
end

function CharacterConfig:getMaxLvByTalentLv(talentLevel)
	if self._talentLimits then
		local keys = table.keys(self._talentLimits)

		table.sort(keys, function(a, b)
			return b < a
		end)

		for i = 1, #keys do
			local key = keys[i]

			if key <= talentLevel then
				return self._talentLimits[key]
			end
		end

		return self._talentLimits[#keys]
	end

	return 0
end

function CharacterConfig:getNextTalentLv(talentLevel)
	local old = self:getMaxLvByTalentLv(talentLevel)

	for i = talentLevel + 1, CharacterConfig.instance:getMaxTalentLv() do
		local new = self:getMaxLvByTalentLv(i)

		if old < new then
			return i, new
		end
	end

	return -1, 0
end

function CharacterConfig:getSkillBuffs(raceId, skillType)
	if not self._awakenStrategy[raceId] then
		local buffList = {}

		for k, cfg in pairs(self._awakenStrategy[raceId]) do
			local buff

			if skillType == GameEnum.SkillRaceType.Normal and not string.nilorempty(cfg.normalDesc) then
				buff = {
					desc = cfg.normalDesc,
					level = cfg.normalLv
				}
			elseif skillType == GameEnum.SkillRaceType.Ult and not string.nilorempty(cfg.ultDesc) then
				buff = {
					desc = cfg.ultDesc,
					level = cfg.ultLv
				}
			elseif skillType == GameEnum.SkillRaceType.Passive and not string.nilorempty(cfg.passiveDesc) then
				buff = {
					desc = cfg.passiveDesc,
					level = cfg.passiveLv
				}
			end

			if buff then
				buff.awakeLevel = cfg.awakenLevel

				table.insert(buffList, buff)
			end
		end

		table.sort(buffList, function(a, b)
			return a.level < b.level
		end)

		return buffList
	end
end

function CharacterConfig:getTalentName(raceId, talentLv)
	local cfg = self:getPetTalentCfg(raceId, talentLv)

	if cfg and not string.nilorempty(cfg.talentName) then
		return cfg.talentName
	else
		return "未配置"
	end
end

function CharacterConfig:getAwakenRareCfg(awakenLv)
	if self._awakenRare then
		return self._awakenRare[awakenLv]
	end

	return nil
end

function CharacterConfig:getAwakenName(awakenLv)
	local cfg = self:getAwakenRareCfg(awakenLv)

	if cfg and cfg.name then
		return cfg.name
	end

	return langPara("觉醒%s", GameUtil.toRomanNumber(awakenLv))
end

function CharacterConfig:getAwakenNameWithRing(awakenLv)
	return self:getAwakenName(awakenLv)
end

function CharacterConfig:getRareByAwakenLv(awakenLv, raceId)
	raceId = checknumber(raceId)

	local rare = GameEnum.PetRare.N
	local cfg = self:getAwakenRareCfg(checknumber(awakenLv))

	if cfg and raceId then
		local petco = self:getPetCo(raceId)

		if petco then
			local pr = petco.rare

			if cfg["rare_" .. pr] then
				rare = cfg["rare_" .. pr]
			end
		end
	end

	return rare
end

function CharacterConfig:getInitRare(raceId)
	raceId = checknumber(raceId)

	local cfg = self:getPetCo(raceId)

	return (cfg or nil) and self:getRareByAwakenLv(cfg.initAwakenLv, raceId)
end

function CharacterConfig:getAwakenLvRangeByRare(rare)
	return
end

function CharacterConfig:getPetAwakenType(raceId, awakenLv)
	awakenLv = checknumber(awakenLv)

	local nextLv = awakenLv + 1
	local cfg = self:getPetCo(raceId)
	local awakenType = GameEnum.PetAwakenType.MaxLv

	if cfg ~= nil then
		local costCfg = CharacterConfig.instance:getPetAwakenCostCfg(checknumber(cfg.awakenCostStrategyId), nextLv)

		if costCfg ~= nil then
			local curRareCfg = self:getAwakenRareCfg(awakenLv)
			local nextRareCfg = self:getAwakenRareCfg(nextLv)
			local isNextUR = nextRareCfg.rare == GameEnum.PetRare.UR

			awakenType = nextRareCfg.rare > curRareCfg.rare and (isNextUR and GameEnum.PetAwakenType.UpRareUtl or GameEnum.PetAwakenType.UpRare) or isNextUR and GameEnum.PetAwakenType.UpSun or GameEnum.PetAwakenType.UpStar
		end
	end

	return awakenType
end

function CharacterConfig:getAwakenLvText(awakenLv)
	local awakenRareCfg = CharacterConfig.instance:getAwakenRareCfg(awakenLv)

	return awakenRareCfg.name
end

function CharacterConfig:getBondCfgsOnForm(raceId, isGetFirst)
	if raceId or self._petBondsOnFrom then
		local cfgs = self._petBondsOnFrom[tonumber(raceId)]

		if cfgs and isGetFirst then
			return cfgs[1]
		end

		return cfgs
	end

	return nil
end

function CharacterConfig:getBondCfgsCollect(raceId, isGetFirst)
	if raceId or self._petBondsCollect then
		local cfgs = self._petBondsCollect[tonumber(raceId)]

		if cfgs and isGetFirst then
			return cfgs[1]
		end

		return cfgs
	end

	return nil
end

function CharacterConfig:getFormulaPropertyTypeMap(id)
	return self._formulaPropertyTypeMap[id]
end

function CharacterConfig:getBondCfgsCollectIds(raceId)
	local list = self:getBondCfgsCollect(raceId)
	local res = {}

	for k, cfg in pairs(list or {}) do
		local hasAll = true

		for i, v in ipairs(cfg.relativeRaceIds or {}) do
			local petCfg = MaterialMgr.getMatCfg(MatType.Pet, v)

			if checknumber(petCfg.bookIds) == 0 then
				hasAll = false

				break
			end
		end

		if hasAll then
			table.insert(res, cfg.id)
		end
	end

	return res
end

function CharacterConfig:getBondCfgsCollectByID(id)
	return self._pet_relation_ship_collect[id]
end

function CharacterConfig:getBondCfgsFormByID(id)
	return self.pet_relation_ship_on_form[id]
end

function CharacterConfig:getMatchBondCfgOnFormByRaceId(raceId, petList, petId, petIdList, isUseBagPet)
	local cfgs = self:getBondCfgsOnForm(raceId)
	local matchCfgs = {}

	if cfgs and #cfgs > 0 and petList and #petList > 0 and table.indexof(petList, raceId) then
		for _, v in ipairs(cfgs) do
			local isMatch = false

			for _1, v1 in ipairs(v.relativeRaceIds) do
				if table.indexof(petList, v1) then
					isMatch = true

					break
				end
			end

			if isMatch then
				table.insert(matchCfgs, v)
			elseif isUseBagPet ~= false and self:checkHas4StarInBag(petId, v, petIdList) then
				table.insert(matchCfgs, v)
			end
		end

		return matchCfgs
	end

	return {}
end

function CharacterConfig:checkHas4StarInBag(petId, cfg, petIdList)
	if petId then
		local petMo = BagModel.instance:getPet(petId)

		if petMo and petMo.isMyPackPet and not petMo.isSupportedPet and not petMo.isHirePet and cfg then
			local activeNeedAwakenLv = checknumber(cfg.activeNeedAwakenLv)

			if petMo.awakeLevel > 0 and activeNeedAwakenLv <= petMo.awakeLevel then
				local relativeRaceIds = cfg.relativeRaceIds
				local isAll = false

				for i, v in ipairs(relativeRaceIds) do
					local boo = self:checkRaceInBag(v, activeNeedAwakenLv, petIdList)

					if boo then
						isAll = true

						return true
					end
				end

				return isAll
			end
		end
	end

	return false
end

function CharacterConfig:checkRaceInBag(raceId, awakelv, petIdList)
	local pets = BagModel.instance:getPets()

	for i, petMo in pairs(pets or {}) do
		if petMo:isExist() and petMo.raceId == raceId and petMo.awakeLevel > 0 and awakelv <= petMo.awakeLevel then
			table.insert(petIdList, petMo.petId)

			return true
		end
	end

	return false
end

function CharacterConfig:getMatchBondCfgOnForm(petList, petIdList, isUseBagPet)
	local matchCfgs

	if petList and #petList > 0 then
		for i, v in ipairs(petList) do
			matchCfgs = matchCfgs or {}

			local petId
			local cfgs = self:getMatchBondCfgOnFormByRaceId(v, petList, (petIdList or nil) and petIdList[i], petIdList, isUseBagPet) or {}

			for _1, v1 in ipairs(cfgs) do
				table.insert(matchCfgs, v1)
			end
		end

		return matchCfgs, petIdList
	end

	return {}, petIdList
end

local typeMap = {
	3,
	1,
	2,
	nil,
	nil,
	5,
	4
}

CharacterConfig.skillTypeMap = typeMap

function CharacterConfig:getSkillLevelStrategyById(skillLevelStrategyId, type, level)
	local serType = typeMap[type]

	return self._petSkillStrategyCfg[skillLevelStrategyId][serType][level]
end

function CharacterConfig:getSkillLevelCfgById(skillLevelStrategyId, serType, level)
	if self._petSkillStrategyCfg[skillLevelStrategyId] and self._petSkillStrategyCfg[skillLevelStrategyId][serType] then
		return self._petSkillStrategyCfg[skillLevelStrategyId][serType][level]
	end
end

function CharacterConfig:getMaxSkillLevelCfgById(skillLevelStrategyId, type)
	if self._petSkillStrategyCfg[skillLevelStrategyId] and self._petSkillStrategyCfg[skillLevelStrategyId][type] then
		return #self._petSkillStrategyCfg[skillLevelStrategyId][type]
	end

	return 0
end

function CharacterConfig:getSkillInfoById(skinId)
	local cfg = self._petSkillInfoCfg[skinId]

	if cfg == nil then
		local skinCfg = PetSkinConfig.instance:getPetSkinCfg(skinId)

		if skinCfg then
			cfg = self._petSkillInfoCfg[skinCfg.raceId]
		end
	end

	return cfg
end

function CharacterConfig:getSkillInfoByLvl(skinId, lvl)
	local cfg = self:getSkillInfoById(skinId)

	if cfg then
		return cfg[lvl]
	end
end

function CharacterConfig:getRandomPetFollowWords(chapter)
	local cfgs = self._followPetWords[chapter]

	if not cfgs then
		return
	end

	local idx = math.random(1, #cfgs)

	return cfgs[idx]
end

function CharacterConfig:getMaxTalentLv()
	return self._maxTalentLv
end

function CharacterConfig:getSignsList(signs)
	return (not string.nilorempty(signs) or nil) and string.split(signs, ",")
end

function CharacterConfig:checkHasSigns(raceId, sign)
	local cfgPet = self:getPetCo(raceId)

	if cfgPet then
		local signList = self:getSignsList(cfgPet.signs)

		for i, v in ipairs(signList) do
			if sign == v then
				return true
			end
		end
	end

	return false
end

function CharacterConfig:getPetName(raceId)
	local id = PetSkinConfig.instance:getPetSkinRaceId(raceId)

	if id > 0 then
		raceId = id
	end

	local data = self:getPetCo(raceId)

	return data and data.name
end

CharacterConfig.instance = CharacterConfig.New()

return CharacterConfig
