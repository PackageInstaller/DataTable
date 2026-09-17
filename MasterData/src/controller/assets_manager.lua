local var_0_0 = {}
local assets_download_event = require("controller.updatemodule.assets_download_event")
local assets_downloader = require("controller.updatemodule.assets_downloader")
local var_0_3 = 1048576
local var_0_4 = 0
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3

var_0_0.updateRef = nil
var_0_0.downloader = nil
var_0_0.loginimg = nil
var_0_0.downloadQueue = {}
var_0_0.downloadInfo = {}

function var_0_0.onEnter(arg_1_0, arg_1_1)
	arg_1_0.updateRef = arg_1_1
end

function var_0_0:onExit()
	self.updateRef = nil

	if self.downloader then
		self.downloader:release()

		self.downloader = nil
	end

	self:unregisterDownloadEvent()
end

function var_0_0:checkUpdate()
	self:checkGameAssets()
end

function var_0_0:checkGameAssets()
	self:checkDataAssets()
	self:checkAntiHexieAssets()
	self:checkVideoAssets()
	self:checkBugFixAssets()

	if config._UPDATE then
		self:checkGameVersion()
	else
		self:genUpdateInfo()
	end
end

function var_0_0:checkDataAssets()
	if DeviceManager.platform == "windows" then
		return
	end

	if tonumber(DeviceManager.getPackageAssetsVersion()) < 65 then
		return
	end

	if cc.FileUtils:getInstance():isFileExist("downloaddata.txt") then
		return
	end

	if DeviceManager.platform == "android" then
		if cc.Native.getArchVersion and cc.Native:getArchVersion() == "64" then
			self:insertDownloadQueue(nil, string.format("https://download9.h-college.com/download/v%s/data64.zip", DeviceManager.getPackageAssetsVersion()), 150 * var_0_3)
		else
			self:insertDownloadQueue(nil, string.format("https://download9.h-college.com/download/v%s/data.zip", DeviceManager.getPackageAssetsVersion()), 150 * var_0_3)
		end
	else
		self:insertDownloadQueue(nil, string.format("https://download9.h-college.com/download/v%s/dataios.zip", DeviceManager.getPackageAssetsVersion()), 150 * var_0_3)
	end
end

function var_0_0:checkAntiHexieAssets()
	if DeviceManager.platform == "windows" then
		return
	end

	if cc.Native.useAntiHexieResource then
		if cc.Native:useAntiHexieResource() then
			return
		end
	elseif tonumber(DeviceManager.getPackageAssetsVersion()) >= 28 then
		return
	end

	if not cc.UserDefault:getInstance():getBoolForKey("antihexie", false) then
		return
	end

	if cc.FileUtils:getInstance():isFileExist("antihexie/antiassets.txt") then
		return
	end

	self:insertDownloadQueue(nil, string.format("http://download9.h-college.com/antihexie/v%s/antiassets.zip", DeviceManager.getPackageAssetsVersion()), 270 * var_0_3)
end

function var_0_0:checkVideoAssets()
	if DeviceManager.platform == "windows" then
		return
	end

	if cc.FileUtils:getInstance():isFileExist("video/pv_B0.mp4") then
		return
	end

	if cc.FileUtils:getInstance():isFileExist("localvideo/video/pv_B0.mp4") then
		return
	end

	self:insertDownloadQueue(nil, "https://download9.h-college.com/download/video.zip", 15 * var_0_3)
end

function var_0_0.checkBugFixAssets(arg_8_0)
	return
end

function var_0_0.checkGameVersion(arg_9_0)
	local var_9_0 = DeviceManager.createHTTPRequest(function(arg_10_0)
		local var_10_0 = arg_10_0.request

		if arg_10_0.name ~= "completed" then
			return
		end

		if var_10_0:getResponseStatusCode() ~= 200 then
			return
		end

		arg_9_0:dealGameVersionInfo(json.decode((var_10_0:getResponseString())))
	end, "https://horcrux.aojiaostudio.com/update", "POST")

	var_9_0:setTimeout(35)

	local var_9_1 = {
		channel = DeviceManager.getChannelID(),
		clientversion = config.version,
		device = DeviceManager.getDeviceID(),
		clientbranch = config.clientbranch,
		platform = DeviceManager.platform
	}

	if cc.Native.getVersionCode then
		var_9_1.versioncode = cc.Native:getVersionCode()
	end

	var_9_0:setPOSTData(json.encode(var_9_1))
	var_9_0:start()
end

