-- chunkname: @modules/common/preload/ConstAbCache.lua

module("modules.common.preload.ConstAbCache", package.seeall)

local ConstAbCache = class("ConstAbCache")

function ConstAbCache:ctor()
	self._pathTab = {
		"ui/viewres/rpcblock/rpcblock.prefab",
		PostProcessingMgr.MainAllProfilePath,
		PostProcessingMgr.MainHighProfilePath,
		PostProcessingMgr.MainMiddleProfilePath,
		PostProcessingMgr.MainLowProfilePath,
		PostProcessingMgr.MainLowBrightnessProfilePath,
		ExploreScenePPVolume.ExploreHighProfilePath,
		ExploreScenePPVolume.ExploreMiddleProfilePath,
		ExploreScenePPVolume.ExploreLowProfilePath,
		RoomResourceEnum.PPVolume.High,
		RoomResourceEnum.PPVolume.Middle,
		RoomResourceEnum.PPVolume.Low,
		PostProcessingMgr.CaptureResPath
	}
	self._pathResTab = {}
end

function ConstAbCache:getRes(path)
	return self._pathResTab[path]
end

function ConstAbCache:startLoad(cb, cbObj)
	self._finishCb = cb
	self._finishCbObj = cbObj
	self._needCount = #self._pathTab

	for _, path in ipairs(self._pathTab) do
		loadAbAsset(path, false, self._onLoadOne, self)
	end
end

function ConstAbCache:_onLoadOne(assetItem)
	if assetItem.IsLoadSuccess then
		assetItem:Retain()

		self._pathResTab[assetItem.ResPath] = assetItem:GetResource()
		self._needCount = self._needCount - 1

		if self._needCount == 0 then
			if self._finishCb then
				self._finishCb(self._finishCbObj)

				self._finishCb = nil
				self._finishCbObj = nil
			end

			logNormal("ConstAbCache 预加载ab资源完成了!")
		end

		return
	end

	logError("ConstAbCache 预加载ab资源失败，path = " .. assetItem.ResPath)
end

ConstAbCache.instance = ConstAbCache.New()

return ConstAbCache
