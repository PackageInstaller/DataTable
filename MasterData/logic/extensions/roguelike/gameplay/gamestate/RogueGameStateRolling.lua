-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateRolling.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateRolling", package.seeall)

local M = class("RogueGameStateRolling", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.ROLLING
	self._workingWork = false
end

function M:onStateEnter(lastState)
	print("ROGUE", "开始滚动骰子")

	local eventType = RogueMgr.instance:getRogueFlow().model:getCurEventType()

	self._eventType = eventType

	if eventType == RoguelikeConst.ROGUE_EVENT_TYPE.SINGLE_EVENT then
		self:createEventWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.MULTI_EVENT then
		self:createEventWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		self:createEventWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.FIGHT_EVENT then
		self:createFightWork()
	elseif eventType == RoguelikeConst.ROGUE_EVENT_TYPE.RECTIFY_EVENT then
		self:createRectifyWork()
	end
end

function M:createRectifyWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkRogueRectifyRoll.New())
	sequence:addChild(WorkInterval.New(0.5 * RogueMgr.instance:getWaitTimeScale()))
	sequence:addChild(WorkRogueExtraMechanism.New())
	work:addChild(sequence)
	work:start(self)
end

function M:createEventWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	if #RogueMgr.instance:getRogueFlow().judgeMgr:getCurRoundCombatDice() == 0 or self._eventType == RoguelikeConst.ROGUE_EVENT_TYPE.ENCOUNTER_EVENT then
		sequence:addChild(WorkRogueEventRoll.New())
		sequence:addChild(WorkInterval.New(0.5 * RogueMgr.instance:getWaitTimeScale()))
	end

	sequence:addChild(WorkRogueRoleRoll.New())
	sequence:addChild(WorkInterval.New(0.5 * RogueMgr.instance:getWaitTimeScale()))
	sequence:addChild(WorkRogueExtraMechanism.New())
	work:addChild(sequence)
	work:start(self)
end

function M:createFightWork()
	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkRogueFeaturesRoll.New())
	sequence:addChild(WorkRogueMonsterRoll.New())
	sequence:addChild(WorkInterval.New(0.5 * RogueMgr.instance:getWaitTimeScale()))
	sequence:addChild(WorkRogueRoleRollAction.New())
	sequence:addChild(WorkRogueRoleRoll.New(true))
	sequence:addChild(WorkInterval.New(0.5 * RogueMgr.instance:getWaitTimeScale()))
	sequence:addChild(WorkRogueExtraMechanism.New())
	work:addChild(sequence)
	work:start(self)
end

function M:_onWorkFinish()
	self._gamePlay:changeState(RoguelikeConst.ROGUE_GAME_STATE.ROLLING_END)
end

function M:onStateExit(newState)
	self:_destroyWork()
end

function M:_createWork()
	self:_destroyWork()

	self._workingWork = WorkFlow.New()

	return self._workingWork
end

function M:_destroyWork()
	if self._workingWork then
		self._workingWork:destroy()

		self._workingWork = false
	end
end

function M:update()
	return
end

function M:onInit()
	return
end

function M:onRelease()
	return
end

return M
