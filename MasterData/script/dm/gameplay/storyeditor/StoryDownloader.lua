-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/storyeditor/StoryDownloader.lua

require("dm.downloader.Downloader")

StoryDownloader = class("StoryDownloader", objectlua.Object, _M)

StoryDownloader:has("_eventDispatcher", {
	is = "rw"
}):injectWith("legs_sharedEventDispatcher")
StoryDownloader:has("_url", {
	is = "rw"
})
StoryDownloader:has("_cdnRoot", {
	is = "rw"
})

local function parseNameByUrl(url)
	local flag, name

	flag = string.find(url, "\\")

	if flag then
		name = string.match(url, ".+\\([^\\]*%.%w+)$")
	end

	flag = string.find(url, "/")

	return (flag or nil) and string.match(url, ".+/([^/]*%.%w+)$")
end

function StoryDownloader:initialize()
	super.initialize(self)
	self:initMember()
end

function StoryDownloader:getFileList()
	return self._fileList
end

function StoryDownloader:initMember()
	self._downloader = Downloader:getInstance()
	self._fileList = {}
	self._isRunning = false
end

function StoryDownloader:downloadFile(cdnRoot, relativepath, callback)
	local url = cdnRoot .. "/" .. relativepath

	relativepath = "stories/" .. relativepath

	if self._downloader then
		local fileUtils = cc.FileUtils:getInstance()
		local configName = parseNameByUrl(relativepath)
		local relativeFolderPath = string.gsub(relativepath, configName, "")

		relativeFolderPath = fileUtils:getWritablePath() .. "/" .. relativeFolderPath

		if not fileUtils:isDirectoryExist(relativeFolderPath) then
			fileUtils:createDirectory(relativeFolderPath)
		end

		local storagePath = fileUtils:getWritablePath() .. "/" .. relativepath

		local function onFileTaskSuccess(task)
			if callback then
				self._isRunning = false

				callback()
			end
		end

		local function onTaskError(task, errorCode, errorCodeInternal, errorStr)
			self._isRunning = false

			if callback then
				callback()
			end
		end

		local taskInfo = {
			type = "file",
			identifier = storagePath,
			srcUrl = url,
			storagePath = storagePath,
			onTaskError = onTaskError,
			onFileTaskSuccess = onFileTaskSuccess
		}

		self._downloader:addDownloadTask(taskInfo)
	end
end

function StoryDownloader:run(callback)
	self._isRunning = true
	self._fileList = {}

	self:requestStoryInfo(function()
		local fileNumber = #self._fileList

		if fileNumber == 0 then
			if callback then
				callback()
			end

			return
		end

		for _, relativefilepath in pairs(self._fileList) do
			self:downloadFile(self._cdnRoot, relativefilepath, function()
				fileNumber = fileNumber - 1

				if fileNumber == 0 then
					if callback then
						callback()
					end

					return
				end
			end)
		end
	end)
end

function StoryDownloader:getIsRunning()
	return self._isRunning
end

function StoryDownloader:requestStoryInfo(callback)
	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("GET", self._url)

	local function httpResponse()
		if xhr.status == 200 then
			local cjson = require("cjson.safe")
			local storyData = cjson.decode(xhr.response)

			self._cdnRoot = storyData.cdnRoot
			self._fileList = storyData.updateList

			if callback then
				callback()
			end
		else
			dump("同步失败")
		end
	end

	xhr:registerScriptHandler(httpResponse)
	xhr:send()
end
