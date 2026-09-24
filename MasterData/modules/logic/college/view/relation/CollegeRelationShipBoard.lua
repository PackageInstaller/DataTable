-- chunkname: @modules/logic/college/view/relation/CollegeRelationShipBoard.lua

module("modules.logic.college.view.relation.CollegeRelationShipBoard", package.seeall)

local CollegeRelationShipBoard = class("CollegeRelationShipBoard", BaseView)

function CollegeRelationShipBoard:onInitView()
	self._gopage = gohelper.findChild(self.viewGO, "#go_page")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Left")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Right")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._simageBGtop = gohelper.findChildSingleImage(self.viewGO, "#simage_BGtop")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CollegeRelationShipBoard:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CollegeRelationShipBoard:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CollegeRelationShipBoard:_btnLeftOnClick()
	self._pageIndex = self._pageIndex - 1

	self.viewContainer:changePage(self._pageIndex)
	self:_updatePageStatus()
end

function CollegeRelationShipBoard:_btnRightOnClick()
	self._pageIndex = self._pageIndex + 1

	self.viewContainer:changePage(self._pageIndex)
	self:_updatePageStatus()
end

function CollegeRelationShipBoard:_editableInitView()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._OnOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)

	self._animator = self.viewGO:GetComponent("Animator")
end

function CollegeRelationShipBoard:_OnOpenView(viewName)
	if viewName == ViewName.CollegeRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("to_detail", 0, 0)
	end
end

function CollegeRelationShipBoard:_OnCloseView(viewName)
	if viewName == ViewName.CollegeRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("back_detail", 0, 0)
	end
end

function CollegeRelationShipBoard:_onRefreshActivity()
	local max = self._pageMax

	self:_updatePageNum()

	if max ~= self._pageMax then
		self.viewContainer:changePage(self._pageIndex)
		self:_updatePageStatus()
	end
end

function CollegeRelationShipBoard:_initPageInfo()
	if CollegeController.showNewChapterPage() then
		self._pageIndex = CollegeEnum.RelationShipBoardPage.Chapter13 or CollegeEnum.RelationShipBoardPage.Default
	end

	self._pageMax = 1

	self:_updatePageNum()
	self:_updatePageStatus()
end

function CollegeRelationShipBoard:_updatePageNum()
	self._pageMax = CollegeController.showNewChapterPage() and 2 or 1
	self._pageIndex = math.min(self._pageIndex, self._pageMax)
end

function CollegeRelationShipBoard:_updatePageStatus()
	self._btnLeft.button.interactable = self._pageIndex > 1
	self._btnRight.button.interactable = self._pageIndex < self._pageMax

	gohelper.setActive(self._btnLeft, self._pageMax > 1)
	gohelper.setActive(self._btnRight, self._pageMax > 1)
end

function CollegeRelationShipBoard:_initCamera()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local path = self.viewContainer:getSetting().otherRes[1]

	animator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(path):GetResource()
	animator.enabled = true

	animator:Play("in", 0, 0)
end

function CollegeRelationShipBoard:onUpdateParam()
	return
end

function CollegeRelationShipBoard:onOpen()
	self:_initPageInfo()
	AudioMgr.instance:trigger(AudioEnum3_3.CommandStationMap.play_ui_yuanzheng_zhb_open)

	if self.viewParam and self.viewParam.fromMapView then
		return
	end

	self:_initCamera()
	TaskDispatcher.cancelTask(self._openPostProcess, self)
	TaskDispatcher.runRepeat(self._openPostProcess, self, 0)

	local go = ViewMgr.instance:getUILayer("POPUP_SECOND")

	gohelper.addChild(go, self.viewGO)

	local container = ViewMgr.instance:getContainer(ViewName.CollegeMilestoneView)

	if container and not gohelper.isNil(container.viewGO) then
		container:setVisibleInternal(false)
	end
end

function CollegeRelationShipBoard:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function CollegeRelationShipBoard:_clearCameraAnim()
	local animator = CameraMgr.instance:getCameraRootAnimator()

	animator.runtimeAnimatorController = nil

	TaskDispatcher.cancelTask(self._openPostProcess, self)
	PostProcessingMgr.instance:setUnitPPValue("radialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("RadialBlurLevel", 1)
	PostProcessingMgr.instance:setUnitPPValue("rgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitStrength", 0)
	PostProcessingMgr.instance:setUnitPPValue("splitPercent", 0)
	PostProcessingMgr.instance:setUnitPPValue("SplitPercent", 0)

	local vec = Vector2(0.5, 0.5)

	PostProcessingMgr.instance:setUnitPPValue("rgbSplitCenter", vec)
	PostProcessingMgr.instance:setUnitPPValue("RgbSplitCenter", vec)
end

function CollegeRelationShipBoard:onOpenFinish()
	local go = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(go, self.viewGO)
	self:_clearCameraAnim()
end

function CollegeRelationShipBoard:onClose()
	self:_clearCameraAnim()
end

function CollegeRelationShipBoard:onDestroyView()
	return
end

return CollegeRelationShipBoard
