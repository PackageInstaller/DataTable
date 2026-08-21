-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/SDK\\Plugin\\GameVoice.lua

local GameVoice = {}
local PluginConfig = require("SDK/Plugin/PluginConfig")
local DeviceHelper = require("Helper/DeviceHelper")
local ChannelUtil = ChannelUtil
local GameVoiceAgent = Framework.Plugin.GameVoiceAgent
local PermissionManager = Framework.Plugin.PermissionManager
local GameVoiceMode = {
	MESSAGE = 1,
	TRANSLATION = 2,
	REAL_TIME = 0
}

GameVoice.GameVoiceMode = GameVoiceMode

local GameVoiceEventType = {
	DOWNLOAD_FINISH = 1,
	UPLOAD_FINISH = 0,
	QUIT_ROOM_FINISH = 5,
	PLAY_FINISH = 2,
	SPEECH_TO_TEXT_FINISH = 3,
	JOIN_ROOM_FINISH = 4
}
local CallbackEvent = {
	STOP_PLAY_BY_USER = 8,
	STOP_PLAY_BY_SYS = 7,
	PLAY_FAIL = 6,
	JOIN_TEAM_ROOM_FAIL = 10,
	QUIT_TEAM_ROOM_FAIL = 11,
	UPLOAD_FAIL = 3,
	PERMISSION_DENIED = 9,
	UNKNOWN = 0,
	JOIN_TEAM_ROOM_ABORT = 12,
	INIT_FAIL = 1,
	RECORD_FAIL = 2,
	SPEECH_TO_TEXT_FAIL = 4,
	QUIT_TEAM_ROOM_ABORT = 13,
	DOWNLOAD_FAIL = 5
}
local CallbackType = {
	RECORD_MSG_END = 2,
	COMPLETE_MSG_END = 3,
	PLAY_MSG_END = 5,
	SET_MODE = 8,
	QUIT_TEAM_ROOM = 7,
	JOIN_TEAM_ROOM = 6
}
local GVoiceErrorCode = {
	REALTIME_STATE_ERR = 8193,
	SUCC = 0,
	QUIT_ROOMNAME_ERR = 8195
}
local INVALID_PARAM = "Unknown"
local RETRY_TIMES = 2
local RECORD_MAX_LENGTH = 30
local ROOM_TIMEOUT_MS = 20000
local FILE_LIST_FILE = "filelist.txt"
local RECORD_FILE_PREFIX = "rec_"

local function dict2List(dict)
	local list = {}

	for i, value in pairs(dict) do
		table.insert(list, i)
	end

	return list
end

local function isFileExists(path)
	local file = io.open(path, "r")

	if file then
		file:close()

		return true
	else
		return false
	end
end

local function getVoiceItem(voiceID)
	if voiceID == nil or voiceID == "" then
		return nil
	else
		if GameVoice._voiceItemTable[voiceID] == nil then
			GameVoice._voiceItemTable[voiceID] = {}
		end

		return GameVoice._voiceItemTable[voiceID]
	end
end

local function removeVoiceItem(voiceID)
	if voiceID == nil or voiceID == "" then
		-- block empty
	else
		GameVoice._voiceItemTable[voiceID] = nil
	end
end

local function setVoiceText(voiceID, text)
	local item = getVoiceItem(voiceID)

	if item ~= nil then
		item.text = text
	end
end

local function getVoiceText(voiceID)
	local item = getVoiceItem(voiceID)

	if item ~= nil then
		return item.text
	end

	return nil
end

local function setVoiceLength(voiceID, length)
	local item = getVoiceItem(voiceID)

	if item ~= nil then
		item.length = length
	end
end

local function getVoiceLength(voiceID)
	local item = getVoiceItem(voiceID)

	if item ~= nil then
		return item.length
	end

	return nil
end

local function removeExtension(str)
	local idx = str:match(".+()%.%w+$")

	if idx then
		return str:sub(1, idx - 1)
	else
		return str
	end
end

local function getFileNameFromPath(path)
	if path == nil then
		return nil
	else
		return path:match("[^/\\\\]+$")
	end
end

