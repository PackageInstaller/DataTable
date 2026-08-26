-- chunkname: @modules/logic/fight/mgr/FightNecessaryAssetLoaderMgr.lua

module("modules.logic.fight.mgr.FightNecessaryAssetLoaderMgr", package.seeall)

local FightNecessaryAssetLoaderMgr = class("FightNecessaryAssetLoaderMgr", FightBaseClass)

function FightNecessaryAssetLoaderMgr:onConstructor()
	return
end

function FightNecessaryAssetLoaderMgr:registWorkLoadAsset()
	local flow = self:com_registFlowParallel()

	flow:registWork(FightWorkLoadAsset, "ui/viewres/fight/fightview.prefab", self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, "ui/viewres/fight/fightskillselectview.prefab", self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, FightPreloadOthersWork.ui_mesh, self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, FightPreloadOthersWork.ui_effectsmat, self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_02), self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, ResUrl.getUIEffect(FightPreloadViewWork.ui_chupai_03), self.onAssetLoaded, self)
	flow:registWork(FightWorkLoadAsset, ResUrl.getUIEffect(FightPreloadViewWork.ui_dazhaoka), self.onAssetLoaded, self)

	return flow
end

function FightNecessaryAssetLoaderMgr:onAssetLoaded(success, assetItem)
	if not success then
		logError("缺少战斗必要资源, path:" .. assetItem.ResPath)
		self:disposeSelf()

		local preSceneType = GameSceneMgr.instance:getPreSceneType()
		local preSceneId = GameSceneMgr.instance:getPreSceneId()
		local preLevelId = GameSceneMgr.instance:getPreLevelId()

		GameSceneMgr.instance:startScene(preSceneType, preSceneId, preLevelId)

		return
	end
end

function FightNecessaryAssetLoaderMgr:onDestructor()
	return
end

return FightNecessaryAssetLoaderMgr