function var_0_0:dealGameVersionInfo(arg_11_1)
	if arg_11_1.sys_conf then
		if arg_11_1.sys_conf.close.errcode ~= 0 then
			self.updateRef:onSystemClose(arg_11_1.sys_conf.close)

			return
		end

		self.loginimg = arg_11_1.sys_conf.loginimg
	end

	if arg_11_1.errcode == var_0_5 then
		self:genGameUpdateVersions(arg_11_1.info)
		self:genUpdateInfo()
	elseif arg_11_1.errcode == var_0_6 then
		self.updateRef:onNewClient(arg_11_1.downloadpath)
	elseif arg_11_1.errcode == var_0_7 then
		self:genGameUpdateVersions(arg_11_1.info)
		self:genUpdateInfo()
	else
		self:genUpdateInfo()
	end
end

function var_0_0:genGameUpdateVersions(arg_12_1)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1.versions) do
		self:insertDownloadQueue(iter_12_1[1], arg_12_1.downloadpath, iter_12_1[2])
	end
end

local function var_0_8(arg_13_0, arg_13_1)
	local var_13_0, var_13_1, var_13_2, var_13_3 = string.match(arg_13_1, "(%d+).(%d+).(%d+).(%d+)")

	if DeviceManager.platform == "android" then
		if cc.Native.getArchVersion and cc.Native:getArchVersion() == "64" then
			return string.format("%s%s%s_%s_%s_64.zip", arg_13_0, var_13_0, var_13_1, var_13_2, var_13_3)
		else
			return string.format("%s%s%s_%s_%s.zip", arg_13_0, var_13_0, var_13_1, var_13_2, var_13_3)
		end
	else
		return string.format("%s%s%s_%s_%s.zip", arg_13_0, var_13_0, var_13_1, var_13_2, var_13_3)
	end
end

function var_0_0:insertDownloadQueue(arg_14_1, arg_14_2, arg_14_3)
	if type(arg_14_2) ~= "table" then
		arg_14_2 = {
			arg_14_2
		}
	end

	local var_14_0 = {}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_2) do
			table.insert(var_14_0, var_0_8(string.urldecode(iter_14_1), arg_14_1))
		end
	else
		for iter_14_2, iter_14_3 in ipairs(arg_14_2) do
			table.insert(var_14_0, string.urldecode(iter_14_3))
		end
	end

	table.insert(self.downloadQueue, {
		version = arg_14_1,
		downloadpath = var_14_0,
		size = arg_14_3
	})
end

function var_0_0:genUpdateInfo()
	self:resetDownloadInfo()

	if #self.downloadQueue > 0 then
		for iter_15_0, iter_15_1 in ipairs(self.downloadQueue) do
			self.downloadInfo.totalsize = self.downloadInfo.totalsize + iter_15_1.size
			self.downloadInfo.packagecount = self.downloadInfo.packagecount + 1
		end

		self.updateRef:onNeedUpdate(self.downloadInfo.totalsize)
	else
		self.updateRef:onNoNewVersion()
	end

	local var_15_1 = math.floor((self.downloadInfo.totalsize - ((not cc.FileUtils:getInstance():isFileExist("downloaddata.txt") or nil) and 150 * var_0_3)) / var_0_3)
	local var_15_2 = "start_game_download_check"
	local var_15_3 = {}

	var_15_3.need_downloaddata = not cc.FileUtils:getInstance():isFileExist("downloaddata.txt")
	var_15_3.need_hotpatch = var_15_1 > 0
	var_15_3.hotpatch_size = var_15_1

	self:pushThinkingDataCilent(var_15_2, var_15_3)
end

function var_0_0:resetDownloadInfo()
	self.downloadInfo.totalsize = 0
	self.downloadInfo.havedownloaded = 0
	self.downloadInfo.packagecount = 0
	self.downloadInfo.downloadedpackage = 0
end

function var_0_0:initDownload()
	self:registerDownloadEvent()
end

function var_0_0:registerDownloadEvent()
	assets_download_event:register(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_SUCCESS, self, self.onDownloadSuccess)
	assets_download_event:register(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_PROCESS, self, self.onDownloadProgress)
	assets_download_event:register(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_ERROR, self, self.onDownloadError)
end

function var_0_0:unregisterDownloadEvent()
	assets_download_event:unregister(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_SUCCESS, self.onDownloadSuccess)
	assets_download_event:unregister(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_PROCESS, self.onDownloadProgress)
	assets_download_event:unregister(assets_download_event.EVENTID.ASSETS_DOWNLOAD_EVENT_ERROR, self.onDownloadError)
end

