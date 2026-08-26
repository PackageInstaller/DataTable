-- chunkname: @modules/logic/fight/view/expoint/FightExPointAdrenalineView.lua

module("modules.logic.fight.view.expoint.FightExPointAdrenalineView", package.seeall)

local FightExPointAdrenalineView = class("FightExPointAdrenalineView", FightBaseView)

function FightExPointAdrenalineView:onConstructor(entityMo)
	self.entityMo = entityMo
	self.entityId = entityMo.id
end

FightExPointAdrenalineView.AnchorX = 31.3
FightExPointAdrenalineView.AnchorY = -21.8

function FightExPointAdrenalineView:onInitView()
	local transform = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	recthelper.setAnchor(transform, FightExPointAdrenalineView.AnchorX, FightExPointAdrenalineView.AnchorY)

	self.itemGo = gohelper.findChild(self.viewGO, "epiitem")

	gohelper.setActive(self.itemGo, false)

	self.itemList = {}
	self.playingAnimItemList = {}
	self.clientAddAdrenaline = 0
end

function FightExPointAdrenalineView:addEvents()
	return
end

function FightExPointAdrenalineView:removeEvents()
	return
end

function FightExPointAdrenalineView:onOpen()
	self.addEventCb(self, FightController.instance, FightEvent.OnExpointMaxAdd, self.onExPointMaxAdd, self)
	self.addEventCb(self, FightController.instance, FightEvent.UpdateExPoint, self.clientUpdateExPoint, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExPointChange, self.onServerExPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onResetCard, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self:refreshAdrenaline()
end

function FightExPointAdrenalineView:onExPointMaxAdd(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshAdrenaline()
end

function FightExPointAdrenalineView:clientUpdateExPoint(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:refreshAdrenaline()
end

function FightExPointAdrenalineView:onStageChange()
	self.clientAddAdrenaline = 0

	self:refreshAdrenaline()
end

function FightExPointAdrenalineView:onResetCard()
	self.clientAddAdrenaline = 0

	self:refreshAdrenaline()
end

function FightExPointAdrenalineView:onPlayHandCard(cardMo)
	local curStage = FightDataHelper.stageMgr:getCurStage()

	if curStage ~= FightStageMgr.StageType.Operate then
		return
	end

	if cardMo.uid ~= self.entityId then
		return
	end

	local skillCo = lua_skill.configDict[cardMo.skillId]

	if not skillCo then
		return
	end

	local behaviourId = FightEnum.BehaviourId.AddAdrenaline

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					self.clientAddAdrenaline = self.clientAddAdrenaline + behaviourArray[2]
				end
			end
		end
	end

	local max = self.entityMo:getMaxExPoint()
	local curAdrenaline = self:getCurAdrenaline()

	max = math.min(max, curAdrenaline + self.clientAddAdrenaline)

	for i = curAdrenaline + 1, max do
		local item = self.itemList[i]

		if item then
			item:setActive(true)
			item:playAnim("add_loop")
		end
	end
end

function FightExPointAdrenalineView:onServerExPointChange(entityId, oldValue, newValue)
	if entityId ~= self.entityId then
		return
	end

	if oldValue == newValue then
		return
	end

	if oldValue < newValue then
		for i = oldValue + 1, newValue do
			local item = self.itemList[i]

			if item then
				item:playAnim("open")
			end
		end
	else
		for i = newValue + 1, oldValue do
			local item = self.itemList[i]

			if item then
				item:playAnim("close")
			end
		end
	end
end

function FightExPointAdrenalineView:getCurAdrenaline()
	return self.entityMo.exPoint
end

function FightExPointAdrenalineView:refreshAdrenaline()
	local max = self.entityMo:getMaxExPoint()
	local curAdrenaline = self:getCurAdrenaline()

	for i = 1, max do
		local item = self.itemList[i]

		item = item or self:createItem()

		item:setActive(true)
		item:refresh(i, i <= curAdrenaline)
	end

	for i = max + 1, #self.itemList do
		local item = self.itemList[i]

		item:setActive(false)
	end
end

function FightExPointAdrenalineView:createItem()
	local item = FightExPointAdrenalineItem.New()

	item:init(gohelper.cloneInPlace(self.itemGo))
	table.insert(self.itemList, item)

	return item
end

function FightExPointAdrenalineView:onClose()
	return
end

function FightExPointAdrenalineView:onDestroyView()
	self.itemList = nil
end

return FightExPointAdrenalineView
