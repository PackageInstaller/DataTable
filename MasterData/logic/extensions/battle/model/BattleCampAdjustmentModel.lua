-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/model/BattleCampAdjustmentModel.lua

module("logic.extensions.battle.model.BattleCampAdjustmentModel", package.seeall)

local M = class("BattleCampAdjustmentModel", BaseModel)

function M:onInit()
	self:onReset()
end

function M:onReset()
	self._debug = false
	self._defaultFocusUnionIndex = 0
	self._currentSameCampCount = 0
	self._isEnableAdjustment = false
	self._isPrePlayedEffect = false
	self._isBeforeCampAdjustmentGuideTriggerred = false
	self._notifyActiveCampChanged = false
	self._notifySignalCharacterCode = false
	self._isDragging = false
	self._isShowUnitUI = true
	self._currentTeamCharacterCodeList = {}
	self._boardUsedTable = {}
	self._unionIndex2UnitsTemp = {}

	BattleAgent.instance:reset()
end

function M:clear()
	self._debug = false
	self._defaultFocusUnionIndex = 0
	self._currentSameCampCount = 0
	self._isEnableAdjustment = false
	self._isPrePlayedEffect = false
	self._isShowUnitUI = true
	self._isDragging = false
	self._notifyActiveCampChanged = false
	self._notifySignalCharacterCode = false
	self._isBeforeCampAdjustmentGuideTriggerred = false

	BattleTableUtil.clearTable(self._currentTeamCharacterCodeList)
	BattleTableUtil.clearTable(self._boardUsedTable)
	BattleTableUtil.clearReusableTable(self._unionIndex2UnitsTemp)
end

function M:setDebug(debug)
	self._debug = debug
end

function M:isDebug()
	return self._debug
end

function M:setBeforeCampAdjustmentGuideTriggerred(isBeforeCampAdjustmentGuideTriggerred)
	self._isBeforeCampAdjustmentGuideTriggerred = isBeforeCampAdjustmentGuideTriggerred
end

function M:isBeforeCampAdjustmentGuideTriggerred()
	return self._isBeforeCampAdjustmentGuideTriggerred
end

function M:setShowUnitUI(show)
	self._isShowUnitUI = show
end

function M:isShowUnitUI()
	return self._isShowUnitUI
end

function M:isAdjusting()
	local model = BattleMgr.instance:getModel()

	return model:getPhase() == BattleEnum.Phase.READY
end

function M:setDragging(isDragging)
	self._isDragging = isDragging
end

function M:isDragging()
	return self._isDragging
end

function M:setEnableAdjustment(enable)
	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleCampAdjustmentModel::setEnableAdjustment %s", tostring(enable)))
	end

	self._isEnableAdjustment = enable
end

function M:isEnableAdjustment()
	return self._isEnableAdjustment
end

function M:buildAvailableHeroMOList()
	local model = BattleMgr.instance:getModel()
	local operateCampId = model:getOperateCampId()
	local battleFieldInfo = model:getBattleFieldInfo()
	local entityInfos = battleFieldInfo.entityInfos

	for _, entityInfo in ipairs(entityInfos) do
		if entityInfo.campId == operateCampId then
			self._boardUsedTable[entityInfo.bornUnionIndex] = true

			self:setCharacterInTeam(entityInfo.entityCode)
		end
	end
end

function M:containsAvailableCharacter()
	local availableHeroMOList = self:getAvailableHeroMOList()

	for _, heroMO in pairs(availableHeroMOList) do
		local isForbidden = BattleCampAdjustmentModel.instance:isForbiddenCharacterCode(heroMO:getId())

		if not isForbidden then
			return true
		end
	end

	return false
end

function M:getCurrentTeamCharacterCodeList()
	return self._currentTeamCharacterCodeList
end

function M:getAvailableHeroMOList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getAvailableHeroMOList()
end

function M:getTrialHeroMOList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getTrialHeroList()
end

function M:getAvailableAndTrialHeroMOList()
	local settingModel = BattleMgr.instance:getSettingModel()
	local res = {}

	for _, hero in ipairs(settingModel:getAvailableHeroMOList()) do
		table.insert(res, hero)
	end

	for _, hero in ipairs(settingModel:getTrialHeroList()) do
		if not hero.inteam then
			table.insert(res, hero)
		end
	end

	return res
end

function M:getBornUnionIndexList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getBornUnionIndexList()
end

