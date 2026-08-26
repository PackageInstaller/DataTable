-- chunkname: @modules/logic/explore/map/scene/ExploreMapSceneObj.lua

module("modules.logic.explore.map.scene.ExploreMapSceneObj", package.seeall)

local ExploreMapSceneObj = class("ExploreMapSceneObj", UserDataDispose)
local MeshRenderer = typeof(UnityEngine.MeshRenderer)

function ExploreMapSceneObj:ctor(container)
	self:__onInit()

	self._container = container
	self.isActive = false
	self._go = nil
	self.ishide = true
end

function ExploreMapSceneObj:setData(config)
	self.id = config.id
	self.path = config.path
	self.pos = config.pos
	self.scale = config.scale
	self.rotation = config.rotation
	self.rendererInfos = config.rendererInfos
	self.useLightMapIndexList = {}
	self.effectType = config.effectType
	self.areaId = config.areaId
	self.overridderLayer = config.overridderLayer or -1
	self._destoryInterval = ExploreConstValue.MapSceneObjDestoryInterval[config.effectType] or ExploreConstValue.CHECK_INTERVAL.MapSceneObjDestory

	for i, v in ipairs(self.rendererInfos) do
		if tabletool.indexOf(self.useLightMapIndexList, v.lightmapIndex) == nil then
			table.insert(self.useLightMapIndexList, v.lightmapIndex)
		end
	end
end

function ExploreMapSceneObj:show()
	self.isActive = true

	if self._go then
		-- block empty
	else
		self._assetId = ResMgr.getAbAsset(self.path, self._loadedCb, self, self._assetId)
	end

	return self._go == nil
end

function ExploreMapSceneObj:markShow()
	self.ishide = false

	TaskDispatcher.cancelTask(self.release, self)
end

function ExploreMapSceneObj:hide()
	if self._go and self.isActive == true then
		TaskDispatcher.runDelay(self.release, self, self._destoryInterval)
	end

	ResMgr.removeCallBack(self._assetId)

	self.isActive = false
	self.ishide = true

	return self.ishide ~= true
end

function ExploreMapSceneObj:unloadnow()
	if self._go and self.ishide == true then
		self:release()
	end
end

local clipLayer = UnityLayer.SceneOpaqueOcclusionClip

function ExploreMapSceneObj:_loadedCb(assetMO)
	if self._go == nil and self.isActive and assetMO.IsLoadSuccess then
		self._go = assetMO:getInstance(nil, nil, self._container)

		local trans = self._go.transform

		transformhelper.setPos(trans, self.pos[1], self.pos[2], self.pos[3])
		transformhelper.setLocalScale(trans, self.scale[1], self.scale[2], self.scale[3])
		transformhelper.setLocalRotation(trans, self.rotation[1], self.rotation[2], self.rotation[3])

		if self.overridderLayer ~= -1 then
			gohelper.setLayer(self._go, self.overridderLayer, false)

			local needClip = self.overridderLayer == clipLayer
			local colliderList = self._go:GetComponentsInChildren(typeof(UnityEngine.Collider))

			for i = 0, colliderList.Length - 1 do
				colliderList[i].enabled = needClip
			end
		end

		local renderers = self._go:GetComponentsInChildren(MeshRenderer, true)

		for i = 0, renderers.Length - 1 do
			local renderer = renderers[i]
			local info = self.rendererInfos[i + 1]

			if info then
				renderer.lightmapIndex = info.lightmapIndex
				renderer.lightmapScaleOffset = Vector4.New(info.lightmapOffsetScale[1], info.lightmapOffsetScale[2], info.lightmapOffsetScale[3], info.lightmapOffsetScale[4])
			end
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.SceneObjLoadedCb)
	gohelper.setActive(self._go, self.isActive)
end

function ExploreMapSceneObj:release()
	self:_clear()
end

function ExploreMapSceneObj:dispose()
	self:_clear()
	self:__onDispose()
end

function ExploreMapSceneObj:_clear()
	TaskDispatcher.cancelTask(self.release, self)
	ResMgr.removeCallBack(self._assetId)
	ResMgr.ReleaseObj(self._go)

	self._go = nil
end

return ExploreMapSceneObj
