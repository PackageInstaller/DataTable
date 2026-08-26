-- chunkname: @modules/logic/enemyinfo/controller/EnemyInfoController.lua

module("modules.logic.enemyinfo.controller.EnemyInfoController", package.seeall)

local EnemyInfoController = class("EnemyInfoController")

function EnemyInfoController:openRougeEnemyInfoView(battleId, hpFixRate)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		hpFixRate = hpFixRate,
		tabEnum = EnemyInfoEnum.TabEnum.Rouge
	})
end

function EnemyInfoController:openSurvivalEnemyInfoView(battleId, hpFixRate)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		hpFixRate = hpFixRate,
		tabEnum = EnemyInfoEnum.TabEnum.Survival
	})
end

function EnemyInfoController:openEnemyInfoViewByBattleId(battleId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		tabEnum = EnemyInfoEnum.TabEnum.Normal
	})
end

function EnemyInfoController:openWeekWalkEnemyInfoView(mapId, selectBattleId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		mapId = mapId,
		selectBattleId = selectBattleId,
		tabEnum = EnemyInfoEnum.TabEnum.WeekWalk
	})
end

function EnemyInfoController:openWeekWalk_2EnemyInfoView(mapId, selectBattleId)
	ViewMgr.instance:openView(ViewName.WeekWalk_2EnemyInfoView, {
		mapId = mapId,
		selectBattleId = selectBattleId,
		tabEnum = EnemyInfoEnum.TabEnum.WeekWalk_2
	})
end

function EnemyInfoController:openSeason123EnemyInfoView(activityId, stage, layer)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = true,
		activityId = activityId,
		stage = stage,
		layer = layer,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function EnemyInfoController:openSeason123EnemyInfoViewWithNoTab(activityId, battleId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		showLeftTab = false,
		activityId = activityId,
		battleId = battleId,
		tabEnum = EnemyInfoEnum.TabEnum.Season123
	})
end

function EnemyInfoController:openBossRushEnemyInfoView(activityId, stage, layer)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		activityId = activityId,
		stage = stage,
		layer = layer,
		tabEnum = EnemyInfoEnum.TabEnum.BossRush
	})
end

function EnemyInfoController:openAct191EnemyInfoView(battleId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		tabEnum = EnemyInfoEnum.TabEnum.Act191
	})
end

function EnemyInfoController:openTowerDeepEnemyInfoView(battleId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		tabEnum = EnemyInfoEnum.TabEnum.TowerDeep
	})
end

function EnemyInfoController:openTowerComposeEnemyInfoView(battleId, themeId, planeId, episodeId)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		themeId = themeId,
		planeId = planeId,
		episodeId = episodeId,
		tabEnum = EnemyInfoEnum.TabEnum.TowerCompose
	})
end

function EnemyInfoController:openSodacheEnemyInfoView(battleId, careerIds, hpFixRate)
	ViewMgr.instance:openView(ViewName.BaseEnemyInfoView, {
		battleId = battleId,
		careerIds = careerIds,
		hpFixRate = hpFixRate,
		tabEnum = EnemyInfoEnum.TabEnum.Sodache
	})
end

EnemyInfoController.instance = EnemyInfoController.New()

LuaEventSystem.addEventMechanism(EnemyInfoController.instance)

return EnemyInfoController
