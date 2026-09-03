-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameExtPackUpdater.lua

local fileUtils = cc.FileUtils:getInstance()
local writablePath = fileUtils:getWritablePath()
local kDownloadRetryMax = 5
local dbFilePath = writablePath .. "extensions.db"
local cjson = require("cjson.safe")

require("dm.gameupdate.GameUpdaterDelegate")
require("dm.gameupdate.GameUpdater")

local isInitUpdateCfg = false
local maxDownloadNum = 20

GameExtPackUpdater = GameExtPackUpdater or {}

local function createSqlStr(sqlData)
	local jsonData = cjson.decode(sqlData)
	local data = jsonData.data
	local updateStr = ""
	local updateDate = {}
	local deleteKey = {}
	local deleteKeyPath = {}

	for i = 1, #data do
		local array = data[i]

		if array[5] ~= "" then
			table.insert(array, jsonData.version)
			table.insert(updateDate, "'" .. table.concat(array, "', '") .. "', '0'")
		end

		table.insert(deleteKey, array[1])
		table.insert(deleteKeyPath, array[2])
	end

	if #deleteKey > 0 then
		updateStr = updateStr .. string.format("DELETE FROM main.extension WHERE logic IN ('%s');", table.concat(deleteKey, "', '"))
	end

	if #updateDate > 0 then
		updateStr = updateStr .. "INSERT OR REPLACE INTO main.extension ('logic','real','size','hash','url','extension','version','downloaded') SELECT " .. table.concat(updateDate, " UNION SELECT ") .. ";"
	end

	for i = 1, #deleteKeyPath do
		local path = writablePath .. deleteKeyPath[i]

		fileUtils:removeFile(path)
		fileUtils:removeFile(path .. ".tmp")
		print("删除扩展包文件", path)
	end

	return updateStr
end

