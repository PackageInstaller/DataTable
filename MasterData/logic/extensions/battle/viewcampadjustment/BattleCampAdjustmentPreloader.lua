-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentPreloader.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentPreloader", package.seeall)

local BattleCampAdjustmentPreloader = class("BattleCampAdjustmentPreloader")
local kMaxPreloadCount = 10

function BattleCampAdjustmentPreloader:ctor()
	self._cacheList = {}
	self._multiLoader = MultiResLoader.New()
end

function BattleCampAdjustmentPreloader:preload(heroMOList)
	self._heroMOList = heroMOList

	removetimer(self._startPreload, self)
	settimer(3, self._startPreload, self, false)
end

function BattleCampAdjustmentPreloader:clear()
	self._heroMOList = false

	self._multiLoader:clear()
	removetimer(self._startPreload, self)

	for _, resource in ipairs(self._cacheList) do
		resource:Release()
	end

	BattleTableUtil.clearTable(self._cacheList)
end

function BattleCampAdjustmentPreloader:_startPreload()
	if not self._heroMOList then
		return
	end

	self._multiLoader:clear()

	local heroMOList = self._heroMOList
	local loopCount = math.min(kMaxPreloadCount, #heroMOList)

	for i = 1, loopCount do
		local heroMO = heroMOList[i]
		local isForbidden = BattleCampAdjustmentModel.instance:isForbiddenCharacterCode(heroMO:getId())

		if isForbidden then
			break
		end

		local modelCO = heroMO:getModelCo()
		local resPath = ModelCOUtil.getLowModelUrl(modelCO)

		if not string.nilorempty(resPath) then
			self._multiLoader:addResPath(resPath, true)
		end
	end

	self._multiLoader:load(self._onAllResLoaded, false, self)
end

function BattleCampAdjustmentPreloader:_onAllResLoaded()
	local resourceCount = self._multiLoader.loadedCount

	self:_popFromCacheList(resourceCount)
	self:_moveLoaderResultToCacheList()
end

function BattleCampAdjustmentPreloader:_moveLoaderResultToCacheList()
	local resources = self._multiLoader:getResources()

	for _, resource in pairs(resources) do
		resource:Retain()
		table.insert(self._cacheList, resource)
	end

	self._multiLoader:clear()
end

function BattleCampAdjustmentPreloader:_popFromCacheList(count)
	local loopCount = math.min(count, #self._cacheList)

	for i = 1, loopCount do
		local resource = table.remove(self._cacheList, 1)

		resource:Release()
	end
end

return BattleCampAdjustmentPreloader
