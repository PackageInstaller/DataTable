-- chunkname: @modules/logic/commandstation/view/CommandStationRelationShipBoard.lua

module("modules.logic.commandstation.view.CommandStationRelationShipBoard", package.seeall)

local CommandStationRelationShipBoard = class("CommandStationRelationShipBoard", BaseView)

function CommandStationRelationShipBoard:onInitView()
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

function CommandStationRelationShipBoard:addEvents()
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CommandStationRelationShipBoard:removeEvents()
	self._btnLeft:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CommandStationRelationShipBoard:_btnLeftOnClick()
	self._pageIndex = self._pageIndex - 1

	self.viewContainer:changePage(self._pageIndex)
	self:_updatePageStatus()
end

function CommandStationRelationShipBoard:_btnRightOnClick()
	self._pageIndex = self._pageIndex + 1

	self.viewContainer:changePage(self._pageIndex)
	self:_updatePageStatus()
end

function CommandStationRelationShipBoard:_editableInitView()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self._onRefreshActivity, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._OnOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._OnCloseView, self)

	self._animator = self.viewGO:GetComponent("Animator")
end

function CommandStationRelationShipBoard:_OnOpenView(viewName)
	if viewName == ViewName.CommandStationRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("to_detail", 0, 0)
	end
end

function CommandStationRelationShipBoard:_OnCloseView(viewName)
	if viewName == ViewName.CommandStationRelationShipDetail then
		self._animator.enabled = true

		self._animator:Play("back_detail", 0, 0)
	end
end

function CommandStationRelationShipBoard:_onRefreshActivity()
	local max = self._pageMax

	self:_updatePageNum()

	if max ~= self._pageMax then
		self.viewContainer:changePage(self._pageIndex)
		self:_updatePageStatus()
	end
end

function CommandStationRelationShipBoard:_initPageInfo()
	if CommandStationController.showNewChapterPage() then
		self._pageIndex = CommandStationEnum.RelationShipBoardPage.Chapter13 or CommandStationEnum.RelationShipBoardPage.Default
	end

	self._pageMax = 1

	self:_updatePageNum()
	self:_updatePageStatus()
end

function CommandStationRelationShipBoard:_updatePageNum()
	self._pageMax = CommandStationController.showNewChapterPage() and 2 or 1
	self._pageIndex = math.min(self._pageIndex, self._pageMax)
end

function CommandStationRelationShipBoard:_updatePageStatus()
	self._btnLeft.button.interactable = self._pageIndex > 1
	self._btnRight.button.interactable = self._pageIndex < self._pageMax

	gohelper.setActive(self._btnLeft, self._pageMax > 1)
	gohelper.setActive(self._btnRight, self._pageMax > 1)
end

function CommandStationRelationShipBoard:_initCamera()
	local animator = CameraMgr.instance:getCameraRootAnimator()
	local path = self.viewContainer:getSetting().otherRes[1]

	animator.runtimeAnimatorController = self.viewContainer._abLoader:getAssetItem(path):GetResource()
	animator.enabled = true

	animator:Play("in", 0, 0)
end

function CommandStationRelationShipBoard:onUpdateParam()
	return
end

function CommandStationRelationShipBoard:onOpen()
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

	local container = ViewMgr.instance:getContainer(ViewName.CommandStationEnterView)

	if container and not gohelper.isNil(container.viewGO) then
		container:setVisibleInternal(false)
	end
end

function CommandStationRelationShipBoard:_openPostProcess()
	PostProcessingMgr.instance:setUIActive(true)
end

function CommandStationRelationShipBoard:_clearCameraAnim()
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

function CommandStationRelationShipBoard:onOpenFinish()
	local go = ViewMgr.instance:getUILayer(UILayerName.PopUpTop)

	gohelper.addChild(go, self.viewGO)
	self:_clearCameraAnim()
end

function CommandStationRelationShipBoard:onClose()
	self:_clearCameraAnim()
end

function CommandStationRelationShipBoard:onDestroyView()
	return
end

return CommandStationRelationShipBoard
