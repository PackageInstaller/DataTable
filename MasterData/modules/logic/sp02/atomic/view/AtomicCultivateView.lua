-- chunkname: @modules/logic/sp02/atomic/view/AtomicCultivateView.lua

module("modules.logic.sp02.atomic.view.AtomicCultivateView", package.seeall)

local AtomicCultivateView = class("AtomicCultivateView", BaseView)

function AtomicCultivateView:onInitView()
	self.txtCurrency = gohelper.findChildTextMesh(self.viewGO, "root/module1/proplayout/propnumbg/#txt_propnum")
	self.txtCurrencyInfo = gohelper.findChildTextMesh(self.viewGO, "root/module1/proplayout/infotxt")
	self.goBranchItem = gohelper.findChild(self.viewGO, "root/module2/scroll_list/viewport/content/#go_item")

	gohelper.setActive(self.goBranchItem, false)

	self.goSkillLineList = gohelper.findChild(self.viewGO, "root/module4/scroll_skilllist/viewport/content/#go_list")

	gohelper.setActive(self.goSkillLineList, false)

	self.btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/module4/#btn_reset", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "root/module5/titlebg/#txt_title")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/module5/layout/scroll_desc/viewport/#txt_desc")
	self.imgVideo = gohelper.findChildImage(self.viewGO, "root/module5/layout/#go_video")
	self.btnUnlock = gohelper.findChildButtonWithAudio(self.viewGO, "root/module5/btn/#btn_unlock", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.goUnlockTips = gohelper.findChild(self.viewGO, "root/module5/btn/#btn_unlock/unlocktips")
	self.txtPropnum = gohelper.findChildTextMesh(self.viewGO, "root/module5/btn/#btn_unlock/unlocktips/prop/#txt_propnum")
	self.txtPropName = gohelper.findChildTextMesh(self.viewGO, "root/module5/btn/#btn_unlock/unlocktips/txt_1")
	self.btnInstall = gohelper.findChildButtonWithAudio(self.viewGO, "root/module5/btn/#btn_install", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.btnRmove = gohelper.findChildButtonWithAudio(self.viewGO, "root/module5/btn/#btn_remove", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.btnActiveReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/module5/btn/#btn_reset", AudioEnum3_10.Outside.play_ui_langchao_general_click)
	self.btnPassiveReset = gohelper.findChildButtonWithAudio(self.viewGO, "root/module5/btn/#btn_reset1", AudioEnum3_10.Outside.play_ui_langchao_general_click)

	local currencyParam = AtomicConfig.instance:getConstValue(AtomicEnum.ConstId.TalentCoin)
	local arr = string.splitToNumber(currencyParam, "#")

	self.currencyId = arr[2]
	self.scrollAnim = gohelper.findChildComponent(self.viewGO, "root/module4", typeof(UnityEngine.Animator))
	self.infoAnim = gohelper.findChildComponent(self.viewGO, "root/module5", typeof(UnityEngine.Animator))
	self.btnMask = gohelper.findChildButtonWithAudio(self.viewGO, "#go_mask", AudioEnum3_10.Outside.play_ui_langchao_general_click)

	gohelper.setActive(self.btnMask, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AtomicCultivateView:addEvents()
	self.addClickCb(self, self.btnReset, self.onClickBtnReset, self)
	self.addClickCb(self, self.btnUnlock, self.onClickBtnUnlock, self)
	self.addClickCb(self, self.btnInstall, self.onClickBtnInstall, self)
	self.addClickCb(self, self.btnRmove, self.onClickBtnRemove, self)
	self.addClickCb(self, self.btnMask, self.onClickBtnMask, self)
	self.addClickCb(self, self.btnActiveReset, self.onClickBtnActiveReset, self)
	self.addClickCb(self, self.btnPassiveReset, self.onClickBtnPassiveReset, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.addEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshOtherInfo, self)
	self.addEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentBranchChange, self.playRefreshBranch, self)
end

function AtomicCultivateView:removeEvents()
	self:removeClickCb(self.btnReset)
	self:removeClickCb(self.btnUnlock)
	self:removeClickCb(self.btnInstall)
	self:removeClickCb(self.btnRmove)
	self:removeClickCb(self.btnMask)
	self:removeClickCb(self.btnActiveReset)
	self:removeClickCb(self.btnPassiveReset)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self.removeEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentUpdate, self.refreshOtherInfo, self)
	self.removeEventCb(self, AtomicTalentController.instance, AtomicEvent.TalentBranchChange, self.playRefreshBranch, self)
end

function AtomicCultivateView:_editableInitView()
	return
end

function AtomicCultivateView:onClickBtnPassiveReset()
	self:onClickBtnResetNode()
end

function AtomicCultivateView:onClickBtnActiveReset()
	self:onClickBtnResetNode()
end

function AtomicCultivateView:onClickBtnMask()
	self:exitInstallMask()
end

function AtomicCultivateView:onClickBtnResetNode()
	local curNodeId = AtomicTalentViewModel.instance:getCurNodeId()

	if not curNodeId then
		return
	end

	AtomicTalentController.instance:tryResetTalent(curNodeId)
end

function AtomicCultivateView:onClickBtnReset()
	local canRest = AtomicTalentViewModel.instance:isBranchCanReset(AtomicTalentViewModel.instance.selectBranchId)

	if not canRest then
		GameFacade.showToast(ToastEnum.AtomicTalentCantReset)

		return
	end

	local function func()
		local branchId = AtomicTalentViewModel.instance.selectBranchId

		AtomicRpc.instance:sendAtomicTalentResetRequest(branchId)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.AtomicTalentResetConfirm, MsgBoxEnum.BoxType.Yes_No, func)
end

function AtomicCultivateView:onClickBtnUnlock()
	local curNodeId = AtomicTalentViewModel.instance:getCurNodeId()

	if not curNodeId then
		return
	end

	AtomicTalentController.instance:tryUnlockTalent(curNodeId)
end

function AtomicCultivateView:onClickBtnInstall()
	local curNodeId = AtomicTalentViewModel.instance:getCurNodeId()

	if not curNodeId then
		return
	end

	self:showInstallMask(curNodeId)
end

function AtomicCultivateView:onClickBtnRemove()
	local curNodeId = AtomicTalentViewModel.instance:getCurNodeId()

	if not curNodeId then
		return
	end

	AtomicTalentController.instance:tryRemoveTalent(curNodeId)
end

function AtomicCultivateView:onClickSkillSlot(index)
	if self.isInstallingNodeId ~= nil then
		AtomicTalentController.instance:tryInstallTalent(self.isInstallingNodeId, index)
		self:exitInstallMask()
		AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_skill_light)
	else
		AtomicTalentController.instance:trySelectSlot(index)
	end
