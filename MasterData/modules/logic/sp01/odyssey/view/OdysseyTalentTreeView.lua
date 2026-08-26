-- chunkname: @modules/logic/sp01/odyssey/view/OdysseyTalentTreeView.lua

module("modules.logic.sp01.odyssey.view.OdysseyTalentTreeView", package.seeall)

local OdysseyTalentTreeView = class("OdysseyTalentTreeView", BaseView)

function OdysseyTalentTreeView:onInitView()
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._txtremainTalentPoint = gohelper.findChildText(self.viewGO, "talentpoint/#txt_remainTalentPoint")
	self._gotalentTree = gohelper.findChild(self.viewGO, "talentTree")
	self._gotreeType1 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType1")
	self._gotreeType2 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType2")
	self._gotreeType3 = gohelper.findChild(self.viewGO, "talentTree/#go_treeType3")
	self._gotalentDetailTipView = gohelper.findChild(self.viewGO, "#go_talentDetailTipView")
	self._txttalentName = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/title/#txt_talentName")
	self._gotalentNode = gohelper.findChild(self.viewGO, "#go_talentDetailTipView/#go_talentNode")
	self._scrolltalentEffect = gohelper.findChildScrollRect(self.viewGO, "#go_talentDetailTipView/#scroll_talentEffect")
	self._goContent = gohelper.findChild(self.viewGO, "#go_talentDetailTipView/#scroll_talentEffect/Viewport/#go_Content")
	self._gotalentEffectItem = gohelper.findChild(self.viewGO, "#go_talentDetailTipView/#scroll_talentEffect/Viewport/#go_Content/#go_talentEffectItem")
	self._btnNotLvDown = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talentDetailTipView/#btn_NotLvDown")
	self._txtNotLvDownNum = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_NotLvDown/#txt_NotLvDownNum")
	self._txtNotLvDown = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_NotLvDown/txt_LvDown")
	self._btnLvDown = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talentDetailTipView/#btn_LvDown")
	self._txtLvDownNum = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_LvDown/#txt_LvDownNum")
	self._txtLvDown = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_LvDown/txt_LvDown")
	self._btnLvUp = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talentDetailTipView/#btn_LvUp")
	self._txtLvUpNum = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_LvUp/#txt_LvUpNum")
	self._goLvUpMax = gohelper.findChild(self.viewGO, "#go_talentDetailTipView/#go_LvUpMax")
	self._btnLvUpFirst = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talentDetailTipView/#btn_LvUpFirst")
	self._txtLvUpFirstNum = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#btn_LvUpFirst/#txt_LvUpFirstNum")
	self._goLvUpLock = gohelper.findChild(self.viewGO, "#go_talentDetailTipView/#go_LvUpLock")
	self._txtLvUpLockNum = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#go_LvUpLock/#txt_LvUpLockNum")
	self._txtlockTip = gohelper.findChildText(self.viewGO, "#go_talentDetailTipView/#go_LvUpLock/LockTips/#txt_lockTip")
	self._btnCloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closeTip")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function OdysseyTalentTreeView:addEvents()
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnNotLvDown:AddClickListener(self._btnNotLvDownOnClick, self)
	self._btnLvDown:AddClickListener(self._btnLvDownOnClick, self)
	self._btnLvUp:AddClickListener(self._btnLvUpOnClick, self)
	self._btnLvUpFirst:AddClickListener(self._btnLvUpFirstOnClick, self)
	self._btnCloseTip:AddClickListener(self._btnCloseTipOnClick, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.RefreshTalentNodeSelect, self.onTalentNodeSelect, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.ResetTalent, self.resetTalent, self)
	self.addEventCb(self, OdysseyController.instance, OdysseyEvent.RefreshTalent, self.refreshUI, self)
end

function OdysseyTalentTreeView:removeEvents()
	self._btnreset:RemoveClickListener()
	self._btnNotLvDown:RemoveClickListener()
	self._btnLvDown:RemoveClickListener()
	self._btnLvUp:RemoveClickListener()
	self._btnLvUpFirst:RemoveClickListener()
	self._btnCloseTip:RemoveClickListener()
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.RefreshTalentNodeSelect, self.onTalentNodeSelect, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.ResetTalent, self.resetTalent, self)
	self.removeEventCb(self, OdysseyController.instance, OdysseyEvent.RefreshTalent, self.refreshUI, self)
end

OdysseyTalentTreeView.NodeRadius = 60
OdysseyTalentTreeView.ScaleOffset = 720
OdysseyTalentTreeView.NormalScale = 0
OdysseyTalentTreeView.ScaleTime = 0.3

