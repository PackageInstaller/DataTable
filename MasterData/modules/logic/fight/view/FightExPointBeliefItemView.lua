-- chunkname: @modules/logic/fight/view/FightExPointBeliefItemView.lua

module("modules.logic.fight.view.FightExPointBeliefItemView", package.seeall)

local FightExPointBeliefItemView = class("FightExPointBeliefItemView", FightBaseView)

function FightExPointBeliefItemView:onConstructor(index, entityData)
	self.index = index
	self.entityData = entityData
	self.entityId = entityData.id

	local num = (index - 1) % 8 + 1

	self.bgName = string.format("fight_nuodika_fuwen_%d_0", num)
	self.pointName = string.format("fight_nuodika_fuwen_%d_1", num)
end

function FightExPointBeliefItemView:onInitView()
	self.bg = gohelper.findChildImage(self.viewGO, "empty")
	self.point = gohelper.findChildImage(self.viewGO, "full")

	UISpriteSetMgr.instance:setFightSprite(self.bg, self.bgName)
	UISpriteSetMgr.instance:setFightSprite(self.point, self.pointName)

	self.ani = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Animator))
end

function FightExPointBeliefItemView:addEvents()
	self:com_registFightEvent(FightEvent.OnExPointChange, self.onExPointChange)
	self:com_registFightEvent(FightEvent.UpdateExPoint, self.onUpdateExPoint)
	self:com_registFightEvent(FightEvent.AddPlayOperationData, self.onAddPlayOperationData)
	self:com_registFightEvent(FightEvent.CancelOperation, self.onOpen)
	self:com_registFightEvent(FightEvent.StageChanged, self.onOpen)
end

function FightExPointBeliefItemView:removeEvents()
	return
end

function FightExPointBeliefItemView:onOpen()
	gohelper.setActive(self.point, self.index <= self.entityData.exPoint)
	self.ani:Play("idle", 0, 0)
end

function FightExPointBeliefItemView:onAddPlayOperationData(operationData)
	if operationData:isPlayCard() then
		local cardData = operationData.cardData

		if cardData.uid == self.entityId and FightCardDataHelper.isBigSkill(cardData.skillId) then
			self.ani:Play("loop", 0, 0)
		end
	end
end

function FightExPointBeliefItemView:onExPointChange(entityId, oldNum, newNum)
	if entityId ~= self.entityId then
		return
	end

	gohelper.setActive(self.point, newNum >= self.index)

	if oldNum ~= newNum then
		if oldNum < newNum then
			if oldNum < self.index and newNum >= self.index then
				self.ani:Play("add", 0, 0)
			end
		elseif newNum < self.index and oldNum >= self.index then
			self.ani:Play("close", 0, 0)
		end
	end
end

function FightExPointBeliefItemView:onUpdateExPoint(entityId, oldNum, newNum)
	if entityId ~= self.entityId then
		return
	end

	gohelper.setActive(self.point, self.index <= self.entityData.exPoint)
end

function FightExPointBeliefItemView:onClose()
	return
end

function FightExPointBeliefItemView:onDestroyView()
	return
end

return FightExPointBeliefItemView
