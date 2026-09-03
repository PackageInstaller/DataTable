-- chunkname: @/tmp/or_script/lua_compile/dm/utils/StringChecker.lua

StringChecker = StringChecker or {}
StringCheckResult = {
	AllOfCharForbidden = "AllOfCharForbidden",
	ForbiddenWords = "ForbiddenWords",
	Success = "Success"
}

local allOfCharForbidden = {
	"\n",
	" ",
	"\r",
	"\t"
}

function StringChecker.isAllofCharForbidden(str)
	if str == "" then
		return false
	end

	for _, v in pairs(allOfCharForbidden) do
		str = string.gsub(str, v, "")
	end

	if str == "" then
		return true
	end

	return false
end

function StringChecker.meaninglessString(str)
	if str == "" then
		return true
	end

	return StringChecker.isAllofCharForbidden(str)
end

local preForbiddenWords = {
	"*",
	"**",
	"***",
	"****",
	"*****",
	"******",
	"*******",
	"********",
	"*********",
	"**********"
}

function StringChecker.hasForbiddenWords(str, maskType)
	local maskWordSystem = DmGame:getInstance()._injector:getInstance(MaskWordSystem)

	StringChecker.forbiiddenWords = maskWordSystem:getMaskWord(maskType)

	local result = false
	local finalString = str
	local replacrStr = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Forbidden_Rep", "content")

	if StringChecker.forbiiddenWords then
		for k, v in pairs(StringChecker.forbiiddenWords) do
			if v.Name ~= "*" and v.Name ~= "" then
				local len = utf8.len(v.Name)

				local function getReplaceWords()
					if v.Type and v.Type == "1" then
						return replacrStr
					end

					if len > 10 then
						return preForbiddenWords[10]
					else
						return preForbiddenWords[len]
					end
				end

				local start, ended = string.find(finalString, v.Name, 1, true)

				while start do
					local str1 = ""

					if start > 1 then
						str1 = string.sub(finalString, 1, start - 1)
					end

					finalString = str1 .. getReplaceWords() .. ((ended < string.len(finalString) or nil) and string.sub(finalString, ended + 1, string.len(finalString)))
					start, ended = string.find(finalString, v.Name, 1, true)
					result = true
				end
			end
		end
	end

	return result, finalString
end

function StringChecker.checkString(str, maskType)
	if StringChecker.isAllofCharForbidden(str) then
		return StringCheckResult.AllOfCharForbidden, ""
	end

	local state, ret = StringChecker.hasForbiddenWords(str, maskType)

	if state then
		return StringCheckResult.ForbiddenWords, ret
	end

	return StringCheckResult.Success, str
end

function StringChecker.initForbiiddenWords()
	return
end

StringChecker.initForbiiddenWords()
