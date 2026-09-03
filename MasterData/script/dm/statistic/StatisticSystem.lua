-- chunkname: @/tmp/or_script/lua_compile/dm/statistic/StatisticSystem.lua

require("dm.statistic.StatisticPointConfig")
require("dm.base.TimeUtil")

StatisticSystem = StatisticSystem or {}
StatisticSystem.baseInfo = StatisticSystem.baseInfo or {}

function StatisticSystem:init()
	local deviceInfo = app.getDevice():getDeviceInfo()

	if app.pkgConfig then
		local baseVersion = app.pkgConfig.packJobId
		local baseInfo = {}

		if app.pkgConfig then
			baseInfo.game = app.pkgConfig.game or "dm"
		end

		baseInfo.baseVersion = baseVersion or "dev"

		if app.pkgConfig then
			baseInfo.platform = app.pkgConfig.platform or "dev"
		end

		baseInfo.os = deviceInfo.systemName .. " " .. deviceInfo.systemVersion
		baseInfo.source = "none"
		baseInfo.dtype = deviceInfo.deviceName or ""
		baseInfo.did = PlatformHelper:getSdkDid() or ""
		baseInfo.rid = ""
		baseInfo.server = ""
		baseInfo._gameplt_ = baseInfo.game .. "_" .. baseInfo.platform

		self:addInfoValues(baseInfo)

		self._rid = ""
	end
end

function StatisticSystem:addInfoValues(infoValues)
	if infoValues == nil then
		return
	end

	for key, value in pairs(infoValues) do
		self.baseInfo[key] = value
	end
end

function StatisticSystem:setRid(rid)
	self._rid = rid or ""
end

local function genSign(params)
	local appsecret = "ZRIXTOXVPRUBYP3FG5LYRBVHQJYYNF5DDMKDACHM4UOFKTAA"

	table.sort(params, function(a, b)
		return a.key < b.key
	end)

	local sign = ""
	local data = ""

	for index, param in ipairs(params) do
		sign = sign .. param.key .. param.value

		if index > 1 then
			data = data .. "&"
		end

		data = data .. param.key .. "=" .. param.value
	end

	sign = appsecret .. sign .. appsecret
	sign = crypto.md5(sign)
	data = data .. "&sign=" .. sign

	return sign, data
end

