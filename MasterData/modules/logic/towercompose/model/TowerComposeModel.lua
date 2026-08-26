-- chunkname: @modules/logic/towercompose/model/TowerComposeModel.lua

module("modules.logic.towercompose.model.TowerComposeModel", package.seeall)

local TowerComposeModel = class("TowerComposeModel", BaseModel)

function TowerComposeModel:onInit()
	self:reInit()
end

function TowerComposeModel:reInit()
	self.fightParam = {}
	self.fightFinishParam = {}
	self.themeDataMap = {}
	self.curThemeId = 1
	self.curUnfoldThemeId = 1
	self.curLayerId = 1
	self.curNeedUnfoldThemeId = 0
	self.fightParamsStr = ""
	self.themeSelectPlaneIdMap = {}
	self.saveLocalDataMap = {}
	self.curFightPlaneId = 0
end

function TowerComposeModel:onReceiveTowerComposeGetInfoReply(info)
	for index, themeInfo in ipairs(info.themes) do
		self:updateThemeInfo(themeInfo)
	end

	local saveThemeAndLayerStr = TowerController.instance:getPlayerPrefs(TowerComposeEnum.LocalPrefsKey.LocalThemeAndLayerId, TowerComposeEnum.DefaultThemeAndLayer)
	local saveThemeAndLayerStrList = string.splitToNumber(saveThemeAndLayerStr, "#")

	self.curThemeId, self.curLayerId = saveThemeAndLayerStrList[1], saveThemeAndLayerStrList[2]

	local passLayer = self:getThemePassLayer(self.curThemeId)

	if passLayer < self.curLayerId and passLayer == 0 then
		self.curLayerId = 1
	end

	if passLayer > 0 then
		local curUnlockPlaneLayerId, planeLayerIdList = self:getCurUnlockPlaneLayerId(self.curThemeId, passLayer)
		local isSelectFirstPlane = self.curLayerId == planeLayerIdList[1]

		if curUnlockPlaneLayerId > 0 and curUnlockPlaneLayerId ~= planeLayerIdList[1] and isSelectFirstPlane then
			self.curLayerId = curUnlockPlaneLayerId
		end
	end

	self.curUnfoldThemeId = self.curThemeId
end

function TowerComposeModel:updateThemeInfo(themeInfo)
	local themeInfoMo = self.themeDataMap[themeInfo.themeId]

	if not themeInfoMo then
		themeInfoMo = TowerComposeThemeMo.New()
		self.themeDataMap[themeInfo.themeId] = themeInfoMo
	end

	themeInfoMo:updateInfo(themeInfo)
end

function TowerComposeModel:updateBossSettle(bossSettle, themeId)
	self._bossSettleInfo = self._bossSettleInfo or TowerComposeBossSettleMo.New()

	self._bossSettleInfo:update(bossSettle, themeId)
end

function TowerComposeModel:getBossSettleInfo()
	return self._bossSettleInfo
end

function TowerComposeModel:getAtkStat(panelId)
	return self._bossSettleInfo and self._bossSettleInfo:getAtkStat(panelId)
end

function TowerComposeModel:setLastEntityMO(mo)
	self._lastEntityMO = mo
end

function TowerComposeModel:getLastEntityMO()
	return self._lastEntityMO
end

function TowerComposeModel:getEntityMO(heroUid)
	return self._lastEntityMO[heroUid]
end

function TowerComposeModel:isPanelHasStat(panelId)
	local atkStats = self:getAtkStat(panelId)

	if atkStats then
		for _, stat in ipairs(atkStats) do
			return true
		end
	end

	return false
end

function TowerComposeModel:onReceiveTowerComposeSetModsReply(info)
	local themeId = info.themeId
	local themeInfoMo = self.themeDataMap[themeId]

	if themeInfoMo then
		themeInfoMo:setCurBossLevel(info.level)

		for _, planeInfo in ipairs(info.planes) do
			themeInfoMo:updatePlaneInfoData(planeInfo)
		end
	end
end

function TowerComposeModel:updateThemeProgress(themeId, progress)
	local themeInfoMo = self.themeDataMap[themeId]

	if themeInfoMo then
		themeInfoMo:updateResearchProgress(progress)
	end
end

