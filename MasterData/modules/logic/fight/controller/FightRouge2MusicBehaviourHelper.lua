-- chunkname: @modules/logic/fight/controller/FightRouge2MusicBehaviourHelper.lua

module("modules.logic.fight.controller.FightRouge2MusicBehaviourHelper", package.seeall)

local FightRouge2MusicBehaviourHelper = _M

function FightRouge2MusicBehaviourHelper.checkIsMusicSkill(roundOp)
	local cardData = roundOp and roundOp.cardData
	local skillId = cardData and cardData.skillId
	local musicSkill = skillId and lua_fight_rouge2_music_ball_skill.configDict[skillId]

	return musicSkill ~= nil
end

function FightRouge2MusicBehaviourHelper.hasMusicNote(roundOp)
	local cardData = roundOp and roundOp.cardData
	local musicNote = cardData and cardData.musicNote
	local type = musicNote and musicNote.type

	if not type or type == FightEnum.Rouge2MusicType.None then
		return false
	end

	return true
end

function FightRouge2MusicBehaviourHelper.isRouge2ClothMusicSkill(skillId)
	local co = lua_fight_rouge2_music_ball_skill.configDict[skillId]

	return co ~= nil
end

function FightRouge2MusicBehaviourHelper.addMusicType(musicType, blueValue)
	FightDataHelper.rouge2MusicDataMgr:addMusicType(musicType, blueValue)

	local music = FightDataHelper.rouge2MusicDataMgr:tryPopMusicNote()

	if not music then
		return
	end

	local op = FightRouge2MusicBehaviourHelper.addOperation(music.type)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayRouge2MusicCardFlowDone, op)
end

function FightRouge2MusicBehaviourHelper.addOperation(musicType)
	local op = FightDataHelper.operationDataMgr:newOperation()
	local entityId = FightRouge2MusicBehaviourHelper.getRouge2MusicEntityId()
	local skillId = FightRouge2MusicBehaviourHelper.getSkillId(musicType)

	op:playRouge2MusicSkill(skillId, entityId)

	return op
end

function FightRouge2MusicBehaviourHelper.getRouge2MusicEntityMo()
	return FightDataHelper.entityMgr:getRouge2Music()
end

function FightRouge2MusicBehaviourHelper.getRouge2MusicEntityId()
	local entityMo = FightRouge2MusicBehaviourHelper.getRouge2MusicEntityMo()

	return entityMo and entityMo.id
end

function FightRouge2MusicBehaviourHelper.getSkillId(musicType)
	local teamType = FightEnum.TeamType.MySide
	local teamDataMgr = FightDataHelper.teamDataMgr
	local info = teamDataMgr:getRouge2MusicInfo(teamType)
	local dict = info and info.type2SkillId

	return dict and dict[musicType]
end

local MAX_BEHAVIOUR_COUNT = 3

function FightRouge2MusicBehaviourHelper.runSkill(skillCo)
	if not skillCo then
		logError("FightRouge2MusicBehaviourHelper.runSkill: skillCo is nil")

		return
	end

	FightRouge2MusicBehaviourHelper.initBehaviorHandle()
	FightRouge2MusicBehaviourHelper.initConditionHandle()

	local behaviourIdList = {}

	for i = 1, MAX_BEHAVIOUR_COUNT do
		local conditionStr = skillCo["condition" .. i]
		local pass = true

		if not string.nilorempty(conditionStr) then
			local conditionList = FightStrUtil.instance:getSplitCache(conditionStr, ":")
			local condition = conditionList[1]
			local conditionParam = conditionList[2]
			local func = FightRouge2MusicBehaviourHelper.conditionHandleDict[condition]

			if func then
				pass = func(skillCo, condition, conditionParam)
			else
				logError(string.format("FightRouge2MusicBehaviourHelper.runSkill: behaviour not found"))
			end
		end

		if pass then
			local behaviourStr = skillCo["behavior" .. i]

			if not string.nilorempty(behaviourStr) then
				local behaviourList = FightStrUtil.instance:getSplitCache(behaviourStr, ":")
				local behaviour = behaviourList[1]
				local behaviourParam = behaviourList[2]
				local func = FightRouge2MusicBehaviourHelper.behaviourHandleDict[behaviour]

				if func then
					local behaviourId = func(skillCo, behaviour, behaviourParam)

					if behaviourId then
						table.insert(behaviourIdList, behaviourId)
					end
				else
					logError(string.format("FightRouge2MusicBehaviourHelper.runSkill: behaviour not found", behaviour))
				end
			end
		end
	end

	return behaviourIdList
