-- chunkname: @modules/logic/college/view/building/CollegeBuildingUpgradeView.lua

module("modules.logic.college.view.building.CollegeBuildingUpgradeView", package.seeall)

local CollegeBuildingUpgradeView = class("CollegeBuildingUpgradeView", BaseViewExtended)

function CollegeBuildingUpgradeView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO_parent_obj, "Bottom/#go_TitleArea/#txt_Title")
	self._goLevelTransition = gohelper.findChild(self.viewGO, "#go_LevelTransition")
	self._imageLevelFrom = gohelper.findChildImage(self.viewGO, "#go_LevelTransition/#image_LevelFrom")
	self._imageLevelTo = gohelper.findChildImage(self.viewGO, "#go_LevelTransition/#image_LevelTo")
	self._txtBuildingPreviewGain = gohelper.findChildText(self.viewGO, "#txt_BuildPreviewGain")
	self._btnUpgrade = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_Upgrade")
	self._btnBuild = gohelper.findChildButtonWithAudio(self.viewGO_parent_obj, "Bottom/#go_Btns/#btn_Build")
	self._goUpgrade = self._btnUpgrade.gameObject
	self._goBuild = self._btnBuild.gameObject
end

function CollegeBuildingUpgradeView:addEvents()
	self._btnUpgrade:AddClickListener(self._btnUpgradeOnClick, self)
	self._btnBuild:AddClickListener(self._btnBuildOnClick, self)
end

function CollegeBuildingUpgradeView:removeEvents()
	self._btnUpgrade:RemoveClickListener()
	self._btnBuild:RemoveClickListener()
end

function CollegeBuildingUpgradeView:_btnUpgradeOnClick()
	CollegeModel.instance:setMsgLock(true)
	CollegeRpc.instance:sendCollegeBuildingUpgrade(self._buildingId, self._onUpgradeDoneCallback, self)
end

function CollegeBuildingUpgradeView:_btnBuildOnClick()
	CollegeModel.instance:setMsgLock(true)
	CollegeRpc.instance:sendCollegeBuildingUpgrade(self._buildingId, self._onUpgradeDoneCallback, self)
end

function CollegeBuildingUpgradeView:_onUpgradeDoneCallback(_, resultCode)
	if resultCode ~= 0 then
		CollegeModel.instance:setMsgLock(false)

		return
	end

	self:getParentView():onCloseClick()
	CollegeHelper.instance:setViewVisible("BuildingUpgradeAnim", true)
	UIBlockHelper.instance:startBlock("BuildingUpgradeAnim", 1.91)
	UIBlockMgrExtend.instance:resetMaskShow()
	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeCameraSizeType, CollegeEnum.DungeonMapCameraSizeType.Low, 0.2, self._playUpgradeAnim, self)
end

function CollegeBuildingUpgradeView:_playUpgradeAnim()
	CollegeController.instance:dispatchEvent(CollegeEvent.PlayBuildingUpgradeAnim, self._buildingId)
	CollegeModel.instance:setMsgLock(false)
	TaskDispatcher.runDelay(self._animEnd, self, 1.5)
end

function CollegeBuildingUpgradeView:_animEnd()
	CollegeStoryHelper.instance:setLockPlayStory(true)
	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeCameraSizeType, CollegeEnum.DungeonMapCameraSizeType.Middle, 0.2, self._showViews, self)
end

function CollegeBuildingUpgradeView:_showViews()
	CollegeStoryHelper.instance:setLockPlayStory(false)
	CollegeHelper.instance:setViewVisible("BuildingUpgradeAnim", false)
	CollegeController.instance:showToast(GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_toast_building_lvup"), self._buildingName))
	CollegeController.instance:dispatchEvent(CollegeEvent.OnBuildingLvChange, CollegeHelper.checkBuildingLv)
end

function CollegeBuildingUpgradeView:onOpen()
	self:initData()
	self:refreshUI()
end

function CollegeBuildingUpgradeView:onSetExclusiveViewVisible(state)
	self:setViewVisible(state)

	if not state then
		return
	end

	self:initData()
	self:refreshUI()
end

function CollegeBuildingUpgradeView:initData()
	self._buildingMo = self.viewContainer.viewParam.data
	self._buildingId = self._buildingMo.id
	self._buildingLv = self._buildingMo.level
	self._maxLvCo = CollegeConfig.instance:getBuildingMaxLvConfig(self._buildingId)

	if self._maxLvCo then
		self._maxLv = self._maxLvCo.level or 0
	end

	self._isMaxLv = self._buildingLv >= self._maxLv
	self._buildingName = self._buildingMo.co.name
	self._nextLvCo = self._buildingMo.nextLvCo
	self._upgradeCost = self._buildingMo.upgradeCost
end

function CollegeBuildingUpgradeView:refreshUI()
	local desc = CollegeHelper.instance:getBuildingDesc(self._nextLvCo)
	local isUpgrade = self._buildingLv > 0 and not self._isMaxLv

	if isUpgrade then
		CollegeIconHelper.setBuildingLv(self._imageLevelFrom, self._buildingLv)
		CollegeIconHelper.setBuildingLv(self._imageLevelTo, self._buildingLv + 1)

		self._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_buildinginfoview_upgradetitle"), self._buildingName)
	else
		self._txtTitle.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("college_buildinginfoview_buildtitle"), self._buildingName)
	end

	self._txtBuildingPreviewGain.text = desc

	gohelper.setActive(self._goLevelTransition, isUpgrade)
	gohelper.setActive(self._goBuild, self._buildingLv <= 0)
	gohelper.setActive(self._goUpgrade, self._buildingLv > 0 and not self._isMaxLv)
	self:getParentView():refreshCost(self._upgradeCost)
end

function CollegeBuildingUpgradeView:onClose()
	CollegeHelper.instance:setViewVisible("BuildingUpgradeAnim", false)
	TaskDispatcher.cancelTask(self._animEnd, self)
end

return CollegeBuildingUpgradeView