local function getFilePath(fileID)
	local prefix = RECORD_FILE_PREFIX

	if fileID then
		prefix = ""
	end

	local fileNameTimeStamp = tostring(os.time()) .. math.floor(os.clock() % 1 * 100)
	local fileName = prefix .. (fileID or fileNameTimeStamp) .. ".dat"
	local filePath = GameVoice.parentPath .. fileName

	return filePath, fileName
end

local function getFileIDFromName(fileName)
	local fileID

	fileID = (fileName ~= nil or nil) and (not fileName:match("^" .. RECORD_FILE_PREFIX) or nil) and removeExtension(fileName)

	return fileID
end

local function getFileIDFromPath(filePath)
	if filePath == nil then
		return nil
	else
		local fileName = getFileNameFromPath(filePath)
		local fileID = getFileIDFromName(fileName)

		return fileID
	end
end

local errorMsg = {}

function GameVoice.handleError(callbackEvent, arg1)
	local text = errorMsg[callbackEvent] or Lang.get(29993)
	local info = {
		isAbort = true,
		CallbackEvent = callbackEvent,
		errorText = text
	}

	if callbackEvent == CallbackEvent.RECORD_FAIL then
		GameVoice.callback(CallbackType.RECORD_MSG_END, false, info)
	elseif callbackEvent == CallbackEvent.PERMISSION_DENIED then
		GameVoice.callback(CallbackType.RECORD_MSG_END, false, info)
	elseif callbackEvent == CallbackEvent.UPLOAD_FAIL then
		local filePath = arg1

		GameVoice.callback(CallbackType.COMPLETE_MSG_END, false, info)
	elseif callbackEvent == CallbackEvent.SPEECH_TO_TEXT_FAIL then
		local fileID = arg1

		info.fileID = fileID

		GameVoice.callback(CallbackType.COMPLETE_MSG_END, false, info)
	elseif callbackEvent == CallbackEvent.PLAY_FAIL or callbackEvent == CallbackEvent.DOWNLOAD_FAIL then
		local fileID = arg1

		if fileID == GameVoice._curPlayingID then
			GameVoice._curPlayingID = nil
		end

		info.fileID = fileID

		GameVoice.callback(CallbackType.PLAY_MSG_END, false, info, fileID)
	elseif callbackEvent == CallbackEvent.JOIN_TEAM_ROOM_FAIL or callbackEvent == CallbackEvent.QUIT_TEAM_ROOM_FAIL or callbackEvent == CallbackEvent.JOIN_TEAM_ROOM_ABORT or callbackEvent == CallbackEvent.QUIT_TEAM_ROOM_ABORT then
		info.isAbort = callbackEvent == CallbackEvent.JOIN_TEAM_ROOM_ABORT or callbackEvent == CallbackEvent.QUIT_TEAM_ROOM_ABORT
		info.roomName = arg1

		if callbackEvent == CallbackEvent.JOIN_TEAM_ROOM_FAIL or callbackEvent == CallbackEvent.JOIN_TEAM_ROOM_ABORT then
			GameVoice.callback(CallbackType.JOIN_TEAM_ROOM, false, info)
		else
			GameVoice.callback(CallbackType.QUIT_TEAM_ROOM, false, info)
		end
	end
end

function GameVoice.setStrategy(newStrategyNo)
	GameVoiceAgent.SetStrategy(newStrategyNo or 0)
end

function GameVoice.init(newStrategyNo)
	if GameVoice._isInited then
		return
	end

	local openID = AccountManager.getOpenID()
	local strategyNo = newStrategyNo or 0
	local appID, appKey, voiceServer

	if strategyNo == PluginConfig.GAME_VOICE_STRAT_GCLOUD then
		appID, appKey, voiceServer = PluginConfig.getGameVoiceConfig()
	elseif strategyNo == PluginConfig.GAME_VOICE_STRAT_DUMMY then
		appID = "GameVoiceAppIDDummy"
		appKey = "GameVoiceAppKeyDummy"
	end

	GameVoiceAgent.Init(appID, appKey, openID)
	GameVoiceAgent.SetServerInfo(voiceServer)
	GameVoiceAgent.SetLuaEventCallback(GameVoice.onGetEvent)

	GameVoice.parentPath = GameVoiceAgent.GetParentPath()
	GameVoice.mode = GameVoiceMode.TRANSLATION
	GameVoice.isMicOn = false
	GameVoice.isSpeakerOn = false
	GameVoice._curRoomName = nil
	GameVoice._roomRequest = {}
	GameVoice._roomPending = {}
	GameVoice._timerRecording = Timer.New(GameVoice._onRecordingTimeout, RECORD_MAX_LENGTH)
	GameVoice._callbackDict = {}
	GameVoice._pollTimer = Timer.New(GameVoice.poll, 0.5, -1)

	GameVoice._pollTimer:Start()

	GameVoice._isInited = true