end

function AtomicCultivateView:onUpdateParam()
	return
end

function AtomicCultivateView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_screen_open)
	AtomicTalentController.instance:onOpenView(self.viewParam)
	self:refreshView()
end

function AtomicCultivateView:onClose()
	AtomicTalentController.instance:onCloseView()
end

function AtomicCultivateView:refreshView()
	self:refreshCurrency()
	self:refreshOtherInfo()
end

function AtomicCultivateView:refreshOtherInfo()
	self:refreshBranchList()
	self:refreshSlotList()
	self:refreshInfo()
end

function AtomicCultivateView:refreshSlotList()
	local slotCount = AtomicTalentViewModel.instance:getTalentSlotCount()
	local skillList = AtomicTalentViewModel.instance:getTalentEquipList()

	for i = 1, slotCount do
		self:updateSkillSlot(i, skillList[i])
	end
end

function AtomicCultivateView:updateSkillSlot(index, skillId)
	self.skillSlotList = self.skillSlotList or {}

	local slot = self.skillSlotList[index]

	if not slot then
		slot = self:getUserDataTb_()
		slot.go = gohelper.findChild(self.viewGO, string.format("module3/skillslot/#go_slot%d", index))
		slot.goSelect = gohelper.findChild(slot.go, "#go_select")
		slot.btn = gohelper.findButtonWithAudio(slot.go, AudioEnum3_10.Outside.play_ui_langchao_general_click)

		slot.btn:AddClickListener(self.onClickSkillSlot, self, index)

		slot.imageIcon = gohelper.findChildImage(slot.go, "icon")
		slot.goLoop = gohelper.findChild(slot.go, "#go_select_lightloop")
		slot.goLight = gohelper.findChild(slot.go, "#go_get")
		self.skillSlotList[index] = slot
	end

	local isSelect = AtomicTalentViewModel.instance:isSlotSelected(index)
	local isEmpty = skillId == nil or skillId <= 0

	gohelper.setActive(slot.imageIcon, not isEmpty)
	gohelper.setActive(slot.goLight, not isEmpty)
	gohelper.setActive(slot.goSelect, not isEmpty)

	if not isEmpty then
		local config = AtomicConfig.instance:getTalentConfig(skillId)

		UISpriteSetMgr.instance:setSp02AtomicIconSprite(slot.imageIcon, config.icon, true)
	end
end

function AtomicCultivateView:refreshBranchList()
	local branchList = AtomicConfig.instance:getBranchList()

	self.branchItemList = self.branchItemList or {}

	for i = 1, math.max(#branchList, #self.branchItemList) do
		local branch = branchList[i]
		local item = self:getBranchItem(i)

		self:updateBranchItem(item, branch)
	end
end

function AtomicCultivateView:getBranchItem(index)
	local item = self.branchItemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self.goBranchItem, tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AtomicCultivateBranchItem)
		self.branchItemList[index] = item
	end

	return item
