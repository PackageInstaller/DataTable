-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/config/AirWorkShopConfig.lua

module("logic.extensions.airworkshop.config.AirWorkShopConfig", package.seeall)

local M = class("AirWorkShopConfig", BaseConfig)

function M:onInit()
	self._msgCO = {}
end

function M:getNames()
	return {
		ConfigName.AirAtkConst,
		ConfigName.AirStudioLevel,
		ConfigName.AirAtkPoint,
		ConfigName.AirStudioMessageJoiner,
		ConfigName.AirStudioMessagePhrase,
		ConfigName.AirStudioMessageWord,
		ConfigName.AirStudioMessageWordType,
		ConfigName.AirStudioPassPercent,
		ConfigName.AirStudioPlayCount,
		ConfigName.AirStudioPool,
		ConfigName.AirStudioTheme,
		ConfigName.AirStudioScene,
		ConfigName.AirStudioBuilding,
		ConfigName.AirStudioWinCondition,
		ConfigName.AirStudioPlanLimit,
		ConfigName.AirStudioAmbushCondition,
		ConfigName.AirStudioTag,
		ConfigName.AirStudioConst,
		ConfigName.AirStudioMessageCondition,
		ConfigName.AirStudioTask,
		ConfigName.AirAtkFree,
		ConfigName.AirTemplate,
		ConfigName.AirExplain
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)
end

function M:getAtkConst(key)
	local data = self:getConfig(ConfigName.AirAtkConst)

	return data[key]
end

function M:getStudioConst(key)
	local data = self:getConfig(ConfigName.AirStudioConst)

	return data[key]
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg.dataList
end

function M:getConfigByKey(cfgName, key, noPrintWhileNotFound)
	local cfg = self:getConfig(cfgName)

	if cfg then
		return cfg[key]
	end

	if not noPrintWhileNotFound then
		printError(string.format("no config with name: t_%s", cfgName))
	end
end

function M:getCreateMaxLevel()
	if not self._createMaxLv then
		local maxLv = 1

		for _, _cfg in ipairs(self:getConfigList(ConfigName.AirStudioLevel) or {}) do
			maxLv = maxLv < _cfg.lv and _cfg.lv or maxLv
		end

		self._createMaxLv = maxLv
	end

	return self._createMaxLv
end

function M:getRodeoLvRange()
	if not self._rodeoMinLv then
		local cfgLst = self:getConfigList(ConfigName.AirAtkPoint)
		local minLv = 1
		local maxLv = 1

		for k, v in pairs(cfgLst or {}) do
			minLv = minLv > v.lv and v.lv or minLv
			maxLv = maxLv < v.lv and v.lv or maxLv
		end

		self._rodeoMinLv = minLv
		self._rodeoMaxLv = maxLv
	end

	return self._rodeoMinLv, self._rodeoMaxLv
end

function M:getRodeoPartLvRange()
	if not self._rodeoPartMinLv then
		local cfgLst = self:getConfigList(ConfigName.AirAtkPoint)
		local minLv = 1
		local maxLv = 1

		for k, v in pairs(cfgLst or {}) do
			minLv = minLv > v.part and v.part or minLv
			maxLv = maxLv < v.part and v.part or maxLv
		end

		self._rodeoPartMinLv = minLv
		self._rodeoPartMaxLv = maxLv
	end

	return self._rodeoPartMinLv, self._rodeoPartMaxLv
end

function M:getRodeoPartLvName(lv)
	if not self._rodeoPartLvName then
		self._rodeoPartLvName = {}

		local cfgLst = self:getConfigList(ConfigName.AirAtkPoint)

		for k, v in pairs(cfgLst or {}) do
			if not self._rodeoPartLvName[v.part] then
				self._rodeoPartLvName[v.part] = v.partName
			end
		end
	end

	return self._rodeoPartLvName[lv]
end

function M:getChallengeNumRecoveryTime()
	if not self._challengeNumRecoveryTime then
		self._challengeNumRecoveryTime = self:getAtkConst("ChallengeNumRecoveryTime").numValue
	end

	return self._challengeNumRecoveryTime
end

function M:getMaxChallengeNum()
	if not self._maxChallengeNum then
		self._maxChallengeNum = self:getAtkConst("MaxChallengeNum").numValue
	end

	return self._maxChallengeNum
end

function M:getAllUnlockTyp()
	if not self._allUnlockTyp then
		self._allUnlockTyp = {
			GameEnum.UnlockTypeEnum.WinCondition,
			GameEnum.UnlockTypeEnum.PlanLimit,
			GameEnum.UnlockTypeEnum.MessagePhrase,
			GameEnum.UnlockTypeEnum.MessageJoiner,
			GameEnum.UnlockTypeEnum.MessageWord
		}
	end

	return self._allUnlockTyp
