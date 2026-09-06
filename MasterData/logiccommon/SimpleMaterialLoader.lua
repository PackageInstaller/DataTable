-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/materialmgr/SimpleMaterialLoader.lua

module("logiccommon.common.materialmgr.SimpleMaterialLoader", package.seeall)

local SimpleMaterialLoader = class("SimpleMaterialLoader")
local POOL_CLEANUP_INTERVAL = 2
local POOL_INSTANCE_IDLE_TIME = 6
local POOL_MAX_SIZE = 8

function SimpleMaterialLoader:ctor()
	self._shareMatAssetsCache = {}
	self._instanceMatAssetsCache = {}
	self._instanceMatTracker = {}
	self._matToInstanceId = setmetatable({}, {
		__mode = "k"
	})
	self._nextInstanceId = 1
	self._instanceMatReturnTime = {}
	self._poolCleanupAccumTime = 0

	LateUpdateBeat:Add(self._updatePoolCleanup, self)
end

function SimpleMaterialLoader:getSharedMat(resPath)
	local asset = self._shareMatAssetsCache[resPath]

	if asset then
		return asset
	end

	asset = CommonPreloader.instance:getSkinlibAsset(resPath)

	if not asset then
		printError("SimpleMaterialLoader:getSharedMat 材质资源为空: " .. resPath)

		return nil
	end

	self._shareMatAssetsCache[resPath] = asset

	return asset
end

function SimpleMaterialLoader:getInstanceMat(resPath)
	local sharedMat = self:getSharedMat(resPath)

	if not sharedMat then
		return nil
	end

	local mat

	if self._instanceMatAssetsCache[resPath] and #self._instanceMatAssetsCache[resPath] > 0 then
		mat = table.remove(self._instanceMatAssetsCache[resPath])

		if goutil.isNil(mat) then
			mat = nil
		end

		if #self._instanceMatAssetsCache[resPath] == 0 then
			self._instanceMatReturnTime[resPath] = nil
		end
	end

	mat = mat or UnityEngine.Object.Instantiate(sharedMat)

	if enableDebug then
		local instanceId = self:_generateInstanceId()

		self:_attachInstanceId(mat, instanceId, resPath)
		self:_trackInstance(resPath, mat, instanceId)
	end

	return mat
end

function SimpleMaterialLoader:recycleInstanceMat(resPath, mat)
	if not mat or goutil.isNil(mat) then
		printError("SimpleMaterialLoader:recycleInstanceMat 材质实例为空: " .. resPath)

		return
	end

	if enableDebug then
		local success, errorMsg = self:_untrackInstance(resPath, mat)

		if not success then
			printError(string.format("[SimpleMaterialLoader] 归还异常: \n-resPath: %s\n-错误: %s", resPath, errorMsg))
		end
	end

	self._instanceMatAssetsCache[resPath] = self._instanceMatAssetsCache[resPath] or {}

	if #self._instanceMatAssetsCache[resPath] < POOL_MAX_SIZE then
		table.insert(self._instanceMatAssetsCache[resPath], mat)

		self._instanceMatReturnTime[resPath] = UnityEngine.Time.time
	else
		UnityEngine.Object.Destroy(mat)
	end
end

function SimpleMaterialLoader:clear()
	if self._instanceMatAssetsCache then
		for resPath, pool in pairs(self._instanceMatAssetsCache) do
			for i = 1, #pool do
				local mat = pool[i]

				if not goutil.isNil(mat) then
					UnityEngine.Object.Destroy(mat)
				end
			end
		end

		self._instanceMatAssetsCache = {}
	end

	self._shareMatAssetsCache = {}
	self._instanceMatTracker = {}
	self._matToInstanceId = nil
	self._nextInstanceId = 1
	self._instanceMatReturnTime = {}
	self._poolCleanupAccumTime = 0

	LateUpdateBeat:Remove(self._updatePoolCleanup, self)
end

