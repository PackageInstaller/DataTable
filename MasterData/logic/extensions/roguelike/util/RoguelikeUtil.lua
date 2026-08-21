-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/util/RoguelikeUtil.lua

module("logic.extensions.roguelike.util.RoguelikeUtil", package.seeall)

local M = class("RoguelikeUtil")
local MAP = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
local MAP2 = "abcdefghijklmnopqrstuvwxyz"

function M:ctor()
	self._selectRoles = {}
end

function M:getCardSlotCount(attrLevel)
	local openConfig = RoguelikeConfig.instance:getConstByName("CardSlotOpen").numValues
	local openCount = 1

	for k, v in pairs(openConfig) do
		if v <= attrLevel then
			openCount = k
		end
	end

	return openCount
end

function M:parseMapCoordinateStr(coordinate)
	local temp = string.gsub(coordinate, "%a+", ".")

	temp = string.sub(temp, 2, string.len(temp))

	local tempStrArr = string.split(temp, ".")
	local tempTable = {}

	for i = 1, #tempStrArr do
		local tempNumStr = tempStrArr[i]

		for j = 1, string.len(tempNumStr) do
			local tempNum = string.sub(tempNumStr, j, j)

			table.insert(tempTable, {
				i,
				tonumber(tempNum)
			})
		end
	end

	return tempTable
end

function M:parseRoomCoordinateStr(coordinate)
	local letter = string.match(coordinate, "%a+")
	local num = string.match(coordinate, "%d+")

	for i = 1, string.len(MAP) do
		local tempLetter = string.sub(MAP, i, i)

		if tempLetter == letter then
			return {
				i,
				tonumber(num)
			}
		end
	end

	return {
		1,
		1
	}
end

function M:convertCAttrType2SType(cType)
	local t1 = RoguelikeConst.DICE_PATTERN
	local t2 = RoguelikeExtension_pb.AttrType

	if cType == t1.POWER then
		return t2.POWER
	elseif cType == t1.AGILE then
		return t2.AGILITY
	elseif cType == t1.KNOWLEDGE then
		return t2.LORE
	elseif cType == t1.COMMUNICATE then
		return t2.CHAT
	elseif cType == t1.INSIGHT then
		return t2.INSIGHT
	elseif cType == t1.LUCKY then
		return t2.LUCK
	elseif cType == t1.CRITICAL_STRIKE then
		return t2.SUCCESS_2
	elseif cType == t1.SACRIFICE then
		return t2.SACRIFICE_1
	elseif cType == t1.SACRIFICE_2 then
		return t2.SACRIFICE_2
	elseif cType == t1.SACRIFICE_3 then
		return t2.SACRIFICE_3
	elseif cType == t1.SACRIFICE_4 then
		return t2.SACRIFICE_4
	elseif cType == t1.SACRIFICE_5 then
		return t2.SACRIFICE_5
	elseif cType == t1.SACRIFICE_6 then
		return t2.SACRIFICE_6
	elseif cType == t1.REDUCE_WISDOM then
		return t2.ECLIPSE_1
	elseif cType == t1.REDUCE_WISDOM_2 then
		return t2.ECLIPSE_2
	elseif cType == t1.REDUCE_WISDOM_3 then
		return t2.ECLIPSE_3
	elseif cType == t1.REDUCE_WISDOM_4 then
		return t2.ECLIPSE_4
	elseif cType == t1.REDUCE_WISDOM_5 then
		return t2.ECLIPSE_5
	elseif cType == t1.REDUCE_WISDOM_6 then
		return t2.ECLIPSE_6
	elseif cType == t1.BLEEDING then
		return t2.BLEED_1
	elseif cType == t1.BLEEDING_2 then
		return t2.BLEED_2
	elseif cType == t1.BLEEDING_3 then
		return t2.BLEED_3
	elseif cType == t1.BLEEDING_4 then
		return t2.BLEED_4
	elseif cType == t1.BLEEDING_5 then
		return t2.BLEED_5
	elseif cType == t1.BLEEDING_6 then
		return t2.BLEED_6
	elseif cType == t1.TRANCE then
		return t2.TRANCE_1
	elseif cType == t1.TRANCE_2 then
		return t2.TRANCE_2
	elseif cType == t1.TRANCE_3 then
		return t2.TRANCE_3
	elseif cType == t1.TRANCE_4 then
		return t2.TRANCE_4
	elseif cType == t1.TRANCE_5 then
		return t2.TRANCE_5
	elseif cType == t1.TRANCE_6 then
		return t2.TRANCE_6
	elseif cType == t1.CURSE then
		return t2.CURSE
	elseif cType == t1.BLESSING then
		return t2.BLESS
	elseif cType == t1.NORMAL then
		return t2.SUCCESS_1
	elseif cType == t1.NORMAL_2 then
		return t2.SUCCESS_2
	elseif cType == t1.NORMAL_3 then
		return t2.SUCCESS_3
	elseif cType == t1.NORMAL_4 then
		return t2.SUCCESS_4
	elseif cType == t1.NORMAL_5 then
		return t2.SUCCESS_5
	elseif cType == t1.NORMAL_6 then
		return t2.SUCCESS_6
	elseif cType == t1.CONTROL then
		return t2.CONTROL
	elseif cType == t1.DEIFY then
		return t2.DEIFY
	elseif cType == t1.COUNTER then
		return t2.COUNTER
	elseif cType == t1.TECHNOLOGY then
		return t2.TECHNOLOGY
	elseif cType == t1.FATHER then
		return t2.FATHER
	elseif cType == t1.DAUGHTER then
		return t2.DAUGHTER
	end

	return nil