function TowerComposeModel:updateUnlockModIds(info)
	local themeId = info.themeId
	local themeInfoMo = self.themeDataMap[themeId]

	if themeInfoMo then
		themeInfoMo:updateUnlockModIds(info.unlockModIds)
	end
end

function TowerComposeModel:onReceiveTowerComposeFightSettlePush(info)
	local themeInfo = info.theme

	self:updateThemeInfo(themeInfo)
	self:updateBossSettle(info.bossSettle, themeInfo.themeId)

	self.fightParamsStr = info.params
	self.fightResult = info.result

	if self.fightResult == TowerComposeEnum.FightResult.Win then
		self:setCurFightPlaneId(self.fightParamsStr)
	end
end

function TowerComposeModel:getThemePassLayer(themeId)
	return (self.themeDataMap[themeId] or nil) and (self.themeDataMap[themeId].passLayerId or 0)
end

function TowerComposeModel:getThemeCount()
	return tabletool.len(self.themeDataMap)
end

function TowerComposeModel:getThemeMo(themeId)
	return self.themeDataMap[themeId]
end

function TowerComposeModel:isMaxPlaneLayerUnlock(themeId, passLayerId)
	local planeLayerIdList = TowerComposeConfig.instance:getThemeAllPlaneLayerIdList(themeId)
	local maxPlaneLayerId = planeLayerIdList[#planeLayerIdList]
	local passLayerConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, passLayerId)

	return passLayerId < maxPlaneLayerId and passLayerConfig and passLayerConfig.nextLayerId == maxPlaneLayerId or maxPlaneLayerId <= passLayerId, maxPlaneLayerId
end

function TowerComposeModel:getCurUnlockPlaneLayerId(themeId, passLayerId)
	local planeLayerIdList = TowerComposeConfig.instance:getThemeAllPlaneLayerIdList(themeId)
	local curUnlockPlaneLayerId = 0
	local passLayerConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, passLayerId)

	for index, layerId in ipairs(planeLayerIdList) do
		if passLayerConfig and passLayerConfig.nextLayerId == layerId or layerId <= passLayerId then
			curUnlockPlaneLayerId = layerId
		end
	end

	return curUnlockPlaneLayerId, planeLayerIdList
end

function TowerComposeModel:checkHasPlaneLayerUnlock(themeId)
	local passLayer = self:getThemePassLayer(themeId)

	if passLayer == 0 then
		return false
	else
		local curUnlockPlaneLayerId = self:getCurUnlockPlaneLayerId(themeId, passLayer)

		return curUnlockPlaneLayerId > 0
	end
end

function TowerComposeModel:setCurThemeIdAndLayer(themeId, layerId)
	self.curThemeId = themeId
	self.curUnfoldThemeId = themeId
	self.curLayerId = layerId

	TowerController.instance:setPlayerPrefs(TowerComposeEnum.LocalPrefsKey.LocalThemeAndLayerId, string.format("%d#%d", self.curThemeId, self.curLayerId))
end

function TowerComposeModel:getCurThemeIdAndLayer()
	return self.curThemeId, self.curLayerId
end

function TowerComposeModel:setCurUnfoldThemeId(themeId)
	self.curUnfoldThemeId = themeId
end

function TowerComposeModel:getCurUnfoldThemeId()
	return self.curUnfoldThemeId
end

function TowerComposeModel:setCurNeedUnfoldThemeId(themeId)
	self.curNeedUnfoldThemeId = themeId
end

function TowerComposeModel:getCurNeedUnfoldThemeId()
	return self.curNeedUnfoldThemeId
end

function TowerComposeModel:setCurSelectPlaneId(planeId)
	local passLayerId = self:getThemePassLayer(self.curThemeId)
	local curUnlockPlaneLayerId, planeLayerIdList = self:getCurUnlockPlaneLayerId(self.curThemeId, passLayerId)

	if curUnlockPlaneLayerId > 0 then
		self.themeSelectPlaneIdMap[self.curThemeId] = planeId
	end
end

function TowerComposeModel:getCurSelectPlaneId()
	return self.themeSelectPlaneIdMap[self.curThemeId] or 1
end

