-- chunkname: @modules/logic/gm/wmz/WmzTesting.lua

package.path = package.path .. ";Assets/ZProj/Editor/Tools/RolePicker/?.lua"

rawset(_G, "prettycjson", require("prettycjson"))
module("modules.logic.gm.wmz.WmzTesting", package.seeall)

local sf = string.format
local ti = table.insert
local math_max = math.max
local RD = require("modules.logic.gm.gaosiniao.reverse_define")
local ChgTesting = require("modules.logic.gm.chg.ChgTesting")
local ser = require("modules.logic.gm.gaosiniao.ser")

local function _readAllText(filename)
	local fh = io.open(filename, "r")

	if not fh then
		logError("[_readAllText] file open failed: " .. filename)

		return ""
	end

	local res = fh:read("*a")

	fh:close()

	return res or ""
end

local function _isFileExists(assetPath)
	return SLFramework.FileHelper.IsFileExists(assetPath)
end

local function _writeTextToPath(filePath, content)
	SLFramework.FileHelper.WriteTextToPath(filePath, content)
end

local function _loadGameRawJson(assetPath)
	if not _isFileExists(assetPath) then
		return {}, ""
	end

	local jsonStr = _readAllText(assetPath)

	if string.nilorempty(jsonStr) then
		return {}, ""
	end

	local json = cjson.decode(jsonStr)
	local configName = json[1]
	local configList = json[2]

	return configList, configName
end

local function _loadPieceJson()
	local lua_activity220_wmz_map_piece = rawget(_G, "lua_activity220_wmz_map_piece")

	if lua_activity220_wmz_map_piece and lua_activity220_wmz_map_piece.configList then
		return
	end

	local jsonName = "json_activity220_wmz_map_piece.json"
	local luaName = "lua_activity220_wmz_map_piece"
	local jsonAssetPath = "Assets/ZResourcesLib/configs/excel2json/" .. jsonName
	local configText, configName = _loadGameRawJson(jsonAssetPath)

	if string.nilorempty(configName) then
		logError("invalid jsonAssetPath! jsonName=" .. tostring(jsonName))

		return
	end

	local modulePath = "modules/configs/excel2json/" .. luaName
	local luaConfig = addGlobalModule(modulePath, luaName)

	if not luaConfig then
		logError("invalid luaConfig! luaName=" .. tostring(luaName))

		return
	end

	luaConfig.onLoad(configText)
end

local s_getMapPieceCOList = {}

local function _getMapPieceCOList(mapId)
	if not s_getMapPieceCOList[mapId] then
		s_getMapPieceCOList[mapId] = {}

		for _, CO in ipairs(lua_activity220_wmz_map_piece.configList) do
			if CO.mapId == mapId then
				ti(s_getMapPieceCOList[mapId], CO)
			end
		end
	end

	return s_getMapPieceCOList[mapId]
end

local kWmzSpriteFolder = "Assets/ZResourcesLib/atlassrc/ui_spriteset/v3a7_wmz_spriteset/"