end

function M:convertSAttrTypeCSType(sType)
	local t2 = RoguelikeConst.DICE_PATTERN
	local t1 = RoguelikeExtension_pb.AttrType

	if sType == t1.POWER then
		return t2.POWER
	elseif sType == t1.AGILITY then
		return t2.AGILE
	elseif sType == t1.LORE then
		return t2.KNOWLEDGE
	elseif sType == t1.CHAT then
		return t2.COMMUNICATE
	elseif sType == t1.INSIGHT then
		return t2.INSIGHT
	elseif sType == t1.LUCK then
		return t2.LUCKY
	elseif sType == t1.CRIT then
		return t2.CRITICAL_STRIKE
	elseif sType == t1.SACRIFICE_1 then
		return t2.SACRIFICE
	elseif sType == t1.SACRIFICE_2 then
		return t2.SACRIFICE_2
	elseif sType == t1.SACRIFICE_3 then
		return t2.SACRIFICE_3
	elseif sType == t1.SACRIFICE_4 then
		return t2.SACRIFICE_4
	elseif sType == t1.SACRIFICE_5 then
		return t2.SACRIFICE_5
	elseif sType == t1.SACRIFICE_6 then
		return t2.SACRIFICE_6
	elseif sType == t1.ECLIPSE_1 then
		return t2.REDUCE_WISDOM
	elseif sType == t1.ECLIPSE_2 then
		return t2.REDUCE_WISDOM_2
	elseif sType == t1.ECLIPSE_3 then
		return t2.REDUCE_WISDOM_3
	elseif sType == t1.ECLIPSE_4 then
		return t2.REDUCE_WISDOM_4
	elseif sType == t1.ECLIPSE_5 then
		return t2.REDUCE_WISDOM_5
	elseif sType == t1.ECLIPSE_6 then
		return t2.REDUCE_WISDOM_6
	elseif sType == t1.BLEED_1 then
		return t2.BLEEDING
	elseif sType == t1.BLEED_2 then
		return t2.BLEEDING_2
	elseif sType == t1.BLEED_3 then
		return t2.BLEEDING_3
	elseif sType == t1.BLEED_4 then
		return t2.BLEEDING_4
	elseif sType == t1.BLEED_5 then
		return t2.BLEEDING_5
	elseif sType == t1.BLEED_6 then
		return t2.BLEEDING_6
	elseif sType == t1.TRANCE_1 then
		return t2.TRANCE
	elseif sType == t1.TRANCE_2 then
		return t2.TRANCE_2
	elseif sType == t1.TRANCE_3 then
		return t2.TRANCE_3
	elseif sType == t1.TRANCE_4 then
		return t2.TRANCE_4
	elseif sType == t1.TRANCE_5 then
		return t2.TRANCE_5
	elseif sType == t1.TRANCE_6 then
		return t2.TRANCE_6
	elseif sType == t1.CURSE then
		return t2.CURSE
	elseif sType == t1.BLESS then
		return t2.BLESSING
	elseif sType == t1.SUCCESS_1 then
		return t2.NORMAL
	elseif sType == t1.SUCCESS_2 then
		return t2.NORMAL_2
	elseif sType == t1.SUCCESS_3 then
		return t2.NORMAL_3
	elseif sType == t1.SUCCESS_4 then
		return t2.NORMAL_4
	elseif sType == t1.SUCCESS_5 then
		return t2.NORMAL_5
	elseif sType == t1.SUCCESS_6 then
		return t2.NORMAL_6
	elseif sType == t1.CONTROL then
		return t2.CONTROL
	elseif sType == t1.DEIFY then
		return t2.DEIFY
	elseif sType == t1.COUNTER then
		return t2.COUNTER
	elseif sType == t1.TECHNOLOGY then
		return t2.TECHNOLOGY
	elseif sType == t1.FATHER then
		return t2.FATHER
	elseif sType == t1.DAUGHTER then
		return t2.DAUGHTER
	end

	print("没找到对应面", sType, debug.traceback())

	return t2.WHITE