function M:getBornDirectionOfUnionIndex(unionIndex)
	local settingModel = BattleMgr.instance:getSettingModel()
	local bornUnionIndexList = settingModel:getBornUnionIndexList()
	local bornDirectionList = settingModel:getBornDirectionList()
	local index = table.indexof(bornUnionIndexList, unionIndex)
	local direction = index and bornDirectionList[index]

	return direction and MeshModelDirection[direction] or MeshModelDirection.Default
end

function M:getLockedCharacterCodeList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getLockedCharacterCodeList()
end

function M:getAssistantCharacterCodeList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getAssistantCharacterCodeList()
end

function M:getForbiddenCareerList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getForbiddenCareerList()
end

function M:getSortPriorityCareer()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getSortPriorityCareer()
end

function M:getForbiddenCampList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getForbiddenCampList()
end

function M:getForbiddenRoleList()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getForbiddenRoleList()
end

function M:getEntityCountLimit()
	local settingModel = BattleMgr.instance:getSettingModel()

	return settingModel:getEntityCountLimit()
end

function M:sortByCareerList(heroList)
	local priorityCareer = self:getSortPriorityCareer()
	local forbiddenCareerList = self:getForbiddenCareerList()

	if priorityCareer <= 0 and #forbiddenCareerList == 0 then
		return heroList
	end

	local normalList = {}
	local forbiddenList = {}
	local priorityList = {}

	for i, heroData in ipairs(heroList) do
		local isForbidden = false

		for _, career in ipairs(forbiddenCareerList) do
			if heroData:getCareer() == career then
				isForbidden = true
			end
		end

		local isPriority = heroData:getCareer() == priorityCareer

		if isPriority then
			table.insert(priorityList, heroData)
		elseif isForbidden then
			table.insert(forbiddenList, heroData)
		else
			table.insert(normalList, heroData)
		end
	end

	table.insertto(priorityList, normalList)
	table.insertto(priorityList, forbiddenList)

	return priorityList
end

function M:setDefaultFocusUnionIndex(defaultFocusUnionIndex)
	self._defaultFocusUnionIndex = defaultFocusUnionIndex
end

function M:getDefaultFocusUnionIndex()
	return self._defaultFocusUnionIndex
end

function M:checkMaxCountLimit()
	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()
	local entityCountLimit = self:getEntityCountLimit()

	return entityCountLimit > #currentTeamCharacterCodeList
end

function M:getRemainPlaceCount()
	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()
	local entityCountLimit = self:getEntityCountLimit()

	return entityCountLimit - #currentTeamCharacterCodeList
end

function M:isValidBornUnionIndex(unionIndex)
	local bornUnionIndexList = self:getBornUnionIndexList()
	local index = table.indexof(bornUnionIndexList, unionIndex)

	return index and true or false
end

function M:isForbiddenCharacterCode(characterCode)
	local isTrial, trialForbidden = self:isHeroForbiddenByTrial(characterCode)

	if isTrial then
		return trialForbidden
	end

	local careerForbideen = self:isHeroForbiddenByCareer(characterCode)
	local campForbideen = self:isHeroForbiddenByCamp(characterCode)
	local roleForbidden = self:isHeroForbiddenByRole(characterCode)

	return careerForbideen or campForbideen or roleForbidden or trialForbidden
end

function M:isHeroForbiddenByCareer(characterCode)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(characterCode)
	local forbiddenCareerList = self:getForbiddenCareerList()

	return table.indexof(forbiddenCareerList, characterCO.career)
end

function M:isHeroForbiddenByCamp(characterCode)
	local characterCO = CharacterConfig.instance:getCfgInfoByID(characterCode)
	local forbiddenCampList = self:getForbiddenCampList()

	return table.indexof(forbiddenCampList, characterCO.camp)
end

function M:isHeroForbiddenByRole(characterCode)
	local forbiddenRoleList = self:getForbiddenRoleList()

	return table.indexof(forbiddenRoleList, characterCode)
end

function M:isHeroForbiddenByTrial(characterCode)
	local inTeam = self:getCurrentTeamCharacterCodeList()
	local trialHeroList = self:getTrialHeroMOList()
	local isTrial = false
	local isForbidden = false
	local trialIdDict = {}

	for _, hero in ipairs(trialHeroList) do
		if hero:getId() == characterCode then
			isTrial = true
		end

		trialIdDict[hero:getId()] = hero.heroId
		trialIdDict[hero.heroId] = hero:getId()
	end

	for _, heroId in ipairs(inTeam) do
		if trialIdDict[heroId] == characterCode then
			isForbidden = true

			break
		end
	end

	return isTrial, isForbidden
