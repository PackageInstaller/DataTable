-- chunkname: @modules/logic/fight/controller/FightPreloadController.lua

module("modules.logic.fight.controller.FightPreloadController", package.seeall)

local FightPreloadController = class("FightPreloadController", BaseController)

function FightPreloadController:onInit()
	self._preloadSequence = nil
	self._firstSequence = self:_buildFirstFlow()
	self._secondSequence = self:_buildSecondFlow()
	self._allResLoadFlow = FlowSequence.New()

	self._allResLoadFlow:addWork(self:_buildFirstFlow(true))
	self._allResLoadFlow:addWork(self:_buildSecondFlow())

	self._reconnectSequence = self:_buildReconnectFlow()
	self._context = {
		callback = self._onPreloadOneFinish,
		callbackObj = self
	}
end

function FightPreloadController:_buildFirstFlow(buildAllRes)
	local sequence = FlowSequence.New()

	sequence:addWork(FightPreloadTimelineFirstWork.New())
	sequence:addWork(FightPreloadTimelineRefWork.New())
	sequence:addWork(FightRoundPreloadEffectWork.New())
	sequence:addWork(FightPreloadFirstMonsterSpineWork.New())
	sequence:addWork(FightPreloadHeroGroupSpineWork.New())
	sequence:addWork(FightPreloadViewWork.New())

	if not buildAllRes then
		sequence:addWork(FightPreloadDoneWork.New())
	end

	sequence:addWork(FightPreloadRoleCardWork.New())
	sequence:addWork(FightPreloadCameraAni.New({}))
	sequence:addWork(FightPreloadEntityAni.New())
	sequence:addWork(FightPreloadRolesTimeline.New())
	sequence:addWork(FightPreloadOthersWork.New())
	sequence:addWork(FightPreloadEffectWork.New())

	return sequence
end

function FightPreloadController:_buildSecondFlow()
	local sequence = FlowSequence.New()

	sequence:addWork(FightPreloadCompareSpineWork.New())
	sequence:addWork(FightPreloadTimelineFirstWork.New())
	sequence:addWork(FightPreloadSpineWork.New())
	sequence:addWork(FightPreloadRoleCardByRealDataWork.New())
	sequence:addWork(FightPreloadOthersWork.New())
	sequence:addWork(FightPreloadViewWork.New())
	sequence:addWork(FightPreloadCameraAni.New())
	sequence:addWork(FightPreloadEntityAni.New())
	sequence:addWork(FightPreloadRolesTimeline.New())
	sequence:addWork(FightPreloadEffectWork.New())
	sequence:addWork(FightPreloadDoneWork.New())
	sequence:addWork(FightPreloadCardInitWork.New())
	sequence:addWork(FightPreloadWaitReplayWork.New())
	sequence:addWork(FightPreloadRoleEffectWork.New())

	return sequence
end

function FightPreloadController:_buildReconnectFlow()
	local sequence = FlowSequence.New()

	sequence:addWork(FightPreloadTimelineFirstWork.New())
	sequence:addWork(FightPreloadSpineWork.New())
	sequence:addWork(FightPreloadRoleCardWork.New())
	sequence:addWork(FightPreloadOthersWork.New())
	sequence:addWork(FightPreloadViewWork.New())
	sequence:addWork(FightPreloadCameraAni.New())
	sequence:addWork(FightPreloadEntityAni.New())
	sequence:addWork(FightPreloadRolesTimeline.New())
	sequence:addWork(FightPreloadEffectWork.New())
	sequence:addWork(FightPreloadDoneWork.New())
	sequence:addWork(FightPreloadCardInitWork.New())
	sequence:addWork(FightPreloadWaitReplayWork.New())
	sequence:addWork(FightPreloadRoleEffectWork.New())

	return sequence
end

function FightPreloadController:reInit()
	self:dispose()
end

function FightPreloadController:isPreloading()
	return self._preloadSequence and self._preloadSequence.status == WorkStatus.Running
end

function FightPreloadController:hasPreload(battleId)
	return (self._battleId == battleId or nil) and self._preloadSequence and self._preloadSequence.status == WorkStatus.Done
end

