-- chunkname: @modules/logic/versionactivity3_4/destinysummongift/view/V3a4DestinyGiftFullView.lua

module("modules.logic.versionactivity3_4.destinysummongift.view.V3a4DestinyGiftFullView", package.seeall)

local V3a4DestinyGiftFullView = class("V3a4DestinyGiftFullView", V3a4DestinyGiftBaseView)

function V3a4DestinyGiftFullView:onInitView()
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
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_reward")
	self._simagerewardIcon = gohelper.findChildSingleImage(self.viewGO, "root/#btn_reward/#simage_rewardIcon")
	self._gocanget = gohelper.findChild(self.viewGO, "root/#btn_reward/#go_canget")
	self._goreceive = gohelper.findChild(self.viewGO, "root/#btn_reward/#go_receive")
	self._txtnum = gohelper.findChildText(self.viewGO, "root/#btn_reward/image_numbg/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4DestinyGiftFullView:addEvents()
	V3a4DestinyGiftFullView.super.addEvents(self)
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshReward, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshGiftInfo, self)
end

function V3a4DestinyGiftFullView:removeEvents()
	V3a4DestinyGiftFullView.super.removeEvents(self)
	self._btnreward:RemoveClickListener()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self.refreshReward, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self.refreshGiftInfo, self)
end

function V3a4DestinyGiftFullView:_btnrewardOnClick()
	local isGet = ActivityType101Model.instance:isType101RewardGet(self.actId, V3a4DestinyGiftFullView.RewardDay)

	if isGet == true then
		return
	end

	Activity101Rpc.instance:sendGet101BonusRequest(self.actId, V3a4DestinyGiftFullView.RewardDay)
end

function V3a4DestinyGiftFullView:_editableInitView()
	V3a4DestinyGiftFullView.super._editableInitView(self)
	gohelper.setActive(self._btnreward, true)
end

function V3a4DestinyGiftFullView:onOpen()
	self:checkParent()
	self:checkParam()
	self:refreshUI()
	self:setRefreshTimeTask()
end

function V3a4DestinyGiftFullView:refreshUI()
	self:refreshGiftInfo()
	self:refreshReward()
end

V3a4DestinyGiftFullView.RewardDay = 1

function V3a4DestinyGiftFullView:refreshReward()
	local rewardDay = V3a4DestinyGiftFullView.RewardDay
	local rewardConfig = ActivityType101Config.instance:getDayCO(self.actId, rewardDay)
	local param = string.split(rewardConfig.bonus, "|")
	local data = string.splitToNumber(param[1], "#")
	local count = data[3]

	self._txtnum.text = tostring(count)

	local icon, iconPath = ItemModel.instance:getItemConfigAndIcon(data[1], data[2], true)

	self._simagerewardIcon:LoadImage(iconPath)

	local isGet = ActivityType101Model.instance:isType101RewardGet(self.actId, rewardDay)

	gohelper.setActive(self._gocanget, not isGet)
	gohelper.setActive(self._goreceive, isGet)

	self._btnreward.enabled = not isGet
end

return V3a4DestinyGiftFullView
