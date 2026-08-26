-- chunkname: @modules/logic/room/entity/pool/RoomGOPool.lua

module("modules.logic.room.entity.pool.RoomGOPool", package.seeall)

local RoomGOPool = _M
local _initialized = false
local _prefabDict, _poolContainerGO
local _poolDictList = {}
local _instanceDictList = {}
local _res2AbDict = {}
local _countDict

function RoomGOPool.init(prefabDict, countDict)
	RoomGOPool._reset()

	_prefabDict = prefabDict
	_countDict = countDict
	_initialized = true
end

function RoomGOPool.addPrefab(resPath, prefab, count)
	if _prefabDict then
		_prefabDict[resPath] = prefab
		_countDict[resPath] = count
	end
end

function RoomGOPool.getInstance(res, containerGO, name, ab)
	if not _initialized then
		return
	end

	local prefab = _prefabDict[res]

	if not prefab then
		local scene = GameSceneMgr.instance:getCurScene()

		prefab = scene.preloader:getResource(res, ab)
	end

	if not prefab then
		logError(string.format("找不到资源: %s", res))

		return
	end

	_res2AbDict[res] = _res2AbDict[res] or ab or res

	local poolList = _poolDictList[res]

	if not poolList then
		poolList = {}
		_poolDictList[res] = poolList
	end

	local instanceList = _instanceDictList[res]

	if not instanceList then
		instanceList = {}
		_instanceDictList[res] = instanceList
	end

	local go

	if #poolList > 0 then
		go = poolList[#poolList]

		gohelper.addChild(containerGO, poolList[#poolList])

		go.name = name or "instance"

		table.remove(poolList, #poolList)
	else
		go = gohelper.clone(prefab, containerGO, name or "instance")
	end

	table.insert(instanceList, go)

	return go
end

function RoomGOPool.returnInstance(res, go)
	if not _initialized then
		return
	end

	local poolList = _poolDictList[res]

	if not poolList then
		poolList = {}
		_poolDictList[res] = poolList
	end

	local instanceList = _instanceDictList[res]

	if not instanceList then
		instanceList = {}
		_instanceDictList[res] = instanceList
	end

	for i, one in ipairs(instanceList) do
		if one == go then
			table.remove(instanceList, i)

			break
		end
	end

	if _countDict[res] and _countDict[res] >= 0 and _countDict[res] <= #poolList then
		gohelper.addChild(RoomGOPool.getPoolContainerGO(), go)
		gohelper.destroy(go)
	else
		gohelper.addChild(RoomGOPool.getPoolContainerGO(), go)
		table.insert(poolList, go)
	end
end

function RoomGOPool.clearPool()
	local tempPoolDictList = _poolDictList

	_poolDictList = {}

	for res, poolList in pairs(tempPoolDictList) do
		for i, go in ipairs(poolList) do
			gohelper.destroy(go)
		end
	end
end

function RoomGOPool.existABPath(abPath)
	local resout

	for res, ab in pairs(_res2AbDict) do
		if ab == abPath then
			resout = false

			if RoomGOPool.existResPath(res) == true then
				return true
			end
		end
	end

	return resout
end

function RoomGOPool.existResPath(resPath)
	local poolList = _poolDictList[resPath]

	if poolList and #poolList > 0 then
		return true
	end

	local instanceList = _instanceDictList[resPath]

	if instanceList and #instanceList > 0 then
		return true
	end

	return false
end

function RoomGOPool.dispose()
	_initialized = false

	for res, instanceList in pairs(_instanceDictList) do
		for i, go in ipairs(instanceList) do
			gohelper.destroy(go)
		end
	end

	for res, poolList in pairs(_poolDictList) do
		for i, go in ipairs(poolList) do
			gohelper.destroy(go)
		end
	end

	RoomGOPool._reset()
end

function RoomGOPool._reset()
	_initialized = false
	_prefabDict = nil
	_poolContainerGO = nil
	_poolDictList = {}
	_instanceDictList = {}
	_res2AbDict = {}
end

function RoomGOPool.getPoolContainerGO()
	if not _poolContainerGO then
		local scene = GameSceneMgr.instance:getCurScene()

		_poolContainerGO = scene.go.poolContainerGO

		gohelper.setActive(_poolContainerGO, false)
	end

	return _poolContainerGO
end

return RoomGOPool