end

function GameVoice.destroy()
	GameVoice._pollTimer:Stop()
end

function GameVoice.pause()
	GameVoice._stopRecording(false, false)
	GameVoiceAgent.Pause()
end

function GameVoice.resume()
	GameVoiceAgent.Resume()
end

GameVoice._voiceItemTable = {}
GameVoice._uploadQueue = {}
GameVoice._downloadQueue = {}
GameVoice._curRecordingPath = nil
GameVoice._curRecordedPath = nil
GameVoice._playAfterDownload = nil
GameVoice._speechToTextQueue = {}
GameVoice._curPlayingID = nil
GameVoice._sendCallback = nil
GameVoice._stopPlayCallback = {}
GameVoice._stopRecordCallback = {}

function GameVoice._setCallback(callbackType, callbackFuncs, nameOrID)
	if nameOrID == nil then
		GameVoice._callbackDict[callbackType] = callbackFuncs
	else
		if GameVoice._callbackDict[callbackType] == nil then
			local dict = {}

			GameVoice._callbackDict[callbackType] = dict
		elseif type(GameVoice._callbackDict[callbackType]) ~= "table" then
			return
		end

		GameVoice._callbackDict[callbackType][nameOrID] = callbackFuncs
	end
end

function GameVoice._getCallback(callbackType, nameOrID)
	local funcs

	if nameOrID == nil then
		funcs = GameVoice._callbackDict[callbackType]
	else
		local dict = GameVoice._callbackDict[callbackType]

		if type(dict) == "table" then
			funcs = dict[nameOrID]
		end
	end

	return funcs
end

function GameVoice.moveCallback(callbackType, oldName, newID)
	local funcs = GameVoice._getCallback(callbackType, oldName)

	if funcs ~= nil then
		GameVoice._setCallback(callbackType, funcs, newID)
		GameVoice._setCallback(callbackType, nil, oldName)
	end
end

function GameVoice.callback(callbackType, isSucc, info, fileID)
	local callbackFuncs = GameVoice._getCallback(callbackType, fileID)

	if callbackFuncs then
		if type(callbackFuncs) == "table" then
			for i, func in ipairs(callbackFuncs) do
				func(isSucc, info)
			end
		else
			callbackFuncs(isSucc, info)
		end

		GameVoice._setCallback(callbackType, nil, fileID)

		if callbackType == CallbackType.RECORD_MSG_END then
			-- block empty
		elseif callbackType == CallbackType.COMPLETE_MSG_END then
			-- block empty
		elseif callbackType == CallbackType.PLAY_MSG_END then
			-- block empty
		end
	end
end

function GameVoice.onUploadFinish(ret, fileID, filePathOld, strLength)
	local length = tonumber(strLength) or -1

	if GameVoice._uploadQueue[filePathOld] == nil then
		return
	end

	if ret == 0 then
		GameVoice.moveCallback(CallbackType.COMPLETE_MSG_END, filePathOld, fileID)
		GameVoice._stopUploadFile(filePathOld)

		local filePath, fileName = getFilePath(fileID)

		GameVoice._addToFileList(fileName)
		setVoiceLength(fileID, length)
		GameVoice._speechToText(fileID)
	else
		local retryTimes = GameVoice._uploadQueue[filePathOld]

		if retryTimes ~= nil then
			GameVoice._uploadFile(filePathOld, true)
		end
	end
end

