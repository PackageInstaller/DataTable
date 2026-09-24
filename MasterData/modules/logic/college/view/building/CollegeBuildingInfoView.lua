-- chunkname: @modules/logic/college/view/building/CollegeBuildingInfoView.lua

module("modules.logic.college.view.building.CollegeBuildingInfoView", package.seeall)

local CollegeBuildingInfoView = class("CollegeBuildingInfoView", ListScrollCellExtend)
local BuildingCanUseAlpha = 1
local BuildingCantUseAlpha = 0.5

function CollegeBuildingInfoView:onInitView()
	self._imageBuildingLevel = gohelper.findChildImage(self.viewGO, "txt_BuildingLevelLabel/#image_BuildingLevel")
	self._txtFunctionDescr = gohelper.findChildText(self.viewGO, "#scroll_FunctionDescr/Viewport/#txt_FunctionDescr")
	self._canvasgroup = gohelper.onceAddComponent(self.viewGO, gohelper.Type_CanvasGroup)
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	gohelper.setActive(self.viewGO, true)

	self._ignoreToastViewList = {
		ViewName.CollegeToastView,
		ViewName.ToastView,
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	}
end

function CollegeBuildingInfoView:addEvents()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self.addEventCb(self, CollegeController.instance, CollegeEvent.OnStoryPlayEnd, self._onStoryPlayEnd, self)
end

function CollegeBuildingInfoView:onUpdateMO(buildingMo)
	self:initData(buildingMo or self._buildingMo)
	self:refreshUI()
end

function CollegeBuildingInfoView:initData(buildingMo)
	self._preBuildingMo = self._buildingMo
	self._preBuildingLv = self._buildingLv
	self._buildingMo = buildingMo
	self._buildingId = buildingMo.id
	self._buildingLv = buildingMo.level
	self._showLevel = math.max(self._buildingLv, 1)

	local buildingLvMap = lua_college_building_level.configDict[self._buildingId]

	self._showBuildingLvCo = buildingLvMap and buildingLvMap[self._showLevel]
end

function CollegeBuildingInfoView:refreshUI()
	if self._needPlayAnim then
		return
	end

	local isLevelUp = self._preBuildingMo == self._buildingMo and self._preBuildingLv < self._buildingLv

	if isLevelUp then
		self._needPlayAnim = true

		self:tryPlayLevelUpAnim()

		return
	end

	self:_reallyRefreshUI()
end

function CollegeBuildingInfoView:tryPlayLevelUpAnim()
	if not self._needPlayAnim then
		return
	end

	if CollegeStoryHelper.instance:isPlayingStory() then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.CollegeBuildingView, self._ignoreToastViewList) then
		return
	end

	self._needPlayAnim = false

	self._animator:Play("leveup", 0, 0)
	UIBlockHelper.instance:startBlock("CollegeBuildingInfoView_RefreshUI", 0.16)
	TaskDispatcher.cancelTask(self._reallyRefreshUI, self)
	TaskDispatcher.runDelay(self._reallyRefreshUI, self, 0.16)
end

function CollegeBuildingInfoView:_reallyRefreshUI()
	CollegeIconHelper.setBuildingLv(self._imageBuildingLevel, self._showLevel)

	self._txtFunctionDescr.text = CollegeHelper.instance:getBuildingDesc(self._showBuildingLvCo)

	local isCantUse = self._buildingLv <= 0

	if isCantUse then
		if not BuildingCantUseAlpha then
			self._canvasgroup.alpha = BuildingCanUseAlpha
		end
	end
end

function CollegeBuildingInfoView:_onCloseViewFinish(viewName)
	if viewName == ViewName.CollegeBuildingView then
		return
	end

	self:tryPlayLevelUpAnim()
end

function CollegeBuildingInfoView:_onStoryPlayEnd()
	self:tryPlayLevelUpAnim()
end

function CollegeBuildingInfoView:onDestroyView()
	UIBlockHelper.instance:endBlock("CollegeBuildingInfoView_RefreshUI")
	TaskDispatcher.cancelTask(self._reallyRefreshUI, self)
end

return CollegeBuildingInfoView
