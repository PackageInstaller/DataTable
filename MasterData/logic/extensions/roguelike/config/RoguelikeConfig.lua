-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/config/RoguelikeConfig.lua

module("logic.extensions.roguelike.config.RoguelikeConfig", package.seeall)

local M = class("RoguelikeConfig", BaseConfig)
local SCRIPT_100 = 100
local SCRIPT_101 = 101
local SCRIPT_999 = 999

function M:onInit()
	self._events = {}
	self._plotEvents = {}
	self._monsters = {}
	self._monsterBoss = {}
	self._roles = {}
	self._eventReply = {}
	self._conditions = {}
	self._effects = {}
	self._scripts = {}
	self._mapDices = {}
	self._maps = {}
	self._rooms = {}
	self._layers = {}
	self._props = {}
	self._consts = {}
	self._bigEvents = {}
	self._mapPlates = {}
	self._mapShapes = {}
	self._equips = {}
	self._tasks = {}
	self._taskLabels = {}
	self._campEffects = {}
	self._galleries = {}
	self._touchs = {}
	self._diffLevels = {}
	self._faceEffects = {}
	self._rectifyEffects = {}
	self._broadcast = {}
	self._fixedRooms = {}
	self._taskBubbleCfg = {}
	self._roleActions = {}
	self._monsterActions = {}
	self._extraPatterns = {}
	self._cardEntries = {}
	self._plots = {}
end

function M:getNames()
	return {
		ConfigName.RoguelikeEvent .. "_" .. SCRIPT_100,
		ConfigName.RoguelikeEvent .. "_" .. SCRIPT_101,
		ConfigName.RoguelikeEvent .. "_" .. SCRIPT_999,
		ConfigName.RoguelikePlotEvent .. SCRIPT_100,
		ConfigName.RoguelikePlotEvent .. SCRIPT_101,
		ConfigName.RoguelikePlotEvent .. SCRIPT_999,
		ConfigName.RoguelikeMonster,
		ConfigName.RoguelikeMonsterBoss,
		ConfigName.RoguelikeRole,
		ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_100,
		ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_101,
		ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_999,
		ConfigName.RoguelikeCondition,
		ConfigName.RoguelikeEffect,
		ConfigName.RoguelikeScript,
		ConfigName.RoguelikeMapDice,
		ConfigName.RoguelikeMap,
		ConfigName.RoguelikeRoom,
		ConfigName.RoguelikeLayer,
		ConfigName.RoguelikeProp,
		ConfigName.RoguelikeConst,
		ConfigName.RoguelikeBigEvent .. "_" .. SCRIPT_100,
		ConfigName.RoguelikeMapPlate,
		ConfigName.RoguelikeMapShape,
		ConfigName.RoguelikeNegativeSanEffect,
		ConfigName.RoguelikeEquip,
		ConfigName.RoguelikeTask,
		ConfigName.RoguelikeTaskLabel,
		ConfigName.RoguelikeCampEffect,
		ConfigName.RoguelikeGallery,
		ConfigName.RoguelikeTouch,
		ConfigName.RoguelikeDiffLevel,
		ConfigName.RoguelikeFaceEffect,
		ConfigName.RoguelikeRectifyEffect,
		ConfigName.RoguelikeBroadcast,
		ConfigName.RoguelikeFixedRoom,
		ConfigName.RoguelikeTaskShowBubble,
		ConfigName.RoguelikeRoleAction,
		ConfigName.RoguelikeMonsterAction,
		ConfigName.RoguelikeExtraPattern,
		ConfigName.RoguelikeCardEntry,
		ConfigName.RoguelikePlot
	}
end

