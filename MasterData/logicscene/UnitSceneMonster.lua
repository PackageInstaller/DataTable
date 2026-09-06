-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitSceneMonster.lua

module("logicscene.scene.unit.impl.UnitSceneMonster", package.seeall)

local UnitSceneMonster = class("UnitSceneMonster", SceneUnitBase)

function UnitSceneMonster:getTag()
	return UnitTag.Monster
end

function UnitSceneMonster:getLayer()
	return SceneLayer.Unit_Value
end

function UnitSceneMonster:_initComponents()
	UnitSceneMonster.super._initComponents(self)
	self:_addComponent("spine", UnitCompSpineEx)
	self:_addComponent("spineMover", UnitCompSpineMover)
	self:_addComponent("shadow", UnitCompShadowOther)
end

function UnitSceneMonster:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)

	local mstId = self.monsterId
	local cfgCo = SceneConfig.instance:getMonsterConfigCo(mstId)
	local moveSpeed

	self.transform:setMoveSpeed((cfgCo or nil) and cfgCo.speed or 1)

	self._isMotion = params.motion

	if self._isMotion then
		self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
		self:patrolInZone(self.zoneId)
	end

	if self.scene.monsterMgr then
		self.scene.monsterMgr:addMonsterInsIds(self.monsterId, self.id)
	end

	self.spineMover:playDefaultIdleAnim()

	if self._isMotion then
		self._wholeScene = self.scene.stage.wholeScene

		self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
	end
end

function UnitSceneMonster:onUnitDestroyed()
	if self._isMotion then
		self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	end

	if self.scene.monsterMgr then
		self.scene.monsterMgr:removeMonsterInsIds(self.monsterId, self.id)
	end

	self._wholeScene = nil

	self.actions:stopAllActions()
	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitSceneMonster:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdateMstUnitPosition(self.id, x, y)
	end
end

return UnitSceneMonster
