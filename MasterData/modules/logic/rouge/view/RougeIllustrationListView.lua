-- chunkname: @modules/logic/rouge/view/RougeIllustrationListView.lua

module("modules.logic.rouge.view.RougeIllustrationListView", package.seeall)

local RougeIllustrationListView = class("RougeIllustrationListView", BaseView)

function RougeIllustrationListView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageListBG = gohelper.findChildSingleImage(self.viewGO, "#simage_ListBG")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "#scroll_view")
	self._sliderprogress = gohelper.findChildSlider(self.viewGO, "#slider_progress")
	self._goLeftTop = gohelper.findChild(self.viewGO, "#go_LeftTop")
	self._gonormal = gohelper.findChild(self.viewGO, "#go_LeftBottom/normal")
	self._godlc = gohelper.findChild(self.viewGO, "#go_LeftBottom/dlc")
	self._btnnormal = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftBottom/normal/btn_click")
	self._gonormalunselect = gohelper.findChild(self.viewGO, "#go_LeftBottom/normal/unselect")
	self._gonormalselected = gohelper.findChild(self.viewGO, "#go_LeftBottom/normal/selected")
	self._btndlc = gohelper.findChildButtonWithAudio(self.viewGO, "#go_LeftBottom/dlc/btn_click")
	self._godlcunselect = gohelper.findChild(self.viewGO, "#go_LeftBottom/dlc/unselect")
	self._godlcselected = gohelper.findChild(self.viewGO, "#go_LeftBottom/dlc/selected")
	self._goscrollcontent = gohelper.findChild(self.viewGO, "#scroll_view/Viewport/Content")
	self._simagedlcbg = gohelper.findChildSingleImage(self.viewGO, "#scroll_view/Viewport/Content/#simage_dlcbg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeIllustrationListView:addEvents()
	self._btnnormal:AddClickListener(self._btnnormalOnClick, self)
	self._btndlc:AddClickListener(self._btndlcOnClick, self)
end

function RougeIllustrationListView:removeEvents()
	self._btnnormal:RemoveClickListener()
	self._btndlc:RemoveClickListener()
end

function RougeIllustrationListView:_btnnormalOnClick()
	self:refreshButtons(RougeEnum.IllustrationType.Normal)
	self:focus2TargetPos(true, RougeEnum.IllustrationType.Normal)
end

function RougeIllustrationListView:_btndlcOnClick()
	self:refreshButtons(RougeEnum.IllustrationType.DLC)
	self:focus2TargetPos(true, RougeEnum.IllustrationType.DLC)
end

function RougeIllustrationListView:refreshButtons(selectType)
	gohelper.setActive(self._gonormalselected, selectType == RougeEnum.IllustrationType.Normal)
	gohelper.setActive(self._gonormalunselect, selectType ~= RougeEnum.IllustrationType.Normal)
	gohelper.setActive(self._godlcselected, selectType == RougeEnum.IllustrationType.DLC)
	gohelper.setActive(self._godlcunselect, selectType ~= RougeEnum.IllustrationType.DLC)
end

local Min_TWEENSCROLLDELTA_X = 0.01
local SCROLL_TWEEN_DURATION = 1
local SCROLL_POS_NORMAL_X = 0
local DLCBG_POSOffset_X = 100

function RougeIllustrationListView:focus2TargetPos(isTween, focusType)
	local scrollPosX = SCROLL_POS_NORMAL_X

	if focusType == RougeEnum.IllustrationType.DLC then
		local scrollContentWidth = recthelper.getWidth(self._goscrollcontent.transform)

		scrollPosX = RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX()

		local viewPortWidth = recthelper.getWidth(self._scrollview.transform)

		scrollPosX = Mathf.Clamp(scrollPosX / (scrollContentWidth - viewPortWidth), 0, 1)
	end

	self:_moveScroll2TargetPos(isTween, scrollPosX)
end

function RougeIllustrationListView:_moveScroll2TargetPos(isTween, scrollPosX)
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

function RougeIllustrationListView:tweenFrame(value)
	if not self._scrollview then
		return
	end

	self._scrollview.horizontalNormalizedPosition = value
end

function RougeIllustrationListView:tweenFinish()
	self._tweenId = nil

	self:endUIBlock()
end

function RougeIllustrationListView:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function RougeIllustrationListView:startUIBlock()
	UIBlockMgrExtend.instance.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("RougeIllustrationTween")
end

function RougeIllustrationListView:endUIBlock()
	UIBlockMgrExtend.instance.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("RougeIllustrationTween")
end

function RougeIllustrationListView:_editableInitView()
	RougeIllustrationListModel.instance.startFrameCount = UnityEngine.Time.frameCount

	RougeIllustrationListModel.instance:initList()
end

function RougeIllustrationListView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.RougeFavoriteAudio4)
	self:focus2TargetPos(false, RougeEnum.IllustrationType.Normal)
	self:setSplitImagePos()
end

function RougeIllustrationListView:setSplitImagePos()
	local dlcIllustrationCount = RougeFavoriteConfig.instance:getDLCIllustationPageCount()
	local hasDLCIllustration = dlcIllustrationCount and dlcIllustrationCount > 0

	gohelper.setActive(self._simagedlcbg.gameObject, hasDLCIllustration)

	if not hasDLCIllustration then
		return
	end

	local splitPosX = RougeIllustrationListModel.instance:getSplitEmptySpaceStartPosX()
	local bgPosX = splitPosX + DLCBG_POSOffset_X

	recthelper.setAnchorX(self._simagedlcbg.transform, bgPosX)
end

function RougeIllustrationListView:onClose()
	if RougeFavoriteModel.instance:getReddotNum(RougeEnum.FavoriteType.Illustration) > 0 then
		local season = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeMarkNewReddotRequest(season, RougeEnum.FavoriteType.Illustration, 0)
	end

	self:killTween()
	self:endUIBlock()
end

function RougeIllustrationListView:onDestroyView()
	return
end

return RougeIllustrationListView
