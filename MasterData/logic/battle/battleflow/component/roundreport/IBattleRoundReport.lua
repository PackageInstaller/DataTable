-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/roundreport/IBattleRoundReport.lua

module("logic.battle.battleflow.component.roundreport.IBattleRoundReport", package.seeall)

local IBattleRoundReport = class("IBattleRoundReport")

function IBattleRoundReport:playStartReport(callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playEndReport(callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playRoundStartedReport(round, callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playStageStartedReport(stageId, callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playStageEndedReport(stageId, callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playPlayerStartedReport(campId, callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

function IBattleRoundReport:playPlayerEndedReport(campId, callback, callbackSelf)
	Handler:executeCallback(callback, callbackSelf)
end

return IBattleRoundReport
