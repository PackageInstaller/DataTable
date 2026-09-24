-- chunkname: @modules/logic/college/view/role/CollegeRoleBasePanelItem.lua

module("modules.logic.college.view.role.CollegeRoleBasePanelItem", package.seeall)

local CollegeRoleBasePanelItem = class("CollegeRoleBasePanelItem", ListScrollCellExtend)

function CollegeRoleBasePanelItem:ctor(parentView)
	CollegeRoleBasePanelItem.super.ctor(self, parentView)

	self._view = parentView
end

function CollegeRoleBasePanelItem:onInitView()
	self._goHas = gohelper.findChild(self.viewGO, "has")
	self._simageBG = gohelper.findChildSingleImage(self.viewGO, "has/#image_PanelBG")
	self._goRoleItem = gohelper.findChild(self.viewGO, "has/#go_roleitem")
	self._txtName = gohelper.findChildText(self.viewGO, "has/#txt_Name")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "has/#btn_Exit")
	self._goBuffContent = gohelper.findChild(self.viewGO, "has/#scroll_Buff/Viewport/Content")
	self._goBuffItem = gohelper.findChild(self.viewGO, "has/#scroll_Buff/Viewport/Content/#go_buff")
	self._goCostRow = gohelper.findChild(self.viewGO, "has/#go_CostRow")
	self._goCostItem = gohelper.findChild(self.viewGO, "has/#go_CostRow/#go_Cost")
	self._btnUpGrade = gohelper.findChildButtonWithAudio(self.viewGO, "has/#btn_UpGrade")
	self._btnRecruit = gohelper.findChildButtonWithAudio(self.viewGO, "has/#btn_Recruit")
	self._goTips = gohelper.findChild(self.viewGO, "has/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "has/#go_Tips/#txt_Tips")
	self._goEmpty = gohelper.findChild(self.viewGO, "empty")
	self._goAdd = gohelper.findChild(self.viewGO, "add")
	self._canvasAdd = gohelper.onceAddComponent(self._goAdd, gohelper.Type_CanvasGroup)
	self._btnClick = gohelper.getClickWithDefaultAudio(self.viewGO)
	self._goBtnExit = self._btnExit.gameObject
	self._goBtnUpGrade = self._btnUpGrade.gameObject
	self._goBtnRecruit = self._btnRecruit.gameObject
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)

	local animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	animator.keepAnimatorStateOnDisable = true

	self:initBgRareEffect()
end

function CollegeRoleBasePanelItem:addEvents()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnExit:AddClickListener(self._btnExitOnClick, self)
	self._btnUpGrade:AddClickListener(self._btnUpGradeOnClick, self)
	self._btnRecruit:AddClickListener(self._btnRecruitOnClick, self)
end

function CollegeRoleBasePanelItem:removeEvents()
	self._btnClick:RemoveClickListener()
	self._btnExit:RemoveClickListener()
	self._btnUpGrade:RemoveClickListener()
	self._btnRecruit:RemoveClickListener()
end

function CollegeRoleBasePanelItem:_btnClickOnClick()
	return
end

function CollegeRoleBasePanelItem:_btnExitOnClick()
	return
end

function CollegeRoleBasePanelItem:_btnUpGradeOnClick()
	return
end

function CollegeRoleBasePanelItem:_btnRecruitOnClick()
	return
end

function CollegeRoleBasePanelItem:createHeadIcon()
	if self._roleItem then
		return
	end

	local goRoleIconItem = self._view:getResInst(CollegeEnum.PrefabPath.RoleItem, self._goRoleItem)

	self._roleItem = MonoHelper.addNoUpdateLuaComOnceToGo(goRoleIconItem, CollegeRoleBaseListItem)
end

function CollegeRoleBasePanelItem:initBgRareEffect()
	self._rareEffectTab = self:getUserDataTb_()
	self._rareEffectTab[3] = gohelper.findChild(self._simageBG.gameObject, "vx_ssr")
	self._rareEffectTab[2] = gohelper.findChild(self._simageBG.gameObject, "vx_sr")
end

function CollegeRoleBasePanelItem:onUpdateMO(mo)
	self:reset()

	self._mo = mo
	self._preHasInfo = self._hasInfo
	self._hasInfo = self._mo ~= nil

	gohelper.setActive(self._goHas, self._hasInfo)
	gohelper.setActive(self._goEmpty, not self._hasInfo)

	if self._preHasInfo ~= self._hasInfo then
		local animName = self._hasInfo and "has" or "empty"

		self:playAnim(animName)
	end

	if not self._hasInfo then
		self:refreshEmptyUI()

		return
	end

	self:updateData(mo)
	self:refreshUI()
