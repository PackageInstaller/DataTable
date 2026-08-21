-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/skill/tag/impl/SkillTagHandler_MoonRing_Variant.lua

module("logic.battle.skill.tag.impl.SkillTagHandler_MoonRing_Variant", package.seeall)

local M = class("SkillTagHandler_MoonRing_Variant", ISkillTagHandler)
local kSceneRoot = SceneMgr.instance:getSceneRoot()

function M:ctor()
	self._resLoader = MultiResLoader.New()
	self._handler = Handler.New()
	self._currentIndex = 0
	self._finishedCount = 0
	self._timelineTask = TimelineTask.New()
	self._performanceCmdList = {}
end

function M:reset()
	self._resLoader:clear()
	self._handler:clear()
	self._timelineTask:clear()

	self._finishedCount = 0
	self._currentIndex = 0

	BattleTableUtil.clearTable(self._performanceCmdList)
end

function M:destroy()
	self:reset()
end

function M:parseServerEventNO(cmdParser, tagNO)
	local shapeTagNO = tagNO.base.shapeTag
	local baseShapeRange = SkillTagUtils.getShapeRange(shapeTagNO.shape)
	local baseShapeType = SkillTagUtils.getShapeType(shapeTagNO.shape)
	local eventNOList = tagNO.events
	local attackerId = cmdParser:getParam(BattleCmdParser.Param_SkillTriggerAttackerId)
	local continuousIndex = 0

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_modifiedTagTriggered) then
			local resultCollection = BattlePerformanceResultCollection:createInstance()
			local performanceCmd = SkillTagPerformanceCmd:createInstance()

			continuousIndex = continuousIndex + 1

			performanceCmd:setTagIdAndContinuousIndex(self._tagId, continuousIndex)
			performanceCmd:setAttackerId(attackerId)

			local tagWithBase = eventNO.tagWithBase
			local shape = tagWithBase.base and tagWithBase.base.shapeTag and tagWithBase.base.shapeTag.shape
			local shapeType = tagWithBase.base and tagWithBase.base.shapeTag and SkillTagUtils.getShapeType(tagWithBase.base.shapeTag.shape) or baseShapeType
			local shapeRange = tagWithBase.base and tagWithBase.base.shapeTag and SkillTagUtils.getShapeRange(tagWithBase.base.shapeTag.shape) or baseShapeRange

			self:_parseTagWithBaseEvent(performanceCmd, tagWithBase, shapeType, shapeRange)
			performanceCmd:setRange(shapeRange)

			for i, commonEventNO in ipairs(tagWithBase.events) do
				if BattleCmdUtil.hasField(commonEventNO, BattleCmdUtil.cmd_groupEvent) then
					resultCollection:parseEventNO(commonEventNO)
					self:_parseGroupEvent(performanceCmd, commonEventNO, shape)
				else
					if not resultCollection then
						resultCollection = BattlePerformanceResultCollection:createInstance()

						if BattleLog.enableError then
							BattleLog.error("unexpect eventNO")
						end
					end

					resultCollection:parseEventNO(commonEventNO)
				end
			end

			self:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
			table.insert(self._performanceCmdList, performanceCmd)
		elseif BattleLog.enableError then
			BattleLog.error("expected tagWithBase eventNO")
		end
	end
end

function M:_parseTagWithBaseEvent(performanceCmd, tagWithBaseEvent, shapeType, range)
	local attackerId = performanceCmd:getAttackerId()
	local effectUrl, scale = self:_getEffectUrl(shapeType, range, attackerId)

	self._resLoader:addResPath(effectUrl)
	performanceCmd:setEffectScale(scale)
	performanceCmd:setEffectResPath(effectUrl)

	if shapeType == BattleEnum.Shape.Line then
		local rotation = SkillTagUtils.getLineRotation(tagWithBaseEvent.base.shapeTag.shape)

		performanceCmd:setRotationY(rotation)
	end
end

function M:_parseGroupEvent(performanceCmd, groupEvent, shapeNO)
	if self._shapeType == BattleEnum.Shape.MultipleShape then
		for i, centerShapeNO in ipairs(shapeNO.multipleShape.centerShapes) do
			local unionIndex = BoardIndexConverter.cellNOToUnionIndex(centerShapeNO.center)

			performanceCmd:addCenterIndex(unionIndex)
		end
	else
		local groupEventNO = groupEvent[BattleCmdUtil.cmd_groupEvent]
		local unionIndex = BoardIndexConverter.cellNOToUnionIndex(groupEventNO.center)

		performanceCmd:addCenterIndex(unionIndex)
	end
end

function M:_parseResultCollection(performanceCmd, cmdParser, resultCollection)
	if not resultCollection then
		return
	end

	resultCollection:tryMergeDamage()

	local sequenceCommand = SkillTagUtils.createSequenceCommand(cmdParser, resultCollection)

	performanceCmd:setEffectCmd(sequenceCommand)
end

function M:startPerformance(callback, callbackSelf)
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onResLoaded, false, self)
end

function M:stopPerformance(isInterrupt)
	return
end

function M:onCommandFinish(cmd, success)
	self._finishedCount = self._finishedCount + 1

	self:_tryFinishHandler()
end

function M:_onResLoaded()
	self._currentIndex = 1

	self:_executePerformance()
end

function M:_onTimelineFinished()
	self._currentIndex = self._currentIndex + 1

	if self._currentIndex > #self._performanceCmdList then
		return
	end

	self:_executePerformance()
end

function M:_tryFinishHandler()
	if self._finishedCount >= #self._performanceCmdList then
		self._handler:callAndClear()
	end
end

function M:_executePerformance()
	self._timelineTask:clear()
	self._timelineTask:addTask(0, self._performOneTag, self)
	self._timelineTask:addTask(1)
	self._timelineTask:addFinishListener(self._onTimelineFinished, self)
	self._timelineTask:setTimeScale(BattleTime.timeScale)
	self._timelineTask:start()
end

function M:_performOneTag()
	local currentIndex = self._currentIndex
	local cmd = self._performanceCmdList[currentIndex]
	local cmdExecuter = BattleMgr.instance:getCmdExecuter()
	local res = self._resLoader:getResource(cmd:getEffectResPath())
	local goTimeline = res:GetMainAsset()

	goutil.setActive(goTimeline, false)
	cmd:setEffectRes(goutil.clone(goTimeline))
	cmdExecuter:executeCommand(cmd, self)
end

function M:_getEffectUrl(shapeType, range, attackerId)
	local uniqueRes, scale = self:_checkForUniqueModelRes(shapeType, range, attackerId)

	if uniqueRes then
		return uniqueRes, scale
	end

	if range >= 3 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_3"), range / 3
	end

	if range >= 2 then
		return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_2"), 1
	end

	return GameUrl.get3dEffectSceneCommonUrl("biaoqian_zhendang_1"), 1
end

function M:_checkForUniqueModelRes(shapeType, range, attackerId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(attackerId)

	if not attacker then
		return
	end

	local entityCode = attacker.property:getEntityCode()
	local modelCode = attacker.property:getModelCode()

	return SkillTagUtils.getTagResourceUrl(entityCode, modelCode, self._tagId, shapeType, range)
end

return M
