-- chunkname: @modules/logic/warmup_h5/view/ActivityWarmUpH5FullView.lua

module("modules.logic.warmup_h5.view.ActivityWarmUpH5FullView", package.seeall)

local ActivityWarmUpH5FullView = class("ActivityWarmUpH5FullView", BaseView)

function ActivityWarmUpH5FullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simagelangtxt = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_langtxt")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Root/#btn_click")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpH5FullView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ActivityWarmUpH5FullView:removeEvents()
	self._btnclick:RemoveClickListener()
end

function ActivityWarmUpH5FullView:_btnclickOnClick()
	StatController.instance:track(StatEnum.EventName.ButtonClick, {
		[StatEnum.EventProperties.ViewName] = "版本H5预热页",
		[StatEnum.EventProperties.ButtonName] = "点击参与"
	})
	SDKDataTrackMgr.instance:trackClickActivityJumpButton()

	local baseUrl = self.viewContainer:getH5BaseUrl()

	WebViewController.instance:simpleOpenWebView(baseUrl, self._onWebViewCb, self)
end

function ActivityWarmUpH5FullView:_actId()
	return self.viewContainer:actId()
end

function ActivityWarmUpH5FullView:_editableInitView()
	self._txtLimitTime.text = ""
end

function ActivityWarmUpH5FullView:_onWebViewCb(errorType, msg)
	if errorType == WebViewEnum.WebViewCBType.Cb then
		local msgParamList = string.split(msg, "#")
		local eventName = msgParamList[1]

		if eventName == "webClose" then
			ViewMgr.instance:closeView(ViewName.WebView)
		end
	end
end

function ActivityWarmUpH5FullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
	GameUtil.loadSImage(self._simagelangtxt, self.viewContainer:getBgResUrl())
	ActivityWarmUpH5FullView.super.onOpen(self)
	AudioMgr.instance:trigger(AudioEnum3_1.WarmUpH5.play_ui_mingdi_h5_open)
	self:_refreshTimeTick()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
	TaskDispatcher.runRepeat(self._refreshTimeTick, self, 1)
end

function ActivityWarmUpH5FullView:_refreshTimeTick()
	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self:_actId())
end

function ActivityWarmUpH5FullView:onClose()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

function ActivityWarmUpH5FullView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTimeTick, self)
end

return ActivityWarmUpH5FullView
