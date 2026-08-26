-- chunkname: @modules/logic/seasonver/act123/model/Season123EnemyModel.lua

module("modules.logic.seasonver.act123.model.Season123EnemyModel", package.seeall)

local Season123EnemyModel = class("Season123EnemyModel", BaseModel)

function Season123EnemyModel:release()
	self.selectIndex = nil
	self.battleIdList = nil
	self.stage = nil
	self._groupMap = nil
	self._monsterGroupMap = nil
	self._group2Monsters = nil
	self.selectMonsterGroupIndex = nil
	self.selectMonsterIndex = nil
	self.selectMonsterId = nil
end

function Season123EnemyModel:init(actId, stage, layer)
	self.activityId = actId
	self.stage = stage
	self.selectIndex = 1
	self.battleIdList = Season123EnemyModel.getStageBattleIds(actId, stage)

	self:initDatas()
	self:initSelect(layer)
end

function Season123EnemyModel:initDatas()
	self._groupMap = {}
	self._monsterGroupMap = {}
	self._group2Monsters = {}
end

function Season123EnemyModel:initSelect(layer)
	local cfgList = Season123Config.instance:getSeasonEpisodeStageCos(self.activityId, self.stage)

	if not cfgList then
		return nil
	end

	for i, co in ipairs(cfgList) do
		if co.layer == layer then
			self.selectIndex = i

			return
		end
	end
end

function Season123EnemyModel:getCurrentBattleGroupIds()
	local battleId = self:getSelectBattleId()

	if not battleId then
		return
	end

	local monsterGroupIds = self._groupMap[battleId]

	if not monsterGroupIds then
		local battleConfig = lua_battle.configDict[battleId]

		if string.nilorempty(battleConfig.monsterGroupIds) then
			monsterGroupIds = {}
		else
			monsterGroupIds = string.splitToNumber(battleConfig.monsterGroupIds, "#")

			for i, groupId in ipairs(monsterGroupIds) do
				local monsterGroupCfg = lua_monster_group.configDict[groupId]

				self._monsterGroupMap[groupId] = monsterGroupCfg

				self:initGroup2Monster(groupId, monsterGroupCfg)
			end
		end

		self._groupMap[battleId] = monsterGroupIds
	end

	return monsterGroupIds
end

function Season123EnemyModel:initGroup2Monster(groupId, monsterGroupConfig)
	local monsterIds = {}
	local monsterNilOrEmpty = string.nilorempty(monsterGroupConfig.monster)
	local spmonsterNilOrEmpty = string.nilorempty(monsterGroupConfig.spMonster)

	if monsterNilOrEmpty and spmonsterNilOrEmpty then
		return
	end

	monsterIds = monsterNilOrEmpty and {} or string.splitToNumber(monsterGroupConfig.monster, "#")

	local spMonsterIds = spmonsterNilOrEmpty and {} or string.splitToNumber(monsterGroupConfig.spMonster, "#")

	for _, spMonsterId in ipairs(spMonsterIds) do
		table.insert(monsterIds, spMonsterId)
	end

	self._group2Monsters[groupId] = monsterIds
end

function Season123EnemyModel:getMonsterIds(groupId)
	return self._group2Monsters[groupId]
end

function Season123EnemyModel:setSelectIndex(index)
	self.selectIndex = index

	self:getCurrentBattleGroupIds()
end

function Season123EnemyModel:getSelectedIndex()
	return self.selectIndex
end

function Season123EnemyModel:getBattleIds()
	return self.battleIdList
end

function Season123EnemyModel:getSelectBattleId()
	return self.battleIdList[self.selectIndex]
end

function Season123EnemyModel:setEnemySelectMonsterId(groupIndex, monsterIndex, monsterId)
	self.selectMonsterGroupIndex = groupIndex
	self.selectMonsterIndex = monsterIndex
	self.selectMonsterId = monsterId
end

function Season123EnemyModel:getBossId(groupIndex)
	local battleId = self:getSelectBattleId()

	if not battleId then
		return
	end

	local monsterGroupId = FightModel.instance:getSelectMonsterGroupId(groupIndex, battleId)
	local monsterGroupCO = monsterGroupId and lua_monster_group.configDict[monsterGroupId]

	if monsterGroupCO and not string.nilorempty(monsterGroupCO.bossId) then
		if not monsterGroupCO.bossId then
			local bossId

			return bossId
		end
	end
end

function Season123EnemyModel.getStageBattleIds(actId, stage)
	local rs = {}
	local cfgList = Season123Config.instance:getSeasonEpisodeStageCos(actId, stage)

	if not cfgList then
		return rs
	end

	for i, cfg in ipairs(cfgList) do
		local episodeCO = DungeonConfig.instance:getEpisodeCO(cfg.episodeId)

		if episodeCO then
			table.insert(rs, episodeCO.battleId)
		end
	end

	return rs
end

Season123EnemyModel.instance = Season123EnemyModel.New()

return Season123EnemyModel
