-- chunkname: @/tmp/or_script/lua_compile/dm/debug/debugBox/view/BattleRecordBox.lua

local fileExt = ".txt"
local filePre = "record@"
local fileIndex = filePre .. "Index" .. fileExt

function startReport(self, battleData)
	local outSelf = self
	local battleDelegate = {}
	local isReplay = true
	local battleRecorder = BattleRecorder:new():restoreRecords(battleData)
	local battleInterpreter = BattleInterpreter:new()

	battleInterpreter:setRecordsProvider(battleRecorder)

	local battleDirector = LocalBattleDirector:new()

	battleDirector:setBattleInterpreter(battleInterpreter)

	local logicInfo = {
		director = battleDirector,
		interpreter = battleInterpreter
	}

	logicInfo.mainPlayerId = battleData.mainPlayerId

	function battleDelegate:onLeavingBattle()
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onPauseBattle(continueCallback, leaveCallback)
		local popupDelegate = {}

		function popupDelegate:willClose(sender, data)
			if data.opt == BattlePauseResponse.kLeave then
				leaveCallback()
			else
				continueCallback(data.hpShow, data.effectShow)
			end
		end

		local pauseView = outSelf:getInjector():getInstance("battlePauseView")

		outSelf:dispatch(ViewEvent:new(EVT_SHOW_POPUP, pauseView, nil, {}, popupDelegate))
	end

	function battleDelegate:tryLeaving(callback)
		callback(true)
	end

	function battleDelegate:onSkipBattle()
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onBattleFinish(result)
		BattleLoader:popBattleView(outSelf)
	end

	function battleDelegate:onDevWin()
		BattleLoader:popBattleView(outSelf)
	end

	local bgRes = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Arena_Background", "content") or "battle_scene_1"
	local data = {
		battleRecords = battleData,
		isReplay = isReplay,
		logicInfo = logicInfo,
		delegate = battleDelegate,
		viewConfig = {
			hpShow = 1,
			mainView = "battlePlayer",
			opPanelRes = "asset/ui/BattleUILayer.csb",
			canChangeSpeedLevel = true,
			opPanelClazz = "BattleUIMediator",
			background = bgRes,
			refreshCost = ConfigReader:getRecordById("ConfigValue", "TacticsCard_Reload").content,
			battleSuppress = BattleDataHelper:getBattleSuppress(),
			btnsShow = {
				speed = {
					visible = true
				},
				skip = {
					visible = false
				},
				auto = {
					visible = false
				},
				pause = {
					visible = true
				},
				restraint = {
					visible = false
				}
			}
		},
		loadingType = LoadingType.KArena
	}

	BattleLoader:pushBattleView(self, data)
end

SaveBattleRecordBox = class("SaveBattleRecordBox", DebugViewTemplate, _M)

function SaveBattleRecordBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function SaveBattleRecordBox:onClick(data)
	local records = self:getInjector():getInstance("Debug_BattleRecords")

	if not records then
		cclog("未读取到战斗记录!")
		self:dispatch(ShowTipEvent({
			tip = "未读取到战斗记录!"
		}))

		return
	end

	local cjson = require("cjson.safe")
	local recordsString = cjson.encode(records)
	local fileName = filePre .. os.date("%Y_%m_%d@%H_%M_%S") .. fileExt

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local filePath = path .. fileName
		local file = io.open(filePath, "w")

		if file == nil then
			cclogf("打开/创建文件失败。可能目录不存在，或者没有写入权限。文件路径：%s", filePath)

			if path == device.writablePath then
				return
			end

			path = device.writablePath
			filePath = device.writablePath .. fileName

			cclogf("尝试写入到默认路径：%s", device.writablePath .. fileName)

			file = io.open(filePath, "w")

			if file == nil then
				cclogf("打开/创建文件失败！")
				self:dispatch(ShowTipEvent({
					tip = "打开/创建文件失败！"
				}))

				return
			end
		end

		file:write(recordsString)
		file:close()

		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			file = io.open(indexPath, "w")

			file:close()
		end

		file = io.open(indexPath, "a+")

		file:write(filePath .. "\n")
		file:close()
		cclog("战斗记录已保存到文件: " .. filePath)
		self:dispatch(ShowTipEvent({
			tip = "战斗记录已保存到文件: " .. filePath
		}))
	end
