-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/BattleCmdUtil.lua

module("logic.battle.battleflow.component.command.BattleCmdUtil", package.seeall)

local BattleCmdUtil = {}

BattleCmdUtil.cmd_weakPointStatusChanged = "weakPointStatusChanged"
BattleCmdUtil.cmd_skillTriggered = "skillTriggered"
BattleCmdUtil.cmd_attributeModified = "attributeModified"
BattleCmdUtil.cmd_weakPointHpChanged = "weakPointHpChanged"
BattleCmdUtil.cmd_entityDead = "entityDead"
BattleCmdUtil.cmd_battleEnded = "battleEnded"
BattleCmdUtil.cmd_plotChainTriggered = "plotChainTriggered"
BattleCmdUtil.cmd_buffRemoved = "buffRemoved"
BattleCmdUtil.cmd_buffRoundDecred = "buffRoundDecred"
BattleCmdUtil.cmd_entitiesAdded = "entitiesAdded"
BattleCmdUtil.cmd_positionChanged = "positionChanged"
BattleCmdUtil.cmd_buffAdded = "buffAdded"
BattleCmdUtil.cmd_terrainUpdated = "terrainUpdated"
BattleCmdUtil.cmd_terrainChange = "terrainChange"
BattleCmdUtil.cmd_damaged = "damaged"
BattleCmdUtil.cmd_groupEvent = "groupEvent"
BattleCmdUtil.cmd_cured = "cured"
BattleCmdUtil.cmd_doomForecast = "doomForecast"
BattleCmdUtil.cmd_tagTriggered = "tag"
BattleCmdUtil.cmd_modifiedTagTriggered = "tagWithBase"
BattleCmdUtil.cmd_shoot = "shoot"
BattleCmdUtil.cmd_skillAdd = "skillAdded"
BattleCmdUtil.cmd_multiRoundAoeAdd = "multiRoundAoeAdd"
BattleCmdUtil.cmd_multiRoundHold = "multiEntityHold"
BattleCmdUtil.cmd_entitiesSwapped = "entitiesSwapped"
BattleCmdUtil.cmd_triggering = "triggering"