end

function M:saveCurCoordinate()
	local allRoomMos = RoguelikeModel.instance:getRoomMOs() or {}

	self._curCoordinates = {}
	self._coordinateIndex = {}
	self._curCutCoordinates = {}
	self._curCoordinates2RoomMo = {}

	local curMapId = RoguelikeModel.instance:getCurMapId()
	local curCutRooms = RoguelikeModel.instance:getCurCutRooms() or {}

	function checkInCutRoom(coordinateStr)
		for k, v in ipairs(curCutRooms) do
			if v == coordinateStr then
				return true
			end
		end

		return false
	end

	for idx, mo in ipairs(allRoomMos) do
		if mo:getMapId() == curMapId then
			local coordinate = mo:getCoordinate()
			local isCutRoom = mo:getIsCutRoom()

			if isCutRoom then
				table.insert(self._curCutCoordinates, coordinate)
			elseif checkInCutRoom(mo:getCoordinateStr()) then
				table.insert(self._curCutCoordinates, coordinate)
			end

			table.insert(self._coordinateIndex, coordinate)

			self._curCoordinates[coordinate[1]] = self._curCoordinates[coordinate[1]] or {}
			self._curCoordinates[coordinate[1]][coordinate[2]] = coordinate
			self._curCoordinates2RoomMo[coordinate[1]] = self._curCoordinates2RoomMo[coordinate[1]] or {}
			self._curCoordinates2RoomMo[coordinate[1]][coordinate[2]] = mo
		end
	end
end

function M:getIsInCutRoom(coordinate)
	for k, v in pairs(self._curCutCoordinates or {}) do
		if v[1] == coordinate[1] and v[2] == coordinate[2] then
			return true
		end
	end

	return false
end

