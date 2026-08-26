-- chunkname: @modules/common/res/AssetInstanceComp.lua

module("modules.common.res.AssetInstanceComp", package.seeall)

local AssetInstanceComp = class("AssetInstanceComp", LuaCompBase)

function AssetInstanceComp:setAsset(assetMO)
	self._assetMO = assetMO
end

function AssetInstanceComp:onDestroy()
	if self._assetMO then
		self._assetMO:release()
	end

	self._assetMO = nil
end

return AssetInstanceComp