function M:handleConfig(name, content)
	if name == ConfigName.RoguelikeMonster then
		self._monsters = content
	elseif name == ConfigName.RoguelikeMonsterBoss then
		self._monsterBoss = content
	elseif name == ConfigName.RoguelikeEvent .. "_" .. SCRIPT_100 then
		self._events[SCRIPT_100] = content
	elseif name == ConfigName.RoguelikeEvent .. "_" .. SCRIPT_101 then
		self._events[SCRIPT_101] = content
	elseif name == ConfigName.RoguelikeEvent .. "_" .. SCRIPT_999 then
		self._events[SCRIPT_999] = content
	elseif name == ConfigName.RoguelikePlotEvent .. SCRIPT_100 then
		self._plotEvents[SCRIPT_100] = content
	elseif name == ConfigName.RoguelikePlotEvent .. SCRIPT_101 then
		self._plotEvents[SCRIPT_101] = content
	elseif name == ConfigName.RoguelikePlotEvent .. SCRIPT_999 then
		self._plotEvents[SCRIPT_999] = content
	elseif name == ConfigName.RoguelikeRole then
		self._roles = content
	elseif name == ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_100 then
		self._eventReply[SCRIPT_100] = content
	elseif name == ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_101 then
		self._eventReply[SCRIPT_101] = content
	elseif name == ConfigName.RoguelikeEventReply .. "_" .. SCRIPT_999 then
		self._eventReply[SCRIPT_999] = content
	elseif name == ConfigName.RoguelikeCondition then
		self._conditions = content
	elseif name == ConfigName.RoguelikeEffect then
		self._effects = content
	elseif name == ConfigName.RoguelikeScript then
		self._scripts = content
	elseif name == ConfigName.RoguelikeMapDice then
		self._mapDices = content
	elseif name == ConfigName.RoguelikeMap then
		self._maps = content
	elseif name == ConfigName.RoguelikeRoom then
		self._rooms = content
	elseif name == ConfigName.RoguelikeLayer then
		self._layers = content
	elseif name == ConfigName.RoguelikeProp then
		self._props = content
	elseif name == ConfigName.RoguelikeConst then
		self._consts = content
	elseif name == ConfigName.RoguelikeBigEvent .. "_" .. SCRIPT_100 then
		self._bigEvents[SCRIPT_100] = content
	elseif name == ConfigName.RoguelikeMapPlate then
		self._mapPlates = content
	elseif name == ConfigName.RoguelikeMapShape then
		self._mapShapes = content
	elseif name == ConfigName.RoguelikeNegativeSanEffect then
		self._negativeSanEffect = content
	elseif name == ConfigName.RoguelikeEquip then
		self._equips = content
	elseif name == ConfigName.RoguelikeTask then
		self._tasks = content
	elseif name == ConfigName.RoguelikeTaskLabel then
		self._taskLabels = content

		TaskModel.instance:initTaskTabData(content.dataList)
	elseif name == ConfigName.RoguelikeCampEffect then
		self._campEffects = content
	elseif name == ConfigName.RoguelikeGallery then
		self._galleries = content
	elseif name == ConfigName.RoguelikeTouch then
		self._touchs = content
	elseif name == ConfigName.RoguelikeDiffLevel then
		self._diffLevels = content
	elseif name == ConfigName.RoguelikeFaceEffect then
		self._faceEffects = content
	elseif name == ConfigName.RoguelikeRectifyEffect then
		self._rectifyEffects = content
	elseif name == ConfigName.RoguelikeBroadcast then
		self._broadcast = content
	elseif name == ConfigName.RoguelikeFixedRoom then
		self._fixedRooms = content
	elseif name == ConfigName.RoguelikeTaskShowBubble then
		self._taskBubbleCfg = content
	elseif name == ConfigName.RoguelikeRoleAction then
		self._roleActions = content
	elseif name == ConfigName.RoguelikeMonsterAction then
		self._monsterActions = content
	elseif name == ConfigName.RoguelikeExtraPattern then
		self._extraPatterns = content
	elseif name == ConfigName.RoguelikeCardEntry then
		self._cardEntries = content
	elseif name == ConfigName.RoguelikePlot then
		self._plots = content
	end
end

function M:getNegativeSanCoBySan(san)
	local co = self._negativeSanEffect[san]

	return co
end

