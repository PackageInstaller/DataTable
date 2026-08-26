-- chunkname: @modules/logic/activity/view/V1a5_DoubleFestival_FullSignView.lua

module("modules.logic.activity.view.V1a5_DoubleFestival_FullSignView", package.seeall)

local V1a5_DoubleFestival_FullSignView = class("V1a5_DoubleFestival_FullSignView", Activity101SignViewBase)

function V1a5_DoubleFestival_FullSignView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._goSign = gohelper.findChild(self.viewGO, "Root/#go_Sign")
	self._imageSignNext = gohelper.findChildImage(self.viewGO, "Root/#go_Sign/#image_SignNext")
	self._imageSignNow = gohelper.findChildImage(self.viewGO, "Root/#go_Sign/#image_SignNow")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtDescr = gohelper.findChildText(self.viewGO, "Root/#txt_Descr")
	self._scrollItemList = gohelper.findChildScrollRect(self.viewGO, "Root/#scroll_ItemList")
	self._goBlock = gohelper.findChild(self.viewGO, "#go_Block")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a5_DoubleFestival_FullSignView:addEvents()
	Activity101SignViewBase.addEvents(self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

function V1a5_DoubleFestival_FullSignView:removeEvents()
	Activity101SignViewBase.removeEvents(self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
end

local actId = ActivityEnum.Activity.DoubleFestivalSign_1_5
local kAnimEvt = "onSwitchEnd"

function V1a5_DoubleFestival_FullSignView:_editableInitView()
	self._imageSignNextTran = self._imageSignNext.transform
	self._imageSignNowTran = self._imageSignNow.transform
	self._animSelf = self._goSign:GetComponent(gohelper.Type_Animator)
	self._animEvent = self._goSign:GetComponent(gohelper.Type_AnimationEventWrap)

	self._animEvent:AddEventListener(kAnimEvt, self._onSwitchEnd, self)
	self._simageTitle:LoadImage(ResUrl.getV1a5SignSingleBgLang("v1a5_sign_df_title"))
	self._simageFullBG:LoadImage(ResUrl.getV1a5SignSingleBg("v1a5_df_sign_fullbg"))

	self._txtDescr.text = ""
end

function V1a5_DoubleFestival_FullSignView:onOpen()
	ActivityType101Model.instance:setCurIndex(nil)

	self._lastDay = nil
	self._txtLimitTime.text = ""

	self:_setActiveBlock(false)
	self:internal_set_openMode(Activity101SignViewBase.eOpenMode.ActivityBeginnerView)
	self:internal_onOpen()

	local day = ActivityType101Model.instance:getLastGetIndex(actId)

	self:_resetByDay(day)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function V1a5_DoubleFestival_FullSignView:onClose()
	self._animEvent:RemoveEventListener(kAnimEvt)

	if self._fTimer then
		self._fTimer:Stop()

		self._fTimer = nil
	end

	self._isFirstUpdateScrollPos = nil

	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	self:_setActiveBlock(false)
end

function V1a5_DoubleFestival_FullSignView:onDestroyView()
	Activity101SignViewBase._internal_onDestroy(self)
	self._simageTitle:UnLoadImage()
	self._simageFullBG:UnLoadImage()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function V1a5_DoubleFestival_FullSignView:onRefresh()
	self:_refreshList()
	self:_refreshTimeTick()
end

function V1a5_DoubleFestival_FullSignView:_refreshTimeTick()
	self._txtLimitTime.text = self:getRemainTimeStr()
end

function V1a5_DoubleFestival_FullSignView:_setPinStartIndex(dataList)
	local _, index = self:getRewardCouldGetIndex()

	index = index <= 4 and 1 or 3

	local scrollModel = self.viewContainer:getScrollModel()

	scrollModel:setStartPinIndex(index)
end

function V1a5_DoubleFestival_FullSignView:_resetByDay(day)
	local co = ActivityType101Config.instance:getDoubleFestivalCOByDay(actId, day)

	GameUtil.setActive01(self._imageSignNowTran, co ~= nil)
	GameUtil.setActive01(self._imageSignNextTran, false)

	if co then
		UISpriteSetMgr.instance:setV1a5DfSignSprite(self._imageSignNow, co.bgSpriteName)
	end

	self._lastDay = day

	self._animSelf:Play(UIAnimationName.Idle, 0, 1)

	self._txtDescr.text = co.blessContentType or ""
end

function V1a5_DoubleFestival_FullSignView:_setActiveBlock(isActive)
	gohelper.setActive(self._goBlock, isActive)
end

function V1a5_DoubleFestival_FullSignView:_tweenSprite(day)
	if not day then
		return
	end

	self:_setActiveBlock(true)

	self._curDay = day

	local lastCO = ActivityType101Config.instance:getDoubleFestivalCOByDay(actId, self._lastDay)
	local co = ActivityType101Config.instance:getDoubleFestivalCOByDay(actId, day)

	GameUtil.setActive01(self._imageSignNextTran, co ~= nil)

	if co then
		local bgSpriteName = co.bgSpriteName

		if lastCO and lastCO.bgSpriteName == bgSpriteName then
			self:_onSwitchEnd()

			return
		end

		UISpriteSetMgr.instance:setV1a5DfSignSprite(self._imageSignNext, bgSpriteName)
	end

	AudioMgr.instance:trigger(AudioEnum.ui_activity_1_5_wulu.play_ui_wulu_seal_cutting_eft)
	self._animSelf:Play(UIAnimationName.Switch, 0, 0)
end

function V1a5_DoubleFestival_FullSignView:_onSwitchEnd()
	local day = self._curDay

	self:_showWish(day)
	self:_setActiveBlock(false)
end

function V1a5_DoubleFestival_FullSignView:_showWish(day)
	if not day then
		return
	end

	self._fTimer = self._fTimer or FrameTimer.New(nil, 0, 0)

	local isFirst = true

	self._fTimer:Reset(function()
		if isFirst then
			isFirst = false

			ViewMgr.instance:openView(ViewName.V1a5_DoubleFestival_WishPanel, {
				day = day
			})
		else
			self:_resetByDay(day)
		end
	end, 1, 2)
	self._fTimer:Start()
end

function V1a5_DoubleFestival_FullSignView:_onCloseView(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	local day = ActivityType101Model.instance:getCurIndex()

	if not day then
		return
	end

	if self._lastDay == day then
		return
	end

	self:_tweenSprite(day)
end

return V1a5_DoubleFestival_FullSignView
