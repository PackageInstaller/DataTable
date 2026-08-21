-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/airwork/BattleMessageMgr.lua

module("logic.battle.battleflow.component.airwork.BattleMessageMgr", package.seeall)

local M = class("BattleMessageMgr", IBattleFlowComp)
local kEmptyTable = {}

function M:onInit()
	self._messageOnCheckerBoard = false
	self._entityId2FollowIdDic = false
end

function M:onStart()
	self._boardMgr = self.flow.boardMgr
	self._unitMgr = self.flow.unitMgr
	self._entityId2MessageUnit = {}
	self._entityId2FollowIdDic = {}

	GlobalDispatcher:addEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
	BattleDispatcher:addEventListener(BattleEventType.OnEntityHandleDie, self._onEntityDead, self)
end

function M:onResourceLoaded()
	return
end

function M:addMessageUnit(messageMO, followUnit, unionIndex)
	local unit = BattleMessageUnit:createInstance()

	unit.lifeTime:setAutoDestroy(true)
	unit.lifeTime:setFinishListener(self._onMessageDestroy, self)
	unit.lifeTime:setLifeTime(10)
	unit.uiProxy:setMessage(messageMO)
	unit.loader:load(BattleResourceName.UnitMessage)

	local entityId = AirWorkShopDefSceneUtil.requestUniqueId()

	unit:setEntityId(entityId)

	self._entityId2MessageUnit[entityId] = unit

	self:_followUnitOrPos(unit, followUnit, unionIndex)
end

function M:_followUnitOrPos(unit, followUnit, unionIndex)
	if followUnit then
		self._entityId2FollowIdDic[unit:getEntityId()] = followUnit.property:getEntityId()

		goutil.addChildToParent(unit.mainGO, followUnit.mountRoot:getSignRoot())
	elseif unionIndex then
		local sceneRoot = SceneMgr.instance:getSceneRoot()

		goutil.addChildToParent(unit.mainGO, sceneRoot)

		local wPos = self._boardMgr:getCellPosition(unionIndex)

		TransformUtils.SetPosition(unit.mainGO.transform, wPos.x, wPos.y + 1, wPos.z)
	else
		unit:destroyUnit()
	end
end

function M:_onEntityDead(_, entityId)
	local tempList = BattleTableUtil.getTempList()

	for messageId, heroId in pairs(self._entityId2FollowIdDic) do
		if heroId == entityId then
			local messageUnit = self._entityId2MessageUnit[messageId]
			local sceneRoot = SceneMgr.instance:getSceneRoot()

			goutil.addChildToParent(messageUnit.mainGO, sceneRoot)
			table.insert(tempList, messageId)
		end
	end

	for i, messageId in ipairs(tempList) do
		self._entityId2FollowIdDic[messageId] = nil
	end

	BattleTableUtil.releaseTempList(tempList)
end

function M:_onMessageDestroy(unit)
	local entityId = unit:getEntityId()

	self._entityId2MessageUnit[entityId] = nil
	self._entityId2FollowIdDic[entityId] = nil
end

function M:onClear()
	self:_clearAllMessage()
	BattleDispatcher:removeEventListener(BattleEventType.OnEntityHandleDie, self._onEntityDead, self)
	GlobalDispatcher:removeEventListener(EventType.ON_ENTER_OR_EXIT_BATTLE_VS, self._onEnterOrExitBttleVsScene, self)
end

function M:_clearAllMessage()
	for entityId, unit in pairs(self._entityId2MessageUnit) do
		unit:destroyUnit()
	end

	BattleTableUtil.clearTable(self._entityId2MessageUnit)
	BattleTableUtil.clearTable(self._entityId2FollowIdDic)
end

function M:_onEnterOrExitBttleVsScene(_, isEnter)
	if isEnter then
		self:_clearAllMessage()
	end
end

return M
