-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_EnemyInfoView.lua

module("modules.logic.bossrush.view.V1a4_BossRush_EnemyInfoView", package.seeall)

local V1a4_BossRush_EnemyInfoView = class("V1a4_BossRush_EnemyInfoView", EnemyInfoView)

function V1a4_BossRush_EnemyInfoView:onInitView()
	V1a4_BossRush_EnemyInfoView.super.onInitView(self)

	self._txthp = gohelper.findChildText(self.viewGO, "enemyinfo/#txt_hp")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._imagedmgtype = gohelper.findChildImage(self.viewGO, "enemyinfo/#txt_name/#image_dmgtype")
end

function V1a4_BossRush_EnemyInfoView:_refreshUI()
	if not self._battleId then
		logError("地方信息界面缺少战斗Id")

		return
	end

	V1a4_BossRush_EnemyInfoView.super._refreshUI(self)
	self:_doUpdateSelectIcon(self._battleId)
end

function V1a4_BossRush_EnemyInfoView:_getBossId(groupIndex)
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

function V1a4_BossRush_EnemyInfoView:onUpdateParam()
	local stage, layer = self.viewParam.bossRushStage, self.viewParam.bossRushLayer

	self._battleId = BossRushConfig.instance:getDungeonBattleId(stage, layer)

	self:_refreshUI()
end

function V1a4_BossRush_EnemyInfoView:onOpen()
	self.addEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
	self:onUpdateParam()
end

function V1a4_BossRush_EnemyInfoView:onClose()
	self.removeEventCb(self, HeroGroupController.instance, HeroGroupEvent.OnClickEnemyItem, self._refreshInfo, self)
end

function V1a4_BossRush_EnemyInfoView:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getBossRushViewRule()

	ruleView:refreshUI(battleId)
end

function V1a4_BossRush_EnemyInfoView:_refreshInfo(monsterConfig)
	V1a4_BossRush_EnemyInfoView.super._refreshInfo(self, monsterConfig)

	local monsterId = monsterConfig.monsterId
	local monsterCo = lua_monster.configDict[monsterId]

	UISpriteSetMgr.instance:setCommonSprite(self._imagedmgtype, "dmgtype" .. tostring(monsterCo.dmgType))
end

return V1a4_BossRush_EnemyInfoView
