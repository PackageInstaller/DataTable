-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Network\\protobuf.lua

local c = require("protobuf.c")
local setmetatable = setmetatable
local type = type
local table = table
local assert = assert
local pairs = pairs
local ipairs = ipairs
local string = string
local print = print
local io = io
local tinsert = table.insert
local rawget = rawget
local debug = debug
local logerror = logerror

module("protobuf")

local _pattern_cache = {}
local P = c._env_new()
local GC = c._gc(P)

function lasterror()
	return c._last_error(P)
end

local decode_type_cache = {}
local _R_meta = {}

function _R_meta:__index(key)
	local func = decode_type_cache[self._CType][key]

	if func == nil then
		logerror(self._CType, key, debug.traceback())

		return nil
	else
		local v = func(self, key)

		self[key] = v

		return v
	end
end

local _reader = {}

function _reader:int(key)
	return c._rmessage_integer(self._CObj, key, 0)
end

function _reader:real(key)
	return c._rmessage_real(self._CObj, key, 0)
end

function _reader:string(key)
	return c._rmessage_string(self._CObj, key, 0)
end

function _reader:bool(key)
	return c._rmessage_integer(self._CObj, key, 0) ~= 0
end

function _reader:message(key, message_type)
	local rmessage = c._rmessage_message(self._CObj, key, 0)

	if rmessage then
		local v = {
			_CObj = rmessage,
			_CType = message_type,
			_Parent = self
		}

		return setmetatable(v, _R_meta)
	end
end

function _reader:int32(key)
	return c._rmessage_int32(self._CObj, key, 0)
end

function _reader:int64(key)
	return c._rmessage_int64(self._CObj, key, 0)
end

function _reader:int52(key)
	return c._rmessage_int52(self._CObj, key, 0)
end

function _reader:uint52(key)
	return c._rmessage_uint52(self._CObj, key, 0)
end

function _reader:int_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_integer(cobj, key, i))
	end

	return ret
end

function _reader:real_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_real(cobj, key, i))
	end

	return ret
end

function _reader:string_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_string(cobj, key, i))
	end

	return ret
end

function _reader:bool_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_integer(cobj, key, i) ~= 0)
	end

	return ret
end

function _reader:message_repeated(key, message_type)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		local m = {
			_CObj = c._rmessage_message(cobj, key, i),
			_CType = message_type,
			_Parent = self
		}

		tinsert(ret, setmetatable(m, _R_meta))
	end

	return ret
end

function _reader:int32_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_int32(cobj, key, i))
	end

	return ret
end

function _reader:int64_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_int64(cobj, key, i))
	end

	return ret
end

function _reader:int52_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_int52(cobj, key, i))
	end

	return ret
end

function _reader:uint52_repeated(key)
	local cobj = self._CObj
	local n = c._rmessage_size(cobj, key)
	local ret = {}

	for i = 0, n - 1 do
		tinsert(ret, c._rmessage_uint52(cobj, key, i))
	end

	return ret
end

_reader[1] = function(msg)
	return _reader.int
end
_reader[2] = function(msg)
	return _reader.real
end
_reader[3] = function(msg)
	return _reader.bool
end
_reader[4] = function(msg)
	return _reader.string
end
_reader[5] = function(msg)
	return _reader.string
end
_reader[6] = function(msg)
	local message = _reader.message

	return function(self, key)
		return message(self, key, msg)
	end
end
_reader[7] = function(msg)
	return _reader.int64
end
_reader[8] = function(msg)
	return _reader.int32
end
_reader[9] = _reader[5]
_reader[10] = function(msg)
	return _reader.int52
end
_reader[11] = function(msg)
	return _reader.uint52
end
_reader[129] = function(msg)
	return _reader.int_repeated
end
_reader[130] = function(msg)
	return _reader.real_repeated
end
_reader[131] = function(msg)
	return _reader.bool_repeated
end
_reader[132] = function(msg)
	return _reader.string_repeated
end
_reader[133] = function(msg)
	return _reader.string_repeated
end
_reader[134] = function(msg)
	local message = _reader.message_repeated

	return function(self, key)
		return message(self, key, msg)
	end
end
_reader[135] = function(msg)
	return _reader.int64_repeated
end
_reader[136] = function(msg)
	return _reader.int32_repeated
end
_reader[137] = _reader[133]
_reader[138] = function(msg)
	return _reader.int52_repeated
end
_reader[139] = function(msg)
	return _reader.uint52_repeated
end

local _decode_type_meta = {}

