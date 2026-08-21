-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/ExpireTimeFormatterImpl.lua

module("logic.common.textformatter.impl.ExpireTimeFormatterImpl", package.seeall)

local ExpireTimeFormatterImpl = class("ExpireTimeFormatterImpl", ITextDataFormatter)

function ExpireTimeFormatterImpl:format(timeSeconds)
	if timeSeconds >= TextFormatterConst.DAY then
		timeSeconds = math.ceil(timeSeconds / TextFormatterConst.DAY)

		return string.format(TextFormatterConst.DAY_FORMAT_PATTERN, timeSeconds)
	end

	if timeSeconds >= TextFormatterConst.HOUR then
		timeSeconds = math.ceil(timeSeconds / TextFormatterConst.HOUR)

		return string.format(TextFormatterConst.HOUR_FORMAT_PATTERN, timeSeconds)
	end

	timeSeconds = math.ceil(timeSeconds / TextFormatterConst.MINUTE)

	return string.format(TextFormatterConst.MINUTE_FORMAT_PATTERN, timeSeconds)
end

return ExpireTimeFormatterImpl
