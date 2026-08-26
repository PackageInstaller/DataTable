-- chunkname: @modules/logic/rouge2/map/model/rpcmo/Rouge2_FightResultMO.lua

module("modules.logic.rouge2.map.model.rpcmo.Rouge2_FightResultMO", package.seeall)

local Rouge2_FightResultMO = pureTable("Rouge2_FightResultMO")

function Rouge2_FightResultMO:init(info)
	self.addCoin = info.addCoin
	self.dropCollectionNum = info.dropCollectionNum
	self.dropSelectNum = info.dropSelectNum
	self.addExp = info.addExp
	self.isWin = info.isWin
	self.retryNum = info.retryNum
	self.season = info.season

	Rouge2_Model.instance:updateRetryNum(self.retryNum)

	self.battleHeroList = {}

	for _, battleHero in ipairs(info.teamInfo.battleHeroList) do
		table.insert(self.battleHeroList, {
			index = battleHero.index,
			heroId = battleHero.heroId,
			equipUid = battleHero.equipUid,
			supportHeroId = battleHero.supportHeroId,
			supportHeroSkill = battleHero.supportHeroSkill
		})
	end

	self.heroLifeMap = {}

	for _, heroLife in ipairs(info.teamInfo.heroLifeList) do
		self.heroLifeMap[heroLife.heroId] = heroLife.life
	end
end

function Rouge2_FightResultMO:getLife(heroId)
	return self.heroLifeMap[heroId]
end

return Rouge2_FightResultMO
