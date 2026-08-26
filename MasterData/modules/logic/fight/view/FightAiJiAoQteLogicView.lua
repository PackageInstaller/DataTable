-- chunkname: @modules/logic/fight/view/FightAiJiAoQteLogicView.lua

module("modules.logic.fight.view.FightAiJiAoQteLogicView", package.seeall)

local FightAiJiAoQteLogicView = class("FightAiJiAoQteLogicView", FightBaseView)

function FightAiJiAoQteLogicView:onInitView()
	self.bowRoot = gohelper.findChild(self.viewGO, "root/bow")
	self.axeRoot = gohelper.findChild(self.viewGO, "root/axe")
	self.bowAnimator = gohelper.onceAddComponent(self.bowRoot, typeof(UnityEngine.Animator))
	self.axeAnimator = gohelper.onceAddComponent(self.axeRoot, typeof(UnityEngine.Animator))
	self.btnAxe = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/axe/btnAxe")
	self.btnBow = gohelper.findChildClickWithDefaultAudio(self.viewGO, "root/bow/btnBow")
	self.pointRoot = gohelper.findChild(self.viewGO, "root/qte")
	self.pointObj = gohelper.findChild(self.viewGO, "root/qte/go_point")
	self.axeUpRoot = gohelper.findChild(self.viewGO, "root/axe/normal/go_canSelect")
	self.bowUpRoot = gohelper.findChild(self.viewGO, "root/bow/normal/go_canSelect")
	self.bowClickEffect = gohelper.findChild(self.viewGO, "root/bowClickEffect")
	self.axeClickEffect = gohelper.findChild(self.viewGO, "root/axeClickEffect")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightAiJiAoQteLogicView:addEvents()
	self:com_registClick(self.btnAxe, self.onAxeClick)
	self:com_registClick(self.btnBow, self.onBowClick)
	self:com_registFightEvent(FightEvent.SetAutoState, self.onSetAutoState)
end

function FightAiJiAoQteLogicView:removeEvents()
	return
end

function FightAiJiAoQteLogicView:onBowClick()
	self:clickBtn(1)
end

function FightAiJiAoQteLogicView:onAxeClick()
	self:clickBtn(2)
end

function FightAiJiAoQteLogicView:clickBtn(selectType)
	if self.clicked then
		return
	end

	AudioMgr.instance:trigger(20305035)

	self.clicked = true

	FightRpc.instance:sendUseClothSkillRequest(selectType, self.fromId, self.toId, FightEnum.ClothSkillType.EzioBigSkill)

	local speed = FightModel.instance:getUISpeed()

	if selectType == 1 then
		if not self.bowAnimator then
			local animator = self.axeAnimator

			animator.speed = speed

			animator:Play("click")
			gohelper.setActive(self.bowClickEffect, selectType == 1)
			gohelper.setActive(self.axeClickEffect, selectType == 2)

			if self.objItem then
				local itemAnimator = gohelper.onceAddComponent(self.objItem, typeof(UnityEngine.Animator))

				itemAnimator.speed = speed

				itemAnimator:Play("close")
			end

			local flow = self:com_registFlowSequence()

			flow:registWork(FightWorkPlayAnimator, self.viewGO, "close", speed)
			flow:registWork(FightWorkFunction, self.afterCloseAni, self, selectType)
			flow:start()
		end
	end
end

function FightAiJiAoQteLogicView:afterCloseAni()
	self.PARENT_VIEW:closeThis()
end

function FightAiJiAoQteLogicView:onSetAutoState(isAuto)
	if isAuto then
		self:checkAuto()
	end
end

function FightAiJiAoQteLogicView:checkAuto()
	local aiJiAoAutoSequenceForGM = FightDataModel.instance.aiJiAoAutoSequenceForGM

	if aiJiAoAutoSequenceForGM then
		local autoSequence = aiJiAoAutoSequenceForGM.autoSequence

		if autoSequence and #autoSequence > 0 then
			local index = aiJiAoAutoSequenceForGM.index + 1

			if not autoSequence[index] then
				index = 1
			end

			aiJiAoAutoSequenceForGM.index = index

			local selectType = autoSequence[index]

			self:clickBtn(selectType)

			return
		end
	end

	local toId = self.toId
	local entityData = FightDataHelper.entityMgr:getById(toId)

	if entityData then
		local curHp = entityData.currentHp
		local maxHp = entityData.attrMO.hp

		if curHp / maxHp >= 0.5 then
			self:clickBtn(2)
		else
			self:clickBtn(1)
		end
	end
end

function FightAiJiAoQteLogicView:onConstructor(fromId, toId)
	self.fromId = fromId
	self.toId = toId
end

function FightAiJiAoQteLogicView:onOpen()
	if not FightDataHelper.tempMgr.aiJiAoQteCount then
		local count = 0

		count = FightDataHelper.tempMgr.aiJiAoQteCount + 2
		self.objItem = nil

		self:com_createObjList(self.onItemShow, FightDataHelper.tempMgr.aiJiAoQteCount, self.pointRoot, self.pointObj)

		local toId = self.toId
		local entityData = FightDataHelper.entityMgr:getById(toId)

		if entityData then
			local curHp = entityData.currentHp
			local maxHp = entityData.attrMO.hp
			local useAxe = curHp / maxHp >= 0.5

			gohelper.setActive(self.bowUpRoot, not useAxe)
			gohelper.setActive(self.axeUpRoot, useAxe)
		end

		if FightDataHelper.stateMgr:getIsAuto() then
			self:checkAuto()
		end
	end
end

function FightAiJiAoQteLogicView:onItemShow(obj, data, index)
	if index > 2 then
		self.objItem = obj
	end
end

function FightAiJiAoQteLogicView:onClose()
	return
end

function FightAiJiAoQteLogicView:onDestroyView()
	return
end

return FightAiJiAoQteLogicView