local kEventKey2CommandClass = {
	stageStarted = BattleCampStageStartedCommand,
	stageEnded = BattleCampStageEndedCommand,
	playerStarted = BattlePlayerStartedCommand,
	playerEnded = BattlePlayerEndedCommand,
	battleEnded = BattleEndedCommand,
	skillTriggered = BattleSkillTriggeredCommand,
	buffTriggered = BattleBuffTriggeredCommand,
	attributeModified = BattlePropertyModifiedCommand,
	buffAdded = BattleBuffAddedCommand,
	buffRemoved = BattleBuffRemovedCommand,
	buffRoundDecred = BattleBuffRoundDecredCommand,
	cured = BattleCuredCommand,
	entityDead = BattleEntityDeadCommand,
	entityStepped = BattleEntitySteppedCommand,
	weakPointHpChanged = BattleWeakPointHpChangedCommand,
	positionChanged = BattlePositionChangedCommand,
	entitiesAdded = BattleEntitiesAddedCommand,
	entityRemoved = BattleEntityRemovedCommand,
	entitiesSwapped = BattleEntitiesSwappedCommand,
	roundStarted = BattleRoundStartedCommand,
	plotChainTriggered = BattlePlotChainTriggeredCommand,
	plotTriggered = BattlePlotTriggeredCommand,
	damaged = BattleDamagedCommand,
	stateAdded = BattleStateAddedCommand,
	stateRemoved = BattleStateRemovedCommand,
	cellsBlocked = BattleCellsBlockedCommand,
	cellsUnblocked = BattleCellsUnblockedCommand,
	cup = BattleCupUpdatedCommand,
	haloRefreshed = BattleHaloRefreshedCommand,
	entityConfigChanged = BattleEnitityConfigChangedCommand,
	userReady = BattleUserReadyCommand,
	cancelReady = BattleUserCancelReadyCommand,
	tacitTaskProgress = BattleTacitTaskProgressCommand,
	skillAdded = BattleSkillAddedCommand,
	skillRemoved = BattleSkillRemovedCommand,
	entityPlayerChanged = BattleEntityPlayerChangedCommand,
	wonConditionsChanged = BattleConditionsChangedCommand,
	terrainChange = BattleTerrainChangedCommand,
	terrainUpdated = BattleTerrainUpdatedCommand,
	skillCdUpdate = BattleSkillCdUpdateCommand,
	weakPointStatusChanged = BattleWeakPointStatusChangedCommand,
	weakPointAdded = BattleWeakPointAddedCommand,
	groupEvent = BattleGroupEventCommand,
	plotTriggered3D = BattlePlotTriggered3DCommand,
	tag = BattleTagTriggeredCommand,
	tagEnhanceAdds = BattleSkillTagEnhancesAddCommand,
	tagEnhanceRemoves = BattleSkillTagEnhancesRemoveCommand,
	multiRoundAoeAdd = EmptyCommand,
	multiRoundAoeRemove = EmptyCommand,
	multiRoundAoeUpdate = BattleMultiRoundAoeUpdateCommand,
	attributeRemoved = BattleAttributeRemoveCommand,
	back = BattleBackCommand,
	modelChanged = BattleUnitModelChangedCommand,
	steppableChange = BattleUnitSteppableChanged,
	multiEntityHold = EmptyCommand,
	weakPointRemoved = BattleWeakPointRemovedCommand,
	ImmuneBuffAdd = BattleImmuneBuffAddCommand,
	ImmuneBuffRemove = BattleImmuneBuffRemoveCommand,
	aiModeChangeNO = BattleAiModeChangeCommand,
	triggering = BattleTriggeringCommand,
	doomForecast = BattleDoomForecastCommand,
	lightColumn = BattleLightColumnUpdateCommand,
	sheetMusic = BattleSheetMusicCommand,
	pianoPlaying = BattlePianoPlayingCommand,
	airMessage = BattleAirMessageCommand
}
local kExtraKey2CommandClass = {
	doomForecast = BattleDoomForecastRedoCommand,
	lightColumn = BattleLightColumnRedoCommand,
	sheetMusic = BattleSheetMusicRedoCommand
}
local kTriggerEffectKey = {
	"skillTriggered",
	"buffTriggered",
	"weakPointStatusChanged"
}
local kSkillPerformanceKey = {
	"damaged",
	"cured",
	"buffAdded",
	"positionChanged"
}

function BattleCmdUtil.parseServerCommand(cmdParser, eventNO)
	for descriptor, value in eventNO:ListFields() do
		local commandClass = cmdParser:internal_getCmdClass(descriptor.name) or kEventKey2CommandClass[descriptor.name]

		if not commandClass then
			if BattleLog.enableError then
				BattleLog.error(string.format("BattleCmdUtil::unhandle EventNO %s", descriptor.name))
			end

			return
		end

		commandClass:parseServerCommand(cmdParser, value)
	end
end

function BattleCmdUtil.parseServerCommandBatch(cmdParser, eventNOList)
	if eventNOList and #eventNOList > 0 then
		for _, eventNO in ipairs(eventNOList) do
			BattleCmdUtil.parseServerCommand(cmdParser, eventNO)
		end
	end
end

function BattleCmdUtil.parseServerRedoCommand(cmdParser, battleExtraNO)
	for descriptor, value in battleExtraNO:ListFields() do
		local commandClass = kExtraKey2CommandClass[descriptor.name]

		if not commandClass then
			if BattleLog.enableError then
				BattleLog.error(string.format("BattleCmdUtil::unhandle BattleExtraNO %s", descriptor.name))
			end

			return
		end

		commandClass:parseServerRedoCommand(cmdParser, value)
	end
end

function BattleCmdUtil.parseServerRedoCommandBatch(cmdParser, battleExtraNOList)
	if battleExtraNOList and #battleExtraNOList > 0 then
		for _, battleExtraNO in ipairs(battleExtraNOList) do
			BattleCmdUtil.parseServerRedoCommand(cmdParser, battleExtraNO)
		end
	end
end

function BattleCmdUtil.getActiveEventNO(eventNO)
	for descriptor, value in eventNO:ListFields() do
		return value
	end
end

