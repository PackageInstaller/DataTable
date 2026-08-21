-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/config/MainPerformConfig.lua

module("logic.extensions.mainui.config.MainPerformConfig", package.seeall)

local M = class("MainPerformConfig", BaseConfig)

function M:onInit()
	self._pointDefaultElementMap = nil
	self._interactPointMap = {}
	self._interactElementPGroup = {}
	self._performHero = {}
	self._modelId2landladyR = {}
	self._faceAnim = {}
end

function M:getNames()
	return {
		ConfigName.MainPerformConst,
		ConfigName.MainPerformFormula,
		ConfigName.MainInteractElement,
		ConfigName.MainInteractElementR,
		ConfigName.MainPerformLandladyR,
		ConfigName.MainPerformHero,
		ConfigName.MainPerformHeroR,
		ConfigName.MainPerformCameraR,
		ConfigName.MainPerformCamGroupChaSysR,
		ConfigName.MainPerformAnimixR,
		ConfigName.BattlePerformanceHeroPos,
		ConfigName.MainPerformFaceAnimR
	}
end

function M:handleConfig(name, content)
	M.super.handleConfig(self, name, content)

	if name == ConfigName.MainPerformConst then
		self._const = content
	elseif name == ConfigName.MainPerformFormula then
		-- block empty
	elseif name == ConfigName.MainInteractElement then
		for k, v in pairs(content.dataList or {}) do
			local point = v.interactPoint

			if not self._interactElementPGroup[point] then
				self._interactElementPGroup[point] = {}
			end

			table.insert(self._interactElementPGroup[point], v)

			if point >= 0 then
				self._interactPointMap[point] = 1
			end
		end
	elseif name == ConfigName.MainPerformHero then
		for k, v in pairs(content.dataList or {}) do
			if not self._performHero[v.id] then
				self._performHero[v.id] = {}
			end

			if not self._performHero[v.id][v.heroId] then
				self._performHero[v.id][v.heroId] = {}
			end

			self._performHero[v.id][v.heroId] = v
		end
	elseif name == ConfigName.MainPerformLandladyR then
		-- block empty
	elseif name == ConfigName.MainPerformFaceAnimR then
		for k, v in pairs(content.dataList or {}) do
			local _modelId = v.id

			if not self._faceAnim[_modelId] then
				self._faceAnim[_modelId] = {}
			end

			for _, _str in ipairs(v.state or {}) do
				local strArr = string.split(_str, "#")
				local animState = strArr[1]
				local animCountStr = strArr[2] or ""
				local arrAnimCountStr = string.split(animCountStr, ",")
				local minCount, maxCount = 1, 1

				if #arrAnimCountStr == 2 then
					minCount, maxCount = tonumber(arrAnimCountStr[1]), tonumber(arrAnimCountStr[2])
				end

				self._faceAnim[_modelId][animState] = {
					minCount,
					maxCount
				}
			end
		end
	end
end

function M:getConstNumByKey(key)
	return self._const[key] and self._const[key].numValue or 0
end

function M:getConstNumValuesByKey(key)
	return self._const[key] and self._const[key].numValues or {}
end

function M:getConfig(cfgName)
	return self._dict[cfgName]
end

function M:getConfigList(cfgName)
	local cfg = self._dict[cfgName]

	return cfg and cfg.dataList or nil
end

function M:getConfigByKey(cfgName, key, noPrintErr)
	local cfg = self:getConfig(cfgName)

	if cfg and cfg[key] then
		return cfg[key]
	end

	if not noPrintErr then
		printError(string.format("could not found [%s] in [t_%s]", key, cfgName))
	end
end

function M:getIsAdjutantOnline(heroId)
	local _charcterCfg = CharacterConfig.instance:getCfgInfoByID(heroId)

	if _charcterCfg then
		return _charcterCfg.isOnline > 0
	else
		return false
	end
end

function M:getBgRefreshTime()
	return self:getConstNumByKey("BgFormulaRefreshTime")
end

