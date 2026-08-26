-- chunkname: @modules/common/utils/GameUtil.lua

module("modules.common.utils.GameUtil", package.seeall)

local GameUtil = {}

function GameUtil.getBriefName(str, charCount, suffix)
	if LuaUtil.isEmptyStr(str) then
		return ""
	end

	local charLen = LuaUtil.getStrLen(str)

	if charLen <= charCount then
		return str
	end

	local ucharArr = LuaUtil.getUCharArr(str)

	if ucharArr == nil or #ucharArr <= 0 then
		return LuaUtil.emptyStr
	end

	suffix = suffix or "..."

	local newStr = LuaUtil.emptyStr
	local counter = 0

	for i = 1, #ucharArr do
		local byte = string.byte(ucharArr[i])

		if byte > 0 and byte <= 127 then
			counter = counter + 1
		elseif byte >= 192 and byte <= 239 then
			counter = counter + 2
		end

		if counter <= charCount then
			newStr = newStr .. ucharArr[i]
		end
	end

	return newStr .. suffix
end

function GameUtil.getUCharArrWithoutRichTxt(str)
	local richTags = {}

	str = string.gsub(str, "(<[^>]+>)", function(s)
		table.insert(richTags, s)

		return "▩"
	end)

	local ucharArr = LuaUtil.getUCharArr(str) or {}

	for i = #ucharArr, 1, -1 do
		if ucharArr[i] == "▩" then
			local tag = table.remove(richTags) or ""

			if ucharArr[i + 1] then
				ucharArr[i + 1] = tag .. ucharArr[i + 1]

				table.remove(ucharArr, i)
			else
				ucharArr[i] = tag
			end
		end
	end

	return ucharArr
end

function GameUtil.getUCharArrWithLineFeedWithoutRichTxt(str)
	local richTags = {}

	str = string.gsub(str, "(<[^>]+>)", function(s)
		table.insert(richTags, s)

		return "▩"
	end)

	local ucharArr = LuaUtil.getUCharArrWithLineFeed(str) or {}

	for i = #ucharArr, 1, -1 do
		if ucharArr[i] == "▩" then
			local tag = table.remove(richTags) or ""

			if ucharArr[i + 1] then
				ucharArr[i + 1] = tag .. ucharArr[i + 1]

				table.remove(ucharArr, i)
			else
				ucharArr[i] = tag
			end
		end
	end

	return ucharArr
end

function GameUtil.removeJsonNull(jsonTb)
	for k, v in pairs(jsonTb) do
		if v == cjson.null then
			jsonTb[k] = nil
		elseif type(v) == "table" then
			GameUtil.removeJsonNull(v)
		end
	end
end

function GameUtil.getBriefNameByWidth(str, txtComponent, offsetWidth, suffix)
	if LuaUtil.isEmptyStr(str) then
		return ""
	end

	local charLen = LuaUtil.getStrLen(str)

	if charLen <= 0 then
		return str
	end

	local destWidth = txtComponent.transform.sizeDelta.x - (offsetWidth or 15)
	local preferredWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(txtComponent, str)

	if preferredWidth < destWidth then
		return str
	end

	suffix = suffix or "..."

	for i = charLen - 1, 1, -1 do
		local newStr = GameUtil.getBriefName(str, i, "")
		local newWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(txtComponent, newStr)

		if newWidth < destWidth then
			return newStr .. suffix
		end
	end

	return str .. suffix
end

function GameUtil.trimInput(inputStr)
	inputStr = string.gsub(inputStr, "　", "")

	return string.gsub(inputStr, "[ \t\n\r]+", "")
end

function GameUtil.trimInput1(inputStr)
	inputStr = string.gsub(inputStr, "　", "")

	return string.gsub(inputStr, "[ \t\r]+", "")
end

function GameUtil.filterSpecChars(s)
	local ss = {}
	local k = 1

	while true do
		if k > #s then
			break
		end

		local c = string.byte(s, k)

		if not c then
			break
		end

		if c < 192 then
			if c >= 48 and c <= 57 or c >= 65 and c <= 90 or c >= 97 and c <= 122 then
				table.insert(ss, string.char(c))
			end

			k = k + 1
		elseif c < 224 then
			k = k + 2
		elseif c < 240 then
			if c >= 228 and c <= 233 then
				local c1 = string.byte(s, k + 1)
				local c2 = string.byte(s, k + 2)

				if c1 and c2 then
					local a1, a2, a3, a4 = 128, 191, 128, 191

					if c == 228 then
						a1 = 184
					elseif c == 233 then
						a2, a4 = 190, c1 ~= 190 and 191 or 165
					end

					if a1 <= c1 and c1 <= a2 and a3 <= c2 and c2 <= a4 then
						table.insert(ss, string.char(c, c1, c2))
					end
				end
			end

			k = k + 3
		elseif c < 248 then
			k = k + 4
		elseif c < 252 then
			k = k + 5
		elseif c < 254 then
			k = k + 6
		end
	end

	return table.concat(ss)
