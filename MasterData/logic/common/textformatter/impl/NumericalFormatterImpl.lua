-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/textformatter/impl/NumericalFormatterImpl.lua

module("logic.common.textformatter.impl.NumericalFormatterImpl", package.seeall)

local NumericalFormatterImpl = class("NumericalFormatterImpl", ITextDataFormatter)

function NumericalFormatterImpl:ctor()
	self.CriticalValue = 999999
	self.TenThousandValue = 10000
end

function NumericalFormatterImpl:format(number, isInt)
	if isInt then
		number = checkint(number)
	end

	if number <= 999999 then
		return tostring(number)
	elseif number % 10000 < 1000 then
		number = string.format("%d万", math.floor(number / 10000))
	else
		number = string.format("%.1f万", (number - number % 1000) / 10000)
	end

	return number
end

return NumericalFormatterImpl
