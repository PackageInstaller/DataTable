-- chunkname: @modules/logic/scene/cachot/comp/CachotScenePreloader.lua

module("modules.logic.scene.cachot.comp.CachotScenePreloader", package.seeall)

local CachotScenePreloader = class("CachotScenePreloader", BaseSceneComp)

CachotScenePreloader.DoorEffectPath = "effects/prefabs_cachot/v1a6_dilao_men.prefab"
CachotScenePreloader.LightPath = "scenes/v1a6_m_s16_dilao_zjm/v1a6_m_s16_scene_light.prefab"
CachotScenePreloader.EventItem = "ui/viewres/versionactivity_1_6/v1a6_cachot/v1a6_cachot_roomeventitem.prefab"
CachotScenePreloader.RoleTransEffect = "effects/prefabs_cachot/v1a6_dilao_chuansong.prefab"
CachotScenePreloader.RoleBornEffect = "effects/prefabs_cachot/v1a6_fangjianchusheng.prefab"

function CachotScenePreloader:init(sceneId, levelId)
	if not self._abLoader then
		self._abLoader = MultiAbLoader.New()

		self:_addLightAsset(self._abLoader)
		self:_addMainSceneEffect(self._abLoader)
		self:_addRoomSceneAsset(self._abLoader)
		self._abLoader:startLoad(self._onLoadedFinish, self)
	end
end

function CachotScenePreloader:onSceneStart(sceneId, levelId)
	return
end

function CachotScenePreloader:_addMainSceneEffect(loader)
	loader:addPath(CachotScenePreloader.DoorEffectPath)
	loader:addPath(CachotScenePreloader.RoleTransEffect)
	loader:addPath(CachotScenePreloader.RoleBornEffect)
end

function CachotScenePreloader:_addRoomSceneAsset(loader)
	loader:addPath(CachotScenePreloader.EventItem)
end

function CachotScenePreloader:_addLightAsset(loader)
	loader:addPath(CachotScenePreloader.LightPath)
end

function CachotScenePreloader:_onLoadedFinish()
	self:dispatchEvent(V1a6_CachotEvent.ScenePreloaded)
end

function CachotScenePreloader:getResByPath(path)
	local assetItem = self._abLoader:getAssetItem(path)

	if not assetItem or not assetItem.IsLoadSuccess then
		logError("资源加载失败 。。。 " .. path)

		return
	end

	return assetItem:GetResource()
end

function CachotScenePreloader:getResInst(path, parent, name)
	local res = self:getResByPath(path)

	if res then
		return gohelper.clone(res, parent, name)
	end
end

function CachotScenePreloader:onSceneClose()
	if self._abLoader then
		self._abLoader:dispose()

		self._abLoader = nil
	end
end

return CachotScenePreloader