function var_0_0:onDownloadSuccess(arg_20_1)
	local var_20_0 = self:getCurrentDownloadInfo()

	if var_20_0.version ~= arg_20_1 then
		print("Version Error!!!!!!!!!!!!!!!!!!!!")
	end

	self.downloadInfo.havedownloaded = self.downloadInfo.havedownloaded + var_20_0.size
	self.downloadInfo.downloadedpackage = self.downloadInfo.downloadedpackage + 1

	if self:haveNextDownloadInfo() then
		self.updateRef:onUpdateProgress(self.downloadInfo.havedownloaded * 100 / self.downloadInfo.totalsize)
		self.downloader:stop()

		local var_20_1 = self:getCurrentDownloadInfo()

		self.downloader:start(var_20_1.version, var_20_1.downloadpath)
	else
		self.updateRef:onUpdateSuccess()
	end
end

function var_0_0:onDownloadProgress(arg_21_1)
	local var_21_0 = (self.downloadInfo.havedownloaded + self:getCurrentDownloadInfo().size * arg_21_1 / 100) * 100 / self.downloadInfo.totalsize

	if var_21_0 < 0 then
		return
	end

	self.updateRef:onUpdateProgress(var_21_0)
end

function var_0_0:onDownloadError(arg_22_1)
	self.downloader:stop()
	self.updateRef:onUpdateError(arg_22_1)
end

function var_0_0:getCurrentDownloadInfo()
	return self.downloadQueue[self.downloadInfo.downloadedpackage + 1]
end

function var_0_0:haveNextDownloadInfo()
	return self.downloadQueue[self.downloadInfo.downloadedpackage + 1] ~= nil
end

function var_0_0:update()
	self.downloader = assets_downloader.new()

	local var_25_0 = self:getCurrentDownloadInfo()

	self.downloader:start(var_25_0.version, var_25_0.downloadpath)
end

function var_0_0.setTimeOut(arg_26_0, ...)
	return
end

function var_0_0.onServerCheckOrder()
	local var_27_0 = DeviceManager.createHTTPRequest(function(arg_28_0)
		local var_28_0 = arg_28_0.request

		if arg_28_0.name ~= "completed" then
			return
		end

		if var_28_0:getResponseStatusCode() ~= 200 then
			return
		end

		if json.decode((var_28_0:getResponseString())).errcode ~= var_0_4 then
			global_logout(5)
		end
	end, config.updateurl, "POST")

	var_27_0:setTimeout(35)
	var_27_0:setPOSTData(json.encode({
		channel = DeviceManager.getChannelID(),
		clientversion = config.version,
		device = DeviceManager.getDeviceID(),
		clientbranch = config.clientbranch
	}))
	var_27_0:start()
end

function var_0_0.pushThinkingDataCilent(arg_29_0, arg_29_1, arg_29_2)
	if not config.packagechannel == "feiyu" then
		return
	end

	if DeviceManager.getPackageChannel() == "aoki" then
		if arg_29_1 == "start_game_download_check" then
			SDKManager.pushAokiEvent(0)
		elseif arg_29_1 == "finish_download" then
			SDKManager.pushAokiEvent(1)
		end
	end

	local uuid4 = require("controller.uuid4")

	arg_29_2 = arg_29_2 or {}
	arg_29_2.event = arg_29_1
	arg_29_2.openid = DeviceManager.getDeviceID()
	arg_29_2.nickname = "unknow"
	arg_29_2.uuid = uuid4:getUUID()
	arg_29_2.timestamp = os.time()
	arg_29_2.channel = DeviceManager:getChannelID()
	arg_29_2.appid = "horcrux"

	local account_manager = require("controller.account_manager")

	if account_manager.getTapadid then
		local var_29_2 = account_manager:getTapadid()
		local var_29_3

		if var_29_2 then
			arg_29_2.oaid = var_29_2
			var_29_3 = json.encode(arg_29_2)
		end
	end

	local var_29_4 = require("controller.sha256").hmac_sha256("jPRt2ZM54YnU9Spd", var_29_3)
	local var_29_5 = DeviceManager.createHTTPRequest(function(arg_30_0)
		local var_30_0 = arg_30_0.request

		if arg_30_0.name ~= "completed" then
			return
		end

		local var_30_1 = var_30_0:getResponseStatusCode()
		local var_30_2 = var_30_0:getResponseString()
	end, "https://matrix-report.aojiaostudio.com/log", "POST")

	var_29_5:setTimeout(35)
	var_29_5:addRequestHeader("X-Authorization: " .. var_29_4)
	var_29_5:setPOSTData(var_29_3)
	var_29_5:start()
end

return var_0_0
