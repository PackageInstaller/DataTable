-- chunkname: @modules/logic/gm/work/GmUpgradeEquipAllToMax.lua

module("modules.logic.gm.work.GmUpgradeEquipAllToMax", package.seeall)

local GmUpgradeEquipAllToMax = class("GmUpgradeEquipAllToMax", BaseWork)

GmUpgradeEquipAllToMax.BlockKey = "send equip all to max msg ing"

function GmUpgradeEquipAllToMax:onStart()
	UIBlockMgr.instance:startBlock(GmUpgradeEquipAllToMax.BlockKey)

	self.equipList = EquipModel.instance:getEquips()
	self.curIndex = 0
	self.maxCount = #self.equipList

	local everySecondSendMsgCount = 50

	TaskDispatcher.runRepeat(self.senMsg, self, 1 / everySecondSendMsgCount)
end

function GmUpgradeEquipAllToMax:senMsg()
	self.curIndex = self.curIndex + 1

	local equipMo = self.equipList[self.curIndex]

	if not equipMo then
		return self:senMsgDone()
	end

	if not EquipHelper.isNormalEquip(equipMo.config) then
		return
	end

	local maxRefineLv = EquipConfig.instance:getEquipRefineLvMax()
	local maxLv = 60
	local msg = string.format("add equip %d#%d#%d", equipMo.equipId, maxLv, maxRefineLv)

	GMRpc.instance:sendGMRequest(msg)
	GameFacade.showToastString(string.format("心相全部拉满进度  %s / %s", self.curIndex, self.maxCount))
end

function GmUpgradeEquipAllToMax:senMsgDone()
	self:clearWork()
	self:onDone(true)
end

function GmUpgradeEquipAllToMax:clearWork()
	TaskDispatcher.cancelTask(self.senMsg, self)
	UIBlockMgr.instance:endBlock(GmUpgradeEquipAllToMax.BlockKey)
end

return GmUpgradeEquipAllToMax
