-- chunkname: @modules/logic/fight/view/expoint/FightExpointClueView.lua

module("modules.logic.fight.view.expoint.FightExpointClueView", package.seeall)

local FightExpointClueView = class("FightExpointClueView", FightBaseView)

FightExpointClueView.ItemSpacingX = 20

function FightExpointClueView:onConstructor(entityMo)
	self.entityMo = entityMo
	self.entityId = entityMo.id

	self:com_registMsg(FightMsgId.GetExPointView, self.onGetExPointView)
	self:com_registEvent(FightController.instance, FightEvent.OnPlayHandCard, self.onPlayHandCard)
end

function FightExpointClueView:onInitView()
	self.goContainer = gohelper.findChild(self.viewGO, "expointContainer/fight_specialpassionpoint")
	self.goDownTemplate = gohelper.findChild(self.viewGO, "expointContainer/fight_specialpassionpoint/down")
	self.goUpTemplate = gohelper.findChild(self.viewGO, "expointContainer/fight_specialpassionpoint/up")
end

function FightExpointClueView:addEvents()
	return
end

function FightExpointClueView:removeEvents()
	return
end

function FightExpointClueView:onGetExPointView(entityId)
	if entityId == self.entityId then
		self.com_replyMsg(self, FightMsgId.GetExPointView, self)
	end
end

function FightExpointClueView:onOpen()
	recthelper.setAnchor(self.viewGO.transform, 0, 4)
	gohelper.setActive(self.goDownTemplate, false)
	gohelper.setActive(self.goUpTemplate, false)

	self.itemList = {}

	self.addEventCb(self, FightController.instance, FightEvent.OnExpointMaxAdd, self.onExPointMaxAdd, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnExPointChange, self.onExPointChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.StageChanged, self.onStageChange, self)
	self.addEventCb(self, FightController.instance, FightEvent.CancelOperation, self.onCancelPreDeduction, self)
	self.addEventCb(self, FightController.instance, FightEvent.OnResetCard, self.onCancelPreDeduction, self)
	self:createObjList()
end

function FightExpointClueView:createObjList()
	local max = self.entityMo:getMaxExPoint()

	for i = 1, max do
		self.itemList[i] = self.itemList[i] or self:createItem(i)

		gohelper.setActive(self.itemList[i].go, true)
	end

	for i = max + 1, #self.itemList do
		gohelper.setActive(self.itemList[i].go, false)
	end

	self:refreshClueEnergy()
end

function FightExpointClueView:createItem(index)
	if index % 2 == 1 then
		if not self.goDownTemplate then
			local template = self.goUpTemplate
			local go = gohelper.clone(template, self.goContainer, index)

			transformhelper.setLocalPos(go.transform, (index - 1) * FightExpointClueView.ItemSpacingX, 0, 0)

			return {
				go = go,
				animator = go:GetComponent(gohelper.Type_Animator)
			}
		end
	end
end

function FightExpointClueView:onExPointMaxAdd(entityId)
	if entityId ~= self.entityId then
		return
	end

	self:createObjList()
end

function FightExpointClueView:onExPointChange(entityId, oldValue, newValue)
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
				item.animator:Play("get", 0, 0)
			end
		end
	else
		for i = newValue + 1, oldValue do
			local item = self.itemList[i]

			if item then
				item.animator:Play("use", 0, 0)
			end
		end
	end
end

function FightExpointClueView:onPlayHandCard(cardMo)
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	if cardMo.uid ~= self.entityId then
		return
	end

	self:refreshPreDeduction()
end

function FightExpointClueView:onStageChange()
	self:refreshClueEnergy()
end

function FightExpointClueView:onCancelPreDeduction()
	self:refreshPreDeduction()
end

function FightExpointClueView:refreshClueEnergy()
	local cur = self.entityMo:getExPoint()
	local max = self.entityMo:getMaxExPoint()

	for i = 1, max do
		local item = self.itemList[i]

		if item then
			if i <= cur then
				item.animator:Play("get", 0, 1)
			else
				item.animator:Play("in", 0, 1)
			end
		end
	end
end

function FightExpointClueView:refreshPreDeduction()
	local cur = self.entityMo:getExPoint()
	local max = self.entityMo:getMaxExPoint()
	local preDeduct = math.min(self:getPreDeductClueCount(), cur)
	local keepLit = cur - preDeduct

	for i = 1, max do
		local item = self.itemList[i]

		if item then
			if i <= keepLit then
				item.animator:Play("get", 0, 1)
			elseif i <= cur then
				item.animator:Play("canuse", 0, 0)
			else
				item.animator:Play("in", 0, 1)
			end
		end
	end
end

function FightExpointClueView:getPreDeductClueCount()
	local total = 0
	local ops = FightDataHelper.operationDataMgr:getEntityOps(self.entityId, FightEnum.CardOpType.PlayCard)

	for _, op in ipairs(ops) do
		total = total + self:getSkillDelClueExPoint(op.skillId)
	end

	return total
end

function FightExpointClueView:getSkillDelClueExPoint(skillId)
	local skillCo = lua_skill.configDict[skillId]

	if not skillCo then
		return 0
	end

	local delCount = 0
	local behaviourId = FightEnum.BehaviourId.DelClueExPoint

	for i = 1, FightEnum.MaxBehavior do
		local behavior = skillCo["behavior" .. i]

		if not string.nilorempty(behavior) then
			local array = FightStrUtil.instance:getSplitString2Cache(behavior, true)

			for _, behaviourArray in ipairs(array) do
				if behaviourArray[1] == behaviourId then
					delCount = delCount + behaviourArray[2]
				end
			end
		end
	end

	return delCount
end

function FightExpointClueView:onClose()
	return
end

function FightExpointClueView:onDestroyView()
	self.itemList = nil
end

return FightExpointClueView
