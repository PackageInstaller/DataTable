-- chunkname: @modules/logic/room/entity/pool/RoomUIPool.lua

module("modules.logic.room.entity.pool.RoomUIPool", package.seeall)

local RoomUIPool = _M
local _initialized = false
local _poolContainerGO, _instanceContainerGO
local _poolDictList = {}
local _instanceDictList = {}
local _instanceListForSibling = {}
local _instanceDictForSibling = {}
local _prefabDict

function RoomUIPool.init(prefabDict)
	RoomUIPool._reset()

	_prefabDict = prefabDict
	_initialized = true

	TaskDispatcher.runRepeat(RoomUIPool._onTickSortSibling, nil, 2)
end

function RoomUIPool.getInstance(res, name)
	if not _initialized then
		return
	end

	local prefab = _prefabDict[res]

	if not prefab then
		local scene = GameSceneMgr.instance:getCurScene()

		prefab = scene.preloader:getResource(res)
	end

	if not prefab then
		logError(string.format("找不到资源:%s", res))

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

	local go

	if #poolList > 0 then
		go = poolList[#poolList]

		gohelper.addChild(RoomUIPool.getInstanceContainerGO(), poolList[#poolList])

		go.name = name or "ui"

		table.remove(poolList, #poolList)
	else
		go = gohelper.clone(prefab, RoomUIPool.getInstanceContainerGO(), name or "ui")
	end

	table.insert(instanceList, go)
	table.insert(_instanceListForSibling, go)
	transformhelper.setLocalScale(go.transform, 0.01, 0.01, 0.01)

	return go
end

function RoomUIPool.returnInstance(res, go)
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

	gohelper.addChild(RoomUIPool.getPoolContainerGO(), go)

	for i, one in ipairs(instanceList) do
		if one == go then
			table.remove(instanceList, i)

			break
		end
	end

	tabletool.removeValue(_instanceListForSibling, go)
	table.insert(poolList, go)
end

function RoomUIPool.dispose()
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

	RoomUIPool._reset()
	TaskDispatcher.cancelTask(RoomUIPool._onTickSortSibling, nil)
end

function RoomUIPool._reset()
	_initialized = false
	_poolContainerGO = nil
	_instanceContainerGO = nil
	_poolDictList = {}
	_instanceDictList = {}

	for key, _ in pairs(_instanceListForSibling) do
		_instanceListForSibling[key] = nil
	end

	for key, _ in pairs(_instanceDictForSibling) do
		_instanceDictForSibling[key] = nil
	end

	_instanceListForSibling = {}
	_instanceDictForSibling = {}
end

function RoomUIPool.getPoolContainerGO()
	if not _poolContainerGO then
		local scene = GameSceneMgr.instance:getCurScene()

		_poolContainerGO = gohelper.findChild(scene.go.canvasGO, "uipoolcontainer")

		gohelper.setActive(_poolContainerGO, false)
	end

	return _poolContainerGO
end

function RoomUIPool.getInstanceContainerGO()
	if not _instanceContainerGO then
		local scene = GameSceneMgr.instance:getCurScene()

		_instanceContainerGO = gohelper.findChild(scene.go.canvasGO, "uiinstancecontainer")
	end

	return _instanceContainerGO
end

function RoomUIPool._onTickSortSibling()
	if #_instanceListForSibling <= 1 then
		return
	end

	local cameraX, cameraY, cameraZ = transformhelper.getPos(CameraMgr.instance:getMainCameraTrs())

	for _, go in ipairs(_instanceListForSibling) do
		local x, y, z = transformhelper.getPos(go.transform)
		local offsetX = cameraX - x
		local offsetY = cameraY - y
		local offsetZ = cameraZ - z

		_instanceDictForSibling[go] = offsetX * offsetX + offsetY * offsetY + offsetZ * offsetZ
	end

	table.sort(_instanceListForSibling, RoomUIPool._sortByDistance)

	for i, go in ipairs(_instanceListForSibling) do
		gohelper.setSibling(go, i - 1)
	end
end

function RoomUIPool._sortByDistance(go1, go2)
	return _instanceDictForSibling[go1] > _instanceDictForSibling[go2]
end

return RoomUIPool