end

function M:getMsgWorkLstByTyp(typ)
	if not self._msgWorkMap then
		self._msgWorkMap = {}

		local cfgLst = self:getConfigList(ConfigName.AirStudioMessageWord)

		for _, cfg in ipairs(cfgLst or {}) do
			if not self._msgWorkMap[cfg.type] then
				self._msgWorkMap[cfg.type] = {}
			end

			table.insert(self._msgWorkMap[cfg.type], cfg)
		end
	end

	if not self._msgWorkMap[typ] then
		printError(string.format("无法在[t_%s]找到typ[%s]的词汇", ConfigName.AirStudioMessageWord, typ))
	end

	return self._msgWorkMap[typ] or {}
end

function M:getMsgCO(typeEnum, id)
	if not self._msgCO[typeEnum] then
		self._msgCO[typeEnum] = {}
	end

	if not self._msgCO[typeEnum][id] then
		local msgTypEnum = GameEnum.AirMsgTextEnum
		local data = {}
		local wordType = 0
		local lockDesc = "未解锁"
		local content = LeaveMsgEnum.EmptyMarkEdit

		if id > 0 then
			if typeEnum == msgTypEnum.Phrase then
				local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioMessagePhrase, id)

				if cfg then
					content = cfg.content or content
				end
			elseif typeEnum == msgTypEnum.Joiner then
				local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioMessageJoiner, id)

				if cfg then
					content = cfg.content or content
				end
			elseif typeEnum == msgTypEnum.Word then
				local cfg = AirWorkShopConfig.instance:getConfigByKey(ConfigName.AirStudioMessageWord, id)

				content = cfg and cfg.content or content
				wordType = cfg and cfg.type or wordType
			end
		end

		data.content = content
		data.wordType = wordType
		data.lockDesc = lockDesc

		local needWordCount = 0

		if typeEnum == msgTypEnum.Phrase then
			for w in string.gmatch(content, "%%s") do
				needWordCount = needWordCount + 1
			end
		end

		data.needWordCount = needWordCount

		if needWordCount > 0 then
			local tmpLst = {}

			for i = 1, needWordCount do
				table.insert(tmpLst, LeaveMsgEnum.EmptyMarkEdit)
			end

			data.tabContent = string.format(content, unpack(tmpLst))
		else
			data.tabContent = content
		end

		data.id = id
		data.NOData = {
			id = id,
			type = typeEnum
		}
		self._msgCO[typeEnum][id] = data
	end

	return self._msgCO[typeEnum][id]
end

function M:getSceneCO(id)
	local data = self:getConfig(ConfigName.AirStudioScene)

	return data[id]
end

function M:getAllSceneCO()
	local data = self:getConfig(ConfigName.AirStudioScene)

	return data.dataList
end

function M:getAllTheme()
	local data = self:getConfig(ConfigName.AirStudioTheme)

	return data.dataList
end

function M:getAllBuildingCO()
	local data = self:getConfig(ConfigName.AirStudioBuilding)

	return data.dataList
end

function M:getBuildingCO(id)
	local data = self:getConfig(ConfigName.AirStudioBuilding)

	return data[id]
end

function M:getAmbushConditionCO(condition)
	local data = self:getConfig(ConfigName.AirStudioAmbushCondition)

	return data[condition]
end

function M:getAllAmbushConditionCO()
	local data = self:getConfig(ConfigName.AirStudioAmbushCondition)

	return data.dataList
end

function M:getMessageConditionCO(condition)
	local data = self:getConfig(ConfigName.AirStudioMessageCondition)

	return data[condition]
end

function M:getAllMessageConditionCO()
	local data = self:getConfig(ConfigName.AirStudioMessageCondition)

	return data.dataList
end

function M:getAllAirTemplateCO()
	local data = self:getConfig(ConfigName.AirTemplate)

	return data.dataList
end

function M:getAllAirTemplateCOBySceneId(sceneId, outTemplateCO)
	local data = self:getConfig(ConfigName.AirTemplate)

	sceneId = tostring(sceneId)

	for k, v in pairs(data.dataList) do
		if v.sceneId == sceneId then
			table.insert(outTemplateCO, v)
		end
	end
end

function M:getAllAirExplainCO()
	local data = self:getConfig(ConfigName.AirExplain)

	return data.dataList
end

M.instance = M.New()

return M
