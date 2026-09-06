-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/PlayMusicObjPoolMgr.lua

module("logic.extensions.playmusic.view.PlayMusicObjPoolMgr", package.seeall)

local PlayMusicObjPoolMgr = class("PlayMusicObjPoolMgr")

function PlayMusicObjPoolMgr:ctor()
	self._compPools = {}
	self._goPools = {}
end

function PlayMusicObjPoolMgr:clear()
	for _, compPool in pairs(self._compPools) do
		compPool:clear()
	end

	for _, goPool in pairs(self._goPools) do
		goPool:clear()
	end
end

function PlayMusicObjPoolMgr:destroy()
	self._compPools = {}
	self._goPools = {}
end

function PlayMusicObjPoolMgr:fetchSymbolCell(symbolId)
	local cell = self:_fetchSymbolComp(symbolId)
	local go = self:_fetchSymbolGo(symbolId)

	cell:init(go, symbolId)

	return cell
end

function PlayMusicObjPoolMgr:returnSymbolCell(symbolCell)
	local symbolId = symbolCell:getSymbolId()
	local go = symbolCell:getGameObject()
	local symbolData = PlayMusicConfig.instance:getPmSymbolData(symbolId)

	self._compPools[symbolData.compId]:returnObject(symbolCell)
	self._goPools[symbolData.prefabName]:returnObject(go)
end

function PlayMusicObjPoolMgr:_fetchSymbolGo(symbolId)
	local symbolData = PlayMusicConfig.instance:getPmSymbolData(symbolId)
	local prefabName = symbolData.prefabName

	if self._goPools[prefabName] == nil then
		self._goPools[prefabName] = self:_creatGameObjectPool(symbolId)
	end

	return self._goPools[prefabName]:fetchObject()
end

function PlayMusicObjPoolMgr:_fetchSymbolComp(symbolId)
	local symbolData = PlayMusicConfig.instance:getPmSymbolData(symbolId)
	local compId = symbolData.compId

	if self._compPools[compId] == nil then
		self._compPools[compId] = self:_creatCompPool(symbolId)
	end

	return self._compPools[compId]:fetchObject()
end

function PlayMusicObjPoolMgr:_creatGameObjectPool(symbolId)
	local assetPath = PlayMusicModel.instance:getSymbolPrefabPath(symbolId)

	local function createFunc()
		local res = rescache:GetResourceNoLoadIfNotExists(assetPath)

		if not res then
			return
		end

		local mainAsset = res:GetMainAsset()

		if not mainAsset then
			return
		end

		return goutil.clone(mainAsset)
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		return
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function PlayMusicObjPoolMgr:_creatCompPool(symbolId)
	local comp = PlayMusicModel.instance:getSymbolComp(symbolId)

	self._curMaxEntityId = 0
	self._recycleEntityIdList = {}

	local function createFunc()
		local entityId = self._recycleEntityIdList[#self._recycleEntityIdList]

		if entityId == nil then
			self._curMaxEntityId = self._curMaxEntityId + 1
			entityId = self._curMaxEntityId
		else
			self._recycleEntityIdList[#self._recycleEntityIdList] = nil
		end

		return comp.New(entityId)
	end

	local function disposeFunc(comp)
		table.insert(self._recycleEntityIdList, comp:getEntityId())
		comp:dispose()
	end

	local function resetFunc(comp)
		comp:reset()
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

return PlayMusicObjPoolMgr
