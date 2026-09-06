-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/treasureraider/UnitTreasureRaiderPlayer.lua

module("logicscene.scene.unit.impl.treasureraider.UnitTreasureRaiderPlayer", package.seeall)

local UnitTreasureRaiderPlayer = class("UnitTreasureRaiderPlayer", SceneUnitBase)

UnitTreasureRaiderPlayer.DefaultPlayerResPath = "scene/tiling/treasure_raider/treasure_raider_player_head.prefab"

function UnitTreasureRaiderPlayer:ctor(componetContainer)
	UnitTreasureRaiderPlayer.super.ctor(self, componetContainer)

	self._lastGridId = nil
end

function UnitTreasureRaiderPlayer:getTag()
	return UnitTag.Player
end

function UnitTreasureRaiderPlayer:getLayer()
	return SceneLayer.Unit_Value
end

function UnitTreasureRaiderPlayer:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("actions", UnitCompActions)
	self:_addComponent("hud", UnitCompHudCommon)
	self:_addComponent("spineMover", UnitCompSpineMoverNone)
	self:_addComponent("spine", UnitCompSpineNone)
	self:_addComponent("head", UnitCompTreasureRaiderHead)
end

function UnitTreasureRaiderPlayer:update(deltaTime)
	self.actions:update(deltaTime)
end

function UnitTreasureRaiderPlayer:setPlayerMo(playerMo)
	self.data = playerMo

	self.head:reloadHeadIcon()
end

function UnitTreasureRaiderPlayer:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, params.posZ)
	self.transform:setMoveSpeed(params.moveSpeed)

	if not params.moveSpeed or params.moveSpeed <= 0 then
		self.transform:setMoveSpeed(1)
	end

	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self:_checkWholeScene()
	self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
end

function UnitTreasureRaiderPlayer:onUnitVisible(go)
	UnitTreasureRaiderPlayer.super.onUnitVisible(self, go)

	if not goutil.isNil(self._gameObject) then
		Framework.TransformUtil.SetLocalRotation(self._gameObject.transform, 0, 0, 0)
	end
end

function UnitTreasureRaiderPlayer:onUnitDestroyed()
	self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.actions:stopAllActions()
	self:OnDestroy()
	self:clearSceneUnit()
end

function UnitTreasureRaiderPlayer:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self:_checkWholeScene()

	if self._wholeScene then
		self._wholeScene:UpdateCommonUnitPosition(UnitTag.Player, self.id, x, y)
	end

	local gridId = self.scene:getTool():pos2Id(x, y)

	self.data:updatePlayerClientPos(gridId)
end

function UnitTreasureRaiderPlayer:_checkWholeScene()
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene
end

function UnitTreasureRaiderPlayer:getUnitName()
	if self.data then
		return self.data.userName
	end
end

function UnitTreasureRaiderPlayer:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitTreasureRaiderPlayer:getUnitHudOffset()
	return 0, 0, 0
end

return UnitTreasureRaiderPlayer