end

function GameUtil.containsPunctuation(str)
	if LuaUtil.isEmptyStr(str) then
		return false
	end

	local count = #str
	local k = 1

	for i = 1, count do
		local byte = string.byte(str, k)

		if byte then
			if byte >= 48 and byte <= 57 or byte >= 65 and byte <= 90 or byte >= 97 and byte <= 122 then
				k = k + 1
			elseif byte >= 228 and byte <= 233 then
				k = k + 3
			elseif byte == 227 then
				local b2 = string.byte(str, k + 1)

				if b2 then
					if b2 == 129 or b2 == 130 then
						k = k + 3
					elseif b2 == 130 or b2 == 131 then
						k = k + 3
					else
						return true
					end
				else
					return false
				end
			elseif byte >= 234 and byte <= 237 then
				k = k + 3
			else
				return true
			end
		end
	end

	return false
end

function GameUtil.test()
	local a = "233不顺利的！"

	logNormal("a length = " .. LuaUtil.getStrLen(a) .. " a ch = " .. LuaUtil.getChineseLen(a))
	logNormal("LuaUtil.getBriefName = " .. GameUtil.getBriefName(a, 6, ".prefab"))

	local input = "地饭 大发      大\ndd哈哈\t哈哈\b"

	logNormal("trimInput = " .. GameUtil.trimInput(input))
	logNormal("trimInput1 = " .. GameUtil.trimInput1(input))

	input = "地饭大 发大\ndd哈哈\t哈哈\b"

	logNormal("trimInput1 = " .. GameUtil.trimInput1("地饭大 发大\ndd哈哈\t哈哈\b"))
	logNormal("GameUtil.containsPunctuation = " .. tostring(GameUtil.containsPunctuation(input)))
end

function GameUtil.parseColor(colorStr)
	return SLFramework.UGUI.GuiHelper.ParseColor(colorStr)
end

function GameUtil.colorToHex(color)
	return SLFramework.UGUI.GuiHelper.ColorToHex(color)
end

function GameUtil.splitString2(str, isNumber, separation1, separation2)
	if GameUtil.needLogInFightSceneUseStringFunc() then
		logError("战斗中不要用`GameUtil.splitString2`, 用`FightStrUtil.getSplitString2Cache`代替")
	end

	if string.nilorempty(str) then
		return
	end

	separation1 = separation1 or "|"
	separation2 = separation2 or "#"

	local ans = string.split(str, separation1)

	for i, each in ipairs(ans) do
		ans[i] = isNumber and string.splitToNumber(each, separation2) or string.split(each, separation2)
	end

	return ans
end

GameUtil.RichTextTags = {
	"<b>",
	"</b>",
	"<i>",
	"</i>",
	"<size=.->",
	"</size>",
	"<color=.->",
	"</color>",
	"<material=.->",
	"</material>",
	"<quad.->",
	"</quad>",
	"<align=.->"
}

function GameUtil.filterRichText(inputStr)
	local result = inputStr

	for i, v in ipairs(GameUtil.RichTextTags) do
		result = string.gsub(result, v, "")
	end

	return result
end

function GameUtil.numberDisplay(number)
	local num = tonumber(number)

	if num <= 99999 then
		return num
	elseif num <= 99999999 and num > 99999 then
		return math.floor(num / 1000) .. "K"
	else
		return math.floor(num / 1000000) .. "M"
	end
end

local romanNums = {
	"I",
	"II",
	"III",
	"IV",
	"V",
	"VI",
	"VII",
	"VIII",
	"IX",
	"X",
	"XI",
	"XII",
	"XIII",
	"XIV",
	"XV",
	"XVI",
	"XVII",
	"XVIII",
	"XIX",
	"XX"
}

function GameUtil.getRomanNums(index)
	return romanNums[index]
end

local ROMAN_NUM_MIN = 1
local ROMAN_NUM_MAX = 3999
local romanValueList = {
	1000,
	900,
	500,
	400,
	100,
	90,
	50,
	40,
	10,
	9,
	5,
	4,
	1
}
local romanSymbolList = {
	"M",
	"CM",
	"D",
	"CD",
	"C",
	"XC",
	"L",
	"XL",
	"X",
	"IX",
	"V",
	"IV",
	"I"
}

function GameUtil.getRomanNums2(num)
	if type(num) ~= "number" or num ~= math.floor(num) then
		logError(string.format("GameUtil.getRomanNums2 error, need integer, num=%s", num))

		return
	end

	if num < ROMAN_NUM_MIN or num > ROMAN_NUM_MAX then
		logError(string.format("GameUtil.getRomanNums2 error, num=%d out of range [%d, %d]", num, ROMAN_NUM_MIN, ROMAN_NUM_MAX))

		return
	end

	local result = ""

	for i = 1, #romanValueList do
		local val = romanValueList[i]
		local count = math.floor(num / val)

		if count > 0 then
			result = result .. string.rep(romanSymbolList[i], count)
			num = num - val * count
		end
	end

	return result
