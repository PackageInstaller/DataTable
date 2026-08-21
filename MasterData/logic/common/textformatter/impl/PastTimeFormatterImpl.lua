-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/PastTimeFormatterImpl.lua

module("logic.common.textformatter.impl.PastTimeFormatterImpl", package.seeall)

local PastTimeFormatterImpl = class("PastTimeFormatterImpl", ITextDataFormatter)

function PastTimeFormatterImpl:format(timeSeconds)
	if timeSeconds >= TextFormatterConst.DAY then
		timeSeconds = math.floor(timeSeconds / TextFormatterConst.DAY)

		return string.format(TextFormatterConst.DAY_FORMAT_PATTERN, timeSeconds)
	end

	if timeSeconds >= TextFormatterConst.HOUR then
		timeSeconds = math.floor(timeSeconds / TextFormatterConst.HOUR)

		return string.format(TextFormatterConst.HOUR_FORMAT_PATTERN, timeSeconds)
	end

	timeSeconds = math.floor(timeSeconds / TextFormatterConst.MINUTE)

	if timeSeconds <= 0 then
		return TextFormatterConst.EMPTY
	end

	return string.format(lang(TextFormatterConst.MINUTE_FORMAT_PATTERN), timeSeconds)
end

return PastTimeFormatterImpl
