local var_0_0 = {}
local file_check_manager = require("controller.filedownloader.file_check_manager")
local auto_download_helper = require("controller.filedownloader.auto_download_helper")
local var_0_3 = cc.Downloader:getInstance()
local var_0_4 = cc.FileUtils:getInstance()
local var_0_5 = 1
local var_0_6 = 2
local var_0_7 = 3
local var_0_8 = 4
local var_0_9 = 0
local var_0_13 = 5
local var_0_14 = 5 * 3
local var_0_15 = 10
local var_0_16 = 10
local manual_download_queue = require("controller.filedownloader.queues.manual_download_queue")
local var_0_18 = manual_download_queue.new()
local var_0_19 = manual_download_queue.new()
local var_0_20 = manual_download_queue.new()
local var_0_21 = require("controller.filedownloader.queues.auto_download_queue").new()
local var_0_22
local download_l2d_helper = require("controller.filedownloader.download_l2d_helper")
local download_queue = require("controller.filedownloader.queues.download_queue")

local function var_0_25(arg_1_0)
	local var_1_0, var_1_1, var_1_2, var_1_3 = arg_1_0:match("(%d+).(%d+).(%d+).(%d+)")

	if GAME_STORAGE_FOLDER then
		return string.format("%s/v%s%s", GAME_STORAGE_FOLDER, var_1_0, var_1_1)
	else
		return string.format("v%s%s", var_1_0, var_1_1)
	end
end

local function var_0_26()
	return var_0_4:getWritablePath() .. "/" .. var_0_25(config.version)
end

var_0_0._scheduler = nil
var_0_0._writeablepath = nil

function var_0_0:init()
	require("view.Sprite.NodeDownload.SpriteDownload")
	require("view.Sprite.NodeDownload.ButtonDownload")
	require("view.Sprite.NodeDownload.LayoutDownload")
	require("view.Sprite.NodeDownload.ImageViewDownload")

	self._writeablepath = var_0_26()
	self._working = false

	var_0_3:setMaxProcessingTasks(var_0_13)
	var_0_3:setStoragePath(self._writeablepath)
	self:registerDownloadListener()
	self:initAutoDownloadPool()
	self:startDownloadScheduler()
end

function var_0_0.initAutoDownloadPool(arg_4_0)
	auto_download_helper:push_assets_to_downloadqueue(var_0_21)
end

function var_0_0:startDownloadScheduler()
	if not self._scheduler then
		self._scheduler = cc.Director:getInstance():getScheduler():scheduleScriptFunc(function(arg_6_0)
			self:onScheduler(arg_6_0)
		end, 0.1, false)
		self._working = true
	end
end

function var_0_0:stopDownloadScheduler()
	if self._scheduler then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self._scheduler)

		self._scheduler = nil
		self._working = false
	end
end

function var_0_0:insertDownloadTasks(arg_8_1, arg_8_2)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if not download_queue[iter_8_1.filename] then
			table.insert(var_8_0, iter_8_1)
		end
	end

	if download_queue:getCount() < var_0_14 and self._working then
		self:addDownloadTaskToQueue(var_8_0, true)
	else
		self:insertManualDownloadPool(var_8_0, arg_8_2)
	end
end

function var_0_0:addNormalDownloadTaskToQueue(arg_9_1, arg_9_2)
	if file_check_manager:isFileExist(arg_9_1.filename) then
		var_0_19:onFileDownloadComplete(arg_9_1.filename)
		var_0_20:onFileDownloadComplete(arg_9_1.filename)
		var_0_21:onFileDownloadComplete(arg_9_1.filename)
		download_l2d_helper:onFileDownloadComplete(arg_9_1.filename)
		file_check_manager:onFileDownloadComplete(arg_9_1.filename)

		if var_0_22 == arg_9_1.filename then
			var_0_22 = nil
		end

		return false
	elseif not download_queue[arg_9_1.filename] then
		download_queue[arg_9_1.filename] = arg_9_1.url

		var_0_3:addDownloadTask(arg_9_1.url, string.format("%s/res/%s", self._writeablepath, arg_9_1.filename), arg_9_2)

		return true
	end
end

function var_0_0:addZipDownloadTaskToQueue(arg_10_1)
	if not download_queue[arg_10_1.filename] then
		download_queue[arg_10_1.filename] = arg_10_1.url

		var_0_3:addDownloadTask(arg_10_1.url, string.format("%s/res/%s", self._writeablepath, arg_10_1.filename))

		return true
	else
		return false
	end
end

function var_0_0:addDownloadTaskToQueue(arg_11_1, arg_11_2)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.filename:find(".zip$") then
			if self:addZipDownloadTaskToQueue(iter_11_1) then
				var_11_0 = true
			end
		elseif self:addNormalDownloadTaskToQueue(iter_11_1, arg_11_2) then
			var_11_0 = true
		end
	end

	if var_11_0 then
		var_0_3:startDownload()
	end
end

function var_0_0.insertManualDownloadPool(arg_12_0, arg_12_1, arg_12_2)
	for iter_12_0, iter_12_1 in ipairs(arg_12_1) do
		local var_12_0 = var_0_20:find(iter_12_1)

		if var_12_0 then
			var_0_20:remove(var_12_0)
		end

		if arg_12_2 == "fight" then
			var_0_18:add(iter_12_1, 1, arg_12_2)
		else
			var_0_18:add(iter_12_1, nil, arg_12_2)
		end
	end
end

function var_0_0.insertAutoDownloadPool(arg_13_0, arg_13_1)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		var_0_19:add(iter_13_1)
	end
end

