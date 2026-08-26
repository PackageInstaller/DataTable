-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadCompareSpineWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadCompareSpineWork", package.seeall)

local FightPreloadCompareSpineWork = class("FightPreloadCompareSpineWork", BaseWork)

function FightPreloadCompareSpineWork:onStart()
	local cacheDict = FightPreloadController.instance.cachePreloadSpine

	if cacheDict then
		local mySpineUrlDict = {}

		for i, v in ipairs(FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide)) do
			local skinCO = FightConfig.instance:getSkinCO(v.skin)
			local url = ResUrl.getSpineFightPrefabBySkin(skinCO)

			mySpineUrlDict[url] = true
		end

		for i, v in ipairs(FightDataHelper.entityMgr:getMySubList()) do
			local skinCO = FightConfig.instance:getSkinCO(v.skin)
			local url = ResUrl.getSpineFightPrefabBySkin(skinCO)

			mySpineUrlDict[url] = true
		end

		for url, spine in pairs(cacheDict) do
			if not mySpineUrlDict[url] then
				FightSpinePool.releaseUrl(url)
				FightPreloadController.instance:releaseAsset(url)

				cacheDict[url] = nil
			end
		end

		FightPreloadController.instance:cacheFirstPreloadSpine()
	end

	self:onDone(true)
end

function FightPreloadCompareSpineWork:clearWork()
	return
end

return FightPreloadCompareSpineWork
