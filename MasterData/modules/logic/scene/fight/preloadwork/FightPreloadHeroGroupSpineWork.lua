-- chunkname: @modules/logic/scene/fight/preloadwork/FightPreloadHeroGroupSpineWork.lua

module("modules.logic.scene.fight.preloadwork.FightPreloadHeroGroupSpineWork", package.seeall)

local FightPreloadHeroGroupSpineWork = class("FightPreloadHeroGroupSpineWork", BaseWork)

function FightPreloadHeroGroupSpineWork:onStart(context)
	local spineUrlList = self:_getSpineUrlList()

	if spineUrlList and #spineUrlList > 0 then
		self._loader = SequenceAbLoader.New()

		self._loader:setPathList(spineUrlList)
		self._loader:setConcurrentCount(10)
		self._loader:setLoadFailCallback(self._onPreloadOneFail)
		self._loader:startLoad(self._onPreloadFinish, self)
	else
		self:onDone(true)
	end
end

function FightPreloadHeroGroupSpineWork:_onPreloadFinish()
	local assetItemDict = self._loader:getAssetItemDict()

	self._needCreateList = {}
	self._hasCreateList = {}

	for url, assetItem in pairs(assetItemDict) do
		FightSpinePool.setAssetItem(url, assetItem)
		table.insert(self._needCreateList, url)
		self.context.callback(self.context.callbackObj, assetItem)
	end

	local needCreateCount = #self._needCreateList

	if needCreateCount > 0 then
		TaskDispatcher.runRepeat(self._createSpineGO, self, 0.1, needCreateCount)
	else
		self:onDone(true)
	end
end

function FightPreloadHeroGroupSpineWork:_createSpineGO()
	local url = table.remove(self._needCreateList)
	local spineGO = FightSpinePool.getSpine(url)

	gohelper.setActive(spineGO, false)

	local container = FightGameMgr.entityMgr:getEntityContainer()

	gohelper.addChild(container, spineGO)
	table.insert(self._hasCreateList, {
		url,
		spineGO
	})

	if #self._needCreateList == 0 then
		FightPreloadController.instance:cacheFirstPreloadSpine(self._hasCreateList)
		TaskDispatcher.cancelTask(self._createSpineGO, self)
		self:_returnSpineToPool()
		self:onDone(true)
	end
end

function FightPreloadHeroGroupSpineWork:_returnSpineToPool()
	if self._hasCreateList then
		for _, tb in ipairs(self._hasCreateList) do
			local url = tb[1]
			local spineGO = tb[2]

			tb[1] = nil
			tb[2] = nil

			FightSpinePool.putSpine(url, spineGO)
		end
	end

	self._needCreateList = nil
	self._hasCreateList = nil
end

function FightPreloadHeroGroupSpineWork:_onPreloadOneFail(loader, assetItem)
	logError("战斗Spine加载失败：" .. assetItem.ResPath)
end

function FightPreloadHeroGroupSpineWork:clearWork()
	self:_returnSpineToPool()
	TaskDispatcher.cancelTask(self._createSpineGO, self)

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end
end

function FightPreloadHeroGroupSpineWork:_getSpineUrlList()
	local roleSkinUrlList = {}

	for i = 1, 3 do
		local heroSingleGroupMO = HeroSingleGroupModel.instance:getById(i)
		local heroMO = heroSingleGroupMO:getHeroMO()
		local monsterCO = heroSingleGroupMO:getMonsterCO()
		local skinId

		if heroMO then
			skinId = heroMO.skin
		elseif monsterCO then
			skinId = monsterCO.skinId
		end

		if skinId then
			if (FightHelper.getZongMaoShaLiMianJuPath(skinId) or nil) and false then
				local skinCO = FightConfig.instance:getSkinCO(skinId)
				local url = ResUrl.getSpineFightPrefabBySkin(skinCO)

				table.insert(roleSkinUrlList, url)
			end
		end
	end

	return roleSkinUrlList
end

return FightPreloadHeroGroupSpineWork