local function var_0_27(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if arg_14_1 <= 0 then
		return var_14_0
	end

	local var_14_1 = arg_14_0:remove(1)

	while var_14_1 do
		table.insert(var_14_0, var_14_1)

		if arg_14_1 <= #var_14_0 then
			break
		end

		var_14_1 = arg_14_0:remove(1)
	end

	return var_14_0
end

function var_0_0:onScheduler(arg_16_1)
	var_0_16 = var_0_16 - arg_16_1

	if var_0_16 <= 0 then
		file_check_manager:saveDownloadedFileList()

		var_0_16 = var_0_15
	end

	if download_queue:getCount() >= var_0_14 then
		return
	end

	local var_16_0 = {}
	local var_16_1 = var_0_14 - download_queue:getCount()

	if var_0_18:count() > 0 then
		local var_16_2 = var_0_27(var_0_18, var_16_1)

		table.insertto(var_16_0, var_16_2)

		var_16_1 = var_16_1 - #var_16_2
	end

	if var_16_1 > 0 and var_0_19:count() > 0 then
		local var_16_3 = var_0_27(var_0_19, var_16_1)

		table.insertto(var_16_0, var_16_3)

		var_16_1 = var_16_1 - #var_16_3
	end

	if var_16_1 > 0 and var_0_20:count() > 0 then
		local var_16_4 = var_0_27(var_0_20, var_16_1)

		table.insertto(var_16_0, var_16_4)

		var_16_1 = var_16_1 - #var_16_4
	end

	if #var_16_0 < 5 and var_0_22 == nil and download_l2d_helper:canDownload() then
		local var_16_5 = download_l2d_helper:dequeueFromQueueEnd()

		if var_16_5 then
			table.insert(var_16_0, var_16_5)

			var_0_22 = var_16_5.filename
		end
	end

	if #var_16_0 > 0 then
		self:addDownloadTaskToQueue(var_16_0)
	end
end

function var_0_0.onSceneTransaction(arg_17_0)
	if var_0_18:count() <= 0 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs((var_0_18:queryWithFilter({
		filtertype = "besides",
		filters = {
			fight = true,
			retry = true
		}
	}))) do
		var_0_20:add(iter_17_1)
	end

	var_0_18:clearWithFilter({
		filtertype = "besides",
		filters = {
			fight = true,
			retry = true
		}
	})
end

function var_0_0.registerDownloadListener(arg_18_0)
	var_0_3:registerDownloadListener(function(arg_19_0, arg_19_1)
		if arg_19_0 == var_0_5 then
			arg_18_0:onDownloadProgressing(arg_19_1)
		elseif arg_19_0 == var_0_6 then
			arg_18_0:onDownloadFinished(arg_19_1)
		elseif arg_19_0 == var_0_7 then
			arg_18_0:onDownloadError(arg_19_1)
		elseif arg_19_0 == var_0_8 then
			arg_18_0:onUnZipFinished(arg_19_1)
		end
	end)
end

function var_0_0.onDownloadProgressing(arg_20_0, arg_20_1)
	local var_20_0 = cc.EventCustom:new("DOWNLOAD_EVENT_PROGRESS")

	var_20_0.fileName = download_queue:getFileNameByURL(arg_20_1.url)
	var_20_0.totalBytesReceived = arg_20_1.totalBytesReceived
	var_20_0.totalBytesExpected = arg_20_1.totalBytesExpected

	cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_20_0)
end

function var_0_0.onDownloadFinished(arg_21_0, arg_21_1)
	local var_21_0 = download_queue:getFileNameByURL(arg_21_1.url)

	download_queue[var_21_0] = nil

	if var_21_0 == var_0_22 then
		var_0_22 = nil
	end

	var_0_19:onFileDownloadComplete(var_21_0)
	var_0_20:onFileDownloadComplete(var_21_0)
	var_0_21:onFileDownloadComplete(var_21_0)
	download_l2d_helper:onFileDownloadComplete(var_21_0)
	file_check_manager:onFileDownloadComplete(var_21_0)

	if arg_21_1.errCode == var_0_9 then
		local var_21_1 = cc.EventCustom:new("DOWNLOAD_EVENT_COMPLETE")

		var_21_1.fileName = var_21_0

		cc.Director:getInstance():getEventDispatcher():dispatchEvent(var_21_1)
	end
end

function var_0_0:onDownloadError(arg_22_1)
	local var_22_0 = download_queue:getFileNameByURL(arg_22_1.url)

	print("DownloadError for ", var_22_0, " desc: ", arg_22_1.errDesc, "url: ", arg_22_1.url)
	self:insertDownloadTasks(file_check_manager:getFileDownloadInfo(var_22_0), "retry")
end

function var_0_0.onUnZipFinished(arg_23_0, arg_23_1)
	return
end

function var_0_0.updateOnGetNewRole(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs((auto_download_helper:generate_assets_on_getrole(arg_24_1))) do
		var_0_19:add(iter_24_1)
	end
end

function var_0_0.updateOnPassLevel(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs((auto_download_helper:generate_assets_on_passlevel(arg_25_1, arg_25_2))) do
		var_0_19:add(iter_25_1)
	end
end

function var_0_0.updateOnEnterGame(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs((auto_download_helper:generate_assets_on_entergame())) do
		var_0_19:add(iter_26_1)
	end
end

function var_0_0.getAutoDownloadCount(arg_27_0)
	return var_0_21:count()
end

function var_0_0.getAutoDownloadTotalSize(arg_28_0)
	return var_0_21:getTotalSize()
end

function var_0_0.getAutoDownloadDownloadedSize(arg_29_0)
	return var_0_21:getDownloadedSize()
end

return var_0_0
