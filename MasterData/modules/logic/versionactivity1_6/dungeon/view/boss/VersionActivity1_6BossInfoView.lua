-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6BossInfoView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6BossInfoView", package.seeall)

local VersionActivity1_6BossInfoView = class("VersionActivity1_6BossInfoView", EnemyInfoView)

function VersionActivity1_6BossInfoView:onInitView()
	VersionActivity1_6BossInfoView.super.onInitView(self)

	self._txthp = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_hp")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "enemyinfo/#txt_name/#image_dmgtype")
end

function VersionActivity1_6BossInfoView:_refreshUI()
	if not self._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	VersionActivity1_6BossInfoView.super._refreshUI(self)
	self:_doUpdateSelectIcon(self._battleId)
end

function VersionActivity1_6BossInfoView:_getBossId(groupIndex)
	local fightParam = FightController.instance:setFightParamByBattleId(self._battleId)

	if fightParam then
		::label_3_0::

		local var_3_0 = fightParam.monsterGroupIds

		if fightParam.monsterGroupIds then
			local monsterGroupId = fightParam.monsterGroupIds[groupIndex]
			local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

			if monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) then
				if not monsterGroupCO.bossId then
					local bossId

					return bossId
				end
			end
		end
	end
end

function VersionActivity1_6BossInfoView:onUpdateParam()
	local episodeId = self.viewParam.bossEpisodeId
	local dungeonEpisodeCfg = Activity149Config.instance:getDungeonEpisodeCfg(episodeId)

	self._battleId = dungeonEpisodeCfg.battleId

	self:_refreshUI()
end

function VersionActivity1_6BossInfoView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
	self:onUpdateParam()
end

function VersionActivity1_6BossInfoView:onClose()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
end

function VersionActivity1_6BossInfoView:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getBossRushViewRule()

	ruleView:refreshUI(battleId)
end

function VersionActivity1_6BossInfoView:_refreshInfo(monsterConfig)
	VersionActivity1_6BossInfoView.super._refreshInfo(self, monsterConfig)

	local monsterId = monsterConfig.monsterId
	local monsterCo = lua_monster.configDict[monsterId]

	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(monsterCo.dmgType))
end

return VersionActivity1_6BossInfoView
