-- chunkname: @modules/logic/scene/fight/comp/FightScenePreloader.lua

module("modules.logic.scene.fight.comp.FightScenePreloader", package.seeall)

local FightScenePreloader = class("FightScenePreloader", BaseSceneComp)

function FightScenePreloader:onInit()
	self._scene = self:getCurScene()
end

function FightScenePreloader:startPreload(second)
	local fightParam = FightModel.instance:getFightParam()
	local episodeId = fightParam and fightParam.episodeId

	if fightParam then
		if not fightParam.battleId then
			if episodeId then
				::label_2_0::

				local battleId = DungeonConfig.instance:getEpisodeBattleId(episodeId)

				if not second and FightPreloadController.instance:hasPreload(battleId) then
					self:_onPreloadFinish()

					return
				end

				local myModelIds = {}
				local mySkinIds = {}
				local enemyModelIds = {}
				local enemySkinIds = {}
				local subSkinIds = {}
				local mySideList = FightDataHelper.entityMgr:getMyNormalList()
				local enemySideList = FightDataHelper.entityMgr:getEnemyNormalList()
				local mySideSubList = FightDataHelper.entityMgr:getMySubList()

				for _, one in ipairs(mySideList) do
					table.insert(myModelIds, one.modelId)
					table.insert(mySkinIds, one.skin)
				end

				for _, one in ipairs(enemySideList) do
					table.insert(enemyModelIds, one.modelId)
					table.insert(enemySkinIds, one.skin)
				end

				for _, one in ipairs(mySideSubList) do
					table.insert(subSkinIds, one.skin)
				end

				FightController.instance:registerCallback(FightEvent.OnPreloadFinish, self._onPreloadFinish, self)

				if FightModel.instance.needFightReconnect then
					FightPreloadController.instance:preloadReconnect(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
				elseif second then
					FightPreloadController.instance:preloadSecond(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
				else
					FightPreloadController.instance:preloadFirst(battleId, myModelIds, mySkinIds, enemyModelIds, enemySkinIds, subSkinIds)
				end

				FightRoundPreloadController.instance:registStageEvent()
			end
		end
	end
end

function FightScenePreloader:_onPreloadFinish()
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, self._onPreloadFinish, self)
	self:dispatchEvent(FightSceneEvent.OnPreloadFinish)
end

function FightScenePreloader:onSceneClose()
	FightPreloadController.instance:dispose()
	FightRoundPreloadController.instance:dispose()
	FightController.instance:unregisterCallback(FightEvent.OnPreloadFinish, self._onPreloadFinish, self)
end

return FightScenePreloader
