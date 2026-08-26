-- chunkname: @modules/logic/gm/work/GmUpgradeAllHeroAllToMax.lua

module("modules.logic.gm.work.GmUpgradeAllHeroAllToMax", package.seeall)

local GmUpgradeAllHeroAllToMax = class("GmUpgradeAllHeroAllToMax", BaseWork)

GmUpgradeAllHeroAllToMax.BlockKey = "send all to max msg ing"

function GmUpgradeAllHeroAllToMax:onStart()
	UIBlockMgr.instance:startBlock(GmUpgradeAllHeroAllToMax.BlockKey)

	self.heroList = HeroModel.instance:getList()
	self.curIndex = 0
	self.maxCount = #self.heroList

	local everySecondSendMsgCount = 50

	TaskDispatcher.runRepeat(self.senMsg, self, 1 / everySecondSendMsgCount)
end

function GmUpgradeAllHeroAllToMax:senMsg()
	self.curIndex = self.curIndex + 1

	local heroMo = self.heroList[self.curIndex]

	if not heroMo then
		return self:senMsgDone()
	end

	local maxTalent = HeroResonanceConfig.instance:getHeroMaxTalentLv(heroMo.heroId)
	local maxLevel = GMController.instance:getHeroMaxLevel(heroMo.heroId)
	local msg = string.format("add heroAttr %d#%d#%d#%d#%d", heroMo.heroId, maxLevel, 0, maxTalent, 5)

	GMRpc.instance:sendGMRequest(msg)
	GameFacade.showToastString(string.format("全部拉满进度  %s / %s", self.curIndex, self.maxCount))
end

function GmUpgradeAllHeroAllToMax:senMsgDone()
	self:clearWork()
	self:onDone(true)
end

function GmUpgradeAllHeroAllToMax:clearWork()
	TaskDispatcher.cancelTask(self.senMsg, self)
	UIBlockMgr.instance:endBlock(GmUpgradeAllHeroAllToMax.BlockKey)
end

return GmUpgradeAllHeroAllToMax