end

local num2Chinese = {
	[0] = "零",
	"一",
	"二",
	"三",
	"四",
	"五",
	"六",
	"七",
	"八",
	"九"
}
local unitName = {
	"十",
	"百",
	"千",
	"万",
	"十",
	"百",
	"千",
	"亿",
	"十",
	"百",
	"千",
	"兆"
}

function GameUtil.getNum2Chinese(index)
	if not LangSettings.instance:isZh() then
		return index
	end

	if index < 10 then
		return num2Chinese[index] or index
	else
		local zhChar = num2Chinese
		local places = unitName
		local numStr = tostring(index)
		local len = string.len(numStr)
		local str = {}
		local has0 = false

		for i = 1, len do
			local n = tonumber(string.sub(numStr, i, i))
			local p = len - i + 1

			if n > 0 and has0 == true then
				str[#str + 1] = num2Chinese[0]
				has0 = false
			end

			if p % 4 == 2 and n == 1 then
				if p < len then
					str[#str + 1] = zhChar[n]
				end

				str[#str + 1] = places[p - 1] or ""
			elseif n > 0 then
				str[#str + 1] = zhChar[n]
				str[#str + 1] = places[p - 1] or ""
			elseif n == 0 then
				if p % 4 == 1 then
					str[#str + 1] = places[p - 1] or ""
				else
					has0 = true
				end
			end
		end

		return table.concat(str, "")
	end
end

GameUtil.englishOrderNumber = {}
GameUtil.englishOrderNumber[1] = "FIRST"
GameUtil.englishOrderNumber[2] = "SECOND"
GameUtil.englishOrderNumber[3] = "THIRD"
GameUtil.englishOrderNumber[4] = "FOURTH"
GameUtil.englishOrderNumber[5] = "FIFTH"
GameUtil.englishOrderNumber[6] = "SIXTH"
GameUtil.englishOrderNumber[7] = "SEVENTH"
GameUtil.englishOrderNumber[8] = "EIGHTH"
GameUtil.englishOrderNumber[9] = "NINTH"
GameUtil.englishOrderNumber[10] = "TENTH"

function GameUtil.getEnglishOrderNumber(number)
	return GameUtil.englishOrderNumber[number] or string.format("%dth", number)
end

local englishNumber = {
	"ONE",
	"TWO",
	"THREE",
	"FOUR",
	"FIVE",
	"SIX",
	"SEVEN",
	"EIGHT",
	"NINE",
	"TEN",
	"ELEVEN",
	"TWELVE",
	"THIRTEEN",
	"FOURTEEN",
	"FIFTEEN",
	"SIXTEEN",
	"SEVENTEEN",
	"EIGHTEEN",
	"NINETEEN",
	"TWENTY"
}

function GameUtil.getEnglishNumber(number)
	return englishNumber[number]
end

function GameUtil.charsize(ch)
	if not ch then
		return 0
	elseif ch >= 252 then
		return 6
	elseif ch >= 248 and ch < 252 then
		return 5
	elseif ch >= 240 and ch < 248 then
		return 4
	elseif ch >= 224 and ch < 240 then
		return 3
	elseif ch >= 192 and ch < 224 then
		return 2
	elseif ch < 192 then
		return 1
	end
end

function GameUtil.utf8len(str)
	if string.nilorempty(str) then
		return 0
	end

	local len = 0
	local aNum = 0
	local hNum = 0
	local currentIndex = 1

	while currentIndex <= #str do
		local char = string.byte(str, currentIndex)
		local cs = GameUtil.charsize(char)

		currentIndex = currentIndex + cs
		len = len + 1

		if cs == 1 then
			aNum = aNum + 1
		elseif cs >= 2 then
			hNum = hNum + 1
		end
	end

	return len, aNum, hNum
end

function GameUtil.utf8sub(str, startChar, numChars)
	local startIndex = 1

	while startChar > 1 do
		local char = string.byte(str, startIndex)

		startIndex = startIndex + GameUtil.charsize(char)
		startChar = startChar - 1
	end

	local currentIndex = startIndex

	while numChars > 0 and currentIndex <= #str do
		local char = string.byte(str, currentIndex)

		currentIndex = currentIndex + GameUtil.charsize(char)
		numChars = numChars - 1
	end

	return string.sub(str, startIndex, currentIndex - 1)
end

function GameUtil.utf8isnum(str)
	if string.nilorempty(str) then
		return false
	end

	for i = 1, string.len(str) do
		local char = string.byte(str, i)

		if not char then
			return false
		end

		if char < 48 or char > 57 then
			return false
		end
	end

	return true
end

function GameUtil.getPreferredWidth(text, content)
	return SLFramework.UGUI.GuiHelper.GetPreferredWidth(text, content)
end

function GameUtil.getPreferredHeight(text, content)
	return SLFramework.UGUI.GuiHelper.GetPreferredHeight(text, content)
end

function GameUtil.getTextHeightByLine(text, content, lineHeight, linespace)
	local singleLineHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(text, " ")
	local textHeight = SLFramework.UGUI.GuiHelper.GetPreferredHeight(text, content)
	local space = linespace or 0

	return (singleLineHeight > 0 or nil) and (textHeight / singleLineHeight * lineHeight + (textHeight / singleLineHeight - 1) * space or 0)
end

function GameUtil.getTextWidthByLine(text, content, wordWidth)
	local singleWordWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(text, "啊")
	local txtWidth = SLFramework.UGUI.GuiHelper.GetPreferredWidth(text, content)

	return (singleWordWidth > 0 or nil) and (txtWidth / singleWordWidth * wordWidth or 0)
end

function GameUtil.getSubPlaceholderLuaLang(text, fillParams)
	if fillParams and #fillParams > 0 then
		text = string.gsub(text, "▩([0-9]+)%%([sd])", function(index, format)
			index = tonumber(index)

			if not fillParams[index] then
				if isDebugBuild then
					local tbl = {
						"[getSubPlaceholderLuaLang] =========== begin",
						"text: " .. text,
						"index: " .. index,
						"format: " .. format,
						"fillParams[index]: 不存在",
						"[getSubPlaceholderLuaLang] =========== end"
					}

					logError(table.concat(tbl, "\n"))
				end

				return ""
			end

			if type(fillParams[index]) == "number" and format == "d" then
				return string.format("%d", fillParams[index])
			end

			if isDebugBuild and string.find(fillParams[index], "%%", 1, true) then
				local tbl = {
					[1] = "[getSubPlaceholderLuaLang] =========== begin",
					[6] = "[getSubPlaceholderLuaLang] =========== end",
					[2] = "text: " .. text,
					[3] = "index: " .. index,
					[4] = "format: " .. format,
					[5] = "fillParams[index]:" .. fillParams[index]
				}

				logError(table.concat(tbl, "\n"))
			end

			return fillParams[index]
		end)
	end

	return text
end

function GameUtil.getSubPlaceholderLuaLangOneParam(text, param)
	text = string.gsub(text, "▩1%%s", param)

	return text
end

function GameUtil.getSubPlaceholderLuaLangTwoParam(text, param1, param2)
	text = string.gsub(text, "▩1%%s", param1)
	text = string.gsub(text, "▩2%%s", param2)

	return text
end

function GameUtil.getSubPlaceholderLuaLangThreeParam(text, param1, param2, param3)
	text = string.gsub(text, "▩1%%s", param1)
	text = string.gsub(text, "▩2%%s", param2)
	text = string.gsub(text, "▩3%%s", param3)

	return text
end

function GameUtil.getMarkIndexList(text)
	local startParser = "<em>"
	local endParser = "</em>"

	text = string.gsub(text, startParser, "▩1")
	text = string.gsub(text, endParser, "▩2")
	text = string.gsub(text, "<[^<>][^<>]->", "")
	text = string.gsub(text, "▩1", startParser)
	text = string.gsub(text, "▩2", endParser)

	local indexList = {}

	if string.nilorempty(text) or string.nilorempty(startParser) or string.nilorempty(endParser) then
		return indexList
	end

	local startIndexList = {}
	local startSplits = string.split(text, startParser)
	local startIndex = 1

	for i, startSplit in ipairs(startSplits) do
		if i == #startSplits then
			break
		end

		startIndex = startIndex + GameUtil.utf8len(startSplit) + (i == 1 and 0 or 1) * GameUtil.utf8len(startParser)

		table.insert(startIndexList, startIndex)
	end

	local endIndexList = {}
	local endSplits = string.split(text, endParser)
	local endIndex = 1

	for i, endSplit in ipairs(endSplits) do
		if i == #endSplits then
			break
		end

		endIndex = endIndex + GameUtil.utf8len(endSplit) + (i == 1 and 0 or 1) * GameUtil.utf8len(endParser)

		table.insert(endIndexList, endIndex)
	end

	local flag = false
	local index = 0
	local offset = 0

	while index <= GameUtil.utf8len(text) do
		if LuaUtil.tableContains(startIndexList, index) then
			flag = true
			index = index + GameUtil.utf8len(startParser)
			offset = offset + GameUtil.utf8len(startParser)
		elseif LuaUtil.tableContains(endIndexList, index) then
			flag = false
			index = index + GameUtil.utf8len(endParser)
			offset = offset + GameUtil.utf8len(endParser)
		else
			if flag then
				table.insert(indexList, index - offset - 1)
			end

			index = index + 1
		end
	end

	return indexList
end

function GameUtil.getMarkText(text)
	if string.nilorempty(text) then
		return ""
	end

	text = string.gsub(text, "<em>", "")
	text = string.gsub(text, "</em>", "")

	return text
end

function GameUtil.getTimeFromString(timeStr)
	if string.nilorempty(timeStr) then
		return 9999999999
	end

	local _, _, year, month, day, hour, minute, second = string.find(timeStr, "(%d-)%-(%d-)%-(%d-)%s-(%d-):(%d-):(%d+)")

	return os.time({
		year = tonumber(year),
		month = tonumber(month),
		day = tonumber(day),
		hour = tonumber(hour),
		min = tonumber(minute),
		sec = tonumber(second)
	})
end

function GameUtil.getTabLen(array)
	local count = 0

	if array then
		for k, v in pairs(array) do
			if array[k] ~= nil then
				count = count + 1
			end
		end
	end

	return count
end

function GameUtil.getAdapterScale()
	local now = Time.time

	if GameUtil._adapterScale and GameUtil._scaleCalcTime and now - GameUtil._scaleCalcTime < 0.01 then
		return GameUtil._adapterScale
	end

	GameUtil._scaleCalcTime = now

	local width = UnityEngine.Screen.width
	local height = UnityEngine.Screen.height

	if BootNativeUtil.isWindows() and not SLFramework.FrameworkSettings.IsEditor then
		width, height = SettingsModel.instance:getCurrentScreenSize()
	end

	local screenRatio = width / height
	local targetRatio = 1.7777777777777777

	GameUtil._adapterScale = targetRatio - screenRatio > 0.01 and targetRatio / screenRatio or 1

	return GameUtil._adapterScale
end

function GameUtil.fillZeroInLeft(num, len)
	local str = tostring(num)

	return string.rep("0", len - #str) .. str
end

function GameUtil.randomTable(t)
	local n = #t

	for i = 1, n do
		local j = math.random(i, n)

		t[i], t[j] = t[j], t[i]
	end

	return t
end

function GameUtil.getUniqueRandomNumbers(min, max, count)
	local range = max - min + 1

	count = math.min(count, range)

	local numbers = {}

	for i = min, max do
		table.insert(numbers, i)
	end

	for i = range, 2, -1 do
		local j = math.random(1, i)

		numbers[i], numbers[j] = numbers[j], numbers[i]
	end

	local result = {}

	for i = 1, count do
		result[i] = numbers[i]
	end

	return result
end

function GameUtil.artTextNumReplace(text)
	if string.nilorempty(text) then
		return text
	end

	local num = text
	local numCount = string.len(num)
	local numTab = {}

	while num > 0 do
		local lastNum = num % 10

		table.insert(numTab, 1, lastNum)

		num = math.floor(num / 10)
	end

	local formatStr = ""

	for i = 1, numCount do
		formatStr = formatStr .. string.format("<sprite=%s>", numTab[i])
	end

	return formatStr
end

function GameUtil.tabletool_fastRemoveValueByValue(array, value)
	for i, v in ipairs(array) do
		if v == value then
			return GameUtil.tabletool_fastRemoveValueByPos(array, i)
		end
	end
end

function GameUtil.tabletool_fastRemoveValueByPos(array, pos)
	local removeValue = array[pos]

	array[pos] = array[#array]

	table.remove(array)

	return array, removeValue
end

function GameUtil.tabletool_dictIsEmpty(dict)
	if not dict then
		return true
	end

	for _, _ in pairs(dict) do
		return false
	end

	return true
end

function GameUtil.tabletool_checkDictTable(refDict, key)
	if type(refDict) ~= "table" then
		logError("GameUtil.tabletool_checkDictTable error, refDict is not a table")

		return
	end

	if not key then
		logError("GameUtil.tabletool_checkDictTable error, key is nil")

		return
	end

	local table = refDict[key]

	if not table then
		table = {}
		refDict[key] = table
	end

	return table
end

function GameUtil.checkPointInRectangle(point, a, b, c, d)
	local ab = b - a
	local ap = point - a
	local bc = c - b
	local bp = point - b
	local abapDot = Vector2.Dot(ab, ap)
	local bcbpDot = Vector2.Dot(bc, bp)

	return abapDot >= 0 and abapDot <= Vector2.Dot(ab, ab) and bcbpDot >= 0 and bcbpDot <= Vector2.Dot(bc, bc)
end

function GameUtil.noMoreThanOneDecimalPlace(value)
	return math.fmod(value, 1) > 0 and string.format("%.1f", value) or string.format("%d", value)
end

function GameUtil.isMobilePlayerAndNotEmulator()
	return BootNativeUtil.isMobilePlayer() and not SDKMgr.instance:isEmulator()
end

function GameUtil.openDeepLink(url, deepLinkUrl)
	if string.nilorempty(deepLinkUrl) or string.nilorempty(url) then
		return
	end

	if SLFramework.FrameworkSettings.IsEditor or BootNativeUtil.isWindows() then
		UnityEngine.Application.OpenURL(url)

		return true
	end

	local jsonObj = {
		deepLink = deepLinkUrl,
		url = url
	}
	local jsonStr = cjson.encode(jsonObj)

	logNormal("openDeepLink:" .. tostring(jsonStr))
	ZProj.SDKMgr.Instance:CallVoidFuncWithParams("openDeepLink", jsonStr)

	return true
end

function GameUtil.openURL(url)
	if string.nilorempty(url) then
		return
	end

	if not BootNativeUtil.isIOS() then
		UnityEngine.Application.OpenURL(url)

		return true
	end

	local jsonObj = {
		deepLink = "",
		url = url
	}
	local jsonStr = cjson.encode(jsonObj)

	logNormal("openDeepLink:" .. tostring(jsonStr))
	ZProj.SDKMgr.Instance:CallVoidFuncWithParams("openDeepLink", jsonStr)

	return true
end

function GameUtil.getMotionDuration(animator, name)
	if animator then
		local clips = animator.runtimeAnimatorController.animationClips

		for i = 0, clips.Length - 1 do
			local clip = clips[i]

			if clip.name == name then
				return clip.length
			end
		end
	end

	return 0
end

function GameUtil.onDestroyViewMemberList(Self, memberName)
	if Self[memberName] then
		local list = Self[memberName]

		for _, item in ipairs(list) do
			item:onDestroyView()
		end

		Self[memberName] = nil
	end
end

function GameUtil.onDestroyViewMember(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		item:onDestroyView()

		Self[memberName] = nil
	end
end

local csTweenHelper = ZProj.TweenHelper

function GameUtil.onDestroyViewMember_TweenId(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		csTweenHelper.KillById(item)

		Self[memberName] = nil
	end
end

function GameUtil.onDestroyViewMemberList_SImage(Self, memberName)
	if Self[memberName] then
		local list = Self[memberName]

		for _, item in ipairs(list) do
			item:UnLoadImage()
		end

		Self[memberName] = nil
	end
end

function GameUtil.onDestroyViewMember_SImage(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		item:UnLoadImage()

		Self[memberName] = nil
	end
end

function GameUtil.onDestroyViewMember_ClickListener(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		item:RemoveClickListener()

		Self[memberName] = nil
	end
end

function GameUtil.onDestroyViewMember_ClickDownListener(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		item:RemoveClickDownListener()

		Self[memberName] = nil
	end
end

function GameUtil.setActive01(transform, isActive)
	if isActive then
		transformhelper.setLocalScale(transform, 1, 1, 1)
	else
		transformhelper.setLocalScale(transform, 0, 0, 0)
	end
end

function GameUtil.clamp(value, min, max)
	return math.min(max, math.max(value, min))
end

function GameUtil.saturate(value)
	return GameUtil.clamp(value, 0, 1)
end

function GameUtil.remap(value, fromMin, fromMax, toMin, toMax)
	value = GameUtil.clamp(value, fromMin, fromMax)

	return toMin + (value - fromMin) * (toMax - toMin) / (fromMax - fromMin)
end

function GameUtil.remap01(value, fromMin, fromMax)
	return GameUtil.remap(value, fromMin, fromMax, 0, 1)
end

function GameUtil.setFirstStrSize(str, size)
	if string.nilorempty(str) then
		return
	end

	local first = GameUtil.utf8sub(str, 1, 1)
	local strLen = GameUtil.utf8len(str)

	return string.format("<size=%s>%s</size>%s", size, first, (strLen >= 2 or nil) and GameUtil.utf8sub(str, 2, strLen - 1))
end

function GameUtil.playerPrefsGetNumberByUserId(playerPrefsKey, defaultValue)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return defaultValue
	end

	local key = playerPrefsKey .. "#" .. tostring(userId)

	return PlayerPrefsHelper.getNumber(key, defaultValue)
end

function GameUtil.playerPrefsSetNumberByUserId(playerPrefsKey, value)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return
	end

	local key = playerPrefsKey .. "#" .. tostring(userId)

	PlayerPrefsHelper.setNumber(key, value)
end

function GameUtil.playerPrefsGetStringByUserId(playerPrefsKey, defaultValue)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return defaultValue
	end

	local key = playerPrefsKey .. "#" .. tostring(userId)

	return PlayerPrefsHelper.getString(key, defaultValue)
end

function GameUtil.playerPrefsSetStringByUserId(playerPrefsKey, value)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return
	end

	local key = playerPrefsKey .. "#" .. tostring(userId)

	PlayerPrefsHelper.setString(key, value)
end

function GameUtil.deleteKey(playerPrefsKey)
	local userId = PlayerModel.instance:getMyUserId()

	if not userId or userId == 0 then
		return
	end

	local key = playerPrefsKey .. "#" .. tostring(userId)

	PlayerPrefsHelper.deleteKey(key)
end

local _uniqueMt = {
	__call = function(t)
		t.count = t.count + 1

		return t.count
	end
}

function GameUtil.getUniqueTb(beginIndex)
	local t = {}

	t.count = beginIndex or 1

	setmetatable(t, _uniqueMt)

	return t
end

local tb = GameUtil.getUniqueTb()

function GameUtil.getEventId()
	return tb()
end

function GameUtil.setDefaultValue(t, defaultValue)
	setmetatable(t, {
		__index = function()
			return defaultValue
		end
	})
end

function GameUtil.getTbValue(t, ...)
	local len = select("#", ...)

	if len == 0 then
		return t
	end

	if type(t) ~= "table" then
		return nil
	end

	return GameUtil.getTbValue(t[...], select(2, ...))
end

function GameUtil.setTbValue(t, k, ...)
	if type(t) ~= "table" or k == nil then
		return
	end

	local len = select("#", ...)

	if len <= 1 then
		if type(t) == "table" then
			t[k] = ...
		end

		return
	end

	local tb = t[k]

	if tb == nil then
		t[k] = {}
		tb = t[k]
	end

	if type(tb) ~= "table" then
		return
	end

	return GameUtil.setTbValue(tb, ...)
end

function GameUtil.rpcInfoToMo(info, cls, oldMo)
	local mo = oldMo or cls.New()

	mo:init(info)

	return mo
end

function GameUtil.rpcInfosToList(infos, cls, key, oldMap)
	local list = {}

	for i, v in ipairs(infos) do
		local oldMo
		local mo = GameUtil.rpcInfoToMo(v, cls, (key and oldMap or nil) and oldMap[key])

		table.insert(list, mo)
	end

	return list
end

function GameUtil.rpcInfosToMap(infos, cls, key, oldMap)
	local map = {}

	key = key or "id"

	for i, v in ipairs(infos) do
		local oldMo = oldMap and oldMap[v[key]]
		local mo = GameUtil.rpcInfoToMo(v, cls, oldMo)

		map[mo[key]] = mo
	end

	return map
end

function GameUtil.rpcInfosToListAndMap(infos, cls, key, oldMap)
	local map = {}

	key = key or "id"

	local list = {}

	for i, v in ipairs(infos) do
		local oldMo = oldMap and oldMap[v[key]]
		local mo = GameUtil.rpcInfoToMo(v, cls, oldMo)

		table.insert(list, mo)

		map[mo[key]] = mo
	end

	return list, map
end

function GameUtil.setActiveUIBlock(blockKey, isActiveBlock, isNeedCircleMv)
	if type(blockKey) ~= "string" then
		logError("blockKey can't be " .. type(blockKey))
	end

	isNeedCircleMv = isNeedCircleMv ~= false

	UIBlockMgrExtend.setNeedCircleMv(isNeedCircleMv)

	if isActiveBlock then
		UIBlockMgr.instance:startBlock(blockKey)
	else
		UIBlockMgr.instance:endBlock(blockKey)
	end
end

function GameUtil.loadSImage(simage, resUrl, loadedCb, cbObj)
	if string.nilorempty(resUrl) then
		simage:UnLoadImage()
	else
		simage:LoadImage(resUrl, loadedCb, cbObj)
	end
end

function GameUtil.logTab(tab, level)
	if not tab or type(tab) ~= "table" then
		return tostring(tab)
	end

	level = level or 0

	if level > 100 then
		logError("stack overflow ...")

		return tostring(tab)
	end

	local logTab = {}
	local initPre = string.rep("\t", level)

	table.insert(logTab, string.format(" {"))

	local pre = string.rep("\t", level + 1)

	for key, value in pairs(tab) do
		if type(value) == "table" then
			table.insert(logTab, string.format("%s %s = %s,", pre, key, GameUtil.logTab(value, level + 1)))
		else
			table.insert(logTab, string.format("%s %s = %s,", pre, key, value))
		end
	end

	table.insert(logTab, string.format("%s }", initPre))

	return table.concat(logTab, "\n")
end

function GameUtil.getViewSize()
	local hudGo = ViewMgr.instance:getUILayer("HUD")
	local tr = hudGo.transform

	return recthelper.getWidth(tr), recthelper.getHeight(tr)
end

function GameUtil.checkClickPositionInRight(clickPosition)
	local hudGo = ViewMgr.instance:getUILayer("HUD")
	local rectTr = hudGo:GetComponent(gohelper.Type_RectTransform)
	local anchorX, _ = recthelper.screenPosToAnchorPos2(clickPosition, rectTr)

	return anchorX >= 0
end

function GameUtil.needLogInFightSceneUseStringFunc()
	return false and GameSceneMgr.instance:isFightScene()
end

function GameUtil.needLogInOtherSceneUseFightStrUtilFunc()
	return false
end

GameUtil.enumId = 0

function GameUtil.getEnumId()
	GameUtil.enumId = GameUtil.enumId + 1

	return GameUtil.enumId
end

GameUtil.instanceId = 0

function GameUtil.getInstanceId()
	GameUtil.instanceId = GameUtil.instanceId + 1

	return GameUtil.instanceId
end

GameUtil.msgId = 0

function GameUtil.getMsgId()
	GameUtil.msgId = GameUtil.msgId + 1

	return GameUtil.msgId
end

function GameUtil.endsWith(str, ending)
	if string.nilorempty(str) or string.nilorempty(ending) then
		return false
	end

	return string.sub(str, -string.len(ending)) == ending
end

function GameUtil.isBaseOf(Base, T)
	if type(Base) ~= type(T) then
		return false
	end

	if type(Base) ~= "table" or type(T) ~= "table" then
		return false
	end

	local p = T

	while p ~= nil do
		if p == Base then
			return true
		end

		p = p.super
	end

	return false
end

function GameUtil.getRandomPosInCircle(centerPosX, centerPosY, radius)
	local r2 = radius * radius
	local rate = math.random(1, 1000) / 1000
	local r = math.sqrt(LuaTween.linear(rate, 0, r2, 1))

	rate = math.random(1, 1000) / 1000

	local angle = LuaTween.linear(rate, 0, 2 * math.pi, 1)
	local x = r * math.cos(angle)
	local y = r * math.sin(angle)

	return x + centerPosX, y + centerPosY
end

function GameUtil.doClearMember(Self, memberName)
	if Self[memberName] then
		local item = Self[memberName]

		item:doClear()

		Self[memberName] = nil
	end
end

local descriptor = require("protobuf.descriptor")
local FieldDescriptor = descriptor.FieldDescriptor

function GameUtil.copyPbData(serverData, decopy)
	if not serverData then
		return
	end

	local fields = serverData._fields

	if next(fields) then
		local fieldTbl = {}

		for keyTbl, value in pairs(fields) do
			local keyName = keyTbl.name

			if keyTbl.label == FieldDescriptor.LABEL_REPEATED then
				if #value ~= 0 then
					local arrayTbl = {}

					for _, arrayValue in ipairs(value) do
						arrayTbl[#arrayTbl + 1] = keyTbl.cpp_type == FieldDescriptor.CPPTYPE_MESSAGE and decopy and GameUtil.copyPbData(arrayValue, decopy) or (keyTbl.cpp_type == FieldDescriptor.CPPTYPE_INT64 or keyTbl.cpp_type == FieldDescriptor.CPPTYPE_UINT64) and tonumber(arrayValue) or arrayValue
					end

					fieldTbl[keyName] = arrayTbl
				end
			else
				fieldTbl[keyName] = keyTbl.cpp_type == FieldDescriptor.CPPTYPE_MESSAGE and decopy and GameUtil.copyPbData(value, true) or (keyTbl.cpp_type == FieldDescriptor.CPPTYPE_INT64 or keyTbl.cpp_type == FieldDescriptor.CPPTYPE_UINT64) and tonumber(value) or value
			end
		end

		return fieldTbl
	end
end

function GameUtil.convertToPercentStr(rate1000)
	rate1000 = rate1000 or 0

	return tostring(math.floor(rate1000 / 10)) .. "%"
end

function GameUtil.calcByDeltaRate1000(num, dtRate1000)
	num = num or 0

	local rate1000 = 1000 + (dtRate1000 or 0)

	return num * rate1000 / 1000
end

function GameUtil.calcByDeltaRate1000AsInt(num, dtRate1000)
	return math.floor(GameUtil.calcByDeltaRate1000(num, dtRate1000))
end

function GameUtil.getTextRenderSize(text)
	if not text then
		return 0, 0
	end

	text:ForceMeshUpdate(true, true)

	local renderValue = text:GetRenderedValues()

	return renderValue.x, renderValue.y
end

function GameUtil.copyArray(array)
	local l = {}

	for i, v in ipairs(array) do
		table.insert(l, v)
	end

	return l
end

function GameUtil.approximately(num1, num2, eps)
	eps = eps or 1e-06

	return eps > math.abs(num1 - num2)
end

function GameUtil.isApproxZero(num, eps)
	return GameUtil.approximately(num, 0, eps)
end

return GameUtil
