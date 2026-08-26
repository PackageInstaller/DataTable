-- chunkname: @modules/logic/rouge2/bossbattle/view/Rouge2_SaveInfoListItem.lua

module("modules.logic.rouge2.bossbattle.view.Rouge2_SaveInfoListItem", package.seeall)

local Rouge2_SaveInfoListItem = class("Rouge2_SaveInfoListItem", ListScrollCellExtend)

function Rouge2_SaveInfoListItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_SaveInfoListItem)
end

function Rouge2_SaveInfoListItem:onInitView()
	self._goHas = gohelper.findChild(self.viewGO, "#go_Has")
	self._imageCareerIcon = gohelper.findChildImage(self.viewGO, "#go_Has/#go_Career/#image_CareerIcon")
	self._txtCareerName = gohelper.findChildText(self.viewGO, "#go_Has/#go_Career/#txt_CareerName")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Has/#btn_Detail")
	self._goAttrList = gohelper.findChild(self.viewGO, "#go_Has/#go_AttrList")
	self._goAttrItem = gohelper.findChild(self.viewGO, "#go_Has/#go_AttrList/#go_AttrItem")
	self._goActiveSkill = gohelper.findChild(self.viewGO, "#go_Has/#go_ActiveSkill")
	self._goHeroGroup = gohelper.findChild(self.viewGO, "#go_Has/#go_HeroGroup")
	self._btnReplace = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Has/#btn_Replace")
	self._btnReplace2 = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Has/#btn_Replace2")
	self._goNotReplace = gohelper.findChild(self.viewGO, "#go_Has/#go_NotReplace")
	self._goCover = gohelper.findChild(self.viewGO, "#go_Has/#go_Cover")
	self._btnUse = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Has/#btn_Use")
	self._goInUse = gohelper.findChild(self.viewGO, "#go_Has/#go_InUse")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._goEmptyShow = gohelper.findChild(self.viewGO, "#go_Empty/#go_EmptyShow")
	self._btnAdd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Empty/#btn_Add")
	self._imageAssessBg = gohelper.findChildImage(self.viewGO, "#go_Has/#image_AssessBg")
	self._imageAssess = gohelper.findChildImage(self.viewGO, "#go_Has/#image_AssessBg/#image_Assess")
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_SaveInfoListItem:initInternal(go, view)
	Rouge2_SaveInfoListItem.super.initInternal(self, go, view)

	if view and self._activeSkillComp then
		local scrollRect = view:getCsListScroll()

		self._activeSkillComp:setParentScroll(scrollRect.gameObject)
	end
end

function Rouge2_SaveInfoListItem:addEvents()
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnReplace:AddClickListener(self._btnReplaceOnClick, self)
	self._btnReplace2:AddClickListener(self._btnReplace2OnClick, self)
	self._btnUse:AddClickListener(self._btnUseOnClick, self)
	self._btnAdd:AddClickListener(self._btnAddOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Rouge2_SaveInfoListItem:removeEvents()
	self._btnDetail:RemoveClickListener()
	self._btnReplace:RemoveClickListener()
	self._btnReplace2:RemoveClickListener()
	self._btnUse:RemoveClickListener()
	self._btnAdd:RemoveClickListener()
end

function Rouge2_SaveInfoListItem:_btnDetailOnClick()
	Rouge2_ViewHelper.openSaveInfoDetailView({
		saveInfo = self._saveInfo
	})
end

function Rouge2_SaveInfoListItem:_btnReplaceOnClick()
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		return
	end

	Rouge2_SaveInfoListModel.instance:onReadyReplace(self._index)
end

function Rouge2_SaveInfoListItem:_btnReplace2OnClick()
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		return
	end

	self._animator:Play("light", 0, 0)
	Rouge2_SaveInfoListModel.instance:markLastSelectIndex(self._index)
	Rouge2_FightRecordController.instance:replaceRecord(self._index)
end

function Rouge2_SaveInfoListItem:_btnUseOnClick()
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Use then
		return
	end

	Rouge2_FightRecordController.instance:setUseRecordIndex(self._index)
end

function Rouge2_SaveInfoListItem:_btnAddOnClick()
	if self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit then
		return
	end

	Rouge2_SaveInfoListModel.instance:markLastSelectIndex(self._index)
	Rouge2_FightRecordController.instance:replaceRecord(self._index)
end

function Rouge2_SaveInfoListItem:_editableInitView()
	self._heroGroupComp = Rouge2_SaveInfoHeroGroupComp.Get(self._goHeroGroup)
	self._activeSkillComp = Rouge2_SaveInfoActiveSkillComp.Get(self._goActiveSkill, Rouge2_Enum.CommonSkillIconType.Type_1)

	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.IsShowSystemName, false)
	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.Scale, Vector2(1.3, 1.3))
	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.Spacing, 34)
	self._activeSkillComp:updateSystemParam(Rouge2_Enum.TeamRecommendParam.MinIconWidth, 70)

	self._goReplace = self._btnReplace.gameObject
	self._goReplace2 = self._btnReplace2.gameObject
	self._goUse = self._btnUse.gameObject