function GameVoice.onDownloadFinish(ret, fileID, filePath)
	if ret == 0 then
		if GameVoice._downloadQueue[fileID] then
			GameVoice._downloadQueue[fileID] = nil

			if GameVoice._playAfterDownload == fileID then
				GameVoice._playVoice(fileID)
			end
		end
	else
		local retryTimes = GameVoice._downloadQueue[fileID]

		if retryTimes ~= nil then
			GameVoice._downloadFile(fileID, true)
		end
	end
end

function GameVoice.onPlayFinish(ret, filePath)
	local fileID = getFileIDFromPath(filePath)
	local curFileID = GameVoice._curPlayingID

	if curFileID ~= nil and curFileID == fileID then
		GameVoice._curPlayingID = nil
	end

	if fileID ~= nil then
		local info = {
			isAbort = false,
			fileID = fileID
		}

		GameVoice.callback(CallbackType.PLAY_MSG_END, true, info, fileID)
	end
end

function GameVoice.onSpeechToTextFinish(ret, fileID, text)
	if ret == 0 then
		local length = getVoiceLength(fileID)

		setVoiceText(fileID, text)

		local info = {
			text = text,
			fileID = fileID,
			length = length
		}

		removeVoiceItem(fileID)
		GameVoice.callback(CallbackType.COMPLETE_MSG_END, true, info)
	else
		local retryTimes = GameVoice._speechToTextQueue[fileID]

		if retryTimes ~= nil then
			GameVoice._speechToText(fileID, true)
		end
	end
end

function GameVoice._onJoinRoom(ret, roomName, memberID)
	GameVoice._setRoomPending(nil)

	if ret == 0 then
		GameVoice._curRoomName = roomName
	end

	local request = GameVoice._roomRequest

	request.timesAll = request.timesAll + 1

	GameVoice._updateRoom()
end

function GameVoice._onQuitRoom(ret, roomName, memberID)
	GameVoice._setRoomPending(nil)

	local request = GameVoice._roomRequest

	request.timesAll = request.timesAll + 1

	if ret == 0 and (roomName == GameVoice._curRoomName or true) then
		GameVoice._curRoomName = nil
	else
		request.timesQuitFailed = request.timesQuitFailed + 1
	end

	GameVoice._updateRoom()
end

GameVoice._CSEventHandler = {
	[GameVoiceEventType.UPLOAD_FINISH] = GameVoice.onUploadFinish,
	[GameVoiceEventType.DOWNLOAD_FINISH] = GameVoice.onDownloadFinish,
	[GameVoiceEventType.PLAY_FINISH] = GameVoice.onPlayFinish,
	[GameVoiceEventType.SPEECH_TO_TEXT_FINISH] = GameVoice.onSpeechToTextFinish,
	[GameVoiceEventType.JOIN_ROOM_FINISH] = GameVoice._onJoinRoom,
	[GameVoiceEventType.QUIT_ROOM_FINISH] = GameVoice._onQuitRoom
}

function GameVoice.onGetEvent(eventType, ret, arg1, arg2, arg3)
	local func = GameVoice._CSEventHandler[eventType]

	if func then
		func(ret, arg1, arg2, arg3)
	end
end

function GameVoice.setMode(voiceMode)
	local oldMode = GameVoice.mode

	if oldMode ~= voiceMode then
		if oldMode == GameVoiceMode.TRANSLATION then
			GameVoice.stopRecordAndPlay()
			GameVoice._setRawMode(voiceMode)
		elseif oldMode == GameVoiceMode.REAL_TIME then
			GameVoice._setRawMode(voiceMode)
		end
	end

	return GameVoice.mode == voiceMode
end

function GameVoice.isInMsgMode()
	return GameVoice.mode == GameVoiceMode.TRANSLATION
end

function GameVoice.canAutoPlay()
	return GameVoice.isInMsgMode() and not GameVoice.isPlaying() and not GameVoice.isRecording()
end

function GameVoice._setRawMode(voiceMode)
	if GameVoice.mode ~= voiceMode and GameVoiceAgent.SetMode(voiceMode) == 0 then
		GameVoice.mode = voiceMode
		GameVoice.isMicOn = false
		GameVoice.isSpeakerOn = false
	end
end

