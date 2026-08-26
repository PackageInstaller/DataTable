-- chunkname: @modules/logic/fight/entity/pool/FightEffectPool.lua

module("modules.logic.fight.entity.pool.FightEffectPool", package.seeall)

local FightEffectPool = _M
local _uniqueIdCounter = 1
local _path2AssetItemDict = {}
local _path2WrapPoolDict = {}
local _id2UsingWrapDict = {}
local _loadingWrapList = {}
local _poolContainerGO, _poolContainerTrs

FightEffectPool.isForbidEffect = nil

function FightEffectPool.getId2UsingWrapDict()
	return _id2UsingWrapDict
end

function FightEffectPool.releaseUnuseEffect()
	for _, wrapPool in pairs(_path2WrapPoolDict) do
		for _, sidePool in pairs(wrapPool) do
			for _, wrap in ipairs(sidePool) do
				wrap:markCanDestroy()
				gohelper.destroy(wrap.containerGO)
			end
		end
	end

	_path2WrapPoolDict = {}

	local usingPathSet = {}

	for _, wrap in pairs(_id2UsingWrapDict) do
		usingPathSet[wrap.path] = true
	end

	local releasePathSet = {}

	for key, assetItem in pairs(_path2AssetItemDict) do
		if not usingPathSet[key] then
			releasePathSet[key] = true

			assetItem:Release()

			_path2AssetItemDict[key] = nil
		end
	end

	return releasePathSet
end

function FightEffectPool.dispose()
	for key, assetItem in pairs(_path2AssetItemDict) do
		assetItem:Release()

		_path2AssetItemDict[key] = nil
	end

	for _, wrapPool in pairs(_path2WrapPoolDict) do
		for _, sidePool in pairs(wrapPool) do
			for _, wrap in ipairs(sidePool) do
				wrap:markCanDestroy()
				gohelper.destroy(wrap.containerGO)
			end
		end
	end

	for _, wrap in pairs(_id2UsingWrapDict) do
		wrap:markCanDestroy()
		gohelper.destroy(wrap.containerGO)
	end

	for _, wrapList in pairs(_loadingWrapList) do
		for _, wrap in ipairs(wrapList) do
			wrap:markCanDestroy()
			gohelper.destroy(wrap.containerGO)
		end
	end

	_path2AssetItemDict = {}
	_path2WrapPoolDict = {}
	_id2UsingWrapDict = {}
	_loadingWrapList = {}

	gohelper.destroy(_poolContainerGO)

	_poolContainerGO = nil
	_poolContainerTrs = nil
	_uniqueIdCounter = 1
end

function FightEffectPool.hasLoaded(path)
	if _path2AssetItemDict then
		return _path2AssetItemDict ~= nil
	end
end

function FightEffectPool.isLoading(path)
	return _loadingWrapList[path]
end

function FightEffectPool.getEffect(path, side, callback, callbackObj, hangPointGO, dontPlay)
	local assetItem = _path2AssetItemDict[path]
	local poolContainer = FightEffectPool.getPoolContainerGO()
	local effectWrap

	if assetItem then
		effectWrap = FightEffectPool._getLoadedEffect(path, side, callback, callbackObj, hangPointGO, dontPlay, assetItem)
	else
		effectWrap = FightEffectPool._getNotLoadEffect(path, side, callback, callbackObj, hangPointGO, dontPlay)
		_id2UsingWrapDict[effectWrap.uniqueId] = effectWrap

		if not FightEffectPool.isForbidEffect then
			local loader = MultiAbLoader.New()

			loader:addPath(effectWrap.abPath)
			loader:startLoad(FightEffectPool._onEffectLoaded)
		end
	end

	_id2UsingWrapDict[effectWrap.uniqueId] = effectWrap

	return effectWrap
end

function FightEffectPool._getLoadedEffect(path, side, callback, callbackObj, hangPointGO, dontPlay, assetItem)
	local effectWrap
	local poolContainer = FightEffectPool.getPoolContainerGO()
	local pool = _path2WrapPoolDict[path]
	local sidePool = pool and pool[side]

	if sidePool and #sidePool > 0 then
		local index = #sidePool

		for i, wrap in ipairs(sidePool) do
			if hangPointGO == nil and wrap.hangPointGO == poolContainer or hangPointGO ~= nil and wrap.hangPointGO == hangPointGO then
				index = i

				break
			end
		end

		effectWrap = table.remove(sidePool, index)

		effectWrap:setHangPointGO(hangPointGO or poolContainer)
	else
		effectWrap = FightEffectPool._createWrap(path)

		effectWrap:setHangPointGO(hangPointGO or poolContainer)

		effectWrap.side = side

		FightEffectPool._instantiateEffectGO(assetItem, effectWrap)
	end

	effectWrap:setCallback(callback, callbackObj)
	effectWrap:doCallback(true)
	effectWrap:setTimeScale(FightModel.instance:getSpeed())

	effectWrap.dontPlay = dontPlay

	effectWrap:play()

	return effectWrap
end

function FightEffectPool._getNotLoadEffect(path, side, callback, callbackObj, hangPointGO, dontPlay)
	local poolContainer = FightEffectPool.getPoolContainerGO()
	local effectWrap = FightEffectPool._createWrap(path)

	effectWrap.side = side

	effectWrap:setHangPointGO(hangPointGO or poolContainer)
	effectWrap:setCallback(callback, callbackObj)

	effectWrap.dontPlay = dontPlay

	local loadingList = _loadingWrapList[path]

	if not loadingList then
		loadingList = {}
		_loadingWrapList[path] = loadingList
	end

	table.insert(loadingList, effectWrap)

	return effectWrap