end

ClearBattleRecordBox = class("ClearBattleRecordBox", DebugViewTemplate, _M)

function ClearBattleRecordBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function ClearBattleRecordBox:onClick(data)
	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")

		for i in f:lines() do
			if io.exists(i) then
				os.remove(i)
			end
		end

		os.remove(indexPath)
		cclog("成功清除战斗记录缓存")
		self:dispatch(ShowTipEvent({
			tip = "成功清除战斗记录缓存"
		}))
	end
end

ReplayBattleRecordBox = class("ReplayBattleRecordBox", DebugViewTemplate, _M)

function ReplayBattleRecordBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function ReplayBattleRecordBox:onClick(data)
	local records = self:getInjector():getInstance("Debug_BattleRecords")

	if not records then
		self:dispatch(ShowTipEvent({
			tip = "未读取到战斗记录!"
		}))
		cclog("未读取到战斗记录!")

		return
	end

	startReport(self, records)
end

ReplayBattleRecordFileBox = class("ReplayBattleRecordFileBox", DebugViewTemplate, _M)

function ReplayBattleRecordFileBox:initialize()
	self._dynamic = true
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "输入文件名",
			type = "Input"
		}
	}

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")
		local count = 0

		for i in f:lines() do
			if io.exists(i) then
				count = count + 1

				local pos, posend = string.find(i, filePre, nil, nil, 1)
				local fileName = string.sub(i, posend + 1)

				self._viewConfig[#self._viewConfig + 1] = {
					type = "Label",
					name = i,
					title = count .. " " .. fileName
				}
			end
		end
	end
end

function ReplayBattleRecordFileBox:onClick(data)
	local index = tonumber(data.FileIndex)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName

		if index then
			local indexPath = path .. fileIndex

			if not io.exists(indexPath) then
				self:dispatch(ShowTipEvent({
					tip = "索引文件不存在"
				}))

				return
			end

			local f = io.open(indexPath, "r")
			local count = 0

			for i in f:lines() do
				if io.exists(i) then
					count = count + 1

					if index == count then
						fileName = i

						break
					end
				end
			end
		else
			fileName = path .. data.FileIndex .. fileExt
		end

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local records = cjson.decode(content)

			startReport(self, records)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

UploadBattleRecordBox = class("UploadBattleRecordBox", DebugViewTemplate, _M)

function UploadBattleRecordBox:initialize()
	self._viewConfig = {
		{
			title = "",
			name = "result",
			type = "Label"
		}
	}
end

function UploadBattleRecordBox:onClick(data)
	local records = self:getInjector():getInstance("Debug_BattleRecords")

	if not records then
		self:dispatch(ShowTipEvent({
			tip = "未读取到战斗记录!"
		}))
		cclog("未读取到战斗记录!")

		return
	end

	local cjson = require("cjson.safe")
	local recordsString = cjson.encode(records)
	local var_18_0 = {
		type = "battlerecord",
		url = "http:192.168.1.73/saveLog.php",
		content = recordsString,
		key = filePre .. os.date("%Y_%m_%d@%H_%M_%S") .. fileExt
	}

	var_18_0.rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

	CommonUtils.uploadData(var_18_0, function(response)
		self:dispatch(ShowTipEvent({
			tip = response
		}))
	end)
end

UploadBattleRecordFileBox = class("UploadBattleRecordFileBox", DebugViewTemplate, _M)

function UploadBattleRecordFileBox:initialize()
	self._dynamic = true
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "输入文件名",
			type = "Input"
		}
	}

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local indexPath = path .. fileIndex

		if not io.exists(indexPath) then
			return
		end

		local f = io.open(indexPath, "r")
		local count = 0

		for i in f:lines() do
			if io.exists(i) then
				count = count + 1

				local pos, posend = string.find(i, filePre, nil, nil, 1)
				local fileName = string.sub(i, posend + 1)

				self._viewConfig[#self._viewConfig + 1] = {
					type = "Label",
					name = i,
					title = count .. " " .. fileName
				}
			end
		end
	end
