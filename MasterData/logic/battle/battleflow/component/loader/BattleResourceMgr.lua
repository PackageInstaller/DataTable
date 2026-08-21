-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/loader/BattleResourceMgr.lua

module("logic.battle.battleflow.component.loader.BattleResourceMgr", package.seeall)

local BattleResourceMgr = class("BattleResourceMgr", IBattleFlowComp)
local kResourcePathList = {}

BattleResourceMgr._cacheResources = {}

function BattleResourceMgr:onInit()
	self._resLoader = MultiResLoader.New()
	self._handler = Handler.New()
end

function BattleResourceMgr:onStart()
	VirtualCameraMgr.instance:createTemporaryCamera(BattleConst.START_CAMERA_CODE)
	VirtualCameraMgr.instance:createTemporaryCamera(BattleConst.ATTACK_CAMERA_CODE)
	VirtualCameraMgr.instance:createTemporaryCamera(BattleConst.ATTACK_RIGHT_CAMERA_CODE)
	VirtualCameraMgr.instance:setTemporaryCameraActive(BattleConst.ATTACK_CAMERA_CODE, false)
	VirtualCameraMgr.instance:setTemporaryCameraActive(BattleConst.ATTACK_RIGHT_CAMERA_CODE, false)

	self._boardModel = self.flow.boardModel
end

function BattleResourceMgr:onPreClear(isRestart)
	self._resLoader:clear()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Battle)
	VirtualCameraMgr.instance:releaseTemporaryCamera(BattleConst.START_CAMERA_CODE)
	VirtualCameraMgr.instance:releaseTemporaryCamera(BattleConst.ATTACK_CAMERA_CODE)
	VirtualCameraMgr.instance:releaseTemporaryCamera(BattleConst.ATTACK_RIGHT_CAMERA_CODE)
end

function BattleResourceMgr:onClear(isRestart)
	self._boardModel = false

	self._handler:clear()
	SpriteAtlasMgr.instance:dump()
end

function BattleResourceMgr:addResourcePathList(resPathList)
	for _, respath in ipairs(resPathList) do
		self._resLoader:addResPath(respath)
	end
end

function BattleResourceMgr:load(callback, callbackSelf)
	self._resLoader:clear()
	self:_collectResource()
	self._handler:setListener(callback, callbackSelf)
	self._resLoader:load(self._onAllLoaded, false, self)
end

function BattleResourceMgr:getAllResourcePath()
	return self._resLoader._resPaths
end

function BattleResourceMgr:getResource(resPath)
	return self._resLoader:getResource(resPath)
end

function BattleResourceMgr:getMainAsset(resPath)
	local res = self._resLoader:getResource(resPath)

	return res and res:GetMainAsset() or false
end

function BattleResourceMgr:getPrefab(resPath)
	local res = self._resLoader:getResource(resPath)

	return res and res:GetMainAsset() or false
end

function BattleResourceMgr:getInst(resPath)
	local prefab = self:getPrefab(resPath)

	return prefab and goutil.clone(prefab) or false
end

function BattleResourceMgr:removeListener()
	self._handler:clear()
end

function BattleResourceMgr:cacheResources()
	self:clearCacheResources()

	local resourceTable = self._resLoader:getResources()

	for _, resource in pairs(resourceTable) do
		resource:Retain()
		table.insert(self._cacheResources, resource)
	end
end

function BattleResourceMgr:clearCacheResources()
	if #self._cacheResources > 0 then
		for _, resource in pairs(self._cacheResources) do
			resource:Release()
		end

		BattleTableUtil.clearTable(self._cacheResources)
	end
end

function BattleResourceMgr:_onAllLoaded()
	self:clearCacheResources()

	if not self._resLoader:isAllSuccess() then
		if enableErrorLog then
			printError("load resource failed!")
		end

		self._handler:call(false)

		return
	end

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Battle)
	self._handler:call(true)
end

function BattleResourceMgr:_collectResource()
	for _, respath in pairs(BattleResourceName.basic) do
		self._resLoader:addResPath(respath)
	end

	self:_collectCameraResource()
	self:_collectExtensionViewResource()
	self.flow:fillResourcePathList(kResourcePathList)
	self:addResourcePathList(kResourcePathList)
	BattleTableUtil.clearTable(kResourcePathList)
end

function BattleResourceMgr:_collectCameraResource()
	self._resLoader:addResPath(VirtualCameraMgr.instance:getCameraUrl(BattleConst.START_CAMERA_CODE))
	self._resLoader:addResPath(VirtualCameraMgr.instance:getCameraUrl(BattleConst.ATTACK_CAMERA_CODE))
	self._resLoader:addResPath(VirtualCameraMgr.instance:getCameraUrl(BattleConst.ATTACK_RIGHT_CAMERA_CODE))
end

function BattleResourceMgr:_collectExtensionViewResource()
	local settingModel = self.flow.settingModel
	local viewClassList = settingModel:getExtensionViewClassList()

	for _, viewClass in ipairs(viewClassList) do
		self._resLoader:addResPath(viewClass:dependMainResource())

		local dependResources = viewClass:dependExtensionResources()

		if dependResources then
			for _, respath in ipairs(dependResources) do
				self._resLoader:addResPath(respath)
			end
		end
	end
end

return BattleResourceMgr
