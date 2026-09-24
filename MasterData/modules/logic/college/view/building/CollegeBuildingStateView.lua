-- chunkname: @modules/logic/college/view/building/CollegeBuildingStateView.lua

module("modules.logic.college.view.building.CollegeBuildingStateView", package.seeall)

local CollegeBuildingStateView = class("CollegeBuildingStateView", BaseViewExtended)

function CollegeBuildingStateView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO_parent_obj, "Bottom/#go_TitleArea/#txt_Title")
	self._btnRecruit = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_Recruit")
	self._btnRefresh = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_Refresh")
	self._btnGoBuild = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_GoBuild")
	self._btnGoUpGrade = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_GoUpgrade")
	self._btnMilestone = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_Milestone")
	self._goRecruit = self._btnRecruit.gameObject
	self._goRefresh = self._btnRefresh.gameObject
	self._goGoBuild = self._btnGoBuild.gameObject
	self._goGoUpgrade = self._btnGoUpGrade.gameObject
	self._goMilestone = self._btnMilestone.gameObject
	self._goBuildInfo = gohelper.findChild(self.viewGO, "#go_BuildInfo")
	self._goInfoDispatch = gohelper.findChild(self.viewGO, "#go_InfoDispatch")
	self._goInfoBuff = gohelper.findChild(self.viewGO, "#go_InfoBuff")
	self._compList = {}

	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goBuildInfo, CollegeBuildingInfoView))
	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goInfoDispatch, CollegeBuildingActorSlotView))
	table.insert(self._compList, MonoHelper.addNoUpdateLuaComOnceToGo(self._goInfoBuff, CollegeBuildingRefinedPropView))
end

function CollegeBuildingStateView:addEvents()
	self._btnGoBuild:AddClickListener(self._btnGoBuildOnClick, self)
	self._btnGoUpGrade:AddClickListener(self._btnGoUpGradeOnClick, self)
	self._btnRecruit:AddClickListener(self._btnRecruitOnClick, self)
	self._btnRefresh:AddClickListener(self._btnRefreshOnClick, self)
	self._btnMilestone:AddClickListener(self._btnMilestoneOnClick, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnServerMsgUpdate, self.refresh, self)
end

function CollegeBuildingStateView:removeEvents()
	self._btnGoBuild:RemoveClickListener()
	self._btnGoUpGrade:RemoveClickListener()
	self._btnRecruit:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
	self._btnMilestone:RemoveClickListener()
end

function CollegeBuildingStateView:_btnGoBuildOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	self:getParentView():switchViewType(CollegeBuildingView.ViewType.Upgrade)
end

function CollegeBuildingStateView:_btnGoUpGradeOnClick()
	if not self._isEnough then
		GameFacade.showToast(ToastEnum.CollegeItemNotEnough)

		return
	end

	self:getParentView():switchViewType(CollegeBuildingView.ViewType.Upgrade)
end

function CollegeBuildingStateView:_btnRecruitOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRecruitView)
end

function CollegeBuildingStateView:_btnRefreshOnClick()
	ViewMgr.instance:openView(ViewName.CollegeRoleRefinedView)
end

function CollegeBuildingStateView:_btnMilestoneOnClick()
	ViewMgr.instance:openView(ViewName.CollegeMilestoneView)
end

function CollegeBuildingStateView:onOpen()
	self:refresh()
end

function CollegeBuildingStateView:onClose()
	return
end

function CollegeBuildingStateView:onSetExclusiveViewVisible(state)
	self:setViewVisible(state)

	if not state then
		return
	end

	self:refresh()
end

function CollegeBuildingStateView:refresh()
	self:initData()
	self:refreshUI()
end

function CollegeBuildingStateView:initData()
	self._buildingMo = self.viewContainer.viewParam.data
	self._buildingCo = self._buildingMo.co
	self._buildingId = self._buildingMo.id
	self._buildingLv = self._buildingMo and self._buildingMo.level
	self._maxLvCo = CollegeConfig.instance:getBuildingMaxLvConfig(self._buildingId)

	if self._maxLvCo then
		self._maxLv = self._maxLvCo.level or 0
	end

	self._isMaxLv = self._buildingLv >= self._maxLv
	self._upgradeCost = self._buildingMo.upgradeCost
	self._isCanUse = self._buildingLv > 0
end

function CollegeBuildingStateView:refreshUI()
	self:refreshOtherBtn()
	gohelper.setActive(self._goGoBuild, not self._isCanUse)
	gohelper.setActive(self._goGoUpgrade, self._isCanUse and not self._isMaxLv)
	self:getParentView():refreshCost(self._upgradeCost)

	if not self._isMaxLv then
		self._isEnough = CollegeModel.instance:isEnoughItemsTb(self._upgradeCost)

		ZProj.UGUIHelper.SetGrayscale(self._goGoBuild, not self._isEnough)
		ZProj.UGUIHelper.SetGrayscale(self._goGoUpgrade, not self._isEnough)
	end

	self._txtTitle.text = self._buildingCo and self._buildingCo.name

	for _, comp in ipairs(self._compList) do
		comp:onUpdateMO(self._buildingMo)
	end
end

function CollegeBuildingStateView:refreshOtherBtn()
	local buildingType = self._buildingCo.buildingType

	gohelper.setActive(self._goRefresh, self._isCanUse and buildingType == CollegeEnum.BuildingType.TrainCharacter)
	gohelper.setActive(self._goRecruit, self._isCanUse and buildingType == CollegeEnum.BuildingType.RecruitCharacter)
	gohelper.setActive(self._goMilestone, self._isCanUse and buildingType == CollegeEnum.BuildingType.OpenReward)
end

return CollegeBuildingStateView