function StatisticSystem:send(content)
	if GameConfigs.closeClientStatistic then
		return
	end

	if content.type == "clickpoint" then
		return
	end

	local stageUrl = app.pkgConfig.stageUrl

	if stageUrl == nil then
		return
	end

	local url = stageUrl .. "/recv.php"

	content = content or {}

	local socket = require("socket")
	local ts = socket.gettime()

	for key, value in pairs(self.baseInfo) do
		content[key] = value
	end

	content.version = app:getAssetsManager():getCurrentVersion()

	if content.type == "loginflow" or content.type == "updateflow" or content.type == "guideflow" or content.type == "otherflow" or content.type == "loginchoose" or content.type == "loginpoint" then
		content.step = StatisticPointConfig[content.point]
	end

	if self._rid then
		content.rid = self._rid
	end

	content._type_ = content.type
	content._time_ = os.date("%Y-%m-%d %H:%M:%S", ts)
	content._date_ = os.date("%Y-%m-%d", ts)
	content.type = nil
	content._utc_ = TimeUtil:getLocalTimeZoneId()

	local cjson = require("cjson.safe")
	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("POST", url)
	xhr:registerScriptHandler(function()
		return
	end)

	if app.pkgConfig then
		local params = {}
		local var_6_0 = {
			key = "game"
		}

		var_6_0.value = self.baseInfo.game or "dm"
		params[#params + 1] = var_6_0

		local var_6_1 = {
			key = "platform"
		}

		var_6_1.value = self.baseInfo.platform or ""
		params[#params + 1] = var_6_1
		params[#params + 1] = {
			key = "mode",
			value = app.pkgConfig or "dev"
		}
		params[#params + 1] = {
			value = "197668",
			key = "appid"
		}

		local var_6_2 = #params + 1
		local var_6_3 = {
			key = "timestamp"
		}

		var_6_3.value = ts and math.floor(ts * 1000) or ""
		params[var_6_2] = var_6_3

		local var_6_4 = {
			key = "data"
		}

		var_6_4.value = cjson.encode(content) or ""
		params[#params + 1] = var_6_4

		local sign, data = genSign(params)

		xhr:send(data)

		if (content._type_ == "loginpoint" or content._type_ == "loginchoose") and DmGame then
			local developSystem = DmGame:getInstance()._injector:getInstance("DevelopSystem")
			local var_6_5 = {
				guideId = tostring(content.point)
			}

			var_6_5.step = tostring(content.step or "")

			developSystem:guideLog(var_6_5)
		end
	end
end

LogType = {
	kBCFail = "bcheckfail",
	kClient = "dmclient",
	kBError = "battleerror"
}

function StatisticSystem:record(type, content)
	if GameConfigs.closeClientStatistic then
		return
	end

	content = content or {}
	content.ts = math.floor(app.getTime())

	for key, value in pairs(self.baseInfo) do
		content[key] = value
	end

	content.version = app:getAssetsManager():getCurrentVersion()

	DpsLogger:info(type, "{}", content)
end

function StatisticSystem:uploadLogs(type)
	if GameConfigs.closeClientStatistic then
		return
	end

	if type == nil then
		return
	end

	local stageUrl = app.pkgConfig.stageUrl

	if stageUrl == nil then
		return
	end

	local url = stageUrl .. "/upload_file.php"
	local time = math.floor(app.getTime())
	local fileUtils = cc.FileUtils:getInstance()
	local logPath = fileUtils:getWritablePath() .. "log"
	local formatStr = logPath .. "/" .. type .. "%s.log"
	local oneDaySec = 86400

	for i = 1, 10 do
		local fileName = string.format(formatStr, os.date("%Y-%m-%d", os.time() - (i - 1) * oneDaySec))
		local fileData = fileUtils:getStringFromFile(fileName)

		if fileData and fileData ~= "" then
			fileUtils:removeFile(fileName)

			local xhr = cc.XMLHttpRequest:new()

			xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

			xhr:open("POST", url)
			xhr:registerScriptHandler(function()
				return
			end)

			if app.pkgConfig then
				local params = {}
				local var_9_0 = {
					key = "game"
				}

				var_9_0.value = self.baseInfo.game or "dm"
				params[#params + 1] = var_9_0

				local var_9_1 = {
					key = "platform"
				}

				var_9_1.value = self.baseInfo.platform or ""
				params[#params + 1] = var_9_1
				params[#params + 1] = {
					key = "mode",
					value = app.pkgConfig or "dev"
				}
				params[#params + 1] = {
					value = "197668",
					key = "appid"
				}
				params[#params + 1] = {
					key = "timestamp",
					value = time or ""
				}
				params[#params + 1] = {
					key = "type",
					value = type or ""
				}
				params[#params + 1] = {
					key = "data",
					value = fileData or ""
				}

				local sign, data = genSign(params)

				xhr:send(data)
			end
		else
			break
		end
	end
end

function StatisticSystem:uploadBattleDump(logType, dumpData, callback)
	if GameConfigs.closeClientStatistic then
		return
	end

	local stageUrl = "http://111.231.218.203"
	local url = stageUrl .. "/upload_file.php"
	local fileData = dumpData

	if type(fileData) ~= "string" then
		local cjson = require("cjson.safe")

		fileData = cjson.encode(dumpData)
	end

	local xhr = cc.XMLHttpRequest:new()

	xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

	xhr:open("POST", url)
	xhr:registerScriptHandler(function()
		return
	end)

	local time = math.floor(app.getTime())

	if app.pkgConfig then
		local params = {}

		params[#params + 1] = {
			value = "or_battleDump",
			key = "game"
		}

		local var_11_0 = {
			key = "platform"
		}

		if logType == LogType.kBCFail or logType == LogType.kBError then
			var_11_0.value = self.baseInfo.platform or "BattleDump"
		end

		params[#params + 1] = var_11_0
		params[#params + 1] = {
			key = "mode",
			value = app.pkgConfig or "DEV"
		}
		params[#params + 1] = {
			value = "197668",
			key = "appid"
		}
		params[#params + 1] = {
			key = "timestamp",
			value = time or ""
		}
		params[#params + 1] = {
			key = "type",
			value = logType or LogType.kBCFail
		}
		params[#params + 1] = {
			key = "data",
			value = fileData or ""
		}

		local sign, data = genSign(params)

		local function httpResponse()
			dump(xhr.response, "uploadBattleDump response")

			if callback then
				callback(xhr.response)
			end
		end

		xhr:registerScriptHandler(httpResponse)
		xhr:send(data)
	end
end

function StatisticSystem:uploadProfilerLog(data)
	if GameConfigs.closeClientStatistic then
		return
	end

	if not app.pkgConfig.stageUrl then
		local stageUrl = "http://dc.dpstorm.com"

		if stageUrl == nil then
			return
		end

		local url = stageUrl .. "/upload_file.php"
		local fileData = data.fileData
		local logName = data.logName
		local xhr = cc.XMLHttpRequest:new()

		xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING

		xhr:open("POST", url)
		xhr:registerScriptHandler(function()
			return
		end)

		local time = math.floor(app.getTime())

		if app.pkgConfig then
			local params = {}
			local var_14_1 = {
				key = "game"
			}

			var_14_1.value = self.baseInfo.game or "dm"
			params[#params + 1] = var_14_1

			local var_14_2 = {
				key = "platform"
			}

			var_14_2.value = self.baseInfo.platform or ""
			params[#params + 1] = var_14_2
			params[#params + 1] = {
				key = "mode",
				value = app.pkgConfig or "dev"
			}
			params[#params + 1] = {
				value = "197668",
				key = "appid"
			}
			params[#params + 1] = {
				key = "timestamp",
				value = time or ""
			}
			params[#params + 1] = {
				key = "type",
				value = "luaprofiler-" .. logName
			}
			params[#params + 1] = {
				key = "data",
				value = fileData or ""
			}

			local sign, data = genSign(params)

			xhr:send(data)
		end
	end
end
