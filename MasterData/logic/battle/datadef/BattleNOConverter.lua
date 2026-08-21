-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/datadef/BattleNOConverter.lua

module("logic.battle.datadef.BattleNOConverter", package.seeall)

local BattleNOConverter = class("BattleNOConverter")

function BattleNOConverter:convertBattleNO(battleNO)
	local battleFieldInfo = BattleFieldInfo:createInstance()

	battleFieldInfo.battleId = battleNO.id
	battleFieldInfo.pvpType = BattleExtension_pb.GameType.DEFAULT
	battleFieldInfo.sceneCode = battleNO.map
	battleFieldInfo.operateCampId = battleNO.myPlayerId
	battleFieldInfo.stepCampId = battleNO.stepPlayer
	battleFieldInfo.round = battleNO.round
	battleFieldInfo.leftUndoCount = battleNO.leftBackCount
	battleFieldInfo.npcCampId = battleNO.systemPlayer and battleNO.systemPlayer.id or 0
	battleFieldInfo.aiMode = battleNO.aiMode

	for i, hero in ipairs(battleNO.heros) do
		battleFieldInfo:addHeroInBattle(hero)
	end

	local entities = battleNO.entities

	for _, entityNO in ipairs(entities) do
		battleFieldInfo:addEntityInfo(self:entityNO2EntityInfo(entityNO))
	end

	local stages = battleNO.stages

	for index, stageNO in ipairs(stages) do
		local players = stageNO.players

		for _, playerNO in ipairs(players) do
			battleFieldInfo:addCampInfo(self:_playerNO2CampInfo(index - 1, playerNO))
		end
	end

	if battleNO.systemPlayer then
		local campInfo = BattleCampInfo:createInstance()

		campInfo.stageId = -1
		campInfo.campId = battleNO.systemPlayer.id

		battleFieldInfo:addCampInfo(campInfo)
	end

	local cells = battleNO.cells

	for _, cellNO in ipairs(cells) do
		self:_parseCellsBlockedEventNOList(battleFieldInfo, cellNO)
		battleFieldInfo:addCellInfo(self:_cellNO2CellInfo(cellNO))
	end

	local haloLinks = battleNO.haloLinks

	for _, haloLinkedNO in ipairs(haloLinks) do
		battleFieldInfo:addInitCommand(BattleHaloRefreshedCommand:createAddFromLinkedNO(haloLinkedNO))
	end

	self:_parseExtraEventNOList(battleFieldInfo, battleNO)
	self:_parseUndoList(battleFieldInfo, battleNO)

	return battleFieldInfo
end

function BattleNOConverter:convert(battleInfoNO)
	local battleFieldInfo = BattleNOConverter:convertBattleNO(battleInfoNO.battlefield)

	battleFieldInfo.battleType = battleInfoNO.type
	battleFieldInfo.multiplied = battleInfoNO.multiplied or 1
	battleFieldInfo.gameplay = battleInfoNO.gameplay or false

	return battleFieldInfo
end

function BattleNOConverter:convertAsPvp(battleInfoNO)
	local battleFieldInfo = BattleNOConverter:convert(battleInfoNO)

	battleFieldInfo.pvpType = battleInfoNO.pvpType

	local players = battleInfoNO.players

	for _, pvpPlayerNO in ipairs(players) do
		local campInfo = battleFieldInfo:getCampInfo(pvpPlayerNO.playerId)

		campInfo.userId = pvpPlayerNO.userId
		campInfo.gameTeamId = pvpPlayerNO.teamId
	end

	return battleFieldInfo
end

local kWeakPointHp = "weakPointHp"

function BattleNOConverter:entityNO2EntityInfo(entityNO)
	local boardModel = BattleMgr.instance:getBoardModel()
	local entityInfo = BattleEntityInfo:createInstance()
	local bornUnionIndex = -1

	if entityNO:HasField("cell") then
		bornUnionIndex = BoardIndexConverter.cellNOToUnionIndex(entityNO.cell)
	end

	entityInfo.entityId = entityNO.id
	entityInfo.entityCode = entityNO.code
	entityInfo.battleCamp = entityNO.battleCamp
	entityInfo.viewEntityCode = entityNO.viewCode
	entityInfo.entityType = entityNO.type
	entityInfo.level = entityNO.level
	entityInfo.userId = entityNO.player
	entityInfo.campId = entityNO.player
	entityInfo.bornUnionIndex = bornUnionIndex
	entityInfo.tagEnhances = entityNO.tagEnhances
	entityInfo.modelId = entityNO.modelId

	local extraNO = entityNO.extra

	if extraNO:HasField("lookAt") then
		entityInfo.direction = extraNO.direction
		entityInfo.lookAtDirection = Coordinates:createInstance(extraNO.lookAt.x, extraNO.lookAt.z)
	else
		entityInfo.direction = extraNO.direction
		entityInfo.lookAtDirection = false
	end

	entityInfo.bodyEffect = extraNO.bodyEffect

	local attributes = entityNO.attributes

	for _, attributeNO in ipairs(attributes) do
		entityInfo:addBaseAttribute(attributeNO.attr, BattleMathUtil.removePrecision(attributeNO.initial))
		entityInfo:addAttribute(attributeNO.attr, BattleMathUtil.removePrecision(attributeNO.value))
	end

	if entityNO:HasField(kWeakPointHp) then
		entityInfo:addAttribute(BattleEnum.Attribute.CURRENT_WEAKPOINT_HP, entityNO.weakPointHp)
		entityInfo:addAttribute(BattleEnum.Attribute.MAX_WEAKPOINT_HP, entityNO.maxWeakPointHp)
		entityInfo:addAttribute(BattleEnum.Attribute.WEAKPOINT_TYPE, entityNO.weakPointType)
	end

	local skills = entityNO.skills

	for _, skillNO in ipairs(skills) do
		entityInfo:addSkillFromSkillNO(skillNO)
	end

	local buffs = entityNO.buffs

	for _, buffNO in ipairs(buffs) do
		entityInfo:addBuff(buffNO.id, buffNO.code, buffNO.round, buffNO.layer)
	end

	local tags = entityNO.tags

	for _, tag in ipairs(tags) do
		entityInfo:addTag(tag)
	end

	local states = entityNO.state

	for _, state in ipairs(states) do
		entityInfo:addState(state)
	end

	local immuneBuffs = entityNO.immuneBuffs

	for _, buff in ipairs(immuneBuffs) do
		entityInfo:addImmuneBuffs(buff)
	end

	if not entityNO.steppable then
		entityInfo:addState(BattleEnum.State.STEPPED)
	end

	entityInfo:addCell(entityNO.cell)

	return entityInfo
