-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/gameplay/gamestate/RogueGameStateInit.lua

module("logic.extensions.roguelike.gameplay.gamestate.RogueGameStateInit", package.seeall)

local M = class("RogueGameStateInit", IRogueGameState)

function M:ctor()
	self._gameState = RoguelikeConst.ROGUE_GAME_STATE.Init
end

function M:onStateEnter(lastState)
	print("ROGUE", "进入初始化")
	RogueMgr.instance:getRogueFlow().model:setCurProp()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_MONSTER_COMBAT_BEGIN)
	self._gamePlay:changeState(RoguelikeConst.ROGUE_GAME_STATE.BEFORE_JUDGE)
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
