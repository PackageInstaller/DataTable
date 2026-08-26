-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyDungeonRewardView.lua

module("modules.logic.sp01.odyssey.view.OdysseyDungeonRewardView", package.seeall)

local OdysseyDungeonRewardView = class("OdysseyDungeonRewardView", BaseView)

function OdysseyDungeonRewardView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gotaskFinish = gohelper.findChild(self.viewGO, "root/#go_taskFinish")
	self._gotxtContent = gohelper.findChild(self.viewGO, "root/#go_taskFinish/#go_txtContent")
	self._goexpItem = gohelper.findChild(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_expItem")
	self._txtexp = gohelper.findChildText(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_expItem/#txt_exp")
	self._gotalentItem = gohelper.findChild(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_talentItem")
	self._txttalentItem = gohelper.findChildText(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_talentItem/#txt_talentItem")
	self._goitemContent = gohelper.findChild(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_itemContent")
	self._goitemIcon = gohelper.findChild(self.viewGO, "root/#go_taskFinish/#go_txtContent/#go_itemContent/#go_itemIcon")
	self._golevelUp = gohelper.findChild(self.viewGO, "root/#go_levelUp")
	self._txtcurLevel = gohelper.findChildText(self.viewGO, "root/#go_levelUp/curLevel/#txt_curLevel")
	self._txtlevelupTalentItem = gohelper.findChildText(self.viewGO, "root/#go_levelUp/levelupTalentItem/#txt_levelupTalentItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyDungeonRewardView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function OdysseyDungeonRewardView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function OdysseyDungeonRewardView:_btncloseOnClick()
	if not self.isAllShowFinish then
		if self.rewardShowFlow then
			local workList = self.rewardShowFlow:getWorkList()
			local curWork = workList[self.rewardShowFlow._curIndex]

			if curWork then
				curWork:onSetDone()
			end
		end

		return
	else
		self:closeThis()
	end
end

function OdysseyDungeonRewardView:_editableInitView()
	self.rewardItemTab = self:getUserDataTb_()
	self.rewardOuterItemTab = self:getUserDataTb_()

	gohelper.setActive(self._goitemIcon, false)
	gohelper.setActive(self._gotaskFinish, false)
	gohelper.setActive(self._golevelUp, false)

	self.showTime = 2
end

function OdysseyDungeonRewardView:onUpdateParam()
	return
end

function OdysseyDungeonRewardView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_receive_award)
	self:initShowRewardData()
	self:showContent()
end

function OdysseyDungeonRewardView:initShowRewardData()
	self.showAddItemList = {}

	local addItemList = self.viewParam.showAddItemList

	self.showAddOuterItemList = self.viewParam.showAddOuterItemList or {}
	self.heroCurLevel = self.viewParam.heroCurLevel
	self.heroCurExp = self.viewParam.heroCurExp
	self.heroOldLevel = self.viewParam.heroOldLevel
	self.levelAddTalentPoint = self.viewParam.levelAddTalentPoint
	self.rewardAddTalentPoint = self.viewParam.rewardAddTalentPoint
	self.addExp = self.viewParam.addExp

	for itemUid, itemMo in pairs(addItemList) do
		if itemMo.addCount > 0 then
			table.insert(self.showAddItemList, itemMo)
		end
	end
end

function OdysseyDungeonRewardView:showContent()
	self:refreshTxtContent()
	self:refreshItemContent()
	self:refreshLevelUpContent()

	local rewardItemType

	self.rewardShowFlow = FlowSequence.New()

	if self.addExp > 0 or self.rewardAddTalentPoint > 0 or #self.showAddItemList > 0 or #self.showAddOuterItemList > 0 then
		local canShowAddItemList = #self.showAddItemList > 0 or #self.showAddOuterItemList > 0

		self.rewardShowFlow:addWork(OdysseyShowRewardWork.New(self._gotaskFinish, 2, (self.rewardAddTalentPoint > 0 or nil) and OdysseyEnum.RewardItemType.Talent, canShowAddItemList))
		TaskDispatcher.cancelTask(self.showAddExpEffect, self)
		TaskDispatcher.runDelay(self.showAddExpEffect, self, 0.5)
	end

	if self.heroCurLevel ~= self.heroOldLevel then
		rewardItemType = OdysseyEnum.RewardItemType.Talent

		self.rewardShowFlow:addWork(OdysseyShowRewardWork.New(self._golevelUp, 1.5, OdysseyEnum.RewardItemType.Talent))
	end

	self.rewardShowFlow:registerDoneListener(self.allShowFinish, self)
	self.rewardShowFlow:start()
end

function OdysseyDungeonRewardView:showAddExpEffect()
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.ShowAddExpEffect)
end

function OdysseyDungeonRewardView:refreshTxtContent()
	gohelper.setActive(self._goexpItem, self.addExp > 0)

	self._txtexp.text = self.addExp > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_getexp"), self.addExp) or ""

	gohelper.setActive(self._gotalentItem, self.rewardAddTalentPoint > 0)

	self._txttalentItem.text = self.rewardAddTalentPoint > 0 and GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_gettalent"), self.rewardAddTalentPoint) or ""
end

function OdysseyDungeonRewardView:refreshItemContent()
	local allShowAddItemList = {}

	tabletool.addValues(allShowAddItemList, self.showAddOuterItemList)
	tabletool.addValues(allShowAddItemList, self.showAddItemList)

	for index, itemMo in ipairs(allShowAddItemList) do
		local rewardItem = self.rewardItemTab[index]

		if not rewardItem then
			rewardItem = {
				go = gohelper.clone(self._goitemIcon, self._goitemContent, "rewardItem_" .. index)
			}
			rewardItem.itemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], rewardItem.go)
			rewardItem.itemIcon = MonoHelper.addNoUpdateLuaComOnceToGo(rewardItem.itemGO, OdysseyItemIcon)
			self.rewardItemTab[index] = rewardItem
		end

		if itemMo.itemType == OdysseyEnum.RewardItemType.OuterItem then
			local dataParam = {
				type = tonumber(itemMo.type),
				id = tonumber(itemMo.id)
			}

			rewardItem.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.OuterItem, dataParam, tonumber(itemMo.addCount))
		else
			rewardItem.itemIcon:initRewardItemInfo(OdysseyEnum.RewardItemType.Item, tonumber(itemMo.id), tonumber(itemMo.addCount))
		end

		gohelper.setActive(rewardItem.go, true)
	end
end

function OdysseyDungeonRewardView:refreshLevelUpContent()
	self._txtcurLevel.text = self.heroCurLevel
	self._txtlevelupTalentItem.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("odyssey_reward_gettalent"), self.levelAddTalentPoint)
end

function OdysseyDungeonRewardView:allShowFinish()
	self.isAllShowFinish = true

	self:closeThis()
end

function OdysseyDungeonRewardView:onClose()
	OdysseyItemModel.instance:cleanAllAddCount()
	OdysseyTalentModel.instance:cleanChangeTalentPoint()

	if self.heroCurLevel ~= self.heroOldLevel then
		OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnRefreshHeroLevel)
	end

	OdysseyModel.instance:updateHeroOldLevel(self.heroCurLevel, self.heroCurExp)
	TaskDispatcher.cancelTask(self.showAddExpEffect, self)
	OdysseyDungeonController.instance:dispatchEvent(OdysseyEvent.OnCloseDungeonRewardView)
end

function OdysseyDungeonRewardView:onDestroyView()
	if self.rewardShowFlow then
		self.rewardShowFlow:destroy()

		self.rewardShowFlow = nil
	end
end

return OdysseyDungeonRewardView
