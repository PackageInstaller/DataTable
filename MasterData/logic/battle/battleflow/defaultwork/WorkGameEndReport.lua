-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkGameEndReport.lua

module("logic.battle.battleflow.defaultwork.WorkGameEndReport", package.seeall)

local WorkGameEndReport = class("WorkGameEndReport", WorkBase)

function WorkGameEndReport:onEnter(context)
	BattleDispatcher:dispatchEvent(BattleEventType.OnCaptureScreenEvent)
	context.viewMgr:clearForExit()
	context.roundReport:playEndReport(self._onFinish, self)
	context.unitOperator:lockOperate()
end

function WorkGameEndReport:onExit(isInterrupt)
	removetimer(self._onFinish, self)
end

function WorkGameEndReport:_onFinish()
	self:onDone(WorkResult.Succeed)
end

return WorkGameEndReport
