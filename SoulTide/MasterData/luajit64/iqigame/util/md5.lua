-- chunkname: @IQIGame\\Util\\md5.lua

local md5 = {
	_VERSION = "md5.lua 1.1.0",
	_URL = "https://github.com/kikito/md5.lua",
	_DESCRIPTION = "MD5 computation in Lua (5.1-3, LuaJIT)",
	_LICENSE = "    MIT LICENSE\n    Copyright (c) 2013 Enrique García Cota + Adam Baldwin + hanzao + Equi 4 Software\n    Permission is hereby granted, free of charge, to any person obtaining a\n    copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\n    without limitation the rights to use, copy, modify, merge, publish,\n    distribute, sublicense, and/or sell copies of the Software, and to\n    permit persons to whom the Software is furnished to do so, subject to\n    the following conditions:\n    The above copyright notice and this permission notice shall be included\n    in all copies or substantial portions of the Software.\n    THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS\n    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY\n    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,\n    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE\n    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n  "
}
local char, byte, format, rep, sub = string.char, string.byte, string.format, string.rep, string.sub
local bit_or, bit_and, bit_not, bit_xor, bit_rshift, bit_lshift
local ok, bit = pcall(require, "bit")
local ok_ffi, ffi = pcall(require, "ffi")

if ok then
	bit_or, bit_and, bit_not, bit_xor, bit_rshift, bit_lshift = bit.bor, bit.band, bit.bnot, bit.bxor, bit.rshift, bit.lshift
