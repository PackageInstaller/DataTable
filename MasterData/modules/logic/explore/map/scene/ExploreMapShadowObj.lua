-- chunkname: @modules/logic/explore/map/scene/ExploreMapShadowObj.lua

module("modules.logic.explore.map.scene.ExploreMapShadowObj", package.seeall)

local ExploreMapShadowObj = class("ExploreMapShadowObj", UserDataDispose)
local MeshRenderer = typeof(UnityEngine.MeshRenderer)

function ExploreMapShadowObj:ctor(container)
	self:__onInit()

	self._container = container
	self.isActive = false
	self._go = nil
	self.ishide = true
end

function ExploreMapShadowObj:setData(config)
	self.id = config.id
	self.path = config.path
	self.areaId = config.areaId
	self.pos = config.pos
	self.scale = config.scale
	self.rotation = config.rotation
	self.bounds = Bounds.New(Vector3.New(config.bounds.center[1], config.bounds.center[2], config.bounds.center[3]), Vector3.New(config.bounds.size[1], config.bounds.size[2], config.bounds.size[3]))
end

function ExploreMapShadowObj:show()
	self.isActive = true
	self.ishide = false

	if self._go then
		-- block empty
	else
		self._assetId = ResMgr.getAbAsset(self.path, self._loadedCb, self, self._assetId)
	end

	TaskDispatcher.cancelTask(self.release, self)
end

function ExploreMapShadowObj:markShow()
	self.ishide = false
end

function ExploreMapShadowObj:hide()
	if self._go and self.isActive == true then
		TaskDispatcher.runDelay(self.release, self, ExploreConstValue.CHECK_INTERVAL.MapShadowObjDestory)
	end

	ResMgr.removeCallBack(self._assetId)

	self.isActive = false
	self.ishide = true

	return self.ishide ~= true
end

function ExploreMapShadowObj:_loadedCb(assetMO)
	if self._go == nil and self.isActive then
		self._go = assetMO:getInstance(nil, nil, self._container)

		local trans = self._go.transform

		transformhelper.setPos(trans, self.pos[1], self.pos[2], self.pos[3])
		transformhelper.setLocalScale(trans, self.scale[1], self.scale[2], self.scale[3])
		transformhelper.setLocalRotation(trans, self.rotation[1], self.rotation[2], self.rotation[3])
	end

	gohelper.setActive(self._go, self.isActive)
end

function ExploreMapShadowObj:release()
	self:_clear()
end

function ExploreMapShadowObj:dispose()
	self:_clear()
	self:__onDispose()
end

function ExploreMapShadowObj:_clear()
	TaskDispatcher.cancelTask(self.release, self)
	ResMgr.removeCallBack(self._assetId)
	ResMgr.ReleaseObj(self._go)

	self._go = nil
end

return ExploreMapShadowObj