local function _genJson(mapCO)
	local mapId = mapCO.id

	if not mapCO.mapSizeX then
		if not mapCO.mapSizeY then
			local mapSizeY = 0

			_loadPieceJson()

			if not lua_activity220_wmz_map_piece then
				logError("lua_activity220_wmz_map_piece load failed")

				return
			end

			local jsonName = sf("json_activity220_wmz_map_%s.json", mapId)
			local luaName = sf("lua_activity220_wmz_map_%s", mapId)
			local jsonAssetPath = "Assets/ZResourcesLib/configs/excel2json/" .. jsonName
			local configText, configName = _loadGameRawJson(jsonAssetPath)

			if string.nilorempty(configName) then
				logError("invalid jsonAssetPath! jsonName=" .. tostring(jsonName))

				return
			end

			local modulePath = "modules/configs/excel2json/" .. luaName
			local luaConfig = addGlobalModule(modulePath, luaName)

			if not luaConfig then
				logError("invalid luaConfig! luaName=" .. tostring(luaName))

				return
			end

			luaConfig.onLoad(configText)

			local configList = luaConfig.configList
			local configDict = luaConfig.configDict
			local CO10000 = configDict[10000]
			local jsonMapStr = CO10000 and CO10000.content

			if string.nilorempty(jsonMapStr) then
				logError("invalid jsonMapStr! content must put into id=10000, luaName=" .. tostring(luaName))

				return
			end

			local finishedMapCOList = cjson.decode(jsonMapStr)
			local width = -1
			local height = -1
			local srcDict = {}
			local toDict = {}
			local dirtyDict = {}

			for _, cellInfo in ipairs(finishedMapCOList) do
				local x = cellInfo.x
				local y = cellInfo.y

				width = math.max(width, x)
				height = math.max(height, y)
				srcDict[x] = srcDict[x] or {}
				srcDict[x][y] = cellInfo
				dirtyDict[x] = dirtyDict[x] or {}
				dirtyDict[x][y] = false
			end

			local mapPieceCOList = _getMapPieceCOList(mapId)

			for _, CO in ipairs(mapPieceCOList) do
				local pieceResNamePrefix = CO.pieceResNamePrefix
				local pieceMinX = CO.pieceMinX
				local pieceMinY = CO.pieceMinY
				local pieceMaxX = CO.pieceMaxX
				local pieceMaxY = CO.pieceMaxY
				local num = 0

				WmzBattleMapMO.foreachLTRB(pieceMinX, pieceMinY, pieceMaxX, pieceMaxY, function(x, y)
					num = num + 1

					local sprite = sf(pieceResNamePrefix .. "%03d", num)

					srcDict[x] = srcDict[x] or {}

					local cellInfo = srcDict[x][y]

					if not cellInfo then
						cellInfo = WmzMapInfo.s_makeVoid(x, y)
						srcDict[x][y] = cellInfo
					end

					cellInfo.sprite = sprite
					cellInfo._fSprite = sprite

					local spriteAssetPath = kWmzSpriteFolder .. sprite .. ".png"

					if not _isFileExists(spriteAssetPath) then
						logError(sf("Sprite Not Found!\nsprite name:%s\npath:%s\nZone碎片组:%s\nmapId:%s\nPos:(%s,%s) in Range: (%s, %s) (%s, %s)", sprite, spriteAssetPath, CO.id, mapId, x, y, pieceMinX, pieceMinY, pieceMaxX, pieceMaxY))
					end
				end)
			end

			for _, CO in pairs(configList) do
				if CO ~= CO10000 then
					local fromX = CO.fromX
					local fromY = CO.fromY
					local toX = CO.toX
					local toY = CO.toY

					if not srcDict[fromX] or not srcDict[fromX][fromY] then
						logError(sf("%s - [%s] invalid fromXY: (%s,%s)", luaName, CO.id, fromX, fromY))
					end

					if not srcDict[toX] or not srcDict[toX][toY] then
						logError(sf("%s - [%s] invalid toXY: (%s,%s)", luaName, CO.id, toX, toY))
					end

					toDict[toX] = toDict[toX] or {}
					toDict[toX][toY] = tabletool.copy(srcDict[fromX][fromY])
					toDict[toX][toY].x = toX
					toDict[toX][toY].y = toY
					dirtyDict[fromX][fromY] = true
					dirtyDict[toX][toY] = false
				end
			end

			for _, v in pairs(srcDict) do
				for _, cellInfo in pairs(v) do
					local fromX = cellInfo.x
					local fromY = cellInfo.y
					local fromFSprite = cellInfo._fSprite
					local bDirty = dirtyDict[fromX][fromY]

					local function _simpleMakeCellInfo()
						toDict[fromX][fromY] = bDirty and WmzMapInfo.s_makeEmpty(fromX, fromY, cellInfo) or tabletool.copy(cellInfo)
					end

					if not toDict[fromX] then
						toDict[fromX] = {}

						_simpleMakeCellInfo()
					elseif not toDict[fromX][fromY] then
						_simpleMakeCellInfo()
					else
						toDict[fromX][fromY]._fSprite = fromFSprite
					end
				end
			end

			local tmpList = {}

			for _, v in pairs(toDict) do
				for _, cellInfo in pairs(v) do
					local ft = cellInfo.floorType
					local pt = cellInfo.pathType

					if WmzMapInfo.s_isTile(pt, ft) then
						cellInfo.zoneId = nil
					elseif WmzMapInfo.s_isStart(pt) then
						cellInfo.groupId = nil
					elseif (ft ~= WmzEnum.FloorType.Void or nil) and false then
						local zoneId = cellInfo.zoneId

						assert(zoneId and zoneId ~= 0, sf("invalid zoneId for non-tile and non-start cell! mapId:%s, pos:(%s,%s)", mapId, cellInfo.x, cellInfo.y))
					end

					if ft == WmzEnum.FloorType._edit_MoveableEmpty then
						ft = WmzEnum.FloorType.Passable
						cellInfo.pathType = WmzEnum.PathType.MoveableNone
					end

					if cellInfo.groupId == 0 then
						cellInfo.groupId = nil
					end

					if cellInfo.zoneId == 0 then
						cellInfo.zoneId = nil
					end

					if cellInfo.sprite == "" then
						cellInfo.sprite = nil
					end

					if ft == WmzEnum.FloorType.Void then
						cellInfo.groupId = nil
					end

					ti(tmpList, cellInfo)
				end
			end

			table.sort(tmpList, function(a, b)
				local ax, ay = a.x, a.y
				local bx, by = b.x, b.y
				local aTo0Dist = ax + ay
				local bTo0Dist = bx + by

				return aTo0Dist < bTo0Dist
			end)

			width = math_max(mapCO.mapSizeX, width)
			height = math_max(mapSizeY, height)

			local export = {
				width = width,
				height = height,
				girds = tmpList
			}
			local jsonStr = ser(export)
			local savePath = sf("Assets/ZProj/Scripts/Lua/modules/configs/wmz/map_%s.lua", mapId)
			local tbl = {}

			ti(tbl, "--start please save to " .. savePath)
			ti(tbl, "--auto gen by WmzTesting.lua")
			ti(tbl, "--json:" .. jsonAssetPath)
			ti(tbl, "--lua:" .. modulePath)
			ti(tbl, jsonStr)

			local content = table.concat(tbl, "\n")

			_writeTextToPath(savePath, content)
			logError(content)
		end
	end
