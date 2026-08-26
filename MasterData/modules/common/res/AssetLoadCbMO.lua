-- chunkname: @modules/common/res/AssetLoadCbMO.lua

module("modules.common.res.AssetLoadCbMO", package.seeall)

local AssetLoadCbMO = class("AssetLoadCbMO")

function AssetLoadCbMO:ctor(loadedCb, loadedObj)
	self._loadedCb = loadedCb
	self._loadedObj = loadedObj
end

function AssetLoadCbMO:call(...)
	self._loadedCb(self._loadedObj, ...)
end

return AssetLoadCbMO
