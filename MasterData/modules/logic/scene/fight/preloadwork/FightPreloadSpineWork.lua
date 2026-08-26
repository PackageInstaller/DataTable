-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadSpineWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadSpineWork", package.seeall)

local FightPreloadSpineWork = class("FightPreloadSpineWork", BaseWork)

function FightPreloadSpineWork:onStart(context)
	local spineUrlList = self:_getSpineUrlList()

	self._loader = SequenceAbLoader.New()

	for _, resPath in ipairs(spineUrlList) do
		self._loader:addPath(resPath)
	end

	self._loader:setConcurrentCount(10)
	self._loader:setLoadFailCallback(self._onPreloadOneFail)
	self._loader:startLoad(self._onPreloadFinish, self)
end

function FightPreloadSpineWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	for url, assetItem in pairs(assetItemDict) do
		self.context.callback(self.context.callbackObj, assetItem)
	end

	self:onDone(true)
end

function FightPreloadSpineWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗Spine加载失败：" .. assetItem.ResPath)
end

function FightPreloadSpineWork:clearWork()
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightPreloadSpineWork:_getSpineUrlList()
	local spineUrlDict = {}

	for _, skinId in ipairs(self.context.mySkinIds) do
		local skinCO = FightConfig.instance:getSkinCO(skinId)

		if skinCO and not string.nilorempty(skinCO.spine) then
			spineUrlDict[ResUrl.getSpineFightPrefabBySkin(skinCO)] = true
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(skinId, spineUrlDict)
	end

	for _, skinId in ipairs(self.context.enemySkinIds) do
		local skinCO = FightConfig.instance:getSkinCO(skinId)

		if skinCO and not string.nilorempty(skinCO.spine) then
			spineUrlDict[ResUrl.getSpineFightPrefabBySkin(skinCO)] = true
		end
	end

	for _, subSkinId in ipairs(self.context.subSkinIds) do
		local skinCO = FightConfig.instance:getSkinCO(subSkinId)

		if skinCO and not string.nilorempty(skinCO.alternateSpine) then
			spineUrlDict[ResUrl.getSpineFightPrefab(skinCO.alternateSpine)] = true
		end

		FightHelper.setZongMaoShaLiMianJuSpineUrl(subSkinId, spineUrlDict)
	end

	local xing_ti_special_url = FightHelper.preloadXingTiSpecialUrl(self.context.myModelIds, self.context.enemyModelIds)
	local ret = {}

	for url, _ in pairs(spineUrlDict) do
		if FightHelper.XingTiSpineUrl2Special[url] and xing_ti_special_url then
			if xing_ti_special_url == 1 then
				url = FightHelper.XingTiSpineUrl2Special[url]
			elseif xing_ti_special_url == 2 then
				table.insert(ret, FightHelper.XingTiSpineUrl2Special[url])
			end
		end

		table.insert(ret, url)
	end

	return ret
end

return FightPreloadSpineWork
