-- chunkname: @modules/logic/versionactivity2_5/act187/view/Activity187PaintingView.lua

module("modules.logic.versionactivity2_5.act187.view.Activity187PaintingView", package.seeall)

local Activity187PaintingView = class("Activity187PaintingView", BaseView)
local REWARD_HAS_GET_ANIM_TIME = 1
local MOUSE_PAUSE_TIME = 0.3

function Activity187PaintingView:onInitView()
	self._btnclose = gohelper.findChildClickWithDefaultAudio(self.viewGO, "v2a5_lanternfestivalpainting/#btn_close")
	self._golowribbon = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#go_decorationLower")
	self._simagelantern = gohelper.findChildSingleImage(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern")
	self._goupribbon = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#go_decorationUpper")
	self._simagepicturebg = gohelper.findChildSingleImage(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow")
	self._simagepicture = gohelper.findChildSingleImage(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#simage_pictureshadow/#simage_picture")
	self._goriddles = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles")
	self._txtriddles = gohelper.findChildText(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#txt_riddles")
	self._goriddlesRewards = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards")
	self._goriddlesRewardItem = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#simage_lantern/#go_riddles/#go_riddlesRewards/#go_riddlesRewardItem")
	self._gopaintTips = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#go_paintTips")
	self._gopaintingArea = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/#go_paintingArea")
	self._gofinishVx = gohelper.findChild(self.viewGO, "v2a5_lanternfestivalpainting/vx_finish")
	self._rawimage = self._gopaintingArea:GetComponent(gohelper.Type_RawImage)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity187PaintingView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._drag:AddDragBeginListener(self._onDragBegin, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddDragEndListener(self._onDragEnd, self)
	self.addEventCb(self, Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, self._onDisplayChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self._onOpenView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Activity187PaintingView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._drag:RemoveDragBeginListener()
	self._drag:RemoveDragListener()
	self._drag:RemoveDragEndListener()
	self.removeEventCb(self, Activity187Controller.instance, Activity187Event.PaintViewDisplayChange, self._onDisplayChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function Activity187PaintingView:_btncloseOnClick()
	self.viewContainer:setPaintingViewDisplay()
end

function Activity187PaintingView:_onDragBegin(param, pointerEventData)
	if self._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	self:setPaintStatus(Activity187Enum.PaintStatus.Painting)
	self:_onDrag(param, pointerEventData)
	TaskDispatcher.cancelTask(self._checkMouseMove, self)
	TaskDispatcher.runRepeat(self._checkMouseMove, self, MOUSE_PAUSE_TIME)
end

function Activity187PaintingView:_onDrag(param, pointerEventData)
	if self._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	self._mouseMove = true

	self:_playPaintingAudio(true)
	self._writingBrush:OnMouseMove(pointerEventData.position.x, pointerEventData.position.y)
end

function Activity187PaintingView:_checkMouseMove()
	if not self._mouseMove then
		self:_playPaintingAudio(false)
	end

	self._mouseMove = false
end

function Activity187PaintingView:_playPaintingAudio(isPlay)
	if self._isPlayPaintingAudio == isPlay then
		return
	end

	if isPlay then
		if not AudioEnum.Act187.play_ui_tangren_yuanxiao_draw_loop then
			local audioName = AudioEnum.Act187.stop_ui_tangren_yuanxiao_draw_loop

			AudioMgr.instance:trigger(audioName)

			self._isPlayPaintingAudio = isPlay
		end
	end
end

function Activity187PaintingView:_onDragEnd(param, pointerEventData)
	self:_playPaintingAudio(false)

	if self._status == Activity187Enum.PaintStatus.Finish then
		return
	end

	self._writingBrush:OnMouseUp()

	local isShowPaintingView = self.viewContainer:isShowPaintView()

	if isShowPaintingView then
		self._paintAreaAnimatorPlayer:Play("close", self._onCloseAreaFinish, self)
		Activity187Controller.instance:finishPainting(self.onPainFinish, self)
	end

	self._mouseMove = false

	TaskDispatcher.cancelTask(self._checkMouseMove, self)
end

function Activity187PaintingView:_onCloseAreaFinish()
	self._writingBrush:Clear()
	gohelper.setActive(self._gopaintingArea, false)
end

function Activity187PaintingView:onPainFinish(cmd, resultCode, msg)
	if resultCode == 0 then
		self._rewardsMaterials = MaterialRpc.receiveMaterial({
			dataList = msg.randomBonusList
		})

		UIBlockMgr.instance:startBlock(Activity187Enum.BlockKey.GetPaintingReward)
		TaskDispatcher.cancelTask(self._showMaterials, self)
		TaskDispatcher.runDelay(self._showMaterials, self, REWARD_HAS_GET_ANIM_TIME)
	end

	self:setPaintStatus(Activity187Enum.PaintStatus.Finish)
end

function Activity187PaintingView:_showMaterials()
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, self._rewardsMaterials)

	self._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)
end

function Activity187PaintingView:_onDisplayChange(isShow, index)
	self._mouseMove = false

	if isShow then
		self:ready2Paint(index)
	else
		TaskDispatcher.cancelTask(self._checkMouseMove, self)
		self:_playPaintingAudio(false)
		gohelper.setActive(self._gopaintingArea, false)
	end
end

function Activity187PaintingView:ready2Paint(index)
	self._curIndex = index

	self._writingBrush:OnMouseUp()

	if self._rawimage.texture then
		self._writingBrush:Clear()
	end

	self:setPaintStatus(Activity187Enum.PaintStatus.Ready)
	self._paintAreaAnimator:Play("idle", 0, 0)
end

function Activity187PaintingView:_onOpenView(viewName)
	if viewName ~= ViewName.CommonPropView or not self._waitOpenCommonProp then
		return
	end

	local lantern = Activity187Enum.EmptyLantern
	local ribbonIndex
	local rewardId = Activity187Model.instance:getPaintingRewardId(self._curIndex)

	if rewardId then
		local actId = Activity187Model.instance:getAct187Id()

		lantern = Activity187Config.instance:getLantern(actId, rewardId)
		ribbonIndex = Activity187Config.instance:getLanternRibbon(actId, rewardId)
	end

	self._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(lantern))

	for index, go in pairs(self._lowRibbonDict) do
		gohelper.setActive(go, index == ribbonIndex)
	end

	for index, go in pairs(self._upRibbonDict) do
		gohelper.setActive(go, index == ribbonIndex)
	end

	self._waitOpenCommonProp = nil
	self._waitCloseCommonProp = true
end

function Activity187PaintingView:_onCloseView(viewName)
	if viewName ~= ViewName.CommonPropView or not self._waitCloseCommonProp then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act187.play_ui_shuori_dreamsong_open)
	gohelper.setActive(self._simagepicturebg, true)
	gohelper.setActive(self._goriddles, true)

	self._waitCloseCommonProp = nil
end

function Activity187PaintingView:_editableInitView()
	self._writingBrush = self._gopaintingArea:GetComponent(typeof(ZProj.WritingBrush))
	self._drag = SLFramework.UGUI.UIDragListener.Get(self._gopaintingArea)
	self._paintAreaAnimator = self._gopaintingArea:GetComponent(typeof(UnityEngine.Animator))
	self._paintAreaAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._gopaintingArea)
	self._lowRibbonDict = self:getUserDataTb_()
	self._upRibbonDict = self:getUserDataTb_()

	self:_fillRibbonDict(self._golowribbon.transform, self._lowRibbonDict)
	self:_fillRibbonDict(self._goupribbon.transform, self._upRibbonDict)

	self._riddlesRewardItemList = {}

	gohelper.setActive(self._goriddlesRewardItem, false)

	self._rewardsMaterials = nil
	self._status = nil
end

function Activity187PaintingView:_fillRibbonDict(parentTrans, dict)
	local childCount = parentTrans.childCount

	for i = 1, childCount do
		local child = parentTrans:GetChild(i - 1)

		dict[child.name] = child
	end
end

function Activity187PaintingView:onUpdateParam()
	return
end

function Activity187PaintingView:onOpen()
	return
end

function Activity187PaintingView:setPaintStatus(status)
	self._status = status
	self._waitOpenCommonProp = nil
	self._waitCloseCommonProp = nil

	local isReady = status == Activity187Enum.PaintStatus.Ready
	local isFinish = status == Activity187Enum.PaintStatus.Finish

	self:hideAllRiddlesRewardItem()

	if isFinish then
		local rewardId = Activity187Model.instance:getPaintingRewardId(self._curIndex)

		if rewardId then
			self._waitOpenCommonProp = true

			local actId = Activity187Model.instance:getAct187Id()
			local lanternImg = Activity187Config.instance:getLanternImg(actId, rewardId)
			local lanternImgBg = Activity187Config.instance:getLanternImgBg(actId, rewardId)

			self._simagepicture:LoadImage(ResUrl.getAct184LanternIcon(lanternImg))
			self._simagepicturebg:LoadImage(ResUrl.getAct184LanternIcon(lanternImgBg))

			self._txtriddles.text = Activity187Config.instance:getBlessing(actId, rewardId)

			local rewardList = Activity187Model.instance:getPaintingRewardList(self._curIndex)

			for i, matMO in ipairs(rewardList) do
				local rewardItem = self:getRiddlesRewardItem(i)

				rewardItem.itemIcon:onUpdateMO(matMO)
			end
		end
	end

	self._simagelantern:LoadImage(ResUrl.getAct184LanternIcon(Activity187Enum.EmptyLantern))

	for _, go in pairs(self._lowRibbonDict) do
		gohelper.setActive(go, false)
	end

	for _, go in pairs(self._upRibbonDict) do
		gohelper.setActive(go, false)
	end

	if not isFinish then
		gohelper.setActive(self._gopaintingArea, true)
		self._paintAreaAnimator:Play("idle", 0, 1)
	end

	gohelper.setActive(self._gopaintTips, isReady)
	gohelper.setActive(self._btnclose, isFinish)
	gohelper.setActive(self._gofinishVx, isFinish)
	gohelper.setActive(self._simagepicturebg, false)
	gohelper.setActive(self._goriddles, false)
end

function Activity187PaintingView:hideAllRiddlesRewardItem()
	self._riddlesRewardItemList = self._riddlesRewardItemList or {}

	for _, riddlesRewardItem in ipairs(self._riddlesRewardItemList) do
		gohelper.setActive(riddlesRewardItem.go, false)
	end
end

function Activity187PaintingView:getRiddlesRewardItem(index)
	self._riddlesRewardItemList = self._riddlesRewardItemList or {}

	local rewardItem = self._riddlesRewardItemList[index]

	if not rewardItem then
		rewardItem = self:getUserDataTb_()
		rewardItem.go = gohelper.clone(self._goriddlesRewardItem, self._goriddlesRewards, index)

		local itemGo = gohelper.findChild(rewardItem.go, "#go_item")

		rewardItem.itemIcon = IconMgr.instance:getCommonItemIcon(itemGo)

		rewardItem.itemIcon:setCountFontSize(40)

		self._riddlesRewardItemList[index] = rewardItem
	end

	gohelper.setActive(rewardItem.go, true)

	return rewardItem
end

function Activity187PaintingView:onClose()
	self._simagepicture:UnLoadImage()
	self._simagepicturebg:UnLoadImage()
	self._simagelantern:UnLoadImage()
	TaskDispatcher.cancelTask(self._showMaterials, self)
	UIBlockMgr.instance:endBlock(Activity187Enum.BlockKey.GetPaintingReward)

	self._rewardsMaterials = nil
	self._status = nil
end

function Activity187PaintingView:onDestroyView()
	return
end

return Activity187PaintingView
