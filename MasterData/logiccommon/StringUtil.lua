-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/util/StringUtil.lua

module("logiccommon.common.util.StringUtil", package.seeall)

local StringUtil = {}
local json = require("cjson")
local utf8_look_for_table = {
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	1,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	2,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	3,
	4,
	4,
	4,
	4,
	4,
	4,
	4,
	4,
	5,
	5,
	5,
	5,
	6,
	6,
	1,
	1
}

StringUtil.EscapeChar = {
	["^"] = true,
	["]"] = true,
	["("] = true,
	["$"] = true,
	["?"] = true,
	["*"] = true,
	["%"] = true,
	["+"] = true,
	["["] = true,
	["."] = true,
	["-"] = true,
	[")"] = true
}

function StringUtil.GetUtf8CharLength(ch)
	return utf8_look_for_table[ch] or 0
end

function StringUtil.GetUtf8Length(str)
	local len, ptr = 0, 1
	local char_list = {}

	repeat
		local char = string.byte(str, ptr)
		local char_len = StringUtil.GetUtf8CharLength(char)
		local nextPtr = ptr + char_len

		table.insert(char_list, string.sub(str, ptr, nextPtr - 1))

		ptr = nextPtr
	until nextPtr > #str

	return #char_list, char_list
end

function StringUtil.RelpaceEscapeChar(input)
	input = string.gsub(input, ".", function(c)
		if StringUtil.EscapeChar[c] then
			return "%" .. c
		else
			return c
		end
	end)

	return input
end

function StringUtil.SubUtf8String(str, begin, _end)
	local len, char_list = StringUtil.GetUtf8Length(str)

	begin = begin == nil and 1 or begin
	_end = (_end == nil or len < _end) and len or _end

	return table.concat(char_list, "", begin, _end)
end

function StringUtil.utf8CharSize(char)
	if not char then
		return 0
	elseif char >= 252 then
		return 6
	elseif char >= 248 then
		return 5
	elseif char >= 240 then
		return 4
	elseif char >= 224 then
		return 3
	elseif char >= 192 then
		return 2
	else
		return 1
	end
end

function StringUtil.utf8split(str)
	local result = {}
	local index = 1
	local len = string.len(str)

	while index <= len do
		local char = string.byte(str, index)
		local size = StringUtil.utf8CharSize(char)

		if size > 0 then
			local value = string.sub(str, index, index + size - 1)

			table.insert(result, value)

			index = index + size
		else
			index = index + 1
		end
	end

	return result
end

local bitStr = {
	"%s",
	"%s万",
	"%s亿",
	"%s万亿",
	"%s兆",
	"%s万兆"
}

function StringUtil:toStringNumber(number)
	return
end

function StringUtil.numberToString(str, flag)
	local number = StringUtil.toNumberString(str)
	local k = 1
	local integerPart = ""
	local floatPart = ""

	while string.len(number) > 4 do
		floatPart = string.sub(number, string.len(number) - 3, string.len(number))
		number = string.sub(number, 1, string.len(number) - 4)
		integerPart = number
		k = k + 1
	end

	integerPart = number

	return string.format(bitStr[k], (checknumber(integerPart) >= 1000 or checknumber(floatPart) < 100) and tostring(integerPart) or checknumber(integerPart) >= 10 and string.format("%s.%s", integerPart, string.sub(floatPart, 1, 1)) or string.format("%s.%s", integerPart, string.sub(floatPart, 1, 2)))
end

function StringUtil.CompareTwoNumber(a, b, isSortFunc)
	a = StringUtil.toNumberString(a)
	b = StringUtil.toNumberString(b)

	if string.len(a) > string.len(b) then
		return true
	elseif string.len(a) < string.len(b) then
		return false
	else
		local bitA, bitB

		for i = 1, string.len(a) do
			bitA = checknumber(string.sub(a, i, i))
			bitB = checknumber(string.sub(b, i, i))

			if bitA ~= bitB then
				return bitB < bitA
			end
		end

		if isSortFunc then
			return false
		else
			return true
		end
	end
end

function StringUtil.toNumberString(str)
	str = tostring(str)

	if string.nilorempty(str) then
		return ""
	else
		local number = ""

		for i = 1, string.len(str) do
			local char = string.sub(str, i, i)

			if char >= "0" and char <= "9" then
				number = number .. char
			else
				return number
			end
		end

		return number
	end
end