function OdysseyTalentTreeView:_btnLvUpFirstOnClick()
	if self.curSelectNodeId > 0 and self.canConsume then
		OdysseyRpc.instance:sendOdysseyTalentNodeLevelUpRequest(self.curSelectNodeId, self.playTalentNodeLevelUpEffect, self)
	elseif not self.canConsume then
		GameFacade.showToast(ToastEnum.OdysseyTalentPointLack)
	end
end

function OdysseyTalentTreeView:_btnresetOnClick()
	GameFacade.showMessageBox(MessageBoxIdDefine.OdysseyResetTalentTree, MsgBoxEnum.BoxType.Yes_No, self.sendResetTalentTree, nil, nil, self)
end

function OdysseyTalentTreeView:sendResetTalentTree()
	OdysseyRpc.instance:sendOdysseyTalentAllResetRequest()
end

function OdysseyTalentTreeView:_btnNotLvDownOnClick()
	if self.isHasChildNode then
		GameFacade.showToast(ToastEnum.OdysseyTalentNotLvDown)
	elseif self.isLvDownNotAccordLightNum then
		GameFacade.showToast(ToastEnum.OdysseyTalentNotAccordLightNum)
	end
end

function OdysseyTalentTreeView:_btnLvDownOnClick()
	OdysseyRpc.instance:sendOdysseyTalentNodeLevelDownRequest(self.curSelectNodeId)
	self._animTalentPoint:Play("click", 0, 0)
	self._animTalentPoint:Update(0)
end

function OdysseyTalentTreeView:_btnLvUpOnClick()
	if self.canConsume then
		OdysseyRpc.instance:sendOdysseyTalentNodeLevelUpRequest(self.curSelectNodeId, self.playTalentNodeLevelUpEffect, self)
	else
		GameFacade.showToast(ToastEnum.OdysseyTalentPointLack)
	end
end

function OdysseyTalentTreeView:_btnCloseTipOnClick()
	if not self.curIsTreeSmallScale then
		return
	end

	OdysseyTalentModel.instance:setCurselectNodeId(0)

	self.curIsTreeSmallScale = true

	self:createAndRefreshTalentNodeItem()
	self:doTalentTreeScaleAnim()
end

function OdysseyTalentTreeView:_editableInitView()
	self.talentTreeMap = self:getUserDataTb_()
	self.talentTreeLineMap = self:getUserDataTb_()

	gohelper.setActive(self._gotalentDetailTipView, false)

	self.tempLineVector = Vector2(0, 0)
	self.curIsTreeSmallScale = false
	self.screenWidth = gohelper.getUIScreenWidth()

	recthelper.setWidth(self._gotalentTree.transform, self.screenWidth)

	self._animTalentTree = gohelper.findChild(self.viewGO, "talentTree"):GetComponent(gohelper.Type_Animator)
	self._animPlayerDetailTip = SLFramework.AnimatorPlayer.Get(self._gotalentDetailTipView)
	self._animTalentPoint = gohelper.findChild(self.viewGO, "talentpoint"):GetComponent(gohelper.Type_Animator)
	self._txtTalentPointEffect = gohelper.findChildText(self.viewGO, "talentpoint/#txt_effect")
	self._talentSelectFrameFlashMap = self:getUserDataTb_()
end

function OdysseyTalentTreeView:onUpdateParam()
	return
end

function OdysseyTalentTreeView:resetTalent()
	if self._gotalentDetailTipView.activeSelf then
		self:_btnCloseTipOnClick()
	end

	self._animTalentPoint:Play("click", 0, 0)
	self._animTalentPoint:Update(0)
	self:refreshUI()
end

function OdysseyTalentTreeView:onOpen()
	self:refreshUI()
	OdysseyStatHelper.instance:initViewStartTime()
end

function OdysseyTalentTreeView:refreshUI()
	self:createAndRefreshTalentNodeItem()
	self:createAndRefreshNodeItemLine()

	self.curTalentPoint = OdysseyTalentModel.instance:getCurTalentPoint()
	self._txtremainTalentPoint.text = self.curTalentPoint
	self._txtTalentPointEffect.text = self.curTalentPoint
	self.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	if self.curSelectNodeId > 0 then
		if not self.curIsTreeSmallScale then
			self:doTalentTreeScaleAnim()
		end

		self:refreshTalentDetailTipView()
	end

	local isHasLightTalentNode = OdysseyTalentModel.instance:isHasTalentNode()

	gohelper.setActive(self._btnreset.gameObject, isHasLightTalentNode)
end