function GameVoice.joinTeamRoom(roomName, callback)
	roomName = roomName and tostring(roomName)

	GameVoice._stopCurrentRoomOperation(true)
	GameVoice._setCallback(CallbackType.JOIN_TEAM_ROOM, callback)
	GameVoice.setMode(GameVoiceMode.REAL_TIME)
	GameVoice._setRoomRequest(roomName, true, true)
	GameVoice._updateRoom()
end

function GameVoice.quitRoom(roomName, callback)
	roomName = roomName and tostring(roomName)

	local operationRoomName, operationIsJoin = GameVoice._getRoomPending()

	if roomName == nil then
		roomName = GameVoice._getPotentialRoom()
	end

	GameVoice._setCallback(CallbackType.QUIT_TEAM_ROOM, callback)

	if GameVoice.mode == GameVoiceMode.REAL_TIME and (GameVoice._curRoomName == roomName or operationRoomName == roomName and operationIsJoin) then
		GameVoice._stopCurrentRoomOperation(true)
		GameVoice._setRoomRequest(roomName, false, true)
		GameVoice._updateRoom()
	else
		GameVoice.callback(CallbackType.QUIT_TEAM_ROOM, true, {
			roomName = roomName
		})
	end
end

function GameVoice.setMic(isOpen)
	if GameVoice.mode == GameVoiceMode.REAL_TIME then
		local isSucc = GameVoiceAgent.SetMic(isOpen == true) == 0

		if isSucc then
			GameVoice.isMicOn = isOpen
		end

		return isSucc
	else
		return false
	end
end

function GameVoice.setSpeaker(isOpen)
	if GameVoice.mode == GameVoiceMode.REAL_TIME then
		local isSucc = GameVoiceAgent.SetSpeaker(isOpen == true) == 0

		if isSucc then
			GameVoice.isSpeakerOn = isOpen
		end

		return isSucc
	else
		return false
	end
end

function GameVoice.setMicVolume(volume)
	GameVoiceAgent.SetMicVolume(math.min(math.floor(100 * volume), 150))
end

function GameVoice.setSpeakerVolume(volume)
	GameVoiceAgent.SetSpeakerVolume(math.min(math.floor(100 * volume), 600))
end

function GameVoice.recordMsg(recordEndCallback)
	GameVoice.stopRecordAndPlay()
	GameVoice._setCallback(CallbackType.RECORD_MSG_END, recordEndCallback)

	if not PermissionManager.IsVoiceReady() then
		GameVoice.handleError(CallbackEvent.PERMISSION_DENIED)
		PermissionManager.RequestVoice()
	else
		local filePath, fileName = getFilePath()

		GameVoice._startRecording(filePath)
	end
end

function GameVoice.stopRecordMsg(isFinish)
	GameVoice._stopRecording(true, isFinish)
end

function GameVoice.completeMsg(completeEndCallback)
	local filePath = GameVoice._curRecordedPath

	GameVoice._curRecordedPath = nil

	GameVoice._setCallback(CallbackType.COMPLETE_MSG_END, completeEndCallback)
	GameVoice._uploadFile(filePath)
end

function GameVoice.playMsg(fileID, playEndCallback)
	if fileID ~= nil then
		GameVoice.stopRecordAndPlay()
		GameVoice._setCallback(CallbackType.PLAY_MSG_END, playEndCallback, fileID)

		local filePath = getFilePath(fileID)

		if isFileExists(filePath) then
			GameVoice._playVoice(fileID)
		else
			GameVoice._playAfterDownload = fileID

			GameVoice._downloadFile(fileID)
		end
	elseif playEndCallback then
		local info = {
			fileID = fileID
		}

		playEndCallback(false, info)
	end
end

function GameVoice.stopRecordAndPlay()
	if GameVoice.isPlaying() then
		GameVoice.stopVoice(nil, false)
	end

	if GameVoice.isRecording() then
		GameVoice._stopRecording(false, true)
	end
end

