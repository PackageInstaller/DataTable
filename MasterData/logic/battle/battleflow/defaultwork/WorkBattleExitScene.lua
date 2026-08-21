-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkBattleExitScene.lua

module("logic.battle.battleflow.defaultwork.WorkBattleExitScene", package.seeall)

local M = class("WorkBattleExitScene", WorkBase)

function M:onEnter(context)
	SceneMgr.instance:exitCurScene()
	self:onDone(WorkResult.Succeed)
end

function M:onExit(isInterrupt)
	CriwareAudioFacade.instance:stopBgm()
end

return M