function OdysseyTalentTreeView:createAndRefreshTalentNodeItem()
	for talentType = OdysseyEnum.TalentType.Hunter, OdysseyEnum.TalentType.Assassin do
		local treeItem = self.talentTreeMap[talentType]

		if not treeItem then
			treeItem = {
				treeGO = self["_gotreeType" .. talentType]
			}
			treeItem.lastCostPoint = -1
			treeItem.txtCostPoint = gohelper.findChildText(treeItem.treeGO, "treeInfo/txt_costPoint")
			treeItem.txtTypeName = gohelper.findChildText(treeItem.treeGO, "treeInfo/txt_typeName")
			treeItem.goLineContent = gohelper.findChild(treeItem.treeGO, "go_lineContent")
			treeItem.goLine = gohelper.findChild(treeItem.treeGO, "go_lineContent/go_line")
			treeItem.upgradeEffect = gohelper.findChild(treeItem.treeGO, "treeInfo/vx_upgrade")
			treeItem.talentItemPos = {}

			for i = 1, 8 do
				local talentItemPos = gohelper.findChild(treeItem.treeGO, "go_talentitem" .. i)

				if not talentItemPos then
					break
				end

				treeItem.talentItemPos[i] = talentItemPos
			end

			treeItem.talentTypeCoList = OdysseyConfig.instance:getAllTalentConfigByType(talentType)
			treeItem.talentNodeItemMap = {}

			for _, talentCo in ipairs(treeItem.talentTypeCoList) do
				local talentPos = talentCo.position
				local talentItemPos = treeItem.talentItemPos[talentPos]

				if talentItemPos then
					local talentItemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], talentItemPos, tostring(talentCo.nodeId))

					treeItem.talentNodeItemMap[talentCo.nodeId] = MonoHelper.addNoUpdateLuaComOnceToGo(talentItemGO, OdysseyTalentNodeItem)
				end
			end

			self.talentTreeMap[talentType] = treeItem
		end

		for _, talentCo in ipairs(treeItem.talentTypeCoList) do
			local talentItem = treeItem.talentNodeItemMap[talentCo.nodeId]

			if talentItem then
				talentItem:refreshNode(talentCo)
			end
		end

		local curTalentConsumeCount = OdysseyTalentModel.instance:getTalentConsumeCount(talentType)

		if treeItem.lastCostPoint > -1 and curTalentConsumeCount > treeItem.lastCostPoint then
			gohelper.setActive(treeItem.upgradeEffect, false)
			gohelper.setActive(treeItem.upgradeEffect, true)
		end

		treeItem.lastCostPoint = curTalentConsumeCount
		treeItem.txtCostPoint.text = curTalentConsumeCount
		treeItem.txtTypeName.text = luaLang("odyssey_talenttree_type" .. talentType)
	end
end

function OdysseyTalentTreeView:createAndRefreshNodeItemLine()
	for talentType, treeItem in pairs(self.talentTreeMap) do
		local lineContentGO = treeItem.goLineContent
		local lineGO = treeItem.goLine

		gohelper.setActive(lineGO, false)

		for _, talentCo in ipairs(treeItem.talentTypeCoList) do
			local preNodeCo = OdysseyConfig.instance:getTalentParentNodeConfig(talentCo.nodeId)

			if preNodeCo then
				local lineItem = self.talentTreeLineMap[talentCo.nodeId]

				if not lineItem then
					lineItem = {}

					local preNodePosGO = treeItem.talentItemPos[preNodeCo.position]
					local curNodePosGO = treeItem.talentItemPos[talentCo.position]
					local preNodePos = preNodePosGO.transform.localPosition
					local curNodePos = curNodePosGO.transform.localPosition
					local linePos = (preNodePos + curNodePos) * 0.5
					local distance = Vector2.Distance(preNodePos, curNodePos) - 2 * OdysseyTalentTreeView.NodeRadius

					self.tempLineVector:Set(curNodePos.x - preNodePos.x, curNodePos.y - preNodePos.y)

					lineItem.go = gohelper.clone(lineGO, lineContentGO, "lineItem" .. talentCo.nodeId)
					lineItem.lightGO = gohelper.findChild(lineItem.go, "go_linelight")

					gohelper.setActive(lineItem.go, true)
					recthelper.setAnchor(lineItem.go.transform, linePos.x, linePos.y)
					recthelper.setHeight(lineItem.go.transform, distance)

					local angle = Mathf.Atan2(self.tempLineVector.y, self.tempLineVector.x) * Mathf.Rad2Deg - 90

					transformhelper.setLocalRotation(lineItem.go.transform, 0, 0, angle)

					self.talentTreeLineMap[talentCo.nodeId] = lineItem
				end

				local talentMo = OdysseyTalentModel.instance:getTalentMo(talentCo.nodeId)

				gohelper.setActive(lineItem.lightGO, talentMo)
			end
		end
	end
