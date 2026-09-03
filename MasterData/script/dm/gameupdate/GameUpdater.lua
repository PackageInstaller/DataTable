-- chunkname: @/tmp/or_script/lua_compile/dm/gameupdate/GameUpdater.lua

local cjson = require("cjson.safe")

require("foundation.crypto.init")
require("dm.downloader.Downloader")
require("dm.gameupdate.GameUpdaterDelegate")
require("dm.gameupdate.VersionChecker")
trycall(require, "dm.assets.DataReader")

local kHorizonSize = 52428800
local kDownloadRetryMax = 2
local fileUtils = cc.FileUtils:getInstance()
local writablePath = fileUtils:getWritablePath()

PkgStatus = {
	kDownloadFinsh = 3,
	kDownloadFail = 4,
	kDownloadDamage = 5,
	kDownloadCancel = 6,
	kWait = 1,
	kDownloading = 2
}

local retainTmpList = {
	6,
	56
}

local function inRetainTmpList(errorCode)
	for _, v in pairs(retainTmpList) do
		if v == errorCode then
			return true
		end
	end

	return false
end

trycall(require, "cocos.cocos2d.functions")

local oldDump = _G.dump

local function dump(...)
	if oldDump then
		pcall(oldDump, ...)
	end
end

local defaultOptions = {
	is = "rw"
}

local function has(self, symbol, options)
	options = options or defaultOptions
	options.is = options.is or defaultOptions.is

	local functionName = symbol:match("[^%w]*(.*)")
	local capitalized = functionName:sub(1, 1):upper() .. functionName:sub(2)
	local geterSymbol
	local isBoolean = options.is:find("b")

	geterSymbol = isBoolean and functionName or "get" .. capitalized

	local seterSymbol = "set" .. capitalized
	local geterFunction, seterFunction

	if options.is:find("r") then
		local default = options.default

		geterFunction = default ~= nil and function(self)
			local v = self[symbol]

			if v ~= nil then
				return v
			end

			return default
		end or function(self)
			return self[symbol]
		end

		_G.rawset(self, geterSymbol, geterFunction)
	end

	if options.is:find("w") then
		function seterFunction(self, value)
			self[symbol] = value
		end

		_G.rawset(self, seterSymbol, seterFunction)
	end

	return {
		class = self,
		memberSymbol = symbol,
		geterSymbol = geterFunction and geterSymbol or nil,
		seterSymbol = seterFunction and seterSymbol or nil
	}
end

UpdatePackage = UpdatePackage or {}
UpdatePackage.has = has

UpdatePackage:has("_md5", {
	is = "r"
})
UpdatePackage:has("_name", {
	is = "r"
})
UpdatePackage:has("_path", {
	is = "r"
})
UpdatePackage:has("_url", {
	is = "rw"
})
UpdatePackage:has("_downloadTaskInfo", {
	is = "rw"
})
UpdatePackage:has("_size", {
	is = "r"
})
UpdatePackage:has("_status", {
	is = "rw"
})
UpdatePackage:has("_packageId", {
	is = "rw"
})
UpdatePackage:has("_retryCount", {
	is = "rw"
})
UpdatePackage:has("_errorCode", {
	is = "rw"
})
UpdatePackage:has("_errorStr", {
	is = "rw"
})
UpdatePackage:has("_realMd5", {
	is = "rw"
})

function UpdatePackage:new(info)
	local result = setmetatable({}, {
		__index = UpdatePackage
	})

	result:initialize(info)

	return result
end

function UpdatePackage:initialize(info)
	self._cdnUrl = info.cdnUrl or {}
	self._cdnIndex = 1
	self._md5 = info.md5
	self._realMd5 = ""
	self._url = info.url
	self._size = info.size
	self._name = info.packName
	self._status = PkgStatus.kWait
	self._path = writablePath .. info.packName
	self._downloadTaskInfo = nil
	self._retryCount = 0
end

function UpdatePackage:getCurDownloadUrl()
	local cdnUrl = self._cdnUrl[self._cdnIndex]

	if cdnUrl then
		return cdnUrl .. "/" .. self._url
	end
end

function UpdatePackage:switchCdn()
	self._cdnIndex = self._cdnIndex + 1
end

function UpdatePackage:resetCdnIndex()
	self._cdnIndex = 1
end