end

function FightRouge2MusicBehaviourHelper.initConditionHandle()
	if FightRouge2MusicBehaviourHelper.conditionHandleDict then
		return
	end

	FightRouge2MusicBehaviourHelper.conditionHandleDict = {
		Rouge2BallCount = FightRouge2MusicBehaviourHelper.conditionRouge2BallCount
	}
end

function FightRouge2MusicBehaviourHelper.conditionRouge2BallCount(skillCo, condition, conditionParam)
	local paramList = FightStrUtil.instance:getSplitToNumberCache(conditionParam, "#")
	local music = paramList[1]
	local targetCount = paramList[2]
	local curCount = 0
	local musicNoteList = FightDataHelper.rouge2MusicDataMgr:getClientMusicNoteList()

	for _, musicNote in ipairs(musicNoteList) do
		if musicNote.type == music then
			curCount = curCount + 1
		end
	end

	return targetCount <= curCount
end

function FightRouge2MusicBehaviourHelper.initBehaviorHandle()
	if FightRouge2MusicBehaviourHelper.behaviourHandleDict then
		return
	end

	FightRouge2MusicBehaviourHelper.behaviourHandleDict = {
		Rouge2BallOut = FightRouge2MusicBehaviourHelper.behaviourRouge2BallOut,
		Rouge2BallIn = FightRouge2MusicBehaviourHelper.behaviourRouge2BallIn,
		Rouge2BallRecursive = FightRouge2MusicBehaviourHelper.behaviourRouge2BallRecursive
	}
end

local BehaviourType = {
	PopAndPush = 3,
	PopMusic = 2,
	AddOperation = 1
}
local BehaviourList = {}
local BehaviourPool = {}

function FightRouge2MusicBehaviourHelper.generateBehaviourObj(type, param1, param2)
	local behaviour = table.remove(BehaviourPool)

	behaviour = behaviour or {}
	behaviour.type = type
	behaviour.param1 = param1
	behaviour.param2 = param2

	local index = FightRouge2MusicBehaviourHelper.getFirstNilIndex()

	if index then
		BehaviourList[index] = behaviour

		return index
	end

	table.insert(BehaviourList, behaviour)

	return #BehaviourList
end

function FightRouge2MusicBehaviourHelper.getFirstNilIndex()
	for index, obj in ipairs(BehaviourList) do
		if obj == nil then
			return index
		end
	end
end

function FightRouge2MusicBehaviourHelper.recycleBehaviourObj(behaviour)
	table.insert(BehaviourPool, behaviour)
end

function FightRouge2MusicBehaviourHelper.behaviourRouge2BallOut(skillCo, behaviour, behaviourParam)
	local musicNote = FightDataHelper.rouge2MusicDataMgr:popMusicType()

	if not musicNote then
		return
	end

	local paramList = FightStrUtil.instance:getSplitToNumberCache(behaviourParam, "#")

	if paramList then
		if not paramList[1] then
			local addSkillCount = 1

			return (FightRouge2MusicBehaviourHelper.generateBehaviourObj(BehaviourType.AddOperation, musicNote, addSkillCount))
		end
	end
end