function M:getPointDefaultElementId(pointId)
	if not self._pointDefaultElementMap then
		self._pointDefaultElementMap = {}

		local str = self._const.DefualtShowElement and self._const.DefualtShowElement.strValue

		if not string.nilorempty(str) then
			local arrStep = string.split(str, "#")

			for _, valueStr in ipairs(arrStep) do
				local arrSingleStep = string.split(valueStr, ",")
				local point = tonumber(arrSingleStep[1])
				local elementId = tonumber(arrSingleStep[2])

				self._pointDefaultElementMap[point] = elementId
			end
		end
	end

	return self._pointDefaultElementMap[pointId] or -1
end

function M:getPointCheckHeroExist(point)
	if not self._pointNotCheckHeroExist then
		self._pointNotCheckHeroExist = {}

		local points = self:getConstNumValuesByKey("NotCheckExistPoints")

		for _, _point in ipairs(points or {}) do
			self._pointNotCheckHeroExist[_point] = 1
		end
	end

	return self._pointNotCheckHeroExist[point] == nil
end

function M:getInteractPointMap()
	return self._interactPointMap
end

function M:getElementLstByPointId(pointId)
	if self._interactElementPGroup[pointId] then
		return self._interactElementPGroup[pointId]
	end

	printError(string.format("无法从[t_%s]找到，所属交互点[%s]的交互元素列表", ConfigName.MainInteractElement, pointId))

	return {}
end

function M:getPerformHeroMap(elementId)
	if self._performHero[elementId] then
		return self._performHero[elementId]
	end

	if enableLog then
		printWarn(string.format("无法从[t_%s]找到，交互元素[%s]的配置", ConfigName.MainPerformHero, elementId), debug.traceback())
	end

	return {}
end

function M:getPerformHero(elementId, heroId)
	local map = self:getPerformHeroMap(elementId)

	if map and map[heroId] then
		return map[heroId]
	end

	printError(string.format("无法从[t_%s]找到，交互元素[%s]角色[%s]的配置", ConfigName.MainPerformHero, elementId, heroId))

	return nil
end

function M:getHeroElementId(heroId, pointId, skinId)
	heroId = heroId or 0

	if heroId <= 0 then
		return MainPerformConfig.instance:getPointDefaultElementId(pointId)
	end

	local isAdjutant = pointId == MainPerformEnum.ElementPointAdjutant

	if isAdjutant then
		local _charcterCfg = CharacterConfig.instance:getCfgInfoByID(heroId)
		local _cfgModel = ModelConfig.instance:getModelConfig(_charcterCfg.modelId)

		if skinId and skinId > 0 then
			local skinCO = HeroSkinConfig.instance:getInfo(skinId)

			_cfgModel = ModelConfig.instance:getModelConfig(skinCO and skinCO.module or 0) or _cfgModel
		end

		local _elementId = _cfgModel.mainSceneElement

		if _elementId > 0 then
			return _elementId
		else
			local fallBackHero = self:getConstNumByKey("DefaultFallBackAdjutant")

			_charcterCfg = CharacterConfig.instance:getCfgInfoByID(fallBackHero)
			_cfgModel = ModelConfig.instance:getModelConfig(_charcterCfg.modelId)

			return _cfgModel.mainSceneElement
		end
	else
		local elementId
		local lst = self:getConfigList(ConfigName.MainPerformHero)

		for _, cfg in ipairs(lst or {}) do
			if not elementId and cfg.heroId == heroId then
				elementId = cfg.id
			end
		end

		return elementId
	end
end

function M:getHeroElementPrefix(heroId, pointId, skinId)
	local prefix
	local elementId = self:getHeroElementId(heroId, pointId, skinId)

	if elementId then
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainInteractElement, elementId)

		prefix = cfg and cfg.animPrefix or ""
	end

	return prefix
end

function M:getLandLadyRConfigByHeroId(heroId)
	local modelId = CharacterUtil.getDepotHeroModelId(heroId)

	return self:getLandLadyRConfig(modelId)
end

