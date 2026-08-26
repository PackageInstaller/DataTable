-- chunkname: @modules/logic/rouge/map/model/rpcmo/RougeFightResultMO.lua

module("modules.logic.rouge.map.model.rpcmo.RougeFightResultMO", package.seeall)

local RougeFightResultMO = pureTable("RougeFightResultMO")

function RougeFightResultMO:init(info)
	self.addCoin = info.addCoin
	self.dropCollectionNum = info.dropCollectionNum
	self.dropSelectNum = info.dropSelectNum
	self.addExp = info.addExp
	self.isWin = info.isWin
	self.retryNum = info.retryNum
	self.season = info.season

	RougeModel.instance:updateRetryNum(self.retryNum)

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

function RougeFightResultMO:getLife(heroId)
	return self.heroLifeMap[heroId]
end

return RougeFightResultMO