end

function UploadBattleRecordFileBox:onClick(data)
	local index = tonumber(data.FileIndex)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName, shortName

		if index then
			local indexPath = path .. fileIndex

			if not io.exists(indexPath) then
				self:dispatch(ShowTipEvent({
					tip = "索引文件不存在"
				}))

				return
			end

			local f = io.open(indexPath, "r")
			local count = 0

			for i in f:lines() do
				if io.exists(i) then
					count = count + 1

					if index == count then
						fileName = i

						break
					end
				end
			end

			local pos, posend = string.find(fileName, filePre, nil, nil, 1)

			shortName = string.sub(fileName, posend + 1)
		else
			fileName = path .. data.FileIndex .. fileExt
			shortName = data.FileIndex .. fileExt
		end

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local recordsString = file:read("*a")
			local var_21_1 = {
				type = "battlerecord",
				url = "http:192.168.1.73/saveLog.php",
				content = recordsString,
				key = shortName
			}

			var_21_1.rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

			CommonUtils.uploadData(var_21_1, function(response)
				self:dispatch(ShowTipEvent({
					tip = response
				}))
			end)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

ReplayBattleRecordPhpBox = class("ReplayBattleRecordPhpBox", DebugViewTemplate, _M)

function ReplayBattleRecordPhpBox:initialize()
	self._viewConfig = {
		{
			default = "1",
			name = "FileIndex",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBattleRecordPhpBox:onClick(data)
	local shortName = data.FileIndex .. fileExt
	local var_24_0 = {
		type = "battlerecord",
		url = "http:192.168.1.73/getLog.php",
		content = recordsString,
		key = shortName
	}

	var_24_0.rid = self:getInjector():getInstance("DevelopSystem"):getPlayer():getRid()

	CommonUtils.getData(var_24_0, function(response)
		if response and response ~= "" then
			local cjson = require("cjson.safe")
			local records = cjson.decode(response)

			startReport(self, records)
		end
	end)
end

ReplayBCFailClientTimelineBox = class("ReplayBCFailClientTimelineBox", DebugViewTemplate, _M)

function ReplayBCFailClientTimelineBox:initialize()
	self._viewConfig = {
		{
			default = "fail",
			name = "FileName",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBCFailClientTimelineBox:onClick(data)
	local name = tostring(data.FileName)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName = path .. name .. ".log"

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local logs = cjson.decode(content)

			if logs == nil then
				content = string.gsub(content, "\"[^\"]*\":%s*nil,", "")
				content = string.gsub(content, ",\"[^\"]*\":%s*nil}", "}")
				content = string.gsub(content, "\\\\", "\\")
				logs = cjson.decode(content)
			end

			local records = logs.battleDump.records

			startReport(self, records)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end

ReplayBCFailServerTimelineBox = class("ReplayBCFailServerTimelineBox", DebugViewTemplate, _M)

function ReplayBCFailServerTimelineBox:initialize()
	self._viewConfig = {
		{
			default = "fail",
			name = "FileName",
			title = "目前文件名无处获取，待以后完善",
			type = "Input"
		}
	}
end

function ReplayBCFailServerTimelineBox:onClick(data)
	local name = tostring(data.FileName)

	if not GameConfigs.recordSavedPath then
		local path = device.writablePath
		local fileName = path .. name .. ".log"

		if io.exists(fileName) then
			local file = io.open(fileName, "r")
			local content = file:read("*a")
			local cjson = require("cjson.safe")
			local logs = cjson.decode(content)

			if logs == nil then
				content = string.gsub(content, "\"[^\"]*\":%s*nil,", "")
				content = string.gsub(content, ",\"[^\"]*\":%s*nil}", "}")
				content = string.gsub(content, "\\\\", "\\")
				logs = cjson.decode(content)
				logs = logs.response
			end

			Bdump(logs.battleInput.playerData)
			Bdump(logs.clientResult.opData)
			Bdump(logs.clientResult.statist)

			local records = logs.serverResult.timelines

			startReport(self, records)
		else
			self:dispatch(ShowTipEvent({
				tip = "文件不存在"
			}))
		end
	end
end
