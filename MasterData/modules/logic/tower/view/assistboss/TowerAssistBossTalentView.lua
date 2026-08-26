-- chunkname: @modules/logic/tower/view/assistboss/TowerAssistBossTalentView.lua

module("modules.logic.tower.view.assistboss.TowerAssistBossTalentView", package.seeall)

local TowerAssistBossTalentView = class("TowerAssistBossTalentView", BaseView)

function TowerAssistBossTalentView:onInitView()
	self.btnBottomClose = gohelper.findChildButtonWithAudio(self.viewGO, "Scroll/Viewport/btnBottomClose")
	self.goBottom = gohelper.findChild(self.viewGO, "Bottom")
	self._bottomAnim = self.goBottom:GetComponent(gohelper.Type_Animator)
	self._bottomCanvasGroup = gohelper.onceAddComponent(self.goBottom, typeof(UnityEngine.CanvasGroup))
	self.btnClose = gohelper.findChildButtonWithAudio(self.goBottom, "root/btn_Close")
	self.btnCancel = gohelper.findChildButtonWithAudio(self.goBottom, "root/btn_cancel")
	self.btnSure = gohelper.findChildButtonWithAudio(self.goBottom, "root/btn_sure")
	self.txtCost = gohelper.findChildTextMesh(self.goBottom, "root/btn_sure/txtCost")
	self.btnLocked = gohelper.findChildButtonWithAudio(self.goBottom, "root/btn_Locked")
	self.txtLock = gohelper.findChildTextMesh(self.goBottom, "root/btn_Locked/txtLock")
	self.btnTips = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/image_TitleBG/#btn_Tips")
	self.goTips = gohelper.findChild(self.viewGO, "Tips/#go_Tips")
	self.btnCloseTips = gohelper.findChildButtonWithAudio(self.viewGO, "Tips/#go_Tips/#btn_closeMopupTip")
	self.imgTypeIcon = gohelper.findChildImage(self.goBottom, "root/Top/TypeIcon/#simage_TypeIcon")
	self.txtType = gohelper.findChildTextMesh(self.goBottom, "root/Top/#txt_Type")
	self.txtDesc = gohelper.findChildTextMesh(self.goBottom, "root/Scroll View/Viewport/desc")

	SkillHelper.addHyperLinkClick(self.txtDesc, self._onHyperLinkClick, self)

	self.descFixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtDesc.gameObject, FixTmpBreakLine)
	self.bossIcon = gohelper.findChildSingleImage(self.viewGO, "BOSS/Head/Mask/image_bossIcon")
	self.txtActiveCount = gohelper.findChildTextMesh(self.viewGO, "BOSS/layout/#txt_PassLevel")
	self.btnResetAll = gohelper.findChildButtonWithAudio(self.viewGO, "BOSS/layout/btn_reset")
	self.txtPoint = gohelper.findChildTextMesh(self.viewGO, "Tips/txt_point")
	self.btnAttr = gohelper.findChildButtonWithAudio(self.viewGO, "btn_Attr")
	self.isBottomVisible = false

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerAssistBossTalentView:addEvents()
	self.addClickCb(self, self.btnAttr, self.onBtnAttr, self)
	self.addClickCb(self, self.btnCloseTips, self.onBtnCloseTips, self)
	self.addClickCb(self, self.btnTips, self.onBtnTips, self)
	self.addClickCb(self, self.btnClose, self.onBtnBottomClose, self)
	self.addClickCb(self, self.btnBottomClose, self.onBtnBottomClose, self)
	self.addClickCb(self, self.btnCancel, self.onBtnReset, self)
	self.addClickCb(self, self.btnSure, self.onBtnSure, self)
	self.addClickCb(self, self.btnResetAll, self.onBtnResetAll, self)
	self.addClickCb(self, self.btnLocked, self.onBtnLocked, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.SelectTalentItem, self._onSelectTalentItem, self)
	self.addEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshView, self)
end