function TowerComposeModel:getCurThemeEnvModId(themeId, planeId)
	local envModIdList = {}
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(themeId)

	table.insert(envModIdList, themeConfig.initEnv)

	local envSlotNum = TowerComposeConfig.instance:getModTypeNum(themeId, TowerComposeEnum.ModType.Env)
	local themeMo = self:getThemeMo(themeId)

	if themeMo and planeId > 0 then
		local planeMo = themeMo:getPlaneMo(planeId)

		if planeMo then
			for slotId = 1, envSlotNum do
				local equipEnvModId = planeMo:getEquipModId(TowerComposeEnum.ModType.Env, slotId)

				if equipEnvModId and equipEnvModId > 0 then
					envModIdList[slotId] = equipEnvModId
				end
			end
		end
	end

	return envModIdList[1], envModIdList
end

function TowerComposeModel:getLocalSaveDataMap(key)
	local saveStr = TowerController.instance:getPlayerPrefs(key)

	if string.nilorempty(saveStr) then
		return self.saveLocalDataMap
	end

	if not self.saveLocalDataMap[key] then
		local saveState = {}
		local saveStateList = GameUtil.splitString2(saveStr, true)

		if saveStateList then
			for _, data in ipairs(saveStateList) do
				local id = data[1]

				saveState[id] = data[2]
			end

			self.saveLocalDataMap[key] = saveState
		end
	end

	return self.saveLocalDataMap[key]
end

function TowerComposeModel:getLocalSaveData(key, id, defaultValue)
	local saveDataMap = self:getLocalSaveDataMap(key)

	return saveDataMap[id] or defaultValue
end

function TowerComposeModel:setLocalSaveDataMap(key, id, value)
	local saveDataMap = self:getLocalSaveDataMap(key)

	if saveDataMap[id] == value then
		return
	end

	saveDataMap[id] = value

	local saveDataList = {}

	for saveId, saveState in pairs(saveDataMap) do
		table.insert(saveDataList, string.format("%s#%s", saveId, saveState))
	end

	TowerController.instance:setPlayerPrefs(key, table.concat(saveDataList, "|"))
end

function TowerComposeModel:getPlaneBossSkinCoList(themeId, planeId, bossSkinCoList)
	local curBossSkinCoList = tabletool.copy(bossSkinCoList)
	local themeMo = self:getThemeMo(themeId)

	if not themeMo then
		logError("该主题信息不存在：" .. themeId)

		return curBossSkinCoList
	end

	local planeMo = themeMo:getPlaneMo(planeId)

	if not planeMo then
		logError("该主题的位面信息不存在：" .. themeId .. "," .. planeId)

		return curBossSkinCoList
	end

	for slot = 1, #curBossSkinCoList do
		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Body, slot)

		if modId and modId > 0 then
			local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)

			if not string.nilorempty(modConfig.slotPart) then
				local spineSkinPartList = string.splitToNumber(modConfig.slotPart, "#")
				local oldSkinId = spineSkinPartList[1]
				local newSkinId = spineSkinPartList[2]

				for index, skinCo in ipairs(curBossSkinCoList) do
					if skinCo.id == oldSkinId then
						curBossSkinCoList[index] = lua_monster_skin.configDict[newSkinId]

						break
					end
				end
			end
		end
	end

	return curBossSkinCoList
end

function TowerComposeModel:getPlaneBossIdList(themeId, planeId, bossMonsterIdList, bossIdList)
	local curBossMonsterIdList = tabletool.copy(bossMonsterIdList)
	local bossIdList = tabletool.copy(bossIdList)
	local themeMo = self:getThemeMo(themeId)

	if not themeMo then
		logError("该主题信息不存在：" .. themeId)

		return curBossMonsterIdList
	end

	local planeMo = themeMo:getPlaneMo(planeId)

	if not planeMo then
		logError("该主题的位面信息不存在：" .. themeId .. "," .. planeId)

		return curBossMonsterIdList
	end

	for slot = 1, #curBossMonsterIdList do
		local modId = planeMo:getEquipModId(TowerComposeEnum.ModType.Body, slot)

		if modId and modId > 0 then
			local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)

			if not string.nilorempty(modConfig.monsterChange) then
				local changeMonsterList = string.splitToNumber(modConfig.monsterChange, "#")
				local oldMonsterId = changeMonsterList[1]
				local newMonsterId = changeMonsterList[2]

				for index, bossId in ipairs(curBossMonsterIdList) do
					if bossId == oldMonsterId then
						curBossMonsterIdList[index] = newMonsterId

						break
					end
				end

				for index, bossId in ipairs(bossIdList) do
					if bossId == oldMonsterId then
						bossIdList[index] = newMonsterId

						break
					end
				end
			end
		end
	end

	return curBossMonsterIdList, bossIdList