end

function CollegeRoleBasePanelItem:reset()
	gohelper.setActive(self._goTips, false)
	gohelper.setActive(self._goBtnUpGrade, false)
	gohelper.setActive(self._goBtnExit, false)
	gohelper.setActive(self._goBtnRecruit, false)
	gohelper.setActive(self._goCostRow, false)
	gohelper.setActive(self._goHas, false)
	gohelper.setActive(self._goEmpty, false)
	gohelper.setActive(self._goAdd, false)

	self._canvasAdd.interactable = false
	self._canvasAdd.blocksRaycasts = false
end

function CollegeRoleBasePanelItem:updateData(mo)
	self._co = mo.co
	self._uid = mo.uid
	self._id = mo.id
	self._level = mo.level
	self._cost = mo.cost
	self._isMaxLv = mo.isMaxLv
	self._locationMo = mo.inLocationStatus
	self._isDispatch = self._locationMo ~= nil
	self._costRate = 1 + mo.attributeContainer:getAttrVal(CollegeEnum.AttrId.RoleUpgradeCostRate) / 1000
end

function CollegeRoleBasePanelItem:refreshUI()
	self:createHeadIcon()
	self:refreshCommonUI()
	self:refreshOtherUI()
end

function CollegeRoleBasePanelItem:refreshEmptyUI()
	self:refreshBgRareEffect()
end

function CollegeRoleBasePanelItem:playAnim(animName, callback, callbackObj)
	if not self.viewGO.activeInHierarchy then
		return
	end

	UIBlockHelper.instance:startBlock(self.__cname, 0.3)

	callback = callback or self._defaultAnimCallback
	callbackObj = callbackObj or self

	self._animatorPlayer:Play(animName, callback, callbackObj)
end

function CollegeRoleBasePanelItem:_defaultAnimCallback()
	return
end

function CollegeRoleBasePanelItem:refreshCommonUI()
	self._roleItem:onUpdateMO(self._mo)

	self._txtName.text = self._co and self._co.name

	local bgName = string.format("college_role_frame%d", self._co.rarity)

	self._simageBG:LoadImage(ResUrl.getCollegeSingleBg(bgName, "role"))
	self:refreshEntries()
	self:refreshBtnVisible()
	self:refreshBgRareEffect(self._co.rarity)
end

function CollegeRoleBasePanelItem:refreshBtnVisible()
	return
end

function CollegeRoleBasePanelItem:refreshEntries()
	local showEntries = self:getShowEntries()
	local hasEntries = showEntries and #showEntries > 0

	gohelper.setActive(self._goBuffContent, hasEntries)

	if not hasEntries then
		return
	end

	local entryCls = self:getEntryClass()

	gohelper.CreateObjList(self, self._refreshEntryItem, showEntries, self._goBuffContent, self._goBuffItem, entryCls)
end

function CollegeRoleBasePanelItem:getShowEntries()
	return self._mo.allEntries
end

function CollegeRoleBasePanelItem:getEntryClass()
	return CollegeRoleBaseEntryItem
end

function CollegeRoleBasePanelItem:_refreshEntryItem(entryItem, entryMo, index)
	entryItem:onUpdateMO(entryMo, self._mo, self, index)
end

function CollegeRoleBasePanelItem:refreshOtherUI()
	return
end

function CollegeRoleBasePanelItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelected, isSelect)
end

function CollegeRoleBasePanelItem:refreshCostList()
	self._costComp = self._costComp or CollegeResCostComp.Get(self._goCostRow, CollegeEnum.ItemCostColorType.Dark)

	self._costComp:onUpdateMO(self._cost, {
		self._costRate
	})
end

function CollegeRoleBasePanelItem:refreshBgRareEffect(rarity)
	rarity = rarity or 0

	for i, goEffect in pairs(self._rareEffectTab) do
		gohelper.setActive(goEffect, i == rarity)
	end
end

function CollegeRoleBasePanelItem:onDestroyView()
	self._simageBG:UnLoadImage()
	UIBlockHelper.instance:endBlock(self.__cname)
end

return CollegeRoleBasePanelItem