end

function OdysseyTalentTreeView:refreshTalentDetailTipView()
	self.curSelectNodeId = OdysseyTalentModel.instance:getCurSelectNodeId()

	if self.curSelectNodeId == 0 then
		return
	end

	gohelper.setActive(self._gotalentDetailTipView, true)

	self.curTalentEffectCoList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(self.curSelectNodeId)

	if self.curTalentEffectCoList[1] then
		self._txttalentName.text = self.curTalentEffectCoList[1].nodeName or ""
	end

	self._scrolltalentEffect.verticalNormalizedPosition = 1
	self.selectTalentMo = OdysseyTalentModel.instance:getTalentMo(self.curSelectNodeId)
	self.isHasChildNode = self.selectTalentMo and self.selectTalentMo:isHasChildNode()
	self.isLvDownNotAccordLightNum = OdysseyTalentModel.instance:checkLvDownHasNotAccordLightNumNode(self.curSelectNodeId)
	self.isUnlock, self.unlockConditionData = OdysseyTalentModel.instance:checkTalentCanUnlock(self.curSelectNodeId)
	self._talentSelectFrameFlashMap = self:getUserDataTb_()

	gohelper.CreateObjList(self, self.onTalentEffectShow, self.curTalentEffectCoList, self._goContent, self._gotalentEffectItem)
	gohelper.setActive(self._goLvUpLock, not self.isUnlock)
	gohelper.setActive(self._btnLvUpFirst.gameObject, self.isUnlock and (not self.selectTalentMo or self.selectTalentMo.level == 0))
	gohelper.setActive(self._btnNotLvDown.gameObject, (false or nil) and true)
	gohelper.setActive(self._btnLvDown.gameObject, self.isUnlock and self.selectTalentMo and self.selectTalentMo.level > 0 and not self.isHasChildNode and not self.isLvDownNotAccordLightNum)
	gohelper.setActive(self._goLvUpMax, self.isUnlock and self.selectTalentMo and self.selectTalentMo.level == #self.curTalentEffectCoList)
	gohelper.setActive(self._btnLvUp.gameObject, self.isUnlock and self.selectTalentMo and self.selectTalentMo.level < #self.curTalentEffectCoList and self.selectTalentMo.level > 0)

	if self.selectTalentMo then
		if not self.selectTalentMo.level then
			local curTalentLevel = 0
			local nextTalentLevel = curTalentLevel + 1

			self.canConsume = nextTalentLevel <= #self.curTalentEffectCoList and self.curTalentPoint >= self.curTalentEffectCoList[nextTalentLevel].consume

			if nextTalentLevel <= #self.curTalentEffectCoList then
				local costNumFormat = self.canConsume and "-%s" or "<#ff0000>-%s</color>"

				self._txtLvUpLockNum.text = string.format(costNumFormat, (self.curTalentEffectCoList[nextTalentLevel] or nil) and (self.curTalentEffectCoList[nextTalentLevel].consume or 0))
				self._txtLvUpNum.text = string.format(costNumFormat, (self.curTalentEffectCoList[nextTalentLevel] or nil) and (self.curTalentEffectCoList[nextTalentLevel].consume or 0))
				self._txtLvUpFirstNum.text = string.format(costNumFormat, (self.curTalentEffectCoList[nextTalentLevel] or nil) and (self.curTalentEffectCoList[nextTalentLevel].consume or 0))
			end

			self._txtNotLvDownNum.text = curTalentLevel > 0 and string.format("+%s", self.curTalentEffectCoList[curTalentLevel].consume) or ""
			self._txtLvDownNum.text = curTalentLevel > 0 and string.format("+%s", self.curTalentEffectCoList[curTalentLevel].consume) or ""
			self._txtNotLvDown.text = curTalentLevel > 1 and luaLang("odyssey_lvdown") or luaLang("odyssey_lvcancel")
			self._txtLvDown.text = curTalentLevel > 1 and luaLang("odyssey_lvdown") or luaLang("odyssey_lvcancel")

			if not self.isUnlock then
				if self.unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentType then
					local talentType, needConsumeCount = tonumber(self.unlockConditionData[2]), tonumber(self.unlockConditionData[3])
					local typeName = luaLang("odyssey_talenttree_type" .. talentType)

					self._txtlockTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("odyssey_talenttree_locktip_needlight"), needConsumeCount, typeName)
				elseif self.unlockConditionData[1] == OdysseyEnum.TalentUnlockCondition.TalentNode then
					self._txtlockTip.text = luaLang("odyssey_talenttree_locktip_prenode")
				end
			else
				self._txtlockTip.text = ""
			end

			self:refreshTalentDetailTipTalentNode()
		end
	end
end

function OdysseyTalentTreeView:refreshTalentDetailTipTalentNode()
	if not self.curDetailTalentNodeItem then
		local talentItemGO = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes[1], self._gotalentNode)

		self.curDetailTalentNodeItem = MonoHelper.addNoUpdateLuaComOnceToGo(talentItemGO, OdysseyTalentNodeItem)

		self.curDetailTalentNodeItem:hideBtn()
	end

	local allTalentEffectCoList = OdysseyConfig.instance:getAllTalentEffectConfigByNodeId(self.curSelectNodeId)

	self.curDetailTalentNodeItem:refreshNode(allTalentEffectCoList[1], true)