function M:getRoguelikeEventById(id, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	return self._events[scriptId][scriptId][id]
end

function M:getPlotEventById(id, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	return self._plotEvents[scriptId][scriptId][id]
end

function M:getRoguelikeMonsterById(id)
	local co = self._monsters[id]

	if co == nil then
		co = self._monsterBoss[id]
	end

	return co
end

function M:getRoguelikeRoleById(id)
	return CharacterConfig.instance:getCharacterItemInfo(id)
end

function M:getRoleName(id)
	return PastInfoConfig.instance:getCharacterInfo(id).name
end

function M:getAllMonster()
	return self._monsters.dataList
end

function M:getAllRole()
	return self._roles.dataList
end

function M:getEventReplyById(id, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	local reply = self._eventReply[scriptId][scriptId][id]

	if not reply then
		printError("找不到应对id", id, "所在剧本", scriptId)
	end

	return reply
end

function M:getConditionById(id)
	return self._conditions[id]
end

function M:getEffectById(id)
	local effectCo = self._effects[id]

	if id ~= 0 and not effectCo then
		printError("找不到效果id", id)
	end

	return effectCo
end

function M:getScriptById(id)
	return self._scripts[id]
end

function M:getFixedRoomById(id)
	return self._fixedRooms[id]
end

function M:getAllScript()
	local allScripts = {}

	for k, v in pairs(self._scripts) do
		if type(k) == "number" then
			table.insert(allScripts, v)
		end
	end

	table.sort(allScripts, function(a, b)
		return a.id < b.id
	end)

	return allScripts
end

function M:getMapDiceById(id)
	return self._mapDices[id]
end

function M:getMapById(id)
	return self._maps[id]
end

function M:getAllMap()
	return self._maps.dataList
end

function M:getMapBySceneCode(sceneCode)
	self._sceneCode2Map = self._sceneCode2Map or {}

	if not self._sceneCode2Map[sceneCode] then
		for k, v in pairs(self._maps.dataList) do
			if v.sceneCode == sceneCode then
				self._sceneCode2Map[sceneCode] = v

				return v
			end
		end

		return nil
	else
		return self._sceneCode2Map[sceneCode]
	end
end

function M:getRoomById(id)
	return self._rooms[id]
end

function M:getPropById(id)
	local prop = self._props[id]

	if not prop then
		printError("找不到道具", id)
	end

	return prop
end

function M:getAllProps()
	return self._props.dataList
end

function M:getPropIsUseDelete(propId)
	local propCo = self:getPropById(propId)

	if propCo then
		local effectIds = propCo.effectIds

		for k, v in pairs(effectIds or {}) do
			if v == 10000000 then
				return true
			end
		end
	end

	return false
end

function M:checkHadLayer(scriptId)
	local exist = self._layers[scriptId] ~= nil

	return exist
end

function M:getLayerCount(scriptId)
	local layers = self._layers[scriptId] or {}

	return #layers
end

function M:getConstByName(name)
	return self._consts[name]
end

function M:getConstEffect(name)
	local co = self:getConstByName(name)

	if co ~= nil then
		return co.numValue
	end

	printError("常量表找不到效果", name)
end

function M:getBigEventId(scriptId, layer)
	local layers = self._layers[scriptId] or {}

	for k, v in ipairs(layers) do
		if v.layer == layer then
			return v.bigEventId
		end
	end

	return 0
end

function M:getBigBossId(scriptId, layer)
	local layers = self._layers[scriptId] or {}

	for k, v in ipairs(layers) do
		if v.layer == layer then
			return v.bigBossId
		end
	end

	return 0
end

function M:getFirstSceneMapId(scriptId, layer)
	local layers = self._layers[scriptId] or {}

	for k, v in ipairs(layers) do
		if v.layer == layer then
			return v.mapIds[1]
		end
	end

	return 0
end

function M:getBigEventStartEventId(scriptId, bigEventId)
	return bigEventId
end

function M:getMapShapeById(shapeId)
	return self._mapShapes[shapeId]
end

function M:getEquipById(id, level)
	level = level or 1

	if self._equips[id] then
		return self._equips[id][level]
	end

	return nil
end

function M:getEquipMaxLevel(id)
	if self._equips[id] then
		return #self._equips[id]
	end

	return 1
end

function M:getTaskById(id)
	return self._tasks[id]
end

function M:getCampEffectById(id)
	return self._campEffects[id]
end

function M:getAllCampAffect()
	return self._campEffects.dataList
end

function M:getGalleryById(id)
	return self._galleries[id]
end

function M:getAllGallery()
	return self._galleries.dataList
end

function M:getAllTouch()
	return self._touchs.dataList
end

function M:getTouchById(id)
	return self._touchs[id]
end

function M:getScriptDiffLevel(scriptId)
	self._scriptLevels = self._scriptLevels or {}
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	if self._scriptLevels[scriptId] then
		return self._scriptLevels[scriptId]
	end

	local diffLevel = 0

	for k, v in pairs(self._diffLevels) do
		if v.id == scriptId then
			diffLevel = diffLevel + 1
		end
	end

	self._scriptLevels[scriptId] = diffLevel

	return diffLevel
end

function M:getDiffLevelByLevel(level, scriptId)
	return self._diffLevels[level]
end

function M:getDiffLevelByLevelIndex(levelIndex, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	local cos = self:getScriptDiffCo(scriptId)

	for k, v in pairs(cos) do
		local co = cos[k]

		if k - 1 == levelIndex then
			return v
		end
	end

	return nil
end

function M:getScriptDiffCo(scriptId)
	self._script2LevelList = self._script2LevelList or {}
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	if self._script2LevelList[scriptId] then
		return self._script2LevelList[scriptId]
	end

	local scriptCos = {}

	for k, v in pairs(self._diffLevels) do
		if v.id == scriptId then
			table.insert(scriptCos, v)
		end
	end

	table.sort(scriptCos, function(a, b)
		return a.level < b.level
	end)

	self._script2LevelList[scriptId] = scriptCos

	return scriptCos
end

function M:getCurDiffLevelEffects(level, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	if not self._diffLevels[level] then
		return nil
	end

	local allEffects = {}
	local cos = self:getScriptDiffCo(scriptId)

	for k, v in pairs(cos) do
		local co = cos[k]

		if level >= v.level and co.effectIds ~= nil then
			TableUtil.addRange(allEffects, co.effectIds)
		end
	end

	return allEffects
end

function M:getCurDiffLevelEffectsByIndex(levelIndex, scriptId)
	scriptId = scriptId or RoguelikeModel.instance:getCurScriptId()
	scriptId = scriptId or SCRIPT_100

	local allEffects = {}
	local cos = self:getScriptDiffCo(scriptId)

	for k, v in pairs(cos) do
		local co = cos[k]

		if k <= levelIndex + 1 and co.effectIds ~= nil then
			TableUtil.addRange(allEffects, co.effectIds)
		end
	end

	return allEffects
end

function M:getDiffLevelIndexByLevel(level, scriptId)
	if not level or level == 0 or not self._diffLevels[level] then
		return 0
	end

	scriptId = scriptId or self._diffLevels[level].id
	scriptId = scriptId or SCRIPT_100

	local cos = self:getScriptDiffCo(scriptId)

	for k, v in ipairs(cos) do
		if v.level == level then
			return k - 1
		end
	end

	return 0
end

function M:getAllFaceEffect()
	return self._faceEffects.dataList
end

function M:getFaceEffectById(id)
	return self._faceEffects[id]
end

function M:getRectifyEffectById(id)
	return self._rectifyEffects[id]
end

local PowerNodeEffectEnum = {
	HOUSE = 3,
	POWER_LEVEL_UP = 5,
	UNLOCK_DRAW = 6,
	ATTR_ADD = 1,
	UNLOCK_ROGUELIKE_SKILL = 7,
	SKILL_UPGRADE = 2,
	UNLOCK_TEXT = 4
}

function M:getFeatureSkillByHeroId(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	return self:getFeatureSkillByHeroMO(heroMO)
end

function M:getFeatureSkillByHeroMO(heroMO)
	local skillList = {}
	local skillIds = heroMO:getRoguelikeSkillIds()
	local nodes = HeroPowerConfig.instance:getCharacterAllNodeInfos(heroMO:getId())

	for _, nodeCO in ipairs(nodes) do
		local skills = skillIds
		local isUnlockSkill = false

		for k, v in pairs(nodeCO.effect) do
			if v == PowerNodeEffectEnum.UNLOCK_ROGUELIKE_SKILL then
				isUnlockSkill = true
			end
		end

		if isUnlockSkill then
			for _, skill in ipairs(skills) do
				local unlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(nodeCO.heroId, nodeCO.code)

				table.insert(skillList, {
					skillId = skill,
					isUnlock = unlock,
					nodeCO = nodeCO
				})
			end
		end
	end

	return skillList
end

function M:getRoguelikeRoleSkillUnlock(heroId)
	local heroMO = HeroDepotModel.instance:getHeroInfoByID(heroId)

	if not heroMO then
		return false
	end

	if not RoguelikeConst.IsGuideFinish() then
		return true
	end

	local skillIds = heroMO:getRoguelikeSkillIds()
	local nodes = HeroPowerConfig.instance:getCharacterAllNodeInfos(heroId)

	for _, nodeCO in ipairs(nodes) do
		local skills = skillIds
		local isUnlockSkill = false

		for k, v in pairs(nodeCO.effect) do
			if v == PowerNodeEffectEnum.UNLOCK_ROGUELIKE_SKILL then
				isUnlockSkill = true
			end
		end

		if isUnlockSkill then
			for _, skill in ipairs(skills) do
				local unlock = CharacterAuthorityModel.instance:checkNodeIsUnlock(nodeCO.heroId, nodeCO.code)

				if unlock then
					return true
				end
			end
		end
	end

	return false
end

function M:getBroadCastByName(name)
	local co = self._broadcast[name]

	return co and co.strValue
end

function M:getBroadCastIsTitle(name)
	local co = self._broadcast[name]

	return co and co.isTitle == 1
end

function M.getBroadCast(name)
	return M.instance:getBroadCastByName(name), M.instance:getBroadCastIsTitle(name)
end

function M:getHandbookCount(galleryId)
	self.handbookCount = self.handbookCount or {}

	local item = self.handbookCount[galleryId] or {}

	if item and #item > 0 then
		return item[1], item[2], item[3], item[4]
	end

	local allMonsters = RoguelikeConfig.instance:getAllMonster()
	local curMonsters = {}

	for k, v in pairs(allMonsters) do
		if v.galleryId == galleryId then
			table.insert(curMonsters, v)
		end
	end

	local allProps = RoguelikeConfig.instance:getAllProps()
	local curProps = {}

	for k, v in pairs(allProps) do
		if v.galleryId == galleryId then
			table.insert(curProps, v)
		end
	end

	local allThreads = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeClueType)
	local curThreads = {}

	for k, v in pairs(allThreads) do
		if v.galleryId == galleryId then
			table.insert(curThreads, v)
		end
	end

	local allCount = #curMonsters + #curProps + #curThreads

	table.insert(item, allCount)
	table.insert(item, #curMonsters)
	table.insert(item, #curProps)
	table.insert(item, #curThreads)

	self.handbookCount[galleryId] = item

	return allCount, #curMonsters, #curProps, #curThreads
end

function M:getBubbleByFactor(factor)
	local tmp = {}

	for _, v in pairs(self._taskBubbleCfg) do
		if v.factor == factor then
			table.insert(tmp, v)
		end
	end

	local randomIndex = math.random(#tmp)
	local bubbleCo = tmp[randomIndex]

	if not bubbleCo then
		printError("找不到气泡配置", factor)
	end

	return bubbleCo
end

function M:getRoleActionById(id)
	return self._roleActions[id]
end

function M:getMonsterActionById(id)
	return self._monsterActions[id]
end

function M:getExtraPatternById(pattern)
	return self._extraPatterns[pattern]
end

function M:getCardEntryById(id)
	return self._cardEntries[id]
end

function M:getPlotListById(id)
	local list = {}

	if id == 0 or id == nil then
		return list
	end

	for k, v in pairs(self._plots.dataList) do
		if v.code == id then
			table.insert(list, v)
		end
	end

	table.sort(list, function(a, b)
		return a.stepCode < b.stepCode
	end)

	return list
end

M.instance = M.New()

return M