function SimpleMaterialLoader:_updatePoolCleanup()
	self._poolCleanupAccumTime = self._poolCleanupAccumTime + UnityEngine.Time.deltaTime

	if self._poolCleanupAccumTime < POOL_CLEANUP_INTERVAL then
		return
	end

	self._poolCleanupAccumTime = 0

	local currentTime = UnityEngine.Time.time

	for resPath, returnTime in pairs(self._instanceMatReturnTime) do
		local assetsList = self._instanceMatAssetsCache[resPath]

		if assetsList and #assetsList > 0 then
			local idleTime = currentTime - returnTime

			if idleTime >= POOL_INSTANCE_IDLE_TIME then
				local mat = table.remove(assetsList)

				if mat and not goutil.isNil(mat) then
					UnityEngine.Object.Destroy(mat)
				end

				if #assetsList == 0 then
					self._instanceMatReturnTime[resPath] = nil
					self._instanceMatAssetsCache[resPath] = nil
				else
					self._instanceMatReturnTime[resPath] = currentTime
				end
			end
		else
			self._instanceMatReturnTime[resPath] = nil
		end
	end
end

function SimpleMaterialLoader:_generateInstanceId()
	self._nextInstanceId = self._nextInstanceId + 1

	return self._nextInstanceId
end

function SimpleMaterialLoader:_attachInstanceId(mat, instanceId, resPath)
	if mat and not goutil.isNil(mat) then
		self._matToInstanceId[mat] = {
			id = instanceId,
			resPath = resPath
		}
	end
end

function SimpleMaterialLoader:_getInstanceId(mat)
	if not mat or goutil.isNil(mat) then
		return nil, nil
	end

	local info = self._matToInstanceId[mat]

	if info then
		return info.id, info.resPath
	end

	return nil, nil
end

function SimpleMaterialLoader:_trackInstance(resPath, mat, instanceId)
	self._instanceMatTracker[resPath] = self._instanceMatTracker[resPath] or {}
	self._instanceMatTracker[resPath][instanceId] = {
		mat = mat,
		stacktrace = debug.traceback("", 3),
		timestamp = UnityEngine.Time.time,
		id = instanceId
	}
end

function SimpleMaterialLoader:_untrackInstance(resPath, mat)
	local instanceId, trackedResPath = self:_getInstanceId(mat)

	if not instanceId then
		return false, "未追踪的材质归还，可能在追溯系统启用前获取"
	end

	if trackedResPath ~= resPath then
		return false, string.format("路径不匹配: 期望=%s, 实际=%s", resPath, trackedResPath)
	end

	if self._instanceMatTracker[resPath] and self._instanceMatTracker[resPath][instanceId] then
		self._instanceMatTracker[resPath][instanceId] = nil

		if next(self._instanceMatTracker[resPath]) == nil then
			self._instanceMatTracker[resPath] = nil
		end

		return true, nil
	else
		return false, "重复归还或记录已丢失"
	end
end

function SimpleMaterialLoader:getLeakedInstances()
	local leakedList = {}
	local totalCount = 0

	for resPath, instances in pairs(self._instanceMatTracker) do
		for instanceId, info in pairs(instances) do
			totalCount = totalCount + 1

			table.insert(leakedList, {
				resPath = resPath,
				instanceId = instanceId,
				timestamp = info.timestamp,
				stacktrace = info.stacktrace,
				leakedTime = UnityEngine.Time.time - info.timestamp
			})
		end
	end

	return {
		totalCount = totalCount,
		instances = leakedList
	}
end

function SimpleMaterialLoader:printLeakReport()
	local leakInfo = self:getLeakedInstances()

	if leakInfo.totalCount == 0 then
		return
	end

	local report = string.format("[SimpleMaterialLoader] 检测到 %d 个未归还的材质实例:", leakInfo.totalCount)

	printError(report)

	for i, leak in ipairs(leakInfo.instances) do
		local details = string.format("\n  [泄漏 #%d]\n  - resPath: %s\n  - instanceId: %d\n  - timestamp: %.2f\n  - leakedTime: %.2f秒", i, leak.resPath, leak.instanceId, leak.timestamp, leak.leakedTime)

		if leak.stacktrace then
			details = details .. "\n  - stacktrace:[[\n" .. leak.stacktrace .. "\n]]"
		end

		printError(details)
	end
end

SimpleMaterialLoader.instance = SimpleMaterialLoader.New()

return SimpleMaterialLoader