end

function BattleNOConverter:_playerNO2CampInfo(stageId, playerNO)
	local campInfo = BattleCampInfo:createInstance()

	campInfo.stageId = stageId
	campInfo.campId = playerNO.id

	return campInfo
end

function BattleNOConverter:_cellNO2CellInfo(cellNO)
	local cellInfo = BattleCellInfo:createInstance()

	cellInfo.unionIndex = BoardIndexConverter.cellNOToUnionIndex(cellNO)

	local additionalTerrainNOList = cellNO.additionalTerrains

	for _, additionalTerrainNO in ipairs(additionalTerrainNOList) do
		cellInfo:setFromAdditionalTerrainNO(additionalTerrainNO)
	end

	return cellInfo
end

function BattleNOConverter:_parseCellsBlockedEventNOList(battleFieldInfo, cellNO)
	local blockedNOList = cellNO.blocked

	if #blockedNOList <= 0 then
		return
	end

	local unionIndex = BoardIndexConverter.cellNOToUnionIndex(cellNO)

	for _, blockedNO in ipairs(blockedNOList) do
		battleFieldInfo:addInitCommand(BattleCellsBlockedCommand:createFromCellsBlockedEventNO(unionIndex, blockedNO))
	end
end

local cmdParser = BattleCmdParser.New()

function BattleNOConverter:_parseExtraEventNOList(battleFieldInfo, battleNO)
	local sequenceCommand = BattleSequenceCommand:createInstance()

	battleFieldInfo:addInitCommand(sequenceCommand)
	cmdParser:internal_begin()
	cmdParser:pushCmdContainer(sequenceCommand)

	local multiRoundAoes = battleNO.multiRoundAoes

	if multiRoundAoes then
		for _, multiRoundAoeNO in ipairs(multiRoundAoes) do
			BattleMultiRoundAoeRedoCommand:parseServerRedoCommand(cmdParser, multiRoundAoeNO)
		end
	end

	local extraNOList = battleNO.battleExtra

	BattleCmdUtil.parseServerRedoCommandBatch(cmdParser, extraNOList)

	local myPlayerNO = self:_getMyPlayerNO(battleNO)

	if myPlayerNO then
		BattlePlayerStatisticRedoCommand:parseServerRedoCommand(cmdParser, myPlayerNO)
	end

	cmdParser:internal_clear()
end

function BattleNOConverter:_getMyPlayerNO(battleNO)
	local stages = battleNO.stages

	for index, stageNO in ipairs(stages) do
		local players = stageNO.players

		for _, playerNO in ipairs(players) do
			if playerNO.id == battleNO.myPlayerId then
				return playerNO
			end
		end
	end
end

function BattleNOConverter:_parseUndoList(battleFieldInfo, battleNO)
	local stepHistoryNOList = battleNO.stepHistory

	if not stepHistoryNOList or #stepHistoryNOList <= 0 then
		if battleNO.round == 1 then
			battleFieldInfo:addInitUndoMO(BattleUndoMO:createRoundMO(battleNO.round))
		end

		return
	end

	local lastStep = 0
	local lastRound = false

	for _, stepHistoryNO in ipairs(stepHistoryNOList) do
		local undoMO = BattleUndoMO:createFromStepHistoryNO(stepHistoryNO)

		if lastRound ~= undoMO:getRound() then
			lastRound = undoMO:getRound()
			lastStep = 0

			battleFieldInfo:addInitUndoMO(BattleUndoMO:createRoundMO(lastRound))
		end

		lastStep = lastStep + 1

		undoMO:setStep(lastStep)
		battleFieldInfo:addInitUndoMO(undoMO)
	end

	if lastRound < battleNO.round then
		battleFieldInfo:addInitUndoMO(BattleUndoMO:createRoundMO(battleNO.round))
	end
end

return BattleNOConverter