else
	ok, bit = pcall(require, "bit32")

	if ok then
		bit_not = bit.bnot

		local function tobit(n)
			return n <= 2147483647 and n or -(bit_not(n) + 1)
		end

		local function normalize(f)
			return function(a, b)
				return tobit(f(tobit(a), tobit(b)))
			end
		end

		bit_or, bit_and, bit_xor = normalize(bit.bor), normalize(bit.band), normalize(bit.bxor)
		bit_rshift, bit_lshift = normalize(bit.rshift), normalize(bit.lshift)
	else
		local function tbl2number(tbl)
			local result = 0
			local power = 1

			for i = 1, #tbl do
				result = result + tbl[i] * power
				power = power * 2
			end

			return result
		end

		local function expand(t1, t2)
			local big, small = t1, t2

			if #big < #small then
				big, small = small, big
			end

			for i = #small + 1, #big do
				small[i] = 0
			end
		end

		local to_bits

		function bit_not(n)
			local tbl = to_bits(n)
			local size = math.max(#tbl, 32)

			for i = 1, size do
				if tbl[i] == 1 then
					tbl[i] = 0
				else
					tbl[i] = 1
				end
			end

			return tbl2number(tbl)
		end

		function to_bits(n)
			if n < 0 then
				return to_bits(bit_not(math.abs(n)) + 1)
			end

			local tbl = {}
			local cnt = 1
			local last

			while n > 0 do
				last = n % 2
				tbl[cnt] = last
				n = (n - last) / 2
				cnt = cnt + 1
			end

			return tbl
		end

		function bit_or(m, n)
			local tbl_m = to_bits(m)
			local tbl_n = to_bits(n)

			expand(tbl_m, tbl_n)

			local tbl = {}

			for i = 1, #tbl_m do
				if tbl_m[i] == 0 and tbl_n[i] == 0 then
					tbl[i] = 0
				else
					tbl[i] = 1
				end
			end

			return tbl2number(tbl)
		end

		function bit_and(m, n)
			local tbl_m = to_bits(m)
			local tbl_n = to_bits(n)

			expand(tbl_m, tbl_n)

			local tbl = {}

			for i = 1, #tbl_m do
				if tbl_m[i] == 0 or tbl_n[i] == 0 then
					tbl[i] = 0
				else
					tbl[i] = 1
				end
			end

			return tbl2number(tbl)
		end

		function bit_xor(m, n)
			local tbl_m = to_bits(m)
			local tbl_n = to_bits(n)

			expand(tbl_m, tbl_n)

			local tbl = {}

			for i = 1, #tbl_m do
				if tbl_m[i] ~= tbl_n[i] then
					tbl[i] = 1
				else
					tbl[i] = 0
				end
			end

			return tbl2number(tbl)
		end

		function bit_rshift(n, bits)
			local high_bit = 0

			if n < 0 then
				n = bit_not(math.abs(n)) + 1
				high_bit = 2147483648
			end

			local floor = math.floor

			for i = 1, bits do
				n = n / 2
				n = bit_or(floor(n), high_bit)
			end

			return floor(n)
		end

		function bit_lshift(n, bits)
			if n < 0 then
				n = bit_not(math.abs(n)) + 1
			end

			for i = 1, bits do
				n = n * 2
			end

			return bit_and(n, 4294967295)
		end
	end
end

local lei2str

if ok_ffi then
	local ct_IntType = ffi.typeof("int[1]")

	function lei2str(i)
		return ffi.string(ct_IntType(i), 4)
	end
else
	function lei2str(i)
		local function f(s)
			return char(bit_and(bit_rshift(i, s), 255))
		end

		return f(0) .. f(8) .. f(16) .. f(24)
	end
end

local function str2bei(s)
	local v = 0

	for i = 1, #s do
		v = v * 256 + byte(s, i)
	end

	return v
end

local str2lei

if ok_ffi then
	local ct_constcharptr = ffi.typeof("const char*")
	local ct_constintptr = ffi.typeof("const int*")

	function str2lei(s)
		local int = ct_constcharptr(s)

		return ffi.cast(ct_constintptr, int)[0]
	end
else
	function str2lei(s)
		local v = 0

		for i = #s, 1, -1 do
			v = v * 256 + byte(s, i)
		end

		return v
	end
end

local function cut_le_str(s)
	return {
		str2lei(sub(s, 1, 4)),
		str2lei(sub(s, 5, 8)),
		str2lei(sub(s, 9, 12)),
		str2lei(sub(s, 13, 16)),
		str2lei(sub(s, 17, 20)),
		str2lei(sub(s, 21, 24)),
		str2lei(sub(s, 25, 28)),
		str2lei(sub(s, 29, 32)),
		str2lei(sub(s, 33, 36)),
		str2lei(sub(s, 37, 40)),
		str2lei(sub(s, 41, 44)),
		str2lei(sub(s, 45, 48)),
		str2lei(sub(s, 49, 52)),
		str2lei(sub(s, 53, 56)),
		str2lei(sub(s, 57, 60)),
		str2lei(sub(s, 61, 64))
	}
end

local CONSTS = {
	3614090360,
	3905402710,
	606105819,
	3250441966,
	4118548399,
	1200080426,
	2821735955,
	4249261313,
	1770035416,
	2336552879,
	4294925233,
	2304563134,
	1804603682,
	4254626195,
	2792965006,
	1236535329,
	4129170786,
	3225465664,
	643717713,
	3921069994,
	3593408605,
	38016083,
	3634488961,
	3889429448,
	568446438,
	3275163606,
	4107603335,
	1163531501,
	2850285829,
	4243563512,
	1735328473,
	2368359562,
	4294588738,
	2272392833,
	1839030562,
	4259657740,
	2763975236,
	1272893353,
	4139469664,
	3200236656,
	681279174,
	3936430074,
	3572445317,
	76029189,
	3654602809,
	3873151461,
	530742520,
	3299628645,
	4096336452,
	1126891415,
	2878612391,
	4237533241,
	1700485571,
	2399980690,
	4293915773,
	2240044497,
	1873313359,
	4264355552,
	2734768916,
	1309151649,
	4149444226,
	3174756917,
	718787259,
	3951481745,
	1732584193,
	4023233417,
	2562383102,
	271733878
}

local function f(x, y, z)
	return bit_or(bit_and(x, y), bit_and(-x - 1, z))
end

local function g(x, y, z)
	return bit_or(bit_and(x, z), bit_and(y, -z - 1))
end

local function h(x, y, z)
	return bit_xor(x, bit_xor(y, z))
end

local function i(x, y, z)
	return bit_xor(y, bit_or(x, -z - 1))
end

local function z(ff, a, b, c, d, x, s, ac)
	a = bit_and(a + ff(b, c, d) + x + ac, 4294967295)

	return bit_or(bit_lshift(bit_and(a, bit_rshift(4294967295, s)), s), bit_rshift(a, 32 - s)) + b
end

local function transform(A, B, C, D, X)
	local a, b, c, d = A, B, C, D
	local t = CONSTS

	a = z(f, a, b, c, d, X[0], 7, t[1])
	d = z(f, d, a, b, c, X[1], 12, t[2])
	c = z(f, c, d, a, b, X[2], 17, t[3])
	b = z(f, b, c, d, a, X[3], 22, t[4])
	a = z(f, a, b, c, d, X[4], 7, t[5])
	d = z(f, d, a, b, c, X[5], 12, t[6])
	c = z(f, c, d, a, b, X[6], 17, t[7])
	b = z(f, b, c, d, a, X[7], 22, t[8])
	a = z(f, a, b, c, d, X[8], 7, t[9])
	d = z(f, d, a, b, c, X[9], 12, t[10])
	c = z(f, c, d, a, b, X[10], 17, t[11])
	b = z(f, b, c, d, a, X[11], 22, t[12])
	a = z(f, a, b, c, d, X[12], 7, t[13])
	d = z(f, d, a, b, c, X[13], 12, t[14])
	c = z(f, c, d, a, b, X[14], 17, t[15])
	b = z(f, b, c, d, a, X[15], 22, t[16])
	a = z(g, a, b, c, d, X[1], 5, t[17])
	d = z(g, d, a, b, c, X[6], 9, t[18])
	c = z(g, c, d, a, b, X[11], 14, t[19])
	b = z(g, b, c, d, a, X[0], 20, t[20])
	a = z(g, a, b, c, d, X[5], 5, t[21])
	d = z(g, d, a, b, c, X[10], 9, t[22])
	c = z(g, c, d, a, b, X[15], 14, t[23])
	b = z(g, b, c, d, a, X[4], 20, t[24])
	a = z(g, a, b, c, d, X[9], 5, t[25])
	d = z(g, d, a, b, c, X[14], 9, t[26])
	c = z(g, c, d, a, b, X[3], 14, t[27])
	b = z(g, b, c, d, a, X[8], 20, t[28])
	a = z(g, a, b, c, d, X[13], 5, t[29])
	d = z(g, d, a, b, c, X[2], 9, t[30])
	c = z(g, c, d, a, b, X[7], 14, t[31])
	b = z(g, b, c, d, a, X[12], 20, t[32])
	a = z(h, a, b, c, d, X[5], 4, t[33])
	d = z(h, d, a, b, c, X[8], 11, t[34])
	c = z(h, c, d, a, b, X[11], 16, t[35])
	b = z(h, b, c, d, a, X[14], 23, t[36])
	a = z(h, a, b, c, d, X[1], 4, t[37])
	d = z(h, d, a, b, c, X[4], 11, t[38])
	c = z(h, c, d, a, b, X[7], 16, t[39])
	b = z(h, b, c, d, a, X[10], 23, t[40])
	a = z(h, a, b, c, d, X[13], 4, t[41])
	d = z(h, d, a, b, c, X[0], 11, t[42])
	c = z(h, c, d, a, b, X[3], 16, t[43])
	b = z(h, b, c, d, a, X[6], 23, t[44])
	a = z(h, a, b, c, d, X[9], 4, t[45])
	d = z(h, d, a, b, c, X[12], 11, t[46])
	c = z(h, c, d, a, b, X[15], 16, t[47])
	b = z(h, b, c, d, a, X[2], 23, t[48])
	a = z(i, a, b, c, d, X[0], 6, t[49])
	d = z(i, d, a, b, c, X[7], 10, t[50])
	c = z(i, c, d, a, b, X[14], 15, t[51])
	b = z(i, b, c, d, a, X[5], 21, t[52])
	a = z(i, a, b, c, d, X[12], 6, t[53])
	d = z(i, d, a, b, c, X[3], 10, t[54])
	c = z(i, c, d, a, b, X[10], 15, t[55])
	b = z(i, b, c, d, a, X[1], 21, t[56])
	a = z(i, a, b, c, d, X[8], 6, t[57])
	d = z(i, d, a, b, c, X[15], 10, t[58])
	c = z(i, c, d, a, b, X[6], 15, t[59])
	b = z(i, b, c, d, a, X[13], 21, t[60])
	a = z(i, a, b, c, d, X[4], 6, t[61])
	d = z(i, d, a, b, c, X[11], 10, t[62])
	c = z(i, c, d, a, b, X[2], 15, t[63])
	b = z(i, b, c, d, a, X[9], 21, t[64])

	return bit_and(A + a, 4294967295), bit_and(B + b, 4294967295), bit_and(C + c, 4294967295), bit_and(D + d, 4294967295)
end

local function md5_update(self, s)
	self.pos = self.pos + #s
	s = self.buf .. s

	for ii = 1, #s - 63, 64 do
		local X = cut_le_str(sub(s, ii, ii + 63))

		assert(#X == 16)

		X[0] = table.remove(X, 1)
		self.a, self.b, self.c, self.d = transform(self.a, self.b, self.c, self.d, X)
	end

	self.buf = sub(s, math.floor(#s / 64) * 64 + 1, #s)

	return self
end

local function md5_finish(self)
	local msgLen = self.pos
	local padLen = 56 - msgLen % 64

	if msgLen % 64 > 56 then
		padLen = padLen + 64
	end

	if padLen == 0 then
		padLen = 64
	end

	local s = char(128) .. rep(char(0), padLen - 1) .. lei2str(bit_and(8 * msgLen, 4294967295)) .. lei2str(math.floor(msgLen / 536870912))

	md5_update(self, s)
	assert(self.pos % 64 == 0)

	return lei2str(self.a) .. lei2str(self.b) .. lei2str(self.c) .. lei2str(self.d)
end

function md5.new()
	return {
		buf = "",
		pos = 0,
		a = CONSTS[65],
		b = CONSTS[66],
		c = CONSTS[67],
		d = CONSTS[68],
		update = md5_update,
		finish = md5_finish
	}
end

function md5.tohex(s)
	return format("%08x%08x%08x%08x", str2bei(sub(s, 1, 4)), str2bei(sub(s, 5, 8)), str2bei(sub(s, 9, 12)), str2bei(sub(s, 13, 16)))
end

function md5.sum(s)
	return md5.new():update(s):finish()
end

function md5.sumhexa(s)
	return md5.tohex(md5.sum(s))
end

return md5