function BattleCmdUtil.splitServerTriggerEffect(eventNOList, resultBeforeTriggerList, resultAfterTriggerList)
	for _, eventNO in ipairs(eventNOList) do
		if eventNO:HasField("entityDead") then
			table.insert(resultAfterTriggerList, eventNO)
		else
			table.insert(resultBeforeTriggerList, eventNO)
		end
	end
end

function BattleCmdUtil.collectTotalChangedHp(eventNOList, totalChangedHpCmd)
	for _, eventNO in ipairs(eventNOList) do
		local effects = eventNO.skillTriggered.effects

		for i, effect in ipairs(effects) do
			for _, effectEventNO in ipairs(effect.events) do
				if effectEventNO:HasField("damaged") then
					totalChangedHpCmd:collectFromDamagedEventNO(effectEventNO.damaged)
				elseif effectEventNO:HasField("cured") then
					totalChangedHpCmd:collectFromCuredEventNO(effectEventNO.cured)
				elseif effectEventNO:HasField("groupEvent") then
					for j, effectEventNO1 in ipairs(effectEventNO.groupEvent.events) do
						if effectEventNO1:HasField("damaged") then
							totalChangedHpCmd:collectFromDamagedEventNO(effectEventNO1.damaged)
						elseif effectEventNO1:HasField("cured") then
							totalChangedHpCmd:collectFromCuredEventNO(effectEventNO1.cured)
						end
					end
				end
			end
		end
	end
end

function BattleCmdUtil.hasField(eventNO, eventKey)
	for descriptor, _ in eventNO:ListFields() do
		if descriptor.name == eventKey then
			return true
		end
	end

	return false
end

function BattleCmdUtil.containsAnyField(eventNO, eventKeyList)
	for _, eventKey in ipairs(eventKeyList) do
		if eventNO:HasField(eventKey) then
			return true
		end
	end

	return false
end

function BattleCmdUtil.containsTriggerEffect(eventNOList)
	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.containsAnyField(eventNO, kTriggerEffectKey) or BattleCmdUtil.containsAnyField(eventNO, kSkillPerformanceKey) then
			return true
		end
	end

	return false
end

function BattleCmdUtil.isStepEndedThenStepAgainTrigger(cmdParser, triggeredEventNO, isSkillTrigger)
	if isSkillTrigger then
		for i, effect in ipairs(triggeredEventNO.effects) do
			local effects = effect.events
			local result = BattleCmdUtil._isStepEndedThenStepAgainTrigger(cmdParser, effects)

			if result ~= -1 then
				return result
			end
		end
	else
		local effects = triggeredEventNO.effects
		local result = BattleCmdUtil._isStepEndedThenStepAgainTrigger(cmdParser, effects)

		if result ~= -1 then
			return result
		end
	end

	return false
end

function BattleCmdUtil._isStepEndedThenStepAgainTrigger(cmdParser, effects)
	for _, eventNO in ipairs(effects) do
		if eventNO:HasField("stateAdded") then
			local currentStepEntityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)

			return eventNO.stateAdded.entity == currentStepEntityId and eventNO.stateAdded.state == BattleEnum.State.STEPPABLE_AGAIN
		end
	end

	return -1
end

function BattleCmdUtil.isEnablePerformance(cmdParser, defaultResult)
	if cmdParser:hasFlag(BattleCmdParser.Flag_In3dPlot) then
		return false
	end

	if cmdParser:hasFlag(BattleCmdParser.Flag_InPlot) then
		return true
	end

	return defaultResult or false
end

function BattleCmdUtil.processEnterForSpecialSkill(cmdParser, entityId, skillId)
	if skillId == 1100221 then
		cmdParser:addCommand(BattleAdjustFollowCenter2Command:create(70007, 70007))
		cmdParser:addCommand(BattleAdjustCameraHeightCommand:create(-12))
		cmdParser:addCommand(BattleCameraLockStatusCommand:create(true))
	end
end

function BattleCmdUtil.processExitForSpecialSkill(cmdParser, entityId, skillId)
	if skillId == 1100221 then
		cmdParser:addCommand(BattleAdjustCameraHeightCommand:create(0))
		cmdParser:addCommand(BattleCameraLockStatusCommand:create(false))
	end
end

return BattleCmdUtil
