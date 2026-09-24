-- chunkname: @modules/logic/college/view/role/CollegeRoleBaseView.lua

module("modules.logic.college.view.role.CollegeRoleBaseView", package.seeall)

local CollegeRoleBaseView = class("CollegeRoleBaseView", BaseView)

function CollegeRoleBaseView:onInitView()
	self._simagechess = gohelper.findChildSingleImage(self.viewGO, "bg/chess/ani/#Image_chess")
	self._goRolePanel = gohelper.findChild(self.viewGO, "#go_rolepanel")
	self._goDispatch = gohelper.findChild(self.viewGO, "Right/#go_vertical/#go_Dispatch")
	self._goRoleList = gohelper.findChild(self.viewGO, "Right/#go_vertical/#scroll_RoleList")
	self._btnBatch = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Buttons/#btn_Batch")
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Buttons/#btn_Refresh")
	self._btnCancel = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Buttons/#btn_Cancel")
	self._btnRecruit = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Buttons/#btn_Recruit")
	self._btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Buttons/#btn_Confirm")
	self._goDispatchBg = gohelper.findChild(self.viewGO, "bg/#image_windmill")
	self._goBagBg = gohelper.findChild(self.viewGO, "bg/#image_person")

	gohelper.setActive(self._goBagBg, true)
	gohelper.setActive(self._goDispatchBg, false)
	recthelper.setHeight(self._goRoleList.transform, 624)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRoleBaseView:addEvents()
	self._btnBatch:AddClickListener(self._btnBatchOnClick, self)
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self._btnCancel:AddClickListener(self._btnCancelOnClick, self)
	self._btnRecruit:AddClickListener(self._btnRecruitOnClick, self)
	self._btnConfirm:AddClickListener(self._btnConfirmOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.SelectCharacter, self._onSelectCharacter, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateBag, self.refresh, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.UpdateCharacter, self.refresh, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.PlayUpgradeAnim, self._playUpgradeAnim, self)
end

function CollegeRoleBaseView:removeEvents()
	self._btnBatch:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnCancel:RemoveClickListener()
	self._btnRecruit:RemoveClickListener()
	self._btnConfirm:RemoveClickListener()
end

function CollegeRoleBaseView:_btnBatchOnClick()
	return
end

function CollegeRoleBaseView:_btnRefreshOnClick()
	return
end

function CollegeRoleBaseView:_btnCancelOnClick()
	return
end

function CollegeRoleBaseView:_btnRecruitOnClick()
	return
end

function CollegeRoleBaseView:_btnConfirmOnClick()
	return
end

function CollegeRoleBaseView:_editableInitView()
	self._scrollView = self.viewContainer:getScrollView()
	self._roleListModel = self._scrollView and self._scrollView._model
	self._goBtnBatch = self._btnBatch.gameObject
	self._goBtnRefresh = self._btnRefresh.gameObject
	self._goBtnCancel = self._btnCancel.gameObject
	self._goBtnRecruit = self._btnRecruit.gameObject
	self._goBtnConfirm = self._btnConfirm.gameObject
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	self:reset()
	self:initPanel()
end

function CollegeRoleBaseView:onOpen()
	self:initViewParam()
	self:initData()
	self:refresh()
end

function CollegeRoleBaseView:reset()
	gohelper.setActive(self._goBtnBatch, false)
	gohelper.setActive(self._goBtnRefresh, false)
	gohelper.setActive(self._goBtnCancel, false)
	gohelper.setActive(self._goBtnRecruit, false)
	gohelper.setActive(self._goBtnConfirm, false)
	gohelper.setActive(self._goDispatch, false)
end

function CollegeRoleBaseView:initPanel()
	local goPanel = self:getResInst(CollegeEnum.PrefabPath.RolePanel, self._goRolePanel)

	self._panelItem = MonoHelper.addNoUpdateLuaComOnceToGo(goPanel, self:getPanelClass(), self)
end

function CollegeRoleBaseView:getPanelClass()
	return CollegeRoleBasePanelItem
end

function CollegeRoleBaseView:initViewParam()
	self._selectMo = self.viewParam and self.viewParam.selectMo
end

function CollegeRoleBaseView:initData()
	self._roleListModel:initList(self._selectMo)
end

function CollegeRoleBaseView:refresh()
	self:refreshData()
	self:refreshUI()
end

function CollegeRoleBaseView:refreshData()
	self._roleListModel:refreshList()
end

function CollegeRoleBaseView:refreshUI()
	self:refreshPanelItem()
	self:refreshBtnVisible()
	self:refreshOtherUI()
end

function CollegeRoleBaseView:refreshBtnVisible()
	return
end

function CollegeRoleBaseView:refreshOtherUI()
	return
end

function CollegeRoleBaseView:refreshPanelItem()
	local selectList = self._scrollView:getSelectList()

	if selectList then
		if not #selectList then
			local selectNum = 0
			local lastSelectMo = selectList and selectList[selectNum]

			self._panelItem:onUpdateMO(lastSelectMo)
			CollegeIconHelper.setActorChessIcon(lastSelectMo and lastSelectMo.co.id, self._simagechess)
		end
	end
end

function CollegeRoleBaseView:_onSelectCharacter()
	self._animator.enabled = true

	self._animator:Play("switch", 0, 0)
	TaskDispatcher.cancelTask(self.refreshUI, self)
	TaskDispatcher.runDelay(self.refreshUI, self, 0.16)
end

function CollegeRoleBaseView:_playUpgradeAnim()
	self._animator.enabled = true

	self._animator:Play("leveup", 0, 0)
end

function CollegeRoleBaseView:onClose()
	self._roleListModel:clear()
	TaskDispatcher.cancelTask(self.refreshUI, self)
end

return CollegeRoleBaseView
