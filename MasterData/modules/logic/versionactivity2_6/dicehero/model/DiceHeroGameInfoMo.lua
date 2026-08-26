-- chunkname: @modules/logic/versionactivity2_6/dicehero/model/DiceHeroGameInfoMo.lua

module("modules.logic.versionactivity2_6.dicehero.model.DiceHeroGameInfoMo", package.seeall)

local DiceHeroGameInfoMo = pureTable("DiceHeroGameInfoMo")

function DiceHeroGameInfoMo:init(data)
	self.chapter = data.chapter
	self.heroBaseInfo = DiceHeroHeroBaseInfoMo.New()

	self.heroBaseInfo:init(data.heroBaseInfo)

	self.rewardItems = {}

	for k, v in pairs(data.panel.rewardItems) do
		self.rewardItems[k] = DiceHeroRewardMo.New()

		self.rewardItems[k]:init(v)
	end

	self.allLevelCos = DiceHeroConfig.instance:getLevelCos(self.chapter)

	local passLen = #data.passLevelIds

	self.co = self.allLevelCos[passLen + 1] or self.allLevelCos[passLen] or self.allLevelCos[1]

	if self.co then
		self.currLevel = self.co.id or 0
	end

	self.allPass = passLen == #self.allLevelCos
end

function DiceHeroGameInfoMo:hasReward()
	return #self.rewardItems > 0
end

return DiceHeroGameInfoMo
