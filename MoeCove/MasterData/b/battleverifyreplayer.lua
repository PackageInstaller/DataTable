---@class BattleVerifyReplayer
local BattleVerifyReplayer = {}

local BattleCore = require "BattleCore"
local cjson = require "cjson"

---@type table
local replaySession = nil

local function updateReplayDisplayText(text)
	if replaySession then
		replaySession.orderDisplayText = text or replaySession.orderDisplayText or ""
	end
end

local function cloneTableIfTable(value)
	if type(value) == "table" then
		return tablex.clone(value)
	end
	return value
end

local function normalizeKeyValueTable(source)
	local result = {}
	if type(source) ~= "table" then
		return result
	end
	for key, value in pairs(source) do
		local numericKey = tonumber(key)
		local assignKey = numericKey or key
		if type(value) == "table" then
			result[assignKey] = tablex.clone(value)
		else
			result[assignKey] = value
		end
	end
	return result
end

local function normalizeArrayTable(source)
	if type(source) ~= "table" then
		return {}
	end
	local result = {}
	local maxIndex = 0
	for index, value in ipairs(source) do
		result[index] = value
		if index > maxIndex then
			maxIndex = index
		end
	end
	for key, value in pairs(source) do
		if type(key) ~= "number" then
			local numericKey = tonumber(key)
			if numericKey and numericKey > 0 then
				numericKey = math.floor(numericKey)
				result[numericKey] = value
				if numericKey > maxIndex then
					maxIndex = numericKey
				end
			end
		end
	end
	if maxIndex == 0 then
		local i = 1
		for _, value in pairs(source) do
			result[i] = value
			i = i + 1
		end
	end
	return result
end

local function decodeField(fieldValue)
	if fieldValue == nil then
		return nil, "missing"
	end
	if type(fieldValue) == "table" then
		return fieldValue
	end
	if type(fieldValue) == "string" then
		if fieldValue == "" then
			return nil, "empty"
		end
		-- Strip UTF-8 BOM if present and trim leading spaces
		fieldValue = fieldValue:gsub("^\239\187\191", "")
		fieldValue = fieldValue:gsub("^%s+", "")

		-- Try JSON first if it looks like JSON
		if fieldValue:sub(1, 1) == "{" or fieldValue:sub(1, 1) == "[" then
			local ok, decoded = pcall(cjson.decode, fieldValue)
			if ok and type(decoded) == "table" then
				return decoded
			end
		end

		-- Fallback: try parse as Lua table string
		local code = fieldValue
		if not code:match("^return%s") and code:match("^%s*[%[{]") then
			code = "return " .. code
		end
		local loader = _G.loadstring or _G.load
		if loader then
			local chunk, err = loader(code)
			if chunk then
				local ok, tbl = pcall(chunk)
				if ok and type(tbl) == "table" then
					return tbl
				end
				return nil, tbl or err or "lua_chunk_exec_failed"
			end
		end
		return nil, "decode_failed"
	end
	return nil, "invalid_type"
end

---@return BattleStartInfo?
local function normalizeBattleStartInfo(rawData)
	if type(rawData) ~= "table" then
		return nil
	end
	local data = tablex.clone(rawData)
	data.heroInfoMap = {}
	if type(rawData.heroInfoMap) == "table" then
		for key, info in pairs(rawData.heroInfoMap) do
			local heroCid = tonumber(key) or key
			local heroInfo = type(info) == "table" and tablex.clone(info) or {}
			local carryEquip = type(info) == "table" and info.carryEquip or nil
			local carryWeapon = type(info) == "table" and info.carryWeapon or nil
			local equippedSkillList = type(info) == "table" and info.EquippedSkillList or nil
			local passiveSkillList = type(info) == "table" and info.effectiveSkill or nil
			heroInfo.carryEquip = normalizeKeyValueTable(carryEquip)
			heroInfo.carryWeapon = normalizeArrayTable(carryWeapon)
			heroInfo.EquippedSkillList = normalizeArrayTable(equippedSkillList)
			heroInfo.effectiveSkill = normalizeArrayTable(passiveSkillList)
			data.heroInfoMap[heroCid] = heroInfo
		end
	end
	if rawData.weaponCidMap then
		data.weaponCidMap = normalizeKeyValueTable(rawData.weaponCidMap)
	end
	if rawData.levelInfo then
		data.levelInfo = cloneTableIfTable(rawData.levelInfo) or rawData.levelInfo
	end
	if rawData.formation then
		data.formation = normalizeArrayTable(rawData.formation)
	end
	return data
