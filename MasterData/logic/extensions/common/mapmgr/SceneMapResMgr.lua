-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/mapmgr/SceneMapResMgr.lua

module("logic.extensions.common.mapmgr.SceneMapResMgr", package.seeall)

local M = class("SceneMapResMgr", SceneComponentBase)
local sceneLighting = "sceneLighting"

function M:ctor()
	self._loadedResDict = {}
	self._sceneLightDict = {}
	self._waitLoadList = {}
	self._needPreloads = {}
	self._resStateDict = {}
	self._notAutoUnload = {}
	self._maxMapCount = 5
	self._isLoading = false
end

function M:onExitScene()
	if not self._notAutoUnload then
		self:unloadAll()
	else
		for resPath, res in pairs(self._loadedResDict) do
			if not self._notAutoUnload[resPath] then
				self:unload(resPath)
			end
		end

		self._sceneLightDict = {}
		self._needPreloads = {}
		self._waitLoadList = {}
	end
end

function M:setMaxCount(maxCount)
	self._maxMapCount = maxCount
end

function M:load(resPath, needPreload)
	if GameUtils.isEmptyString(resPath) then
		return
	end

	local isPreload = needPreload == nil and true or needPreload

	self._needPreloads[resPath] = isPreload

	local cacheRes = self._loadedResDict[resPath]

	if cacheRes then
		self:_onResLoaded(cacheRes)
	else
		self._waitLoadList = self._waitLoadList or {}

		table.insert(self._waitLoadList, resPath)

		if not self._isLoading then
			self:_tryLoad()
		end
	end
end

function M:_tryLoad()
	self._isLoading = true

	local cacheCount = self:getResCount()

	if cacheCount > self._maxMapCount then
		self:_unloadWithStrategy(cacheCount - self._maxMapCount)
	end

	local resPath = table.remove(self._waitLoadList, 1)

	getres(resPath, self._onResLoaded, self, ResType.AssetBunble)
end

function M:loadById(mapId, needPreload)
	local resPath = GameUrl.getMapUrlById(mapId)

	self:load(resPath, needPreload)
end

function M:loadByIds(mapIds, needPreloads)
	if not mapIds or #mapIds <= 0 then
		return
	end

	needPreloads = needPreloads or {}

	for i = 1, #mapIds do
		self:loadById(mapIds[i], needPreloads[i])
	end
end

function M:unload(resPath)
	if not resPath then
		return
	end

	local index = table.indexof(self._waitLoadList, resPath)

	if index then
		removeresl(resPath, self._onResLoaded, self)
	end

	if self._loadedResDict[resPath] then
		self._loadedResDict[resPath]:Release()

		self._loadedResDict[resPath] = nil
	end

	self._sceneLightDict[resPath] = nil
end

function M:unloadById(mapId)
	if not mapId then
		return
	end

	local resPath = GameUrl.getMapUrlById(mapId)

	self:unload(resPath)
end

function M:unloadByIds(mapIds)
	if not mapIds or #mapIds <= 0 then
		return
	end

	for i = 1, #mapIds do
		self:unloadById(mapIds[i])
	end
end

function M:unloadAll()
	for _, res in pairs(self._loadedResDict) do
		if res then
			res:Release()
		end
	end

	if #self._waitLoadList > 0 then
		for i = 1, #self._waitLoadList do
			removeresl(self._waitLoadList[i], self._onResLoaded, self)
		end
	end

	self._needPreloads = {}
	self._waitLoadList = {}
	self._loadedResDict = {}
	self._sceneLightDict = {}
end

function M:getRes(resPath)
	return self._loadedResDict[resPath]
end

function M:getResById(mapId)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	return self._loadedResDict[resPath]
end

function M:getInst(resPath)
	local res = self._loadedResDict[resPath]

	if res then
		return res:GetScene()
	end
end

function M:getInstById(mapId)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	return self:getInst(resPath)
end

function M:getSceneLight(resPath)
	return self._sceneLightDict[resPath]
end

function M:getSceneLightById(mapId)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	return self:getSceneLight(resPath)
end

function M:getAllRes(resPath)
	return self._loadedResDict
end

function M:getResCount()
	local count = 0

	for _, res in pairs(self._loadedResDict) do
		if res then
			count = count + 1
		end
	end

	return count
end

function M:setNotAutoUnload(resPath, isNotAutoUnload)
	self._notAutoUnload[resPath] = isNotAutoUnload
end

function M:setNotAutoUnloadById(mapId, isNotAutoUnload)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	self:setNotAutoUnload(resPath, isNotAutoUnload)
end

function M:setActiveScene(resPath)
	local sceneInst = self:getInst(resPath)

	if sceneInst and sceneInst:IsValid() then
		self:_setSceneObjsActive(resPath, sceneInst, true)
		SceneUtils.SetActiveScene(sceneInst.name)
	end
end

function M:setActiveSceneById(mapId)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	local sceneInst = self:getInst(resPath)

	if sceneInst and sceneInst:IsValid() then
		self:_setSceneObjsActive(resPath, sceneInst, true)
		SceneUtils.SetActiveScene(sceneInst.name)
	end
end

function M:setSceneObjsActive(resPath, isActive)
	local sceneInst = self:getInst(resPath)

	if sceneInst and sceneInst:IsValid() then
		self:_setSceneObjsActive(resPath, sceneInst, isActive)
	end
end

function M:setSceneObjsActiveById(mapId, isActive)
	local resPath = GameUrl.getMapUrlById(mapId)

	if not resPath then
		return
	end

	local sceneInst = self:getInst(resPath)

	if sceneInst and sceneInst:IsValid() then
		self:_setSceneObjsActive(resPath, sceneInst, isActive)
	end
end

function M:_onResLoaded(res)
	if res.IsSuccess then
		local resPath = res.ResPath

		if not self._loadedResDict[resPath] then
			res:Retain()

			self._loadedResDict[resPath] = res
		end

		local active = not self._needPreloads[resPath]

		self:setSceneObjsActive(resPath, active)

		self._resStateDict[resPath] = {
			time = ServerTime.now(),
			isUsing = active
		}
	end

	SceneMgrDispatcher:dispatchEvent(SceneNotify.OnOneMapLoaded, res)

	if #self._waitLoadList >= 1 then
		self:_tryLoad()
	else
		self._isLoading = false
		self._waitLoadList = {}

		SceneMgrDispatcher:dispatchEvent(SceneNotify.OnAllMapLoaded)
	end
end

function M:_unloadWithStrategy(count)
	local _unloadList = {}

	for resPath, tb in pairs(self._resStateDict) do
		if tb and not tb.isUsing then
			table.insert(_unloadList, tb)
		end
	end

	table.sort(_unloadList, function(a, b)
		return a.time < b.time
	end)

	for i = 1, count do
		local unload = _unloadList[i]

		if unload and not GameUtils.isEmptyString(unload.resPath) then
			self:unload(unload.resPath)

			self._resStateDict[unload.resPath] = nil
		end
	end
end

function M:_setSceneObjsActive(resPath, sceneInst, isActive)
	local rootObjs = sceneInst:GetRootGameObjects()

	for i = 1, sceneInst.rootCount do
		local rootGo = rootObjs:GetValue(i - 1)

		if not self._sceneLightDict[resPath] and rootGo.name == sceneLighting then
			self._sceneLightDict[resPath] = rootGo
		end

		if rootGo.activeSelf ~= isActive then
			goutil.setActive(rootGo, isActive)
		end
	end

	self._resStateDict[resPath] = {
		time = ServerTime.now(),
		isUsing = isActive
	}
end

M.instance = M.New()

return M
