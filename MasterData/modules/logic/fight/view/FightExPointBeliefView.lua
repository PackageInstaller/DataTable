-- chunkname: @modules/logic/fight/view/FightExPointBeliefView.lua

module("modules.logic.fight.view.FightExPointBeliefView", package.seeall)

local FightExPointBeliefView = class("FightExPointBeliefView", FightBaseView)

function FightExPointBeliefView:onConstructor(entityData)
	self.entityData = entityData
	self.entityId = entityData.id
end

function FightExPointBeliefView:onInitView()
	self.root1 = gohelper.findChild(self.viewGO, "expointContainer/exPointLine1")
	self.root2 = gohelper.findChild(self.viewGO, "expointContainer/exPointLine2")
	self.objItem = gohelper.findChild(self.viewGO, "expointContainer/#go_pointItem")
end

function FightExPointBeliefView:addEvents()
	self:com_registFightEvent(FightEvent.OnExpointMaxAdd, self.onExPointMaxAdd)
end

function FightExPointBeliefView:removeEvents()
	return
end

function FightExPointBeliefView:onGetExPointView(entityId)
	if entityId == self.entityId then
		self.com_replyMsg(self, FightMsgId.GetExPointView, self)
	end
end

function FightExPointBeliefView:onOpen()
	gohelper.setActive(self.objItem, false)

	self.itemList = {}

	self:createObjList()
end

function FightExPointBeliefView:createObjList()
	local max = self.entityData:getMaxExPoint()

	for i = 1, max do
		if not self.itemList[i] then
			if i <= 4 then
				if not self.root1 then
					local parentGO = self.root2
					local obj = gohelper.clone(self.objItem, parentGO, i)

					self.itemList[i] = self:com_openSubView(FightExPointBeliefItemView, obj, parentGO, i, self.entityData)
				end
			end
		end

		gohelper.setActive(self.itemList[i].viewGO, true)
	end

	for i = max + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].viewGO, false)
	end
end

function FightExPointBeliefView:onExPointMaxAdd(entityId, offsetNum)
	if entityId ~= self.entityId then
		return
	end

	self:createObjList()
end

function FightExPointBeliefView:onClose()
	return
end

function FightExPointBeliefView:onDestroyView()
	return
end

return FightExPointBeliefView
