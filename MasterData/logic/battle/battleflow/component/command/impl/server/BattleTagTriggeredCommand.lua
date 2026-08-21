-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleTagTriggeredCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleTagTriggeredCommand", package.seeall)

local BattleTagTriggeredCommand = class("BattleTagTriggeredCommand", BattleCommandBase)

function BattleTagTriggeredCommand:parseServerCommand(cmdParser, tagNO)
	local tagId = tagNO.base.tagId
	local isVariant = tagNO.base.variant
	local tagHandler = SkillTagPerformanceMgr.instance:createHandler(tagId, isVariant)

	if tagHandler then
		tagHandler:parseServerEventNO(cmdParser, tagNO)

		local cmd = BattleTagTriggeredCommand:createInstance()

		cmd:setTagId(tagId)
		cmd:setTagHandler(tagHandler)
		cmdParser:addCommand(cmd)
		cmdParser:addCommand(BattleTagTriggerEndedCommand:createInstance())
	end
end

function BattleTagTriggeredCommand:onInit()
	self._tagId = false
	self._tagHandler = false
end

function BattleTagTriggeredCommand:onClear(interrupt)
	if self._tagHandler then
		self._tagHandler:stopPerformance(interrupt)
		SkillTagPerformanceMgr.instance:destroyHandler(self._tagHandler)
	end

	self._tagId = false
	self._tagHandler = false
end

function BattleTagTriggeredCommand:execute(battleFlow, runningContext)
	runningContext:setParam(BattleCmdRunningContext.Param_TagId, self._tagId)
	BattleDamageHintFacade.instance:setVisible(false)
	self._tagHandler:startPerformance(self._onPerformanceFinished, self)
end

function BattleTagTriggeredCommand:_onPerformanceFinished()
	BattleSideHintViewFacade.instance:hideTagHint()
	BattleDamageHintFacade.instance:setVisible(false)
	self:finish(true)
end

function BattleTagTriggeredCommand:toString()
	return string.format("[battle tag triggered tagId = %s]", self._tagId)
end

function BattleTagTriggeredCommand:setTagId(tagId)
	self._tagId = tagId

	return self
end

function BattleTagTriggeredCommand:setTagHandler(tagHandler)
	self._tagHandler = tagHandler

	return self
end

return BattleTagTriggeredCommand
