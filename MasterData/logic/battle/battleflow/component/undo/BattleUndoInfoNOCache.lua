-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/undo/BattleUndoInfoNOCache.lua

module("logic.battle.battleflow.component.undo.BattleUndoInfoNOCache", package.seeall)

local BattleUndoInfoNOCache = class("BattleUndoInfoNOCache")

function BattleUndoInfoNOCache:ctor()
	self._activeFieldKey = false
	self._activeRound = false
	self._activeStep = false
	self._battleInfoNOCache = {}
	self._enableCacheFlag = {}
	self._requestingQueue = Queue.create()
end

function BattleUndoInfoNOCache:initialize()
	self:_setEvent(true)
end

function BattleUndoInfoNOCache:clear()
	self:_setEvent(false)

	self._activeFieldKey = false
	self._activeRound = false
	self._activeStep = false

	self._requestingQueue:clear()
	BattleTableUtil.clearTable(self._battleInfoNOCache)
	BattleTableUtil.clearTable(self._enableCacheFlag)
end

function BattleUndoInfoNOCache:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_GET_BACK_INFO, self._onReceiveGetBackInfo, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_GET_BACK_INFO, self._onReceiveGetBackInfo, self)
	end
end

function BattleUndoInfoNOCache:deleteCacheItem(round, step)
	local fieldKey = self:_genBattleFieldKey(round, step)

	self._battleInfoNOCache[fieldKey] = nil
end

function BattleUndoInfoNOCache:getActiveRound()
	return self._activeRound
end

function BattleUndoInfoNOCache:getActiveStep()
	return self._activeStep
end

function BattleUndoInfoNOCache:getBattleInfoNO(round, step, enableCache)
	local fieldKey = self:_genBattleFieldKey(round, step)

	self._activeFieldKey = fieldKey
	self._activeRound = round
	self._activeStep = step

	local battleInfoNO = self._battleInfoNOCache[fieldKey]

	if not battleInfoNO then
		self._enableCacheFlag[fieldKey] = enableCache

		self._requestingQueue:enqueue(fieldKey)
		BattleAgent.instance:sendGetBackInfoRequest(round, step, true)
	end

	return battleInfoNO
end

function BattleUndoInfoNOCache:_onReceiveGetBackInfo(evt, msg)
	local fieldKey = self._requestingQueue:dequeue()

	if not msg then
		if BattleLog.enableError then
			BattleLog.error(string.format("The key[%s] get back info failed", fieldKey))
		end

		return
	end

	local battleInfoNO = msg.info

	if self._enableCacheFlag[fieldKey] then
		self._battleInfoNOCache[fieldKey] = battleInfoNO
	end

	if self._activeFieldKey == fieldKey then
		BattleDispatcher:dispatchEvent(BattleEventType.OnUndoBattlefieldUpdate, battleInfoNO)
	end
end

function BattleUndoInfoNOCache:_genBattleFieldKey(round, entityId)
	return string.format("%s_%s", round, entityId or 0)
end

return BattleUndoInfoNOCache