function M:saveCurCoordinate2()
	local allRoomMos = RoguelikeModel.instance:getRoom2MOs() or {}

	self._curCoordinates2 = {}
	self._coordinateIndex2 = {}
	self._curCoordinates2RoomMo2 = {}

	local curMapId = RoguelikeModel.instance:getCurSecondMapId()

	for idx, mo in ipairs(allRoomMos) do
		if mo:getMapId() == curMapId then
			local coordinate = mo:getCoordinate()

			table.insert(self._coordinateIndex2, coordinate)

			self._curCoordinates2[coordinate[1]] = self._curCoordinates2[coordinate[1]] or {}
			self._curCoordinates2[coordinate[1]][coordinate[2]] = coordinate
			self._curCoordinates2RoomMo2[coordinate[1]] = self._curCoordinates2RoomMo2[coordinate[1]] or {}
			self._curCoordinates2RoomMo2[coordinate[1]][coordinate[2]] = mo
		end
	end
end

function M:getIndexByCoordinate(coordinate)
	for k, v in ipairs(self._coordinateIndex) do
		if v[1] == coordinate[1] and v[2] == coordinate[2] then
			return k
		end
	end
end

function M:getIndexByCoordinate2(coordinate)
	for k, v in ipairs(self._coordinateIndex2) do
		if v[1] == coordinate[1] and v[2] == coordinate[2] then
			return k
		end
	end
end

function M:getNearCoordinates(coordinate, coordinate2, lineNodes)
	local x = coordinate[1]
	local y = coordinate[2]
	local x2 = coordinate2[1]
	local y2 = coordinate2[2]
	local result = {}
	local isFinish = false
	local cellInfo = self._curCoordinates2RoomMo[x][y]:getCellInfo()
	local cellDir = cellInfo and {
		cellInfo.up,
		cellInfo.down,
		cellInfo.left,
		cellInfo.right
	} or {}
	local matchKey = 2

	function insertToResult(tb1, index)
		if tb1 == nil then
			return
		end

		local co = tb1[index]

		if isFinish then
			return
		end

		if co ~= nil then
			for k, v in pairs(lineNodes) do
				if v[1] == co[1] and v[2] == co[2] then
					return
				end
			end

			table.insert(result, co)

			if co[1] == coordinate2[1] and co[2] == coordinate2[2] then
				isFinish = true
				result = {}

				table.insert(result, co)
			end
		end
	end

	function checkIsVisible(tb1, index)
		if tb1 == nil then
			return false
		end

		local mo = tb1[index]

		if mo ~= nil then
			return mo:getIsVisible()
		end

		return false
	end

	function insertCoordinate(tb1, index1, tb2, dir)
		if checkIsVisible(tb2, index1) then
			if cellInfo then
				if tostring(cellDir[dir]) ~= "0" and tostring(cellDir[dir]) ~= "1" then
					insertToResult(tb1, index1)
				end
			else
				insertToResult(tb1, index1)
			end
		end
	end

	insertCoordinate(self._curCoordinates[x], y - 1, self._curCoordinates2RoomMo[x], 1)
	insertCoordinate(self._curCoordinates[x], y + 1, self._curCoordinates2RoomMo[x], 2)
	insertCoordinate(self._curCoordinates[x + 1], y, self._curCoordinates2RoomMo[x + 1], 4)
	insertCoordinate(self._curCoordinates[x - 1], y, self._curCoordinates2RoomMo[x - 1], 3)

	return result, isFinish
end

function M:getNearCoordinates2(coordinate, coordinate2, lineNodes)
	local x = coordinate[1]
	local y = coordinate[2]
	local x2 = coordinate2[1]
	local y2 = coordinate2[2]
	local result = {}
	local isFinish = false

	function insertToResult(tb1, index)
		if tb1 == nil then
			return
		end

		local co = tb1[index]

		if isFinish then
			return
		end

		if co ~= nil then
			for k, v in pairs(lineNodes) do
				if v[1] == co[1] and v[2] == co[2] then
					return
				end
			end

			table.insert(result, co)

			if co[1] == coordinate2[1] and co[2] == coordinate2[2] then
				isFinish = true
				result = {}

				table.insert(result, co)
			end
		end
	end

	function checkIsVisible(tb1, index)
		if tb1 == nil then
			return false
		end

		local mo = tb1[index]

		if mo ~= nil then
			return mo:getIsVisible()
		end

		return false
	end

	function insertCoordinate(tb1, index1, tb2)
		if checkIsVisible(tb2, index1) then
			insertToResult(tb1, index1)
		end
	end

	insertCoordinate(self._curCoordinates2[x], y - 1, self._curCoordinates2RoomMo2[x], 1)
	insertCoordinate(self._curCoordinates2[x], y + 1, self._curCoordinates2RoomMo2[x], 2)
	insertCoordinate(self._curCoordinates2[x + 1], y, self._curCoordinates2RoomMo2[x + 1], 4)
	insertCoordinate(self._curCoordinates2[x - 1], y, self._curCoordinates2RoomMo2[x - 1], 3)

	return result, isFinish
