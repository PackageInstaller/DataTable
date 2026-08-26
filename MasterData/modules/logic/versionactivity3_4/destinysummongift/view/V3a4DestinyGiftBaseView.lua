-- chunkname: @modules/logic/versionactivity3_4/destinysummongift/view/V3a4DestinyGiftBaseView.lua

module("modules.logic.versionactivity3_4.destinysummongift.view.V3a4DestinyGiftBaseView", package.seeall)

local V3a4DestinyGiftBaseView = class("V3a4DestinyGiftBaseView", BaseView)

function V3a4DestinyGiftBaseView:onInitView()
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

function V3a4DestinyGiftBaseView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btngoto:AddClickListener(self._btngotoOnClick, self)
end

function V3a4DestinyGiftBaseView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btngoto:RemoveClickListener()
end

function V3a4DestinyGiftBaseView:_btngotoOnClick()
	if self.packageId == nil then
		logError("3.4 狂想卡池礼包 缺少礼包id")

		return
	end

	local param = string.format("%s#%s", JumpEnum.JumpView.SummonView, self.poolId)

	JumpController.instance:jumpByParam(param)
end

function V3a4DestinyGiftBaseView:_btnbuyOnClick()
	if self.packageId == nil then
		logError("3.4 狂想卡池礼包 缺少礼包id")

		return
	end

	PayController.instance:startPay(self.packageId)
end

function V3a4DestinyGiftBaseView:_editableInitView()
	self._giftRewardItemList = {}
	self._txtTime.text = luaLang("ended")
end

function V3a4DestinyGiftBaseView:onUpdateParam()
	return
end

function V3a4DestinyGiftBaseView:onOpen()
	self:checkParent()
	self:checkParam()
	self:refreshUI()
	self:setRefreshTimeTask()
end

function V3a4DestinyGiftBaseView:setRefreshTimeTask()
	if not self.packageId then
		return
	end

	self:refreshTime()
	TaskDispatcher.runRepeat(self.refreshTime, self, 1)
end

function V3a4DestinyGiftBaseView:checkParent()
	if self.viewParam then
		if self.viewParam then
			gohelper.setParent(self.viewGO, self.viewParam)
		end
	end
end

function V3a4DestinyGiftBaseView:checkParam()
	if not self.viewParam.actId then
		local actId = ActivityEnum.Activity.V3a4_DestinyGift

		if actId == nil then
			logError("3.4 狂想卡池礼包 缺少活动id")

			return
		end

		self.actId = actId

		local config = ActivityConfig.instance:getActivityCo(actId)

		if config == nil then
			logError("3.4 狂想卡池礼包 活动配置不存在 活动id:" .. tostring(actId))

			return
		end

		self.actConfig = config

		local paramList = string.splitToNumber(self.actConfig.param, "#")

		self.packageId = paramList[1]
		self.poolId = paramList[2]
	end
end

function V3a4DestinyGiftBaseView:refreshUI()
	self:refreshGiftInfo()
end

function V3a4DestinyGiftBaseView:refreshGiftInfo()
	if self.packageId == nil then
		logError("3.4 狂想卡池礼包 缺少礼包id")

		return
	end

	local packageConfig = StoreConfig.instance:getChargeGoodsConfig(self.packageId)

	if not packageConfig then
		return
	end

	self:refreshBuyState(packageConfig)
	self:refreshGiftReward(packageConfig)
end

function V3a4DestinyGiftBaseView:refreshBuyState(packageConfig)
	local packageMo = StoreModel.instance:getGoodsMO(packageConfig.id)
	local isSoldOut = true

	if not packageMo then
		logNormal("3.4 狂想卡池礼包 缺少礼包数据 id: " .. tostring(packageConfig.id))
	else
		isSoldOut = packageMo:isSoldOut()
	end

	gohelper.setActive(self._gobuy, not isSoldOut)
	gohelper.setActive(self._gogoto, isSoldOut)

	if isSoldOut then
		return
	end

	self._txtcost.text = tostring(packageConfig.price)
end

function V3a4DestinyGiftBaseView:refreshGiftReward(packageConfig)
	local giftDataList = {}

	if string.nilorempty(packageConfig.item) then
		logError("3.4 狂想卡池礼包 缺少礼包获得道具数据 id: " .. tostring(packageConfig.id))
	else
		local param = string.split(packageConfig.item, "|")

		for _, singleParam in ipairs(param) do
			local singleData = string.splitToNumber(singleParam, "#")

			table.insert(giftDataList, singleData)
		end
	end

	local haveReward = next(giftDataList)

	gohelper.setActive(self._gogiftreward, haveReward)

	if not haveReward then
		return
	end

	gohelper.CreateObjList(self, self.onGetItemGo, giftDataList, self._gogiftreward, self._goicon1)

	self.giftDataList = giftDataList
end

function V3a4DestinyGiftBaseView:onGetItemGo(go, data)
	local giftItem = IconMgr.instance:getCommonPropItemIcon(go)

	table.insert(self._giftRewardItemList, giftItem)
	giftItem:setMOValue(data[1], data[2], data[3], nil, true)
	giftItem:setScale(0.75)
end

function V3a4DestinyGiftBaseView:refreshTime()
	if not self.packageId then
		self._txtTime.text = luaLang("ended")

		return
	end

	local packageMo = StoreModel.instance:getGoodsMO(self.packageId)

	if not packageMo then
		self._txtTime.text = luaLang("ended")

		return
	end

	local endTime = packageMo.offlineTime
	local nowTime = ServerTime.now()

	self._txtTime.text = endTime <= nowTime and luaLang("ended") or TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)
end

function V3a4DestinyGiftBaseView:onClose()
	TaskDispatcher.cancelTask(self.refreshTime, self)
end

function V3a4DestinyGiftBaseView:onDestroyView()
	tabletool.clear(self._giftRewardItemList)
end

return V3a4DestinyGiftBaseView
