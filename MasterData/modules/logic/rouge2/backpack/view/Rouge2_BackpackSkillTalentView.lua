-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackSkillTalentView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackSkillTalentView", package.seeall)

local Rouge2_BackpackSkillTalentView = class("Rouge2_BackpackSkillTalentView", BaseViewExtended)

function Rouge2_BackpackSkillTalentView:onInitView()
	self._btnCloseDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseDetail")
	self._goTalentContainer = gohelper.findChild(self.viewGO, "#go_TalentContainer")
	self._btnCloseDetail2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_TalentContainer/Viewport/#btn_CloseDetail2")
	self._goViewPort = gohelper.findChild(self.viewGO, "#go_TalentContainer/Viewport")
	self._goContent = gohelper.findChild(self.viewGO, "#go_TalentContainer/Viewport/Content")
	self._goPet = gohelper.findChild(self.viewGO, "#go_Pet")
	self._goTree = gohelper.findChild(self.viewGO, "#go_TalentContainer/Viewport/Content/#go_Tree")
	self._goLineItem = gohelper.findChild(self.viewGO, "#go_TalentContainer/Viewport/Content/#go_Tree/#go_LineItem")
	self._txtTalentNum = gohelper.findChildText(self.viewGO, "layout/#txt_TalentNum")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Reset", AudioEnum.Rouge2.ClickResetTalent)
	self._goEnableReset = gohelper.findChild(self.viewGO, "#btn_Reset/#go_EnableReset")
	self._goDisableReset = gohelper.findChild(self.viewGO, "#btn_Reset/#go_DisableReset")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackSkillTalentView:addEvents()
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self._btnCloseDetail:AddClickListener(self._btnCloseDetailOnClick, self)
	self._btnCloseDetail2:AddClickListener(self._btnCloseDetailOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
end

function Rouge2_BackpackSkillTalentView:removeEvents()
	self._btnReset:RemoveClickListener()
	self._btnCloseDetail:RemoveClickListener()
	self._btnCloseDetail2:RemoveClickListener()
end

function Rouge2_BackpackSkillTalentView:_btnResetOnClick()
	if not self._isCanReset then
		GameFacade.showToast(ToastEnum.Rouge2TalentStageReset2)

		return
	end

	ViewMgr.instance:openView(ViewName.Rouge2_BackpackTalentResetView)
end

function Rouge2_BackpackSkillTalentView:_btnCloseDetailOnClick()
	ViewMgr.instance:closeView(ViewName.Rouge2_BackpackTalentDetailView)
end

function Rouge2_BackpackSkillTalentView:_editableInitView()
	self._isFirstEnter = true
	self._viewPortWidth = recthelper.getWidth(self._goViewPort.transform)
	self._halfViewPortWidth = self._viewPortWidth / 2
	self._treeLayoutElement = gohelper.onceAddComponent(self._goTree, typeof(UnityEngine.UI.LayoutElement))
	self._talentItemTab = self:getUserDataTb_()
	self._talentId2ItemTab = self:getUserDataTb_()
	self._talentItemUseNumMap = {}
	self._lineItemPool = LuaObjPool.New(100, function()
		return (self:createLineItem())
	end, function(lineItem)
		return
	end, function(lineItem)
		if lineItem ~= nil then
			lineItem:reset()
		end
	end)

	gohelper.setActive(self._goLineItem, false)
	self:initTalentTemplate()
	self:initTalentTree()
	self:initPet()
end

function Rouge2_BackpackSkillTalentView:initTalentTemplate()
	self._talentTemplateTab = self:getUserDataTb_()
	self._talentTemplateTab[Rouge2_Enum.BagTalentType.Normal] = gohelper.findChild(self._goTree, "#go_NormalItem")
	self._talentTemplateTab[Rouge2_Enum.BagTalentType.Transform] = gohelper.findChild(self._goTree, "#go_TransformItem")
	self._talentTemplateTab[Rouge2_Enum.BagTalentType.Hole] = gohelper.findChild(self._goTree, "#go_HoleItem")

	for _, goTemplate in pairs(self._talentTemplateTab) do
		gohelper.setActive(goTemplate, false)
	end
end

function Rouge2_BackpackSkillTalentView:initTalentTree()
	local useMap = {}
	local maxTalentItemPosX = -100000

	for _, talentCo in ipairs(lua_fight_rouge2_summoner.configList) do
		local talentItem = self:_getOrCreateTalentItem(talentCo)

		if talentItem then
			talentItem:show()
			talentItem:onUpdateMO(talentCo)

			useMap[talentItem] = true
			self._talentId2ItemTab[talentCo.talentId] = talentItem

			local talentItemPosX = talentItem:getItemPos()

			if maxTalentItemPosX < talentItemPosX then
				maxTalentItemPosX = talentItemPosX
			end
		end
	end

	for _, talentItemList in pairs(self._talentItemTab) do
		for _, talentItem in pairs(talentItemList) do
			if not useMap[talentItem] then
				talentItem:hide()
			end
		end
	end

	self._treeLayoutElement.minWidth = maxTalentItemPosX + Rouge2_Enum.BagTalentTreeEndWidth
end

function Rouge2_BackpackSkillTalentView:_getOrCreateTalentItem(talentCo)
	local type = talentCo.type

	if not self._talentItemUseNumMap[type] then
		local useNum = 0
		local typeIndex = useNum + 1
		local talentItemList = self._talentItemTab[type]

		if not talentItemList then
			talentItemList = self:getUserDataTb_()
			self._talentItemTab[type] = talentItemList
		end

		local talentItem = talentItemList[typeIndex]

		if not talentItem then
			talentItem = self:_createTalentItem(type, typeIndex)
			talentItemList[typeIndex] = talentItem
			self._talentItemUseNumMap[type] = typeIndex
		end

		return talentItem
	end
end

function Rouge2_BackpackSkillTalentView:_createTalentItem(type, typeIndex)
	local goTemplate = self._talentTemplateTab[type]

	if gohelper.isNil(goTemplate) then
		logError(string.format("肉鸽背包天赋节点模板不存在 type = %s", type))

		return
	end

	local cls = Rouge2_Enum.BagTalentType2Cls[type]
	local go = gohelper.cloneInPlace(goTemplate, string.format("%s_%s", type, typeIndex))

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, cls, self)
end