end

function AtomicCultivateView:updateBranchItem(item, branch)
	if not item then
		return
	end

	item:updateData(branch)
end

function AtomicCultivateView:refreshCurrency()
	local currencyMO = CurrencyModel.instance:getCurrency(self.currencyId)
	local currencyCO = CurrencyConfig.instance:getCurrencyCo(self.currencyId)

	if currencyMO then
		if not currencyMO.quantity then
			self.txtCurrency.text = 0
			self.txtCurrencyInfo.text = ""
		end
	end
end

function AtomicCultivateView:refreshInfo()
	local curNodeId = AtomicTalentViewModel.instance:getCurNodeId()

	if curNodeId ~= self._curNodeId then
		self._curNodeId = curNodeId

		self:playRefreshInfo()
	end

	if curNodeId then
		::label_26_0::

		local config = AtomicConfig.instance:getTalentConfig(curNodeId)

		if not config then
			self.txtTitle.text = ""
			self.txtDesc.text = ""

			gohelper.setActive(self.btnInstall, false)
			gohelper.setActive(self.btnRmove, false)
			gohelper.setActive(self.btnUnlock, false)
			gohelper.setActive(self.imgVideo, false)
			gohelper.setActive(self.btnActiveReset, false)
			gohelper.setActive(self.btnPassiveReset, false)

			return
		end

		if string.nilorempty(config.pic) then
			gohelper.setActive(self.imgVideo, false)
		else
			gohelper.setActive(self.imgVideo, true)
			UISpriteSetMgr.instance:setSp02AtomicIconSprite(self.imgVideo, config.pic, true)
		end

		self.txtTitle.text = config.name

		local skillStr = SkillHelper.addLink(config.desc)

		self.txtDesc.text = skillStr or ""

		SkillHelper.addHyperLinkClick(self.txtDesc)

		local isUnlock = AtomicTalentViewModel.instance:isNodeUnlocked(curNodeId)

		if isUnlock then
			local isInstall = AtomicTalentViewModel.instance:isNodeInstalled(curNodeId)

			if isInstall then
				gohelper.setActive(self.btnInstall, false)
				gohelper.setActive(self.btnRmove, true)
				gohelper.setActive(self.btnActiveReset, false)
				gohelper.setActive(self.btnPassiveReset, false)
			else
				local isCanTalent = AtomicTalentViewModel.instance:isNodeCanTalent(curNodeId)

				gohelper.setActive(self.btnInstall, isCanTalent)
				gohelper.setActive(self.btnActiveReset, isCanTalent)
				gohelper.setActive(self.btnRmove, false)
				gohelper.setActive(self.btnPassiveReset, not isCanTalent)
			end

			gohelper.setActive(self.btnUnlock, false)
		else
			gohelper.setActive(self.btnInstall, false)
			gohelper.setActive(self.btnRmove, false)
			gohelper.setActive(self.btnActiveReset, false)
			gohelper.setActive(self.btnPassiveReset, false)

			local isPreUnlock = AtomicTalentViewModel.instance:isNodePreUnlock(curNodeId)

			gohelper.setActive(self.goUnlockTips, isPreUnlock)
			gohelper.setActive(self.btnUnlock, isPreUnlock)

			if isPreUnlock then
				local cost = string.splitToNumber(config.cost, "#")
				local currencyCO = CurrencyConfig.instance:getCurrencyCo(cost[2])

				self.txtPropnum.text = cost[3]
				self.txtPropName.text = currencyCO.name
			end
		end
	end
end

function AtomicCultivateView:playRefreshBranch()
	self.scrollAnim:Play("refresh", 0, 0)
end

function AtomicCultivateView:playRefreshInfo()
	self.infoAnim:Play("refresh", 0, 0)
end

function AtomicCultivateView:showInstallMask(nodeId)
	AudioMgr.instance:trigger(AudioEnum3_10.Outside.play_ui_langchao_install_open)

	self.isInstallingNodeId = nodeId

	gohelper.setActive(self.btnMask, true)

	if self.skillSlotList then
		for _, slot in pairs(self.skillSlotList) do
			gohelper.setActive(slot.goLoop, true)
		end
	end
end

function AtomicCultivateView:exitInstallMask()
	self.isInstallingNodeId = nil

	gohelper.setActive(self.btnMask, false)

	if self.skillSlotList then
		for _, slot in pairs(self.skillSlotList) do
			gohelper.setActive(slot.goLoop, false)
		end
	end
end

function AtomicCultivateView:onDestroyView()
	if self.skillSlotList then
		for _, slot in pairs(self.skillSlotList) do
			slot.btn:RemoveClickListener()
		end
	end
end

return AtomicCultivateView