function _decode_type_meta:__index(key)
	local t, msg = c._env_type(P, self._CType, key)

	if _reader[t] == nil then
		return nil
	else
		local func = assert(_reader[t], key)(msg)

		self[key] = func

		return func
	end
end

setmetatable(decode_type_cache, {
	__index = function(self, key)
		local v = setmetatable({
			_CType = key
		}, _decode_type_meta)

		self[key] = v

		return v
	end
})

local function decode_message(message, buffer, length)
	local rmessage = c._rmessage_new(P, message, buffer, length)

	if rmessage then
		local self = {
			_CObj = rmessage,
			_CType = message
		}

		c._add_rmessage(GC, rmessage)

		return setmetatable(self, _R_meta)
	end
end

local encode_type_cache = {}

local function encode_message(CObj, message_type, t)
	local type = encode_type_cache[message_type]

	for k, v in pairs(t) do
		local func = type[k]

		func(CObj, k, v)
	end
end

local _writer = {
	int = c._wmessage_integer,
	real = c._wmessage_real,
	enum = c._wmessage_string,
	string = c._wmessage_string,
	int64 = c._wmessage_int64,
	int32 = c._wmessage_int32,
	int52 = c._wmessage_int52,
	uint52 = c._wmessage_uint52
}

function _writer:bool(k, v)
	c._wmessage_integer(self, k, v and 1 or 0)
end

function _writer:message(k, v, message_type)
	local submessage = c._wmessage_message(self, k)

	encode_message(submessage, message_type, v)
end

function _writer:int_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_integer(self, k, v)
	end
end

function _writer:real_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_real(self, k, v)
	end
end

function _writer:bool_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_integer(self, k, v and 1 or 0)
	end
end

function _writer:string_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_string(self, k, v)
	end
end

function _writer:message_repeated(k, v, message_type)
	for _, v in ipairs(v) do
		local submessage = c._wmessage_message(self, k)

		encode_message(submessage, message_type, v)
	end
end

function _writer:int32_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_int32(self, k, v)
	end
end

function _writer:int64_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_int64(self, k, v)
	end
end

function _writer:int52_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_int52(self, k, v)
	end
end

function _writer:uint52_repeated(k, v)
	for _, v in ipairs(v) do
		c._wmessage_uint52(self, k, v)
	end
end

_writer[1] = function(msg)
	return _writer.int
end
_writer[2] = function(msg)
	return _writer.real
end
_writer[3] = function(msg)
	return _writer.bool
end
_writer[4] = function(msg)
	return _writer.string
end
_writer[5] = function(msg)
	return _writer.string
end
_writer[6] = function(msg)
	local message = _writer.message

	return function(self, key, v)
		return message(self, key, v, msg)
	end
end
_writer[7] = function(msg)
	return _writer.int64
end
_writer[8] = function(msg)
	return _writer.int32
end
_writer[9] = _writer[5]
_writer[10] = function(msg)
	return _writer.int52
end
_writer[11] = function(msg)
	return _writer.uint52
end
_writer[129] = function(msg)
	return _writer.int_repeated
end
_writer[130] = function(msg)
	return _writer.real_repeated
end
_writer[131] = function(msg)
	return _writer.bool_repeated
end
_writer[132] = function(msg)
	return _writer.string_repeated
end
_writer[133] = function(msg)
	return _writer.string_repeated
end
_writer[134] = function(msg)
	local message = _writer.message_repeated

	return function(self, key, v)
		return message(self, key, v, msg)
	end
end
_writer[135] = function(msg)
	return _writer.int64_repeated
end
_writer[136] = function(msg)
	return _writer.int32_repeated
end
_writer[137] = _writer[133]
_writer[138] = function(msg)
	return _writer.int52_repeated
end
_writer[139] = function(msg)
	return _writer.uint52_repeated
end

local _encode_type_meta = {}

function _encode_type_meta:__index(key)
	local t, msg = c._env_type(P, self._CType, key)
	local func = assert(_writer[t], key)(msg)

	self[key] = func

	return func
end

setmetatable(encode_type_cache, {
	__index = function(self, key)
		local v = setmetatable({
			_CType = key
		}, _encode_type_meta)

		self[key] = v

		return v
	end
})

function encode(message, t, func, ...)
	local encoder = c._wmessage_new(P, message)

	assert(encoder, message)
	encode_message(encoder, message, t)

	if func then
		local buffer, len = c._wmessage_buffer(encoder)
		local ret = func(buffer, len, ...)

		c._wmessage_delete(encoder)

		return ret
	else
		local s = c._wmessage_buffer_string(encoder)

		c._wmessage_delete(encoder)

		return s
	end
end

