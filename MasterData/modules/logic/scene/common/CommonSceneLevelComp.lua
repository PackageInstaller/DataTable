-- chunkname: @modules/logic/scene/common/CommonSceneLevelComp.lua

module("modules.logic.scene.common.CommonSceneLevelComp", package.seeall)

local CommonSceneLevelComp = class("CommonSceneLevelComp", BaseSceneComp)

CommonSceneLevelComp.OnLevelLoaded = 1

local sceneEffectPath = "scenes/common/vx_prefabs/%s.prefab"

function CommonSceneLevelComp:onInit()
	self._sceneId = nil
	self._levelId = nil
	self._isLoadingRes = false
	self._levelId = nil
	self._resPath = nil
	self._assetItem = nil
	self._instGO = nil
end

function CommonSceneLevelComp:getCurLevelId()
	return self._levelId
end

function CommonSceneLevelComp:onSceneStart(sceneId, levelId, failCallback)
	self._sceneId = sceneId
	self._levelId = levelId
	self._failCallback = failCallback

	self:loadLevel(levelId)
end

function CommonSceneLevelComp:onSceneClose()
	if self._isLoadingRes and self._resPath then
		removeAssetLoadCb(self._resPath, self._onLoadCallback, self)

		self._isLoadingRes = nil
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()
	end

	self._levelId = nil
	self._resPath = nil
	self._assetItem = nil
	self._instGO = nil

	self:releaseSceneEffectsLoader()
end

function CommonSceneLevelComp:loadLevel(levelId)
	if self._isLoadingRes then
		logError("is loading scene level res, cur id = " .. (self._levelId or "nil") .. ", try to load id = " .. (levelId or "nil"))

		return
	end

	if self._assetItem then
		gohelper.destroy(self._instGO)
		self._assetItem:Release()

		self._assetItem = nil
		self._instGO = nil

		self:releaseSceneEffectsLoader()
	end

	self._isLoadingRes = true
	self._levelId = self:getLevelId(levelId)

	self:getCurScene():setCurLevelId(self._levelId)

	self._resPath = self:getSceneLevelUrl()

	loadAbAsset(self._resPath, false, self._onLoadCallback, self)
end

function CommonSceneLevelComp:getSceneLevelUrl()
	return ResUrl.getSceneLevelUrl(self._levelId)
end

function CommonSceneLevelComp:getLevelId(levelId)
	return levelId
end

function CommonSceneLevelComp:_onLoadCallback(assetItem)
	self._isLoadingRes = false

	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local sceneGO = self:getCurScene():getSceneContainerGO()

		self._instGO = gohelper.clone(self._assetItem:GetResource(self._resPath), sceneGO)

		self:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, self._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, self._levelId)

		local typeName = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]

		if not self._sceneId then
			local sceneId = -1

			if not self._levelId then
				local levelId = -1

				logNormal(string.format("load scene level finish: %s %d level_%d", typeName, sceneId, levelId))

				local levelConfig = lua_scene_level.configDict[levelId]

				if levelConfig and not string.nilorempty(levelConfig.sceneEffects) then
					self:releaseSceneEffectsLoader()

					local effects = string.split(levelConfig.sceneEffects, "#")

					self._sceneEffectsLoader = MultiAbLoader.New()

					for i, v in ipairs(effects) do
						self._sceneEffectsLoader:addPath(string.format(sceneEffectPath, v))
					end

					self._sceneEffectsObj = {}

					self._sceneEffectsLoader:setOneFinishCallback(self._onSceneEffectsLoaded)
					self._sceneEffectsLoader:startLoad(self._onAllSceneEffectsLoaded, self)
				end
			end
		end
	elseif self._failCallback then
		self:_failCallback()
	else
		logError("load scene level fail, level_" .. ((not self._levelId or nil) and "nil"))
	end
end

function CommonSceneLevelComp:_onSceneEffectsLoaded(loader)
	if not gohelper.isNil(self._instGO) then
		local assetItem = loader:getFirstAssetItem()
		local tarPrefab = assetItem and assetItem:GetResource()

		if tarPrefab then
			table.insert(self._sceneEffectsObj, gohelper.clone(tarPrefab, self._instGO))
		end
	end
end

function CommonSceneLevelComp:_onAllSceneEffectsLoaded()
	return
end

function CommonSceneLevelComp:releaseSceneEffectsLoader()
	if self._sceneEffectsLoader then
		self._sceneEffectsLoader:dispose()

		self._sceneEffectsLoader = nil
	end
end

function CommonSceneLevelComp:getSceneGo()
	return self._instGO
end

return CommonSceneLevelComp
