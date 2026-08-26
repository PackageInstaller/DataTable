-- chunkname: @modules/logic/seasonver/act123/controller/Season123EnemyController.lua

module("modules.logic.seasonver.act123.controller.Season123EnemyController", package.seeall)

local Season123EnemyController = class("Season123EnemyController", BaseController)

function Season123EnemyController:onOpenView(actId, stage, layer)
	Season123EnemyModel.instance:init(actId, stage, layer)
end

function Season123EnemyController:onCloseView()
	Season123EnemyModel.instance:release()
end

function Season123EnemyController:switchTab(index)
	local curIndex = Season123EnemyModel.instance:getSelectedIndex()

	if curIndex ~= index then
		Season123EnemyModel.instance:setSelectIndex(index)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSwitchTab)
	end
end

function Season123EnemyController:selectMonster(groupIndex, monsterIndex)
	local groupIds = Season123EnemyModel.instance:getCurrentBattleGroupIds()

	if not groupIds then
		return
	end

	local monsterIds = Season123EnemyModel.instance:getMonsterIds(groupIds[groupIndex])

	if not monsterIds then
		return
	end

	local monsterId = monsterIds[monsterIndex]

	if monsterId ~= Season123EnemyModel.instance.selectMonsterId then
		Season123EnemyModel.instance:setEnemySelectMonsterId(groupIndex, monsterIndex, monsterId)
		Season123Controller.instance:dispatchEvent(Season123Event.EnemyDetailSelectEnemy)
	end
end

Season123EnemyController.instance = Season123EnemyController.New()

LuaEventSystem.addEventMechanism(Season123EnemyController.instance)

return Season123EnemyController