function M:getLandLadyRConfig(modelId)
	local _cfgModel = ModelConfig.instance:getModelConfig(modelId)

	if _cfgModel and _cfgModel.mainSceneElement > 0 then
		local _cfgR = self:getConfigByKey(ConfigName.MainPerformLandladyR, modelId, true)

		_cfgR = _cfgR or self:getConfigByKey(ConfigName.MainPerformLandladyR, 0, true)

		return _cfgR
	else
		local fallBackHero = self:getConstNumByKey("DefaultFallBackAdjutant")

		if Astral.OSDef.isEditor then
			local logStr = string.format("模型[%s] 模型表没有配置[交互元素] 将使用[%s]%s配置替代", modelId, fallBackHero, ContainmentUtil.getHeroName(fallBackHero))

			printWarn(logStr, debug.traceback())
			ToolTipsMgr.showCharacterTopToast(logStr, nil, 2)
		end

		return self:getConfigByKey(ConfigName.MainPerformLandladyR, CharacterUtil.getModelId(fallBackHero, 0))
	end
end

function M:getElementDefaultCharSysCamGroupId(elementId, autoFallBack)
	local cfg = self:getConfigByKey(ConfigName.MainInteractElementR, elementId)

	if not cfg and autoFallBack then
		local fallBackElement = self:getPointDefaultElementId(MainPerformEnum.ElementPointAdjutant)

		cfg = self:getConfigByKey(ConfigName.MainInteractElementR, fallBackElement)
	end

	return cfg and cfg.charSysCamGroup or nil
end

function M:getHeroCharSysCamGroup(modelId)
	local cfgR = self:getLandLadyRConfig(modelId)

	if cfgR and cfgR.charSysCamGroup > 0 then
		return self:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, cfgR.charSysCamGroup)
	else
		local camGroupId = 1

		return self:getConfigByKey(ConfigName.MainPerformCamGroupChaSysR, camGroupId)
	end
end

function M:getRandomHeroFaceAnimStep(modelId, animState)
	local step = 0
	local len = self._faceAnim[modelId] and self._faceAnim[modelId][animState] and #self._faceAnim[modelId][animState] or 0

	if not string.nilorempty(animState) and len == 2 then
		local minCount = self._faceAnim[modelId][animState][1]
		local maxCount = self._faceAnim[modelId][animState][2]

		step = math.random(minCount, maxCount)
	end

	return step
end

function M:rebuildHeroFaceAnimStep(modelId)
	local cfg = self:getConfigByKey(ConfigName.MainPerformFaceAnimR, modelId, true)

	if cfg then
		if not self._faceAnim[modelId] then
			self._faceAnim[modelId] = {}
		end

		for _, _str in ipairs(cfg.state or {}) do
			local strArr = string.split(_str, "#")
			local animState = strArr[1]
			local animCountStr = strArr[2] or ""
			local arrAnimCountStr = string.split(animCountStr, ",")
			local minCount, maxCount = 1, 1

			if #arrAnimCountStr == 2 then
				minCount, maxCount = tonumber(arrAnimCountStr[1]), tonumber(arrAnimCountStr[2])
			end

			self._faceAnim[modelId][animState] = {
				minCount,
				maxCount
			}
		end
	end

	if Astral.OSDef.isEditor then
		TableUtil.dump(self:getHeroFaceAnimCountCfg(modelId))
	end
end

function M:getHeroFaceAnimCountCfg(modelId)
	if self._faceAnim and self._faceAnim[modelId] then
		return self._faceAnim[modelId]
	end

	return {}
end

function M:getCamPosData(camCode)
	local cfgCam = self:getConfigByKey(ConfigName.MainPerformCameraR, camCode)
	local posData = cfgCam and cfgCam.posData or {}
	local x = posData[1] or 0
	local y = posData[2] or 0
	local z = posData[3] or 0
	local rx = posData[4] or 0
	local ry = posData[5] or 0
	local rz = posData[6] or 0
	local fov = posData[7] or MainPerformEnum.DefaultFov

	return x, y, z, rx, ry, rz, fov
end

function M:getLandLadyColliderData(modelId)
	local cfg

	if modelId and modelId > 0 then
		cfg = self:getLandLadyRConfig(modelId)
	end

	local colliderData = cfg and cfg.collider or {}
	local centerX = colliderData[1] or -0.1
	local centerY = colliderData[2] or 0.6
	local centerZ = colliderData[3] or 0
	local sizeX = colliderData[4] or 0.7
	local sizeY = colliderData[5] or 1
	local sizeZ = colliderData[6] or 0.24

	return centerX, centerY, centerZ, sizeX, sizeY, sizeZ
end

M.instance = M.New()

return M
