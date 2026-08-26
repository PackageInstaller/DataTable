-- chunkname: @modules/logic/rouge/config/RougeConfig.lua

module("modules.logic.rouge.config.RougeConfig", package.seeall)

local RougeConfig = class("RougeConfig", BaseConfig)

function RougeConfig:reqConfigNames()
	return {
		"rouge_season",
		"rouge_const",
		"rouge_outside_const",
		"rouge_difficulty",
		"rouge_result",
		"rouge_badge",
		"rouge_ending",
		"rouge_last_reward",
		"rouge_style",
		"rouge_style_talent",
		"rouge_level",
		"rouge_active_skill",
		"rouge_map_skill",
		"rogue_collection_backpack",
		"rouge_genius_branch"
	}
end

local function getRougeSeasonCO(id)
	return lua_rouge_season.configDict[id]
end

function RougeConfig:_openList()
	local list = lua_rouge_season.configList
	local res = {
		0
	}

	for _, v in ipairs(list) do
		table.insert(res, v.id)
	end

	return res
end

function RougeConfig:onConfigLoaded(configName, configTable)
	if configName == "rouge_season" then
		self._openDict = {}

		self:_getOrCreateOpenDict()
	elseif configName == "rouge_difficulty" then
		self._difficultyDlcDict = {}
		self._difficultBaseDict = {}
		self._difficultyStartViewInfoDict = {}

		self:_getOrCreateDifficultyDict()
	elseif configName == "rouge_style" then
		self._styleBaseDict = {}
		self._styleDlcDict = {}

		self:_getOrCreateRougeStyleDict()
	elseif configName == "rouge_const" then
		self:_initConst()
	elseif configName == "rouge_genius_branch" then
		self._geniusBranchStartViewInfoDict = {}
		self._geniusBranchIdListWithStartView = {}
	end
end

function RougeConfig:_initConst()
	self._roleCapacity = self:_initRoleCapacity(RougeEnum.Const.RoleCapacity)
	self._roleHalfCapacity = self:_initRoleCapacity(RougeEnum.Const.RoleHalfCapacity)
end

function RougeConfig:_initRoleCapacity(constId)
	local roleCapacity = self:getConstValueByID(constId)
	local list = GameUtil.splitString2(roleCapacity, true, "|", "#")
	local capacityList = {}

	for i, v in ipairs(list) do
		local rare, capacity = v[1], v[2]

		capacityList[rare] = capacity
	end

	return capacityList
end

function RougeConfig:getRoleCapacity(rare)
	return self._roleCapacity[rare] or 1
end

function RougeConfig:getRoleHalfCapacity(rare)
	return self._roleHalfCapacity[rare] or 1
end

function RougeConfig:getSeasonAndVersion(seasonVersionId)
	local CO = getRougeSeasonCO(seasonVersionId)

	return CO.season, CO.version
end

function RougeConfig:getConstValueByID(id)
	local CO = lua_rouge_const.configDict[id]

	return CO.value
end

function RougeConfig:getConstNumValue(id)
	return tonumber(self:getConstValueByID(id))
end

function RougeConfig:getOutSideConstValueByID(id)
	local CO = lua_rouge_outside_const.configList[id]

	return CO.value
end

function RougeConfig:_getOrCreateDifficultyDict()
	local season = self:season()

	if self._difficultBaseDict[season] then
		return self._difficultBaseDict[season], self._difficultyDlcDict[season]
	end

	local dlcRes = {}
	local baseRes = {}

	self._difficultyDlcDict[season] = dlcRes
	self._difficultBaseDict[season] = baseRes

	if lua_rouge_difficulty.configDict[season] then
		for _, CO in pairs(lua_rouge_difficulty.configDict[season]) do
			if string.nilorempty(CO.version) then
				table.insert(baseRes, CO)
			else
				local versions = RougeDLCHelper.versionStrToList(CO.version)

				for _, version in ipairs(versions) do
					dlcRes[version] = dlcRes[version] or {}

					if self:isRougeSeasonIdOpen(version) then
						table.insert(dlcRes[version], CO)
					end
				end
			end
		end
	end

	for _, v in pairs(dlcRes) do
		table.sort(v, function(a, b)
			if a.difficulty ~= b.difficulty then
				return a.difficulty < b.difficulty
			end

			return false
		end)
	end

	return baseRes, dlcRes
end

function RougeConfig:_getOrCreateOpenDict()
	local season = self:season()

	if self._openDict[season] then
		return self._openDict[season]
	end

	local res = {}

	self._openDict[season] = res

	local list = self:_openList()

	for _, id in ipairs(list) do
		res[id] = true
	end

	return res
end

