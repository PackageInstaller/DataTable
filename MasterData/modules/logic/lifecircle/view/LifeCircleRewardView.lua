-- chunkname: @modules/logic/lifecircle/view/LifeCircleRewardView.lua

module("modules.logic.lifecircle.view.LifeCircleRewardView", package.seeall)

local LifeCircleRewardView = class("LifeCircleRewardView", BaseView)

function LifeCircleRewardView:onInitView()
	self._txtDays = gohelper.findChildText(self.viewGO, "TitleBG/#txt_Days")
	self._simageIcon = gohelper.findChildSingleImage(self.viewGO, "#simage_Icon")
	self._goReward = gohelper.findChild(self.viewGO, "#go_Reward")
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "#go_Reward/#scroll_Reward")
	self._goContent = gohelper.findChild(self.viewGO, "#go_Reward/#scroll_Reward/Viewport/#go_Content")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function LifeCircleRewardView:addEvents()
	self._click:AddClickListener(self.closeThis, self)
end

function LifeCircleRewardView:removeEvents()
	self._click:RemoveClickListener()
end

local csAnimatorPlayer = SLFramework.AnimatorPlayer
local State = {
	ShowingRewards = 3,
	ShownRewards = 4,
	OpeningBox = 1,
	OpenedBox = 2,
	None = 0
}

function LifeCircleRewardView:_editableInitView()
	self._state = State.None
	self._contentGrid = self._goContent:GetComponent(gohelper.Type_GridLayoutGroup)
	self._click = gohelper.getClick(self.viewGO)
	self._animatorPlayer = csAnimatorPlayer.Get(self.viewGO)
	self._animSelf = self._animatorPlayer.animator
	self._scrollitemTrans = self._scrollitem.transform
	self._goContentTrans = self._goContent.transform

	local v2CellSize = self._contentGrid.cellSize
	local v2spacing = self._contentGrid.spacing

	self._w = recthelper.getWidth(self._scrollitemTrans)
	self._h = recthelper.getHeight(self._scrollitemTrans)
	self._colCount = self._contentGrid.constraintCount
	self._itemHeight = v2CellSize.y
	self._spacingY = v2spacing.y

	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
	self:_setActive_goReward(false)
end

function LifeCircleRewardView:closeThis()
	if self._state == State.None then
		self:_moveState()
	end

	if not self:_allowCloseView() then
		return
	end

	LifeCircleRewardView.super.closeThis(self)
end

function LifeCircleRewardView:onClickModalMask()
	self:closeThis()
end

function LifeCircleRewardView:onUpdateParam()
	CommonPropListItem.hasOpen = false
	self._contentGrid.enabled = false

	self:_setPropItems()

	self._txtDays.text = self:_loginDayCount()
end

function LifeCircleRewardView:_loginDayCount()
	return self.viewParam.loginDayCount or 0
end

function LifeCircleRewardView:_materialDataMOList()
	return self.viewParam.materialDataMOList or {}
end

function LifeCircleRewardView:onOpen()
	self:onUpdateParam()
end

function LifeCircleRewardView:onOpenFinish()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_open_25251110)
end

function LifeCircleRewardView:onClose()
	FrameTimerController.onDestroyViewMember(self, "_fTimer")
	CommonPropListModel.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_General_shutdown)

	CommonPropListItem.hasOpen = false

	TaskDispatcher.cancelTask(self._moveState, self)
	NavigateMgr.instance:removeEscape(self.viewName)
end

function LifeCircleRewardView:onDestroyView()
	TaskDispatcher.cancelTask(self._moveState, self)
end

function LifeCircleRewardView:_setPropItems()
	CommonPropListModel.instance:setPropList(self:_materialDataMOList())

	local h = self:_getContentHeight()

	recthelper.setSize(self._goContentTrans, self._w, h)

	self._contentGrid.enabled = true

	local _magicEnabled = true

	FrameTimerController.onDestroyViewMember(self, "_fTimer")

	self._fTimer = FrameTimerController.instance:register(function()
		self._contentGrid.enabled = _magicEnabled
		_magicEnabled = not _magicEnabled
	end, 5, 2)

	self._fTimer:Start()
end

function LifeCircleRewardView:_setActive_goReward(isActive)
	gohelper.setActive(self._goReward, isActive)
end

function LifeCircleRewardView:_playAnim(name, cb, cbObj)
	self._animatorPlayer:Play(name, cb, cbObj)
end

function LifeCircleRewardView:_moveState()
	self:_setState(self._state + 1)
end

function LifeCircleRewardView:_setState(newState)
	if newState <= self._state then
		return
	end

	self._state = newState

	if newState == State.OpeningBox then
		self:_onOpenBoxAnim()
	elseif newState == State.OpenedBox then
		self:_onOpenedBox()
	elseif newState == State.ShowingRewards then
		self:_onShowingRewards()
	elseif newState == State.ShownRewards then
		-- block empty
	end
end

function LifeCircleRewardView:_onOpenBoxAnim()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_tangren_qiandao_leiji_25251111)
	self._playAnim(self, UIAnimationName.Click, self._moveState, self)
end

function LifeCircleRewardView:_onOpenedBox()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_rewards_rare_2000081)
	self:_setActive_goReward(true)
	self:_moveState()
end

function LifeCircleRewardView:_onShowingRewards()
	TaskDispatcher.cancelTask(self._moveState, self)
	TaskDispatcher.runDelay(self._moveState, self, 0.8)
end

function LifeCircleRewardView:_allowCloseView()
	return self._state >= State.ShownRewards
end

function LifeCircleRewardView:_getContentHeight()
	local list = CommonPropListModel.instance:getList()
	local itemCount = #list
	local constraintCount = self._colCount
	local itemHeight = self._itemHeight
	local spacingY = self._spacingY
	local lineCount = math.max(1, math.ceil(itemCount / constraintCount))
	local h = math.max(self._h, self._contentGrid.preferredHeight)

	h = math.max(h, (lineCount - 1) * spacingY + itemHeight * lineCount)

	return h
end

return LifeCircleRewardView