function TowerAssistBossTalentView:removeEvents()
	self:removeClickCb(self.btnAttr)
	self:removeClickCb(self.btnCloseTips)
	self:removeClickCb(self.btnTips)
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnBottomClose)
	self:removeClickCb(self.btnCancel)
	self:removeClickCb(self.btnSure)
	self:removeClickCb(self.btnResetAll)
	self:removeClickCb(self.btnLocked)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ResetTalent, self._onResetTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.ActiveTalent, self._onActiveTalent, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.SelectTalentItem, self._onSelectTalentItem, self)
	self.removeEventCb(self, TowerController.instance, TowerEvent.RefreshTalent, self.refreshView, self)
end

function TowerAssistBossTalentView:_editableInitView()
	return
end

function TowerAssistBossTalentView:onBtnLocked()
	local selectId = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not selectId then
		return
	end

	local talentTree = self.bossMo:getTalentTree()
	local talentNode = talentTree and talentTree:getNode(selectId)

	if not talentNode then
		return
	end

	local isActiveGroup, activeId = talentNode:isActiveGroup()

	if isActiveGroup then
		local activeNode = talentTree:getNode(activeId)

		GameFacade.showToast(ToastEnum.ToweTalentMutex, activeNode.config.nodeName)
	else
		local result = talentNode:getParentActiveResult()

		if result == 0 then
			GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)
		else
			GameFacade.showToast(ToastEnum.ToweTalentPreNotAllActive)
		end
	end
end

function TowerAssistBossTalentView:onBtnAttr()
	if not self.bossId then
		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossTalentTallView, {
		bossId = self.bossId
	})
end

function TowerAssistBossTalentView:onBtnTips()
	gohelper.setActive(self.goTips, true)
end

function TowerAssistBossTalentView:onBtnCloseTips()
	gohelper.setActive(self.goTips, false)
end

function TowerAssistBossTalentView:onBtnReset()
	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		GameFacade.showToast(ToastEnum.TowerBossTalentPlanCantModify)

		return
	end

	local talentId = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if TowerAssistBossTalentListModel.instance:isTalentCanReset(talentId, true) then
		TowerRpc.instance:sendTowerResetTalentRequest(self.bossId, talentId)
	end
end

function TowerAssistBossTalentView:onBtnResetAll()
	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.TowerTalentReset, MsgBoxEnum.BoxType.Yes_No, self._sendTowerResetAllTalentRequest, nil, nil, self)
end

function TowerAssistBossTalentView:_sendTowerResetAllTalentRequest()
	TowerRpc.instance:sendTowerResetTalentRequest(self.bossId, 0)
end

function TowerAssistBossTalentView:onBtnSure()
	local selectId = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not selectId then
		return
	end

	local talentTree = self.bossMo:getTalentTree()
	local talentNode = talentTree and talentTree:getNode(selectId)

	if not talentNode then
		return
	end

	if TowerAssistBossTalentListModel.instance:getAutoTalentState() then
		GameFacade.showToast(ToastEnum.TowerBossTalentPlanCantModify)

		return
	end

	if talentNode:isActiveTalent() then
		return
	end

	if talentNode:isActiveGroup() then
		return
	end

	if not talentNode:isParentActive() then
		GameFacade.showToast(ToastEnum.ToweTalentPreNotActive)

		return
	end

	if not talentNode:isTalentConsumeEnough() then
		GameFacade.showToast(ToastEnum.ToweTalentPointNotEnough)

		return
	end

	TowerRpc.instance:sendTowerActiveTalentRequest(self.bossId, selectId)
	TowerAssistBossTalentListModel.instance:setSelectTalent()
	self:setBottomVisible(false)
end

function TowerAssistBossTalentView:onBtnBottomClose()
	if self:setBottomVisible(false) then
		TowerAssistBossTalentListModel.instance:setSelectTalent()
	end
end

function TowerAssistBossTalentView:setBottomVisible(isVisible)
	if self.isBottomVisible == isVisible then
		return
	end

	self.isBottomVisible = isVisible

	if isVisible then
		gohelper.setActive(self.goBottom, true)
		self._bottomAnim:Play("open")

		self._bottomCanvasGroup.interactable = true
		self._bottomCanvasGroup.blocksRaycasts = true

		gohelper.setActive(self.btnAttr, false)
	else
		self._bottomAnim:Play("close")

		self._bottomCanvasGroup.interactable = false
		self._bottomCanvasGroup.blocksRaycasts = false

		gohelper.setActive(self.btnAttr, true)
	end

	return true
