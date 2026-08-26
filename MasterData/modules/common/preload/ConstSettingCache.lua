-- chunkname: @modules/common/preload/ConstSettingCache.lua

module("modules.common.preload.ConstSettingCache", package.seeall)

local ConstSettingCache = class("ConstSettingCache")

function ConstSettingCache:ctor()
	self._resPath = {}
end

function ConstSettingCache:init(cb, cbObj)
	return
end

return ConstSettingCache