end

WmzEnum.rDir = RD(WmzEnum, "Dir")
WmzEnum.rCorner = RD(WmzEnum, "Corner")
WmzEnum.rZoneMask = RD(WmzEnum, "ZoneMask")
WmzEnum.rFloorType = RD(WmzEnum, "FloorType")
WmzEnum.rPathType = RD(WmzEnum, "PathType")
WmzEnum.rPathSpriteId = RD(WmzEnum, "PathSpriteId")

function WmzEnum.nameOfPT(ePathType)
	local E = WmzEnum.PathType

	if ePathType == E.L then
		return "←"
	elseif ePathType == E.T then
		return "↑"
	elseif ePathType == E.R then
		return "→"
	elseif ePathType == E.B then
		return "→↓"
	elseif ePathType == E.RB then
		return "→↓"
	elseif ePathType == E.LT then
		return "←↑"
	elseif ePathType == E.LRTB then
		return "↑→↓←"
	elseif ePathType == E.TB then
		return "↑↓"
	elseif ePathType == E.LB then
		return "←↓"
	elseif ePathType == E.RT then
		return "↑→"
	elseif ePathType == E.LR then
		return "←→"
	elseif ePathType == E.LTB then
		return "←↑↓"
	elseif ePathType == E.RTB then
		return "↑↓→"
	elseif ePathType == E.LRB then
		return "←↓→"
	elseif ePathType == E.LRT then
		return "←↑→"
	elseif ePathType == E.None then
		return "None"
	elseif ePathType == E.MoveableNone then
		return "MoveableNone"
	else
		assert(false, "unsupported WmzEnum.PathType : " .. tostring(ePathType))
	end
end

function WmzEnum.nameOfFT(eFloorType)
	local E = WmzEnum.FloorType

	if eFloorType == E.Passable then
		return "Passable"
	elseif eFloorType == E.Wall then
		return "Wall"
	elseif eFloorType == E.Void then
		return "Void"
	elseif eFloorType == E.PassableEmpty then
		return "PassableEmpty"
	elseif eFloorType == E._edit_MoveableEmpty then
		return "_edit_MoveableEmpty"
	else
		assert(false, "unsupported WmzEnum.FloorType : " .. tostring(eFloorType))
	end
end

