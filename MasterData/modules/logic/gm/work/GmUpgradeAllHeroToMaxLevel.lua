-- chunkname: @modules/logic/gm/work/GmUpgradeAllHeroToMaxLevel.lua

module("modules.logic.gm.work.GmUpgradeAllHeroToMaxLevel", package.seeall)

local GmUpgradeAllHeroToMaxLevel = class("GmUpgradeAllHeroToMaxLevel", BaseWork)

GmUpgradeAllHeroToMaxLevel.BlockKey = "send max level msg ing"

function GmUpgradeAllHeroToMaxLevel:onStart()
	UIBlockMgr.instance:startBlock(GmUpgradeAllHeroToMaxLevel.BlockKey)

	self.heroList = HeroModel.instance:getList()
	self.curIndex = 0
	self.maxCount = #self.heroList

	local everySecondSendMsgCount = 50

	TaskDispatcher.runRepeat(self.senMsg, self, 1 / everySecondSendMsgCount)
end

function GmUpgradeAllHeroToMaxLevel:senMsg()
	self.curIndex = self.curIndex + 1

	local heroMo = self.heroList[self.curIndex]

	if not heroMo then
		return self:senMsgDone()
	end

	local maxLevel = GMController.instance:getHeroMaxLevel(heroMo.heroId)
	local msg = string.format("add heroAttr %d#%d#%d#%d#%d", heroMo.heroId, maxLevel, 0, heroMo.talent, heroMo.exSkillLevel)

	GMRpc.instance:sendGMRequest(msg)
	GameFacade.showToastString(string.format("设置最大等级进度  %s / %s", self.curIndex, self.maxCount))
end

function GmUpgradeAllHeroToMaxLevel:senMsgDone()
	self:clearWork()
	self:onDone(true)
end

function GmUpgradeAllHeroToMaxLevel:clearWork()
	TaskDispatcher.cancelTask(self.senMsg, self)
	UIBlockMgr.instance:endBlock(GmUpgradeAllHeroToMaxLevel.BlockKey)
end

return GmUpgradeAllHeroToMaxLevel
