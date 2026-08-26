-- chunkname: @modules/logic/sp01/linkgift/view/V2a9_LinkGiftView.lua

module("modules.logic.sp01.linkgift.view.V2a9_LinkGiftView", package.seeall)

local V2a9_LinkGiftView = class("V2a9_LinkGiftView", BaseView)

function V2a9_LinkGiftView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "root/Left/simage_timebg/#txt_LimitTime")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a9_LinkGiftView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V2a9_LinkGiftView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function V2a9_LinkGiftView:_btncloseOnClick()
	self:closeThis()
end

function V2a9_LinkGiftView:_editableInitView()
	self._linkGiftItemList = {}

	for i = 1, 9 do
		local go = gohelper.findChild(self.viewGO, "root/Right/reward_panel0" .. i)

		if go then
			local linkGiftItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, V2a9_LinkGiftItem, self)

			table.insert(self._linkGiftItemList, linkGiftItem)
		else
			break
		end
	end
end

function V2a9_LinkGiftView:onUpdateParam()
	return
end

function V2a9_LinkGiftView:onOpen()
	self.addEventCb(self, TaskController.instance, TaskEvent.SetTaskList, self._onRefreshEvent, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onRefreshEvent, self)

	self._poolId = self.viewParam and self.viewParam.poolId
	self._goodsCdfList = {}

	local goodsCfgList = StoreConfig.instance:getCharageGoodsCfgListByPoolId(self._poolId)

	if goodsCfgList then
		for _, goodsCfg in ipairs(goodsCfgList) do
			if StoreModel.instance:getGoodsMO(goodsCfg.id) then
				table.insert(self._goodsCdfList, goodsCfg)
			end
		end
	end

	table.sort(self._goodsCdfList, V2a9_LinkGiftView._sortGoodsCfgList)
	self:_refreshUI()
	self:_refreshOpenTime()
	TaskDispatcher.runRepeat(self.repeatCallCountdown, self, 10)

	if StoreGoodsTaskController.instance:isHasNewRedDotByPoolId(self._poolId) then
		StoreGoodsTaskController.instance:clearNewRedDotByPoolId(self._poolId)
		StoreGoodsTaskController.instance:waitUpdateRedDot()
	end

	AudioMgr.instance:trigger(AudioEnum3_10.LinkGift.play_ui_qiutu_revelation_open)
end

function V2a9_LinkGiftView:onClose()
	TaskDispatcher.cancelTask(self.repeatCallCountdown, self)
	TaskDispatcher.cancelTask(self._onTopRefreshUI, self)
end

function V2a9_LinkGiftView:onDestroyView()
	for i, item in ipairs(self._linkGiftItemList) do
		item:onDestroy()
	end
end

function V2a9_LinkGiftView:_onRefreshEvent()
	TaskDispatcher.cancelTask(self._onTopRefreshUI, self)
	TaskDispatcher.runDelay(self._onTopRefreshUI, self, 0.2)
end

function V2a9_LinkGiftView:_onTopRefreshUI(viewName)
	if ViewHelper.instance:checkViewOnTheTop(self.viewName) then
		self:_refreshUI()
	end
end

function V2a9_LinkGiftView:_refreshUI()
	for i, item in ipairs(self._linkGiftItemList) do
		item:onUpdateMO(self._goodsCdfList[i])
	end
end

function V2a9_LinkGiftView:repeatCallCountdown()
	self:_refreshOpenTime()
end

function V2a9_LinkGiftView:_refreshOpenTime()
	local poolMO = SummonMainModel.instance:getPoolServerMO(self._poolId)
	local textStr

	if poolMO ~= nil and poolMO.offlineTime ~= 0 and poolMO.offlineTime < TimeUtil.maxDateTimeStamp then
		local time = poolMO.offlineTime - ServerTime.now()

		textStr = SummonModel.formatRemainTime(time)
	else
		textStr = ""
	end

	self._txtLimitTime.text = textStr
end

function V2a9_LinkGiftView._sortGoodsCfgList(a, b)
	if a.price ~= b.price then
		return a.price < b.price
	end

	if a.id ~= b.id then
		return a.id < b.id
	end
end

return V2a9_LinkGiftView