function Rouge2_BackpackSkillTalentView:getTalentItemById(talentId)
	local talentItem = self._talentId2ItemTab[talentId]

	if not talentItem then
		logError(string.format("肉鸽背包天赋节点不存在 talentId = %s", talentId))
	end

	return talentItem
end

function Rouge2_BackpackSkillTalentView:createLineItem()
	local goLine = gohelper.cloneInPlace(self._goLineItem, "line")

	return (MonoHelper.addNoUpdateLuaComOnceToGo(goLine, Rouge2_BackpackTalentLineItem))
end

function Rouge2_BackpackSkillTalentView:getLineItem()
	return self._lineItemPool:getObject()
end

function Rouge2_BackpackSkillTalentView:recycleLineItem(lineItem)
	if not lineItem then
		return
	end

	self._lineItemPool:putObject(lineItem)
end

function Rouge2_BackpackSkillTalentView:onOpen()
	self:refreshUI()
end

function Rouge2_BackpackSkillTalentView:onClose()
	TaskDispatcher.cancelTask(self.focusNewUnlockTalent, self)
end

function Rouge2_BackpackSkillTalentView:refreshUI()
	self:refreshTalentNum()
	self:refreshResetBtn()
	self:refreshPet()

	if self._isFirstEnter then
		TaskDispatcher.cancelTask(self.focusNewUnlockTalent, self)
		TaskDispatcher.runDelay(self.focusNewUnlockTalent, self, 0.0001)

		self._isFirstEnter = false
	end
end

function Rouge2_BackpackSkillTalentView:refreshTalentNum()
	self._txtTalentNum.text = Rouge2_BackpackModel.instance:getCanUseTalentPoint()
end

function Rouge2_BackpackSkillTalentView:refreshResetBtn()
	self._isCanReset = Rouge2_BackpackController.instance:isCanResetTalentStage()

	gohelper.setActive(self._goEnableReset, self._isCanReset)
	gohelper.setActive(self._goDisableReset, not self._isCanReset)
end

function Rouge2_BackpackSkillTalentView:_onUpdateRougeInfo()
	self:refreshUI()
end

function Rouge2_BackpackSkillTalentView:initPet()
	self._petItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._goPet, Rouge2_BackpackTalentPetItem)
end

function Rouge2_BackpackSkillTalentView:refreshPet()
	if self._petItem then
		self._petItem:onUpdateMO()
	end
end

function Rouge2_BackpackSkillTalentView:focusNewUnlockTalent()
	local newUnlockTalentId = Rouge2_BackpackController.instance:getNewUnlockTalentId()
	local talentItem = newUnlockTalentId and self:getTalentItemById(newUnlockTalentId)

	if not talentItem then
		return
	end

	ZProj.UGUIHelper.RebuildLayout(self._goTalentContainer.transform)

	local offset = gohelper.fitScrollItemOffset(self._goTalentContainer, self._goContent, talentItem:getViewGO(), ScrollEnum.ScrollDirH)

	offset = offset < 0 and offset - self._halfViewPortWidth or offset + self._halfViewPortWidth

	recthelper.setAnchorX(self._goContent.transform, offset)
end

function Rouge2_BackpackSkillTalentView:onDestroyView()
	if self._lineItemPool then
		self._lineItemPool:dispose()

		self._lineItemPool = nil
	end
end

return Rouge2_BackpackSkillTalentView
