-- chunkname: @modules/logic/summon/pool/SummonEffectPool.lua

module("modules.logic.summon.pool.SummonEffectPool", package.seeall)

local SummonEffectPool = _M
local _uniqueIdCounter = 1
local _path2AssetItemDict = {}
local _path2WrapPoolDict = {}
local _id2UsingWrapDict = {}
local _poolContainerGO, _poolContainerTrs

function SummonEffectPool.onEffectPreload(assetItem)
	assetItem:Retain()

	_path2AssetItemDict[assetItem.ResPath] = assetItem

	SummonEffectPool.returnEffect(SummonEffectPool.getEffect(assetItem.ResPath))
end

function SummonEffectPool.dispose()
	for _, assetItem in pairs(_path2AssetItemDict) do
		assetItem:Release()
	end

	for _, wrapPool in pairs(_path2WrapPoolDict) do
		for _, wrap in ipairs(wrapPool) do
			wrap:markCanDestroy()
			gohelper.destroy(wrap.containerGO)
		end
	end

	for _, wrap in pairs(_id2UsingWrapDict) do
		wrap:markCanDestroy()
		gohelper.destroy(wrap.containerGO)
	end

	_path2AssetItemDict = {}
	_path2WrapPoolDict = {}
	_id2UsingWrapDict = {}

	gohelper.destroy(_poolContainerGO)

	_poolContainerGO = nil
	_poolContainerTrs = nil
	_uniqueIdCounter = 1
end

function SummonEffectPool.getEffect(path, hangPointGO)
	logNormal("SummonEffectPool.getEffect path = " .. path)

	local assetItem = _path2AssetItemDict[path]
	local poolContainer = SummonEffectPool.getPoolContainerGO()
	local effectWrap

	if assetItem then
		local pool = _path2WrapPoolDict[path]

		if pool and #pool > 0 then
			local index = #pool

			for i, wrap in ipairs(pool) do
				if hangPointGO == nil and wrap.hangPointGO == poolContainer or hangPointGO ~= nil and wrap.hangPointGO == hangPointGO then
					index = i

					break
				end
			end

			effectWrap = table.remove(pool, index)
		else
			effectWrap = SummonEffectPool._createWrap(path)

			SummonEffectPool._instantiateEffectGO(assetItem, effectWrap, path)
		end

		effectWrap:setHangPointGO(hangPointGO or poolContainer)
	else
		logError("Summon Effect need preload: " .. path)

		return nil
	end

	_id2UsingWrapDict[effectWrap.uniqueId] = effectWrap

	effectWrap:setActive(true)

	return effectWrap
end

function SummonEffectPool.returnEffect(effectWrap)
	if gohelper.isNil(effectWrap.containerGO) then
		return
	end

	effectWrap:stop()
	effectWrap:unloadIcon()
	effectWrap:setActive(false)

	_id2UsingWrapDict[effectWrap.uniqueId] = nil

	local pool = _path2WrapPoolDict[effectWrap.path]

	if not pool then
		pool = {}
		_path2WrapPoolDict[effectWrap.path] = pool
	end

	table.insert(pool, effectWrap)
end

function SummonEffectPool.returnEffectToPoolContainer(effectWrap)
	effectWrap:setHangPointGO(SummonEffectPool.getPoolContainerGO())
end

function SummonEffectPool.getPoolContainerGO()
	if not _poolContainerGO then
		local SummonSceneRoot = VirtualSummonScene.instance:getRootGO()

		_poolContainerGO = gohelper.create3d(SummonSceneRoot, "EffectPool")
		_poolContainerTrs = _poolContainerGO.transform
	end

	return _poolContainerGO
end

function SummonEffectPool._instantiateEffectGO(assetItem, effectWrap, path)
	local effectGO = path and gohelper.clone(assetItem:GetResource(path), effectWrap.containerGO) or gohelper.clone(assetItem:GetResource(), effectWrap.containerGO)

	if effectGO == nil then
		logError("Instantiate effect failed: " .. path)

		return
	end

	effectWrap:setEffectGO(effectGO)
end

function SummonEffectPool._createWrap(path)
	local nameArr = string.split(path, "/")
	local name = nameArr[#nameArr]
	local go = gohelper.create3d(SummonEffectPool.getPoolContainerGO(), name)
	local effectWrap = MonoHelper.addLuaComOnceToGo(go, SummonEffectWrap)

	effectWrap:setUniqueId(_uniqueIdCounter)
	effectWrap:setPath(path)

	_uniqueIdCounter = _uniqueIdCounter + 1

	return effectWrap
end

return SummonEffectPool