function GameVoice.stopVoice(fileID, byUser)
	if fileID == nil then
		local info = {
			isAbort = true,
			byUser = byUser
		}

		if GameVoice._curPlayingID then
			local curFileID = GameVoice._curPlayingID

			info.fileID = curFileID
			GameVoice._curPlayingID = nil

			GameVoiceAgent.StopPlayFile()
			GameVoice.poll()
			GameVoice.callback(CallbackType.PLAY_MSG_END, true, info, curFileID)
		end

		if GameVoice._playAfterDownload then
			local curFileID = GameVoice._playAfterDownload

			info.fileID = curFileID
			GameVoice._playAfterDownload = nil

			GameVoice.callback(CallbackType.PLAY_MSG_END, true, info, curFileID)
		end
	else
		local info = {
			isAbort = true,
			byUser = byUser,
			fileID = fileID
		}
		local needCallback = false

		if fileID == GameVoice._curPlayingID then
			GameVoiceAgent.StopPlayFile()
			GameVoice.poll()

			GameVoice._curPlayingID = nil
			needCallback = true
		end

		if fileID == GameVoice._playAfterDownload then
			GameVoice._playAfterDownload = nil
			needCallback = true
		end

		if needCallback then
			GameVoice.callback(CallbackType.PLAY_MSG_END, true, info, fileID)
		end
	end
end

function GameVoice.poll()
	if GameVoice._lastPollFrame == nil or GameVoice._lastPollFrame ~= Time.frameCount then
		GameVoice._lastPollFrame = Time.frameCount

		GameVoiceAgent.Poll()
	end
end

function GameVoice.cleanVoiceFiles(savedIDDict)
	if savedIDDict == nil then
		return
	end

	local parentPath = GameVoice.parentPath
	local fileList = GameVoice._getFileList()
	local newFileList = {}

	for i, fileName in ipairs(fileList) do
		local fileID = removeExtension(fileName)

		if savedIDDict[fileID] == nil then
			os.remove(parentPath .. fileName)
		else
			table.insert(newFileList, fileName)
		end
	end

	GameVoice._overwriteFileList(newFileList)
end

function GameVoice.isPlaying()
	return GameVoice._curPlayingID ~= nil or GameVoice._playAfterDownload ~= nil
end

function GameVoice.isRecording()
	return GameVoice._curRecordingPath ~= nil
end

function GameVoice._setRoomRequest(roomName, isJoin, isLocked)
	local request = GameVoice._roomRequest

	request.roomName = roomName
	request.isJoin = isJoin or false
	request.isLocked = isLocked or false
	request.timesQuitFailed = 0
	request.timesAll = 0
end

function GameVoice._getRoomRequest()
	local request = GameVoice._roomRequest

	return request.roomName, request.isJoin
end

function GameVoice.hasRoomRequest()
	local roomName = GameVoice._getRoomRequest()

	return roomName ~= nil and roomName ~= ""
end

function GameVoice._isRoomOperationLocked()
	return GameVoice._roomRequest.isLocked
end

function GameVoice._setRoomOperationLocked(isLocked)
	GameVoice._roomRequest.isLocked = isLocked
end

function GameVoice._setRoomPending(roomName, isJoin)
	local operation = GameVoice._roomPending

	operation.roomName = roomName
	operation.isJoin = isJoin
end

function GameVoice._getRoomPending()
	local operation = GameVoice._roomPending

	if operation then
		return operation.roomName, operation.isJoin
	else
		return nil
	end
end

function GameVoice._isInPending()
	return GameVoice._getRoomPending() ~= nil
end

function GameVoice._stopCurrentRoomOperation(isAbort)
	local joinEvent = isAbort and CallbackEvent.JOIN_TEAM_ROOM_ABORT or CallbackEvent.JOIN_TEAM_ROOM_FAIL
	local quitEvent = isAbort and CallbackEvent.QUIT_TEAM_ROOM_ABORT or CallbackEvent.QUIT_TEAM_ROOM_FAIL

	if GameVoice._isRoomOperationLocked() then
		local roomName, isJoin = GameVoice._getRoomRequest()

		GameVoice._setRoomRequest()

		if roomName ~= nil then
			if isJoin then
				GameVoice.handleError(joinEvent, roomName)
			else
				GameVoice.handleError(quitEvent, roomName)
			end
		end
	end
end

