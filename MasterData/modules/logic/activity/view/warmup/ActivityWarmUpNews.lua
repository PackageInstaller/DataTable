-- chunkname: @modules/logic/activity/view/warmup/ActivityWarmUpNews.lua

module("modules.logic.activity.view.warmup.ActivityWarmUpNews", package.seeall)

local ActivityWarmUpNews = class("ActivityWarmUpNews", BaseView)

function ActivityWarmUpNews:onInitView()
	self._txtinfo = gohelper.findChildText(self.viewGO, "#scroll_info/Viewport/Content/#txt_info")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityWarmUpNews:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function ActivityWarmUpNews:removeEvents()
	self._btnclose:RemoveClickListener()
end

function ActivityWarmUpNews:_editableInitView()
	return
end

function ActivityWarmUpNews:onDestroyView()
	return
end

function ActivityWarmUpNews:onOpen()
	local orderId = self.viewParam.orderId
	local actId = self.viewParam.actId

	self.orderCo = Activity106Config.instance:getActivityWarmUpOrderCo(actId, orderId)

	self:refreshUI()
end

function ActivityWarmUpNews:onClose()
	return
end

function ActivityWarmUpNews:_btncloseOnClick()
	self:closeThis()
end

function ActivityWarmUpNews:onClickModalMask()
	self:closeThis()
end

function ActivityWarmUpNews:refreshUI()
	self._txtinfo.text = self.orderCo and self.orderCo.infoDesc or ""
end

return ActivityWarmUpNews
