-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateRoleChange.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateRoleChange", package.seeall)

local M = class("RogueGameStateRoleChange", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.ROLE_CHANGE
end

function M:onStateEnter(lastState)
	local nextState = RoguelikeConst.ROGUE_GAME_STATE.BEFORE_JUDGE
	local model = RogueMgr.instance:getRogueFlow().model

	if model:getRoundFinish() then
		nextState = RoguelikeConst.ROGUE_GAME_STATE.RESULT
	elseif model:setNextRoleIndex() == 0 then
		if model:getRoundFinish() then
			nextState = RoguelikeConst.ROGUE_GAME_STATE.RESULT
		else
			model:setFirstActiveRoleIndex()
			GlobalDispatcher:dispatchEvent(EventType.ROGUE_FIRST_ROLE_SWITCH)

			nextState = RoguelikeConst.ROGUE_GAME_STATE.BEFORE_JUDGE

			RogueMgr.instance:getRogueFlow().judgeMgr:clearRoleDiceWall()
		end
	end

	self._gamePlay:changeState(nextState)
end

function M:onStateExit(newState)
	return
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