function GameVoice._callJoinTeamRoom(roomName, timeout)
	if GameVoice._isInPending() then
		return
	end

	GameVoice._setRoomPending(roomName, true)

	local ret = GameVoiceAgent.JoinTeamRoom(roomName, timeout)

	if ret ~= 0 then
		GameVoice.onGetEvent(GameVoiceEventType.JOIN_ROOM_FINISH, ret, roomName, nil)
	end
end

function GameVoice._callQuitTeamRoom(roomName, timeout)
	if GameVoice._isInPending() then
		return
	end

	GameVoice._setRoomPending(roomName, false)

	local ret = GameVoiceAgent.QuitRoom(roomName, timeout)

	if ret ~= 0 then
		GameVoice.onGetEvent(GameVoiceEventType.QUIT_ROOM_FINISH, ret, roomName, nil)
	end
end

function GameVoice._getPotentialRoom()
	local operationRoomName, _ = GameVoice._getRoomPending()

	return GameVoice._curRoomName or operationRoomName
end

function GameVoice._updateRoom()
	if GameVoice._isInPending() then
		return
	end

	if GameVoice.mode == GameVoiceMode.REAL_TIME then
		local roomName, isJoin = GameVoice._getRoomRequest()

		if roomName then
			local request = GameVoice._roomRequest

			if request.timesAll > 10 then
				GameVoice._stopCurrentRoomOperation()

				return
			end

			if isJoin then
				if roomName == GameVoice._curRoomName then
					GameVoice.callback(CallbackType.JOIN_TEAM_ROOM, true, {
						roomName = roomName
					})
					GameVoice._setRoomRequest(nil)
				else
					local tryForceJoin = request.timesQuitFailed % 5 == 4

					if GameVoice._curRoomName == nil or tryForceJoin then
						GameVoice._callJoinTeamRoom(roomName, ROOM_TIMEOUT_MS)
					else
						GameVoice._callQuitTeamRoom(GameVoice._curRoomName, ROOM_TIMEOUT_MS)
					end
				end
			elseif GameVoice._curRoomName == nil then
				GameVoice.callback(CallbackType.QUIT_TEAM_ROOM, true, {
					roomName = roomName
				})
				GameVoice._setRoomRequest(nil)
			else
				GameVoice._callQuitTeamRoom(roomName, ROOM_TIMEOUT_MS)
			end
		end
	else
		GameVoice._stopCurrentRoomOperation()
	end
end

function GameVoice._startRecording(filePath)
	local fileName

	if filePath ~= nil then
		fileName = getFileNameFromPath(filePath)
	end

	if fileName == nil then
		GameVoice.handleError(CallbackEvent.RECORD_FAIL)
	end

	local ret = GameVoiceAgent.StartRecording(filePath)

	if ret ~= 0 then
		GameVoice.handleError(CallbackEvent.RECORD_FAIL)
	else
		GameVoice._curRecordingPath = filePath

		GameVoice._addToFileList(fileName)
		GameVoice._timerRecording:Restart()
	end
end

function GameVoice._stopRecording(byUser, isAbort)
	if GameVoice._curRecordingPath ~= nil then
		local timer = GameVoice._timerRecording

		timer:Stop()

		GameVoice._curRecordedPath = GameVoice._curRecordingPath
		GameVoice._curRecordingPath = nil

		local ret = GameVoiceAgent.StopRecording()

		if ret ~= 0 then
			GameVoice.handleError(CallbackEvent.RECORD_FAIL)
		else
			local info = {
				filePath = GameVoice._curRecordedPath,
				byUser = byUser,
				isAbort = isAbort
			}

			GameVoice.callback(CallbackType.RECORD_MSG_END, true, info)
		end
	end
end

function GameVoice._onRecordingTimeout()
	GameVoice._stopRecording(false, false)
end

function GameVoice._uploadFile(filePath, isRetry)
	if filePath ~= nil then
		if isRetry then
			GameVoice._uploadQueue[filePath] = GameVoice._uploadQueue[filePath] + 1
		else
			GameVoice._uploadQueue[filePath] = 0
		end

		local retryTimes = GameVoice._uploadQueue[filePath]

		if retryTimes < RETRY_TIMES then
			local ret = GameVoiceAgent.UploadRecordedFile(filePath)

			if ret ~= 0 then
				GameVoice.handleError(CallbackEvent.UPLOAD_FAIL)
			end
		else
			GameVoice._stopUploadFile(filePath)
		end
	else
		GameVoice.handleError(CallbackEvent.UPLOAD_FAIL)
	end