function GameExtPackUpdater.initUpdateCfg()
	if isInitUpdateCfg then
		return
	end

	isInitUpdateCfg = true

	app.getAssetsManager():cleanup_ext()

	if not fileUtils:isFileExist(dbFilePath) then
		local srcDBFilePath = fileUtils:fullPathForFilename("extensions.db")

		if fileUtils:isFileExist(srcDBFilePath) then
			print("*********copy extensions db to" .. dbFilePath)
			app.copyFile(srcDBFilePath, dbFilePath)
			print("*********copy extensions db over*********")
		else
			print("********* no extensions db *********")

			return
		end
	else
		print("*********extensions db existing*********")
	end

	local updateCfgPath = writablePath .. "updateExtDist"

	if fileUtils:isFileExist(updateCfgPath) then
		local updateContent = fileUtils:getStringFromFile(updateCfgPath)
		local maxSQLCount = 300
		local cjson = require("cjson.safe")
		local updateData = cjson.decode(updateContent)
		local sqlVector = {}
		local sqls = updateData.data

		if maxSQLCount < table.nums(sqls) then
			for i, v in ipairs(sqls) do
				local pointer = math.ceil(i / maxSQLCount)

				sqlVector[pointer] = sqlVector[pointer] or {
					data = {},
					version = updateData.version
				}

				local subSQLData = sqlVector[pointer]
				local index = math.mod(i, maxSQLCount)

				index = index == 0 and maxSQLCount or index
				subSQLData.data[index] = sqls[i]
			end
		else
			sqlVector[#sqlVector + 1] = updateData
		end

		local tempUpdateDBPath = writablePath .. "extensions_temp.db"

		fileUtils:removeFile(tempUpdateDBPath)
		app.copyFile(dbFilePath, tempUpdateDBPath)
		print("start update extensions db")

		for _, subSqlData in ipairs(sqlVector) do
			local subContent = createSqlStr(cjson.encode(subSqlData))
			local errorInfo = app.getAssetsManager():mergeDbBySQLString(tempUpdateDBPath, subContent)

			assert(#errorInfo == 0, "mergeDb error:" .. errorInfo)
		end

		fileUtils:removeFile(dbFilePath)
		fileUtils:renameFile(tempUpdateDBPath, dbFilePath)
		fileUtils:removeFile(updateCfgPath)
		print("*********merge extensions db over*********")
	end

	app.getAssetsManager():initExtensionsDB(dbFilePath)
end

function GameExtPackUpdater:new()
	local result = setmetatable({}, {
		__index = GameExtPackUpdater
	})

	result:initialize()

	return result
end

function GameExtPackUpdater:initialize()
	self._downloader = Downloader:getInstance()

	if app.setDownloaderMaxNumPerFrame then
		app.setDownloaderMaxNumPerFrame(2)
	end

	self._isAllDownloadFinish = false
	self._resType = nil
	self._packages = {}
end

function GameExtPackUpdater:setDownloaderMaxNumPerFrame(num)
	self._downloader = Downloader:getInstance()

	if app.setDownloaderMaxNumPerFrame then
		app.setDownloaderMaxNumPerFrame(num)
	end
end

function GameExtPackUpdater:initWithTypeOrSqlStr(type, sqlConditionStr)
	local sqlstr = ""

	if type then
		self._resType = tostring(type)
		sqlstr = "WHERE extension = " .. self._resType
	end

	local var_6_0 = app.getAssetsManager():getExtRowsByConditionStr((sqlConditionStr or nil) and "WHERE " .. sqlConditionStr)

	var_6_0 = var_6_0 or {}
	self._extensionsInfo = var_6_0

	local tempCache = {}

	self._packages = {}

	for _, v in pairs(self._extensionsInfo) do
		if not tempCache[v[7]] then
			local cdnInfo = {}

			_G.CDN_URLS = _G.CDN_URLS or {}
			cdnInfo[#cdnInfo + 1] = _G.CDN_URLS[1] or "http://cdn.dpstorm.com"

			local extraCdnUrl = _G.CDN_URLS[2]

			if extraCdnUrl and extraCdnUrl ~= "" then
				cdnInfo[#cdnInfo + 1] = extraCdnUrl
			end

			local isDownload = v[5] == "1"
			local packageInfo = {
				cdnUrl = cdnInfo,
				url = v[4],
				packName = v[3],
				size = tonumber(v[6]),
				md5 = v[7]
			}
			local package = UpdatePackage:new(packageInfo)

			package.totalBytesReceived = 0
			package.logic = v[1]

			if isDownload or fileUtils:isFileExist(package:getPath()) then
				package.totalBytesReceived = packageInfo.size

				package:setStatus(PkgStatus.kDownloadFinsh)

				if not isDownload then
					self:updateDownloadState(package:getName())
				end
			end

			self._packages[#self._packages + 1] = package
			tempCache[v[7]] = true
		end
	end
end

function GameExtPackUpdater:isAllDownloadFinish()
	if self._isAllDownloadFinish then
		return true
	end

	if #self._extensionsInfo == 0 then
		return true
	end

	for index, package in ipairs(self._packages) do
		if package:getStatus() ~= PkgStatus.kDownloadFinsh then
			return false
		end
	end

	self._isAllDownloadFinish = true

	return true
end

function GameExtPackUpdater:hasDownloadingTask()
	for index, package in ipairs(self._packages) do
		if package:getStatus() == PkgStatus.kDownloading or package:getStatus() == PkgStatus.kWait then
			return true
		end
	end

	return false
end

function GameExtPackUpdater:autoPauseTask()
	if self._isPause then
		return
	end

	self:pauseTask()

	self._isAutoPause = true
end

function GameExtPackUpdater:pauseTask()
	self._isAutoPause = false

	if self._isPause then
		return
	end

	if self:isAllDownloadFinish() then
		return
	end

	self._isPause = true

	for index, package in ipairs(self._downLoadingTask) do
		self._downloader:cancelTask(package:getCurDownloadUrl())
	end
end

function GameExtPackUpdater:isAutoPause()
	return self._isAutoPause
end

function GameExtPackUpdater:isPause()
	return self._isPause
end

function GameExtPackUpdater:setIgnoreNetState(ignore)
	self._ignoreNetState = ignore
end

function GameExtPackUpdater:ignoreNetState()
	return self._ignoreNetState
end

function GameExtPackUpdater:resumeTask()
	if not self._isPause then
		return
	end

	self._isPause = false
	self._isAutoPause = false

	for k, v in pairs(self._downLoadingTask) do
		v:resetCdnIndex()
		self:downloadResPack(v)
	end
end

function GameExtPackUpdater:setProgressFunc(func)
	self._progressFunc = func
end

function GameExtPackUpdater:onAutoPause()
	if self._delegate and self._delegate.onAutoPause then
		self._delegate:onAutoPause()
	end
end

function GameExtPackUpdater:onAutoResume()
	if self._delegate and self._delegate.onAutoResume then
		self._delegate:onAutoResume()
	end
end

function GameExtPackUpdater:setDelegate(delegate)
	self._delegate = delegate
end

function GameExtPackUpdater:getProgress()
	if #self._packages == 0 then
		return 100
	end

	local totalBytesReceived = self:getTotalReceivedSize()
	local totalBytesExpected = self:getTotalExpectedSize()

	return totalBytesReceived / totalBytesExpected * 100
end

function GameExtPackUpdater:getTotalReceivedSize()
	if self._totalBytesReceived then
		return self._totalBytesReceived
	end

	local totalBytesReceived = 0

	for index, package in ipairs(self._packages) do
		totalBytesReceived = totalBytesReceived + package.totalBytesReceived
	end

	self._totalBytesReceived = totalBytesReceived

	return self._totalBytesReceived
end

function GameExtPackUpdater:getTotalExpectedSize()
	if self._totalBytesExpected then
		return self._totalBytesExpected
	end

	self._totalBytesExpected = 0

	for index, package in ipairs(self._packages) do
		self._totalBytesExpected = self._totalBytesExpected + package:getSize()
	end

	return self._totalBytesExpected
end

function GameExtPackUpdater:run()
	if self._isRun then
		return
	end

	self._isRun = true

	if self:isAllDownloadFinish() then
		if self._progressFunc then
			self._progressFunc(100)
		end

		print("所有文件已经下载完成")

		return
	end

	self._downloadNum = #self._packages
	self._progress = 0
	self._currentDownloadIndex = 0
	self._downLoadingTask = {}

	print("准备下载任务数量", self._downloadNum)

	if self._downloadNum >= maxDownloadNum then
		if not maxDownloadNum then
			local startDownloadNum = self._downloadNum

			table.sort(self._packages, function(a, b)
				if a:getStatus() == b:getStatus() then
					return a:getCurDownloadUrl() > b:getCurDownloadUrl()
				else
					return a:getStatus() == PkgStatus.kDownloadFinsh
				end
			end)

			while self._currentDownloadIndex < self._downloadNum and startDownloadNum > 0 do
				self._currentDownloadIndex = self._currentDownloadIndex + 1

				local package = self._packages[self._currentDownloadIndex]

				if package:getStatus() ~= PkgStatus.kDownloadFinsh then
					startDownloadNum = startDownloadNum - 1

					self:downloadResPack(package)
				end
			end

			local progress = self:getProgress()

			if self._progressFunc and (progress - self._progress > 1 or progress == 100) then
				self._progress = progress

				self._progressFunc(progress)
				print(string.format("----------------总下载进度:%s--------------", progress))
			end
		end
	end
end

function GameExtPackUpdater:updateDownloadState(real)
	local sqlstr = string.format("UPDATE extension SET downloaded = '1' WHERE real = '%s'", real)

	app.getAssetsManager():mergeExtensionsDBBySQLString(sqlstr)
end

function GameExtPackUpdater:_clearErrorPackage()
	for index, package in ipairs(self._packages) do
		local pkgPath = package:getPath()

		if pkgPath then
			if package:getStatus() == PkgStatus.kDownloadFail then
				local errorCode = package:getErrorCode()

				if errorCode ~= 42 and errorCode ~= 6 and errorCode ~= 56 then
					fileUtils:removeFile(pkgPath .. ".tmp")

					self._totalBytesReceived = self:getTotalReceivedSize() - package.totalBytesReceived
					package.totalBytesReceived = 0
				end
			elseif package:getStatus() == PkgStatus.kDownloadDamage then
				fileUtils:removeFile(pkgPath)

				self._totalBytesReceived = self:getTotalReceivedSize() - package.totalBytesReceived
				package.totalBytesReceived = 0
			end
		end
	end
end

function GameExtPackUpdater:downloadResPack(package)
	local function retry(package)
		package:resetCdnIndex()

		local curDownloadUrl = package:getCurDownloadUrl()

		if curDownloadUrl then
			local downloadTaskInfo = package:getDownloadTaskInfo()

			downloadTaskInfo.srcUrl = curDownloadUrl

			package:setDownloadTaskInfo(downloadTaskInfo)
			package:setStatus(PkgStatus.kDownloading)
			print("重置cdn尝试下载", curDownloadUrl)

			local pkgPath = package:getPath()

			self._downloader:addDownloadTask(downloadTaskInfo)
		end
	end

	local function onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
		self._totalBytesReceived = self:getTotalReceivedSize() + totalBytesReceived - package.totalBytesReceived
		package.totalBytesReceived = totalBytesReceived

		if self._delegate and self._delegate.onTaskProgress then
			self._delegate:onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
		end
	end

	local function onFileTaskSuccess(task)
		self._totalBytesReceived = self:getTotalReceivedSize() + package:getSize() - package.totalBytesReceived
		package.totalBytesReceived = package:getSize()

		if self._delegate and self._delegate.onFileTaskSuccess then
			self._delegate:onFileTaskSuccess(task)
		end

		package:setStatus(PkgStatus.kDownloadFinsh)

		self._downLoadingTask[package.logic] = nil

		if package:getRetryCount() > 0 then
			print("重新尝试下载成功:", package:getCurDownloadUrl())
		end

		if self._currentDownloadIndex < self._downloadNum then
			self._currentDownloadIndex = self._currentDownloadIndex + 1

			self:downloadResPack(self._packages[self._currentDownloadIndex])
		else
			self:_clearErrorPackage()
		end

		self:updateDownloadState(package:getName())

		local progress = self:getProgress()

		if self._progressFunc and (progress - self._progress > 1 or progress == 100) then
			self._progress = progress

			self._progressFunc(progress)
			print(string.format("----------------总下载进度:%s--------------", progress))
		end
	end

	local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
		if errorCodeInternal == 42 then
			package:setStatus(PkgStatus.kDownloadCancel)
			package:setErrorCode(errorCodeInternal)
			package:setErrorStr(errorStr)

			return
		end

		local pkgPath = package:getPath()

		if pkgPath then
			local errorCode = package:getErrorCode()

			if errorCode ~= 6 and errorCode ~= 56 then
				fileUtils:removeFile(pkgPath .. ".tmp")

				self._totalBytesReceived = self:getTotalReceivedSize() - package.totalBytesReceived
				package.totalBytesReceived = 0
			end
		end

		print(string.format("下载任务失败:%s,%s,%s,%s", task.requestURL or "", errorCode, errorCodeInternal, errorStr))
		package:switchCdn()

		local curDownloadUrl = package:getCurDownloadUrl()

		if curDownloadUrl then
			print("切换cdn尝试下载", curDownloadUrl)

			local downloadTaskInfo = package:getDownloadTaskInfo()

			downloadTaskInfo.srcUrl = curDownloadUrl

			package:setDownloadTaskInfo(downloadTaskInfo)
			package:setStatus(PkgStatus.kDownloading)
			package:setErrorCode(errorCodeInternal)
			package:setErrorStr(errorStr)
			self._downloader:addDownloadTask(downloadTaskInfo)
		elseif package:getRetryCount() < kDownloadRetryMax then
			package:setRetryCount(package:getRetryCount() + 1)
			retry(package)
		else
			package:setStatus(PkgStatus.kDownloadFail)
			self:_clearErrorPackage()
			print(string.format("****下载任务最终尝试失败*****:%s,%s,%s,%s", task.requestURL or "", errorCode, errorCodeInternal, errorStr))

			if self._delegate and self._delegate.onTaskError then
				self._delegate:onTaskError(task, errorCode, errorCodeInternal, errorStr)
			end

			if self._currentDownloadIndex < self._downloadNum then
				self._currentDownloadIndex = self._currentDownloadIndex + 1

				self:downloadResPack(self._packages[self._currentDownloadIndex])
			end
		end
	end

	local destPath = package:getPath()
	local curDownloadUrl = package:getCurDownloadUrl()
	local taskInfo = {
		type = "file",
		identifier = package.logic,
		md5 = package:getMd5(),
		srcUrl = curDownloadUrl,
		storagePath = destPath,
		onTaskProgress = onTaskProgress,
		onFileTaskSuccess = onFileTaskSuccess,
		onTaskError = onTaskError
	}

	package:setDownloadTaskInfo(taskInfo)

	if self._delegate and self._delegate.onFileTaskStart then
		self._delegate:onFileTaskStart(taskInfo)
	end

	if fileUtils:isFileExist(destPath) then
		print("文件已经存在直接下载成功", curDownloadUrl)

		local size = package:getSize()
		local task = {
			storagePath = taskInfo.storagePath,
			identifier = taskInfo.identifier,
			requestURL = taskInfo.srcUrl
		}

		onTaskProgress(task, 0, size, size)
		onFileTaskSuccess(task)
	else
		package:setStatus(PkgStatus.kDownloading)

		self._downLoadingTask[package.logic] = package

		if self._isPause then
			return
		end

		self._downloader:addDownloadTask(taskInfo)
	end
end