function RougeConfig:_getOrCreateRougeStyleDict()
	local season = self:season()

	if self._styleBaseDict[season] then
		return self._styleBaseDict[season], self._styleDlcDict[season]
	end

	local dlcRes = {}
	local baseRes = {}

	self._styleBaseDict[season] = baseRes
	self._styleDlcDict[season] = dlcRes

	if lua_rouge_style.configDict[season] then
		for _, CO in pairs(lua_rouge_style.configDict[season]) do
			if string.nilorempty(CO.version) then
				table.insert(baseRes, CO)
			else
				local versions = RougeDLCHelper.versionStrToList(CO.version)

				for _, version in ipairs(versions) do
					dlcRes[version] = dlcRes[version] or {}

					if self:isRougeSeasonIdOpen(version) then
						table.insert(dlcRes[version], CO)
					end
				end
			end
		end
	end

	for _, v in pairs(dlcRes) do
		table.sort(v, function(a, b)
			return a.id < b.id
		end)
	end

	return baseRes, dlcRes
end

function RougeConfig:isRougeSeasonIdOpen(lua_rouge_season_id)
	local dict = self:_getOrCreateOpenDict()

	return not not dict[lua_rouge_season_id]
end

function RougeConfig:getDifficultyCOList(outList, versionList)
	if not versionList or #versionList <= 0 then
		return
	end

	local collectMap = {}

	for _, version in ipairs(versionList) do
		local _, dlcDict = self:_getOrCreateDifficultyDict()
		local list = dlcDict and dlcDict[version]

		if list then
			for _, CO in ipairs(list) do
				if RougeDLCHelper.isCurrentUsingContent(CO.version) and not collectMap[CO.difficulty] then
					table.insert(outList, CO)

					collectMap[CO.difficulty] = true
				end
			end
		end
	end
end

function RougeConfig:getStylesCOList(outList, versionList)
	if not versionList or #versionList <= 0 then
		return
	end

	local _, dlcDict = self:_getOrCreateRougeStyleDict()
	local collectMap = {}

	for _, version in ipairs(versionList) do
		local list = dlcDict and dlcDict[version]

		if list then
			for _, CO in ipairs(list) do
				if RougeDLCHelper.isCurrentUsingContent(CO.version) and not collectMap[CO.id] then
					table.insert(outList, CO)

					collectMap[CO.id] = true
				end
			end
		end
	end
end

function RougeConfig:getStyleConfig(id)
	local season = self:season()

	return lua_rouge_style.configDict[season][id]
end

function RougeConfig:getSeasonStyleConfigs()
	local season = self:season()

	return lua_rouge_style.configDict[season]
end

function RougeConfig:getCollectionBackpackCO(rouge_style_id)
	local layoutId = self:getStyleConfig(rouge_style_id).layoutId

	return lua_rogue_collection_backpack.configDict[layoutId]
end

function RougeConfig:getDifficultyCO(difficulty)
	local season = self:season()

	return lua_rouge_difficulty.configDict[season][difficulty]
end

function RougeConfig:getDifficultyCOStartViewInfo(difficulty)
	if not difficulty then
		return {}
	end

	local season = self:season()
	local seasonDict = self._difficultyStartViewInfoDict[season]

	if seasonDict and seasonDict[difficulty] then
		return seasonDict[difficulty]
	end

	self._difficultyStartViewInfoDict[season] = self._difficultyStartViewInfoDict[season] or {}

	local dict = {}

	self._difficultyStartViewInfoDict[season][difficulty] = dict

	local CO = self:getDifficultyCO(difficulty)
	local startView = CO.startView
	local startViewList = GameUtil.splitString2(startView, false, "|", "#")

	if not startViewList then
		return dict
	end

	for _, args in ipairs(startViewList) do
		local StartViewEnum = args[1]

		assert(RougeEnum.StartViewEnum[StartViewEnum], "unsupported error excel:R肉鸽表.xlsx export_难度表.sheet difficulty=" .. difficulty .. " 列'startView'=" .. startView .. " 配了代码未支持的类型:" .. StartViewEnum)

		local delta = tonumber(args[2]) or 0

		dict[StartViewEnum] = (dict[StartViewEnum] or 0) + delta
	end

	return dict
end

function RougeConfig:getDifficultyCOStartViewDeltaValue(difficulty, eStartViewEnum)
	local dict = self:getDifficultyCOStartViewInfo(difficulty)

	return dict[eStartViewEnum] or 0
end

function RougeConfig:getDifficultyCOTitle(difficulty)
	return self:getDifficultyCO(difficulty).title
end

function RougeConfig:getActiveSkillCO(id)
	local activeSkillCo = lua_rouge_active_skill.configDict[id]

	if not activeSkillCo then
		logError("缺少肉鸽激活技能配置, 技能id :" .. tostring(id))
	end

	return activeSkillCo
end

