-- chunkname: @modules/logic/gm/work/GmUpgradeAllHeroToMaxTalent.lua

module("modules.logic.gm.work.GmUpgradeAllHeroToMaxTalent", package.seeall)

local GmUpgradeAllHeroToMaxTalent = class("GmUpgradeAllHeroToMaxTalent", BaseWork)

GmUpgradeAllHeroToMaxTalent.BlockKey = "send max talent msg ing"

function GmUpgradeAllHeroToMaxTalent:onStart()
	UIBlockMgr.instance:startBlock(GmUpgradeAllHeroToMaxTalent.BlockKey)

	self.heroList = HeroModel.instance:getList()
	self.curIndex = 0
	self.maxCount = #self.heroList

	local everySecondSendMsgCount = 50

	TaskDispatcher.runRepeat(self.senMsg, self, 1 / everySecondSendMsgCount)
end

function GmUpgradeAllHeroToMaxTalent:senMsg()
	self.curIndex = self.curIndex + 1

	local heroMo = self.heroList[self.curIndex]

	if not heroMo then
		return self:senMsgDone()
	end

	local maxTalent = HeroResonanceConfig.instance:getHeroMaxTalentLv(heroMo.heroId)
	local msg = string.format("add heroAttr %d#%d#%d#%d#%d", heroMo.heroId, heroMo.level, 0, maxTalent, heroMo.exSkillLevel)

	GMRpc.instance:sendGMRequest(msg)
	GameFacade.showToastString(string.format("设置最大共鸣进度  %s / %s", self.curIndex, self.maxCount))
end

function GmUpgradeAllHeroToMaxTalent:senMsgDone()
	self:clearWork()
	self:onDone(true)
end

function GmUpgradeAllHeroToMaxTalent:clearWork()
	TaskDispatcher.cancelTask(self.senMsg, self)
	UIBlockMgr.instance:endBlock(GmUpgradeAllHeroToMaxTalent.BlockKey)
end

return GmUpgradeAllHeroToMaxTalent