local kGreen = ChgTesting.kGreen
local kWhite = ChgTesting.kWhite
local kYellow = ChgTesting.kYellow
local kRed = ChgTesting.kRed
local kBlue = ChgTesting.kBlue
local kBlack = ChgTesting.kBlack

local function _unitTest1()
	return 1372301
end

local function _unitTest()
	return _unitTest1()
end

local TestingBase = _G.class("TestingBase")

function TestingBase:ctor()
	self._pb = DungeonModule_pb
	self._cCfg = WmzConfig
	self._cTaskCfg = TaskConfig
	self._pbTask = TaskModule_pb
end

function TestingBase:build_test()
	return
end

function TestingBase:link(obj)
	self._obj = obj
end

function TestingBase:actId()
	return self._cCfg.instance:actId()
end

function TestingBase:taskType()
	return self._cCfg.instance:taskType()
end

function TestingBase:getEpisodeCO(episodeId)
	local cfgObj = self._cCfg.instance

	if not episodeId or episodeId == 0 then
		return
	end

	return (cfgObj:getEpisodeCO(episodeId))
end

local kErrMsgServer = "myserver error"
local STesting = _G.class("STesting", TestingBase)

function STesting:ctor()
	TestingBase.ctor(self)

	self._actId2InfoDict = {}
	self._taskInfoDict = {}
	self._taskActivityInfoDict = {}
end

local kTest_CompleteCount = 6
local kBase_EpisodeId = 1311800

function STesting:_make_Act220Info(activityId)
	assert(activityId, kErrMsgServer)

	local act220EpisodeCOs = assert(lua_activity220_episode.configDict[activityId], kErrMsgServer .. activityId)
	local episodeId2Act220EpisodeRecord = {}

	for i, v in pairs(act220EpisodeCOs) do
		local episodeId = v.episodeId

		episodeId2Act220EpisodeRecord[episodeId] = self:_make_Act220EpisodeRecord(episodeId)
	end

	episodeId2Act220EpisodeRecord[0] = self:_make_Act220EpisodeRecord(0)

	local res = {
		activityId = activityId,
		episodeId2Act220EpisodeRecord = episodeId2Act220EpisodeRecord
	}

	for i = 1, kTest_CompleteCount do
		local episodeId = kBase_EpisodeId + i

		episodeId2Act220EpisodeRecord[episodeId].isFinished = true
	end

	return res
end

function STesting:handleGetAct220Info(req, reply)
	local activityId = req.activityId
	local info = self:_getInfo(activityId)

	if not info then
		info = self:_make_Act220Info(activityId)
		self._actId2InfoDict[activityId] = info
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodes", self:_getEpisodeList(activityId))
end

function STesting:handleAct220FinishEpisode(req, reply)
	local activityId = req.activityId
	local episodeId = req.episodeId
	local progress = req.progress
	local info = assert(self:_getInfo(activityId), kErrMsgServer)
	local act220EpisodeRecord = assert(info.episodeId2Act220EpisodeRecord[episodeId], kErrMsgServer)

	if episodeId == 0 then
		act220EpisodeRecord.isFinished = true
	else
		local episodeCO = assert(self:getEpisodeCO(episodeId), kErrMsgServer)

		if episodeCO.preEpisodeId > 0 then
			local preAct220EpisodeRecord = info.episodeId2Act220EpisodeRecord[episodeCO.preEpisodeId]

			assert(preAct220EpisodeRecord.isFinished, kErrMsgServer)
		end

		act220EpisodeRecord.isFinished = true
	end

	rawset(reply, "activityId", activityId)
	rawset(reply, "episodeId", episodeId)
	rawset(reply, "progress", progress)
end

function STesting:_make_taskInfos(typeId)
	local dict = {}

	if typeId == self:taskType() then
		for _, CO in ipairs(lua_activity220_task.configList) do
			local taskId = CO.id
			local activityId = CO.activityId

			dict[activityId] = dict[activityId] or {}

			if CO.isOnline then
				dict[activityId][taskId] = self:_make_TaskInfo(taskId, typeId)
			end
		end
	else
		assert(false, "please init task type: " .. typeId)
	end

	return dict
end

function STesting:_make_TaskActivityInfo(typeId)
	return {
		defineId = 0,
		expiryTime = 0,
		value = 0,
		gainValue = 0,
		typeId = typeId
	}
end