end

function FightEffectPool.returnEffect(effectWrap)
	if gohelper.isNil(effectWrap.containerGO) then
		return
	end

	effectWrap:setActive(false)
	effectWrap:onReturnPool()

	_id2UsingWrapDict[effectWrap.uniqueId] = nil

	local pool = _path2WrapPoolDict[effectWrap.path]

	if not pool then
		pool = {}
		_path2WrapPoolDict[effectWrap.path] = pool
	end

	local sidePool = pool[effectWrap.side]

	if not sidePool then
		sidePool = {}
		pool[effectWrap.side] = sidePool
	end

	if not tabletool.indexOf(sidePool, effectWrap) then
		table.insert(sidePool, effectWrap)
	end
end

function FightEffectPool.returnEffectToPoolContainer(effectWrap)
	effectWrap:setHangPointGO(FightEffectPool.getPoolContainerGO())
end

function FightEffectPool.getPoolContainerGO()
	if not _poolContainerGO then
		local fightSceneRoot = GameSceneMgr.instance:getScene(SceneType.Fight):getSceneContainerGO()

		_poolContainerGO = gohelper.create3d(fightSceneRoot, "EffectPool")
		_poolContainerTrs = _poolContainerGO.transform
	end

	return _poolContainerGO
end

function FightEffectPool._onEffectLoaded(loader)
	local assetItem = loader:getFirstAssetItem()

	if assetItem and assetItem.IsLoadSuccess then
		if GameResMgr.IsFromEditorDir then
			FightEffectPool._createLoadedEffectWrap(assetItem, assetItem.ResPath)
		else
			local allNames = assetItem.AllAssetNames

			if allNames then
				for i = 0, allNames.Length - 1 do
					local path = allNames[i]

					path = ResUrl.getPathWithoutAssetLib(path)

					FightEffectPool._createLoadedEffectWrap(assetItem, path)
				end
			end
		end
	else
		for key, wrapList in pairs(_loadingWrapList) do
			local hasLoad

			for _, effectWrap in ipairs(wrapList) do
				if assetItem then
					if effectWrap.abPath == assetItem.ResPath then
						effectWrap:doCallback(false)

						hasLoad = true
					end
				elseif loader._pathList and effectWrap.abPath == loader._pathList[1] then
					effectWrap:doCallback(false)

					hasLoad = true
				end
			end

			if hasLoad then
				_loadingWrapList[key] = nil
			end
		end

		if assetItem then
			logError("load effect fail: " .. assetItem.ResPath)
		end
	end

	loader:dispose()
end

function FightEffectPool._createLoadedEffectWrap(assetItem, path)
	if not _path2AssetItemDict[path] then
		_path2AssetItemDict[path] = assetItem

		assetItem:Retain()
	end

	local loadingList = _loadingWrapList[path]

	_loadingWrapList[path] = nil

	if loadingList then
		if not #loadingList then
			local count = 0

			for i = 1, count do
				local effectWrap = loadingList[i]

				FightEffectPool._instantiateEffectGO(assetItem, effectWrap)

				if _id2UsingWrapDict[effectWrap.uniqueId] then
					effectWrap:doCallback(true)
					effectWrap:setTimeScale(FightModel.instance:getSpeed())
					effectWrap:setActive(false)
					effectWrap:play()
				end
			end
		end
	end
end

function FightEffectPool._instantiateEffectGO(assetItem, effectWrap)
	if gohelper.isNil(effectWrap.containerGO) then
		return
	end

	local wholeEffectGO = gohelper.clone(assetItem:GetResource(effectWrap.path), effectWrap.containerGO)
	local effectGO = wholeEffectGO
	local effectSuffix

	if effectWrap.side == FightEnum.EntitySide.MySide then
		effectSuffix = "_r"
	elseif effectWrap.side == FightEnum.EntitySide.EnemySide then
		effectSuffix = "_l"
	end

	if not string.nilorempty(effectSuffix) then
		local wholeEffectTr = wholeEffectGO.transform
		local childCount = wholeEffectTr.childCount

		for i = 0, childCount - 1 do
			local child = wholeEffectTr:GetChild(i)
			local childName = child.name
			local len = string.len(childName)

			if string.sub(childName, len - 1, len) == effectSuffix then
				effectGO = child.gameObject

				gohelper.addChild(effectWrap.containerGO, child.gameObject)
				gohelper.destroy(wholeEffectGO)

				break
			end
		end
	end

	gohelper.removeEffectNode(effectGO)
	effectWrap:setEffectGO(effectGO)
end

function FightEffectPool._createWrap(path)
	local nameArr = FightStrUtil.instance:getSplitCache(path, "/")
	local name = nameArr[#nameArr]
	local go = gohelper.create3d(FightEffectPool.getPoolContainerGO(), name)
	local effectWrap = MonoHelper.addLuaComOnceToGo(go, FightEffectWrap)

	effectWrap:setUniqueId(_uniqueIdCounter)
	effectWrap:setPath(path)

	_uniqueIdCounter = _uniqueIdCounter + 1

	return effectWrap
end

return FightEffectPool
