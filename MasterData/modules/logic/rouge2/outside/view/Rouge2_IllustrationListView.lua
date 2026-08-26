-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_IllustrationListView.lua

module("modules.logic.rouge2.outside.view.Rouge2_IllustrationListView", package.seeall)

local Rouge2_IllustrationListView = class("Rouge2_IllustrationListView", BaseView)

function Rouge2_IllustrationListView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageListBG = gohelper.findChildSingleImage(self.viewGO, "#simage_ListBG")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#slider_progress")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content")
	self._simagedlcbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#simage_dlcbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_IllustrationListView:addEvents()
	self._scrollview:AddOnValueChanged(self._onScrollRectValueChanged, self)
end

function Rouge2_IllustrationListView:removeEvents()
	self._scrollview:RemoveOnValueChanged()
end

local Min_TWEENSCROLLDELTA_X = 0.01
local SCROLL_TWEEN_DURATION = 1
local SCROLL_POS_NORMAL_X = 0

function Rouge2_IllustrationListView:focus2TargetPos(isTween, focusType)
	local scrollPosX = SCROLL_POS_NORMAL_X

	if focusType == RougeEnum.IllustrationType.DLC then
		local scrollContentWidth = recthelper.getWidth(self._goscrollcontent.transform)

		scrollPosX = RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX()

		local viewPortWidth = recthelper.getWidth(self._scrollview.transform)

		scrollPosX = Mathf.Clamp(scrollPosX / (scrollContentWidth - viewPortWidth), 0, 1)
	end

	self:_moveScroll2TargetPos(isTween, scrollPosX)
end

function Rouge2_IllustrationListView:_moveScroll2TargetPos(isTween, scrollPosX)
	self:killTween()
	self:endUIBlock()

	if isTween then
		local startPos = self._scrollview.horizontalNormalizedPosition
		local diff = math.abs(scrollPosX - startPos)

		if diff > Min_TWEENSCROLLDELTA_X then
			self:startUIBlock()

			self._tweenId = ZProj.TweenHelper.DOTweenFloat(startPos, scrollPosX, SCROLL_TWEEN_DURATION, self.tweenFrame, self.tweenFinish, self)
		end
	else
		self._scrollview.horizontalNormalizedPosition = scrollPosX
	end
end

function Rouge2_IllustrationListView:_onScrollRectValueChanged()
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a2_Rouge_Review_Illustration_Tab, 0) then
		Rouge2_OutsideController.instance:dispatchEvent(Rouge2_OutsideEvent.OnIllustrationScrollViewValueChanged)
	end
end

function Rouge2_IllustrationListView:tweenFrame(value)
	if not self._scrollview then
		return
	end

	self._scrollview.horizontalNormalizedPosition = value
end

function Rouge2_IllustrationListView:tweenFinish()
	self._tweenId = nil

	self:endUIBlock()
end

function Rouge2_IllustrationListView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function Rouge2_IllustrationListView:startUIBlock()
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("Rouge2_IllustrationTween")
end

function Rouge2_IllustrationListView:endUIBlock()
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("Rouge2_IllustrationTween")
end

function Rouge2_IllustrationListView:_editableInitView()
	Rouge2_IllustrationListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	Rouge2_IllustrationListModel.instance:initList()

	self.animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
end

function Rouge2_IllustrationListView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio4)
	self.animator:Play("open", 0, 0)
	self._onScrollRectValueChanged()
end

function Rouge2_IllustrationListView:onClose()
	self:killTween()
	self:endUIBlock()
	self.animator:Play("close", 0, 0)
end

function Rouge2_IllustrationListView:onDestroyView()
	return
end

return Rouge2_IllustrationListView