function STesting:handleGetTaskInfoReply(req, reply)
	local typeIds = req.typeIds
	local taskInfo = {}
	local activityInfo = {}

	for _, typeId in ipairs(typeIds) do
		self._taskInfoDict[typeId] = self._taskInfoDict[typeId] or self:_make_taskInfos(typeId)
		self._taskActivityInfoDict[typeId] = self._taskActivityInfoDict[typeId] or self:_make_TaskActivityInfo(typeId)

		for actId, actTable in pairs(self._taskInfoDict[typeId]) do
			if actId == self:actId() then
				for taskId, info in pairs(actTable) do
					table.insert(taskInfo, info)
				end
			end
		end

		table.insert(activityInfo, self._taskActivityInfoDict[typeId])
	end

	rawset(reply, "taskInfo", taskInfo)
	rawset(reply, "activityInfo", activityInfo)
	rawset(reply, "typeIds", typeIds)
end

function STesting:_getInfo(activityId)
	return self._actId2InfoDict[activityId]
end

function STesting:_make_TaskInfo(taskId, taskType)
	local taskCO = TaskModel.instance:getTaskConfig(taskType, taskId)

	assert(taskCO, kErrMsgServer)

	local maxProgress = taskCO.maxProgress
	local res = {
		hasFinished = false,
		expiryTime = 0,
		finishCount = 0,
		id = taskId,
		type = taskType,
		progress = math.random(0, maxProgress)
	}

	res.hasFinished = res.progress == maxProgress

	return res
end

local kResultCode = 0
local CTesting = _G.class("CTesting", TestingBase)

function CTesting:ctor()
	TestingBase.ctor(self)

	self._cRpc = DungeonRpc
	self._cCtrl = WmzController
	self._cWmzSysModel = WmzSysModel
	self._cBattleModel = WmzBattleModel
	self._cTaskRpc = TaskRpc
	self._cTaskModel = TaskModel
	self._cTaskController = TaskController
	self._cWmzViewBaseContainer = WmzViewBaseContainer
	self._cV3a7_Wmz_GameView = V3a7_Wmz_GameView
	self._cV3a7_Wmz_GameViewContainer = V3a7_Wmz_GameViewContainer
end

function CTesting:build_test()
	self:build_test__Wmz()
	self:build_test__Task()
end

function CTesting:build_test__Wmz()
	local rpcObj = self._cRpc.instance
	local pb = self._pb

	function self._cRpc.sendGetAct220InfoRequest(thisObj, activityId, cb, cbObj)
		local req = pb.GetAct220InfoRequest()

		req.activityId = activityId

		local reply = pb.GetAct220InfoReply()

		self._obj:handleGetAct220Info(req, reply)
		rpcObj:onReceiveGetAct220InfoReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct220FinishEpisodeRequest(thisObj, activityId, episodeId, progress, cb, cbObj)
		local req = pb.Act220FinishEpisodeRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.progress = progress or ""

		local reply = pb.Act220FinishEpisodeReply()

		self._obj:handleAct220FinishEpisode(req, reply)
		rpcObj:onReceiveAct220FinishEpisodeReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct220SaveEpisodeProgressRequest(thisObj, activityId, episodeId, progress, cb, cbObj)
		local req = pb.Act220SaveEpisodeProgressRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.progress = progress or ""

		local reply = pb.Act220SaveEpisodeProgressReply()

		self._obj:handleAct220SaveEpisodeProgress(req, reply)
		rpcObj:onReceiveAct220FinishEpisodeReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cRpc.sendAct220ChooseEpisodeBranchRequest(thisObj, activityId, episodeId, branchId, cb, cbObj)
		local req = pb.Act220ChooseEpisodeBranchRequest()

		req.activityId = activityId
		req.episodeId = episodeId
		req.branchId = branchId

		local reply = pb.Act220ChooseEpisodeBranchReply()

		self._obj:handleAct220ChooseEpisodeBranch(req, reply)
		rpcObj:onReceiveAct220ChooseEpisodeBranchReply(kResultCode, reply)

		local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

		if cb then
			if cbObj then
				cb(cbObj, cmd, kResultCode)
			else
				cb(cmd, kResultCode)
			end
		end
	end

	function self._cV3a7_Wmz_GameViewContainer.openInternal(thisObj, viewParam, ...)
		local modelInst = self._cBattleModel.instance
		local episodeId = modelInst:episodeId()

		modelInst:onInit()

		modelInst._episodeId = episodeId

		thisObj:restart()
		self._cV3a7_Wmz_GameViewContainer.super.openInternal(thisObj, viewParam, ...)
	end

	function self._cV3a7_Wmz_GameViewContainer.buildViews(thisObj)
		thisObj._mainView = V3a7_Wmz_GameView.New()

		return {
			thisObj._mainView
		}
	end

	function self._cV3a7_Wmz_GameViewContainer.restart(thisObj)
		local modelInst = self._cBattleModel.instance
		local _mapMO = modelInst._mapMO
		local mapId = _unitTest()

		_mapMO:restart(mapId)
	end

	function self._cWmzViewBaseContainer.saveInt(key, value)
		logError("saveInt:" .. tostring(key) .. " value=" .. tostring(value))
	end

	function self._cWmzViewBaseContainer.showV3a7_Wmz_GameStartView()
		return
	end
