-- chunkname: @modules/logic/explore/map/light/ExploreMapLightPool.lua

module("modules.logic.explore.map.light.ExploreMapLightPool", package.seeall)

local ExploreMapLightPool = class("ExploreMapLightPool")

function ExploreMapLightPool:getInst(lightMO, parent)
	self._pool = self._pool or ExploreMapLightItem.getPool()
	self._lightGo = self._lightGo or self:getLightGo()

	local lightItem = self._pool:getObject()

	lightItem:init(lightMO, parent, self._lightGo)

	return lightItem
end

function ExploreMapLightPool:getLightGo()
	local sceneType = GameSceneMgr.instance:getCurSceneType()

	if sceneType ~= SceneType.Explore then
		return
	end

	local scene = GameSceneMgr.instance:getCurScene()

	return scene.preloader:getResByPath(ResUrl.getExploreEffectPath(ExploreConstValue.MapLightEffect))
end

function ExploreMapLightPool:inPool(lightItem)
	if not self._pool then
		lightItem:release()

		return
	end

	self._pool:putObject(lightItem)
end

function ExploreMapLightPool:clear()
	if self._pool then
		self._pool:dispose()

		self._pool = nil
	end

	self._lightGo = nil
end

ExploreMapLightPool.instance = ExploreMapLightPool.New()

return ExploreMapLightPool
