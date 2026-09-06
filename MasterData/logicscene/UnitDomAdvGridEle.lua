-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/domainadventure/UnitDomAdvGridEle.lua

module("logicscene.scene.unit.impl.domainadventure.UnitDomAdvGridEle", package.seeall)

local UnitDomAdvGridEle = class("UnitDomAdvGridEle", SceneUnitBase)

function UnitDomAdvGridEle:ctor(componetContainer)
	UnitDomAdvGridEle.super.ctor(self, componetContainer)

	self._sortingOrder = -1
end

function UnitDomAdvGridEle:getTag()
	return UnitTag.TilingSceneElem
end

function UnitDomAdvGridEle:getLayer()
	return SceneLayer.Unit_Value
end

function UnitDomAdvGridEle:_initComponents()
	return
end

function UnitDomAdvGridEle:update(deltaTime)
	return
end

function UnitDomAdvGridEle:getIconSprite()
	return
end

function UnitDomAdvGridEle:onUnitCreated(params)
	self._sortingOrder = params.sortingOrder
end

function UnitDomAdvGridEle:onUnitVisible(go)
	UnitDomAdvGridEle.super.onUnitVisible(self, go)

	if goutil.isNil(self._gameObject) then
		return
	end

	self._gameObject.transform:SetParent(self.go.transform)
	Framework.TransformUtil.SetLocalPos(self._gameObject.transform, 0, 0, 0)
	GoUtil.SetSortingOrder(self.go, self._sortingOrder)
end

function UnitDomAdvGridEle:onUnitDestroyed()
	self:OnDestroy()
end

return UnitDomAdvGridEle
