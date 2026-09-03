-- chunkname: @/tmp/or_script/lua_compile/foundation/luaext/bitop.lua

local bit = _G.bit

if bit ~= nil then
	return bit
end

local pow2s = {
	1,
	2,
	4,
	8,
	16,
	32,
	64,
	128,
	256,
	512,
	1024,
	2048,
	4096,
	8192,
	16384,
	32768,
	65536,
	131072,
	262144,
	524288,
	1048576,
	2097152,
	4194304,
	8388608,
	16777216,
	33554432,
	67108864,
	134217728,
	268435456,
	536870912,
	1073741824,
	2147483648
}
local bit = {}

function bit.bnot(a)
	a = a % 4294967296

	return 4294967295 - a
end

function bit.band(a, b)
	local calc = 0

	b = b % 4294967296
	a = a % 4294967296

	for i = 31, 0, -1 do
		local val = pow2s[i + 1]
		local aa = false
		local bb = false

		if a == 0 or b == 0 then
			break
		end

		if val <= a then
			aa = true
			a = a - val
		end

		if val <= b then
			bb = true
			b = b - val
		end

		if aa and bb then
			calc = calc + val
		end
	end

	return calc
end

function bit.bor(a, b)
	local calc = 0

	b = b % 4294967296
	a = a % 4294967296

	for i = 31, 0, -1 do
		local val = pow2s[i + 1]
		local aa = false
		local bb = false

		if a == 0 or b == 0 then
			calc = calc + a + b

			break
		end

		if val <= a then
			aa = true
			a = a - val
		end

		if val <= b then
			bb = true
			b = b - val
		end

		if aa or bb then
			calc = calc + val
		end
	end

	return calc
end

function bit.bxor(a, b)
	local calc = 0

	b = b % 4294967296
	a = a % 4294967296

	for i = 31, 0, -1 do
		local val = pow2s[i + 1]
		local aa = false
		local bb = false

		if a == 0 or b == 0 then
			calc = calc + a + b

			break
		end

		if val <= a then
			aa = true
			a = a - val
		end

		if val <= b then
			bb = true
			b = b - val
		end

		if aa ~= bb then
			calc = calc + val
		end
	end

	return calc
end

function bit.lshift(a, bits)
	local res = a * pow2s[bits + 1]

	return res % 4294967296
end

function bit.rshift(a, bits)
	a = a % 4294967296

	local mod = pow2s[bits + 1]
	local r = a % mod

	return (a - r) / mod
end

function bit.arshift(a, bits)
	a = a % 4294967296

	if a >= 2147483648 then
		a = a - 4294967296
	end

	local mod = pow2s[bits + 1]
	local r = a % mod

	return (a - r) / mod % 4294967296
end

_G.bit = bit

return bit
