-- chunkname: @modules/logic/versionactivity2_3/act174/model/Act174GameMO.lua

module("modules.logic.versionactivity2_3.act174.model.Act174GameMO", package.seeall)

local Act174GameMO = pureTable("Act174GameMO")

function Act174GameMO:init(info, filter)
	self.hp = info.hp
	self.coin = info.coin
	self.gameCount = info.gameCount
	self.winCount = info.winCount
	self.score = info.score
	self.state = info.state
	self.forceBagInfo = info.forceBagInfo
	self.shopInfo = info.shopInfo

	self:updateTeamMo(info.teamInfo)
	self:updateWareHouseMo(info.warehouseInfo, filter)

	self.fightInfo = info.fightInfo
	self.season = info.season
	self.param = info.param
end

function Act174GameMO:updateShopInfo(shopInfo)
	self.shopInfo = shopInfo
end

function Act174GameMO:updateTeamMo(teamInfos)
	self.teamMoList = {}

	for i, teamInfo in ipairs(teamInfos) do
		local teamMo = Act174TeamMO.New()

		teamMo:init(teamInfo)

		self.teamMoList[i] = teamMo
	end
end

function Act174GameMO:updateWareHouseMo(wareHouseInfo, filter)
	if self.warehouseMo then
		if filter then
			self.warehouseMo:update(wareHouseInfo)
		else
			self.warehouseMo:init(wareHouseInfo)
		end
	else
		self.warehouseMo = Act174WareHouseMO.New()

		self.warehouseMo:init(wareHouseInfo)
	end
end

function Act174GameMO:buyInShopReply(info)
	self.shopInfo = info.shopInfo

	self.warehouseMo:clearNewSign()
	self.warehouseMo:update(info.warehouseInfo)

	self.coin = info.coin
end

function Act174GameMO:updateIsBet(isBet)
	self.fightInfo.betHp = isBet
end

function Act174GameMO:isInGame()
	return self.state ~= Activity174Enum.GameState.None
end

function Act174GameMO:getForceBagsInfo()
	return self.forceBagInfo
end

function Act174GameMO:getShopInfo()
	return self.shopInfo
end

function Act174GameMO:getTeamMoList()
	return self.teamMoList
end

function Act174GameMO:getWarehouseInfo()
	return self.warehouseMo
end

function Act174GameMO:getFightInfo()
	return self.fightInfo
end

function Act174GameMO:setBattleHeroInTeam(row, column, _battleHero)
	if not _battleHero.heroId and not _battleHero.itemId then
		self:delBattleHeroInTeam(row, column)

		return
	end

	local teamInfo = Activity174Helper.MatchKeyInArray(self.teamMoList, row, "index")

	if teamInfo then
		local battleHeros = teamInfo.battleHeroInfo
		local hero = Activity174Helper.MatchKeyInArray(battleHeros, column, "index")

		if hero then
			hero.index = _battleHero.index
			hero.heroId = _battleHero.heroId
			hero.itemId = _battleHero.itemId
			hero.priorSkill = _battleHero.priorSkill
		else
			table.insert(battleHeros, _battleHero)
		end
	else
		teamInfo = {
			index = row,
			battleHeroInfo = {
				_battleHero
			}
		}

		local teamMo = Act174TeamMO.New()

		teamMo:init(teamInfo)
		table.insert(self.teamMoList, teamMo)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function Act174GameMO:delBattleHeroInTeam(row, column)
	local teamInfo = Activity174Helper.MatchKeyInArray(self.teamMoList, row, "index")

	if teamInfo then
		local battleHeros = teamInfo.battleHeroInfo
		local hero = Activity174Helper.MatchKeyInArray(battleHeros, column, "index")

		if hero then
			tabletool.removeValue(battleHeros, hero)
		end
	else
		logError("teamInfo dont exist" .. row)
	end

	Activity174Controller.instance:dispatchEvent(Activity174Event.ChangeLocalTeam)
end

function Act174GameMO:isHeroInTeam(heroId)
	for i = 1, #self.teamMoList do
		local teamInfo = self.teamMoList[i]

		for j = 1, #teamInfo.battleHeroInfo do
			local battleHeroInfo = teamInfo.battleHeroInfo[j]

			if battleHeroInfo.heroId == heroId then
				return 1
			end
		end
	end

	return 0
end

function Act174GameMO:getCollectionEquipCnt(collectId)
	local count = 0

	for _, teamMo in ipairs(self.teamMoList) do
		for _, battleHeroMo in ipairs(teamMo.battleHeroInfo) do
			if battleHeroMo.itemId == collectId then
				count = count + 1
			end
		end
	end

	return count
end

function Act174GameMO:exchangeTempCollection(from, to)
	local tempInfos = self.fightInfo.tempInfo
	local tempInfoA = Activity174Helper.MatchKeyInArray(tempInfos, from, "index")
	local tempInfoB = Activity174Helper.MatchKeyInArray(tempInfos, to, "index")

	if tempInfoA and tempInfoB then
		tempInfoA.index = to
		tempInfoB.index = from
	end
end

function Act174GameMO:getTempCollectionId(row, column, isEnemy)
	if isEnemy then
		if not self.fightInfo.matchInfo.tempInfo then
			local tempInfos = self.fightInfo.tempInfo
			local tempInfo = Activity174Helper.MatchKeyInArray(tempInfos, row, "index")

			if tempInfo then
				return tempInfo.collectionId[column]
			end

			return 0
		end
	end
end

function Act174GameMO:getBetScore()
	local betScore = 0

	if not string.nilorempty(self.param) and string.find(self.param, "betScore") then
		local params = string.split(self.param, "#")
		local betParams = string.split(params[1], ":")

		betScore = tonumber(betParams[2])
	end

	return betScore
end

return Act174GameMO
