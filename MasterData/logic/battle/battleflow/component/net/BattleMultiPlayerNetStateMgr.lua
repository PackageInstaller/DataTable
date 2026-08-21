-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/net/BattleMultiPlayerNetStateMgr.lua

module("logic.battle.battleflow.component.net.BattleMultiPlayerNetStateMgr", package.seeall)

local BattleMultiPlayerNetStateMgr = class("BattleMultiPlayerNetStateMgr", IBattleFlowComp)
local kLoadingKey = "BattleMultiPlayerNetStateMgr"

function BattleMultiPlayerNetStateMgr:onInit()
	self._userInBattleServerState = {}
	self._allUserReadyTimeStamp = false
end

function BattleMultiPlayerNetStateMgr:onStart()
	self:_setEvent(true)

	self._allUserReadyTimeStamp = false
end

function BattleMultiPlayerNetStateMgr:onClear()
	self:_setEvent(false)

	self._allUserReadyTimeStamp = false

	BattleTableUtil.clearTable(self._userInBattleServerState)
end

function BattleMultiPlayerNetStateMgr:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_ALL_USER_ENTER_DONE, self._onReceiveAllUserEnterDone, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_USER_NET_STATE_CHANGED, self._onReceiveUserNetStateChanged, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBeginCampAdjustment, self._onBeginCampAdjustment, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_ALL_USER_ENTER_DONE, self._onReceiveAllUserEnterDone, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_USER_NET_STATE_CHANGED, self._onReceiveUserNetStateChanged, self)
	end
end

function BattleMultiPlayerNetStateMgr:getAllUserReadyTimeStamp()
	return self._allUserReadyTimeStamp or 0
end

function BattleMultiPlayerNetStateMgr:isUserOnline(userId)
	return self._userInBattleServerState[userId]
end

function BattleMultiPlayerNetStateMgr:_onBeginCampAdjustment()
	if not self._allUserReadyTimeStamp then
		LoadingFacade.instance:showWaiting(kLoadingKey)
		BattleAgent.instance:sendConnectCompleteRequest()
	end
end

function BattleMultiPlayerNetStateMgr:_onReceiveAllUserEnterDone()
	self._allUserReadyTimeStamp = ServerTime.now()

	LoadingFacade.instance:hideWaiting(kLoadingKey)
end

function BattleMultiPlayerNetStateMgr:_onReceiveUserNetStateChanged(evt, msg)
	for _, stateNO in ipairs(msg.state) do
		self:_handleUserStateChanged(stateNO.userId, stateNO.online)
	end
end

function BattleMultiPlayerNetStateMgr:_handleUserStateChanged(userId, isOnline)
	if self._userInBattleServerState[userId] == nil then
		self._userInBattleServerState[userId] = isOnline

		return
	end

	self._userInBattleServerState[userId] = isOnline

	local tips = string.format("玩家【%s】%s", userId, isOnline and "上线" or "离线")

	if BattleLog.enableLog then
		BattleLog.log(tips)
	end
end

return BattleMultiPlayerNetStateMgr