end

function OdysseyTalentTreeView:onTalentEffectShow(obj, data, index)
	local txtDesc = gohelper.findChildText(obj, "txt_desc")
	local goSelectFrame = gohelper.findChild(obj, "txt_desc/go_selectFrame")
	local goSelectFrameFlash = gohelper.findChild(obj, "txt_desc/go_selectFrame_flash")
	local goLine = gohelper.findChild(obj, "txt_desc/go_line")

	if self.selectTalentMo then
		local nextLevel = (self.selectTalentMo.level or 0) + 1

		txtDesc.text = SkillHelper.buildDesc(data.nodeDesc)

		local fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(txtDesc.gameObject, FixTmpBreakLine)

		SkillHelper.addHyperLinkClick(txtDesc, self._onHyperLinkClick, self)
		fixTmpBreakLine:refreshTmpContent(txtDesc)
		SLFramework.UGUI.GuiHelper.SetColor(txtDesc, nextLevel <= index and "#5C5C5C" or "#BEB9A6")
		gohelper.setActive(goSelectFrame, index == nextLevel)
		gohelper.setActive(goLine, index ~= #self.curTalentEffectCoList)
		gohelper.setActive(goSelectFrameFlash, false)

		self._talentSelectFrameFlashMap[index] = goSelectFrameFlash
	end
end

function OdysseyTalentTreeView:onTalentEffectFlashShow()
	if self.selectTalentMo then
		if not self.selectTalentMo.level then
			local curLevel = 0

			for index, flashGO in pairs(self._talentSelectFrameFlashMap) do
				gohelper.setActive(flashGO, false)
				gohelper.setActive(flashGO, index == curLevel)
			end
		end
	end
end

function OdysseyTalentTreeView:_onHyperLinkClick(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipView(tonumber(effId), clickPosition)
end

function OdysseyTalentTreeView:doTalentTreeScaleAnim()
	self._animTalentTree:Play(self.curIsTreeSmallScale and "close" or "open", 0, 0)
	gohelper.setActive(self._gotalentDetailTipView, true)

	if self.curIsTreeSmallScale then
		self._animPlayerDetailTip:Play("close", self.hideTalentDetailTip, self)
	else
		self._animPlayerDetailTip:Play("open", nil, self)
	end

	self.curIsTreeSmallScale = not self.curIsTreeSmallScale
end

function OdysseyTalentTreeView:onTalentNodeSelect()
	if self.curIsTreeSmallScale then
		self._animPlayerDetailTip:Play("open", nil, self)
	end

	self:refreshUI()
end

function OdysseyTalentTreeView:hideTalentDetailTip()
	gohelper.setActive(self._gotalentDetailTipView, false)
end

function OdysseyTalentTreeView:playTalentNodeLevelUpEffect()
	for talentType = OdysseyEnum.TalentType.Hunter, OdysseyEnum.TalentType.Assassin do
		local treeItem = self.talentTreeMap[talentType]

		if not treeItem then
			return
		end

		local talentItem = treeItem.talentNodeItemMap[self.curSelectNodeId]

		if talentItem then
			talentItem:playLevelUpEffect()

			break
		end
	end

	AudioMgr.instance:trigger(AudioEnum2_9.Odyssey.play_ui_cikexia_link_activate)
	self._animTalentPoint:Play("click", 0, 0)
	self._animTalentPoint:Update(0)
	self:onTalentEffectFlashShow()
end

function OdysseyTalentTreeView:onClose()
	OdysseyTalentModel.instance:setCurselectNodeId(0)
	OdysseyController.instance:dispatchEvent(OdysseyEvent.OnRefreshReddot)
	OdysseyStatHelper.instance:sendOdysseyViewStayTime("OdysseyTalentTreeView")
end

function OdysseyTalentTreeView:onDestroyView()
	return
end

return OdysseyTalentTreeView
