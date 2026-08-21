-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/performance/skip/SkillSkipPlayer.lua

module("logic.battle.skill.performance.skip.SkillSkipPlayer", package.seeall)

local SkillSkipPlayer = class("SkillSkipPlayer", AbstractGlobalReusable)
local kStrengthenHalf = 0.4

function SkillSkipPlayer:ctor()
	self._timelineTask = TimelineTask.New()
	self._trumpSkip = SkillTrumpSkip.New()
	self._soloInMainScene = SkillSoloInMainScene.New()
	self._handler = Handler.New()
	self._attackInfo = false
end

function SkillSkipPlayer:reset()
	if self._attackInfo then
		self._attackInfo:returnSelf()

		self._attackInfo = false
	end
end

function SkillSkipPlayer:destroy()
	self:reset()
end

function SkillSkipPlayer:bindContext(context)
	self._soloInMainScene:bindContext(context)
end

function SkillSkipPlayer:doAttack(attackInfo, callback, callbackSelf)
	self._attackInfo = SkillAttackInfo:createInstance()

	self._attackInfo:copyFrom(attackInfo)
	self._handler:setListener(callback, callbackSelf)
	self:_loadTrumpSkipPerformance()
	self:_loadMainScenePerformance()
end

function SkillSkipPlayer:doStop()
	self._trumpSkip:stop()
	self._trumpSkip:clear()
	self._soloInMainScene:stop()
	self._soloInMainScene:clear()
	self._timelineTask:clear()
	self._attackInfo:clear()
	self._handler:clear()
end

function SkillSkipPlayer:_loadTrumpSkipPerformance()
	local attackInfo = self._attackInfo
	local attacker = attackInfo:getAttacker()
	local skillMO = attacker.skill:getActiveSkillById(attackInfo:getSkillId())

	if not skillMO:isTrumpSkill() then
		return
	end

	local modelCode = attacker.property:getModelCode()
	local modelCO = ModelConfig.instance:getModelConfig(modelCode)

	if not modelCO or modelCO.specialResForBoss <= 0 then
		return
	end

	self._trumpSkip:loadResource(attackInfo, self._checkResourceLoaded, self)
end

function SkillSkipPlayer:_loadMainScenePerformance()
	local timelineResPath, url = self:_judgeTimelineNameAndUrl()

	self._soloInMainScene:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
	self._soloInMainScene:setTimelineResPath(timelineResPath)
	self._soloInMainScene:loadResource(url, self._checkResourceLoaded, self)
end

function SkillSkipPlayer:_judgeTimelineNameAndUrl()
	local attacker = self._attackInfo:getAttacker()
	local continuousType = self._attackInfo:getContinuousType()
	local timelineNameOrDirectory = self:_judgeSkillTimeResource()

	if continuousType == BattleEnum.SkillContinuousType.MUTI_TIMELINE then
		local continuousCount = self._attackInfo:getContinuousCount()
		local timelineName = SkillPerformanceConfig.instance:getPerformanceTimelineWithSuffix(timelineNameOrDirectory, continuousCount)

		return timelineName, BattleSkillAssist.getNormal3dEffectSkillUrlWithDirectory(timelineNameOrDirectory, timelineName)
	else
		return timelineNameOrDirectory, BattleSkillAssist.getNormal3dEffectSkillUrl(timelineNameOrDirectory)
	end
end

function SkillSkipPlayer:_judgeSkillTimeResource()
	local attacker = self._attackInfo:getAttacker()
	local skillId = self._attackInfo:getSkillId()
	local attackingDirection = self._attackInfo:getAttackingDirection()

	if attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE then
		local performanceTimeline = SkillTagUtils.getChaseTagPerformanceTimeline(attacker.property:getEntityCode(), attacker.property:getModelCode())

		if performanceTimeline then
			return performanceTimeline
		end
	end

	local isMultiSoloPerformance = SkillPerformanceCOUtil.isMultiSoloPerformance(attacker, skillId)

	if isMultiSoloPerformance then
		return SkillPerformanceConfig.instance:getSkillMultiPerformanceTimeline(self._attackInfo:getAnimState(), attacker.property:getModelCode(), 2)
	end

	return SkillPerformanceConfig.instance:getSkillSkipPerformanceTimeline(attacker, skillId)
end

function SkillSkipPlayer:_checkResourceLoaded()
	if self._trumpSkip:isResourceLoaded() and self._soloInMainScene:isResourceLoaded() then
		self:_startCutIn()
	end
end

function SkillSkipPlayer:_startCutIn()
	self._timelineTask:stop()
	self._timelineTask:addFinishListener(self._onCutInFinish, self)
	self._timelineTask:addTask(0)
	self._timelineTask:start()
end

function SkillSkipPlayer:_tTurnOnCutIn()
	SkilStrengthenCutInMgr.instance:turnOnCutIn(true)
end

function SkillSkipPlayer:_turnOffCutIn()
	SkilStrengthenCutInMgr.instance:turnOffCutIn()
end

function SkillSkipPlayer:_onCutInFinish()
	self._trumpSkip:start(self._attackInfo, self._onTrumpSkipPerformanceFinished, self)
end

function SkillSkipPlayer:_onTrumpSkipPerformanceFinished()
	self._soloInMainScene:start(self._attackInfo, self._onMainScenePerformanceFinished, self)
	self:_playPriorityCounterDirection()
end

function SkillSkipPlayer:_onMainScenePerformanceFinished()
	self._handler:callAndClear()
end

function SkillSkipPlayer:_playPriorityCounterDirection()
	local hasPriorityCounter = self._attackInfo:hasPriorityCounter()

	if not hasPriorityCounter then
		return
	end

	local attacker = self._attackInfo:getAttacker()

	BattleAttackSignCommand:executeAttackSignCommand(attacker, BattleEnum.AttackingDirection.ATTACKING_DIRECTION_PRIORITY_COUNTER)
end

return SkillSkipPlayer