end

function TowerComposeModel:getChangeTemplate(bossMonsterIdList, episodeId, modLevel)
	local bossLvConfig = TowerComposeConfig.instance:getBossLevelCo(episodeId, modLevel)

	if string.nilorempty(bossLvConfig.templateChange) then
		return {}
	end

	local monsterTemplateMap = {}

	for index, bossId in ipairs(bossMonsterIdList) do
		local bossConfig = lua_monster.configDict[bossId]

		if not string.nilorempty(bossConfig.template) then
			monsterTemplateMap[bossId] = bossConfig.template
		end
	end

	local changeTemplateDataList = GameUtil.splitString2(bossLvConfig.templateChange, true)

	for index, changeTemplateData in ipairs(changeTemplateDataList) do
		local oldTemplateId = changeTemplateData[1]
		local newTemplateId = changeTemplateData[2]

		for bossId, templateId in pairs(monsterTemplateMap) do
			if templateId == oldTemplateId then
				monsterTemplateMap[bossId] = newTemplateId
			end
		end
	end

	return monsterTemplateMap
end

function TowerComposeModel:getMonsterHp(bossMonsterIdList, episodeId, modLevel, monsterId)
	local monsterTemplateMap = self:getChangeTemplate(bossMonsterIdList, episodeId, modLevel)
	local monsterConfig = lua_monster.configDict[monsterId]

	if not monsterTemplateMap[monsterId] then
		local templateId = monsterConfig.template
		local tempHp = CharacterDataConfig.instance:calculateMonsterHpNewFunc(monsterConfig)

		if tempHp then
			return tempHp
		end

		local monsterTemplateConfig = lua_monster_template.configDict[templateId]

		if monsterTemplateConfig then
			return monsterTemplateConfig.life + monsterConfig.level * monsterTemplateConfig.lifeGrow
		end

		return 0
	end
end

function TowerComposeModel:setEquipModId(themeId, planeId, modType, slot, modId)
	local themeMo = self:getThemeMo(themeId)

	if not themeMo then
		logError("该主题信息不存在：" .. themeId)

		return
	end

	local planeMo = themeMo:getPlaneMo(planeId)

	if not planeMo then
		logError("该主题的位面信息不存在：" .. themeId .. "," .. planeId)

		return
	end

	planeMo:setEquipModId(modType, slot, modId)
end

function TowerComposeModel:sendSetModsRequest(themeId, layerId, callback, callbackObj)
	local themeMo = self:getThemeMo(themeId)

	if not themeMo then
		return
	end

	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	local modInfoList = {}

	for planeId = 1, towerEpisodeConfig.plane do
		local planeMo = themeMo:getPlaneMo(planeId)

		if not planeMo then
			return
		end

		modInfoList[planeId] = planeMo:getAllModeInfoList()
	end

	TowerComposeRpc.instance:sendTowerComposeSetModsRequest(themeId, modInfoList, callback, callbackObj)
end

function TowerComposeModel:checkModIsInPlane(modId, modType)
	local themeMo = self:getThemeMo(self.curThemeId)
	local themeConfig = TowerComposeConfig.instance:getThemeConfig(self.curThemeId)
	local initEnvModId = themeConfig.initEnv
	local initEnvModInfoMap = {}
	local plane1Mo = themeMo:getPlaneMo(1)
	local modInfoList1 = plane1Mo:getModInfoList(modType)

	for _, modInfo in ipairs(modInfoList1) do
		if modInfo.modId == modId then
			if modInfo.modId == initEnvModId then
				initEnvModInfoMap[1] = modInfo

				break
			else
				return 1, modInfo
			end
		end
	end

	local plane2Mo = themeMo:getPlaneMo(2)

	if not plane2Mo then
		return 0, nil, initEnvModInfoMap
	end

	local modInfoList2 = plane2Mo:getModInfoList(modType)

	for _, modInfo in ipairs(modInfoList2) do
		if modInfo.modId == modId then
			if modInfo.modId == initEnvModId then
				initEnvModInfoMap[2] = modInfo

				break
			else
				return 2, modInfo
			end
		end
	end

	return 0, nil, initEnvModInfoMap
