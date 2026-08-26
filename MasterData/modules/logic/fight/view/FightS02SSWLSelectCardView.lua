-- chunkname: @modules/logic/fight/view/FightS02SSWLSelectCardView.lua

module("modules.logic.fight.view.FightS02SSWLSelectCardView", package.seeall)

local FightS02SSWLSelectCardView = class("FightS02SSWLSelectCardView", BaseView)

function FightS02SSWLSelectCardView:onInitView()
	self.goCardItem = gohelper.findChild(self.viewGO, "#scroll_handcards/Viewport/handcards/#go_item")
	self.txtSkillName = gohelper.findChildText(self.viewGO, "CheckPoint/#txt_skillname")
	self.txtSkillDesc = gohelper.findChildText(self.viewGO, "CheckPoint/Scroll View/Viewport/#txt_skilldesc")
	self.txtSelectCount = gohelper.findChildText(self.viewGO, "txtbg/#txt_selectcount")
	self.sendBtn = gohelper.findChildButton(self.viewGO, "#btn_send")

	gohelper.setActive(self.goCardItem, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightS02SSWLSelectCardView:addEvents()
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self.closeThis, self, LuaEventSystem.High)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self.closeThis, self, LuaEventSystem.High)
end

function FightS02SSWLSelectCardView:removeEvents()
	return
end

function FightS02SSWLSelectCardView:onClickSendBtn()
	local selectCount = #self.selectedIndexList

	if selectCount < self.selectCount then
		return
	end

	AudioMgr.instance:trigger(385029)

	local value = FightHelper.buildSSWLSelectedValue(self.selectedIndexList)

	FightRpc.instance:sendUseClothSkillRequest(0, self.entityId, value, FightEnum.ClothSkillType.TwinsSelect)
end

function FightS02SSWLSelectCardView.blockEsc()
	return
end

function FightS02SSWLSelectCardView:_editableInitView()
	self.sendBtn:AddClickListener(self.onClickSendBtn, self)

	self.sendBtnAnimator = gohelper.findChildComponent(self.viewGO, "#btn_send", gohelper.Type_Animator)
	self.cardItemList = {}
	self.selectedIndexList = {}
end

function FightS02SSWLSelectCardView:refreshSendBtnAnimator()
	if self.sendBtnAnimator then
		if #self.selectedIndexList >= self.selectCount then
			self.sendBtnAnimator:Play("unlock")
		else
			self.sendBtnAnimator:Play("lock")
		end
	end
end

function FightS02SSWLSelectCardView:onOpen()
	AudioMgr.instance:trigger(385027)
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)

	self.entityId = self.viewParam.entityId

	local paramList = self.viewParam.paramList

	self.selectCount = paramList[2]
	self.selectSkillList = {}

	for i = 3, #paramList do
		table.insert(self.selectSkillList, paramList[i])
	end

	self:refreshCardItemList()
	self:updateSelectFrame()
	self:refreshSelectCount()
	self:refreshSendBtnAnimator()
	self:refreshSelectSkillDesc()
end

function FightS02SSWLSelectCardView:refreshSelectSkillDesc()
	if not self.selectedIndexList[1] then
		local selectedIndex = 0

		if selectedIndex < 1 then
			self.txtSkillName.text = ""
			self.txtSkillDesc.text = ""
		else
			local skillId = self.selectSkillList[selectedIndex]
			local skillCo = skillId and lua_skill.configDict[skillId]

			if not skillCo then
				self.txtSkillName.text = ""
				self.txtSkillDesc.text = ""

				logError("skill id not exist : " .. tostring(skillId))

				return
			end

			self.txtSkillName.text = skillCo.name
			self.txtSkillDesc.text = SkillHelper.getSkillDesc(nil, skillCo)
		end
	end
end

function FightS02SSWLSelectCardView:refreshCardItemList()
	for index, skillId in ipairs(self.selectSkillList) do
		local cardItem = self.cardItemList[index]

		cardItem = cardItem or self:createCardItem()
		cardItem.index = index

		cardItem.cardItem:updateItem(self.entityId, skillId)
		gohelper.setActive(cardItem.cardParentGo, true)
	end

	for i = #self.selectSkillList + 1, #self.cardItemList do
		local cardItem = self.cardItemList[i]

		if cardItem then
			gohelper.setActive(cardItem.cardParentGo, false)
		end
	end
end

function FightS02SSWLSelectCardView:updateSelectFrame()
	for index, cardItem in ipairs(self.cardItemList) do
		gohelper.setActive(cardItem.selectedGo, tabletool.indexOf(self.selectedIndexList, index))
	end
end

function FightS02SSWLSelectCardView:createCardItem()
	local cardItem = self:getUserDataTb_()

	cardItem.cardParentGo = gohelper.cloneInPlace(self.goCardItem)
	cardItem.cardInnerGo = gohelper.findChild(cardItem.cardParentGo, "#go_carditem")
	cardItem.selectedGo = gohelper.findChild(cardItem.cardParentGo, "#go_Frame")

	gohelper.setActive(cardItem.selectedGo, false)

	local path = self.viewContainer:getSetting().otherRes[1]
	local cardGo = self.viewContainer:getResInst(path, cardItem.cardInnerGo, "cardItem")

	cardItem.cardItem = MonoHelper.addNoUpdateLuaComOnceToGo(cardGo, FightViewCardItem)

	table.insert(self.cardItemList, cardItem)

	local click = gohelper.getClick(cardItem.cardParentGo)

	self.addClickCb(self, click, self.onClickCardItem, self, cardItem)

	return cardItem
end

function FightS02SSWLSelectCardView:onClickCardItem(cardItem)
	local index = cardItem.index
	local existPos = tabletool.indexOf(self.selectedIndexList, index)

	if existPos then
		table.remove(self.selectedIndexList, existPos)
	else
		if #self.selectedIndexList >= self.selectCount then
			table.remove(self.selectedIndexList, 1)
		end

		table.insert(self.selectedIndexList, index)
		AudioMgr.instance:trigger(385028)
	end

	self:updateSelectFrame()
	self:refreshSelectCount()
	self:refreshSendBtnAnimator()
	self:refreshSelectSkillDesc()
end

function FightS02SSWLSelectCardView:refreshSelectCount()
	local selectCount = #self.selectedIndexList

	self.txtSelectCount.text = string.format("%s/%s", selectCount, self.selectCount)
end

function FightS02SSWLSelectCardView:onClose()
	return
end

function FightS02SSWLSelectCardView:onDestroyView()
	if self.sendBtn then
		self.sendBtn:RemoveClickListener()

		self.sendBtn = nil
	end
end

return FightS02SSWLSelectCardView
