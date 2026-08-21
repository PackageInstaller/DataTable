-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/flow/component/mgr/RogueGamePlayMgr.lua

module("logic.extensions.roguelike.flow.component.mgr.RogueGamePlayMgr", package.seeall)

local M = class("RogueGamePlayMgr", IRogueFlowComp)

function M:onInit()
	self._gamePlay = RogueGamePlay.New()

	self._gamePlay:init()
end

function M:onStart()
	self._gamePlay:changeState(RoguelikeConst.ROGUE_GAME_STATE.INIT)
end

function M:onClear()
	self._gamePlay:release()
end

function M:changeState(state)
	self._gamePlay:changeState(state)
end

function M:getGamePlay()
	return self._gamePlay
end

return M