local _pattern_type = {
	{
		"%d",
		"i"
	},
	{
		"%F",
		"r"
	},
	{
		"%d",
		"b"
	},
	{
		"%d",
		"i"
	},
	{
		"%s",
		"s"
	},
	{
		"%s",
		"m"
	},
	{
		"%D",
		"x"
	},
	{
		"%d",
		"p"
	},
	[10] = {
		"%D",
		"d"
	},
	[11] = {
		"%D",
		"u"
	},
	[129] = {
		"%a",
		"I"
	},
	[130] = {
		"%a",
		"R"
	},
	[131] = {
		"%a",
		"B"
	},
	[132] = {
		"%a",
		"I"
	},
	[133] = {
		"%a",
		"S"
	},
	[134] = {
		"%a",
		"M"
	},
	[135] = {
		"%a",
		"X"
	},
	[136] = {
		"%a",
		"P"
	},
	[138] = {
		"%a",
		"D"
	},
	[139] = {
		"%a",
		"U"
	}
}

_pattern_type[9] = _pattern_type[5]
_pattern_type[137] = _pattern_type[133]

local function _pattern_create(pattern)
	local iter = string.gmatch(pattern, "[^ ]+")
	local message = iter()
	local cpat = {}
	local lua = {}

	for v in iter do
		local tidx = c._env_type(P, message, v)
		local t = _pattern_type[tidx]

		assert(t, tidx)
		tinsert(cpat, v .. " " .. t[1])
		tinsert(lua, t[2])
	end

	local cobj = c._pattern_new(P, message, "@" .. table.concat(cpat, " "))

	if cobj == nil then
		return
	end

	c._add_pattern(GC, cobj)

	local pat = {
		size = 0,
		CObj = cobj,
		format = table.concat(lua)
	}

	pat.size = c._pattern_size(pat.format)

	return pat
end

setmetatable(_pattern_cache, {
	__index = function(t, key)
		local v = _pattern_create(key)

		t[key] = v

		return v
	end
})

function unpack(pattern, buffer, length)
	local pat = _pattern_cache[pattern]

	return c._pattern_unpack(pat.CObj, pat.format, pat.size, buffer, length)
end

function pack(pattern, ...)
	local pat = _pattern_cache[pattern]

	return c._pattern_pack(pat.CObj, pat.format, pat.size, ...)
end

function check(typename, field)
	if field == nil then
		return c._env_type(P, typename)
	else
		return c._env_type(P, typename, field) ~= 0
	end
end

local default_cache = {}

local function default_table(typename)
	local v = default_cache[typename]

	if v then
		return v
	end

	v = {
		__index = assert(decode_message(typename, ""))
	}
	default_cache[typename] = v

	return v
end

local decode_message_mt = {}

local function decode_message_cb(typename, buffer)
	return setmetatable({
		typename,
		buffer
	}, decode_message_mt)
end

function decode(typename, buffer, length)
	local ret = {}
	local ok = c._decode(P, decode_message_cb, ret, typename, buffer, length)

	if ok then
		return setmetatable(ret, default_table(typename))
	else
		return false, c._last_error(P)
	end
end

local function expand(tbl)
	local typename = rawget(tbl, 1)
	local buffer = rawget(tbl, 2)

	tbl[1], tbl[2] = nil

	assert(c._decode(P, decode_message_cb, tbl, typename, buffer), typename)
	setmetatable(tbl, default_table(typename))
end

function decode_message_mt.__index(tbl, key)
	expand(tbl)

	return tbl[key]
end

function decode_message_mt.__pairs(tbl)
	expand(tbl)

	return pairs(tbl)
end

local function set_default(typename, tbl)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			local t, msg = c._env_type(P, typename, k)

			if t == 6 then
				set_default(msg, v)
			elseif t == 134 then
				for _, v in ipairs(v) do
					set_default(msg, v)
				end
			end
		end
	end

	return setmetatable(tbl, default_table(typename))
end

function register(buffer)
	c._env_register(P, buffer)
end

function register_file(filename)
	local f = assert(io.open(filename, "rb"))
	local buffer = f:read("*a")

	c._env_register(P, buffer)
	f:close()
end

function enum_id(enum_type, enum_name)
	return c._env_enum_id(P, enum_type, enum_name)
end

function extract(tbl)
	local typename = rawget(tbl, 1)
	local buffer = rawget(tbl, 2)

	if type(typename) == "string" and type(buffer) == "string" and check(typename) then
		expand(tbl)
	end

	for k, v in pairs(tbl) do
		if type(v) == "table" then
			extract(v)
		end
	end
end

default = set_default
