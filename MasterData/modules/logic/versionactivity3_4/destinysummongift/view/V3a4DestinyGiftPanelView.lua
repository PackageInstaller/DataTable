-- chunkname: @modules/logic/versionactivity3_4/destinysummongift/view/V3a4DestinyGiftPanelView.lua

module("modules.logic.versionactivity3_4.destinysummongift.view.V3a4DestinyGiftPanelView", package.seeall)

local V3a4DestinyGiftPanelView = class("V3a4DestinyGiftPanelView", V3a4DestinyGiftBaseView)

function V3a4DestinyGiftPanelView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/info/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/info/#scroll_desc/Viewport/Content/#txt_desc")
	self._txtTime = gohelper.findChildText(self.viewGO, "root/info/time/#txt_time")
	self._gogiftreward = gohelper.findChild(self.viewGO, "root/info/#go_giftreward")
	self._goicon1 = gohelper.findChild(self.viewGO, "root/info/#go_giftreward/#go_icon1")
	self._goicon2 = gohelper.findChild(self.viewGO, "root/info/#go_giftreward/#go_icon2")
	self._goicon3 = gohelper.findChild(self.viewGO, "root/info/#go_giftreward/#go_icon3")
	self._goicon4 = gohelper.findChild(self.viewGO, "root/info/#go_giftreward/#go_icon4")
	self._gobuy = gohelper.findChild(self.viewGO, "root/#go_buy")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._txtcost = gohelper.findChildText(self.viewGO, "root/#go_buy/#txt_cost")
	self._gogoto = gohelper.findChild(self.viewGO, "root/#go_goto")
	self._btngoto = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_goto/#btn_goto")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4DestinyGiftPanelView:addEvents()
	V3a4DestinyGiftPanelView.super.addEvents(self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.closeThis, self)
end

function V3a4DestinyGiftPanelView:removeEvents()
	V3a4DestinyGiftPanelView.super.removeEvents(self)
	self._btnClose:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self.closeThis, self)
end

function V3a4DestinyGiftPanelView:_btnCloseOnClick()
	self:closeThis()
end

function V3a4DestinyGiftPanelView:onOpen()
	self:checkParent()
	self:checkParam()
	self:refreshUI()
	self:setRefreshTimeTask()
end

function V3a4DestinyGiftPanelView:checkParam()
	if self.viewParam == nil or self.viewParam.poolId == nil or self.viewParam.order == nil then
		logError("3.4 狂想卡池礼包 缺少数据")

		return
	end

	local summonPackagePoolConfig = SummonConfig.instance:getSummonPoolPackageConfig(self.viewParam.poolId, self.viewParam.order)

	if summonPackagePoolConfig == nil then
		logError("3.4 狂想卡池礼包 不存在的礼包 id:" .. tostring(self.viewParam.poolId) .. " order: " .. tostring(self.viewParam.order))

		return
	end

	if string.nilorempty(summonPackagePoolConfig.packageRecommend) then
		logError("3.4 狂想卡池礼包 推荐礼包为空 id:" .. tostring(self.viewParam.poolId) .. " order: " .. tostring(self.viewParam.order))

		return
	end

	local param = string.splitToNumber(summonPackagePoolConfig.packageRecommend, "#")

	if param == nil or next(param) == nil then
		logError("3.4 狂想卡池礼包 推荐礼包为空 id:" .. tostring(self.viewParam.poolId) .. " order: " .. tostring(self.viewParam.order))

		return
	end

	self.packageId = param[1]
	self.poolId = self.viewParam.poolId
end

return V3a4DestinyGiftPanelView