function FightPreloadController:preloadFirst(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	self:_startPreload(self._firstSequence, battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
end

function FightPreloadController:preloadSecond(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	local curBattleId = FightModel.instance:getBattleId()

	if curBattleId ~= self._battleId then
		self:dispose()
		self:_startPreload(self._allResLoadFlow, battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	else
		self:_startPreload(self._secondSequence, battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	end
end

function FightPreloadController:preloadReconnect(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	self:_startPreload(self._reconnectSequence, battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
end

function FightPreloadController:_startPreload(sequence, battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	self:__onInit()

	if self._preloadSequence and self._preloadSequence.status == WorkStatus.Running then
		self._preloadSequence:stop()
	end

	self._assetItemDict = self._assetItemDict or self:getUserDataTb_()
	self._battleId = battleId
	self._preloadSequence = sequence

	self._preloadSequence:registerDoneListener(self._onPreloadDone, self)
	self._preloadSequence:start(self:_getContext(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds))
end

function FightPreloadController:_getContext(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
	self._context.battleId = battleId
	self._context.myModelIds = myModelIds
	self._context.mySkinIds = mySkinIds
	self._context.enemyModelIds = enemyModelIds
	self._context.enemySkinIds = enemySkinIds
	self._context.subSkinIds = subSkinIds

	return self._context
end

function FightPreloadController:dispose()
	self._battleId = nil

	if self._preloadSequence then
		self._preloadSequence:stop()
		self._preloadSequence:unregisterDoneListener(self._onPreloadDone, self)

		self._preloadSequence = nil
	end

	FightEffectPool.dispose()
	FightSpineMatPool.dispose()
	FightSpinePool.dispose()

	if self._assetItemDict then
		for url, assetItem in pairs(self._assetItemDict) do
			assetItem:Release()
		end

		self._assetItemDict = nil
	end

	self.roleCardAssetItemDict = nil
	self.timelineRefAssetItemDict = nil

	self:cacheFirstPreloadSpine()

	self._context.timelineDict = nil

	ZProj.SkillTimelineAssetHelper.ClearAssetJson()
	self:__onDispose()
end

function FightPreloadController:_onPreloadDone()
	FightController.instance:dispatchEvent(FightEvent.OnPreloadFinish)
end

function FightPreloadController:_onPreloadOneFinish(assetItem)
	local url = assetItem.ResPath

	if not self._assetItemDict[url] then
		self._assetItemDict[url] = assetItem

		assetItem:Retain()
	end
end

function FightPreloadController:addRoleCardAsset(assetItem)
	local url = assetItem.ResPath

	self.roleCardAssetItemDict = self.roleCardAssetItemDict or {}
	self.roleCardAssetItemDict[url] = assetItem
end

function FightPreloadController:releaseRoleCardAsset()
	if not self.roleCardAssetItemDict then
		return
	end

	for url, assetItem in pairs(self.roleCardAssetItemDict) do
		self.roleCardAssetItemDict[url] = nil
		self._assetItemDict[url] = nil

		assetItem:Release()
	end

	self.roleCardAssetItemDict = nil
end

function FightPreloadController:addTimelineRefAsset(assetItem)
	local url = assetItem.ResPath

	self.timelineRefAssetItemDict = self.timelineRefAssetItemDict or {}
	self.timelineRefAssetItemDict[url] = assetItem
end

function FightPreloadController:releaseTimelineRefAsset()
	if not self.timelineRefAssetItemDict then
		return
	end

	for url, assetItem in pairs(self.timelineRefAssetItemDict) do
		self.timelineRefAssetItemDict[url] = nil
		self._assetItemDict[url] = nil

		assetItem:Release()
	end

	self.timelineRefAssetItemDict = nil
end

function FightPreloadController:getFightAssetItem(path)
	local assetItem = self._assetItemDict[path]

	if assetItem then
		return assetItem
	end

	logWarn(path .. " need preload")
end

function FightPreloadController:releaseAsset(url)
	if self._assetItemDict then
		if self._assetItemDict then
			self._assetItemDict:Release()

			self._assetItemDict[url] = nil
		end
	end
end

function FightPreloadController:cacheFirstPreloadSpine(data)
	if data then
		self.cachePreloadSpine = {}

		for i, v in ipairs(data) do
			self.cachePreloadSpine[v[1]] = v[2]
		end
	else
		self.cachePreloadSpine = nil
	end
end

FightPreloadController.instance = FightPreloadController.New()

return FightPreloadController
