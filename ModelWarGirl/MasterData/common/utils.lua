-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\utils.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResHero = require("ClientData/ResHero")
local Equip = require("Common/Object/Equip")
local Artifact = require("Common/Object/Artifact")
local Hero = require("Common/Object/Hero")
local Monster = require("Common/Object/Monster")
local ResMaze = require("ClientData/ResMaze")
local ResStar = require("ClientData/ResStar")
local ResItem = require("ClientData/ResItem")
local ResHeroRecharge = require("ClientData/ResHeroRecharge")
local ResArtifactXP = require("ClientData/ResArtifactXP")
local ResEquipMainProp = require("ClientData/ResEquipMainProp")
local ResEquipMainPropTempl = require("ClientData/ResEquipMainPropTempl")
local ResStep = require("ClientData/ResStep")
local ResBattleToolRobot = require("ClientData/ResBattleToolRobot")
local ResBattleToolProp = require("ClientData/ResBattleToolProp")
local ResLevelCost = require("ClientData/ResLevelCost")
local ResStepCost = require("ClientData/ResStepCost")
local ResHeroResetMisc = require("ClientData/ResHeroResetMisc")
local ResColor = require("ClientData/ResColor")
local ResCommonModel = require("ClientData/ResCommonModel")
local ResModelPath = require("ClientData/ResModelPath")
local ResMonster = require("ClientData/ResMonster")
local ResPassiveSkill = require("ClientData/ResPassiveSkill")
local ResArtifactLevelUp = require("ClientData/ResArtifactLevelUp")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ResMazeInitConfig = require("ClientData/ResMazeInitConfig")
local ResBattleRobot = require("ClientData/ResBattleRobot")
local ResWorldBoss = require("ClientData/ResWorldBoss")
local FashionResource = require("ClientData/FashionResource")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local Relic = require("Common/Object/Relic")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local ResRearHouseGroup = require("ClientData/ResRearHouseGroup")
local ResRearHouseGroupEffect = require("ClientData/ResRearHouseGroupEffect")
local ResAbilityStore = require("ClientData/ResAbilityStore")
local ResHeroProficientLevel = require("ClientData/ResHeroProficientLevel")
local ResHeroProficientScore = require("ClientData/ResHeroProficientScore")
local ResURHeroProficientLevel = require("ClientData/ResURHeroProficientLevel")
local ResOpActTowerStage = require("ClientData/ResOpActTowerStage")
local ResRentTask = require("ClientData/ResRentTask")
local ResRentMisc = require("ClientData/ResRentMisc")
local ResRentStageConfig = require("ClientData/ResRentStageConfig")
local ResClanBattleSkill = require("ClientData/ResClanBattleSkill")
local ResClanBattleRune = require("ClientData/ResClanBattleRune")
local ResClanBattleTalent = require("ClientData/ResClanBattleTalent")
local ResClanBattleAverageLv = require("ClientData/ResClanBattleAverageLv")
local ResClanHeadFrame = require("ClientData/ResClanHeadFrame")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local ResOpActClanBossLevelScore = require("ClientData/ResOpActClanBossLevelScore")
local ResOpActClanBossStarScore = require("ClientData/ResOpActClanBossStarScore")
local ResOpActClanBossPaintScore = require("ClientData/ResOpActClanBossPaintScore")
local ResOpActClanBossStepScore = require("ClientData/ResOpActClanBossStepScore")
local ResStageBonusPredict = require("ClientData/ResStageBonusPredict")
local ResOpActTowerBossAward = require("ClientData/ResOpActTowerBossAward")
local ResHeroCrystalProp = require("ClientData/ResHeroCrystalProp")
local ResPushGiftContent = require("ClientData/ResPushGiftContent")
local ResRandClient = require("ClientData/ResRandClient")
local ResRecharge = require("ClientData/ResRecharge")
local ResVowContent = require("ClientData/ResVowContent")
local ResDevelopMisc = require("ClientData/ResDevelopMisc")
local Pet = require("Common/Object/Pet")
local PetAmulet = require("Common/Object/PetAmulet")
local PetGem = require("Common/Object/PetGem")
local ResRoleHeadPendant = require("ClientData/ResRoleHeadPendant")
local IS_PUBLISH_VERSION = IS_PUBLISH_VERSION
local lBit

if IsGLDeclared("bit") then
	lBit = bit
else
	lBit = require("bit")
end

local __utils = {}

__utils._utf8Headers = {
	0,
	192,
	224,
	240,
	248,
	252
}

function __utils.getLogging(logger)
	return function(title, message)
		if logger then
			if message and type(message) == "string" then
				logger:info(title .. message)
			elseif message and type(message) == "table" then
				logger:info(title .. __utils.dumpTab(message))
			else
				logger:info(title)
			end
		end
	end
end

function __utils.setLoggingLogger(logger)
	__utils.logToLogger = __utils.getLogging(logger)
end

__utils.setLoggingLogger()

function __utils.getIndexByValue(argTable, argValue)
	if not argTable or not argValue then
		return -1
	end

	for i, value in ipairs(argTable) do
		if value == argValue then
			return i
		end
	end

	return -1
end

function __utils.getSortingFunc(attrName, isLess)
	return function(a, b)
		if a[attrName] and b[attrName] then
			if isLess then
				return a[attrName] < b[attrName]
			else
				return a[attrName] > b[attrName]
			end
		elseif a[attrName] then
			return true
		end
	end
end

function __utils.getTableElemCount(tab, exceptNil)
	if not tab then
		return 0
	end

	local count = 0

	for k, value in pairs(tab) do
		if exceptNil then
			if value ~= nil then
				count = count + 1
			end
		else
			count = count + 1
		end
	end

	return count
end

function __utils.copyTable(table)
	local newTable = {}

	for i, value in pairs(table) do
		newTable[i] = value
	end

	return newTable
end

function __utils.clearTable(tab)
	if not tab then
		return
	end

	local list = {}

	for k, v in pairs(tab) do
		table.insert(list, k)
	end

	for i = #list, 1, -1 do
		tab[list[i]] = nil
	end
end

function __utils.dumpTab(tab)
	return __utils.execDumpTab(tab, nil, {})
end

