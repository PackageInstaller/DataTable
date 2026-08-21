-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleLoopAnimSynMgr.lua

module("logic.battle.battleflow.component.BattleLoopAnimSynMgr", package.seeall)

local M = class("BattleLoopAnimSynMgr", IBattleFlowComp)

function M:onInit()
	return
end

function M:onStart()
	self._loopAnimSynPlay = BattleLoopAnimSynPlay.CreateInstance()

	self:_setEvent(true)
end

function M:playAnimSyn(anim, name)
	self._loopAnimSynPlay:PlayAnimSyn(anim, name)
end

function M:stopAnim(anim)
	self._loopAnimSynPlay:RemoveAnim(anim)
end

function M:onClear()
	self._loopAnimSynPlay:Clear()
	self:_setEvent(false)
end

function M:_setEvent(add)
	return
end

return M