end

local function readFileContent(filePath)
	local file, openErr = io.open(filePath, "rb")
	if not file then
		return nil, { err = "open_failed", detail = openErr }
	end
	local content = file:read("*a")
	file:close()
	if not content or content == "" then
		return nil, { err = "empty_file" }
	end
	-- Normalize BOM/encoding (handle UTF-8/16/32 BOMs)
	-- UTF-8 BOM: EF BB BF (handled later too)
	-- UTF-16 LE: FF FE, UTF-16 BE: FE FF
	-- UTF-32 LE: FF FE 00 00, UTF-32 BE: 00 00 FE FF
	local b1 = content:byte(1) or 0
	local b2 = content:byte(2) or 0
	local b3 = content:byte(3) or 0
	local b4 = content:byte(4) or 0
	-- UTF-32 LE
	if b1 == 0xFF and b2 == 0xFE and b3 == 0x00 and b4 == 0x00 then
		-- collapse every 4 bytes into one byte (ASCII-safe)
		local out = {}
		for i = 5, #content, 4 do
			out[#out + 1] = string.char(content:byte(i))
		end
		content = table.concat(out)
	-- UTF-32 BE
	elseif b1 == 0x00 and b2 == 0x00 and b3 == 0xFE and b4 == 0xFF then
		local out = {}
		for i = 5, #content, 4 do
			out[#out + 1] = string.char(content:byte(i + 3))
		end
		content = table.concat(out)
	-- UTF-16 LE
	elseif b1 == 0xFF and b2 == 0xFE then
		local out = {}
		for i = 3, #content, 2 do
			out[#out + 1] = string.char(content:byte(i))
		end
		content = table.concat(out)
	-- UTF-16 BE
	elseif b1 == 0xFE and b2 == 0xFF then
		local out = {}
		for i = 3, #content, 2 do
			out[#out + 1] = string.char(content:byte(i + 1))
		end
		content = table.concat(out)
	end
	return content
end

local function extractPayload(content)
	-- Remove BOM and trim
	content = content:gsub("^\239\187\191", "")
	content = content:gsub("^%s+", "")

	-- Try JSON if looks like JSON
	if content:sub(1, 1) == "{" or content:sub(1, 1) == "[" then
		local ok, payload = pcall(cjson.decode, content)
		if ok and type(payload) == "table" then
			return payload
		end
	end

	-- Fallback: treat file as Lua returning a table (exported Lua report style)
	local code = content
	if not code:match("^return%s") and code:match("^%s*[%[{]") then
		code = "return " .. code
	end
	local loader = _G.loadstring or _G.load
	if loader then
		local chunk, err = loader(code)
		if chunk then
			local ok, tbl = pcall(chunk)
			if ok and type(tbl) == "table" then
				return tbl
			else
				return nil, { err = "lua_exec_failed", detail = tbl or err }
			end
		else
			return nil, { err = "lua_load_failed", detail = err }
		end
	end
	return nil, { err = "decode_failed", detail = "unsupported_format_or_invalid_json" }
end

local function parseOrderReport(payload)
	local orderReport, orderErr = decodeField(payload.orderReport or payload.order_report or payload.report)
	if not orderReport then
		return nil, { err = "orderReport_missing", detail = orderErr }
	end
	return orderReport
end

---@class ParseError
---@field err string
---@field detail any

---@return BattleStartInfo?, ParseError?
local function parseBattleStartInfo(payload)
	local battleStartRaw = payload.battleStartInfo
	local battleStartInfo, err = decodeField(battleStartRaw)
	if not battleStartInfo then
		return nil, { err = "battleStartInfo_missing", detail = err }
	end
	local r = normalizeBattleStartInfo(battleStartInfo)
	return r
end

local function parseRandomList(payload)
	local randomListRaw = payload.randomList
	local randomList, err = decodeField(randomListRaw)
	if not randomList then
		return nil, { err = "randomList_missing", detail = err }
	end
	if type(randomList) ~= "table" then
		return nil, { err = "randomList_invalid_type", detail = "expected_table" }
	end
	return randomList
end

local function collectFormationHeroCids(battleStartInfo)
	local heroCidList = {}
	for _, cid in ipairs(battleStartInfo.formation or {}) do
		heroCidList[#heroCidList + 1] = cid
	end
	if #heroCidList == 0 and type(battleStartInfo.heroInfoMap) == "table" then
		for cid, _ in pairs(battleStartInfo.heroInfoMap) do
			heroCidList[#heroCidList + 1] = tonumber(cid) or cid
		end
		table.sort(heroCidList, function(a, b)
			return tonumber(a) < tonumber(b)
		end)
	end
	return heroCidList
end

local function encodeOrderText(order, title, index, totalCount)
	if not order then
		return string.format("%s\n当前索引: %d/%d\n暂无操作战报。", title or "操作战报", index or 0, totalCount or 0)
	end
	local orderText = nil
	local ok, encoded = pcall(cjson.encode, order)
	if ok then
		orderText = encoded
	else
		orderText = tablex.dump(order)
	end
	return string.format("%s\n当前索引: %d/%d\n操作类型: %s\n%s", title or "操作战报", index or 0,
		totalCount or 0, tostring(order.type), orderText)
end

local function getSessionState(lastActionText)
	if not replaySession then
		return {
			filePath = "",
			levelId = 0,
			heroCids = {},
			totalOrderCount = 0,
			currentOrderIndex = 0,
			nextOrderIndex = 0,
			formationReady = false,
			started = false,
			finished = false,
			battleResultText = "未加载",
			lastActionText = lastActionText or "",
		}
	end

	local battleMgr = BattleCore:getBattleMgr()
	local orderMgr = battleMgr:getOrderManager()
	local currentOrderIndex = orderMgr and orderMgr:getCurrentIndex() or 0
	local totalOrderCount = orderMgr and orderMgr:getTotalCount() or replaySession.totalOrderCount or 0
	local finished = orderMgr and orderMgr:isFinished() or false
	local nextOrderIndex = 0
	if not finished and totalOrderCount > 0 then
		nextOrderIndex = math.min(currentOrderIndex + 1, totalOrderCount)
	end
	local battleResultText = "未结束"
	if battleMgr.gameResult == true then
		battleResultText = "胜利"
	elseif battleMgr.gameResult == false then
		battleResultText = "失败"
	end

	return {
		filePath = replaySession.filePath or "",
		levelId = replaySession.battleStartInfo and replaySession.battleStartInfo.level or 0,
		heroCids = replaySession.heroCids or {},
		totalOrderCount = totalOrderCount,
		currentOrderIndex = currentOrderIndex,
		nextOrderIndex = nextOrderIndex,
		formationReady = replaySession.formationReady == true,
		started = replaySession.started == true,
		finished = finished,
		battleResultText = battleResultText,
		lastActionText = lastActionText or replaySession.lastActionText or "",
	}
end

local function buildLoadResult(lastActionText, orderText)
	local state = getSessionState(lastActionText)
	replaySession.lastActionText = state.lastActionText
	updateReplayDisplayText(orderText)
	return state, orderText
end

---@param battleMgr BattleManager
---@param battleStartInfo BattleStartInfo
local function runSimpleVerify(battleMgr, battleStartInfo, simpleRaw)
	if not simpleRaw then
		return true
	end
	local simpleList, simpleErr = decodeField(simpleRaw)
	if not simpleList or type(simpleList) ~= "table" then
		LuaLogger.es("BattleVerifyReplayer: simple verify decode fail", simpleErr)
		return false
	end
	local isPass = true
	for _, simpleData in ipairs(simpleList) do
		if not battleMgr:simpleVerifyBattle(battleStartInfo, simpleData) then
			isPass = false
		end
	end
	return isPass
end

function BattleVerifyReplayer.replayFromFile(filePath, options)
	options = options or {}
	if type(filePath) ~= "string" or filePath == "" then
		return false, { err = "invalid_path" }
	end

	local content, readErr = readFileContent(filePath)
	if not content then
		LuaLogger.es("BattleVerifyReplayer: read file fail", filePath, readErr and readErr.detail)
		return false, readErr
	end

	local payload, payloadErr = extractPayload(content)
	if not payload then
		LuaLogger.es("BattleVerifyReplayer: payload decode fail", filePath, payloadErr and payloadErr.detail)
		return false, payloadErr
	end

	local orderReport, orderErr = parseOrderReport(payload)
	if not orderReport then
		LuaLogger.es("BattleVerifyReplayer: order report parse fail", filePath, orderErr and orderErr.detail)
		return false, orderErr
	end

	local battleStartInfo, startErr = parseBattleStartInfo(payload)
	if not battleStartInfo then
		LuaLogger.es("BattleVerifyReplayer: battle start parse fail", filePath, startErr)
		return false, { err = "battleStartInfo_parse_failed", detail = startErr }
	end

	GV.IsReplayingBattleId = battleStartInfo.level

	local battleMgr = BattleCore:getBattleMgr()
	local expectedResult = nil
	if orderReport.result ~= nil then
		expectedResult = (orderReport.result == GE.BattleResultType.Win)
	end

	local randomList, randomErr = parseRandomList(payload)
	if not randomList then
		LuaLogger.es("BattleVerifyReplayer: random list parse fail", filePath, randomErr and randomErr.detail)
	end

	local verifyResult = battleMgr:verifyBattle(battleStartInfo, orderReport, randomList)
	local expectationMatched = false

	-- local simpleVerifyResult = runSimpleVerify(battleMgr, battleStartInfo, payload.simpleVerifyData)
	

	local detail = {
		filePath = filePath,
		payload = payload,
		orderReport = orderReport,
		battleStartInfo = battleStartInfo,
		verifyResult = verifyResult,
		expectedResult = expectedResult,
		expectationMatched = expectationMatched,
		-- simpleVerifyResult = simpleVerifyResult,
	}

	LuaLogger.ds("BattleVerifyReplayer: replay finished", filePath, expectationMatched)
	return expectationMatched, detail
end

function BattleVerifyReplayer.loadReplaySessionFromFile(filePath)
	if type(filePath) ~= "string" or filePath == "" then
		return false, { err = "invalid_path" }
	end

	local content, readErr = readFileContent(filePath)
	if not content then
		return false, readErr
	end

	local payload, payloadErr = extractPayload(content)
	if not payload then
		return false, payloadErr
	end

	local orderReport, orderErr = parseOrderReport(payload)
	if not orderReport then
		return false, orderErr
	end

	local battleStartInfo, startErr = parseBattleStartInfo(payload)
	if not battleStartInfo then
		return false, { err = "battleStartInfo_parse_failed", detail = startErr }
	end

	local randomList = nil
	local randomListErr = nil
	randomList, randomListErr = parseRandomList(payload)
	if not randomList then
		LuaLogger.es("BattleVerifyReplayer: random list parse fail", filePath, randomListErr and randomListErr.detail)
	end

	GV.IsReplayingBattleId = battleStartInfo.level

	replaySession = {
		filePath = filePath,
		payload = payload,
		orderReport = orderReport,
		battleStartInfo = battleStartInfo,
		randomList = randomList,
		heroCids = collectFormationHeroCids(battleStartInfo),
		formationReady = false,
		started = false,
		finished = false,
		pendingEnterBattle = true,
		lastActionText = "正在按正常战斗流程进入关卡。",
		orderDisplayText = "正在加载战斗场景，请稍候。",
	}

	Me:setNowSelectLevel(battleStartInfo.level)
	LoadingMgr:SetLoadingStart(function()
        StateMgr:ChangeToState(GameFlowState.BattleState)
    end, nil, nil, "BattleVerifyReplayer")
	local state, displayText = buildLoadResult(replaySession.lastActionText, replaySession.orderDisplayText)
	return true, state, displayText
end

function BattleVerifyReplayer.startReplaySession()
	if not replaySession then
		return false, { err = "session_not_loaded" }
	end
	if replaySession.formationReady ~= true then
		return false, { err = "formation_not_ready" }
	end
	replaySession.started = true
	local battleMgr = BattleCore:getBattleMgr()
	battleMgr:setBattleState(GE.BattleState.WaitInputOrder)
	local orderMgr = battleMgr:getOrderManager()
	local nextOrder = orderMgr and orderMgr:getNextOrder() or nil
	local orderText = encodeOrderText(nextOrder, "待播放操作战报", (orderMgr and orderMgr:getCurrentIndex() or 0) + 1,
		orderMgr and orderMgr:getTotalCount() or 0)
	local state, displayText = buildLoadResult("战斗已开始，可逐步播放操作战报。", orderText)
	return true, state, displayText
end

function BattleVerifyReplayer.playNextReplayOrder()
	if not replaySession then
		return false, { err = "session_not_loaded" }
	end
	if replaySession.started ~= true then
		return false, { err = "session_not_started" }
	end

	local battleMgr = BattleCore:getBattleMgr()
	local orderMgr = battleMgr:getOrderManager()
	if not orderMgr then
		return false, { err = "order_manager_missing" }
	end
	if orderMgr:isFinished() then
		local finishedText = "操作战报已全部播放完成。"
		local state, displayText = buildLoadResult(finishedText, finishedText)
		return true, state, displayText
	end

	local nextOrderIndex = orderMgr:getCurrentIndex() + 1
	local nextOrder = orderMgr:getNextOrder()
	local played = battleMgr:stepVerifyBattleOrder()
	if played == false then
		local failText = "操作战报播放失败。"
		local state, displayText = buildLoadResult(failText, failText)
		return false, state, displayText
	end

	local totalOrderCount = orderMgr:getTotalCount()
	local playedText = encodeOrderText(nextOrder, "当前播放的操作战报", nextOrderIndex, totalOrderCount)
	local nextPendingOrder = orderMgr:getNextOrder()
	local orderText = playedText
	if nextPendingOrder then
		orderText = playedText .. "\n\n" .. encodeOrderText(nextPendingOrder, "下一条操作战报", orderMgr:getCurrentIndex() + 1,
			totalOrderCount)
		local state, displayText = buildLoadResult(string.format("已播放第 %d 条操作战报。", nextOrderIndex), orderText)
		return true, state, displayText
	end

	local finishText = playedText .. "\n\n操作战报已全部播放完成。"
	local state, displayText = buildLoadResult(string.format("已播放第 %d 条操作战报，全部完成。", nextOrderIndex), finishText)
	return true, state, displayText
end

function BattleVerifyReplayer.getReplaySessionState()
	local state = getSessionState()
	return state, replaySession and replaySession.orderDisplayText or ""
end

function BattleVerifyReplayer.hasPendingReplaySession()
	return replaySession ~= nil and replaySession.pendingEnterBattle == true
end

function BattleVerifyReplayer.getPendingReplaySession()
	return replaySession
end

function BattleVerifyReplayer.onReplayBattleEntered()
	if not replaySession then
		return
	end
	replaySession.pendingEnterBattle = false
	replaySession.lastActionText = "已进入对应关卡，正在根据战报上阵角色。"
	replaySession.orderDisplayText = "正在初始化战斗角色，请稍候。"
end

function BattleVerifyReplayer.onReplayFormationReady()
	if not replaySession then
		return
	end
	replaySession.formationReady = true
	replaySession.lastActionText = "已进入对应关卡，并完成战报角色上阵。"
	local battleMgr = BattleCore:getBattleMgr()
	local orderMgr = battleMgr and battleMgr:getOrderManager() or nil
	local nextOrder = orderMgr and orderMgr:getNextOrder() or nil
	local orderText = encodeOrderText(nextOrder, "待播放操作战报", 1, orderMgr and orderMgr:getTotalCount() or 0)
	updateReplayDisplayText(orderText)
end

function BattleVerifyReplayer.onReplayBattleEnd()
	if not replaySession then
		return
	end
	replaySession.finished = true
	replaySession.lastActionText = "战斗已结束。"
	replaySession.orderDisplayText = "战斗已结束。"
end

function BattleVerifyReplayer.OnReplayFail(failText)
	if not replaySession then
		return
	end
	replaySession.lastActionText = failText or "战斗回放失败。"
	replaySession.orderDisplayText = failText or "战斗回放失败。"
end

return BattleVerifyReplayer