function RougeConfig:getMapSkillCo(id)
	local mapSkillCo = lua_rouge_map_skill.configDict[id]

	if not mapSkillCo then
		logError("缺少肉鸽地图技能配置, 地图技能id :" .. tostring(id))
	end

	return mapSkillCo
end

function RougeConfig:getRougeBadgeCO(season, badgeId)
	return lua_rouge_badge.configDict[season][badgeId]
end

function RougeConfig:getEndingCO(endingId)
	local endCo = lua_rouge_ending.configDict[endingId]

	if not endCo then
		logError("rouge end config not exist, endId : " .. tostring(endingId))

		return
	end

	return endCo
end

function RougeConfig:getLastRewardCO(id)
	local season = self:season()

	return lua_rouge_last_reward.configDict[season][id]
end

function RougeConfig:getStyleLockDesc(id)
	local styleCO = self:getStyleConfig(id)
	local unlockType = styleCO.unlockType

	if not unlockType or unlockType == 0 then
		return ""
	end

	return RougeMapUnlockHelper.getLockTips(unlockType, styleCO.unlockParam)
end

function RougeConfig:getAbortCDDuration()
	return math.max(0, self:getConstNumValue(44) or 0)
end

function RougeConfig:getDifficultyCOListByVersions(versionList)
	local res = {}
	local baseRes = self:_getOrCreateDifficultyDict()

	tabletool.addValues(res, baseRes)
	self:getDifficultyCOList(res, versionList)
	table.sort(res, function(a, b)
		if a.difficulty ~= b.difficulty then
			return a.difficulty < b.difficulty
		end

		if a.version ~= b.version then
			return a.version < b.version
		end

		return false
	end)

	return res
end

function RougeConfig:getStyleCOListByVersions(versionList)
	local res = {}
	local baseRes = self:_getOrCreateRougeStyleDict()

	tabletool.addValues(res, baseRes)
	self:getStylesCOList(res, versionList)
	table.sort(res, function(a, b)
		return a.id < b.id
	end)

	return res
end

function RougeConfig:getGeniusBranchCO(geniusBranchId)
	local season = self:season()

	return lua_rouge_genius_branch.configDict[season][geniusBranchId]
end

function RougeConfig:getGeniusBranchStartViewInfo(geniusBranchId)
	if not geniusBranchId then
		return {}
	end

	local season = self:season()
	local seasonDict = self._geniusBranchStartViewInfoDict[season]

	if seasonDict and seasonDict[geniusBranchId] then
		return seasonDict[geniusBranchId]
	end

	self._geniusBranchStartViewInfoDict[season] = self._geniusBranchStartViewInfoDict[season] or {}

	local dict = {}

	self._geniusBranchStartViewInfoDict[season][geniusBranchId] = dict

	local CO = self:getGeniusBranchCO(geniusBranchId)
	local startView = CO.startView
	local startViewList = GameUtil.splitString2(startView, false, "|", "#")

	if not startViewList then
		return dict
	end

	for _, args in ipairs(startViewList) do
		local StartViewEnum = args[1]

		assert(RougeEnum.StartViewEnum[StartViewEnum], "unsupported error R肉鸽局外表.xlsx export_天赋分支表.sheet id=" .. geniusBranchId .. " 列'startView'=" .. startView .. " 配了代码未支持的类型:" .. StartViewEnum)

		local delta = tonumber(args[2]) or 0

		dict[StartViewEnum] = (dict[StartViewEnum] or 0) + delta
	end

	return dict
end

function RougeConfig:getGeniusBranchStartViewDeltaValue(geniusBranchId, eStartViewEnum)
	local dict = self:getGeniusBranchStartViewInfo(geniusBranchId)

	return dict[eStartViewEnum] or 0
end

function RougeConfig:getGeniusBranchIdListWithStartView()
	local season = self:season()
	local seasonDict = self._geniusBranchIdListWithStartView[season]

	if seasonDict then
		return seasonDict
	end

	local list = {}

	self._geniusBranchIdListWithStartView[season] = list

	local configDictSeason = lua_rouge_genius_branch.configDict[season]

	for _, CO in pairs(configDictSeason) do
		if not string.nilorempty(CO.startView) then
			table.insert(list, CO.id)
		end
	end

	return list
end

function RougeConfig:getSkillCo(skillType, skillId)
	if skillType == RougeEnum.SkillType.Map then
		return self:getMapSkillCo(skillId)
	elseif skillType == RougeEnum.SkillType.Style then
		return self:getActiveSkillCO(skillId)
	else
		logError("未定义的技能类型:" .. tostring(skillType))
	end
end

function RougeConfig:season()
	assert(false, "please override this function")
end

function RougeConfig:openUnlockId()
	assert(false, "please override this function")
end

function RougeConfig:achievementJumpId()
	assert(false, "please override this function")
end

RougeConfig.instance = RougeConfig.New()

return RougeConfig
