-- chunkname: @modules/logic/tower/view/fight/TowerDeepHeroGroupFightViewLevel.lua

module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightViewLevel", package.seeall)

local TowerDeepHeroGroupFightViewLevel = class("TowerDeepHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function TowerDeepHeroGroupFightViewLevel:addEvents()
	TowerDeepHeroGroupFightViewLevel.super.addEvents(self)
	self.addEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self._showEnemyList, self)
end

function TowerDeepHeroGroupFightViewLevel:removeEvents()
	TowerDeepHeroGroupFightViewLevel.super.removeEvents(self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.OnLoadTeamSuccess, self._showEnemyList, self)
end

function TowerDeepHeroGroupFightViewLevel:_btnenemyOnClick()
	if self._battleId then
		EnemyInfoController.instance:openTowerDeepEnemyInfoView(self._battleId)
	end
end

function TowerDeepHeroGroupFightViewLevel:_showEnemyList()
	local fight_param = FightModel.instance:getFightParam()
	local boss_career_dic = {}
	local enemy_career_dic = {}
	local enemy_boss_list = {}
	local bossId = TowerPermanentDeepModel.instance:getCurDeepMonsterId()
	local enemy_career = lua_monster.configDict[bossId].career

	boss_career_dic[enemy_career] = (boss_career_dic[enemy_career] or 0) + 1

	table.insert(enemy_boss_list, bossId)

	local enemy_career_list = {}

	for k, v in pairs(boss_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	self._enemy_boss_end_index = #enemy_career_list

	for k, v in pairs(enemy_career_dic) do
		table.insert(enemy_career_list, {
			career = k,
			count = v
		})
	end

	gohelper.CreateObjList(self, self._onEnemyItemShow, enemy_career_list, gohelper.findChild(self._goenemyteam, "enemyList"), gohelper.findChild(self._goenemyteam, "enemyList/go_enemyitem"))

	local recommendLevel = FightHelper.getBattleRecommendLevel(fight_param.battleId, self._isSimple)

	self._txtrecommendlevel.text = recommendLevel >= 0 and HeroConfig.instance:getLevelDisplayVariant(recommendLevel) or ""
end

return TowerDeepHeroGroupFightViewLevel
