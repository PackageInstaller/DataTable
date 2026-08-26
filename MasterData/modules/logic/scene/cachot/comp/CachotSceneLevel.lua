-- chunkname: @modules/logic/scene/cachot/comp/CachotSceneLevel.lua

module("modules.logic.scene.cachot.comp.CachotSceneLevel", package.seeall)

local CachotSceneLevel = class("CachotSceneLevel", CommonSceneLevelComp)

function CachotSceneLevel:onSceneStart(sceneId, levelId)
	self._eventTrs = {}

	CachotSceneLevel.super.onSceneStart(self, sceneId, levelId)
end

function CachotSceneLevel:switchLevel(levelId)
	if levelId == self._levelId then
		if not self._isLoadingRes then
			self:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, self._levelId)
			GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, self._levelId)
		end

		return
	end

	if self._isLoadingRes then
		self._levelId = nil
		self._isLoadingRes = nil

		removeAssetLoadCb(self._resPath, self._onLoadCallback, self)
	end

	self._eventTrs = {}

	self:loadLevel(levelId)
end

function CachotSceneLevel:_onLoadCallback(assetItem)
	self._isLoadingRes = false

	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		local sceneGO = self:getCurScene():getSceneContainerGO()

		self._instGO = gohelper.clone(self._assetItem:GetResource(self._resPath), sceneGO, "CachotLevel")

		local sceneGo = self._instGO

		for i = 1, 3 do
			local go = gohelper.findChild(sceneGo, "Obj-Plant/event/" .. i)

			if not go then
				go = gohelper.create3d(gohelper.findChild(sceneGo, "Obj-Plant"), tostring(i))

				if i == 1 then
					go.transform.localPosition = Vector3.New(28, -7, 1)
				elseif i == 2 then
					go.transform.localPosition = Vector3.New(32, -7, 1)
				elseif i == 3 then
					go.transform.localPosition = Vector3.New(36, -7, 1)
				end
			end

			self._eventTrs[i] = go.transform
		end

		self:dispatchEvent(CommonSceneLevelComp.OnLevelLoaded, self._levelId)
		GameSceneMgr.instance:dispatchEvent(SceneEventName.OnLevelLoaded, self._levelId)

		local typeName = SceneType.NameDict[GameSceneMgr.instance:getCurSceneType()]

		if not self._sceneId then
			if not self._levelId then
				local levelId = -1

				logNormal(string.format("load scene level finish: %s %d level_%d", typeName, self._sceneId, levelId))
			end
		end
	else
		logError("load scene level fail, level_" .. ((not self._levelId or nil) and "nil"))
	end
end

function CachotSceneLevel:getEventTr(index)
	return self._eventTrs[index]
end

function CachotSceneLevel:onSceneClose()
	self._eventTrs = {}

	CachotSceneLevel.super.onSceneClose(self)
end

return CachotSceneLevel