end

function TowerComposeModel:getAllUnlockTypeModCoList(themeId, modType, slotId)
	local modConfigList = {}
	local allModConfigList = TowerComposeConfig.instance:getComposeAllModBySlot(themeId, modType, slotId) or {}
	local themeMo = self:getThemeMo(themeId)

	for index, modConfig in ipairs(allModConfigList) do
		if themeMo:isModUnlock(modConfig.id) then
			table.insert(modConfigList, modConfig)
		end
	end

	return modConfigList
end

function TowerComposeModel:getThemePlaneLevel(themeId, isEquiping)
	local themeMo = self:getThemeMo(themeId)

	if isEquiping then
		local plane1Mo = themeMo:getPlaneMo(1)
		local plane2Mo = themeMo:getPlaneMo(2)

		return Mathf.Max(plane1Mo.level, (plane2Mo or nil) and (plane2Mo.level or 0))
	else
		return themeMo:getCurBossLevel()
	end
end

function TowerComposeModel:replaceLevelSkillDesc(skillDesc, curLevel, hightLightColor, normalLightColor)
	local hightLightColor = hightLightColor or "#D0AE47"
	local normalLightColor = normalLightColor or "#686868"
	local desc = string.gsub(skillDesc, "(<lv%d+:.->)", function(str)
		local matchStrList = {}
		local levelList = {}

		for level, num in string.gmatch(str, "lv(%d+):(%d+%%?)") do
			table.insert(levelList, level)
			table.insert(matchStrList, num)
		end

		local parts = {}

		for index, num in ipairs(matchStrList) do
			if levelList[index] == tostring(curLevel) then
				table.insert(parts, string.format("<color=%s>%s</color>", hightLightColor, num))
			else
				table.insert(parts, string.format("<color=%s>%s</color>", normalLightColor, num))
			end
		end

		return table.concat(parts, string.format("<color=%s>/</color>", normalLightColor))
	end)

	desc = string.gsub(desc, "|", string.format("<color=%s>/</color>", normalLightColor))

	return desc
end

function TowerComposeModel:getCurThemeUnlockResearchCoList(themeId)
	local themeMo = self:getThemeMo(themeId)
	local allResearchCoList = TowerComposeConfig.instance:getAllResearchCoList(themeId)
	local unlockResearchCoList = {}

	for _, researchCo in ipairs(allResearchCoList) do
		if themeMo.researchProgress >= researchCo.req then
			table.insert(unlockResearchCoList, researchCo)
		end
	end

	return unlockResearchCoList
end

function TowerComposeModel:checkCurThemeResearchUnlock(themeId, researchId)
	local themeMo = self:getThemeMo(themeId)
	local researchCo = TowerComposeConfig.instance:getResearchCo(researchId)

	return themeMo.researchProgress >= researchCo.req
end

function TowerComposeModel:setRecordFightParam(themeId, layerId, episodeId, isReconnect)
	self.fightParam.themeId = themeId or self.fightParam.themeId
	self.fightParam.layerId = layerId or self.fightParam.layerId
	self.fightParam.episodeId = episodeId

	local towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	self.fightParam.plane = towerEpisodeConfig.plane
	self.fightParam.isReconnect = isReconnect
end

function TowerComposeModel:getRecordFightParam()
	return self.fightParam
end

function TowerComposeModel:clearRecordFightParam()
	self.fightParam = {}
end