if not PatchFile then
	local PatchFile = {}

	PatchFile.has = has

	PatchFile:has("_md5", {
		is = "rw"
	})
	PatchFile:has("_cdnInfo", {
		is = "rw"
	})
	PatchFile:has("_patchInfo", {
		is = "rw"
	})
	PatchFile:has("_patchId", {
		is = "rw"
	})
	PatchFile:has("_storagePath", {
		is = "rw"
	})
	PatchFile:has("_logic", {
		is = "rw"
	})
	PatchFile:has("_url", {
		is = "rw"
	})
	PatchFile:has("_retryCount", {
		is = "rw"
	})
	PatchFile:has("_downloadTaskInfo", {
		is = "rw"
	})

	function PatchFile:new(info)
		local result = setmetatable({}, {
			__index = PatchFile
		})

		result:initialize(info)

		return result
	end

	function PatchFile:initialize(info)
		self._cdnInfo = info.cdnInfo
		self._patchInfo = info.patchInfo
		self._md5 = self._patchInfo.hash
		self._cdnIndex = info.index
		self._logic = self._patchInfo.logic
		self._url = self._patchInfo.url
		self._retryCount = 0
		self._downloadTaskInfo = nil
		self._storagePath = ""
	end

	function PatchFile:resetCdnIndex()
		self._cdnIndex = 1
	end

	function PatchFile:switchCdn()
		self._cdnIndex = self._cdnIndex + 1
	end

	function PatchFile:getCurDownloadUrl()
		local cdnUrl = self._cdnInfo[self._cdnIndex]

		if cdnUrl then
			return cdnUrl .. "/" .. self._url
		end
	end

	local function dumpPackageInfos(packages)
		local text = ""

		if not packages then
			text = "the packages is nil"
		end

		for _, package in pairs(packages) do
			text = text .. "{\n"

			if package and package.getUrl then
				text = text .. "url:" .. tostring(package:getUrl()) .. "\n"
			end

			if package and package.getMd5 then
				text = text .. "md5:" .. tostring(package:getMd5()) .. "\n"
			end

			if package and package.getPath then
				text = text .. "path:" .. tostring(package:getPath()) .. "\n"
			end

			if package and package.getCdnIndex then
				text = text .. "cdnIndex:" .. tostring(package:getCdnIndex()) .. "\n"
			end

			if package and package.getSize then
				text = text .. "size:" .. tostring(package:getSize()) .. "\n"
			end

			if package and package.getName then
				text = text .. "name:" .. tostring(package:getName()) .. "\n"
			end

			if package and package.getStatus then
				text = text .. "status:" .. tostring(package:getStatus()) .. "\n"
			end

			if package and package.getRetryCount then
				text = text .. "retryCount:" .. tostring(package:getRetryCount()) .. "\n"
			end

			if package and package.getRealMd5 then
				text = text .. "realMd5:" .. tostring(package:getRealMd5()) .. "\n"
			end

			text = text .. "}\n"
		end

		return text
	end

	GameUpdater = GameUpdater or {}

	local packages = {}
	local installVersionsInfo = {}
	local installVersionsIndex = 0
	local ASSETS_DB_FILE = "assets.db"
	local PATCH_FOLDER = "patch"
	local patch_path = writablePath .. PATCH_FOLDER
	local packTotalSize = 0

	IS_FORCE_UPDATE = false

	local function calculatePackSize(data)
		local ret = 0
		local deviceInfo = app.getDevice():getDeviceInfo()

		if data and data.pack and type(data.pack) == "table" then
			for _, packageDatas in pairs(data.pack) do
				local packageData = packageDatas[tostring((deviceInfo and deviceInfo.cpuType or nil) and deviceInfo.cpuType)]

				for _, v in pairs(packageData) do
					ret = ret + tonumber(v.size)
				end
			end
		end

		return ret
	end

	local function parsePackNameByUrl(url)
		local flag, zipName

		if type(url) ~= "string" then
			GameUpdaterDebuger:print("download pack address url type is not string, it is %s", type(url))

			return nil
		end

		flag = string.find(url, "\\")

		if flag then
			zipName = string.match(url, ".+\\([^\\]*%.%w+)$")
		end

		flag = string.find(url, "/")

		return (flag or nil) and string.match(url, ".+/([^/]*%.%w+)$")
	end

	local function calculateAlreadyDownloadSize(data, downloader)
		local ret = 0
		local deviceInfo = app.getDevice():getDeviceInfo()

		if data and data.pack and type(data.pack) == "table" then
			for _, packageDatas in pairs(data.pack) do
				local packageData = packageDatas[tostring((deviceInfo and deviceInfo.cpuType or nil) and deviceInfo.cpuType)]

				for _, v in pairs(packageData) do
					local tempfile = writablePath .. parsePackNameByUrl(v.url)
					local receivedSize = downloader:getTotalBytesReceivedByStoragePath(tempfile)

					ret = ret + receivedSize
				end
			end
		end

		return ret
	end

	local function sendStatistic(content)
		trycall(function()
			StatisticSystem:send(content)
		end)
	end

	local function recordStatistic(content)
		trycall(function()
			StatisticSystem:record(content)
		end)
	end

	function GameUpdater:getPackTotalSize()
		return packTotalSize
	end

	function GameUpdater:new()
		local result = setmetatable({}, {
			__index = GameUpdater
		})

		result:initialize()

		return result
	end

	function GameUpdater:initialize()
		self._downloader = Downloader:getInstance()
		self._assetsManager = app:getAssetsManager()
		self._versionChecker = VersionChecker:new()
		self._delegate = GameUpdaterDelegate:new()

		if self._versionChecker then
			self._versionChecker:setDelegate(self._delegate)
		end

		IS_FORCE_UPDATE = false
		self._targetVersion = 0
	end

	function GameUpdater:isAllDownloadFinish()
		for index, package in ipairs(packages) do
			if package:getStatus() ~= PkgStatus.kDownloadFinsh then
				return false
			end
		end

		return true
	end

	function GameUpdater:hasDownloadingTask()
		for index, package in ipairs(packages) do
			if package:getStatus() == PkgStatus.kDownloading or package:getStatus() == PkgStatus.kWait then
				return true
			end
		end

		return false
	end

	function GameUpdater:delayCallByTime(delayMilliseconds, func, ...)
		assert(func ~= nil, "delayCallByTime: func is nil")

		local callFunc = func
		local arglist = {
			n = select("#", ...),
			...
		}
		local animTickEntry

		local function timeUp(time)
			if animTickEntry ~= nil then
				cc.Director:getInstance():getScheduler():unscheduleScriptEntry(animTickEntry)

				animTickEntry = nil

				if arglist ~= nil and arglist.n > 0 then
					callFunc(unpack(arglist, 1, arglist.n))
				else
					callFunc()
				end
			end
		end

		local delay = (delayMilliseconds or 0) * 0.001

		animTickEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(timeUp, delay, false)

		return animTickEntry
	end

	function GameUpdater:installPackages()
		if self._assetsManager == nil or self._assetsManager.installAssetsPackage == nil then
			GameUpdaterDebuger:print("AssetsManager is nil or installAssetsPackage is nil")

			return
		end

		installVersionsIndex = installVersionsIndex + 1

		local pkgPaths = installVersionsInfo[installVersionsIndex]

		dump(pkgPaths, "安装更新包installAssetsPackage pkgPaths:")
		dump(installVersionsInfo, "安装更新包installAssetsPackage installVersionsInfo:")
		dump(installVersionsIndex, "安装更新包installAssetsPackage installVersionsIndex:")
		self._assetsManager:installAssetsPackage(pkgPaths, 50, true, function(event, details)
			dump(details, "details:")

			local jsonData = cjson.decode(details)

			if event == "started" then
				for _, detail in ipairs(jsonData) do
					local id = detail.id
					local pkg = detail.pkg

					for _, package in pairs(packages) do
						if package:getPath() == pkg then
							package:setPackageId(id)
						end
					end
				end

				if self._delegate and self._delegate.onInstallPackage then
					self._delegate:onInstallPackage(event, details)
				end

				if PlatformHelper then
					PlatformHelper:reportByUpdate("gameResDecBegin", "http://cdn.dpstorm.com")
				end
			elseif event == "completed" then
				self._updateExtCache = self._updateExtCache or {}

				local cjson = require("cjson.safe")
				local updateCfgPath = writablePath .. "updateExt"
				local updateExtDistPath = writablePath .. "updateExtDist"

				if fileUtils:isFileExist(updateCfgPath) then
					if not fileUtils:isFileExist(updateExtDistPath) then
						app.copyFile(updateCfgPath, updateExtDistPath)
					else
						local distData = cjson.decode(fileUtils:getStringFromFile(updateExtDistPath))
						local srcData = cjson.decode(fileUtils:getStringFromFile(updateCfgPath))

						for _, item in ipairs(srcData.data) do
							if self._updateExtCache[item[1]] then
								local index = self._updateExtCache[item[1]]

								self._updateExtCache[index] = item
							else
								distData.data[#distData.data + 1] = item
								self._updateExtCache[item[1]] = #distData.data
							end
						end

						io.writefile(updateExtDistPath, cjson.encode(distData), "w+")
					end
				end

				local socket = require("socket")
				local t = math.floor(socket.gettime() * 1000)
				local content = {
					point = "update_install_finish",
					type = "updateflow",
					targetVersion = self._targetVersion,
					costTime = t - self._updateStartTime
				}

				sendStatistic(content)

				local pkgPathsTable = string.split(pkgPaths, ";")

				for _, v in pairs(pkgPathsTable) do
					fileUtils:removeFile(v)
				end

				dump(jsonData.version, "switchVersion:")
				self._assetsManager:switchAssetsVersion(tonumber(jsonData.version))

				if fileUtils then
					fileUtils:removeDirectory(writablePath .. PATCH_FOLDER)
					fileUtils:createDirectory(patch_path)
					app.getPatchManager():switchPatch(tostring(0))
					fileUtils:purgeCachedEntries()
				end

				local updateConfigDBPath = fileUtils:fullPathForFilename("gameUpdateConfig.db")
				local destDBFilePath = writablePath .. "gameConfig.db"
				local backupDBPath = writablePath .. "gameConfig_backup.db"
				local tempUpdateDBPath = writablePath .. "gameConfig_temp.db"

				DataReader:cleanCache()
				DBReader:getInstance(true)
				fileUtils:removeFile(tempUpdateDBPath)

				if fileUtils:isFileExist(backupDBPath) then
					fileUtils:removeFile(destDBFilePath)
					fileUtils:renameFile(backupDBPath, destDBFilePath)
				end

				if fileUtils:isFileExist(updateConfigDBPath) then
					DataReader:cleanCache()

					local errorInfo = ""

					for i = 1, 3 do
						fileUtils:removeFile(tempUpdateDBPath)

						if not copyDB(destDBFilePath, tempUpdateDBPath) then
							return
						end

						errorInfo = DBReader:getInstance(true):mergeDb(tempUpdateDBPath, updateConfigDBPath)

						if #errorInfo == 0 then
							break
						end
					end

					if #errorInfo > 0 then
						function callBack()
							REBOOT()
						end

						local updateNoticPopup = require("dm.UpdateNoticPopup")

						updateNoticPopup:alert({
							msg = DB_MERGE_SPACE_LIMIT,
							callBack = callBack
						})

						return
					end

					fileUtils:removeFile(destDBFilePath)
					fileUtils:renameFile(tempUpdateDBPath, destDBFilePath)
					fileUtils:removeFile(updateConfigDBPath)
					fileUtils:purgeCachedEntries()
					print("*********merge db over*********")
				end

				if self._delegate and self._delegate.onInstallPackage then
					self._delegate:onInstallPackage(event, details)
				end

				if installVersionsIndex >= 1000 or tonumber(#installVersionsInfo) == tonumber(installVersionsIndex) then
					local socket = require("socket")
					local t = math.floor(socket.gettime() * 1000)
					local content = {
						point = "update_finish",
						type = "updateflow",
						targetVersion = self._targetVersion,
						costTime = t - self._updateStartTime
					}

					if PlatformHelper then
						PlatformHelper:reportByUpdate("gameResDecSuccess", "http://cdn.dpstorm.com")
					end

					StatisticSystem:send(content)

					if self._delegate and self._delegate.onUpdateFinish then
						dump(installVersionsInfo, "安装全部更新包完成installVersionsInfo:")
						dump(installVersionsIndex, "安装全部更新包完成installVersionsIndex:")
						self._delegate:onUpdateFinish()
					end
				else
					self._installTask = self:delayCallByTime(0, function()
						if self._installTask then
							self._installTask = nil

							dump(installVersionsIndex, "继续安装包installVersionsIndex:")
							dump(installVersionsInfo, "继续安装包installVersionsInfo:")
							self:installPackages()
						end
					end)
				end
			elseif event == "failed" then
				local content = {
					point = "update_install_failed",
					type = "otherflow"
				}

				sendStatistic(content)

				if PlatformHelper then
					PlatformHelper:reportByUpdate("gameResDecError", "http://cdn.dpstorm.com")
				end

				local installErrorText = "install error text: {\n" .. tostring(details) .. "}\n"
				local packageInfos = dumpPackageInfos(packages) or ""

				installErrorText = installErrorText .. packageInfos .. "\n"

				if app and app.args and app.args.bootTimes then
					installErrorText = installErrorText .. "boot times: " .. tostring(app.args.bootTimes) .. "\n"
				end

				local removedErrorPackage = "removedErrorPackage--->:"
				local taskId = jsonData.task

				for _, package in pairs(packages) do
					if package:getPackageId() == taskId then
						if fileUtils:isFileExist(package:getPath()) then
							removedErrorPackage = "real remove error package: " .. tostring(package:getPath()) .. "\n"
						end

						installErrorText = installErrorText .. removedErrorPackage

						fileUtils:removeFile(package:getPath())
						fileUtils:removeFile(package:getPath() .. ".tmp")
					end
				end

				installErrorText = installErrorText .. removedErrorPackage .. "handle install error finish"

				dump(installErrorText, "installErrorText--->")

				local content = {
					type = "CheckInstallError",
					version = (app and app.getAssetsManager and app.getAssetsManager().getCurrentVersion or nil) and app.getAssetsManager():getCurrentVersion(),
					info = installErrorText
				}

				recordStatistic(LogType.kClient, content)

				if self._delegate and self._delegate.onInstallPackage then
					self._delegate:onInstallPackage(event, details)
				end
			end
		end)
	end

	function GameUpdater:downloadResPack(package)
		if package == nil then
			return
		end

		if self._downloader == nil then
			GameUpdaterDebuger:print("downloader is nil")

			return
		end

		local function retry(package)
			package:resetCdnIndex()

			local curDownloadUrl = package:getCurDownloadUrl()

			if curDownloadUrl then
				local downloadTaskInfo = package:getDownloadTaskInfo()

				downloadTaskInfo.srcUrl = curDownloadUrl

				package:setDownloadTaskInfo(downloadTaskInfo)
				package:setStatus(PkgStatus.kDownloading)
				self._downloader:addDownloadTask(downloadTaskInfo)
			end
		end

		local function clearErrorPackage()
			for index, package in ipairs(packages) do
				local pkgPath = package:getPath()

				if pkgPath then
					if package:getStatus() == PkgStatus.kDownloadFail then
						local errorCode = package:getErrorCode()

						if not inRetainTmpList(errorCode) then
							fileUtils:removeFile(pkgPath .. ".tmp")
						end
					elseif package:getStatus() == PkgStatus.kDownloadDamage then
						fileUtils:removeFile(pkgPath)
					end
				end
			end
		end

		local function onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
			if self._delegate and self._delegate.onTaskProgress then
				self._delegate:onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
			end
		end

		local function onFileTaskSuccess(task)
			if self._delegate and self._delegate.onFileTaskSuccess then
				self._delegate:onFileTaskSuccess(task)
			end

			local fileMd5

			if table.nums(packages) > 1 and package:getSize() < kHorizonSize then
				local content = fileUtils:getStringFromFile(package:getPath())

				fileMd5 = crypto.md5(content)

				package:setRealMd5(fileMd5)
			end

			if fileMd5 and package:getMd5() and package:getMd5() ~= fileMd5 then
				local content = {
					point = "update_download_pkg_damage",
					type = "otherflow"
				}

				sendStatistic(content)
				package:setStatus(PkgStatus.kDownloadDamage)
			else
				package:setStatus(PkgStatus.kDownloadFinsh)
			end

			if self:isAllDownloadFinish() then
				local socket = require("socket")
				local t = math.floor(socket.gettime() * 1000)
				local content = {
					point = "update_download_finish",
					type = "updateflow",
					targetVersion = self._targetVersion,
					costTime = t - self._updateStartTime
				}

				sendStatistic(content)

				if PlatformHelper then
					PlatformHelper:reportByUpdate("gameUpdateAssetSuccess", "http://cdn.dpstorm.com")
				end

				self:installPackages()
			elseif not self:hasDownloadingTask() then
				clearErrorPackage()

				if self._delegate and self._delegate.onDownloadError then
					self._delegate:onDownloadError()
				end
			end
		end

		local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
			package:switchCdn()

			local curDownloadUrl = package:getCurDownloadUrl()

			if curDownloadUrl then
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

				if not self:hasDownloadingTask() then
					clearErrorPackage()

					if self._delegate and self._delegate.onTaskError then
						self._delegate:onTaskError(task, errorCode, errorCodeInternal, errorStr)
					end
				end
			end
		end

		local destPath = package:getPath()
		local curDownloadUrl = package:getCurDownloadUrl()
		local taskInfo = {
			type = "file",
			identifier = curDownloadUrl,
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
			self._downloader:addDownloadTask(taskInfo)
		end
	end

	function GameUpdater:run(callback)
		local assetsDBFilePath = writablePath .. ASSETS_DB_FILE

		if not fileUtils:isFileExist(assetsDBFilePath) then
			GameUpdaterDebuger:print("can not find \"assets.db\" file, so excute ' no need update '")
			self:excuteNoUpdateCmd()

			if callback then
				callback()
			end

			return
		end

		if self._versionChecker then
			local curVersion = self._assetsManager:getCurrentVersion()

			GameUpdaterDebuger:print("current package version:%d", tonumber(curVersion))

			local vmsUrl
			local targetV

			if app and app.args and app.args.userData and type(app.args.userData) == "string" then
				local targetVData = cjson.decode(app.args.userData)

				if targetVData and targetVData.targetV then
					targetV = tonumber(targetVData.targetV)
				end
			end

			local content = {
				point = "login_request_vms",
				type = "loginflow"
			}

			sendStatistic(content)
			self._versionChecker:vmsRequest((app.pkgConfig and app.pkgConfig.captainUrl and app.pkgConfig.captainUrl ~= "" or nil) and app.pkgConfig.captainUrl, curVersion, targetV, function(errorCode, httpData)
				if errorCode == 200 then
					if httpData and httpData.ret then
						if httpData.data then
							if httpData.data.targetV then
								self._targetVersion = tonumber(httpData.data.targetV)
							end

							if httpData.data.webApiRoot then
								GameConfigs.webApiRoot = httpData.data.webApiRoot
							end

							if httpData.data.switchConfig and type(httpData.data.switchConfig) == "table" then
								for k, v in pairs(httpData.data.switchConfig) do
									GameConfigs[tostring(k)] = v
								end
							end

							local extraCdnUrl = httpData.data.extraCdnUrl

							_G.CDN_URLS = {
								httpData.data.cdnUrl
							}

							if extraCdnUrl and extraCdnUrl ~= "" then
								table.insert(_G.CDN_URLS, extraCdnUrl)
							end

							self:excuteCommandByCmd(httpData.ret, httpData.data)

							if callback then
								callback()
							end
						else
							GameUpdaterDebuger:print("httpData.data is nil, so excute ' no need update '")
							self:excuteNoUpdateCmd(nil)
						end
					else
						GameUpdaterDebuger:print("httpData.ret is nil, so excute ' no need update '")
						self:excuteNoUpdateCmd(nil)
					end
				else
					GameUpdaterDebuger:print("vmsRequest reponse statusCode is not 200, so excute ' no need update '")
				end
			end)
		end
	end

	function GameUpdater:setCallback(callback)
		if self._delegate then
			self._delegate:setCallback(callback)
		end
	end

	function GameUpdater:excuteCommandByCmd(retCode, data)
		if type(retCode) == "number" and retCode == 0 then
			local content = {
				point = "patch_start",
				type = "patchflow"
			}

			StatisticSystem:send(content)
			self:excutePatchCmd(data, function(isReboot)
				local content = {
					point = "patch_finish",
					type = "patchflow"
				}

				StatisticSystem:send(content)
				self:excuteNoUpdateCmd(isReboot)
			end)
		elseif type(retCode) == "number" and retCode == 1 then
			packTotalSize = calculatePackSize(data)

			if self._delegate and self._delegate.onEnsureUpdate then
				self._delegate:onEnsureUpdate(packTotalSize, calculateAlreadyDownloadSize(data, self._downloader), data)
			else
				self:excuteUpdateCmd(data)
			end
		elseif type(retCode) == "number" and retCode == 2 then
			if self._delegate and self._delegate.onMaintain then
				self._delegate:onMaintain(data.notice)
			end
		elseif type(retCode) == "number" and retCode == 3 then
			IS_FORCE_UPDATE = true

			if self._delegate and self._delegate.onForceUpdate then
				self._delegate:onForceUpdate()
			end
		else
			self:excuteNoUpdateCmd(data)
		end
	end

	function GameUpdater:excuteNoUpdateCmd(data)
		if self._delegate and self._delegate.onNoUpdate then
			self._delegate:onNoUpdate(data)
		end
	end

	function GameUpdater:excutePatchCmd(data, callback)
		dump(data, "patch data")

		if not data and callback then
			callback(false)

			return
		end

		if (not data.patchInfo or not data.patchInfo.patch or not data.patchInfo.patchVersion) and callback then
			callback(false)

			return
		end

		local patch_path = writablePath .. PATCH_FOLDER

		if not cc.FileUtils:getInstance():isDirectoryExist(patch_path) then
			cc.FileUtils:getInstance():createDirectory(patch_path)
		end

		local deviceInfo = app.getDevice():getDeviceInfo()
		local patch = data.patchInfo.patch[tostring((deviceInfo and deviceInfo.cpuType or nil) and deviceInfo.cpuType)]
		local patchSubVersion = data.patchInfo.patchVersion
		local patchManager
		local currentPatchVersion = "0"

		if app and app.getPatchManager then
			patchManager = app.getPatchManager()
			currentPatchVersion = patchManager:getCurrentPatchVersion()
		elseif callback then
			callback(false)

			return
		end

		if tostring(patchSubVersion) == "0" then
			if patchManager then
				patchManager:switchPatch(tostring(patchSubVersion))
				patchManager:commitPatchRecord()
			end

			if callback then
				callback(currentPatchVersion ~= "0" and currentPatchVersion ~= "")
			end

			return
		end

		if patch == nil and tostring(patchSubVersion) ~= "0" then
			if patchManager then
				patchManager:switchPatch(tostring(patchSubVersion))
				patchManager:commitPatchRecord()
			end

			if callback then
				callback(true)
			end

			return
		end

		local function cleanPatch()
			if fileUtils then
				fileUtils:removeDirectory(patch_path)
				fileUtils:createDirectory(patch_path)
			end

			patchManager:switchPatch(tostring(0))

			if callback then
				callback(false)
			end
		end

		local toDownloadPatchs = {}
		local downloadPatchFinishNumber = 0
		local downloadPatchErrorNumber = 0

		if patch and #patch == 0 and callback then
			callback(false)

			return
		end

		for _, v in pairs(patch) do
			local cdnInfo = {
				data.cdnUrl
			}
			local extraCdnUrl = data.extraCdnUrl

			if extraCdnUrl and extraCdnUrl ~= "" then
				table.insert(cdnInfo, extraCdnUrl)
			end

			local downLoadInfo = {
				index = 1,
				cdnInfo = cdnInfo,
				patchInfo = v
			}
			local patchFile = PatchFile:new(downLoadInfo)

			patchFile:setStoragePath(writablePath .. PATCH_FOLDER .. "/" .. tostring(patchSubVersion) .. "/" .. patchFile:getLogic())
			table.insert(toDownloadPatchs, patchFile)
		end

		dump("check local paths start-------->")

		local localPatchCorrect = true

		for _, v in pairs(toDownloadPatchs) do
			if not fileUtils:isFileExist(v:getStoragePath()) then
				if fileUtils:isFileExist(v:getStoragePath() .. ".done") then
					local content = fileUtils:getStringFromFile(v:getStoragePath() .. ".done")

					if tostring(content) == tostring(v:getMd5()) and tostring(content) ~= "" then
						dump(v, "local patch correct success------->")
					else
						localPatchCorrect = false

						dump(v, "local patch md5 error step1------->")
						dump(patchFileMd5, "local patch md5 error step2------->")
					end
				else
					localPatchCorrect = false

					dump(v, "local patch not exist------->")
				end
			else
				local content = fileUtils:getStringFromFile(v:getStoragePath())
				local patchFileMd5 = crypto.md5(content)

				if tostring(patchFileMd5) == tostring(v:getMd5()) and tostring(patchFileMd5) ~= "" then
					dump(v, "local patch correct success------->")
				else
					localPatchCorrect = false

					dump(v, "local patch md5 error step1------->")
					dump(patchFileMd5, "local patch md5 error step2------->")
				end
			end
		end

		if localPatchCorrect == true then
			if callback then
				callback(false)
			end

			dump(localPatchCorrect, "check local paths end-------->")
			patchManager:switchPatch(tostring(patchSubVersion))

			return
		end

		dump(localPatchCorrect, "check local paths end-------->")

		local function isAllPatchDownloadFinish()
			return downloadPatchFinishNumber + downloadPatchErrorNumber == #toDownloadPatchs
		end

		local function executeDownloadPatch(downloadPatch)
			local function onTaskProgress(task, bytesReceived, totalBytesReceived, totalBytesExpected)
				return
			end

			local function onFileTaskSuccess(task)
				if fileUtils:isFileExist(downloadPatch:getStoragePath()) then
					local content = fileUtils:getStringFromFile(downloadPatch:getStoragePath())
					local patchFileMd5 = crypto.md5(content)

					if tostring(patchFileMd5) == tostring(downloadPatch:getMd5()) and tostring(patchFileMd5) ~= "" then
						downloadPatchFinishNumber = downloadPatchFinishNumber + 1

						fileUtils:removeFile(downloadPatch:getStoragePath() .. ".tmp")
						dump(downloadPatch, "download patch success------>")

						if string.find(downloadPatch:getStoragePath(), ".db", 1, true) then
							fileUtils:writeStringToFile(tostring(patchFileMd5), downloadPatch:getStoragePath() .. ".done")
						end
					else
						downloadPatchErrorNumber = downloadPatchErrorNumber + 1

						dump(downloadPatch, "patch file md5 error-------->")
						dump(patchFileMd5, "patchFileMd5-------->")
					end
				else
					downloadPatchErrorNumber = downloadPatchErrorNumber + 1

					dump(downloadPatch, "patch file is not exist-------->")
				end

				if isAllPatchDownloadFinish() then
					if downloadPatchErrorNumber > 0 then
						dump("onFileTaskSuccess")
						dump(downloadPatchFinishNumber, "downloadPatchFinishNumber")
						dump(downloadPatchErrorNumber, "downloadPatchErrorNumber")
						dump("cleanPatch")
						cleanPatch()

						return
					end

					if patchManager then
						patchManager:switchPatch(tostring(patchSubVersion))

						for _, v in pairs(toDownloadPatchs) do
							patchManager:updatePatchRecord(v:getLogic(), v:getMd5(), v:getUrl(), 0)
						end

						patchManager:commitPatchRecord()
						dump("patch finish")

						local name = ""

						for k, v in pairs(patch) do
							name = string.gsub(v.logic, ".lua", "")
							name = string.gsub(name, "/", ".")

							if string.sub(name, 1, 7) == "script." then
								name = string.sub(name, 8, string.len(name))
							end

							package.loaded[name] = nil
						end

						if callback then
							callback(true)
						end
					end
				end
			end

			local function retryDownloadPatch(retryPatch)
				dump(retryPatch, "retry patch info")
				retryPatch:resetCdnIndex()

				local curDownloadUrl = retryPatch:getCurDownloadUrl()

				if curDownloadUrl then
					local downloadTaskInfo = retryPatch:getDownloadTaskInfo()

					downloadTaskInfo.srcUrl = curDownloadUrl

					retryPatch:setDownloadTaskInfo(downloadTaskInfo)
					self._downloader:addDownloadTask(downloadTaskInfo)
				end
			end

			local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
				downloadPatch:switchCdn()

				local curDownloadUrl = downloadPatch:getCurDownloadUrl()

				if curDownloadUrl then
					local downloadTaskInfo = downloadPatch:getDownloadTaskInfo()

					downloadTaskInfo.srcUrl = curDownloadUrl

					downloadPatch:setDownloadTaskInfo(downloadTaskInfo)
					self._downloader:addDownloadTask(downloadTaskInfo)
				elseif downloadPatch:getRetryCount() < kDownloadRetryMax then
					downloadPatch:setRetryCount(downloadPatch:getRetryCount() + 1)
					retryDownloadPatch(downloadPatch)
				else
					downloadPatchErrorNumber = downloadPatchErrorNumber + 1

					if isAllPatchDownloadFinish() and downloadPatchErrorNumber > 0 then
						dump("onTaskError")
						dump(downloadPatchFinishNumber, "downloadPatchFinishNumber")
						dump(downloadPatchErrorNumber, "downloadPatchErrorNumber")
						dump("cleanPatch")
						cleanPatch()

						return
					end
				end
			end

			local head, _ = fileUtils:splitPath(downloadPatch:getStoragePath())

			if not fileUtils:isDirectoryExist(head) then
				fileUtils:createDirectory(head)
			end

			local taskInfo = {
				type = "file",
				identifier = downloadPatch:getStoragePath(),
				srcUrl = downloadPatch:getCurDownloadUrl(),
				storagePath = downloadPatch:getStoragePath(),
				onTaskProgress = onTaskProgress,
				onFileTaskSuccess = onFileTaskSuccess,
				onTaskError = onTaskError
			}

			downloadPatch:setDownloadTaskInfo(taskInfo)
			self._downloader:addDownloadTask(taskInfo)
		end

		for _, v in pairs(toDownloadPatchs) do
			executeDownloadPatch(v)
		end
	end

	function GameUpdater:excuteUpdateCmd(data)
		local socket = require("socket")

		self._updateStartTime = math.floor(socket.gettime() * 1000)

		local content = {
			costTime = 0,
			point = "update_start",
			type = "updateflow",
			targetVersion = self._targetVersion
		}

		sendStatistic(content)

		if PlatformHelper then
			PlatformHelper:reportByUpdate("gameUpdateAssetBegin", "http://cdn.dpstorm.com")
		end

		local deviceInfo = app.getDevice():getDeviceInfo()

		if data and data.pack and type(data.pack) == "table" then
			local packTable = data.pack

			if self._delegate and self._delegate.onUpdate then
				self._delegate:onUpdate()
			end

			packages = {}
			installVersionsInfo = {}
			installVersionsIndex = 0

			for index, packageDatas in pairs(packTable) do
				local packagesData = packageDatas[tostring((deviceInfo and deviceInfo.cpuType or nil) and deviceInfo.cpuType)]
				local pkgPaths = {}

				for _, v in pairs(packagesData) do
					local packName = parsePackNameByUrl(v.url)

					if packName == nil then
						if self._delegate and self._delegate.onUpdateFinish then
							self._delegate:onUpdateFinish()
						end

						return
					end

					local cdnInfo = {}

					cdnInfo[#cdnInfo + 1] = data.cdnUrl

					local extraCdnUrl = data.extraCdnUrl

					if extraCdnUrl and extraCdnUrl ~= "" then
						cdnInfo[#cdnInfo + 1] = extraCdnUrl
					end

					local packageInfo = {
						cdnUrl = cdnInfo,
						url = v.url,
						packName = packName,
						size = v.size,
						md5 = v.hash
					}
					local package = UpdatePackage:new(packageInfo)

					packages[#packages + 1] = package
					pkgPaths[#pkgPaths + 1] = package:getPath()
				end

				installVersionsInfo[tonumber(index)] = table.concat(pkgPaths, ";")
			end

			dump(packages, "下载包packages信息:")
			dump(installVersionsInfo, "安装包paths信息:")
			dump(installVersionsIndex, "安装包installVersionsIndex信息:")

			for k, v in pairs(packages) do
				self:downloadResPack(v)
			end
		elseif self._delegate and self._delegate.onUpdateError then
			self._delegate:onUpdateError()
		end
	end

	function GameUpdater:getTargetVersion()
		return self._targetVersion
	end
end
