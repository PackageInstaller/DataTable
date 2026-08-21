-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/comp/BattleUnitCompSceneProxy.lua

module("logic.battle.unit.comp.BattleUnitCompSceneProxy", package.seeall)

local M = class("BattleUnitCompSceneProxy", BattleUnitCompBase)

function M:onInit()
	self._invisibleSignAmount = SignalAmount.New()
	self._barProperty = false

	self:onReuse()
end

function M:onReuse()
	self._invisibleSignAmount:clear()

	self._barProperty = BattleUnitPropertyBar:createInstance(self._unit)

	self:setEvent(true)
end

function M:onReset()
	self:_clearBarProperty()
	self:setEvent(false)
end

function M:onDestroy()
	self:_clearBarProperty()
	self:setEvent(false)
end

function M:setEvent(isAdd)
	if isAdd then
		self._unit:addInnerEventListener(UnitActionType.BattleAttributeUpdate, self._onAttributeUpdate, self)
		self._unit:addInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.BattleAttributeUpdate, self._onAttributeUpdate, self)
		self._unit:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._onMeshModelLoaded, self)
	end
end

function M:onUpdateTimeScale(timeScale)
	if self._barProperty then
		self._barProperty:setPlaySpeed(timeScale)
	end
end

function M:setIsInBossView(isInBoss)
	self._isInBossView = isInBoss

	if isInBoss then
		self._barProperty:setBossUIStatus(true)
	end
end

function M:rebuildUI()
	self._barProperty:setUrl(BattleResourceName.BloodBar)
	self._barProperty:updateBaseInfo()
end

function M:forceSync()
	self._barProperty:updateBaseInfo()
end

function M:forecast(forecastEntityInfo)
	self._barProperty:forecast(forecastEntityInfo)
end

function M:clearForecast()
	if self._barProperty then
		self._barProperty:updateBaseInfo()
	end
end

function M:setMask(isMask)
	if self._barProperty then
		self._barProperty:setMask(isMask)
	end
end

function M:_onAttributeUpdate()
	if self._barProperty then
		self._barProperty:onAttributeUpdate()
	end
end

function M:_onMeshModelLoaded()
	self:_updateVisible()
end

function M:_updateVisible()
	local visible = self._invisibleSignAmount:isUnactive()

	if self._barProperty then
		goutil.setActive(self._barProperty.rootGO, visible)
	end
end

function M:setVisible(visible, key)
	self._invisibleSignAmount:setKeyEnable(key, not visible)
	self:_updateVisible()
end

function M:_clearBarProperty()
	if self._barProperty then
		self._barProperty:returnSelf()

		self._barProperty = false
	end
end

return M