function __utils.execDumpTab(tab, ind, parentTabs)
	if tab == nil then
		return "nil"
	end

	local str = "{"
	local ind = ind or "  "

	parentTabs[tab] = true

	for k, v in pairs(tab) do
		if type(k) == "string" then
			k = tostring(k) .. " = "
		else
			k = "[" .. tostring(k) .. "] = "
		end

		local s = ""

		if type(v) == "nil" then
			s = "nil"
		elseif type(v) == "boolean" then
			if v then
				s = "true"
			else
				s = "false"
			end
		elseif type(v) == "number" then
			s = v
		elseif type(v) == "string" then
			if v:find("\x00") then
				s = "BIT_STR"
			else
				s = "\"" .. v .. "\""
			end
		elseif type(v) == "table" then
			if parentTabs[v] ~= true then
				s = __utils.execDumpTab(v, ind .. "  ", parentTabs)
				s = string.sub(s, 1, #s - 1)
			else
				s = tostring(v)
			end
		elseif type(v) == "function" then
			s = "function"
		elseif type(v) == "thread" then
			s = "thread : " .. tostring(v)
		elseif type(v) == "userdata" then
			s = "userdata : " .. tostring(v)
		else
			s = "nuknow : " .. tostring(v)
		end

		str = str .. "\n" .. ind .. k .. s .. " ,"
	end

	parentTabs[tab] = nil

	local sss = string.sub(str, 1, #str - 1)

	if #ind > 0 then
		ind = string.sub(ind, 1, #ind - 2)
	end

	sss = sss .. "\n" .. ind .. "}\n"

	return sss
end

function __utils.thorLog(t, logtype, tag)
	if tag ~= nil then
		-- block empty
	end

	logtype = logtype or 0

	local logFunc

	if logtype == 0 then
		logFunc = log
	elseif logtype == 1 then
		logFunc = logwarning
	else
		logFunc = logerror
	end

	if type(t) ~= "table" then
		logFunc(t)
	else
		local tolog = __utils.dumpTab(t)

		logFunc(tolog)
	end
end

function __utils.splitString(str, delimiter)
	if str == nil or str == "" or delimiter == nil then
		return {
			str
		}
	end

	local matchDet = string.gsub(delimiter, "([%(%)%.%%%+%-%*%?%[%^%$])", "%%%1")
	local result = {}

	for match in (str .. delimiter):gmatch("(.-)" .. matchDet) do
		table.insert(result, match)
	end

	return result
end

function __utils.splitStringIntoArgs(str, delimiter, argCount)
	local args = __utils.splitString(str, delimiter)

	if argCount then
		for i = 1, argCount - #args do
			table.insert(args, "")
		end
	end

	return unpack(args)
end

function __utils.trimStartEnd(str)
	if not str then
		return
	end

	return string.gsub(str, "^[%s]*(.-)[%s]*$", "%1")
end

function __utils.replaceString(s, pattern, repl)
	local i, j = string.find(s, pattern, 1, true)

	if i and j then
		local ret = {}
		local start = 1

		while i and j do
			table.insert(ret, string.sub(s, start, i - 1))
			table.insert(ret, repl)

			start = j + 1
			i, j = string.find(s, pattern, start, true)
		end

		table.insert(ret, string.sub(s, start))

		return table.concat(ret)
	end

	return s
end

function __utils.serialize(t)
	local mark = {}
	local assign = {}

	local function table2str(t, parent)
		mark[t] = parent

		local ret = {}

		for f, v in pairs(t) do
			local k = type(f) == "number" and "[" .. f .. "]" or "['" .. f .. "']"
			local dotkey = parent .. k
			local t = type(v)

			if t == "userdata" or t == "function" or t == "thread" or t == "proto" or t == "upval" then
				-- block empty
			elseif t == "table" then
				if mark[v] then
					table.insert(assign, dotkey .. "=" .. mark[v])
				else
					table.insert(ret, string.format("%s=%s", k, table2str(v, dotkey)))
				end
			elseif t == "string" then
				table.insert(ret, string.format("%s=%q", k, v))
			elseif t == "number" then
				if v == math.huge then
					table.insert(ret, string.format("%s=%s", k, "math.huge"))
				elseif v == -math.huge then
					table.insert(ret, string.format("%s=%s", k, "-math.huge"))
				else
					table.insert(ret, string.format("%s=%s", k, tostring(v)))
				end
			else
				table.insert(ret, string.format("%s=%s", k, tostring(v)))
			end
		end

		return "{" .. table.concat(ret, ",") .. "}"
	end

	if type(t) == "table" then
		return string.format("%s%s", table2str(t, "_"), table.concat(assign, " "))
	else
		return tostring(t)
	end
end

function __utils.unserialize(str)
	local EMPTY_TABLE = {}

	if str == nil or str == "nil" then
		return nil
	elseif type(str) ~= "string" then
		return EMPTY_TABLE
	elseif #str == 0 then
		return EMPTY_TABLE
	end

	local code, ret = pcall(loadstring(string.format("do local _=%s return _ end", str)))

	if code then
		return ret
	else
		return EMPTY_TABLE
	end
end

function __utils.utf8len(input, chnCount)
	if chnCount == nil then
		chnCount = 1
	end

	local len = string.len(input)
	local left = len
	local cnt = 0
	local arr = __utils._utf8Headers

	while left ~= 0 do
		local tmp = string.byte(input, -left)
		local i = #arr
		local count = 1

		while arr[i] do
			if tmp >= arr[i] then
				left = left - i

				if i ~= 1 then
					count = chnCount
				end

				break
			end

			i = i - 1
		end

		cnt = cnt + count
	end

	return cnt
end

function __utils.substring(input, chnCount, keepLength)
	if chnCount == nil then
		chnCount = 1
	end

	local len = 0
	local left = 1
	local byteLen = string.len(input)
	local arr = __utils._utf8Headers

	while left < byteLen do
		local tmp = string.byte(input, left)
		local i = #arr
		local count = 1

		while arr[i] do
			if tmp >= arr[i] then
				if i ~= 1 then
					count = chnCount
				end

				break
			end

			i = i - 1
		end

		len = len + count

		if keepLength < len then
			break
		else
			left = left + i
		end
	end

	return string.sub(input, 1, left - 1)
end

function __utils.utf8Substring(input, startIndex, endIndex)
	local startByte = 0
	local endByte = 0
	local len = string.len(input)
	local left = len
	local curIndex = 1
	local curByte = 1
	local arr = __utils._utf8Headers

	while left > 0 do
		if startIndex == curIndex then
			startByte = curByte
		end

		if startByte ~= 0 and endByte ~= 0 then
			break
		end

		local tmp = string.byte(input, -left)
		local i = #arr

		while arr[i] do
			if tmp >= arr[i] then
				left = left - i
				curByte = curByte + i

				break
			end

			i = i - 1
		end

		if endIndex == curIndex then
			endByte = curByte - 1
		end

		if startByte ~= 0 and endByte ~= 0 then
			break
		end

		curIndex = curIndex + 1
	end

	if startByte == 0 or endByte == 0 then
		return nil
	else
		return string.sub(input, startByte, endByte)
	end
end

function __utils.deepcopy(ori_tab)
	if type(ori_tab) ~= "table" then
		return nil
	end

	local new_tab = {}

	for i, v in pairs(ori_tab) do
		local vtyp = type(v)

		if vtyp == "table" then
			new_tab[i] = utils.deepcopy(v)
		elseif vtyp == "thread" then
			new_tab[i] = v
		elseif vtyp == "userdata" then
			new_tab[i] = v
		else
			new_tab[i] = v
		end
	end

	return new_tab
end

function __utils.deepcompare(t1, t2)
	if t1 == t2 then
		return true
	end

	local ty1, ty2 = type(t1), type(t2)

	if ty1 ~= ty2 then
		return false
	end

	if ty1 ~= "table" then
		return t1 == t2
	end

	local checked = {}

	for k1, v1 in pairs(t1) do
		local v2 = t2[k1]

		if v2 == nil or not __utils.deepcompare(v1, v2) then
			return false
		end

		checked[k1] = true
	end

	for k2, v2 in pairs(t2) do
		if not checked[k2] then
			local v1 = t1[k2]

			if v1 == nil or not __utils.deepcompare(v1, v2) then
				return false
			end
		end
	end

	return true
end

function __utils.formatNumber(num)
	local places = {
		"",
		Lang.get(1773),
		Lang.get(50264),
		Lang.get(50265),
		Lang.get(50266),
		Lang.get(1773),
		Lang.get(50264),
		Lang.get(50265),
		Lang.get(50267),
		Lang.get(1773),
		Lang.get(50264),
		Lang.get(50265),
		Lang.get(50266)
	}

	if type(num) ~= "number" then
		return string.format(num .. "is not a num")
	end

	local numStr = tostring(num)
	local len = string.len(numStr)
	local str = ""
	local has0 = false

	for i = 1, len do
		local n = tonumber(string.sub(numStr, i, i))
		local p = len - i + 1

		if n > 0 and has0 == true then
			str = str .. "零"
			has0 = false
		end

		if p % 4 == 2 and n == 1 then
			if p < len then
				str = str .. Const.NUMBER_TO_WORD[n]
			end

			str = str .. places[p]
		elseif n > 0 then
			str = str .. Const.NUMBER_TO_WORD[n]
			str = str .. places[p]
		elseif n == 0 then
			if p % 4 == 1 then
				str = str .. places[p]
			else
				has0 = true
			end
		end
	end

	return str
end

function __utils.isTablesSame(table1, table2)
	if #table1 == #table2 then
		for _, value in pairs(table1 or {}) do
			if not utils.tableIsContainsElement(table2, value) then
				return false
			end
		end

		return true
	end

	return false
end

function __utils.tableIsContainsElement(table, element)
	for _, value in pairs(table or {}) do
		if value == element then
			return true
		end
	end

	return false
end

function __utils.getTableValue(tab, keyName, defValue)
	if tab == nil then
		tab = {}
	end

	local v = tab[keyName]

	if v == nil or v == 0 or v == "" then
		return defValue
	else
		return v
	end
end

function __utils.getLength(v1)
	if v1 == nil then
		return nil
	end

	local l = 0

	for i, _ in ipairs(v1) do
		l = l + v1[i]^2
	end

	return l^0.5
end

local vector_keys = {
	"x",
	"y",
	"z"
}

function __utils.getDistance(v1, v2)
	if v1 == nil or v2 == nil or #v1 ~= #v2 then
		return nil
	end

	local acc = 0

	if v1[1] then
		for i, _ in ipairs(v1) do
			acc = acc + (v2[i] - v1[i])^2
		end
	else
		for _, key in ipairs(vector_keys) do
			acc = acc + (v2[key] - v1[key])^2
		end
	end

	return acc^0.5
end

function __utils.getDistance2D(x1, y1, x2, y2)
	return ((x2 - x1)^2 + (y2 - y1)^2)^0.5
end

function __utils.isCloseEnough(v1, v2, distance)
	if distance == nil or distance < 0 then
		return nil
	end

	return distance >= __utils.getDistance(v1, v2)
end

function __utils.dot(v1, v2)
	if v1 == nil or v2 == nil or #v1 ~= #v2 then
		return nil
	end

	local dot = 0

	for i, _ in ipairs(v1) do
		dot = dot + v2[i] * v1[i]
	end

	return dot
end

function __utils.normalize(v1)
	if v1 == nil then
		return nil
	end

	local length = __utils.getLength(v1)

	if length == 0 then
		return nil
	end

	local normal = {}

	for i, _ in ipairs(v1) do
		normal[i] = v1[i] / length
	end

	return normal
end

function __utils.getNearest(posOrigin, entries, fields)
	if type(posOrigin) ~= "table" or type(entries) ~= "table" then
		return
	end

	local minDis = math.huge
	local minPos, minIndex, curDis

	for i, curPos in pairs(entries) do
		if fields ~= nil then
			for _, field in ipairs(fields) do
				curPos = curPos[field]

				if curPos == nil then
					break
				end
			end
		end

		curDis = __utils.getDistance(posOrigin, curPos)

		if curDis ~= nil and curDis < minDis then
			minIndex = i
			minPos = curPos
			minDis = curDis
		end
	end

	return minIndex
end

function __utils.getBitsDictFromByteString(byteString)
	if not byteString then
		return {}
	end

	local bytesList = {
		byteString:byte(1, -1)
	}
	local bitCount = 8
	local bitList = {}

	for index = 1, #bytesList do
		for j = 1, bitCount do
			if lBit.band(bytesList[index], lBit.lshift(1, bitCount - j)) ~= 0 then
				local position = (index - 1) * bitCount + j

				bitList[position] = true
			end
		end
	end

	return bitList
end

function __utils.getBitsListFromByteString(byteString)
	if not byteString then
		return {}
	end

	local bytesList = {
		byteString:byte(1, -1)
	}
	local bitCount = 8
	local bitList = {}

	for index = 1, #bytesList do
		for j = 1, bitCount do
			if lBit.band(bytesList[index], lBit.lshift(1, bitCount - j)) ~= 0 then
				local position = (index - 1) * bitCount + j

				table.insert(bitList, position)
			end
		end
	end

	return bitList
end

function __utils.getNumListFromString(str, delimiter)
	local numStrList = utils.splitString(str, delimiter)
	local numList = {}

	for _, numStr in ipairs(numStrList) do
		if numStr ~= "" then
			local num = tonumber(numStr)

			if num then
				table.insert(numList, num)
			end
		end
	end

	return numList
end

function __utils.getAbilityList(heroId, ability)
	local abilityList = {}

	if ResAbilityStore[heroId] then
		local abilityStore = ResAbilityStore[heroId].ability_store
		local abilityPosList = __utils.getBitsListFromByteString(ability)

		for _, abilityIndex in ipairs(abilityPosList) do
			if abilityStore[abilityIndex] then
				table.insert(abilityList, abilityStore[abilityIndex])
			end
		end
	end

	return abilityList
end

function __utils.getPaintData(heroId, paintLv, ability)
	local paintData = {}

	paintData.level = paintLv
	paintData.abilityList = {}

	if ability then
		paintData.abilityList = __utils.getAbilityList(heroId, ability)
	end

	local paintRecipeId = ResHero[heroId].paint_id

	if ResHeroPaint[paintRecipeId] and ResHeroPaint[paintRecipeId][paintData.level] then
		paintData.resData = ResHeroPaint[paintRecipeId][paintData.level]

		return paintData
	end
end

function __utils.getRelationPointData(pointSvrData)
	local pointData = {}

	for relationPoint, relationPointData in ipairs(pointSvrData) do
		pointData[relationPoint] = {}
		pointData[relationPoint].level = relationPointData.level
	end

	return pointData
end

function __utils.getStickData(stickSvrData)
	return {
		id = stickSvrData.id,
		level = stickSvrData.stick_level
	}
end

function __utils.getRelationPointBattleState(heroId, pointData)
	local vowPointId = 7

	if pointData[7] then
		local maxLevel = ResDevelopMisc[vowPointId].max_level

		if maxLevel <= pointData[7].level then
			return ResVowContent[heroId].state_id
		end
	end
end

function __utils.addStateContainer(container, state_id, state_lv)
	state_lv = state_lv or 1

	for index, info in ipairs(container) do
		if info[1] == state_id then
			if state_lv == info[2] then
				info[3] = info[3] + 1
			elseif state_lv > info[2] then
				info[2] = state_lv
			end

			return
		end
	end

	table.insert(container, {
		state_id,
		state_lv,
		1
	})
end

function __utils.addPassiveContainer(container, passive_id, passive_lv)
	passive_lv = passive_lv or 1

	for index, info in ipairs(container) do
		if info[1] == passive_id then
			return
		end
	end

	table.insert(container, {
		passive_id,
		passive_lv
	})
end

function __utils.addAttrContainer(container, serverName, attrValue)
	local attrName = BattleConst.PROP_TYPE_CONFIG[serverName]

	if attrName then
		container[attrName] = (container[attrName] or 0) + attrValue
	end
end

function __utils.getBattleConfigRobots(battleConfig, robot)
	local heros = {}
	local robots = battleConfig.robots or {}

	for _, info in ipairs(robot) do
		local pos = info.pos
		local robotIndex = info.index
		local robotId = robots[robotIndex]
		local heroMain = ResBattleRobot[robotId]

		if heroMain then
			local playerinfo = utils.getRobotPlayerInfo(heroMain)

			if playerinfo then
				playerinfo.forceSkillAnim = heroMain.skill_anim == 1
				playerinfo.pos = pos

				table.insert(heros, playerinfo)
			end
		end
	end

	return heros
end

local INIT_BATTLE_TYPE_SPE_DATA = {
	[BattleConst.BATTLE_TYPE_STAGE] = "_initBattleSpeDataStage",
	[BattleConst.BATTLE_TYPE_STEPTOWER] = "_initBattleSpeDataStepTower",
	[BattleConst.BATTLE_TYPE_MAZE] = "_initBattleSpeDataMaze",
	[BattleConst.BATTLE_TYPE_ONCETOWER] = "_initBattleSpeDataOnceTower",
	[BattleConst.BATTLE_TYPE_WORLD_BOSS] = "_initBattleSpeDataWorldBoss",
	[BattleConst.BATTLE_TYPE_ACTIVITY] = "_initBattleSpeDataActivity",
	[BattleConst.BATTLE_TYPE_SEASON_TOWER] = "_initBattleSpeDataSeasonTower",
	[BattleConst.BATTLE_TYPE_RENT] = "_initBattleSpeDataRent",
	[BattleConst.BATTLE_TYPE_CIRCLE] = "_initBattleSpeDataCircle",
	[BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND] = "_initBattleSpeBossExpand",
	[BattleConst.BATTLE_TYPE_NEW_MAZE] = "_initBattleSpeNewMaze",
	[BattleConst.BATTLE_TYPE_MAZE_PET] = "_initBattleSpePetMaze",
	[BattleConst.BATTLE_TYPE_SNEAK_BATTLE] = "_initBattleSpeSneakBattle"
}

function __utils.getBattleInitInfo(battleInfo)
	local battleInitData = {}

	__utils._initBattleArgs(battleInitData, battleInfo)
	__utils._initBattleHeros(battleInitData, battleInfo)

	if INIT_BATTLE_TYPE_SPE_DATA[battleInitData.battleType] then
		__utils[INIT_BATTLE_TYPE_SPE_DATA[battleInitData.battleType]](battleInitData, battleInfo)
	end

	return battleInitData
end

function __utils._initBattleArgs(battleInitData, battleInfo)
	battleInitData.battleType = battleInfo.type
	battleInitData.seed = battleInfo.start_common.base.seed
	battleInitData.battleNo = battleInfo.start_common.base.pve_id
	battleInitData.speData = {}
	battleInitData.multiTeamHeros = {}
	battleInitData.heros = {}
	battleInitData.multiTeamPets = {}
	battleInitData.pets = {}
	battleInitData.speData.campBuffData = {}
	battleInitData.speData.teamProficientData = {}
	battleInitData.speData.extraAttrs = {}
	battleInitData.speData.extraStates = {}
	battleInitData.speData.extraPassives = {}
	battleInitData.speData.PossessPet = {}
end

function __utils.isMultiTeamBattle(battleType)
	return BattleConst.THREE_ROUND_BATTLE_TYPE[battleType]
end

function __utils._initBattleHeros(battleInitData, battleInfo)
	for _, campInfo in ipairs(battleInfo.start_common.formation) do
		local allRoleHeadPendant = {}

		if campInfo.dress and campInfo.dress.head_pendant then
			for _, dressInfo in ipairs(campInfo.dress.head_pendant) do
				table.insert(allRoleHeadPendant, dressInfo.id)
			end
		end

		local camp = campInfo.camp == BattleConst.CAMP_MONSTER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
		local formIndex = campInfo.index

		if campInfo.pet and campInfo.pet.pet and campInfo.pet.pet.resid > 0 then
			local newPet = utils.initBattlePetObj(campInfo.pet, camp)

			if utils.isMultiTeamBattle(battleInitData.battleType) then
				if not battleInitData.multiTeamPets[formIndex] then
					battleInitData.multiTeamPets[formIndex] = {}
				end

				table.insert(battleInitData.multiTeamPets[formIndex], newPet)

				if formIndex <= 1 then
					table.insert(battleInitData.pets, newPet)
				end
			else
				table.insert(battleInitData.pets, newPet)
			end
		end

		if battleInitData.battleType ~= BattleConst.BATTLE_TYPE_ACTIVITY and not battleInitData.speData.campBuffData[camp] then
			battleInitData.speData.campBuffData[camp] = {}

			if campInfo.house then
				battleInitData.speData.campBuffData[camp].buffInfo = utils.getHouseGroupBuffs(battleInfo.type, campInfo.house.part_group)
			end

			if campInfo.possess and campInfo.possess.possess_data then
				local careerPets = {}
				local petRune = campInfo.possess.pet_common_rune
				local petExclusiveRune = campInfo.possess.pet_exclusive_rune

				for _, petData in ipairs(campInfo.possess.possess_data) do
					local oneCareerPets = {}
					local careerId = petData.career_id

					if careerId and careerId > 0 and petData.item and #petData.item > 0 then
						for _, petInfo in ipairs(petData.item) do
							local newPet = utils.getBattleFormationPet(petInfo.pet, petRune, petExclusiveRune)

							if newPet then
								table.insert(oneCareerPets, newPet)
							end
						end

						if #oneCareerPets > 0 then
							careerPets[careerId] = oneCareerPets
						end
					end
				end

				battleInitData.speData.PossessPet[camp] = careerPets
			end

			if campInfo.proficent then
				local teamGroup = {}

				for _, info in ipairs(campInfo.proficent.item) do
					local gemAttrs = {}

					if Const.TEAM_PATCH_OPEN and info.attr_data then
						for _, itInfo in ipairs(info.attr_data.item) do
							gemAttrs[itInfo.attr] = itInfo.total_value
						end
					end

					teamGroup[info.group_id] = {
						info.score,
						info.level,
						gemAttrs
					}
				end

				teamGroup[Const.OTHER_TEAM_INDEX] = {
					campInfo.proficent.other_score,
					0
				}

				if campInfo.proficent.ur then
					local urData = campInfo.proficent.ur
					local gemAttrsUR = {}

					if urData.attr_data then
						for _, itInfo in ipairs(urData.attr_data.item or {}) do
							gemAttrsUR[itInfo.attr] = itInfo.total_value
						end
					end

					teamGroup[Const.UR_TEAM_INDEX] = {
						urData.score,
						urData.level,
						gemAttrsUR
					}
				end

				if next(teamGroup) then
					battleInitData.speData.campBuffData[camp].teamGroup = teamGroup
				end
			end
		end

		local crystalMaxLevel = campInfo.crystal_level

		for _, heroInfo in ipairs(campInfo.item) do
			if heroInfo.idx ~= 0 then
				local hero = {}

				hero.equips = {}

				if battleInitData.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
					hero.heroObj = __utils.getCircleBattleHero(Hero(heroInfo.hero.base))
					hero.level = hero.heroObj.level

					local equips = hero.heroObj:getEquips()

					if equips then
						for _, equip in pairs(equips) do
							table.insert(hero.equips, equip)
						end
					end

					local artifact = hero.heroObj:getArtifact()

					if artifact then
						hero.artifact = artifact
					end

					if heroInfo.clan_relic and heroInfo.clan_relic.id ~= 0 then
						hero.heroRelic = Relic(heroInfo.clan_relic)
					end

					hero.relationPointData = {}
				elseif battleInitData.battleType == BattleConst.BATTLE_TYPE_NEW_MAZE then
					local newMazeHero = Hero(heroInfo.hero.base)

					newMazeHero.isNotCircleHero = true
					hero.heroObj = __utils.getCircleBattleHero(newMazeHero)
					hero.level = hero.heroObj.level

					local equips = hero.heroObj:getEquips()

					if equips then
						for _, equip in pairs(equips) do
							table.insert(hero.equips, equip)
						end
					end

					local artifact = hero.heroObj:getArtifact()

					if artifact then
						hero.artifact = artifact
					end

					if heroInfo.relic and heroInfo.relic.id ~= 0 then
						hero.heroRelic = Relic(heroInfo.relic)
					end

					hero.relationPointData = {}
				elseif battleInitData.battleType == BattleConst.BATTLE_TYPE_SNEAK_BATTLE then
					local newHero = Hero(heroInfo.hero.base)

					newHero.isNotCircleHero = true
					hero.heroObj = __utils.getCircleBattleHero(newHero)
					hero.level = hero.heroObj.level

					local equips = hero.heroObj:getEquips()

					if equips then
						for _, equip in pairs(equips) do
							table.insert(hero.equips, equip)
						end
					end

					local artifact = hero.heroObj:getArtifact()

					if artifact then
						hero.artifact = artifact
					end

					if heroInfo.relic and heroInfo.relic.id ~= 0 then
						hero.heroRelic = Relic(heroInfo.relic)
					end

					hero.relationPointData = {}
				else
					hero.heroObj = Hero(heroInfo.hero.base)

					for _, eInfo in ipairs(heroInfo.equip or {}) do
						table.insert(hero.equips, Equip(eInfo.data))
					end

					if heroInfo.artifact and heroInfo.artifact.resid ~= 0 then
						hero.artifact = Artifact(heroInfo.artifact)
					end

					hero.level = heroInfo.hero.base.level

					if heroInfo.relic and heroInfo.relic.id ~= 0 then
						hero.heroRelic = Relic(heroInfo.relic)
					end

					if heroInfo.develop then
						hero.relationPointData = __utils.getRelationPointData(heroInfo.develop.point)
					else
						hero.relationPointData = {}
					end
				end

				if hero.heroObj then
					hero.crystalSecondLevel = hero.heroObj.crystalSecondLevel
				end

				hero.gid = heroInfo.hero.base.gid
				hero.heroID = heroInfo.hero.base.resid
				hero.star = heroInfo.hero.base.star
				hero.step = heroInfo.hero.base.step
				hero.pos = heroInfo.idx
				hero.hpPercent = heroInfo.hero.hp or 0
				hero.camp = camp
				hero.crystalMaxLevel = crystalMaxLevel
				hero.storyUnlockDic = utils.getBitsDictFromByteString(heroInfo.hero.crystal_unlock)
				hero.fashionSkins = __utils.getBitsDictFromByteString(heroInfo.skin)
				hero.fashionBases = __utils.getBitsDictFromByteString(heroInfo.base)

				if heroInfo.season_relic and heroInfo.season_relic.id ~= 0 then
					hero.heroSeasonRelic = Relic(heroInfo.season_relic)
				end

				hero.allRoleHeadPendant = allRoleHeadPendant

				if heroInfo.paint_level and heroInfo.paint_level > 0 then
					hero.paintData = __utils.getPaintData(hero.heroID, heroInfo.paint_level, heroInfo.ability)
				else
					hero.paintData = {}
				end

				if heroInfo.new_paint_level and heroInfo.new_paint_level > 0 then
					hero.paintPlusData = {
						level = heroInfo.new_paint_level,
						relateLevel = heroInfo.new_paint_relate_level
					}
				else
					hero.paintPlusData = {}
				end

				if heroInfo.stick then
					hero.stickData = __utils.getStickData(heroInfo.stick)
				else
					hero.stickData = {}
				end

				if utils.isMultiTeamBattle(battleInitData.battleType) then
					if not battleInitData.multiTeamHeros[formIndex] then
						battleInitData.multiTeamHeros[formIndex] = {}
					end

					table.insert(battleInitData.multiTeamHeros[formIndex], hero)

					if formIndex <= 1 then
						table.insert(battleInitData.heros, hero)
					end
				else
					table.insert(battleInitData.heros, hero)
				end
			end
		end
	end

	battleInitData.speData.suppres = battleInfo.start_common.base.suppres
	battleInitData.speData.serverBuff = {}

	for _, bInfo in ipairs(battleInfo.start_common.base.buff) do
		table.insert(battleInitData.speData.serverBuff, bInfo.id)
	end

	table.sort(battleInitData.speData.serverBuff)
	table.sort(battleInitData.heros, __utils.BattleHeroSortFunc)

	for _, formHeros in pairs(battleInitData.multiTeamHeros) do
		table.sort(formHeros, __utils.BattleHeroSortFunc)
	end
end

function __utils.initBattlePetObj(petInfo, camp)
	local pet = utils.getBattleFormationPet(petInfo)

	return {
		camp = camp,
		petId = pet.id,
		pet = pet
	}
end

function __utils.BattleHeroSortFunc(heroA, heroB)
	if heroA.camp ~= heroB.camp then
		return heroA.camp == BattleConst.CAMP_PLAYER
	elseif heroA.pos and heroB.pos and heroA.pos ~= heroB.pos then
		return heroA.pos < heroB.pos
	elseif heroA.heroID and heroB.heroID and heroA.heroID ~= heroB.heroID then
		return heroA.heroID < heroB.heroID
	end
end

function __utils._initBattleSpeDataStage(battleInitData, battleInfo)
	battleInitData.speData.stageData = {}
	battleInitData.speData.stageData.season = battleInfo.spec.stage.data.season
	battleInitData.speData.stageData.chapter = battleInfo.spec.stage.data.chapter
	battleInitData.speData.stageData.level = battleInfo.spec.stage.data.level
	battleInitData.speData.stageData.suppressTick = battleInfo.spec.stage.data.refresh_tick
	battleInitData.speData.stageData.vipLevel = battleInfo.spec.stage.data.vip_lv
	battleInitData.speData.stageData.backStageCnt = battleInfo.spec.stage.data.back_stage_cnt
	__utils.stagePreSuppressLevel = battleInfo.start_common.base.suppres
end

function __utils._initBattleSpeDataStepTower(battleInitData, battleInfo)
	local battleConfig = ResBattleConfig[battleInitData.battleNo] or {}

	battleInitData.speData.stepTowerData = {}
	battleInitData.speData.stepTowerData.layer = battleInfo.spec.tower.data.layer
	battleInitData.speData.stepTowerData.level = battleInfo.spec.tower.data.level
	battleInitData.speData.stepTowerData.star = battleInfo.spec.tower.data.star
	battleInitData.speData.PossessPet = {}
	battleInitData.heros = utils.getBattleConfigRobots(battleConfig, battleInfo.start_common.base.robot.rebot)
end

function __utils._initBattleSpeSneakBattle(battleInitData, battleInfo)
	local weekIndex = battleInfo.spec.newpve.data.week_index
	local ResNewPveIndex = require("ClientData/ResNewPveIndex")
	local ResNewPveBuff = require("ClientData/ResNewPveBuff")

	if weekIndex and ResNewPveIndex[weekIndex] then
		local buffId = ResNewPveIndex[weekIndex].buff

		if buffId and ResNewPveBuff[buffId] then
			local effectId = ResNewPveBuff[buffId].effect

			if effectId and effectId ~= 0 then
				table.insert(battleInitData.speData.serverBuff, effectId)
				table.sort(battleInitData.speData.serverBuff)
			end
		end
	end
end

function __utils._initBattleSpeDataMaze(battleInitData, battleInfo)
	local maze_id = battleInfo.spec.maze.maze_id
	local layer = battleInfo.spec.maze.layer
	local node_id = battleInfo.spec.maze.node_id

	if ResMaze[maze_id] and ResMaze[maze_id][layer] then
		battleInitData.speData.mazeData = ResMaze[maze_id][layer][node_id]
	end

	battleInitData.speData.mazeRelics = {}

	for _, relicInfo in ipairs(battleInfo.spec.maze.relics) do
		table.insert(battleInitData.speData.mazeRelics, relicInfo.id)
	end

	for _, relicInfo in ipairs(battleInfo.spec.maze.pandora_relics) do
		table.insert(battleInitData.speData.mazeRelics, relicInfo.id)
	end

	battleInitData.speData.monsterHps = {}

	for _, hpInfo in ipairs(battleInfo.spec.maze.monster.record) do
		battleInitData.speData.monsterHps[hpInfo.id] = hpInfo.hp
	end

	battleInitData.speData.monsterLevel = math.max(1, battleInfo.start_common.base.pve_level or 0)

	local mazeConfigData = ResMazeInitConfig[maze_id]

	if mazeConfigData and battleInitData.speData.mazeData then
		local baseRate = battleInitData.speData.mazeData.enhance_rate or 0
		local incRate = battleInitData.speData.mazeData.level_rate or 0

		battleInitData.speData.mazeEnhanceRate = baseRate + math.max(0, (mazeConfigData.level_up or 0) - (battleInfo.start_common.base.pve_level or 0)) * incRate
	end
end

function __utils._initBattleSpeNewMaze(battleInitData, battleInfo)
	battleInitData.speData.newMazeData = {}

	local relics = battleInfo.spec.newmaze.data.relic
	local halos = battleInfo.spec.newmaze.data.halo
	local debuff = battleInfo.spec.newmaze.data.buff
	local fetters = battleInfo.spec.newmaze.data.fetter

	battleInitData.speData.newMazeData.tmpID = battleInfo.spec.newmaze.data.tmp_id
	battleInitData.speData.newMazeData.level = battleInfo.spec.newmaze.data.level
	battleInitData.speData.newMazeData.layer = battleInfo.spec.newmaze.data.layer
	battleInitData.speData.newMazeData.eventId = battleInfo.spec.newmaze.data.spec_id
	battleInitData.speData.newMazeFetters = {}

	for _, fettersInfo in ipairs(fetters or {}) do
		table.insert(battleInitData.speData.newMazeFetters, fettersInfo.id)
	end

	battleInitData.speData.newMazeRelics = {}

	for _, relicInfo in ipairs(relics or {}) do
		table.insert(battleInitData.speData.newMazeRelics, relicInfo.id)
	end

	battleInitData.speData.newMazeHalos = {}

	for _, haloInfo in ipairs(halos or {}) do
		table.insert(battleInitData.speData.newMazeHalos, haloInfo.id)
	end

	battleInitData.speData.newMazeBuffs = {}

	for _, buffInfo in ipairs(debuff or {}) do
		table.insert(battleInitData.speData.newMazeBuffs, buffInfo.id)
	end

	battleInitData.speData.monsterHps = {}

	if battleInfo.spec.newmaze.data.monster then
		for _, hpInfo in ipairs(battleInfo.spec.newmaze.data.monster.record) do
			battleInitData.speData.monsterHps[hpInfo.pos] = hpInfo.hp
		end
	end
end

function __utils._initBattleSpePetMaze(battleInitData, battleInfo)
	local petMazeData = {}
	local petMaze = battleInfo.spec.petmaze.data

	petMazeData.actId = petMaze.act_id
	petMazeData.level = petMaze.level
	petMazeData.bossId = petMaze.boss_id
	petMazeData.stageId = petMaze.stage_id
	petMazeData.quality = petMaze.quality
	battleInitData.speData.petMazeData = petMazeData
end

function __utils._initBattleSpeDataOnceTower(battleInitData, battleInfo)
	local relics_id = battleInfo.spec.once_tower.data.relics_id

	if relics_id > 0 then
		battleInitData.speData.mazeRelics = {}

		table.insert(battleInitData.speData.mazeRelics, relics_id)
	end
end

function __utils._initBattleSpeDataWorldBoss(battleInitData, battleInfo)
	local world_boss = battleInfo.spec.world_boss.data

	if world_boss then
		local worldBossData = ResWorldBoss[world_boss.type] or {}

		worldBossData = worldBossData[world_boss.hard]
		battleInitData.speData.worldBossData = worldBossData
	end
end

function __utils._initBattleSpeDataActivity(battleInitData, battleInfo)
	local battleConfig = ResBattleConfig[battleInitData.battleNo] or {}

	battleInitData.heros = utils.getBattleConfigRobots(battleConfig, battleInfo.start_common.base.robot.rebot)
end

function __utils._initBattleSpeDataSeasonTower(battleInitData, battleInfo)
	local towerServerData = battleInfo.spec.opact_tower.data

	battleInitData.speData.seasonTowerData = {}

	local towerData = ResOpActTowerStage[towerServerData.detail_id][towerServerData.tower_id][towerServerData.layer]

	battleInitData.speData.seasonTowerData.towerData = towerData
	battleInitData.speData.seasonTowerData.suppressTick = towerServerData.last_fight_tick
	battleInitData.speData.seasonTowerData.vipLevel = towerServerData.vip_lv

	if towerData.boss_id then
		battleInitData.speData.seasonTowerData.bossConfig = ResOpActTowerBossAward[towerData.boss_id]
	end

	battleInitData.speData.monsterHps = {}

	for _, hpInfo in ipairs(towerServerData.record) do
		battleInitData.speData.monsterHps[hpInfo.id] = hpInfo.hp
	end

	battleInitData.speData.STBuffs = {}

	for _, buff in ipairs(towerServerData.buff) do
		table.insert(battleInitData.speData.STBuffs, buff.id)
	end
end

function __utils._initBattleSpeDataRent(battleInitData, battleInfo)
	local serverRentData = battleInfo.spec.rent.data

	battleInitData.speData.rentData = {}

	local taskId = serverRentData.taskid
	local teamBattle = serverRentData.teamid and serverRentData.teamid > 0

	battleInitData.speData.rentData.stageConfig = utils.getRentStageData(taskId, teamBattle, serverRentData.stage, serverRentData.max_stage)
end

function __utils._initBattleSpeDataCircle(battleInitData, battleInfo)
	battleInitData.speData.clanData = {}
	battleInitData.speData.clanData.layer = battleInfo.spec.clan.data.layer
	battleInitData.speData.monsterHps = {}

	for _, hpInfo in ipairs(battleInfo.spec.clan.data.monster.monster) do
		battleInitData.speData.monsterHps[hpInfo.pos] = hpInfo.hp
	end

	for _, skill in ipairs(battleInfo.spec.clan.data.skill) do
		local skillId = skill.id
		local clanSkillData = ResClanBattleSkill[skillId] or {}

		if clanSkillData.state_id then
			__utils.addStateContainer(battleInitData.speData.extraStates, clanSkillData.state_id, clanSkillData.state_lv)
		end

		if clanSkillData.passive_id then
			__utils.addPassiveContainer(battleInitData.speData.extraPassives, clanSkillData.passive_id, clanSkillData.passive_lv)
		end
	end

	local battle_proficiency = battleInfo.spec.clan.data.battle_proficiency

	for talentId, clanTalentData in ipairs(ResClanBattleTalent) do
		if battle_proficiency >= clanTalentData.proficiency then
			if clanTalentData.state_id then
				__utils.addStateContainer(battleInitData.speData.extraStates, clanTalentData.state_id, clanTalentData.state_lv)
			end

			if clanTalentData.passive_id then
				__utils.addPassiveContainer(battleInitData.speData.extraPassives, clanTalentData.passive_id, clanTalentData.passive_lv)
			end
		end
	end

	for _, rune in ipairs(battleInfo.spec.clan.data.rune) do
		local runeId = rune.id
		local clanRuneData = ResClanBattleRune[runeId] or {}

		if clanRuneData.state_id then
			__utils.addStateContainer(battleInitData.speData.extraStates, clanRuneData.state_id, 1)
		end

		if clanRuneData.props then
			for _, attrs in ipairs(clanRuneData.props) do
				__utils.addAttrContainer(battleInitData.speData.extraAttrs, attrs.type, attrs.value)
			end
		end
	end

	if battleInfo.spec.clan.data.all_open == 1 then
		battleInitData.speData.clanData.atkRate = ResClanBattleMisc[1].all_show_atk_rate * 0.0001
		battleInitData.speData.clanData.mhpRate = ResClanBattleMisc[1].all_show_mhp_rate * 0.0001
	end

	local monsterData = ResClanBattleMonster[battleInfo.spec.clan.data.monsterid]

	if monsterData and monsterData.type == 3 then
		battleInitData.speData.clanData.isBoss = true
		battleInitData.speData.clanData.monsterData = monsterData
	end
end

function __utils._initBattleSpeBossExpand(battleInitData, battleInfo)
	return
end

function __utils.getDemoBuffData(mainData)
	local buffData = {}

	if mainData.rearHouse then
		local fakeRearHouseData = {}

		for index = 0, 5 do
			local startIndex = index * 2 + 1

			if mainData.rearHouse[startIndex] and mainData.rearHouse[startIndex + 1] then
				table.insert(fakeRearHouseData, {
					groupid = mainData.rearHouse[startIndex],
					num = mainData.rearHouse[startIndex + 1]
				})
			else
				break
			end
		end

		buffData.buffInfo = utils.getHouseGroupBuffs(mainData.rearHouse.battleType, fakeRearHouseData)
	end

	if mainData.heroProficient then
		local teamGroup = {}
		local ResHeroProficientLevel = require("ClientData/ResHeroProficientLevel")

		for index = 0, 5 do
			local startIndex = index * 2 + 1

			if mainData.heroProficient[startIndex] and mainData.heroProficient[startIndex + 1] then
				local groupid = mainData.heroProficient[startIndex]
				local score = mainData.heroProficient[startIndex + 1]
				local nLevel = 0

				for level, info in ipairs(ResHeroProficientLevel) do
					if score >= info.group_score then
						nLevel = level
					else
						break
					end
				end

				teamGroup[groupid] = {
					score,
					nLevel
				}
			else
				break
			end
		end

		if next(teamGroup) then
			buffData.teamGroup = teamGroup
		end
	end

	return buffData
end

function __utils.getRentStageConfigId(stage)
	if not stage then
		return #ResRentStageConfig
	end

	local addStage = stage - ResRentStageConfig[1].stage_id + 1
	local nowLevel = addStage % 100
	local nowStage = math.floor(addStage % 10000 / 100)

	return nowStage * 30 + nowLevel
end

function __utils.getRentStageData(taskId, teamBattle, stage, maxStage)
	if ResRentTask[taskId] then
		local tType = ResRentTask[taskId].type
		local stageOffset = ResRentMisc[1].normal_offset

		if tType == 2 and teamBattle then
			stageOffset = ResRentMisc[1].team_advanced_offset
		elseif tType == 2 then
			stageOffset = ResRentMisc[1].advanced_offset
		elseif tType == 3 and teamBattle then
			stageOffset = ResRentMisc[1].team_rare_offset
		elseif tType == 3 then
			stageOffset = ResRentMisc[1].rare_offset
		end

		local nowIndex = __utils.getRentStageConfigId(stage)
		local maxIndex = math.min(#ResRentStageConfig, math.max(1, __utils.getRentStageConfigId(maxStage) - ResRentMisc[1].max_stage_fixed))

		nowIndex = math.min(maxIndex, math.max(1, nowIndex + stageOffset))

		return ResRentStageConfig[nowIndex]
	end
end

function __utils.calHerosAverageLv(formationHeros)
	local function _sortFormationHeroByLevel(a, b)
		return a.level > b.level
	end

	table.sort(formationHeros, _sortFormationHeroByLevel)

	local LEVEL_WEIGHT = {
		25,
		25,
		20,
		15,
		15
	}
	local totalLevel = 0

	for i, hero in ipairs(formationHeros) do
		totalLevel = totalLevel + hero.level * LEVEL_WEIGHT[i]
	end

	if formationHeros and #formationHeros > 0 then
		return math.max(math.floor(totalLevel / 100), formationHeros[#formationHeros].level)
	else
		return totalLevel
	end
end

function __utils.getRobotPlayerInfoWithRobotIds(robotIds, posConfig)
	local infos = {}

	for index, robotId in ipairs(robotIds) do
		local heroMain = ResBattleRobot[robotId]
		local info = __utils.getRobotPlayerInfo(heroMain)

		info.camp = BattleConst.CAMP_MONSTER

		table.insert(infos, info)
	end

	if posConfig == nil then
		return infos
	else
		for i, pos in ipairs(posConfig) do
			if infos[pos] then
				infos[pos].pos = i
			end
		end
	end

	return infos
end

local REVERSE_NUM = {
	128,
	64,
	32,
	16,
	8,
	4,
	2,
	1
}

function __utils.getByteStringFromBitsList(bitList, maxStrNum)
	table.sort(bitList)

	local byteString = ""

	for index = 1, maxStrNum or 1 do
		local count = 0

		for _, value in ipairs(bitList) do
			if value > index * 8 - 8 and value <= index * 8 then
				count = count + REVERSE_NUM[value - index * 8 + 8]
			end
		end

		byteString = byteString .. string.char(count)
	end

	return byteString
end

function __utils.getRobotPlayerInfo(heroMain)
	if heroMain then
		local robotMain = ResBattleToolRobot[heroMain.heroProp]
		local fakeServerHero = {}

		fakeServerHero.gid = heroMain.heroID
		fakeServerHero.resid = heroMain.heroID
		fakeServerHero.crystal_level = robotMain.crystal_level
		fakeServerHero.level = robotMain.level
		fakeServerHero.star = robotMain.star
		fakeServerHero.step = robotMain.step
		fakeServerHero.skin = heroMain.skinId
		fakeServerHero.recharge = robotMain.recharge

		local playerInfo = {}

		playerInfo.isRobot = true
		playerInfo.heroObj = Hero(fakeServerHero)
		playerInfo.gid = heroMain.heroID
		playerInfo.heroID = heroMain.heroID
		playerInfo.star = robotMain.star
		playerInfo.crystalSecondLevel = robotMain.crystal_level
		playerInfo.level = robotMain.level
		playerInfo.step = robotMain.step
		playerInfo.hpPercent = 0
		playerInfo.equips = {}

		local equipMain = ResBattleToolProp[heroMain.equipProp]

		if equipMain and equipMain.artifactID then
			playerInfo.artifact = Artifact({
				resid = equipMain.artifactID,
				level = equipMain.artifactLevel,
				break_level = equipMain.artifactBreakLevel
			})
		end

		if equipMain and equipMain.relic_id then
			playerInfo.heroRelic = Relic({
				id = equipMain.relic_id,
				level = equipMain.relic_level
			})
		end

		if equipMain and equipMain.paint_level then
			playerInfo.paintData = __utils.getPaintData(heroMain.heroID, equipMain.paint_level, __utils.getByteStringFromBitsList(equipMain.paint_ability))

			playerInfo.heroObj:setPaintData(playerInfo.paintData)
		end

		playerInfo.camp = BattleConst.CAMP_PLAYER
		playerInfo.robotEquips = equipMain

		return playerInfo
	end
end

function __utils.getRobotPlayerInfoAI(heroMain)
	if heroMain then
		local robotMain

		if heroMain.heroProp then
			robotMain = ResBattleToolRobot[heroMain.heroProp]
		else
			robotMain = heroMain
		end

		local fakeServerHero = {}

		fakeServerHero.gid = heroMain.heroID
		fakeServerHero.resid = heroMain.heroID
		fakeServerHero.crystal_level = robotMain.crystal_level
		fakeServerHero.level = robotMain.level
		fakeServerHero.star = robotMain.star
		fakeServerHero.step = robotMain.step
		fakeServerHero.skin = heroMain.skinId
		fakeServerHero.recharge = robotMain.recharge

		local playerInfo = {}

		playerInfo.isRobot = true
		playerInfo.heroObj = Hero(fakeServerHero)
		playerInfo.gid = heroMain.heroID
		playerInfo.heroID = heroMain.heroID
		playerInfo.star = robotMain.star
		playerInfo.crystalSecondLevel = robotMain.crystal_level
		playerInfo.level = robotMain.level
		playerInfo.step = robotMain.step
		playerInfo.hpPercent = 0
		playerInfo.equips = {}

		local equipMain

		if heroMain.equipProp then
			equipMain = ResBattleToolProp[heroMain.equipProp]
		else
			equipMain = heroMain
		end

		if equipMain and equipMain.artifactID then
			playerInfo.artifact = Artifact({
				resid = equipMain.artifactID,
				level = equipMain.artifactLevel,
				break_level = equipMain.artifactBreakLevel
			})
		end

		if equipMain and equipMain.relic_id then
			playerInfo.heroRelic = Relic({
				id = equipMain.relic_id,
				level = equipMain.relic_level
			})
		end

		if equipMain and equipMain.paint_level then
			playerInfo.paintData = __utils.getPaintData(heroMain.heroID, equipMain.paint_level, __utils.getByteStringFromBitsList(equipMain.paint_ability))

			playerInfo.heroObj:setPaintData(playerInfo.paintData)
		end

		playerInfo.camp = BattleConst.CAMP_PLAYER
		playerInfo.robotEquips = equipMain

		return playerInfo
	end
end

function __utils.getRobotHeroInfo(robotIds, posConfig)
	if robotIds == nil then
		return
	end

	local heros = {}

	for index, robotId in ipairs(robotIds) do
		local heroMain = ResBattleRobot[robotId]

		if heroMain then
			local robotMain = ResBattleToolRobot[heroMain.heroProp]
			local fakeServerHero = {}

			fakeServerHero.gid = tostring(index)
			fakeServerHero.resid = heroMain.heroID
			fakeServerHero.crystal_level = robotMain.crystal_level
			fakeServerHero.level = robotMain.level
			fakeServerHero.star = robotMain.star
			fakeServerHero.step = robotMain.step
			fakeServerHero.skin = heroMain.skinId
			fakeServerHero.recharge = robotMain.recharge

			table.insert(heros, Hero(fakeServerHero))
		end
	end

	if posConfig == nil then
		return heros
	else
		for i, pos in ipairs(posConfig) do
			if heros[pos] then
				heros[pos].pos = i
			end
		end
	end

	return heros
end

function __utils.getBattleFormationHero(battleStartData)
	local multiTeamHeros = {}
	local multiPets = {}

	for _, campInfo in ipairs(battleStartData.start_common.formation) do
		local camp = campInfo.camp == BattleConst.CAMP_MONSTER and BattleConst.CAMP_MONSTER or BattleConst.CAMP_PLAYER
		local formIndex = campInfo.index

		if campInfo.pet and campInfo.pet.pet and campInfo.pet.pet.resid > 0 then
			if not multiPets[formIndex] then
				multiPets[formIndex] = {}
			end

			if not multiPets[formIndex][camp] then
				multiPets[formIndex][camp] = {}
			end

			local newPet = utils.initBattlePetObj(campInfo.pet, camp)

			multiPets[formIndex][camp] = newPet.pet
		end

		for _, heroInfo in ipairs(campInfo.item) do
			local hero = Hero(heroInfo.hero.base)

			if Const.PAINT_PLUS_OPEN and heroInfo.new_paint_level and heroInfo.new_paint_level > 0 then
				local paintData = {}

				paintData.level = heroInfo.new_paint_level

				if heroInfo.new_paint_relate_level and heroInfo.new_paint_relate_level > 0 then
					paintData.relateLevel = heroInfo.new_paint_relate_level
				end

				hero:setPaintPlusData(paintData)
			end

			if not multiTeamHeros[formIndex] then
				multiTeamHeros[formIndex] = {}
			end

			if not multiTeamHeros[formIndex][camp] then
				multiTeamHeros[formIndex][camp] = {}
			end

			table.insert(multiTeamHeros[formIndex][camp], hero)
		end
	end

	return multiTeamHeros, multiPets
end

function __utils.isRobot(uid)
	if uid == nil then
		return
	end

	local num = tonumber(uid)

	return num > 0 and num < 10000
end

function __utils.getRobotServerFormation(robotIds, posConfig)
	if robotIds == nil then
		return
	end

	local serverFormation = {}

	for i, rId in ipairs(robotIds) do
		local serverHeroData = __utils.getRobotServerHeroData(rId)

		if serverHeroData then
			table.insert(serverFormation, serverHeroData)
		end
	end

	if posConfig == nil then
		return serverFormation
	end

	for i, index in ipairs(posConfig) do
		if serverFormation[index] then
			serverFormation[index].idx = i
		end
	end

	return serverFormation
end

function __utils.checkRelationLvUpMaterialEnough(hero, relationPoint)
	local materials = hero:getRelationPointNeedMaterial(relationPoint)
	local canLvUp = true

	if materials then
		for i, idNum in ipairs(materials) do
			local curCount = CurAvatar:getItemNumById(idNum.id)

			if curCount < idNum.num then
				canLvUp = false

				break
			end
		end
	end

	return canLvUp
end

function __utils.getRobotServerHeroData(robotId)
	local heroMain = ResBattleRobot[robotId]

	if heroMain then
		local robotMain = ResBattleToolRobot[heroMain.heroProp]
		local equipMain = ResBattleToolProp[heroMain.equipProp] or {}
		local serverHeroData = {}
		local artifact, relic

		if equipMain.artifactID then
			artifact = {
				gid = "0",
				exp = 0,
				break_level = equipMain.artifactBreakLevel or 0,
				level = equipMain.artifactLevel or 0,
				resid = equipMain.artifactID
			}
		end

		if equipMain.relic_id then
			relic = {
				level = equipMain.relic_level or 0,
				id = equipMain.relic_id
			}
		end

		local hero = {
			base = {
				lock = 0,
				artifact = "0",
				wake = 0,
				level = robotMain.level,
				crystal_level = robotMain.crystal_level,
				star = robotMain.star,
				resid = heroMain.heroID,
				gid = heroMain.heroID,
				skin = heroMain.skinId,
				step = robotMain.step,
				recharge = robotMain.recharge
			}
		}
		local equip = {}

		serverHeroData.hero = hero
		serverHeroData.artifact = artifact
		serverHeroData.equip = equip
		serverHeroData.relic = relic

		return serverHeroData
	end
end

local function _sortGetStageBonusResInfo(a, b)
	if a.startStageIndex ~= b.startStageIndex then
		return a.startStageIndex < b.startStageIndex
	elseif a.id ~= b.id then
		return a.id < b.id
	end
end

local INIT_PREDICT_BONUS = false

function __utils.getStageBonusResInfoList()
	if not INIT_PREDICT_BONUS then
		INIT_PREDICT_BONUS = true

		for id, bonusData in pairs(ResStageBonusPredict) do
			bonusData.startStageIndex = bonusData.begin_stage[2] * 100 + bonusData.begin_stage[3]
		end
	end

	local bonusResDataList = {}

	for id, bonusData in pairs(ResStageBonusPredict) do
		bonusData.startStage1 = bonusData.begin_stage[1]

		table.insert(bonusResDataList, bonusData)
	end

	table.sort(bonusResDataList, _sortGetStageBonusResInfo)

	return bonusResDataList
end

function __utils.getStageBonusInfo(banStageShow, ignoreGot)
	local nowBonus, isNotGot
	local stageBonusResDataList = __utils.getStageBonusResInfoList()

	for _, bonusData in ipairs(stageBonusResDataList) do
		local isBonusBan = false

		if not banStageShow or not bonusData.ban_stage_show or bonusData.ban_stage_show ~= 1 then
			local startInfo = bonusData.begin_stage
			local endInfo = bonusData.end_stage

			if CurAvatar:mainStageStatePassed(startInfo[1], startInfo[2], startInfo[3]) then
				if not CurAvatar:mainStageStatePassed(endInfo[1], endInfo[2], endInfo[3]) then
					nowBonus = bonusData

					break
				elseif not ignoreGot and bonusData.relate_achieve and CurAvatar:getAchieveStatus(bonusData.relate_achieve) ~= Const.ACHIEVE_STATUS.AWARD_GOT then
					nowBonus = bonusData
					isNotGot = true

					break
				end
			else
				nowBonus = bonusData

				break
			end
		end
	end

	return nowBonus, isNotGot
end

function __utils.getStageBonusDataList()
	local bonusDataList = {}
	local nowBonus, isNotGot = __utils.getStageBonusInfo(nil, true)
	local stageBonusResDataList = __utils.getStageBonusResInfoList()

	for idx, bonusResData in ipairs(stageBonusResDataList) do
		local id = bonusResData.id
		local startInfo = bonusResData.begin_stage
		local endInfo = bonusResData.end_stage
		local bonusData = {}

		bonusData.resData = bonusResData

		if CurAvatar:mainStageStatePassed(startInfo[1], startInfo[2], startInfo[3]) then
			if id == nowBonus.id then
				bonusData.state = Const.STAGE_BONUS_STATE.NEXT
			elseif bonusData.resData.relate_achieve and CurAvatar:getAchieveStatus(bonusData.resData.relate_achieve) ~= Const.ACHIEVE_STATUS.AWARD_GOT then
				bonusData.state = Const.STAGE_BONUS_STATE.GET
			else
				bonusData.state = Const.STAGE_BONUS_STATE.GOT
			end
		else
			bonusData.state = Const.STAGE_BONUS_STATE.DIS
		end

		table.insert(bonusDataList, bonusData)
	end

	return bonusDataList
end

function __utils.getNowSpecStageBonus()
	local nowBonus, isNotGot = __utils.getStageBonusInfo(nil, true)
	local specBonus

	if nowBonus then
		local stageBonusResDataList = __utils.getStageBonusResInfoList()

		for idx = 1, #stageBonusResDataList do
			local id = stageBonusResDataList[idx].id

			if id >= nowBonus.id and ResStageBonusPredict[id] and ResStageBonusPredict[id].spec_icon_path then
				return ResStageBonusPredict[id]
			elseif ResStageBonusPredict[id] and ResStageBonusPredict[id].spec_icon_path then
				specBonus = ResStageBonusPredict[id]
			end
		end

		return specBonus
	end
end

function __utils.getBattleFormationPet(petInfo, fixedRune, fixedExclusiveRune)
	if petInfo and petInfo.pet and petInfo.pet and petInfo.pet.resid > 0 then
		local pet = Pet(petInfo.pet)

		pet:setPetLevel(petInfo.pet_degree.level)

		local mainAmulet, assistAmulet

		if petInfo.amulet1 and petInfo.amulet1.resid > 0 then
			mainAmulet = PetAmulet(petInfo.amulet1)
		end

		if petInfo.amulet2 and petInfo.amulet2.resid > 0 then
			assistAmulet = PetAmulet(petInfo.amulet2)
		end

		local gems = {}

		for _, gemInfo in ipairs(petInfo.gem) do
			local newGem = PetGem(gemInfo)

			table.insert(gems, newGem)
		end

		pet:setBattlePetAmulet(mainAmulet, assistAmulet)
		pet:setBattlePetGem(gems)

		if fixedRune then
			pet:setBattlePetRune(fixedRune, fixedExclusiveRune)
		else
			pet:setBattlePetRune(petInfo.pet_common_rune, petInfo.pet_exclusive_rune)
		end

		return pet
	end
end

function __utils.getFormationHeros(formation)
	local heros = {}
	local crystalMaxLevel = formation.crystal_level

	for _, heroInfo in ipairs(formation.item) do
		if heroInfo.hero.base.resid ~= 0 then
			local hero = Hero(heroInfo.hero.base)

			hero.pos = heroInfo.idx

			table.insert(heros, hero)

			local equips = {}

			if heroInfo.equip ~= nil then
				for j, e in ipairs(heroInfo.equip or {}) do
					if e.data.gid ~= "0" then
						local _equip = Equip(e.data)

						_equip.inWearing = hero.gid
						equips[_equip.subType] = _equip
					end
				end
			end

			local artifact

			if heroInfo.artifact ~= nil and heroInfo.artifact.gid ~= "0" then
				artifact = Artifact(heroInfo.artifact)
				artifact.inWearing = hero.gid
			end

			if heroInfo.paint_level and heroInfo.paint_level > 0 then
				hero:setPaintData(utils.getPaintData(hero.id, heroInfo.paint_level, heroInfo.ability))
			end

			if heroInfo.develop then
				hero:setRelationPointData(utils.getRelationPointData(heroInfo.develop.point))
			end

			if Const.PAINT_PLUS_OPEN and heroInfo.new_paint_level and heroInfo.new_paint_level > 0 then
				local paintPlusData = {}

				paintPlusData.level = heroInfo.new_paint_level

				if heroInfo.new_paint_relate_level and heroInfo.new_paint_relate_level > 0 then
					paintPlusData.relateLevel = heroInfo.new_paint_relate_level
				end

				hero:setPaintPlusData(paintPlusData)
			end

			local relic

			if heroInfo.relic and heroInfo.relic.id ~= 0 then
				relic = Relic(heroInfo.relic)
				relic.inWearing = hero.gid
			end

			hero:setEquips(equips, artifact, relic)

			if heroInfo.season_relic and heroInfo.season_relic.id ~= 0 then
				local relic = Relic(heroInfo.relic)

				hero:setSeasonRelic(relic)
			end

			local sData = {}

			sData.skin = {}
			sData.base = {}

			if heroInfo.skin then
				sData.skin = ClientUtils.getBitsDictFromByteString(heroInfo.skin)
			end

			if heroInfo.base then
				sData.base = ClientUtils.getBitsDictFromByteString(heroInfo.base)
			end

			hero:setSkinData(sData)

			local storyUnlockDic = utils.getBitsDictFromByteString(heroInfo.hero.crystal_unlock)

			hero:setCrystalStoryData(crystalMaxLevel, storyUnlockDic)

			if heroInfo.stick then
				hero:setStickData(utils.getStickData(heroInfo.stick))
			end
		else
			local hero = Monster(BattleConst.HIDE_FORMATION_MONSTER_ID)

			hero.pos = heroInfo.idx

			table.insert(heros, hero)
		end
	end

	local newPet = utils.getBattleFormationPet(formation.pet)

	return heros, newPet
end

function __utils.getResetedHero(hero, resetType)
	local svrData = {}

	svrData.gid = hero.gid
	svrData.resid = hero.id
	svrData.star = hero.star
	svrData.lock = hero.lock
	svrData.level = resetType == Const.HERO_RESET_STEP and hero.realLevel or 1
	svrData.step = resetType == Const.HERO_RESET_LEVEL and hero.step or 0
	svrData.wake = 0
	svrData.equip = {}
	svrData.artifact = nil
	svrData.recharge = resetType == Const.HERO_RESET_LEVEL and hero.recharge or 0
	svrData.skin = hero.skin
	svrData.base = hero.base

	local resetedHero = Hero(svrData)

	if hero.mazeHp then
		resetedHero:setMazeAttr(hero.mazeHp)
	end

	return resetedHero
end

function __utils.getCircleBattleHero(hero, relic, isnNewMazz)
	local clanBattleInfo = ResClanBattleAverageLv[hero.id]

	if clanBattleInfo then
		if hero.isNotCircleHero or isnNewMazz or clanBattleInfo.disable_clanbattle == nil then
			local svrData = utils.deepcopy(hero._serverData)

			svrData.relic = 0
			svrData.level = clanBattleInfo.hero_lv or hero._serverData.level
			svrData.step = __utils.getMaxStepByLevel(clanBattleInfo.hero_lv)
			svrData.crystal_level = 0

			local circleBattleHero = Hero(svrData)

			circleBattleHero:initTeamInfo()

			local equips = {}

			if clanBattleInfo.equip_info then
				for _, equipData in ipairs(clanBattleInfo.equip_info) do
					local svrData = {}

					svrData.gid = ""
					svrData.resid = equipData.id
					svrData.level = equipData.enhance
					svrData.evolve = equipData.evolve

					local equip = Equip(svrData)

					equips[equip.part] = equip
				end
			end

			local artifact

			if clanBattleInfo.artifact_id then
				local artifactSvrData = {}

				artifactSvrData.gid = ""
				artifactSvrData.resid = clanBattleInfo.artifact_id
				artifactSvrData.level = clanBattleInfo.artifact_enhance or 0
				artifactSvrData.break_level = __utils.getArtifactNeedBreakLv(artifactSvrData.level)
				artifact = Artifact(artifactSvrData)
			end

			if relic then
				relic.inWearing = circleBattleHero.gid
			end

			circleBattleHero:setEquips(equips, artifact, relic)

			return circleBattleHero
		elseif clanBattleInfo.disable_clanbattle and clanBattleInfo.disable_clanbattle == 1 then
			-- block empty
		end
	elseif ResHero[hero.id] and ResHero[hero.id].quality > 2 then
		-- block empty
	end
end

function __utils.realCreateCircleBattleHero(hero, relic)
	return
end

function __utils.getMaxStepByLevel(heroLevel)
	local resultStep = 0

	for i, v in ipairs(ResStep) do
		if heroLevel >= v.level_limit then
			resultStep = i
		end
	end

	return resultStep
end

function __utils.getArtifactNeedBreakLv(enhanceLv)
	local breakLv = 0
	local totalMaxBreak = Const.ARTIFACT_MAX_BREAK_LEVEL

	for i = 0, totalMaxBreak do
		if enhanceLv > ResArtifactLevelUp[i].limit_level then
			breakLv = i + 1
		end
	end

	return breakLv
end

function __utils.setCircleHeadFrame(displayUI, headFrameId, endTime)
	if endTime and endTime > 0 and endTime < ClientUtils.getServerTime() then
		headFrameId = 0
	end

	if displayUI then
		local isShow = true
		local info = ResClanHeadFrame[headFrameId]

		if info then
			displayUI:setImage(info.icon_path, info.icon_name)

			if displayUI.headFrameId == headFrameId then
				if displayUI.effectChild then
					displayUI.effectChild:setVisible(true)
				end
			else
				if displayUI.effectChild then
					displayUI.effectChild:destroy()

					displayUI.effectChild = nil
				end

				if info and info.efx_path then
					displayUI.effectChild = UIControls.Child(displayUI, displayUI.mPath, info.efx_path)

					displayUI.effectChild:setVisible(true)
				end
			end
		else
			isShow = false
		end

		displayUI.headFrameId = headFrameId

		displayUI:setVisible(isShow)
	end
end

function __utils.getRevertedHero(hero, canResetStep)
	local svrData = {}

	svrData.gid = hero.gid
	svrData.resid = hero.id
	svrData.star = 6
	svrData.lock = hero.lock
	svrData.level = 1
	svrData.step = canResetStep == true and 0 or hero.step
	svrData.wake = 0
	svrData.equip = {}
	svrData.artifact = nil
	svrData.recharge = canResetStep == true and 0 or hero.recharge
	svrData.skin = hero.skin
	svrData.base = hero.base

	local revertedHero = Hero(svrData)

	if hero.mazeHp then
		revertedHero:setMazeAttr(hero.mazeHp)
	end

	return revertedHero
end

function __utils.getPlanHero(hero)
	local svrData = {}

	svrData.gid = hero.gid
	svrData.resid = hero.id
	svrData.star = hero.star
	svrData.lock = hero.lock
	svrData.level = hero.level
	svrData.step = hero.step
	svrData.wake = hero.wake
	svrData.equip = {}
	svrData.artifact = 0
	svrData.recharge = hero.recharge
	svrData.skin = hero.skin
	svrData.base = hero.base

	local planHero = Hero(svrData)

	planHero:initCrystalData()
	planHero:initTeamInfo()
	planHero:offAllEquips()

	return planHero
end

function __utils.getHeroBySvrData(heroBase)
	return Hero(heroBase)
end

function __utils.getIntactHeroObj(heroSvrData, equipsSvrData, artifactSvrData, relicSvrData, paint_level, ability, crystal_step, crystal_type, skin, base, relation, paintPlusLevel, paintPlusRelaLevel, seasonRelicSvrData, stickData)
	local intactHero = Hero(heroSvrData)
	local equips = {}

	for j, e in ipairs(equipsSvrData or {}) do
		if e.data.gid ~= "0" then
			local _equip = Equip(e.data)

			_equip.inWearing = intactHero.gid
			equips[_equip.subType] = _equip
		end
	end

	local artifact

	if artifactSvrData ~= nil and artifactSvrData.gid ~= "0" then
		artifact = Artifact(artifactSvrData)
		artifact.inWearing = intactHero.gid
	end

	local relic

	if relicSvrData ~= nil and relicSvrData.id ~= 0 then
		relic = Relic(relicSvrData)
		relic.inWearing = intactHero.gid
	end

	intactHero:setEquips(equips, artifact, relic)

	if seasonRelicSvrData and seasonRelicSvrData.id ~= 0 then
		local seasonRelic = Relic(seasonRelicSvrData)

		intactHero:setSeasonRelic(seasonRelic)
	end

	if paint_level and paint_level > 0 then
		intactHero:setPaintData(utils.getPaintData(intactHero.id, paint_level, ability))
	end

	if relation then
		intactHero:setRelationPointData(utils.getRelationPointData(relation.point))
	end

	local sData = {}

	sData.skin = {}
	sData.base = {}

	if skin then
		sData.skin = __utils.getBitsDictFromByteString(skin)
	end

	if base then
		sData.base = __utils.getBitsDictFromByteString(base)
	end

	if Const.PAINT_PLUS_OPEN and paintPlusLevel and paintPlusLevel ~= 0 then
		local paintData = {}

		paintData.level = paintPlusLevel

		if paintPlusRelaLevel and paintPlusRelaLevel ~= 0 then
			paintData.relateLevel = paintPlusLevel
		end

		intactHero:setPaintPlusData(paintData)
	end

	if stickData then
		intactHero:setStickData(utils.getStickData(stickData))
	end

	intactHero:setSkinData(sData)

	intactHero.otherCrystalStep = crystal_step or 0
	intactHero.otherCrystalType = crystal_type or 0

	return intactHero
end

function __utils.getHeroByFormationItem(item)
	if Const.PAINT_PLUS_OPEN then
		return utils.getIntactHeroObj(item.hero.base, item.equip, item.artifact, item.relic, item.paint_level, item.ability, nil, nil, item.skin, item.base, item.develop, item.new_paint_level, item.new_paint_relate_level, item.season_relic, item.stick)
	else
		return utils.getIntactHeroObj(item.hero.base, item.equip, item.artifact, item.relic, item.paint_level, item.ability, nil, nil, item.skin, item.base, item.develop, nil, nil, item.season_relic, item.stick)
	end
end

function __utils.getHeroListByFormation(formation)
	local heroDic = {}

	for order, item in ipairs(formation.item) do
		local hero = utils.getHeroByFormationItem(item)

		hero.order = order

		table.insert(heroDic, {
			item.idx,
			hero
		})
	end

	return heroDic
end

function __utils.getBattleMonsterInfo(monsterID, pos, camp, entityID)
	local player = {}

	player.entityID = entityID
	player.pos = pos
	player.monsterID = monsterID
	player.camp = camp

	return player
end

function __utils.getHeroAssistPos(passiveSkill, passiveLevel, heroPos, GridConfig)
	local assists = {}
	local posNum = 0
	local passiveData = ResPassiveSkill[passiveSkill] or {}

	passiveData = passiveData[passiveLevel]

	if passiveData and passiveData.support_type and GridConfig.PosToCoord[heroPos] then
		local buffType = passiveData.support_type

		if buffType == BattleConst.ASSIST_TYPE_LINE then
			local coord = GridConfig.PosToCoord[heroPos]
			local nowLine = math.floor(coord / BattleMiscConfig.ONE_LINE_MAX)

			for index = 1, #GridConfig.LineConfig[nowLine] / 2 do
				local tPos = GridConfig.LineConfig[nowLine][index]

				if tPos ~= heroPos then
					table.insert(assists, tPos)
				end
			end

			posNum = #assists
		elseif buffType == BattleConst.ASSIST_TYPE_NEB_ALL or buffType == BattleConst.ASSIST_TYPE_NEB_THREE or buffType == BattleConst.ASSIST_TYPE_NEB_TWO then
			local nebs = GridConfig.NebConfig[heroPos] or {}

			for _, nPos in ipairs(nebs) do
				if heroPos > 0 and nPos > 0 then
					table.insert(assists, nPos)
				elseif heroPos < 0 and nPos < 0 then
					table.insert(assists, nPos)
				end
			end

			if buffType == BattleConst.ASSIST_TYPE_NEB_THREE then
				posNum = 3
			elseif buffType == BattleConst.ASSIST_TYPE_NEB_TWO then
				posNum = 2
			else
				posNum = #assists
			end
		elseif buffType == BattleConst.ASSIST_TYPE_ALL then
			for index = 1, 12 do
				if index ~= heroPos then
					table.insert(assists, index)
				end
			end

			posNum = BattleConst.BATTLE_MAX_POS
		end
	end

	return assists, posNum
end

function __utils.getFormationCampMaxNum(fieldObjs)
	local playerMaxNum = 0
	local playerLightNum = 0
	local playerDarkNum = 0
	local playerCampNums = {}
	local monsterMaxNum = 0
	local monsterLightNum = 0
	local monsterDarkNum = 0
	local monsterCampNums = {}

	for pos, dragObj in pairs(fieldObjs) do
		local player = dragObj.hero

		if player and player.camp then
			if dragObj.isPlayer then
				if player.camp == Const.CAMP_TYPE.SLIM_SNOW then
					playerLightNum = playerLightNum + 1
				elseif player.camp == Const.CAMP_TYPE.NINE_NIGHT then
					playerDarkNum = playerDarkNum + 1
				else
					local num = playerCampNums[player.camp] or 0

					playerCampNums[player.camp] = num + 1

					if playerMaxNum < num + 1 then
						playerMaxNum = num + 1
					end
				end
			elseif player.camp == Const.CAMP_TYPE.SLIM_SNOW then
				monsterLightNum = monsterLightNum + 1
			elseif player.camp == Const.CAMP_TYPE.NINE_NIGHT then
				monsterDarkNum = monsterDarkNum + 1
			else
				local num = monsterCampNums[player.camp] or 0

				monsterCampNums[player.camp] = num + 1

				if monsterMaxNum < num + 1 then
					monsterMaxNum = num + 1
				end
			end
		end
	end

	local specCampInfo = {
		math.min(5, playerLightNum),
		math.min(5, playerDarkNum),
		math.min(5, monsterLightNum),
		math.min(5, monsterDarkNum)
	}

	return math.min(5, playerMaxNum + playerLightNum + playerDarkNum), math.min(5, monsterMaxNum + monsterLightNum + monsterDarkNum), specCampInfo
end

function __utils.getBattleCampMaxNum(entityDict)
	local playerMaxNum = 0
	local playerLightNum = 0
	local playerDarkNum = 0
	local playerCampNums = {}
	local monsterMaxNum = 0
	local monsterLightNum = 0
	local monsterDarkNum = 0
	local monsterCampNums = {}

	for objectID, playerinfo in pairs(entityDict) do
		local player = playerinfo.heroObj

		if player and player.camp then
			if playerinfo.camp == BattleConst.CAMP_PLAYER then
				if player.camp == Const.CAMP_TYPE.SLIM_SNOW then
					playerLightNum = playerLightNum + 1
				elseif player.camp == Const.CAMP_TYPE.NINE_NIGHT then
					playerDarkNum = playerDarkNum + 1
				else
					local num = playerCampNums[player.camp] or 0

					playerCampNums[player.camp] = num + 1

					if playerMaxNum < num + 1 then
						playerMaxNum = num + 1
					end
				end
			elseif player.camp == Const.CAMP_TYPE.SLIM_SNOW then
				monsterLightNum = monsterLightNum + 1
			elseif player.camp == Const.CAMP_TYPE.NINE_NIGHT then
				monsterDarkNum = monsterDarkNum + 1
			else
				local num = monsterCampNums[player.camp] or 0

				monsterCampNums[player.camp] = num + 1

				if monsterMaxNum < num + 1 then
					monsterMaxNum = num + 1
				end
			end
		end
	end

	local specCampInfo = {
		math.min(5, playerLightNum),
		math.min(5, playerDarkNum),
		math.min(5, monsterLightNum),
		math.min(5, monsterDarkNum)
	}

	return math.min(5, playerMaxNum + playerLightNum + playerDarkNum), math.min(5, monsterMaxNum + monsterLightNum + monsterDarkNum), specCampInfo
end

function __utils.getBattleObjMaxNum(entityDict, propName, needValue)
	local playerMaxNum = 0
	local playerNumDict = {}
	local monsterMaxNum = 0
	local monsterNumDict = {}

	for objectID, playerinfo in pairs(entityDict) do
		local player = playerinfo.heroObj

		if player and player[propName] then
			if playerinfo.camp == BattleConst.CAMP_PLAYER then
				local num = playerNumDict[player[propName]] or 0

				playerNumDict[player[propName]] = num + 1

				if playerMaxNum < num + 1 then
					playerMaxNum = num + 1
				end
			else
				local num = monsterNumDict[player[propName]] or 0

				monsterNumDict[player[propName]] = num + 1

				if monsterMaxNum < num + 1 then
					monsterMaxNum = num + 1
				end
			end
		end
	end

	if needValue then
		return playerNumDict[needValue] or 0, monsterNumDict[needValue] or 0
	else
		return playerMaxNum, monsterMaxNum
	end
end

function __utils.getDragPlaneMaxNum(fieldObjs, propName, needValue)
	local playerMaxNum = 0
	local playerNumDict = {}

	for pos, dragObj in pairs(fieldObjs) do
		local player = dragObj.hero

		if player and player.camp and dragObj.isPlayer and player[propName] then
			local num = playerNumDict[player[propName]] or 0

			playerNumDict[player[propName]] = num + 1

			if playerMaxNum < num + 1 then
				playerMaxNum = num + 1
			end
		end
	end

	if needValue then
		return playerNumDict[needValue] or 0
	else
		return playerMaxNum
	end
end

function __utils.getDeadlineStr(Deadline, ignoreHour, ignoreYear)
	if ignoreHour then
		return os.date("%Y/%m/%d", Deadline)
	elseif ignoreYear then
		return os.date("%m/%d %H:%M:%S", Deadline)
	else
		return os.date("%Y/%m/%d %H:%M", Deadline)
	end

	return " "
end

function __utils.calcTimeTxt(timeSecond, ignoreHour)
	if timeSecond < 0 then
		timeSecond = 0
	end

	local hour = math.floor(timeSecond / 3600)
	local minute = math.floor(math.fmod(timeSecond, 3600) / 60)
	local second = math.fmod(timeSecond, 60)
	local timeString = ""

	if hour >= 24 then
		timeString = string.format(Lang.get(29866), math.floor(hour / 24), math.fmod(hour, 24))
	elseif ignoreHour then
		timeString = string.format("%02d:%02d", minute, second)
	else
		timeString = string.format("%02d:%02d:%02d", hour, minute, second)
	end

	return timeString
end

function __utils.calcShortTimeTxt(timeSecond, strFormat)
	if timeSecond < 0 then
		timeSecond = 0
	end

	local hour = math.floor(timeSecond / 3600)
	local minute = math.floor(math.fmod(timeSecond, 3600) / 60)
	local second = math.fmod(timeSecond, 60)
	local timeString = ""

	if hour >= 24 then
		if strFormat then
			timeString = string.format(strFormat, utils.format(Lang.get(48649), math.floor(hour / 24)))
		else
			timeString = string.format(Lang.get(29867), math.floor(hour / 24))
		end
	else
		timeString = string.format("%02d:%02d:%02d", hour, minute, second)
	end

	return timeString
end

function __utils.calHeroSkillLevel(hero, skillType)
	local oriLevel = 0

	if skillType == Const.HERO_SKILL_FIELD.ATTACK or skillType == Const.HERO_SKILL_FIELD.SKILL then
		oriLevel = 1
	end

	if hero.recharge > 0 then
		return ResHeroRecharge[math.min(hero.recharge, hero:getMaxStep())][Const.HERO_SKILL_LEVEL_FIELD_DIC[skillType]]
	else
		return oriLevel
	end
end

function __utils.campIsLightOrDark(camp)
	return camp == Const.CAMP_TYPE.SLIM_SNOW or camp == Const.CAMP_TYPE.NINE_NIGHT
end

function __utils.getHeroMaxSkillLevel(hero, skillType)
	if hero.itemType and hero.itemType == Const.ITEM_TYPE_HERO then
		local maxStep = hero:getMaxStep()

		return ResHeroRecharge[maxStep][Const.HERO_SKILL_LEVEL_FIELD_DIC[skillType]]
	else
		local skillLevelField = Const.MONSTER_SKILL_LEVEL_FIELD_DIC[skillType]

		return ResMonster[hero.id][skillLevelField] or 0
	end
end

function __utils.getHeroLevelCost(hero, oriLv, targetLv)
	local materialIdNums = {}

	for level = oriLv, targetLv - 1 do
		local levelCost = ResLevelCost[hero.quality][level]

		for idx, id in ipairs(levelCost.res_id) do
			if not materialIdNums[id] then
				materialIdNums[id] = levelCost.res_num[idx]
			else
				materialIdNums[id] = materialIdNums[id] + levelCost.res_num[idx]
			end
		end

		if not materialIdNums[Const.MONEY_ID_GOLD] then
			materialIdNums[Const.MONEY_ID_GOLD] = levelCost.gold
		else
			materialIdNums[Const.MONEY_ID_GOLD] = materialIdNums[Const.MONEY_ID_GOLD] + levelCost.gold
		end
	end

	return materialIdNums
end

function __utils.getHeroLevelStepCost(hero, resetType)
	local materialIdNums = {}

	if resetType == Const.HERO_RESET_LEVEL or resetType == Const.HERO_RESET_ALL then
		for level = 1, hero.realLevel - 1 do
			local levelCost = ResLevelCost[hero.quality][level]

			if levelCost then
				for idx, id in ipairs(levelCost.res_id) do
					if not materialIdNums[id] then
						materialIdNums[id] = levelCost.res_num[idx]
					else
						materialIdNums[id] = materialIdNums[id] + levelCost.res_num[idx]
					end
				end

				if not materialIdNums[Const.MONEY_ID_GOLD] then
					materialIdNums[Const.MONEY_ID_GOLD] = levelCost.gold
				else
					materialIdNums[Const.MONEY_ID_GOLD] = materialIdNums[Const.MONEY_ID_GOLD] + levelCost.gold
				end
			end
		end
	end

	if resetType == Const.HERO_RESET_STEP or resetType == Const.HERO_RESET_ALL then
		for step = 1, hero.step do
			local stepCostInfo = ResStepCost[hero.resData.step_up_id][step]

			if stepCostInfo then
				for i, idNum in ipairs(stepCostInfo.materials) do
					if not materialIdNums[idNum.id] then
						materialIdNums[idNum.id] = idNum.num
					else
						materialIdNums[idNum.id] = materialIdNums[idNum.id] + idNum.num
					end
				end

				if not materialIdNums[Const.MONEY_ID_GOLD] then
					materialIdNums[Const.MONEY_ID_GOLD] = stepCostInfo.gold
				else
					materialIdNums[Const.MONEY_ID_GOLD] = materialIdNums[Const.MONEY_ID_GOLD] + stepCostInfo.gold
				end
			end
		end
	end

	return materialIdNums
end

function __utils.getHeroResetReturnMaterialList(hero, resetType)
	local materialIdNums = __utils.getHeroLevelStepCost(hero, resetType)

	for id, num in pairs(materialIdNums) do
		materialIdNums[id] = math.floor(num * (ResHeroResetMisc[1].ratio / 10000))
	end

	local materialList = {}

	for id, num in pairs(materialIdNums) do
		table.insert(materialList, {
			id = id,
			num = num
		})
	end

	local function sortMaterial(a, b)
		if a.id == Const.MONEY_ID_GOLD or b.id == Const.MONEY_ID_GOLD then
			return a.id == Const.MONEY_ID_GOLD
		elseif a.id == Const.MONEY_ID_HERO_EXP or b.id == Const.MONEY_ID_HERO_EXP then
			return a.id == Const.MONEY_ID_HERO_EXP
		elseif ResItem[a.id].quality ~= ResItem[b.id].quality then
			return ResItem[a.id].quality > ResItem[b.id].quality
		else
			return a.id < b.id
		end
	end

	table.sort(materialList, sortMaterial)

	return materialList
end

function __utils.getArtifactMainPropValue(artifact, propType, enhanceLevel, breakLevel)
	enhanceLevel = enhanceLevel or artifact.enhanceLevel
	breakLevel = breakLevel or artifact.breakLevel

	local oriMainPropValue = artifact.resData[propType]
	local breakValue = ResArtifactLevelUp[breakLevel].break_prop_v or 0

	if enhanceLevel > 0 then
		local rate = ResArtifactXP[artifact.resData.templete_id][enhanceLevel].prop_rate

		return math.floor(oriMainPropValue * (rate / 10000) + 0.5) + breakValue
	else
		return oriMainPropValue + breakValue
	end
end

function __utils.getRelicMainPropValue(relic, propType)
	return
end

function __utils.getEquipMainPropValue(equip, enhanceLevel, mainProp)
	mainProp = mainProp or equip.mainProp
	enhanceLevel = enhanceLevel or equip.enhanceLevel

	local oriMainPropValue = ResEquipMainProp[mainProp][equip.level].main_value1

	if enhanceLevel > 0 then
		local rate_id = ResEquipMainProp[mainProp][equip.level].lv_rate_id
		local rate = ResEquipMainPropTempl[rate_id][enhanceLevel].rate

		return math.floor(oriMainPropValue * (rate / 10000) + 0.5)
	else
		return oriMainPropValue
	end
end

function __utils.getEquipMainProp2Value(equip, mainProp)
	mainProp = mainProp or equip.mainProp2

	local oriMainPropValue = ResEquipMainProp[mainProp][equip.level].main_value2

	return oriMainPropValue
end

function __utils.sortOfEquip(equipA, equipB)
	if equipA.inWearing and not equipB.inWearing then
		return true
	elseif equipB.inWearing and not equipA.inWearing then
		return false
	end

	if equipA.part ~= equipB.part then
		return equipA.part < equipB.part
	elseif equipA.quality ~= equipB.quality then
		return equipA.quality > equipB.quality
	elseif equipA.level ~= equipB.level then
		return equipA.level > equipB.level
	else
		return equipA.id < equipB.id
	end
end

function __utils.sortOfArtifact(artifactA, artifactB)
	if artifactA.inWearing and not artifactB.inWearing then
		return true
	elseif artifactB.inWearing and not artifactA.inWearing then
		return false
	end

	if artifactA.quality ~= artifactB.quality then
		return artifactA.quality > artifactB.quality
	elseif artifactA.career ~= artifactB.career then
		return artifactA.career < artifactB.career
	else
		return artifactA.id < artifactB.id
	end
end

function __utils.GetPlayerName(playerName, uid)
	local selectedServerName = SvrListManager.getCurServerName()

	if playerName and playerName ~= "" then
		local nameList = __utils.splitString(playerName, "-")

		if nameList[2] == "" or nameList[2] == nil then
			nameList[2] = __utils.GetDefaultName(uid)
		end

		local serverID = tonumber(nameList[1])
		local serverName = SvrListManager.getServerName(serverID)

		if serverName then
			if RegionUtils.isJP() and string.find(nameList[2], "%$") then
				return Const.DEFAULT_NAME, serverName, serverID
			end

			return nameList[2], serverName, serverID
		else
			if RegionUtils.isJP() and string.find(playerName, "%$") then
				return Const.DEFAULT_NAME, selectedServerName
			end

			return playerName, selectedServerName
		end
	else
		return __utils.GetDefaultName(uid), selectedServerName
	end
end

function __utils.GetDefaultName(uid)
	if uid then
		return Const.DEFAULT_NAME .. uid
	else
		return Const.DEFAULT_NAME
	end
end

local CONDITION_TYPE_STATE = 1
local CONDITION_TYPE_HP = 2
local CONDITION_TYPE_CHECK_SHIELD = 3
local CONDITION_TYPE_ATTR_EQUAL = 4
local CONDITION_TYPE_CAMP_OVERCOME = 5
local CONDITION_TYPE_ATTR_GROUP = 6
local CONDITION_TYPE_STATE_GROUP = 7

function __utils._checkHasState(master, targetType, target, stateId)
	if targetType == 1 then
		return master:hasBattleState(stateId)
	elseif targetType == 2 then
		if target then
			return target:hasBattleState(stateId)
		end
	elseif targetType == 3 and target then
		return target:hasBattleState(stateId, master.id)
	end

	return false
end

function __utils.onCheckCondition(master, conditions, target)
	local condType = tonumber(conditions[1])

	if condType == CONDITION_TYPE_STATE then
		if conditions[4] == "1" then
			return not __utils._checkHasState(master, tonumber(conditions[2]), target, tonumber(conditions[3]))
		else
			return __utils._checkHasState(master, tonumber(conditions[2]), target, tonumber(conditions[3]))
		end
	elseif condType == CONDITION_TYPE_HP then
		local baseValue = 0

		if conditions[2] == "1" and target then
			if conditions[6] == "2" then
				baseValue = target.hp / target.mhp
			else
				baseValue = target.hp
			end
		elseif conditions[2] == "2" then
			if conditions[6] == "2" then
				baseValue = master.hp / master.mhp
			else
				baseValue = master.hp
			end
		end

		local targetValue = 0

		if conditions[4] == "2" and target then
			if conditions[6] == "2" then
				targetValue = target.hp / target.mhp
			else
				targetValue = target.hp
			end
		elseif conditions[4] == "1" then
			if conditions[6] == "2" then
				targetValue = master.hp / master.mhp
			else
				targetValue = master.hp
			end
		elseif conditions[4] == "3" then
			if conditions[6] == "2" then
				targetValue = tonumber(conditions[5]) / 10000
			else
				targetValue = tonumber(conditions[5])
			end
		end

		if conditions[3] == "1" then
			return targetValue < baseValue
		else
			return baseValue < targetValue
		end
	elseif condType == CONDITION_TYPE_CHECK_SHIELD then
		local hasShield = false

		if conditions[2] == "1" then
			hasShield = master.shield and master.shield > 0
		elseif conditions[2] == "2" and target then
			hasShield = target.shield and target.shield > 0
		end

		if conditions[3] == "1" then
			return not hasShield
		else
			return hasShield
		end
	elseif condType == CONDITION_TYPE_ATTR_EQUAL then
		local t = target

		if conditions[2] == "1" then
			t = master
		end

		return t and tostring(t[conditions[3]]) == conditions[4]
	elseif condType == CONDITION_TYPE_CAMP_OVERCOME then
		if not target or not target.race then
			return false
		end

		if conditions[2] == "1" and BattleConst.HERO_CAMP_OVERCOME[master.race] == target.race then
			return true
		elseif conditions[2] == "2" and BattleConst.HERO_CAMP_OVERCOME[target.race] == master.race then
			return true
		else
			return false
		end
	elseif condType == CONDITION_TYPE_ATTR_GROUP then
		local t = target

		if conditions[2] == "1" then
			t = master
		end

		local needAnd = false

		if conditions[3] == "1" then
			needAnd = true
		end

		for index = 1, 5 do
			local start = index * 2 + 2

			if conditions[start] and tostring(t[conditions[start]]) == conditions[start + 1] then
				if not needAnd then
					return true
				end
			elseif conditions[start] and needAnd then
				return false
			end
		end

		return needAnd
	elseif condType == CONDITION_TYPE_STATE_GROUP then
		local needAnd = false

		if conditions[2] == "1" then
			needAnd = true
		end

		for index = 1, 5 do
			local start = index * 3

			if not conditions[start] then
				break
			end

			local condSuit = false
			local targetType = tonumber(conditions[start])
			local stateId = tonumber(conditions[start + 1])
			local checkNoHas = conditions[start + 2] == "1"

			if checkNoHas then
				condSuit = not __utils._checkHasState(master, targetType, target, stateId)
			else
				condSuit = __utils._checkHasState(master, targetType, target, stateId)
			end

			if condSuit then
				if not needAnd then
					return true
				end
			elseif needAnd then
				return false
			end
		end

		return needAnd
	end

	return true
end

function __utils.checkFormationConditionLimit(conditionID, heros)
	local ResBattleFormationLimit = require("ClientData/ResBattleFormationLimit")

	if not conditionID or not ResBattleFormationLimit[conditionID] then
		return
	end

	if not heros then
		return false, 0
	end

	local checkNum = 0
	local condConfig = ResBattleFormationLimit[conditionID]

	for _, hero in ipairs(heros or {}) do
		if condConfig.check_type == Const.FORMATION_LIMIT_TYPE_CAMP then
			for _, camp in ipairs(condConfig.param or {}) do
				if hero.camp == camp then
					checkNum = checkNum + 1

					break
				end
			end
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_CAREER then
			for _, career in ipairs(condConfig.param or {}) do
				if hero.career == career then
					checkNum = checkNum + 1

					break
				end
			end
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_TEAM then
			for _, team in ipairs(condConfig.param or {}) do
				if hero.team == team then
					checkNum = checkNum + 1

					break
				end
			end
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_STAR then
			local needStar = condConfig.param[1]

			if needStar <= hero.star then
				checkNum = checkNum + 1
			end
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_STEP then
			checkNum = checkNum + hero.step
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_TOTAL_STAR then
			checkNum = checkNum + hero.star
		elseif condConfig.check_type == Const.FORMATION_LIMIT_TYPE_TOTAL_PAINT then
			checkNum = checkNum + hero.star

			local paintData = hero:getPaintData()

			if paintData and paintData.resData then
				checkNum = checkNum + paintData.resData.card_show_id + 1
			end
		end
	end

	if condConfig.compare_type == Const.FORMATION_LIMIT_COMPARE_TYPE_FILTER then
		return checkNum < condConfig.need_value
	else
		return checkNum >= condConfig.need_value, checkNum
	end
end

function __utils.openSweepDlg(gamePlayId, sweepRPC, costId, costNum, remainTimes, totalTimes, needId, needNum, getNumOnce)
	local sweepMainDlg = UIManager.getUI("sweepMainDlg", true)

	if sweepMainDlg then
		sweepMainDlg:initForSweepInfo(gamePlayId, sweepRPC, costId, costNum, {
			remainTimes = remainTimes,
			totalTimes = totalTimes,
			needId = needId,
			needNum = needNum,
			getNumOnce = getNumOnce
		})
	end
end

function __utils.getPositionByBattlePos(dir, centerPosition, battlePos, camp)
	if not BattleConst.NORMAL_POS_CONFIG[battlePos] then
		battlePos = 0
	end

	local orderX = BattleConst.NORMAL_POS_CONFIG[battlePos][1]
	local orderY = BattleConst.NORMAL_POS_CONFIG[battlePos][2]

	if camp == BattleConst.CAMP_MONSTER then
		orderX = BattleConst.LR_LEN - 1 - orderX
	end

	return __utils.getPositionByBattleCoord(dir, centerPosition, orderX, orderY)
end

function __utils.getPositionByBattleCoord(dir, centerPosition, coordX, coordY)
	local leftDir = dir * BattleConst.GRID_SIZE
	local upDir = Vector3(-dir.z, 0, dir.x) * BattleConst.GRID_SIZE * 0.866
	local newOffset = -leftDir * (BattleConst.LR_LEN - 1) / 2 - upDir * (BattleConst.UD_LEN - 1) / 2

	return leftDir * coordX + centerPosition + newOffset + upDir * coordY
end

function __utils.getNodePosition(nodeName)
	local node = UnityEngine.GameObject.Find(nodeName)

	if node then
		return node.transform.position
	end
end

function __utils.getCommonModelData(commonModelId)
	if not commonModelId then
		return
	end

	local modelData = ResCommonModel[commonModelId]

	if not modelData then
		return
	end

	return modelData
end

function __utils.getModelPathData(pathId)
	if not pathId then
		return
	end

	local pathData = ResModelPath[pathId]

	if not pathData then
		return
	end

	return pathData
end

function __utils.fixFashionPath(path, fashionTag)
	if not fashionTag or not FashionResource[path] or not FashionResource[path][fashionTag] then
		return path
	end

	return FashionResource[path][fashionTag]
end

function __utils.DebugNoticeSceneInfo(sceneInfo)
	MsgManager.notice(sceneInfo)
end

function __utils.isMoveEmoji(text)
	local res = string.gsub(text, "\r\n", "")
	local r = string.match(res, "(<%d+>)")

	if r == nil then
		return
	else
		local type = UIConst.EMOJI_TYPE_MAP[r]

		if type == UIConst.EMOJI_TYPE_MOVE then
			return r
		end
	end
end

function __utils.isLargeEmoji(text)
	local res = string.gsub(text, "\r\n", "")
	local r = string.match(res, "(<%d+>)")

	if r == nil then
		return
	else
		local type = UIConst.EMOJI_TYPE_MAP[r]

		if type and (type == UIConst.EMOJI_TYPE_LARGE or type == UIConst.EMOJI_TYPE_MOVE) then
			return r
		end
	end
end

function __utils.isPlayerEmoji(text)
	local res = string.gsub(text, "\r\n", "")
	local r = string.match(res, "(<%d+>)")

	if r == nil then
		return
	else
		local type = UIConst.EMOJI_TYPE_MAP[r]

		if type and type == UIConst.EMOJI_TYPE_PLAYER then
			return r
		end
	end
end

function __utils.getColorfulStr(str, color)
	return "<color=#" .. color.ff .. ">" .. str .. "</color>"
end

function __utils.getUnityColor(resColorData)
	return UnityEngine.Color(resColorData.r / 255, resColorData.g / 255, resColorData.b / 255, resColorData.a / 255)
end

local RANDOM_SCENE = {
	6,
	5,
	9,
	1,
	10
}

function __utils.getRandomScene()
	if not Const.RANDOM_SCENE_NO then
		local day = os.time() % 18000

		day = math.floor(day / 3600)
		day = day + 1
		Const.RANDOM_SCENE_NO = RANDOM_SCENE[day]
	end

	return Const.RANDOM_SCENE_NO
end

local RANDOM_BATTLE_SCENE = {
	{
		10002,
		10003,
		10004,
		10005
	},
	[5] = {
		20001,
		20002,
		20003,
		20004
	},
	[6] = {
		30002,
		30003,
		30004
	},
	[9] = {
		40001,
		40002,
		40003,
		40004
	},
	[10] = {
		50001,
		50002,
		50003,
		50004
	}
}

function __utils.getRandomBattleScene()
	local bigSceneNo = __utils.getRandomScene()
	local sceneList = RANDOM_BATTLE_SCENE[bigSceneNo]
	local randIdx = math.random(1, #sceneList)

	return sceneList[randIdx]
end

function __utils.removeTableElements(dic, removeNum, sortFunc)
	if dic == nil or type(dic) ~= "table" then
		return
	end

	local temp = {}

	for key, value in pairs(dic) do
		if value then
			table.insert(temp, key)
		end
	end

	table.sort(temp, function(v1, v2)
		return sortFunc(dic[v1], dic[v2])
	end)

	for i = 1, math.min(removeNum, #temp) do
		dic[temp[i]] = nil
	end
end

function __utils.PrintNotSame(value1, value2, needPrint)
	if type(value1) == "table" and type(value2) == "table" then
		local same = true

		for key, value in pairs(value1) do
			if not __utils.PrintNotSame(value, value2[key], needPrint) then
				same = false

				if needPrint then
					-- block empty
				end
			end
		end

		for key, value in pairs(value2) do
			if not __utils.PrintNotSame(value, value1[key], needPrint) then
				same = false

				if needPrint then
					-- block empty
				end

				same = false
			end
		end

		return same
	else
		if type(value1) == "number" and type(value2) == "number" and math.abs(value1 - value2) <= 1e-06 then
			return true
		end

		return value1 == value2
	end
end

local UN_SHOWN_EQUIP_HERO = {
	"roleInfoHeroDlg",
	"heroEquipEvolutionDlg",
	"equipChangeInfoDlg",
	"heroEquipUpGradeDlg",
	"equipTowerEquipHaveDlg"
}

function __utils.isCheckRoleInfo()
	for _, uiName in ipairs(UN_SHOWN_EQUIP_HERO) do
		local ui = UIManager.getUI(uiName, nil, false)

		if ui and ui:isInShow() then
			return true
		end
	end

	return false
end

function __utils.getHouseGroupBuffs(battleType, gIds)
	if gIds == nil or #gIds == 0 then
		return
	end

	local info
	local buffInfo = {}

	for _, numInfo in ipairs(gIds) do
		info = ResRearHouseGroup[numInfo.groupid]

		if numInfo.num > 0 and info and info.is_add_buff == 1 then
			local attrInfo = ResRearHouseGroupEffect[info.group_id]

			if attrInfo then
				for _, attr in ipairs(attrInfo.buff_effect) do
					if attr.num <= numInfo.num then
						local buff = __utils._getConfigBuffs(attr)

						if buff then
							table.insert(buffInfo, buff)
						end
					end
				end
			end
		end
	end

	return buffInfo
end

local ALLMAP = {}
local mt = {
	__index = function(...)
		return true
	end
}

setmetatable(ALLMAP, mt)

function __utils._getConfigBuffs(info)
	local isModeValid = false

	if info.mode == nil then
		isModeValid = true
	else
		for _, mode in ipairs(info.mode) do
			if BattleConst.HOUSE_BUFF_MODE_MAP[mode].type == battleType then
				isModeValid = true

				break
			end
		end
	end

	if not isModeValid then
		return
	end

	local camp, career, gameGroup, buffs

	if info.camp then
		camp = {}

		for _, campId in ipairs(info.camp or {}) do
			camp[campId] = true
		end
	else
		camp = ALLMAP
	end

	if info.career then
		career = {}

		for _, careerId in ipairs(info.career or {}) do
			career[careerId] = true
		end
	else
		career = ALLMAP
	end

	if info.game_group then
		gameGroup = {}

		for _, groupId in ipairs(info.game_group or {}) do
			gameGroup[groupId] = true
		end
	else
		gameGroup = ALLMAP
	end

	buffs = {}

	for j = 1, #info.type do
		if info.value[j] then
			buffs[info.type[j]] = info.value[j]
		end
	end

	return {
		camp = camp,
		career = career,
		gameGroup = gameGroup,
		buffs = buffs
	}
end

function __utils.getHeroHouseBuffs(hero, buffInfo)
	if buffInfo == nil or #buffInfo == 0 then
		return
	end

	local allBuffs = {}

	for _, oneBuff in ipairs(buffInfo) do
		if oneBuff.camp[hero.camp] and oneBuff.career[hero.career] and oneBuff.gameGroup[hero.team] then
			table.insert(allBuffs, oneBuff.buffs)
		end
	end

	return allBuffs
end

function __utils.getHeroHouseBuffProps(hero, buffInfo, props)
	local allBuffs = utils.getHeroHouseBuffs(hero, buffInfo)

	props = props or {}

	if allBuffs then
		for _, buff in ipairs(allBuffs or {}) do
			for pType, pValue in pairs(buff) do
				local attrName = BattleConst.PROP_TYPE_CONFIG[pType]

				props[attrName] = (props[attrName] or 0) + pValue
			end
		end
	end

	return props
end

function __utils.getHeroTeamProficientProps(hero, scores, props)
	props = props or {}

	if not hero.team then
		return props
	end

	local team
	local isOtherTeam = hero.team < 1 or hero.team > 6

	if not isOtherTeam then
		team = hero.team
	else
		team = Const.OTHER_TEAM_INDEX
	end

	if hero:isURHero() then
		team = Const.UR_TEAM_INDEX
	end

	if not scores[team] then
		return props
	end

	local score = scores[team][1] or 0
	local level = scores[team][2] or 0
	local gemAttrs = scores[team][3]
	local commonBuffs = __utils.getProficientCommonBuffs(score, isOtherTeam, hero:isURHero())

	if commonBuffs then
		for i, data in ipairs(commonBuffs) do
			local attrName = BattleConst.PROP_TYPE_CONFIG[data.id]

			props[attrName] = (props[attrName] or 0) + data.value
		end
	end

	local info = hero:isURHero() and ResURHeroProficientLevel[level] or ResHeroProficientLevel[level]

	if info then
		for i, id in pairs(info.attrs or {}) do
			local attrName = BattleConst.PROP_TYPE_CONFIG[id]

			props[attrName] = (props[attrName] or 0) + (info.value[i] or 0)
		end
	end

	if gemAttrs then
		for attr, totalValue in pairs(gemAttrs) do
			local attrName = BattleConst.PROP_TYPE_CONFIG[attr]

			props[attrName] = (props[attrName] or 0) + totalValue
		end
	end

	return props
end

function __utils.initHeadPendantProps(allRoleHeadPendant, props)
	props = props or {}

	for _, penId in ipairs(allRoleHeadPendant or {}) do
		local penData = ResRoleHeadPendant[penId]

		if penData and penData.attrs then
			for _, attrData in ipairs(penData.attrs) do
				local propName = BattleConst.PROP_TYPE_CONFIG[attrData.type]

				props[propName] = (props[propName] or 0) + attrData.value
			end
		end
	end

	return props
end

function __utils.getHeroTeamProficientStates(hero, scores)
	local data = {}

	if not hero.team then
		return data
	end

	local team = hero:isURHero() and Const.UR_TEAM_INDEX or hero.team

	if not scores[team] then
		return data
	end

	local level = scores[team][2] or 0

	for i = 1, level do
		local info = hero:isURHero() and ResURHeroProficientLevel[level] or ResHeroProficientLevel[level]

		if info and info.state_id then
			table.insert(data, info.state_id)
		end
	end

	return data
end

function __utils.getProficientCommonBuffs(score, isOtherTeam, isUR)
	score = score or 0

	for i, info in ipairs(ResHeroProficientScore) do
		if score == info.score then
			local preInfo = ResHeroProficientScore[score - 1]
			local data = isOtherTeam and {
				{
					id = 11,
					value = info.other_team_e_atk
				},
				{
					id = 13,
					value = info.other_team_e_mhp
				}
			} or {
				{
					id = 11,
					value = info.e_atk
				},
				{
					id = 13,
					value = info.e_mhp
				}
			}

			if isUR then
				data = {
					{
						id = 11,
						value = info.ur_team_e_atk
					},
					{
						id = 13,
						value = info.ur_team_e_mhp
					}
				}
			end

			if preInfo then
				data[1].isChange = preInfo.e_atk ~= info.e_atk
				data[2].isChange = preInfo.e_mhp ~= info.e_mhp
			else
				data[1].isChange = true
				data[2].isChange = true
			end

			return data
		end
	end
end

function __utils.getProficientLevelInfo(score, totalScore, isUR)
	score = score or 0
	totalScore = totalScore or 0

	local resData = isUR and ResURHeroProficientLevel or ResHeroProficientLevel

	for i = #resData, 1, -1 do
		local info = resData[i]

		if score >= info.group_score and totalScore >= info.total_score then
			return info
		end
	end
end

function __utils.getClanClearHeroScore(hero, actId)
	local score = 0

	if ResOpActClanBossLevelScore[actId] and ResOpActClanBossLevelScore[actId][hero.level] then
		score = score + (ResOpActClanBossLevelScore[actId][hero.level].score or 0)
	end

	if ResOpActClanBossStarScore[actId] and ResOpActClanBossStarScore[actId][hero.star] then
		score = score + (ResOpActClanBossStarScore[actId][hero.star].score or 0)
	end

	if ResOpActClanBossStepScore[actId] and ResOpActClanBossStepScore[actId][hero.step] then
		score = score + (ResOpActClanBossStepScore[actId][hero.step].score or 0)
	end

	local paintLevel = hero:getPaintLevel()

	if ResOpActClanBossPaintScore[actId] and ResOpActClanBossPaintScore[actId][paintLevel] then
		score = score + (ResOpActClanBossPaintScore[actId][paintLevel].score or 0)
	end

	return score
end

function __utils.getHeroStoryProps(crystalMaxLevel, storyUnlockDic, props)
	if crystalMaxLevel and crystalMaxLevel > 0 and storyUnlockDic then
		for sType, sInfo in pairs(ResHeroCrystalProp) do
			if storyUnlockDic[sType] then
				for phase, phaseInfo in ipairs(sInfo) do
					if phaseInfo[1] and crystalMaxLevel >= phaseInfo[1].need_level then
						for _, propInfo in ipairs(phaseInfo) do
							if crystalMaxLevel >= propInfo.need_level then
								local attrName = BattleConst.PROP_TYPE_CONFIG[propInfo.prop_type]

								props[attrName] = (props[attrName] or 0) + propInfo.prop_value
							else
								break
							end
						end
					else
						break
					end
				end
			end
		end
	end

	return props
end

local CLIENT_RANDOM_ID_START = 10000000

function __utils.SetRechargeContent(rechargeId, contentId)
	if contentId and ResPushGiftContent[contentId] and ResRecharge[rechargeId] then
		local contentData = ResPushGiftContent[contentId]
		local tmpClientData = {}

		tmpClientData.id = CLIENT_RANDOM_ID_START

		local show_ids = {}
		local show_nums = {}

		for _, idInfo in ipairs(contentData.content) do
			table.insert(show_ids, idInfo.id)
			table.insert(show_nums, idInfo.num)
		end

		tmpClientData.show_ids = show_ids
		tmpClientData.show_nums = show_nums
		ResRandClient[CLIENT_RANDOM_ID_START] = tmpClientData

		local rechargeData = ResRecharge[rechargeId]

		rechargeData.rand_id = CLIENT_RANDOM_ID_START

		local RechargeManager = require("System/Recharge/RechargeManager")
		local product = RechargeManager.getProductByRechargeId(rechargeId)

		if product then
			product.randId = CLIENT_RANDOM_ID_START
		end

		CLIENT_RANDOM_ID_START = CLIENT_RANDOM_ID_START + 1
	end
end

function __utils.GetBattleFrameRound(passedFrame, roundTime)
	local curFrame = 0

	for rNum, rTime in ipairs(roundTime or {}) do
		local frame = rTime

		if type(rTime) ~= "number" then
			frame = rTime.time
		end

		if passedFrame < curFrame + frame then
			return rNum, passedFrame - curFrame
		end

		curFrame = curFrame + frame
	end

	return 1, 0
end

function __utils.IsSyncBattlePassed(startTime, roundTime)
	local passedTime = ClientUtils.getServerTime() - startTime
	local passedFrame = math.max(0, math.floor(passedTime * 20 * BattleMiscConfig.SYNC_REPLAY_TIME_SPEED))
	local startRound, startFrame = utils.GetBattleFrameRound(passedFrame, roundTime)

	return startRound == 1 and startFrame == 0
end

function __utils.GetSyncBattleRemainTime(startTime, roundTime)
	local totalFrame = 0

	for rNum, rTime in pairs(roundTime or {}) do
		local frame = rTime

		if type(rTime) ~= "number" then
			frame = rTime.time
		end

		totalFrame = totalFrame + frame
	end

	local totalSecond = math.floor(totalFrame / (20 * BattleMiscConfig.SYNC_REPLAY_TIME_SPEED))

	return startTime + totalSecond - ClientUtils.getServerTime()
end

local orderCache = {}
local argsCache = {}

function __utils.format(fmt, ...)
	for k, v in pairs(orderCache) do
		orderCache[k] = nil
	end

	for k, v in pairs(argsCache) do
		argsCache[k] = nil
	end

	local num = select("#", ...)

	for i = 1, num do
		argsCache[i] = select(i, ...)
	end

	local done = 0

	fmt = fmt:gsub("%%(%d*):?([-+%d%.]*[cdfosxX])", function(order, placeholder)
		done = done + 1

		local arg = argsCache[tonumber(order)]

		if arg == nil and (IS_PUBLISH_VERSION or true) then
			arg = argsCache[done] or ""
		end

		table.insert(orderCache, arg)

		return "%" .. placeholder
	end)

	local status, ret = pcall(string.format, fmt, unpack(done ~= 0 and orderCache or argsCache))

	if status then
		return ret
	else
		return fmt
	end
end

function __utils.isInTable(container, key)
	for _, value in pairs(container or {}) do
		if value == key then
			return true
		end
	end

	return false
end

function __utils.getSamepleHero(data)
	local fakeServerHero = {}

	fakeServerHero.gid = data.gid
	fakeServerHero.resid = data.resid
	fakeServerHero.crystal_level = data.crystal_level
	fakeServerHero.level = data.level
	fakeServerHero.star = data.star
	fakeServerHero.step = data.step
	fakeServerHero.skin = data.skin

	return Hero(fakeServerHero)
end

function __utils.getDeepCopyHero(hero)
	local newHero = {}

	setmetatable(newHero, {
		__index = hero
	})

	return newHero
end

if not IsGLDeclared("utils") or not utils then
	GLDeclare("utils", __utils)
end

return __utils