function TowerComposeModel:setCurFightPlaneId(params, isReconnect)
	local towerEpisodeConfig = {}
	local themeId = self.curThemeId
	local layerId = self.curLayerId
	local planeId = 0

	if params then
		local paramData = cjson.decode(params)

		themeId = paramData.themeId
		layerId = paramData.layerId
		planeId = paramData.planeId
	elseif self.fightParam then
		themeId = self.fightParam.themeId
		layerId = self.fightParam.layerId
	end

	towerEpisodeConfig = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)
	self.curFightPlaneId = 0

	if towerEpisodeConfig.plane == 2 and not isReconnect then
		local themeMo = self:getThemeMo(themeId)
		local curBossMo = themeMo:getCurBossMo()
		local isBossLock = curBossMo.lock
		local isAllPlaneLock = self:isAllPlaneLock(themeId)

		if isAllPlaneLock then
			local planeInfoMap = curBossMo:getPlaneInfoMap()

			for planeId, planeMo in pairs(planeInfoMap) do
				if not planeMo.hasFight then
					self.curFightPlaneId = planeId

					break
				end
			end
		else
			for plane = 1, 2 do
				local planeMo = themeMo:getPlaneMo(plane)

				if isBossLock and not planeMo.isLock then
					self.curFightPlaneId = plane

					break
				end

				if not planeMo.hasFight then
					self.curFightPlaneId = plane

					break
				end
			end
		end

		self.curFightPlaneId = self.curFightPlaneId == 0 and 1 or self.curFightPlaneId
	else
		self.curFightPlaneId = isReconnect and planeId or towerEpisodeConfig.plane
	end
end

function TowerComposeModel:getCurFightPlaneId()
	return self.curFightPlaneId
end

function TowerComposeModel:onReceiveTowerBattleFinishPush(info)
	self.fightFinishParam.result = info.result

	if info.params then
		local paramData = cjson.decode(info.params)

		self.fightFinishParam.themeId = paramData.themeId
		self.fightFinishParam.layerId = paramData.layerId
		self.fightFinishParam.planeId = paramData.planeId
	end
end

function TowerComposeModel:getFightFinishParam()
	return self.fightFinishParam
end

function TowerComposeModel:clearFightFinishParam()
	self.fightFinishParam = {}
end

function TowerComposeModel:isFightPassNewLayer(themeId)
	local themePassLayer = self:getThemePassLayer(themeId)

	return (self.fightFinishParam.themeId == themeId or nil) and self.fightFinishParam.layerId and not (self.fightFinishParam.layerId <= 0 or self.fightFinishParam.result ~= 1 or self.fightFinishParam.layerId ~= themePassLayer)
end

function TowerComposeModel:checkCanShowResultView()
	local themeId, layerId = self:getCurThemeIdAndLayer()
	local towerEpisodeCo = TowerComposeConfig.instance:getEpisodeConfig(themeId, layerId)

	return towerEpisodeCo.plane ~= TowerComposeEnum.PlaneType.None
end

function TowerComposeModel:checkHasModsLock(themeId, modList)
	local themeMo = self:getThemeMo(themeId)

	for index, modId in ipairs(modList) do
		if not themeMo:isModUnlock(modId) then
			return (TowerComposeConfig.instance:getComposeModConfig(modId))
		end
	end
end

