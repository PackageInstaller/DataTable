-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gm/view/gameeditor/crossword/CrosswordGM.lua

module("logic.extensions.gm.view.gameeditor.crossword.CrosswordGM", package.seeall)

local CrosswordGM = class("CrosswordGM")
local startX = 50
local startY = 50
local len = 100

function splitToChars(inputstr)
	local t = {}

	for i = 1, #inputstr do
		local char = inputstr:sub(i, i)

		table.insert(t, char)
	end

	return t
end

function splitChineseCharacters(input)
	local result = {}
	local i = 1
	local length = #input

	while i <= length do
		local char = string.sub(input, i, i)
		local byte = string.byte(char)

		if byte >= 240 then
			table.insert(result, string.sub(input, i, i + 3))

			i = i + 4
		elseif byte >= 224 then
			table.insert(result, string.sub(input, i, i + 2))

			i = i + 3
		elseif byte >= 192 then
			table.insert(result, string.sub(input, i, i + 1))

			i = i + 2
		else
			table.insert(result, char)

			i = i + 1
		end
	end

	return result
end

function CrosswordGM:_tryRedo()
	self._myList = {}

	for i, arr in ipairs(self._recordList) do
		table.insert(self._myList, arr)
	end

	for i = #self._myList, 1, -1 do
		local newIdx = math.random(1, i)

		self._myList[i] = self._myList[newIdx]
		self._myList[newIdx] = self._myList[i]
	end

	return self:_startTryFillIn()
end

function CrosswordGM:_startTryFillIn()
	self._map = {}
	self._jumpMap = {}
	self._result = {}
	self._startIdx = 0

	local a = table.remove(self._myList, 1)

	self:_trySetInToMap(a, 1, startX, startY)

	local count = #self._myList + 100

	while #self._myList > 0 do
		local arr, j, obj = self:_findWordsInMap(self._myList)

		if obj == nil then
			return false
		end

		local boo = self:_tryDealNext(arr, j, obj)

		if not boo then
			table.insert(self._myList, arr)
		end

		count = count - 1

		if count < 0 then
			return false
		end
	end

	return true
end

function CrosswordGM:enterWords(str)
	if string.nilorempty(str) then
		TipsFacade.instance:openCommonTips("填字游戏命令行错误，无参数")

		return
	end

	local arr = string.split(str, "#")

	self._recordCount = 100
	self._recordList = {}
	self._myList = {}

	for i, str in ipairs(arr) do
		local tem = splitChineseCharacters(str)

		table.insert(self._myList, tem)
		table.insert(self._recordList, tem)
	end

	local isFill = self:_startTryFillIn()

	if not isFill then
		printError(">>>>开始打乱次序")

		for i = 1, 100 do
			isFill = self:_tryRedo()

			if isFill then
				break
			end
		end
	end

	if not isFill then
		printError(">>>>已经尝试很多次了。还存在找不到的情况！检查输入,打乱次序试试！！")

		return
	end

	local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge

	for k, obj in pairs(self._map) do
		minX = math.min(minX, obj.x)
		maxX = math.max(maxX, obj.x)
		minY = math.min(minY, obj.y)
		maxY = math.max(maxY, obj.y)
	end

	print(minX, maxX, minY, maxY)

	local s = ""

	for y = 1, maxY - minY + 1 do
		for x = 1, maxX - minX + 1 do
			local idx = self:_getIdx(x + minX - 1, y + minY - 1)
			local obj = self._map[idx]

			s = obj and s .. obj.char or s .. "　"
		end

		s = s .. "\n"
	end

	printError(">>>>>>>>>>>>>>>>>===============\n", s)

	local resStr = ""

	for i, v in ipairs(self._result) do
		local blStr = table.concat(v.belongList, ",")
		local sfStr = table.concat(v.startFlags, ",")

		resStr = resStr .. langPara("活动Id\t%s\t%s\t%s\t%s\t[%s]\t[%s]\n", i, v.char, v.x - minX + 1, v.y - minY + 1, blStr, sfStr)
	end

	printError(">>>>>>>>>>===============\n", resStr, "\n========================")
	Game.TextUtil.CopyToClipBoard(resStr)
	TipsFacade.instance:openPopupWindow("填字结果已经复制", s)
end

function CrosswordGM:_getIdx(x, y)
	return x - 1 + (y - 1) * len
end

function CrosswordGM:_trySetInToMap(arr, type, sx, sy)
	local list = {}

	for i, v in ipairs(arr) do
		local idx = 0

		idx = type == 1 and self:_getIdx(sx + i - 1, sy) or self:_getIdx(sx, sy + i - 1)

		if self._map[idx] == nil or self._map[idx].char == v then
			local obj

			table.insert(list, type == 1 and {
				char = v,
				type = type,
				x = sx + i - 1,
				y = sy,
				idx = idx,
				belongList = {},
				startFlags = {}
			} or {
				char = v,
				type = type,
				x = sx,
				y = sy + i - 1,
				idx = idx,
				belongList = {},
				startFlags = {}
			})
		else
			printError(">>>>>>>>>ERROR!!", v, sx, sy, idx, self._map[idx].char)

			return false
		end
	end

	self._startIdx = self._startIdx + 1

	ArraySort.sortOn(list, "idx")

	for i, v in ipairs(list) do
		local key = v.idx

		if self._map[key] then
			table.insert(self._map[key].belongList, self._startIdx)

			if i == 1 then
				if type == 1 then
					table.insert(self._map[key].startFlags, self._startIdx)
				else
					table.insert(self._map[key].startFlags, -1 * self._startIdx)
				end
			end
		else
			self._map[key] = v

			table.insert(self._map[key].belongList, self._startIdx)

			if i == 1 then
				if type == 1 then
					table.insert(self._map[key].startFlags, self._startIdx)
				else
					table.insert(self._map[key].startFlags, -1 * self._startIdx)
				end
			end

			table.insert(self._result, v)
		end
	end

	return true
end

function CrosswordGM:_findWordsInMap(list)
	for i, arr in ipairs(list) do
		for j, char in ipairs(arr) do
			for k, obj in pairs(self._map) do
				if char == obj.char and (self._jumpMap[arr] == nil or self._jumpMap[arr][k] == nil) then
					table.remove(list, i)

					self._jumpMap[arr] = self._jumpMap[arr] or {}
					self._jumpMap[arr][k] = true

					return arr, j, obj
				end
			end
		end
	end
end

function CrosswordGM:_tryDealNext(arr, j, obj)
	if obj == nil then
		return
	end

	local sx, sy, type

	if obj.type == 1 then
		type = 2
		sx = obj.x
		sy = obj.y - j + 1
	else
		type = 1
		sx = obj.x - j + 1
		sy = obj.y
	end

	return (self:_trySetInToMap(arr, type, sx, sy))
end

CrosswordGM.instance = CrosswordGM.New()

return CrosswordGM
