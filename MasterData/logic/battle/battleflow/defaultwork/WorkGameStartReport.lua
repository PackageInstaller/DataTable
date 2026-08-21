-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/WorkGameStartReport.lua

module("logic.battle.battleflow.defaultwork.WorkGameStartReport", package.seeall)

local WorkGameStartReport = class("WorkGameStartReport", WorkBase)

function WorkGameStartReport:onEnter(context)
	BattleDispatcher:dispatchEvent(BattleEventType.OnCaptureScreenEvent)
	context.roundReport:playStartReport(self._onFinish, self)
end

function WorkGameStartReport:onExit(isInterrupt)
	removetimer(self._onFinish, self)
end

function WorkGameStartReport:_onFinish()
	self:onDone(WorkResult.Succeed)
end

return WorkGameStartReport