function TowerComposeModel:checkLocalThemeUpdate()
	local saveStr = TowerController.instance:getPlayerPrefs(TowerComposeEnum.LocalPrefsKey.TowerComposeUpdateTheme, "")
	local curThemeIdList = {}

	for themeId, themeInfo in pairs(self.themeDataMap) do
		table.insert(curThemeIdList, themeId)
	end

	table.sort(curThemeIdList, function(a, b)
		return a < b
	end)

	if string.nilorempty(saveStr) then
		return true, curThemeIdList[#curThemeIdList]
	end

	local saveThemeIdList = string.splitToNumber(saveStr, "#")

	if saveThemeIdList and #saveThemeIdList > 0 and #saveThemeIdList < #curThemeIdList then
		return true, curThemeIdList[#saveThemeIdList]
	end

	return false
end

function TowerComposeModel:saveLocalTheme()
	local curThemeIdList = {}

	for themeId, themeInfo in pairs(self.themeDataMap) do
		table.insert(curThemeIdList, themeId)
	end

	table.sort(curThemeIdList, function(a, b)
		return a < b
	end)

	local saveStr = table.concat(curThemeIdList, "#")

	TowerController.instance:setPlayerPrefs(TowerComposeEnum.LocalPrefsKey.TowerComposeUpdateTheme, saveStr)
end

function TowerComposeModel:calModPointBaseScore(themeId, planeId)
	local themeMo = self:getThemeMo(themeId)
	local planeMo = themeMo:getPlaneMo(planeId)
	local bodyModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Body)
	local wordModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Word)
	local envModInfoList = planeMo:getHaveModInfoList(TowerComposeEnum.ModType.Env)
	local totalPointBase = 0

	for index, modInfo in ipairs(bodyModInfoList) do
		local modConfig = TowerComposeConfig.instance:getComposeModConfig(modInfo.modId)

		if not self:isIgnoreCalModPointBase(modConfig.id) then
			local pointLevelCo = TowerComposeConfig.instance:getPointLevelConfig(modConfig.level)

			totalPointBase = totalPointBase + pointLevelCo.bossPointBase
		end
	end

	for index, modInfo in ipairs(wordModInfoList) do
		local modConfig = TowerComposeConfig.instance:getComposeModConfig(modInfo.modId)

		if not self:isIgnoreCalModPointBase(modConfig.id) then
			local pointLevelCo = TowerComposeConfig.instance:getPointLevelConfig(modConfig.level)

			totalPointBase = totalPointBase + pointLevelCo.bossPointBase
		end
	end

	for index, modInfo in ipairs(envModInfoList) do
		local modConfig = TowerComposeConfig.instance:getComposeModConfig(modInfo.modId)

		if not self:isIgnoreCalModPointBase(modConfig.id) then
			local pointLevelCo = TowerComposeConfig.instance:getPointLevelConfig(modConfig.level)

			totalPointBase = totalPointBase + pointLevelCo.bossPointBase
		end
	end

	return totalPointBase
end

function TowerComposeModel:isIgnoreCalModPointBase(modId)
	local modIdListStr = TowerComposeConfig.instance:getConstValue(TowerComposeEnum.ConstId.IgnoreCalPointBaseModList)
	local modIdList = string.splitToNumber(modIdListStr, "#")

	return tabletool.indexOf(modIdList, modId)
end

function TowerComposeModel:updateTowercomposeRecordBossData(themeId, recordInfo)
	local curThemeMo = self:getThemeMo(themeId)

	if not curThemeMo then
		return
	end

	curThemeMo:updateComposeBossRecordInfo(recordInfo)
end

function TowerComposeModel:updateTowerComposeBossData(themeId, bossInfo)
	local curThemeMo = self:getThemeMo(themeId)

	if not curThemeMo then
		return
	end

	curThemeMo:updateComposeBossInfo(bossInfo)
end

function TowerComposeModel:getCurLockPlaneId(themeId, checkNotLock)
	local curThemeMo = self:getThemeMo(themeId)

	if curThemeMo then
		local curBossMo = curThemeMo:getCurBossMo()

		if curBossMo then
			local planeInfoMap = curBossMo:getPlaneInfoMap()

			for planeId, planeMo in pairs(planeInfoMap) do
				if not checkNotLock and planeMo.isLock then
					return planeId
				end

				if checkNotLock and not planeMo.isLock then
					return planeId
				end
			end
		end
	end

	return 0
end

function TowerComposeModel:checkPlaneLock(themeId, planeId)
	local curThemeMo = self:getThemeMo(themeId)

	if curThemeMo then
		local curBossMo = curThemeMo:getCurBossMo()

		if curBossMo then
			local planeInfoMap = curBossMo:getPlaneInfoMap()

			return planeInfoMap[planeId] and planeInfoMap[planeId].isLock
		end
	end

	return false
end

function TowerComposeModel:isAllPlaneLock(themeId)
	for planeId = 1, 2 do
		if not self:checkPlaneLock(themeId, planeId) then
			return false
		end
	end

	return true
end

function TowerComposeModel:isAllEpisodeFinish(themeId)
	local passLayer = self:getThemePassLayer(themeId)
	local allEpisodeList = TowerComposeConfig.instance:getThemeAllEpisodeConfig(themeId)
	local finalEpisodeCo = allEpisodeList[#allEpisodeList]
	local isAllEpisodeFinish = passLayer == finalEpisodeCo.layerId

	return isAllEpisodeFinish, finalEpisodeCo.layerId
end

TowerComposeModel.instance = TowerComposeModel.New()

return TowerComposeModel
