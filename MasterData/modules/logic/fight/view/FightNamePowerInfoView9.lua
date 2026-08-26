-- chunkname: @modules/logic/fight/view/FightNamePowerInfoView9.lua

module("modules.logic.fight.view.FightNamePowerInfoView9", package.seeall)

local FightNamePowerInfoView9 = class("FightNamePowerInfoView9", FightBaseView)

function FightNamePowerInfoView9:onInitView()
	self.content = gohelper.findChild(self.viewGO, "#go_content")
	self.objItem = gohelper.findChild(self.viewGO, "epiitem")
end

function FightNamePowerInfoView9:addEvents()
	self:com_registFightEvent(FightEvent.PowerMaxChange, self.onPowerMaxChange)
end

function FightNamePowerInfoView9:removeEvents()
	return
end

function FightNamePowerInfoView9:onConstructor(entityId, powerInfo)
	self.entityId = entityId
	self.powerInfo = powerInfo

	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
end

function FightNamePowerInfoView9:onGetExPointView(entityId)
	if entityId == self.entityId then
		FightMsgMgr.replyMsg(FightMsgId.GetExPointView, self)
	end
end

function FightNamePowerInfoView9:onOpen()
	gohelper.setActive(self.objItem, false)

	self.itemList = {}

	self:createObjList()
end

function FightNamePowerInfoView9:createObjList()
	local max = self.powerInfo.max

	for i = 1, max do
		if not self.itemList[i] then
			local obj = gohelper.clone(self.objItem, self.content, i)

			self.itemList[i] = self:com_openSubView(FightNamePowerInfoView9Item, obj, self.content, i, self.entityId, self.powerInfo)
		end

		gohelper.setActive(self.itemList[i].viewGO, true)
	end

	for i = max + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].viewGO, false)
	end
end

function FightNamePowerInfoView9:onPowerMaxChange(entityId, powerId)
	if entityId ~= self.entityId then
		return
	end

	self:createObjList()
end

function FightNamePowerInfoView9:onClose()
	return
end

function FightNamePowerInfoView9:onDestroyView()
	return
end

return FightNamePowerInfoView9