end

function GameVoice._stopUploadFile(filePath)
	GameVoice._uploadQueue[filePath] = nil
end

function GameVoice._downloadFile(fileID, isRetry)
	if fileID ~= nil then
		local filePath, fileName = getFilePath(fileID)

		if isRetry then
			GameVoice._downloadQueue[fileID] = GameVoice._downloadQueue[fileID] + 1
		else
			GameVoice._downloadQueue[fileID] = 0

			GameVoice._addToFileList(fileName)
		end

		local retryTimes = GameVoice._downloadQueue[fileID]

		if retryTimes < RETRY_TIMES then
			local ret = GameVoiceAgent.DownloadFile(fileID, filePath)

			if ret ~= 0 then
				GameVoice.handleError(CallbackEvent.DOWNLOAD_FAIL, fileID)
			end
		else
			GameVoice._stopDownloadFile(fileID)

			if GameVoice._playAfterDownload == fileID then
				GameVoice._playAfterDownload = nil
			end

			GameVoice.handleError(CallbackEvent.DOWNLOAD_FAIL, fileID)
		end
	end
end

function GameVoice._stopDownloadFile(fileID)
	GameVoice._downloadQueue[fileID] = nil
end

function GameVoice._speechToText(fileID, isRetry)
	if fileID ~= nil then
		if isRetry then
			GameVoice._speechToTextQueue[fileID] = GameVoice._speechToTextQueue[fileID] + 1
		else
			GameVoice._speechToTextQueue[fileID] = 0
		end

		local retryTimes = GameVoice._speechToTextQueue[fileID]

		if retryTimes < RETRY_TIMES then
			if ChannelUtil.isPlaywith then
				GameVoice.onSpeechToTextFinish(0, fileID, Lang.get(29994))
			else
				local ret = GameVoiceAgent.SpeechToText(fileID)

				if ret ~= 0 then
					GameVoice.handleError(CallbackEvent.SPEECH_TO_TEXT_FAIL, fileID)
				end
			end
		else
			GameVoice._stopSpeechToText(fileID)
			GameVoice.handleError(CallbackEvent.SPEECH_TO_TEXT_FAIL, fileID)
		end
	end
end

function GameVoice._stopSpeechToText(fileID)
	GameVoice._speechToTextQueue[fileID] = nil
end

function GameVoice._playVoice(fileID)
	if fileID ~= nil then
		GameVoice._curPlayingID = fileID

		if GameVoice._playAfterDownload == fileID then
			GameVoice._playAfterDownload = nil
		end

		local filePath, fileName = getFilePath(fileID)
		local ret = GameVoiceAgent.PlayFile(filePath)

		if ret ~= 0 then
			GameVoice.handleError(CallbackEvent.PLAY_FAIL, fileID)
		end
	end
end

function GameVoice._getFileList()
	local path = GameVoice.parentPath .. FILE_LIST_FILE
	local fileList = {}
	local lines

	if isFileExists(path) then
		lines = io.lines(path)
	end

	if lines then
		for fileName in io.lines(path) do
			table.insert(fileList, fileName)
		end
	end

	return fileList
end

function GameVoice._addToFileList(fileName)
	local path = GameVoice.parentPath .. FILE_LIST_FILE
	local file = io.open(path, "a")

	if file then
		if type(fileName) == "string" then
			file:write(fileName, "\n")
		elseif type(fileName) == "table" then
			for i, item in pairs(fileName) do
				file:write(item, "\n")
			end
		end

		file:close()
	end
end

function GameVoice._overwriteFileList(fileName)
	local path = GameVoice.parentPath .. FILE_LIST_FILE
	local file = io.open(path, "w")

	if file then
		if type(fileName) == "string" then
			file:write(fileName, "\n")
		elseif type(fileName) == "table" then
			for i, item in pairs(fileName) do
				file:write(item, "\n")
			end
		end

		file:close()
	end
end

return GameVoice
