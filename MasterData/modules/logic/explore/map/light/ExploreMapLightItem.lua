-- chunkname: @modules/logic/explore/map/light/ExploreMapLightItem.lua

module("modules.logic.explore.map.light.ExploreMapLightItem", package.seeall)

local ExploreMapLightItem = class("ExploreMapLightItem")

ExploreMapLightItem._itemPool = nil

function ExploreMapLightItem.getPool()
	ExploreMapLightItem._itemPool = ExploreMapLightItem._itemPool or LuaObjPool.New(100, ExploreMapLightItem._poolNew, ExploreMapLightItem._poolRelease, ExploreMapLightItem._poolReset)

	return ExploreMapLightItem._itemPool
end

function ExploreMapLightItem._poolNew()
	return ExploreMapLightItem.New()
end

function ExploreMapLightItem._poolRelease(luaObj)
	luaObj:release()
end

function ExploreMapLightItem._poolReset(luaObj)
	luaObj:reset()
end

function ExploreMapLightItem:release()
	if self._cloneGo then
		gohelper.destroy(self._cloneGo)

		self._cloneGo = nil
	end

	self._trans = nil
	self._lightCenter = nil
	self._lightLast = nil
end

function ExploreMapLightItem:reset()
	self._trans:SetParent(nil)
	transformhelper.setLocalScale(self._trans, 0, 0, 0)
end

function ExploreMapLightItem:ctor()
	self._cloneGo = nil
end

function ExploreMapLightItem:init(lightMO, parent, go)
	if not self._cloneGo then
		self._cloneGo = gohelper.clone(go, parent)
		self._trans = self._cloneGo.transform
		self._lightCenter = self._trans:Find("zhong")
		self._lightLast = self._trans:Find("wei")
	else
		self._trans:SetParent(parent.transform)
	end

	self:updateLightMO(lightMO)
end

function ExploreMapLightItem:updateLightMO(lightMO)
	local dir = lightMO.dir
	local scale = lightMO.lightLen

	transformhelper.setLocalPos(self._trans, 0, 1, 0)
	transformhelper.setLocalRotation(self._trans, 0, dir, 0)
	transformhelper.setLocalScale(self._trans, 1, 1, 1)
	transformhelper.setLocalScale(self._lightCenter, 3, 0.2, scale - 0.5)
	transformhelper.setLocalPos(self._lightLast, 0, 0, scale - 0.1)
end

return ExploreMapLightItem