end

function TowerAssistBossTalentView:_onResetTalent(talentId)
	self:refreshView()
end

function TowerAssistBossTalentView:_onActiveTalent(talentId)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_talent_light)
	self:refreshView()
end

function TowerAssistBossTalentView:_onSelectTalentItem()
	self:refreshBottom()
end

function TowerAssistBossTalentView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_enter_talent_tree)
	self:refreshParam()
	self:refreshView()
end

function TowerAssistBossTalentView:refreshParam()
	self.bossId = self.viewParam.bossId
	self.bossMo = TowerAssistBossModel.instance:getBoss(self.bossId)
end

function TowerAssistBossTalentView:refreshView()
	TowerAssistBossTalentListModel.instance:refreshList()
	self:refreshBoss()
	self:refreshBottom()

	self.txtPoint.text = tostring(self.bossMo:getTalentPoint())
end

function TowerAssistBossTalentView:refreshBoss()
	local param1, param2 = self.bossMo:getTalentActiveCount()

	self.txtActiveCount.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towertalent_already_light"), param1, param1 + param2)

	local assistBossConfig = TowerConfig.instance:getAssistBossConfig(self.bossId)
	local skinConfig = FightConfig.instance:getSkinCO(assistBossConfig.skinId)

	self.bossIcon:LoadImage(ResUrl.monsterHeadIcon(skinConfig and skinConfig.headIcon))

	local bossMo = TowerAssistBossModel.instance:getById(self.bossId)
	local isAutoTalentPlan = TowerAssistBossTalentListModel.instance:getAutoTalentState()

	gohelper.setActive(self.btnResetAll, bossMo ~= nil and not isAutoTalentPlan)
end

function TowerAssistBossTalentView:refreshBottom()
	local selectId = TowerAssistBossTalentListModel.instance:getSelectTalent()

	if not selectId then
		self:setBottomVisible(false)

		return
	end

	self:setBottomVisible(true)

	local talentTree = self.bossMo:getTalentTree()
	local talentNode = talentTree:getNode(selectId)

	if not talentNode then
		return
	end

	local config = talentNode.config
	local isActive = talentNode:isActiveTalent()
	local isActiveGroup = talentNode:isActiveGroup()
	local isParentActive = talentNode:isParentActive()
	local isLeafNode = talentNode:isLeafNode()
	local canShow = not isActive and not isActiveGroup and isParentActive

	gohelper.setActive(self.btnSure, canShow)
	gohelper.setActive(self.btnCancel, isLeafNode and isActive)

	local showLock = not isActive and (isActiveGroup or not isParentActive)

	gohelper.setActive(self.btnLocked, showLock)

	if showLock then
		local result = talentNode:getParentActiveResult()

		self.txtLock.text = isActiveGroup and luaLang("towertalent_txt_Locked2") or result == 0 and luaLang("towertalent_txt_Locked1") or luaLang("towertalent_txt_Locked3")
	end

	if not isActive then
		self.txtCost.text = talentNode:isTalentConsumeEnough() and string.format("<color=#070706>-%s</color>", talentNode.config.consume) or string.format("-%s", talentNode.config.consume)
	end

	TowerConfig.instance:setTalentImg(self.imgTypeIcon, config)

	self.txtType.text = config.nodeName
	self.txtDesc.text = SkillHelper.buildDesc(config.nodeDesc)

	self.descFixTmpBreakLine:refreshTmpContent(self.txtDesc)
end

function TowerAssistBossTalentView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(effId), CommonBuffTipEnum.Anchor[self.viewName], CommonBuffTipEnum.Pivot.Down)
end

function TowerAssistBossTalentView:onClose()
	TowerAssistBossTalentListModel.instance:setSelectTalent()
end

function TowerAssistBossTalentView:onDestroyView()
	self.bossIcon:UnLoadImage()
end

return TowerAssistBossTalentView
