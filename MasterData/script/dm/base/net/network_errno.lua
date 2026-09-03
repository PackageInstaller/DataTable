-- chunkname: @/tmp/or_script/lua_compile/dm/base/net/network_errno.lua

if neterrno == nil then
	neterrno = (device.platform == "ios" or device.platform == "mac" or device.platform == "windows") and {
		ESHUTDOWN = 58,
		ENETRESET = 52,
		ETOOMANYREFS = 59,
		ENOBUFS = 55,
		ENOTCONN = 57,
		ETIMEDOUT = 60,
		ECONNRESET = 54,
		ECONNREFUSED = 61,
		EISCONN = 56,
		ENETDOWN = 50,
		ECONNABORTED = 53,
		ENETUNREACH = 51
	} or device.platform == "android" and {
		ESHUTDOWN = 108,
		ENETRESET = 102,
		ETOOMANYREFS = 109,
		ENOBUFS = 105,
		ENOTCONN = 107,
		ETIMEDOUT = 110,
		ECONNRESET = 104,
		ECONNREFUSED = 111,
		EISCONN = 106,
		ENETDOWN = 100,
		ECONNABORTED = 103,
		ENETUNREACH = 101
	} or {}
end
