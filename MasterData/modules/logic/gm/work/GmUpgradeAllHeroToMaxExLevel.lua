-- chunkname: @modules/logic/gm/work/GmUpgradeAllHeroToMaxExLevel.lua

module("modules.logic.gm.work.GmUpgradeAllHeroToMaxExLevel", package.seeall)

local GmUpgradeAllHeroToMaxExLevel = class("GmUpgradeAllHeroToMaxExLevel", BaseWork)

GmUpgradeAllHeroToMaxExLevel.BlockKey = "send max ex level msg ing"

function GmUpgradeAllHeroToMaxExLevel:onStart()
	UIBlockMgr.instance:startBlock(GmUpgradeAllHeroToMaxExLevel.BlockKey)

	self.heroList = HeroModel.instance:getList()
	self.curIndex = 0
	self.maxCount = #self.heroList

	local everySecondSendMsgCount = 50

	TaskDispatcher.runRepeat(self.senMsg, self, 1 / everySecondSendMsgCount)
end

function GmUpgradeAllHeroToMaxExLevel:senMsg()
	self.curIndex = self.curIndex + 1

	local heroMo = self.heroList[self.curIndex]

	if not heroMo then
		return self:senMsgDone()
	end

	local msg = string.format("add heroAttr %d#%d#%d#%d#%d", heroMo.heroId, heroMo.level, 0, heroMo.talent, 5)

	GMRpc.instance:sendGMRequest(msg)
	GameFacade.showToastString(string.format("设置最大塑造进度  %s / %s", self.curIndex, self.maxCount))
end

function GmUpgradeAllHeroToMaxExLevel:senMsgDone()
	self:clearWork()
	self:onDone(true)
end

function GmUpgradeAllHeroToMaxExLevel:clearWork()
	TaskDispatcher.cancelTask(self.senMsg, self)
	UIBlockMgr.instance:endBlock(GmUpgradeAllHeroToMaxExLevel.BlockKey)
end

return GmUpgradeAllHeroToMaxExLevel
