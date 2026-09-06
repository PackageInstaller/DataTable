-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonGridElem.lua

module("logicscene.scene.unit.impl.season.UnitSeasonGridElem", package.seeall)

local UnitSeasonGridElem = class("UnitSeasonGridElem", SceneUnitBase)

function UnitSeasonGridElem:getTag()
	return UnitTag.TilingSceneElem
end

function UnitSeasonGridElem:getLayer()
	return SceneLayer.Unit_Value
end

function UnitSeasonGridElem:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
end

function UnitSeasonGridElem:update(deltaTime)
	return
end

function UnitSeasonGridElem:getIconSprite()
	return
end

function UnitSeasonGridElem:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, params.posZ)
	self.transform:setMoveSpeed(0)
end

function UnitSeasonGridElem:getSortingOrderOffset(layerNum)
	local orderOffset = -(self.row % 2 + 2 * self.col)

	return -10000 + (layerNum - 1) * 2000 + orderOffset
end

function UnitSeasonGridElem:onUnitVisible(go)
	UnitSeasonGridElem.super.onUnitVisible(self, go)

	if self._gameObject then
		self._gameObject.transform:SetParent(self.go.transform)
		Framework.TransformUtil.SetLocalPos(self._gameObject.transform, 0, 0, 0)

		local layerNum = self.scene:getLayerNumByElementId(self.id)

		if layerNum > 2 then
			return
		end

		GoUtil.SetSortingOrder(self._gameObject, self:getSortingOrderOffset(layerNum))

		self._gameObject.layer = SceneLayer.InteractiveObject_Value

		local boxCollider = goutil.addComponentOnce(self._gameObject, ComponentType.BoxCollider)

		boxCollider.center = Vector3.New(0, 0, 0)
		boxCollider.size = Vector3.New(1, 1, 1)
	end
end

function UnitSeasonGridElem:onUnitDestroyed()
	self:OnDestroy()
end

return UnitSeasonGridElem