end

function Rouge2_SaveInfoListItem:onUpdateMO(mo)
	self._mo = mo
	self._saveInfo = self._mo and self._mo.saveInfo
	self._reviewInfo = self._saveInfo and self._saveInfo:getReviewInfo()

	if self._mo then
		self._viewType = self._mo.viewType or Rouge2_OutsideEnum.SaveInfoViewType.Show
	end

	self._hasRecord = self._saveInfo ~= nil

	self:refreshUI()
end

function Rouge2_SaveInfoListItem:refreshUI()
	gohelper.setActive(self._goHas, self._hasRecord)
	gohelper.setActive(self._goEmpty, not self._hasRecord)

	if not self._hasRecord then
		self:refreshEmpty()

		return
	end

	self:refreshBaseInfo()
	self:refreshHeroInfo()
	self:refreshAttrInfo()
	self:refreshSkillInfo()
end

function Rouge2_SaveInfoListItem:refreshEmpty()
	gohelper.setActive(self._btnAdd.gameObject, self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.Edit)
	gohelper.setActive(self._goEmptyShow, self._viewType ~= Rouge2_OutsideEnum.SaveInfoViewType.Edit)
end

function Rouge2_SaveInfoListItem:refreshBaseInfo()
	local careerId = self._reviewInfo:getCareerId()

	Rouge2_IconHelper.setCareerName(careerId, self._txtCareerName)
	Rouge2_IconHelper.setCareerIcon(careerId, self._imageCareerIcon, Rouge2_Enum.CareerIconSuffix.Mini)

	local isEditType = self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.Edit
	local useSaveIndex = Rouge2_FightRecordController.instance:getUseSaveIndex()
	local curReplaceIndex = Rouge2_SaveInfoListModel.instance:getReplaceIndex()
	local lastSelectIndex = Rouge2_SaveInfoListModel.instance:getLastSelectIndex()
	local isCurReplace = curReplaceIndex == self._index
	local isLastSelect = lastSelectIndex == self._index

	gohelper.setActive(self._goUse, self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.Use)
	gohelper.setActive(self._goReplace, isEditType and not isCurReplace)
	gohelper.setActive(self._goReplace2, isEditType and isCurReplace)
	gohelper.setActive(self._goNotReplace, self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.EditDone and isLastSelect)
	gohelper.setActive(self._goCover, self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.EditDone and not isLastSelect)
	gohelper.setActive(self._goInUse, self._viewType == Rouge2_OutsideEnum.SaveInfoViewType.Use and self._index == useSaveIndex)

	local score = self._reviewInfo:getScore()

	Rouge2_IconHelper.setResultAssessIcon(score, self._imageAssess, self._imageAssessBg)
end

function Rouge2_SaveInfoListItem:refreshHeroInfo()
	if self._reviewInfo then
		local lastTeamInfoList = self._reviewInfo:getLastTeamInfoList()

		self._heroGroupComp:onUpdateMO(self._reviewInfo)
	end
end

function Rouge2_SaveInfoListItem:refreshAttrInfo()
	local leaderAttrInfoList = self._reviewInfo and self._reviewInfo:getLeaderAttrInfoList() or {}

	gohelper.CreateObjList(self, self._refreshAttrItem, leaderAttrInfoList, self._goAttrList, self._goAttrItem)
end

function Rouge2_SaveInfoListItem:_refreshAttrItem(goItem, attrInfo, index)
	local imageIcon = gohelper.findChildImage(goItem, "image_Icon")
	local txtValue = gohelper.findChildText(goItem, "txt_Value")

	Rouge2_IconHelper.setAttributeIcon(attrInfo.id, imageIcon, Rouge2_Enum.AttrIconSuffix.Small)

	txtValue.text = tostring(attrInfo.value)
end

function Rouge2_SaveInfoListItem:refreshSkillInfo()
	if self._reviewInfo then
		local skillList = self._reviewInfo:getItemList(Rouge2_Enum.BagType.ActiveSkill)

		self._activeSkillComp:onUpdateMO(Rouge2_Enum.ItemDataType.Config, self._reviewInfo)
	end
end

function Rouge2_SaveInfoListItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_SaveInfoView then
		return
	end

	if self.viewGO.activeInHierarchy then
		self._animator:Play("close", 0, 0)
	end
end

function Rouge2_SaveInfoListItem:onDestroyView()
	return
end

return Rouge2_SaveInfoListItem
