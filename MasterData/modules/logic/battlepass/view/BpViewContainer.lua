-- chunkname: @modules/logic/battlepass/view/BpViewContainer.lua

module("modules.logic.battlepass.view.BpViewContainer", package.seeall)

local BpViewContainer = class("BpViewContainer", BaseViewContainer)
local TabView_Navigation = 1
local TabView_BonusOrTask = 2

function BpViewContainer:buildViews()
	BpModel.instance.isViewLoading = true

	return {
		BpBuyBtn.New(),
		TabViewGroup.New(TabView_Navigation, "#go_btns"),
		BPTabViewGroup.New(TabView_BonusOrTask, "#go_container"),
		BpView.New(),
		ToggleListView.New(TabView_BonusOrTask, "right/toggleGroup")
	}
end

function BpViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == TabView_Navigation then
		self._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			self._navigateButtonView
		}
	elseif tabContainerId == TabView_BonusOrTask then
		return {
			BpBonusView.New(),
			BpTaskView.New()
		}
	end
end

function BpViewContainer:playOpenTransition()
	local sec = 1
	local isPlayDayFirstAnim = not self.viewParam or self.viewParam.isPlayDayFirstAnim

	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay and TimeUtil.getWeekFirstLoginRed("BpViewOpenAnim") and TimeUtil.getDayFirstLoginRed("BpViewOpenAnim") then
		if isPlayDayFirstAnim then
			self.firstAnimFlow = FlowSequence.New()

			self.firstAnimFlow:addWork(FunctionWork.New(self.playOpenAnim1, self))
			self.firstAnimFlow:start()

			return
		else
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, self._checkPlayDayAnim, self)
		end
	end

	BpViewContainer.super.playOpenTransition(self, {
		anim = (self.viewParam and self.viewParam.isSwitch or nil) and "switch",
		duration = sec
	})
end

function BpViewContainer:playOpenAnim1()
	AudioMgr.instance:trigger(AudioEnum2_6.BP.BpDayFirstAnim)
	UIBlockMgrExtend.setNeedCircleMv(false)

	local anim = "tarotopen2"
	local sec = 3

	TimeUtil.setWeekFirstLoginRed("BpViewOpenAnim")
	AudioMgr.instance:trigger(AudioEnum3_4.BP.FaceView_play_ui_bulaochun_yunying_bp)
	BpViewContainer.super.playOpenTransition(self, {
		anim = anim,
		duration = sec
	})
end

function BpViewContainer:_checkPlayDayAnim()
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.BpView) then
		return
	end

	if self.viewParam and not self.viewParam.isPlayDayFirstAnim then
		self.viewParam.isPlayDayFirstAnim = true
	end

	self:playOpenTransition()
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkPlayDayAnim, self)
end

function BpViewContainer:onPlayOpenTransitionFinish()
	UIBlockMgrExtend.setNeedCircleMv(true)
	BpViewContainer.super.onPlayOpenTransitionFinish(self)
end

function BpViewContainer:playCloseTransition()
	self:onPlayCloseTransitionFinish()
end

function BpViewContainer:onContainerClose()
	if self.firstAnimFlow then
		self.firstAnimFlow:stop()

		self.firstAnimFlow = nil
	end

	UIBlockMgrExtend.setNeedCircleMv(true)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, self._checkPlayDayAnim, self)
	BpViewContainer.super.onContainerClose(self)
end

return BpViewContainer