function StringUtil.getLimitStr(value, limitedLen)
	local t = StringUtil.utf8split(value)
	local len = 0
	local i = 1
	local result = ""

	while len < limitedLen and i <= #t do
		local charLen = 2

		if string.len(t[i]) == 1 then
			charLen = StringUtil.getCharLen(t[i])
		end

		if limitedLen >= len + charLen then
			result = result .. t[i]
			i = i + 1
			len = len + charLen
		else
			break
		end
	end

	return result, len
end

function StringUtil.getCharLen(char)
	char = tostring(char)

	if char >= "A" and char <= "Z" then
		return 2
	elseif char == "m" then
		return 1
	elseif char >= "a" and char <= "z" then
		return 1
	else
		return 1
	end
end

function StringUtil.isPureDigital(str)
	if str then
		str = tostring(str)

		local t = StringUtil.utf8split(str)

		for _, v in ipairs(t) do
			if v < "0" or v > "9" then
				return false
			end
		end

		return true
	end

	return false
end

function StringUtil.parseJsonParams(content, params, needParseParam, splitName)
	if needParseParam then
		params = string.nilorempty(params) and {} or json.decode(params)
	end

	local userName = ""

	content = content or ""

	for k, v in pairs(params or {}) do
		if k == "materials" then
			local matName = ""

			if not string.nilorempty(v) then
				local mats = string.split(v, "#")

				if mats and #mats > 1 then
					for index, temMat in ipairs(mats) do
						matName = index > 1 and matName .. "、" .. MaterialMgr.getMaterialsNameByCfg(temMat) or MaterialMgr.getMaterialsNameByCfg(temMat)
					end
				else
					local mat = string.split(v, ":")

					matName = MaterialMgr.getMaterialsNameByCfg(v)
				end
			else
				printError(">>>>>>>>>> 邮件 materials 属性空")
			end

			content = StringUtil._changeTxt(content, k, matName)
		elseif k == "fm_role" then
			content = StringUtil._changeTxt(content, k, lang("tip_family_position_" .. v))
		elseif k == "un" and splitName then
			userName = v
			content = StringUtil._changeTxt(content, k, "")
		elseif k == "rare" then
			local rare = checknumber(v)

			content = StringUtil._changeTxt(content, k, ConstString.PetRareLang[rare])
		elseif k == "raceId" then
			local cfg = CharacterConfig.instance:getPetCo(checknumber(v))

			if cfg then
				if not cfg.name then
					local name = ""

					content = StringUtil._changeTxt(content, k, name)
				end
			end
		elseif k == "legendClgId" then
			local cfg = LegendConfig.instance:getLegendChallengeCfg(checknumber(v))

			if cfg then
				if not cfg.challengeName then
					local name = ""

					content = StringUtil._changeTxt(content, k, name)
				end
			end
		elseif k == "d" then
			local damage = StringUtil.numberToString(v)

			content = StringUtil._changeTxt(content, k, damage)
		elseif k == "c" then
			local count = StringUtil.numberToString(v)

			content = StringUtil._changeTxt(content, k, count)
		elseif k == "userName" then
			content = StringUtil._changeTxt(content, k, v)
		elseif k == "bossName" then
			content = StringUtil._changeTxt(content, k, v)
		elseif k == "tokenId" then
			local cfg = BirthdayWishesConfig.instance:getTokenCfgByTokenId(checknumber(v))
			local matType, matId, matNum = MaterialMgr.getMatParams(cfg.reward)
			local matName = MaterialMgr.getMaterialsName(matType, matId)

			content = StringUtil._changeTxt(content, k, string.format("%sx%s", matName, matNum))
		elseif k == "pgr" then
			local raceId = params.raceId
			local cfg = CharacterConfig.instance:getPetCo(checknumber(raceId))

			if cfg then
				if not cfg.name then
					local name = ""

					if raceId == 10380 then
						-- block empty
					elseif v > 0 then
						local pga = params.pga

						content = string.nilorempty(pga) and content .. string.format("\n（%s挑战中<color=#eb4642>NO.%s</color>通关认证）", name, v) or content .. string.format("\n（%s挑战中<color=#eb4642>%s NO.%s</color>通关认证）", name, pga, v)
					elseif v == 0 then
						content = content .. string.format("\n（%s挑战通关认证）", name)
					end
				end
			end
		elseif k == "flowerId" then
			local matStr = SendFlowerConfig.instance:getFlowerMatStrById(checknumber(v))
			local matType, id, matNum = MaterialMgr.getMatParams(matStr)
			local name = MaterialMgr.getMaterialsName(matType, id)

			content = StringUtil._changeTxt(content, k, name)
		elseif k == "spRpkId" then
			local cfg = SpringRedPackConfig.instance:getPrizeCfg(checknumber(v))

			if cfg then
				local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)
				local name = MaterialMgr.getMaterialsName(matType, id)
				local str = string.format("%s*%d", name, matNum)

				content = StringUtil._changeTxt(content, k, str)
			else
				content = StringUtil._changeTxt(content, k, v)
			end
		elseif k == "foodName" then
			local dishId = checknumber(string.sub(v, 1, 4)) - 1000
			local actId = checknumber(string.sub(v, 5))
			local name = GoddessDelicacyModel.instance:getShareFoodInfo(actId, dishId)

			content = StringUtil._changeTxt(content, k, name)
		elseif k == "foodFormula" then
			local dishId = checknumber(string.sub(v, 1, 4)) - 1000
			local actId = checknumber(string.sub(v, 5))
			local _, formula = GoddessDelicacyModel.instance:getShareFoodInfo(actId, dishId, true, true)

			content = StringUtil._changeTxt(content, k, formula)
		elseif k == "define" then
			local str = string.split(v, "_")
			local cfg = BirthdayCakeConfig.instance:getCakeStoreCfg(checknumber(str[1]), checknumber(str[2]))
			local name = MaterialMgr.getMaterialsNameByCfg(cfg.reward)
			local type, id, num = MaterialMgr.getMatParams(cfg.reward)

			content = StringUtil._changeTxt(content, k, string.format("%sX%s", name, num))
		elseif k == "redpackTaskId" then
			local taskName, redpackName = FamilyModel.instance:getRedpackAndTaskname(checknumber(v))

			content = string.gsub(content, "{taskName}", taskName)
			content = string.gsub(content, "{redpackName}", redpackName)
		elseif k == "titleId" then
			local cfg = TitleConfig.instance:getCfgById(checknumber(v))

			content = StringUtil._changeTxt(content, k, cfg.titleName)
		elseif k == "lv" then
			local lv = StringUtil.numberToString(v)

			content = StringUtil._changeTxt(content, k, lv)
		elseif k == "name" then
			content = StringUtil._changeTxt(content, k, v)
		elseif k == "gtactId" then
			content = StringUtil._changeTxt(content, k, lang("黄金十周年"))
		elseif k == "tp" then
			content = StringUtil._changeTxt(content, k, tostring(v))
		elseif k == "left_seconds" then
			local time = GameUtil.FormatTimeWords(checknumber(v))

			content = StringUtil._changeTxt(content, k, time)
		elseif k == "ts" then
			local time = GameUtil.formatTimeStamp("%m月%d日 %H:%M", checknumber(v) / 1000)

			content = StringUtil._changeTxt(content, k, time)
		elseif k == "ts_date" then
			local time = GameUtil.formatTimeStamp("%Y年%m月%d日", checknumber(v) / 1000)

			content = StringUtil._changeTxt(content, k, time)
		else
			content = StringUtil._changeTxt(content, k, lang(v))
		end
	end

	content = string.gsub(content, "{userName}", RoleModel.instance:getUserName())

	return content, userName