end

local calcTime = 500

function M:getLineCoordinate(coordinate1, coordinate2, findCallback)
	self._allLines = {}
	self._calcTime = calcTime
	self._findTarget = false
	self._findResultList = {}

	local line1 = {
		coordinate1
	}

	table.insert(self._allLines, line1)

	function self._findCallback(lines)
		local temp = ""
		local tempIndex = {}
		local hadMeetQuestion = false

		for k, v in ipairs(lines) do
			local mo = self._curCoordinates2RoomMo[v[1]][v[2]]

			if not hadMeetQuestion then
				table.insert(tempIndex, self:getIndexByCoordinate(v))

				temp = temp .. string.format("[%d,%d]", v[1], v[2]) .. "->"

				if mo and not mo:getIsClear() and k > 1 then
					hadMeetQuestion = true
				end
			end
		end

		local isMoveOne = RoguelikeConfig.instance:getConstByName("MoveOneSquareEffect").numValue == 1

		if isMoveOne and #tempIndex > 1 then
			tempIndex = {
				tempIndex[1],
				tempIndex[2]
			}
		end

		if findCallback then
			findCallback(tempIndex)
		end
	end

	self:createLine(coordinate1, coordinate2, line1)

	if #self._findResultList == 0 then
		FloatWordMgr.instance:show("当前路径不可达")
	else
		function getIsClear(indexList)
			for k, v in pairs(indexList) do
				local mo = self._curCoordinates2RoomMo[v[1]][v[2]]

				if mo and not mo:getIsClear() then
					return 1
				end
			end

			return 0
		end

		table.sort(self._findResultList, function(a, b)
			if #a ~= #b then
				return #a < #b
			else
				local aHadClear = getIsClear(a)
				local bHadMeet = getIsClear(b)

				return aHadClear < bHadMeet
			end
		end)
		self._findCallback(self._findResultList[1])
	end
end

