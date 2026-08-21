-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/loader/MultiResLoaderExtend.lua

module("logic.common.loader.MultiResLoaderExtend", package.seeall)

local MultiResLoaderExtend = class("MultiResLoaderExtend", MultiResLoader)

function MultiResLoaderExtend:load(finishCallback, progressCallback, callbackObj)
	if self._resPaths == nil or #self._resPaths == 0 then
		finishCallback(callbackObj)

		return
	end

	self._finishCallback = finishCallback or false
	self._progressCallback = progressCallback or false
	self._callbackObj = callbackObj or false
	self.totalCount = #self._resPaths

	local needPreload = false
	local resType = ResType.AssetBunble

	for i = 1, self.totalCount do
		if self._isAllPreload then
			needPreload = true
		elseif self._resPreloadFlags then
			needPreload = self._resPreloadFlags[i]
		else
			needPreload = false
		end

		if self._resTypeList then
			resType = self._resTypeList[i]
		else
			resType = ResType.AssetBunble
		end

		if not self:getResource(self._resPaths[i]) then
			getres(self._resPaths[i], MultiResLoader._onResLoaded, self, resType, needPreload)
		end
	end
end

return MultiResLoaderExtend
