-- chunkname: @modules/common/utils/Bitwise.lua

module("modules.common.utils.Bitwise", package.seeall)

local bit = require("bit")
local _B = {
	["&"] = function(a, b)
		return bit.band(a, b)
	end,
	["|"] = function(a, b)
		return bit.bor(a, b)
	end,
	[">>"] = function(a, b)
		return bit.rshift(a, b)
	end,
	["<<"] = function(a, b)
		return bit.lshift(a, b)
	end,
	["^"] = function(a, b)
		return bit.bxor(a, b)
	end,
	["~"] = function(a)
		return bit.bnot(a)
	end
}
local Bitwise = _B

function Bitwise.hasAny(num, bits)
	return _B["&"](num, bits) ~= 0
end

function Bitwise.has(num, bits)
	return _B["&"](num, bits) == bits
end

function Bitwise.set(num, bits)
	return _B["|"](num, bits)
end

function Bitwise.unset(num, bits)
	return _B["&"](num, _B["~"](bits))
end

function Bitwise.lowbit(num)
	return _B["&"](num, -num)
end

function Bitwise.isPow2(num)
	if num == 0 then
		return true
	end

	return _B["&"](num, num - 1) == 0
end

function Bitwise.nextPow2(num)
	num = num - 1
	num = _B["|"](num, _B[">>"](num, 1))
	num = _B["|"](num, _B[">>"](num, 2))
	num = _B["|"](num, _B[">>"](num, 4))
	num = _B["|"](num, _B[">>"](num, 8))
	num = _B["|"](num, _B[">>"](num, 16))
	num = _B["|"](num, _B[">>"](num, 32))

	return num + 1
end

function Bitwise.count1(num)
	local cnt = 0

	while num ~= 0 do
		num = num - _B.lowbit(num)
		cnt = cnt + 1
	end

	return cnt
end

function Bitwise.unitTest()
	assert(_B["&"](2, 3) == 2)
	assert(_B["|"](1, 2) == 3)
	assert(_B[">>"](2, 1) == 1)
	assert(_B["<<"](2, 1) == 4)
	assert(_B["^"](1, 3) == 2)
	assert(_B["~"](1) == -2)
	assert(_B["~"](4) == -5)
	assert(Bitwise.hasAny(5, 1) == true)
	assert(Bitwise.hasAny(5, 2) == false)
	assert(Bitwise.hasAny(5, 3) == true)
	assert(Bitwise.has(5, 3) == false)
	assert(Bitwise.has(6, 3) == false)
	assert(Bitwise.has(6, 4) == true)
	assert(Bitwise.set(5, 1) == 5)
	assert(Bitwise.unset(5, 1) == 4)
	assert(Bitwise.unset(5, 3) == 4)
	assert(Bitwise.lowbit(5) == 1)
	assert(Bitwise.lowbit(4) == 4)
	assert(Bitwise.isPow2(0) == true)
	assert(Bitwise.isPow2(4) == true)
	assert(Bitwise.isPow2(64) == true)
	assert(Bitwise.isPow2(5) == false)
	assert(Bitwise.nextPow2(8) == 8)
	assert(Bitwise.nextPow2(16) == 16)
	assert(Bitwise.nextPow2(17) == 32)
	assert(Bitwise.nextPow2(1) == 1)
	assert(Bitwise.nextPow2(0) == 0)
	assert(Bitwise.nextPow2(320) == 512)
	assert(Bitwise.count1(5) == 2)
	assert(Bitwise.count1(15) == 4)
	assert(Bitwise.count1(128) == 1)
	assert(Bitwise.count1(127) == 7)
end

return Bitwise