function M:getLineCoordinate2(coordinate1, coordinate2, findCallback)
	self._allLines = {}
	self._calcTime = calcTime
	self._findTarget = false
	self._findResultList = {}

	local line1 = {
		coordinate1
	}

	table.insert(self._allLines, line1)

	function self._findCallback(lines)
		local temp = ""
		local tempIndex = {}
		local hadMeetQuestion = false

		for k, v in ipairs(lines) do
			local mo = self._curCoordinates2RoomMo2[v[1]][v[2]]

			if not hadMeetQuestion then
				table.insert(tempIndex, self:getIndexByCoordinate2(v))

				temp = temp .. string.format("[%d,%d]", v[1], v[2]) .. "->"

				if mo and not mo:getIsClear() and k > 1 then
					hadMeetQuestion = true
				end
			end
		end

		local isMoveOne = RoguelikeConfig.instance:getConstByName("MoveOneSquareEffect").numValue == 1

		if isMoveOne and #tempIndex > 1 then
			tempIndex = {
				tempIndex[1],
				tempIndex[2]
			}
		end

		if findCallback then
			findCallback(tempIndex)
		end

		print("路径结果", #lines, #tempIndex, temp)
	end

	self:createLine2(coordinate1, coordinate2, line1)

	if #self._findResultList == 0 then
		FloatWordMgr.instance:show("当前路径不可达")
	else
		function getIsClear(indexList)
			for k, v in pairs(indexList) do
				local mo = self._curCoordinates2RoomMo2[v[1]][v[2]]

				if mo and not mo:getIsClear() then
					return 1
				end
			end

			return 0
		end

		table.sort(self._findResultList, function(a, b)
			if #a ~= #b then
				return #a < #b
			else
				local aHadClear = getIsClear(a)
				local bHadMeet = getIsClear(b)

				return aHadClear < bHadMeet
			end
		end)
		self._findCallback(self._findResultList[1])
	end
end

function M:createLine(coordinate1, targetCoordinate, lineNodes)
	if self._calcTime < 0 then
		return
	end

	self._calcTime = self._calcTime - 1

	local nearNodes, isFinish = self:getNearCoordinates(coordinate1, targetCoordinate, lineNodes)

	if #nearNodes > 0 then
		if isFinish then
			self._findTarget = true

			table.insert(lineNodes, nearNodes[1])

			local curLineNodes = {}
			local hadCut = false

			for k, v in ipairs(lineNodes) do
				if not hadCut then
					if k < #lineNodes then
						if self:getIsInCutRoom(v) and self:getIsInCutRoom(lineNodes[k + 1]) then
							hadCut = true
							self._findTarget = false

							return
						end

						table.insert(curLineNodes, v)
					else
						table.insert(curLineNodes, v)
					end
				end
			end

			table.insert(self._findResultList, TableUtil.deepCopy(curLineNodes))
		end

		if #nearNodes == 1 then
			table.insert(lineNodes, nearNodes[1])
			self:createLine(lineNodes[#lineNodes], targetCoordinate, lineNodes)
		else
			for k, v in ipairs(nearNodes) do
				local newLineNodes = TableUtil.deepCopy(lineNodes)

				table.insert(self._allLines, newLineNodes)
				table.insert(newLineNodes, v)
				self:createLine(newLineNodes[#newLineNodes], targetCoordinate, newLineNodes)
			end
		end
	end
end

function M:createLine2(coordinate1, targetCoordinate, lineNodes)
	if self._calcTime < 0 then
		return
	end

	self._calcTime = self._calcTime - 1

	local nearNodes, isFinish = self:getNearCoordinates2(coordinate1, targetCoordinate, lineNodes)

	if #nearNodes > 0 then
		if isFinish then
			self._findTarget = true

			table.insert(lineNodes, nearNodes[1])
			table.insert(self._findResultList, TableUtil.deepCopy(lineNodes))
		end

		if #nearNodes == 1 then
			table.insert(lineNodes, nearNodes[1])
			self:createLine2(lineNodes[#lineNodes], targetCoordinate, lineNodes)
		else
			for k, v in ipairs(nearNodes) do
				local newLineNodes = TableUtil.deepCopy(lineNodes)

				table.insert(self._allLines, newLineNodes)
				table.insert(newLineNodes, v)
				self:createLine2(newLineNodes[#newLineNodes], targetCoordinate, newLineNodes)
			end
		end
	end
end

function M:getWorldPos(position, camera)
	local kUICamera = self._uiCamera

	if kUICamera == nil then
		kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	end

	self._objCamera = camera ~= nil and camera or self._objCamera

	local ptScreen = UnityEngine.RectTransformUtility.WorldToScreenPoint(kUICamera, position)

	ptScreen.z = 0
	ptScreen.z = math.abs(kUICamera.transform.position.z - position.z)

	local ptWorld = self._objCamera:ScreenToWorldPoint(ptScreen)

	return ptWorld
end

function M:getWorldPosByOffset(position, offset)
	local offsetX = offset and offset or 1

	position.x = position.x - offsetX

	return self:getWorldPos(position)
end

function M:getScriptMemoryProgress(scriptId)
	local curCount = 0
	local meetMonsters = RoguelikeModel.instance:getLogInfo().monster
	local meetProps = RoguelikeModel.instance:getLogInfo().props
	local meetClue = RoguelikeModel.instance:getLogInfo().clue

	function checkIsMeet(id, meetList)
		for k, v in ipairs(meetList) do
			if v == id then
				return true
			end
		end

		return false
	end

	local allThreads = BackpackConfig.instance:getItemsInfoByType(GameEnum.ItemTypeEnum.RoguelikeClueType)
	local curThreads = {}

	for k, v in pairs(allThreads) do
		if v.galleryId == scriptId then
			table.insert(curThreads, v)

			if checkIsMeet(v.id, meetClue) then
				curCount = curCount + 1
			end
		end
	end

	local allMonsters = RoguelikeConfig.instance:getAllMonster()
	local curMonsters = {}

	for k, v in pairs(allMonsters) do
		if v.galleryId == scriptId then
			table.insert(curMonsters, v)

			if checkIsMeet(v.id, meetMonsters) then
				curCount = curCount + 1
			end
		end
	end

	local allProps = RoguelikeConfig.instance:getAllProps()
	local curProps = {}

	for k, v in pairs(allProps) do
		if v.galleryId == scriptId then
			table.insert(curProps, v)

			if checkIsMeet(v.id, meetProps) then
				curCount = curCount + 1
			end
		end
	end

	local allCount = #curThreads + #curMonsters + #curProps

	return curCount, allCount
end

function M:checkOpenCampEffect(scriptId, level)
	local effectIds = RoguelikeConfig.instance:getCurDiffLevelEffects(level, scriptId)

	for k, v in pairs(effectIds or {}) do
		local effectCo = RoguelikeConfig.instance:getEffectById(v)

		if effectCo and effectCo.program == "OpenCampEffect" then
			return true
		end
	end

	return false
end

function M:createSelectRoles()
	if #self._selectRoles > 0 then
		return self._selectRoles
	else
		for i = 1, 4 do
			local role = RogueMapGenerator.createMapRole()

			table.insert(self._selectRoles, role)
		end

		return self._selectRoles
	end
end

function M:getSelectRoles()
	return self._selectRoles
end

function M:destroySelectRoles()
	for k, v in pairs(self._selectRoles or {}) do
		v:destroy()
	end

	self._selectRoles = {}
end

function M:getExploreScriptsKey()
	local kExploreScripts = "kExploreScripts"
	local key = kExploreScripts .. PlayerModel.instance:getId()

	return key
end

function M:saveExploreScripts()
	local allScript = RoguelikeConfig.instance:getAllScript()
	local str = ""

	for i = 1, #allScript do
		str = str .. allScript[i].id .. "-"
	end

	Astral.LocalStorage.Instance:SetString(self:getExploreScriptsKey(), str)
end

function M:getLastExploreScripts()
	local allScript = RoguelikeConfig.instance:getAllScript()
	local str = Astral.LocalStorage.Instance:GetString(self:getExploreScriptsKey(), "")
	local scriptId = RoguelikeConfig.instance:getConstByName("GuideScriptId").numValue
	local isFinish = RoguelikeConst.IsGuideFinish()

	if isFinish then
		return allScript[#allScript], false
	end

	if str ~= "" then
		local scriptIds = string.split(str, "-")
		local allScriptIds = {}

		for _, id in ipairs(scriptIds) do
			table.insert(allScriptIds, tonumber(id))
		end

		function checkIsNew(id)
			for k, v in pairs(allScriptIds) do
				if id == v then
					return false
				end
			end

			return true
		end

		if not isFinish then
			for k, v in pairs(allScript) do
				if scriptId == v.id then
					return v, false
				end
			end
		end

		for k, v in pairs(allScript) do
			if checkIsNew(v.id) then
				return v, true
			end
		end

		return allScript[#allScript], false
	end

	return allScript[1], true
end

function M:getIsGuideScript()
	local scriptId = RoguelikeConfig.instance:getConstByName("GuideScriptId").numValue

	return scriptId == RoguelikeModel.instance:getCurScriptId()
end

M.instance = M.New()

return M
