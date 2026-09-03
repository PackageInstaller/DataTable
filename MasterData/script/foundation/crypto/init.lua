-- chunkname: @/tmp/or_script/lua_compile/foundation/crypto/init.lua

local __FILE__ = select(1, ...) or ""
local __PACKAGE__ = string.gsub(__FILE__, "[^.]+$", "")

local function export(url)
	return require(__PACKAGE__ .. url)
end

if not _G.crypto then
	local crypto = {}

	if crypto.crc32 == nil then
		export("crc32")

		crypto.crc32 = crc32.crc32
	end

	if crypto.md5 == nil then
		export("md5")

		crypto.md5 = md5.md5
	end

	if crypto.base64_encode == nil or crypto.base64_decode == nil then
		local base64 = export("base64")

		crypto.base64_encode = base64.to_base64
		crypto.base64_decode = base64.from_base64
	end

	return crypto
end