end

function M:isLockedCharacter(characterCode)
	local lockedCharacterCodeList = self:getLockedCharacterCodeList()

	return table.indexof(lockedCharacterCodeList, characterCode)
end

function M:isAssistantCharacter(characterCode)
	local assistantCharacterCodeList = self:getAssistantCharacterCodeList()

	return table.indexof(assistantCharacterCodeList, characterCode)
end

function M:isKillCharacter(characterCode)
	local settingModel = BattleMgr.instance:getSettingModel()
	local killEntityCodeList = settingModel:getKillEntityCodeList()

	return table.indexof(killEntityCodeList, characterCode)
end

function M:isProtectCharacter(characterCode)
	local settingModel = BattleMgr.instance:getSettingModel()
	local protectEntityCodeList = settingModel:getProtectEntityCodeList()

	return table.indexof(protectEntityCodeList, characterCode)
end

function M:setCharacterInTeam(characterCode)
	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()

	table.insert(currentTeamCharacterCodeList, characterCode)

	self._notifySignalCharacterCode = characterCode

	local availableHeroMOList = self:getAvailableHeroMOList()

	for index, heroMO in ipairs(availableHeroMOList) do
		if characterCode == heroMO:getId() then
			table.remove(availableHeroMOList, index)

			return index
		end
	end

	local trialList = self:getTrialHeroMOList()

	for index, heroMO in ipairs(trialList) do
		if characterCode == heroMO:getId() then
			heroMO.inteam = true

			return index
		end
	end

	return false
end

function M:setCharacterOutTeam(characterCode, indexInList)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(characterCode)

	if not heroMO then
		local settingModel = BattleMgr.instance:getSettingModel()
		local trialList = settingModel:getTrialHeroList()

		for _, item in ipairs(trialList) do
			if item:getId() == characterCode then
				item.inteam = false
				heroMO = item

				break
			end
		end
	end

	if not heroMO then
		if BattleLog.enableError then
			BattleLog.error("cannot find HeroMO", characterCode)
		end

		return
	end

	if not heroMO.isTrial then
		local availableHeroMOList = self:getAvailableHeroMOList()

		if indexInList and indexInList <= #availableHeroMOList then
			table.insert(availableHeroMOList, indexInList, heroMO)
		else
			table.insert(availableHeroMOList, heroMO)
		end
	end

	local currentTeamCharacterCodeList = self:getCurrentTeamCharacterCodeList()

	table.removebyvalue(currentTeamCharacterCodeList, characterCode)
end

function M:getSameCampCount()
	return self._currentSameCampCount
end

function M:isSameActiveCampChanged()
	return self._notifyActiveCampChanged
end

function M:isPrePlayedEffect()
	return self._isPrePlayedEffect
end

function M:popTempUnit(unionIndex)
	local unit = self._unionIndex2UnitsTemp[unionIndex]

	self._unionIndex2UnitsTemp[unionIndex] = nil

	return unit
end

function M:addTempUnit(unionIndex, unit)
	local tempUnit = self._unionIndex2UnitsTemp[unionIndex]

	if tempUnit then
		if BattleLog.enableError then
			BattleLog.error(string.format("Already contains unit at unionIndex %s", unionIndex))
		end

		tempUnit:returnSelf()
	end

	self._unionIndex2UnitsTemp[unionIndex] = unit
end

function M:setPrePlayedEffect(isPrePlayedEffect)
	self._isPrePlayedEffect = isPrePlayedEffect
end

function M:isNotifySignalCharacterCode(characterCode)
	return self._notifySignalCharacterCode == characterCode
end

function M:resetSameActiveCampChangedNotify()
	self._notifySignalCharacterCode = false
	self._notifyActiveCampChanged = false
end

function M:setCellIndexUsedState(cellIndex, isUsed)
	self._boardUsedTable[cellIndex] = isUsed
end

function M:isCellIndexUsed(cellIndex)
	return self._boardUsedTable[cellIndex]
end

function M:recordAllHeroesByBackInfo()
	local model = BattleMgr.instance:getModel()

	model:clearStartHeroes()

	if model:isReconnectMode() then
		local heroes = model:getHeroesInBattle()

		for i, heroId in ipairs(heroes) do
			model:addStartHero(heroId)
		end
	else
		local unitMgr = BattleMgr.instance:getUnitMgr()
		local heroIds = unitMgr:getMyUnits(true)

		for i, v in ipairs(heroIds) do
			model:addStartHero(v)
		end
	end
end

M.instance = M.New()

return M
