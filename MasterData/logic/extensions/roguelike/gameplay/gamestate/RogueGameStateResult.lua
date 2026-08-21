-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateResult.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateResult", package.seeall)

local M = class("RogueGameStateResult", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.RESULT
end

function M:onStateEnter(lastState)
	local diceMgr = RogueMgr.instance:getRogueFlow().diceMgr
	local judgeMgr = RogueMgr.instance:getRogueFlow().judgeMgr
	local combatDices = judgeMgr:getCurRoundCombatDice()
	local playerDices = judgeMgr:getCurRoundPlayerDice()

	for k, v in pairs(combatDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end

	for k, v in pairs(playerDices) do
		diceMgr:recoveryDiceObj(v:getGo())
	end

	RogueMgr.instance:getRogueFlow().shieldMgr:clear()
	RogueMgr.instance:getModel():setEventChangeDifficulty(0)

	local work = self:_createWork()

	work:setDoneCaller(self._onWorkFinish, self)

	local sequence = FlowSequence.New()

	sequence:addChild(WorkRogueShowResult.New())
	work:addChild(sequence)
	work:start(self)
end

function M:_onWorkFinish()
	local isWin = RogueMgr.instance:getModel():getJudgeResult()

	print("ROGUE", "显示结果", isWin and "胜利" or "失败")
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_RESULT_FINISH, isWin)

	if RogueMgr.instance:getHackToolModel() then
		local msg = string.format(RoguelikeConfig.getBroadCast("Challenge_Result"), isWin and "胜利" or "失败")

		GlobalDispatcher:dispatchEvent(EventType.ROGUE_ROUND_BROAD_CAST, msg)
	end
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

function M:onStateExit(newState)
	self:_destroyWork()
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
