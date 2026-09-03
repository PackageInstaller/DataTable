-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/story/sandbox.lua

module("story", package.seeall)

sandbox = sandbox or {}
sandbox.__scenes__ = sandbox.__scenes__ or {}
sandbox.__stories__ = sandbox.__stories__ or {}
sandbox.floor = math.floor
sandbox.ceil = math.ceil
sandbox.max = math.max
sandbox.min = math.min
sandbox.abs = math.abs
sandbox.random = math.random
sandbox.dump = dump
sandbox.cclog = cclog
