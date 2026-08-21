-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/unit/impl/BattlePlotUnit.lua

module("logic.battle.unit.impl.BattlePlotUnit", package.seeall)

local BattlePlotUnit = class("BattlePlotUnit", BattleUnitBase)

function BattlePlotUnit:getTag()
	return UnitTag.Player
end

function BattlePlotUnit:getLayer()
	return SceneLayer.Unit_Value
end

function BattlePlotUnit:_initComponents()
	self:_addComponent("mover", BattleUnitCompMover)
	self:_addComponent("property", BattleUnitCompProperty)
	self:_addComponent("mountRoot", BattleUnitCompMountRoot)
	self:_addComponent("transform", BattleUnitCompTransform)
	self:_addComponent("meshModel", BattleUnitCompMeshModel)
	self:_addComponent("meshModelMover", BattleUnitCompMeshModelMover)
	self:_addComponent("avatarSynchronizer", BattlePlotUnitCompAvatarSynchronizer)
end

function BattlePlotUnit:setProxyVisible(isActive, key)
	if self:isDestroyed() then
		return
	end

	self.uiProxy:setVisible(isActive, false, key)
	self.sceneProxy:setVisible(isActive, key)
end

return BattlePlotUnit
