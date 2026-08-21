-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/clientpreview/ClientPreviewBattleNetAgent.lua

module("logic.battle.clientpreview.ClientPreviewBattleNetAgent", package.seeall)

local ClientPreviewBattleNetAgent = class("ClientPreviewBattleNetAgent")

function ClientPreviewBattleNetAgent:sendEndReadyRequest()
	BattleMgr.instance:getServerSimulation():simulateReady()
	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_END_READY, true)
end

function ClientPreviewBattleNetAgent:sendPlaceEntityRequest(entityCode, unionIndex)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate, false)
end

function ClientPreviewBattleNetAgent:sendRemoveEntityRequest(entityId)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate, true)
end

function ClientPreviewBattleNetAgent:sendMoveEntityRequest(entityId, unionIndex)
	BattleDispatcher:dispatchEvent(BattleEventType.Adjustment_OnAvailableHeroListUpdate, true)
end

function ClientPreviewBattleNetAgent:sendPostEventAnimationRequest()
	if enableLog then
		printInfo("ClientPreviewBattleNetAgent::sendPostEventAnimationRequest")
	end

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_NEXT_OPERATE)
end

function ClientPreviewBattleNetAgent:sendStepRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex)
	if enableLog then
		printInfo("ClientPreviewBattleNetAgent::sendStepRequest", entityId)
	end

	BattleMgr.instance:getServerSimulation():simulateStepRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex)
end

function ClientPreviewBattleNetAgent:sendEndStageRequest()
	if enableLog then
		printInfo("ClientPreviewBattleNetAgent::sendEndStageRequest")
	end

	BattleMgr.instance:getServerSimulation():simulateEndStage()
end

function ClientPreviewBattleNetAgent:sendSurrenderRequest()
	if enableLog then
		printInfo("ClientPreviewBattleNetAgent::sendSurrenderRequest")
	end

	local model = BattleMgr.instance:getModel()
	local resultMO = model:getResultMO()

	resultMO:setSurrender(true)
	BattleMgr.instance:exit()
end

local kEvents = {}

function ClientPreviewBattleNetAgent:pushEventNO(msg)
	kEvents[1] = msg

	BattleDispatcher:dispatchEvent(BattleEventType.ON_RECEIVE_NET_EVENT, kEvents)
end

ClientPreviewBattleNetAgent.instance = ClientPreviewBattleNetAgent.New()

return ClientPreviewBattleNetAgent
