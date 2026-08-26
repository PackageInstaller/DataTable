-- chunkname: @modules/logic/fight/entity/pool/FightSpinePool.lua

module("modules.logic.fight.entity.pool.FightSpinePool", package.seeall)

local FightSpinePool = class("FightSpinePool")
local _poolDict = {}
local _assetItemDict = {}

function FightSpinePool.getSpine(url)
	local pool = _poolDict[url]

	if not pool then
		pool = LuaObjPool.New(3, function()
			local assetItem = _assetItemDict[url]

			if assetItem then
				local prefab = assetItem:GetResource()

				return (gohelper.clone(prefab))
			end
		end, FightSpinePool._releaseFunc, FightSpinePool._resetFunc)
		_poolDict[url] = pool
	end

	return (pool:getObject())
end

function FightSpinePool.putSpine(url, spineGO)
	local pool = _poolDict[url]

	if pool then
		pool:putObject(spineGO)
	end
end

function FightSpinePool.setAssetItem(url, assetItem)
	_assetItemDict[url] = assetItem
end

function FightSpinePool.dispose()
	for url, pool in pairs(_poolDict) do
		FightSpinePool.releaseUrl(url)
	end

	for url, assetItem in pairs(_assetItemDict) do
		_assetItemDict[url] = nil
	end

	_poolDict = {}
	_assetItemDict = {}
end

function FightSpinePool._releaseFunc(spineGO)
	if spineGO then
		gohelper.destroy(spineGO)
	end
end

function FightSpinePool._resetFunc(spineGO)
	if spineGO then
		gohelper.setActive(spineGO, false)

		local container = FightGameMgr.entityMgr:getEntityContainer()

		gohelper.addChild(container, spineGO)
		transformhelper.setLocalPos(spineGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(spineGO.transform, 1, 1, 1)
		transformhelper.setLocalRotation(spineGO.transform, 0, 0, 0)
	end
end

function FightSpinePool.releaseUrl(url)
	if _poolDict then
		if _poolDict then
			_poolDict:dispose()

			_poolDict[url] = nil
		end

		if _assetItemDict and _assetItemDict[url] then
			_assetItemDict[url] = nil
		end
	end
end

return FightSpinePool
