-- chunkname: @modules/logic/towercompose/model/TowerComposePlaneMo.lua

module("modules.logic.towercompose.model.TowerComposePlaneMo", package.seeall)

local TowerComposePlaneMo = class("TowerComposePlaneMo", TowerComposePlaneMo)

function TowerComposePlaneMo:ctor(params)
	self.themeId = params.themeId
	self.level = 0
	self.modInfoMap = {}
	self.modeInfoList = {}
	self.hasFight = false
	self.teamInfoData = {}
end

function TowerComposePlaneMo:updateInfo(info)
	self.planeId = info.planeId

	self:updateModsInfo(info.mods)
	self:updateTeamInfo(info.team)

	self.curScore = info.currScore
	self.fightResult = info.result
	self.hasFight = info.result and info.result ~= TowerComposeEnum.FightResult.None
	self.isLock = info.lock
end

function TowerComposePlaneMo:updateModsInfo(modsInfo)
	self:buildAllDefaultModInfoMap()

	for _, modInfo in ipairs(modsInfo) do
		self:buildDefaultModInfoMap(modInfo.type)

		for _, modSlotData in ipairs(modInfo.mods) do
			self.modInfoMap[modInfo.type][modSlotData.slot] = modSlotData.modId
		end
	end

	self:buildModInfoList()
end

function TowerComposePlaneMo:buildDefaultModInfoMap(modType)
	if not self.modInfoMap[modType] then
		self.modInfoMap[modType] = {}

		local slotNumMap = TowerComposeConfig.instance:getModSlotNumMap(self.themeId)
		local slotNum = slotNumMap[modType]

		for slotId = 1, slotNum do
			self.modInfoMap[modType][slotId] = 0
		end

		return true
	end

	return false
end

function TowerComposePlaneMo:buildAllDefaultModInfoMap()
	self.modInfoMap = {}

	for modType = TowerComposeEnum.ModType.Body, TowerComposeEnum.ModType.Env do
		self:buildDefaultModInfoMap(modType)
	end
end

function TowerComposePlaneMo:buildModInfoList()
	self.modeInfoList = {}
	self.level = 0

	for modType, modTypeData in pairs(self.modInfoMap) do
		self.modeInfoList[modType] = self.modeInfoList[modType] or {}

		for slot, modId in pairs(modTypeData) do
			local data = {}

			data.slot = slot
			data.modId = modId

			table.insert(self.modeInfoList[modType], data)

			if modId > 0 then
				local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)

				self.level = self.level + modConfig.level
			end
		end

		table.sort(self.modeInfoList[modType], function(a, b)
			return a.slot < b.slot
		end)
	end
end

function TowerComposePlaneMo:updateTeamInfo(teamInfo)
	if not teamInfo.heroes then
		return
	end

	self.teamInfoData.heros = {}

	for _, heroInfo in ipairs(teamInfo.heroes) do
		local heroData = {}

		heroData.pos = heroInfo.pos
		heroData.heroId = heroInfo.heroId
		heroData.trialId = heroInfo.trialId
		heroData.equipId = heroInfo.mindId
		self.teamInfoData.heros[heroData.pos] = heroData
	end

	self.teamInfoData.supportId = teamInfo.supportId
	self.teamInfoData.researchId = teamInfo.researchId
	self.teamInfoData.clothId = teamInfo.playerSkill

	self:updateSupportAssistHero(teamInfo.supportAssistHero)
end

function TowerComposePlaneMo:updateSupportAssistHero(supportAssistHero)
	local assistHero = {}

	assistHero.heroUid = tonumber(supportAssistHero.uid)
	assistHero.heroId = tonumber(supportAssistHero.heroId)
	assistHero.level = supportAssistHero.level
	assistHero.skin = supportAssistHero.skin
	assistHero.exSkillLevel = supportAssistHero.exSkillLevel
	self.teamInfoData.assistHero = assistHero
end

function TowerComposePlaneMo:getTeamInfoData()
	return self.teamInfoData
end

function TowerComposePlaneMo:getEquipModId(modType, slot)
	return (self.modInfoMap[modType] or nil) and (self.modInfoMap[modType][slot] or 0)
end

function TowerComposePlaneMo:setEquipModId(modType, slot, modId)
	self:buildDefaultModInfoMap(modType)

	self.modInfoMap[modType][slot] = modId

	self:buildModInfoList()
end

function TowerComposePlaneMo:getModInfoList(modType)
	local needBuild = self:buildDefaultModInfoMap(modType)

	if needBuild then
		self:buildModInfoList()
	end

	return self.modeInfoList[modType] or {}
end

function TowerComposePlaneMo:getAllModeInfoList()
	return self.modeInfoList
end

function TowerComposePlaneMo:getHaveModInfoList(modType)
	local modInfoList = self:getModInfoList(modType)
	local haveModInfoList = {}

	for index, modInfo in ipairs(modInfoList) do
		if modInfo.modId > 0 then
			table.insert(haveModInfoList, modInfo)
		end
	end

	return haveModInfoList
end

function TowerComposePlaneMo:dropAllSlotMod(modType)
	self:buildDefaultModInfoMap(modType)

	for slotId, modId in pairs(self.modInfoMap[modType]) do
		self.modInfoMap[modType][slotId] = 0
	end

	self:buildModInfoList()
end

function TowerComposePlaneMo:getEquipModLevel(modType)
	local curModLevel = 0
	local modeList = self.modeInfoList[modType]

	for _, modInfo in ipairs(modeList) do
		if modInfo.modId > 0 then
			local modConfig = TowerComposeConfig.instance:getComposeModConfig(modInfo.modId)

			curModLevel = curModLevel + modConfig.level
		end
	end

	return curModLevel
end

function TowerComposePlaneMo:getPlaneLevelByEquipMod(modType, slotId, modId)
	local modConfig = TowerComposeConfig.instance:getComposeModConfig(modId)
	local slotModId = self.modInfoMap[modType][slotId]
	local tempLevel = self.level

	if slotModId > 0 then
		local curModConfig = TowerComposeConfig.instance:getComposeModConfig(slotModId)

		tempLevel = tempLevel - curModConfig.level
	end

	return tempLevel + modConfig.level
end

return TowerComposePlaneMo