function FightRouge2MusicBehaviourHelper.behaviourRouge2BallIn(skillCo, behaviour, behaviourParam)
	local paramList = FightStrUtil.instance:getSplitToNumberCache(behaviourParam, "#")
	local music = paramList and paramList[1]

	if paramList then
		if not paramList[2] then
			local count = 1

			if not music then
				logError("推球参数配置错误：" .. tostring(behaviourParam))

				return
			end

			for _ = 1, count do
				FightDataHelper.rouge2MusicDataMgr:addMusicType(music)
			end

			return (FightRouge2MusicBehaviourHelper.generateBehaviourObj(BehaviourType.PopMusic))
		end
	end
end

function FightRouge2MusicBehaviourHelper.behaviourRouge2BallRecursive(skillCo, behaviour, behaviourParam)
	local musicNote = FightDataHelper.rouge2MusicDataMgr:popMusicType()

	if not musicNote then
		return
	end

	local paramList = FightStrUtil.instance:getSplitToNumberCache(behaviourParam, "#")

	if paramList then
		if not paramList[1] then
			local count = 3

			for _ = 1, count do
				FightDataHelper.rouge2MusicDataMgr:addMusicType(musicNote.type, musicNote.blueValue)
			end

			return (FightRouge2MusicBehaviourHelper.generateBehaviourObj(BehaviourType.PopAndPush, musicNote))
		end
	end
end

function FightRouge2MusicBehaviourHelper.runPopBehaviour(behaviourId)
	local behaviourObj = BehaviourList[behaviourId]

	if not behaviourObj then
		return
	end

	BehaviourList[behaviourId] = nil

	FightRouge2MusicBehaviourHelper.recycleBehaviourObj(behaviourObj)
	FightRouge2MusicBehaviourHelper.initPopBehaviourHandleDict()

	local type = behaviourObj.type
	local handle = FightRouge2MusicBehaviourHelper.popBehaviourHandleDict[type]

	if handle then
		handle(behaviourObj.param1, behaviourObj.param2)
	end
end

function FightRouge2MusicBehaviourHelper.initPopBehaviourHandleDict()
	if FightRouge2MusicBehaviourHelper.popBehaviourHandleDict then
		return
	end

	FightRouge2MusicBehaviourHelper.popBehaviourHandleDict = {
		[BehaviourType.AddOperation] = FightRouge2MusicBehaviourHelper.runAddOperation,
		[BehaviourType.PopMusic] = FightRouge2MusicBehaviourHelper.runPopMusic,
		[BehaviourType.PopAndPush] = FightRouge2MusicBehaviourHelper.runPopAndPush
	}
end

function FightRouge2MusicBehaviourHelper.runAddOperation(musicNote, count)
	for _ = 1, count do
		AudioMgr.instance:trigger(20320603)

		local op = FightRouge2MusicBehaviourHelper.addOperation(musicNote.type)

		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
		FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
		FightController.instance:dispatchEvent(FightEvent.OnPlayRouge2MusicCardFlowDone, op)
	end
end

function FightRouge2MusicBehaviourHelper.runPopMusic()
	while true do
		local musicNote = FightDataHelper.rouge2MusicDataMgr:tryPopMusicNote()

		if not musicNote then
			return
		end

		AudioMgr.instance:trigger(20320603)

		local op = FightRouge2MusicBehaviourHelper.addOperation(musicNote.type)

		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
		FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
		FightController.instance:dispatchEvent(FightEvent.OnPlayRouge2MusicCardFlowDone, op)
	end
end

function FightRouge2MusicBehaviourHelper.runPopAndPush(musicNote)
	AudioMgr.instance:trigger(20320603)

	local op = FightRouge2MusicBehaviourHelper.addOperation(musicNote.type)

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, op)
	FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	FightController.instance:dispatchEvent(FightEvent.RefreshPlayCardRoundOp, op)
	FightController.instance:dispatchEvent(FightEvent.OnPlayRouge2MusicCardFlowDone, op)
	FightRouge2MusicBehaviourHelper.runPopMusic()
end

return FightRouge2MusicBehaviourHelper