end

function StringUtil._changeTxt(content, key, value)
	return string.gsub(content, string.format("{%s}", key), tostring(value))
end

local splitChar = {
	["("] = true,
	["$"] = true,
	["|"] = true,
	["&"] = true,
	[")"] = true
}

function StringUtil.parseConditionStr(str, func)
	function func(str)
		return math.random() >= 0.5
	end

	if string.nilorempty(str) then
		return false
	end

	str = str .. "$"

	local lastPointer = 0
	local t = {}

	for i = 1, #str do
		local c = string.sub(str, i, i)

		if splitChar[c] == true then
			if i > lastPointer + 1 then
				table.insert(t, func(string.sub(str, lastPointer + 1, i - 1)))
			end

			StringUtil._calculateOnce(t)

			if c == ")" then
				local isMatched = false

				for j = #t, 1, -1 do
					if t[j] == "(" then
						isMatched = true

						table.remove(t, j)
						StringUtil._calculateOnce(t)

						break
					end
				end
			else
				table.insert(t, c)
			end
		end
	end

	StringUtil._calculateOnce(t)

	return #t == 1 and t[1] == true
end

function StringUtil._calculateOnce(t)
	if t and #t > 0 then
		local status = t[#t]
		local operator = t[#t - 1]

		if type(status) == "boolean" and (operator == "&" or operator == "|") then
			local preStatus = t[#t - 2]

			if type(status) == "boolean" then
				table.remove(t, #t)
				table.remove(t, #t)

				t[#t] = operator == "&" and status and preStatus or status or preStatus
			end
		end
	end
end

return StringUtil
