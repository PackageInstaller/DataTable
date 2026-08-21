-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/climbingtower/model/ClimbingTowerDungeonMo.lua

module("logic.extensions.climbingtower.model.ClimbingTowerDungeonMo", package.seeall)

local M = class("ClimbingTowerDungeonMo", DungeonMOBase)

function M:initByConfig(co)
	M.super.initByConfig(self, co)
end

function M:setTowerCfg(typ, towerCfgId)
	self._towerTyp = typ
	self._towerCfgId = towerCfgId
end

function M:getTowerTyp()
	return self._towerTyp
end

function M:getTowerCfgId()
	return self._towerCfgId
end

function M:getDungeonId()
	return self:getId()
end

function M:getDifficultAngle()
	if not self._difficultAngle then
		self._difficultAngle = {}

		local cfgName

		if self:getTowerTyp() == ClimbingTowerEnum.PageTyp.BrightSide then
			cfgName = ConfigName.LightMoonTower
		else
			cfgName = ConfigName.DarkMoonTower
		end

		local cfg = ClimbingTowerConfig.instance:getConfigByKey(cfgName, self:getTowerCfgId())
		local hour, min = -1, -1

		if not string.nilorempty(cfg.diffAngle) then
			local timeStrArr = string.split(cfg.diffAngle, "#")

			for _, tStr in ipairs(timeStrArr) do
				if not string.nilorempty(tStr) then
					local t = string.split(tStr, ":")

					hour = tonumber(t[1])
					min = tonumber(t[2])
				else
					hour, min = -1, -1
				end

				table.insert(self._difficultAngle, {
					hour = hour,
					min = min
				})
			end
		else
			for i = 1, 3 do
				table.insert(self._difficultAngle, {
					hour = hour,
					min = min
				})
			end
		end
	end

	return self._difficultAngle
end

function M:getIsUnlock()
	if DungeonModel.instance:getAllDungeonUnlock() then
		return true
	end

	if not self._preDungeonId then
		return true
	end

	if self:getTowerTyp() == ClimbingTowerEnum.PageTyp.BrightSide then
		local preDungeonMo = ClimbingTowerModel.instance:getDungeonMoById(self._preDungeonId)

		return preDungeonMo:hasPassed()
	else
		local preDungeonMo = ClimbingTowerDarkModel.instance:getDungeonMoById(self._preDungeonId)

		return preDungeonMo:hasPassed()
	end
end

function M:getIsLock()
	return not self:getIsUnlock()
end

function M:getIsClear()
	return self:hasPassed()
end

function M:getBossId()
	local enemyIds = self:getEnemyIds() or {}

	return enemyIds[1] or 0
end

function M:getBossLv()
	if not self._bossLevel then
		local level = 0
		local bossId = self:getBossId()

		if bossId > 0 then
			local monsterCO = MonsterConfig.instance:getMonsterCO(bossId)

			if monsterCO then
				level = monsterCO.level
			end
		end

		self._bossLevel = level
	end

	return self._bossLevel
end

function M:getCostItemId()
	return CommEnum.CurrencyCodeEnum.TlCode
end

function M:getCostItemCount()
	return self:getPointCost()
end

function M:getFirstPassRewardDataLst()
	if not self._firstPassRewardDataLst then
		self._firstPassRewardDataLst = {}

		for _, reward in ipairs(self:getAllFirstPassReward()) do
			self:_addRewardToTable(self._firstPassRewardDataLst, reward.code, reward.num, true)
		end
	end

	return self._firstPassRewardDataLst
end

function M:getNormalPassRewardDataLst()
	if not self._normalPassRewardDataLst then
		self._normalPassRewardDataLst = {}

		for _, reward in ipairs(self:getAllNormalPassReward()) do
			self:_addRewardToTable(self._normalPassRewardDataLst, reward, 1, false)
		end
	end

	return self._normalPassRewardDataLst
end

function M:getTotalPassRewardDataLst()
	if not self._totalPassRewardDataLst then
		self._totalPassRewardDataLst = {}

		local first = self:getFirstPassRewardDataLst()
		local normal = self:getNormalPassRewardDataLst()

		for _, value in ipairs(first) do
			table.insert(self._totalPassRewardDataLst, value)
		end

		for _, value in ipairs(normal) do
			table.insert(self._totalPassRewardDataLst, value)
		end
	end

	return self._totalPassRewardDataLst
end

function M:_addRewardToTable(theTable, itemId, itemCount, isFirstPassItem)
	local itemData = ItemUtil.createItemData({
		itemId = itemId
	})

	itemData:setCount(itemCount)
	table.insert(theTable, {
		itemData = itemData,
		isFirstPassItem = isFirstPassItem
	})
end

function M:getWinConditionDescLst()
	if not self._winConditionDescLst then
		self._winConditionDescLst = {}
	end

	return self._winConditionDescLst
end

function M:canRecord()
	return false
end

function M:getLastDungeonId()
	local dungeonId

	if self:getTowerTyp() == ClimbingTowerEnum.PageTyp.BrightSide then
		local maxStorey = ClimbingTowerConfig.instance:getBrightSideMaxStorey()

		dungeonId = ClimbingTowerConfig.instance:getBrightTowerDungeonIdByCode(maxStorey)
	else
		local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()

		if darkRound then
			local co = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

			if co then
				local dungeonIds = co:getDungeonIds()

				dungeonId = dungeonIds[#dungeonIds]
			end
		end
	end

	return dungeonId
end

function M:getNextDungeonId()
	if self:getTowerTyp() == ClimbingTowerEnum.PageTyp.BrightSide then
		local cfg = ClimbingTowerConfig.instance:getConfigByKey(ConfigName.LightMoonTower, self:getTowerCfgId() + 1)

		return cfg and cfg.dungeon
	else
		local darkRound = ClimbingTowerDarkModel.instance:getDarkRound()

		if darkRound then
			local co = ClimbingTowerConfig.instance:getDarkRoundCO(darkRound)

			if co then
				local dungeonId = self:getDungeonId()
				local dungeonIds = co:getDungeonIds()
				local index = table.indexof(dungeonIds, dungeonId)

				return dungeonIds[index + 1]
			end
		end
	end
end

return M
