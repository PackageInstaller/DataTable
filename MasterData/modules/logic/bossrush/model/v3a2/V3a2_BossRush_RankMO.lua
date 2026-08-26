-- chunkname: @modules/logic/bossrush/model/v3a2/V3a2_BossRush_RankMO.lua

module("modules.logic.bossrush.model.v3a2.V3a2_BossRush_RankMO", package.seeall)

local V3a2_BossRush_RankMO = pureTable("V3a2_BossRush_RankMO")

function V3a2_BossRush_RankMO:initMO(config, preExp, needExp)
	self.config = config
	self.isNoraml = true
	self.playerLevel = config.playerLevel
	self.totalNeedExp = needExp
	self.preExp = preExp
end

function V3a2_BossRush_RankMO:setInfo(playerLevel, gainMilestoneLevel)
	self.finishClaim = gainMilestoneLevel >= self.config.playerLevel
	self.canClaim = not self.finishClaim and playerLevel >= self.config.playerLevel
end

function V3a2_BossRush_RankMO:onClaim(isFinish)
	self.finishClaim = isFinish
end

function V3a2_BossRush_RankMO:setLock(isShowNextLine, level)
	self.isNoraml = false
	self.isShowNextLine = isShowNextLine
	self.playerLevel = level
end

function V3a2_BossRush_RankMO:setPreRank(rank)
	self.preRank = rank
end

return V3a2_BossRush_RankMO
