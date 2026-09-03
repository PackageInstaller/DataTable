-- chunkname: @/tmp/or_script/lua_compile/dm/downloader/Downloader.lua

Downloader = Downloader or {}

local __downloaderFactory

function Downloader:getInstance()
	if __downloaderFactory == nil then
		__downloaderFactory = Downloader:new()
	end

	return __downloaderFactory
end

function Downloader:new()
	local result = setmetatable({}, {
		__index = Downloader
	})

	result:initialize()

	return result
end

function Downloader:initialize()
	self:initMember()
end

function Downloader:initMember()
	self._tasks = {}
	self._downloader = app:getDownloader()

	function self._downloader.onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
		local taskInfo = self:getTask(task.identifier)

		if taskInfo and taskInfo.onTaskProgress then
			taskInfo.onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
		end
	end

	function self._downloader.onTaskError(task, errorCode, errorCodeInternal, errorStr)
		local taskInfo = self:getTask(task.identifier)

		if taskInfo then
			self:removeTask(task.identifier)

			if taskInfo.onTaskError then
				taskInfo.onTaskError(task, errorCode, errorCodeInternal, errorStr)
			end
		end
	end

	function self._downloader.onFileTaskSuccess(task)
		local taskInfo = self:getTask(task.identifier)

		if taskInfo then
			self:removeTask(task.identifier)

			if taskInfo.onFileTaskSuccess then
				taskInfo.onFileTaskSuccess(task)
			end
		end
	end

	function self._downloader.onDataTaskSuccess(task, data)
		local taskInfo = self:getTask(task.identifier)

		if taskInfo then
			self:removeTask(task.identifier)

			if taskInfo.onDataTaskSuccess then
				taskInfo.onDataTaskSuccess(task, data)
			end
		end
	end
end

function Downloader:getTask(identifier)
	for _, v in pairs(self._tasks) do
		if v.identifier == identifier then
			return v
		end
	end

	return nil
end

function Downloader:addTask(info)
	if self:isExistTask(info.identifier) then
		return
	end

	table.insert(self._tasks, info)

	if info.type == "file" then
		self._downloader:downloadFile(info.srcUrl, info.storagePath, info.identifier, info.md5 or "")
	elseif info.type == "data" then
		self._downloader:downloadData(info.srcUrl, info.identifier)
	end
end

function Downloader:isExistTask(identifier)
	for _, v in pairs(self._tasks) do
		if v.identifier and v.identifier == identifier then
			return true
		end
	end

	return false
end

function Downloader:removeTask(identifier)
	for i = 1, #self._tasks do
		local task = self._tasks[i]

		if task == nil or task.identifier == identifier then
			table.remove(self._tasks, i)

			return
		end
	end
end

function Downloader:addDownloadTask(info)
	assert(info.identifier ~= nil, "addDownloadTask param 'identifier' must not be nil")
	assert(info.srcUrl ~= nil, "addDownloadTask param 'srcUrl' must not be nil")
	assert(info.type ~= nil, "addDownloadTask param 'type' must not be nil")
	self:addTask(info)
end

function Downloader:cancelTask(url)
	self._downloader:cancelTaskByURL(url)

	for i = #self._tasks, 1, -1 do
		local task = self._tasks[i]

		if task == nil or task.srcUrl == url then
			table.remove(self._tasks, i)
		end
	end
end

function Downloader:getTotalBytesReceivedByStoragePath(storagePath)
	if not self._downloader.getTotalBytesReceivedByStoragePath then
		return 0
	end

	return self._downloader:getTotalBytesReceivedByStoragePath(storagePath)
end
