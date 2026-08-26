-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpTips.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpTips", package.seeall)

local ActivityWarmUpTips = class("ActivityWarmUpTips", BaseView)

function ActivityWarmUpTips:onInitView()
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "#simage_bg1")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._txtinfo = gohelper.findChildText(self.viewGO, "#scroll_info/Viewport/Content/#txt_info")
	self._txttitle = gohelper.findChildText(self.viewGO, "#txt_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpTips:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function ActivityWarmUpTips:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ActivityWarmUpTips:_editableInitView()
	self._simagebg1:LoadImage(ResUrl.getActivityWarmUpBg("bg_zi8"))
	self._simageicon:LoadImage(ResUrl.getActivityWarmUpBg("bg_tu1"))
end

function ActivityWarmUpTips:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simageicon:UnLoadImage()
end

function ActivityWarmUpTips:onOpen()
	local orderId = self.viewParam.orderId
	local actId = self.viewParam.actId

	self.orderCo = Activity106Config.instance:getActivityWarmUpOrderCo(actId, orderId)

	self:refreshUI()
end

function ActivityWarmUpTips:onClose()
	return
end

function ActivityWarmUpTips:_btncloseOnClick()
	self:closeThis()
end

function ActivityWarmUpTips:refreshUI()
	if self.orderCo then
		self._txtinfo.text = self.orderCo.desc
		self._txttitle.text = self.orderCo.name
	else
		self._txtinfo.text = ""
		self._txttitle.text = ""
	end
end

function ActivityWarmUpTips:onClickModalMask()
	self:closeThis()
end

return ActivityWarmUpTips