end

function CTesting:build_test__Task()
	local rpcObj = self._cTaskRpc.instance
	local pb = self._pbTask

	function self._cTaskRpc.sendGetTaskInfoRequest(thisObj, typeIds, callback, callbackObj)
		local req = pb.GetTaskInfoRequest()

		for _, v in pairs(typeIds) do
			table.insert(req.typeIds, v)
		end

		if #typeIds == 1 and typeIds[1] == self:taskType() then
			local reply = pb.GetTaskInfoReply()

			self._obj:handleGetTaskInfoReply(req, reply)
			rpcObj:onReceiveGetTaskInfoReply(kResultCode, reply)

			local cmd = LuaSocketMgr.instance:getCmdByPbStructName(req.__cname)

			if callback then
				if callbackObj then
					callback(callbackObj, cmd, kResultCode)
				else
					callback(cmd, kResultCode)
				end
			end
		else
			return thisObj:sendMsg(req, callback, callbackObj)
		end
	end
end

local WmzTesting = _G.class("WmzTesting")

function WmzTesting:ctor()
	self._client = CTesting.New()
	self._sever = STesting.New()

	self._sever:link(self._client)
	self._client:link(self._sever)
end

function WmzTesting:_test()
	self._client:build_test()
	self._sever:build_test()
end

function WmzTesting:_offline_test()
	local myActId = self._client:actId()

	logError(myActId)

	if not myActId then
		logError("WmzTesting offline test error: can not found actId")

		return
	end

	local myStartTime = os.time() * 1000
	local myEndTime = myStartTime + 259200
	local myActivityInfo = {
		activityInfos = {
			{
				currentStage = 0,
				isUnlock = true,
				online = true,
				isReceiveAllBonus = false,
				isNewStage = false,
				id = myActId,
				startTime = myStartTime,
				endTime = myEndTime
			}
		}
	}

	ActivityModel.instance:setActivityInfo(myActivityInfo)
	WmzTesting.instance:_test()

	if not WmzTesting.s_fistOpenGm then
		GMController.instance:openGMView()

		WmzTesting.s_fistOpenGm = true

		return
	end

	ViewMgr.instance:closeView(ViewName.GMToolView)
	ViewMgr.instance:closeView(ViewName.GMToolView2)

	if not WmzTesting.s_V3a7_Wmz_GameView then
		ViewMgr.instance:openView(ViewName.V3a7_Wmz_GameView)

		WmzTesting.s_V3a7_Wmz_GameView = true
	else
		WmzTesting.s_V3a7_Wmz_GameView = false

		ViewMgr.instance:closeView(ViewName.V3a7_Wmz_GameView)
	end

	do return end

	self:genAllJson()
end

function WmzTesting:genAllJson()
	for _, CO in ipairs(lua_activity220_wmz_map.configList) do
		callWithCatch(_genJson, CO)
	end
end

WmzTesting.instance = WmzTesting.New()
WmzTesting.setColorDesc = ChgTesting.setColorDesc
WmzTesting.kGreen = kGreen
WmzTesting.kWhite = kWhite
WmzTesting.kYellow = kYellow
WmzTesting.kRed = kRed
WmzTesting.kBlue = kBlue
WmzTesting.kBlack = kBlack

return WmzTesting
