-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/doubleeleven/view/RebatemallView.lua

module("logic.extensions.doubleeleven.view.RebatemallView", package.seeall)

local RebatemallView = class("RebatemallView", ViewComponent)

function RebatemallView:ctor()
	RebatemallView.super.ctor(self)
end

function RebatemallView:unbindEvents()
	RebatemallView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnGoto)
end

function RebatemallView:bindEvents()
	RebatemallView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnTip, self._onClickTip, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function RebatemallView:buildUI()
	RebatemallView.super.buildUI(self)

	self._petCon = self:getGo("petCon")
	self._goldBarCon = self:getGo("goldBarCon")
	self._rabateProgressGo = self:getGo("rabateProgress")
	self._ptableviewGo = self:getGo("rabateProgress/tableview")
	self._ptablecell = self:getGo("rabateProgress/buyItem")
	self._shopGo = self:getGo("shop")
	self._stableviewGo = self:getGo("shop/tableview")
	self._stablecell = self:getGo("shop/buyItem")
	self._rewardSlider = self:getGo("scorollRewardAnim")
	self._txtTime = self:getTxt("time/txtTime")
	self._txtBubble = self:getTxt("bubble/txtDesc")
	self._btnTip = self:getBtn("btnTip")
	self._btnGoto = self:getBtn("rabateProgress/btnGoto")
	self._playerSliderMo = PlayerSliderMo.New(self._rewardSlider)
	self._ptableview = ScrollerList.create(self._ptableviewGo, self._ptablecell, GameUtil.handler(self._updatePCell, self), GameUtil.handler(self._clearPCell, self))
	self._stableview = ScrollerList.create(self._stableviewGo, self._stablecell, GameUtil.handler(self._updateSCell, self), GameUtil.handler(self._clearSCell, self))
	self._txtNum = self:getTxt("scorollRewardAnim/txtNum")
end

function RebatemallView:onExit()
	RebatemallView.super.onExit(self)
	self._ptableview:dispose()
	self._stableview:dispose()
	self._playerSliderMo:onExit()
	RoleObjectPool.instance:removeRole(self._loader)
end

function RebatemallView:onEnter()
	RebatemallView.super.onEnter(self)

	self._activityId = ActivityDefineController.instance:getActivityIdByType(GameEnum.ActivityType.RebateMall)
	self._actCfgs = DoubleElevenConfig.instance:getRebateMallActCfgs(self._activityId)
	self._itemsCfg = DoubleElevenConfig.instance:getRebateItemCfgs(self._activityId)
	self._prizeCfgs = DoubleElevenConfig.instance:getRebatePrizeCfgs(self._activityId)
	self._raceId = self._actCfgs.raceId

	RebateMallController.instance:setActId(self._activityId)
	self.addGEvent(self, GlobalNotify.RebateMallPeriod1InfoRes, self._refreshProgress, self)
	self.addGEvent(self, GlobalNotify.RebateMallPeriod2InfoRes, self._refreshShop, self)
	self.addGEvent(self, GlobalNotify.RebateMallGainPrizeRes, self._sendRebateMallPeriodInfoReq, self)
	self.addGEvent(self, GlobalNotify.RebateMallBuyRes, self._sendRebateMallPeriodInfoReq, self)

	self._shopIsOpen = RebateMallController.instance:isRebateMallBuyShopOpen()

	self:_sendRebateMallPeriodInfoReq()
	self:_initUI()
	self:_initPlayerParams()
	self:_setNum()
end

function RebatemallView:_initUI()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.RebateMall, self._activityId)

	self._txtTime.text = string.format("活动时间：%s", GameUtil.getFormatTimeByStamp(startTime, endTime))

	local x, y, scale = 0, 0, 1

	self._loader = RoleObjectPool.instance:addRoleToParent(self._loader, self._raceId, self._petCon, scale, nil, true, x, y)

	local name = self._actCfgs.deduceTo

	if self._shopIsOpen then
		local itemsData = RebateMallController.instance:shopItemsData()

		self._stableview:reloadData(itemsData)
	else
		local itemsData = self._itemsCfg

		self._ptableview:reloadData(itemsData)
	end

	local objList = {
		{
			showAdd = false,
			id = name
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	GameUtil.SetActive(self._rabateProgressGo, not self._shopIsOpen)
	GameUtil.SetActive(self._shopGo, self._shopIsOpen)
	GameUtil.SetActive(self._ptablecell, false)
	GameUtil.SetActive(self._stablecell, false)
end

function RebatemallView:_sendRebateMallPeriodInfoReq()
	RebateMallController.instance:sendRebateMallPeriodInfoReq()
end

function RebatemallView:_refreshProgress()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()

	self._txtBubble.text = self._actCfgs.bubbleDesc1

	self:_setNum()
end

function RebatemallView:_refreshShop()
	local itemsData = RebateMallController.instance:shopItemsData()

	self._stableview:reloadData(itemsData)

	self._txtBubble.text = self._actCfgs.bubbleDesc2

	self:_setNum()
end

function RebatemallView:_updatePCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local item = goutil.findChild(cell, "item")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local price = goutil.findChild(cell, "price")
	local txtPrice = goutil.findChildTextComponent(cell, "price/txtPrice")
	local priceIcon = goutil.findChild(cell, "price/txtPrice/coin")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.cost)

	MaterialMgr.setCellByCfg(data.content, item)
	MaterialMgr.setIcon(priceIcon, matType, matId)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.content)
	txtPrice.text = matNum
	txtLimit.text = string.format("限购：%s", data.limitTimes)

	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickProgressItem, self, cell.gameObject, data.content))
end

function RebatemallView:_clearPCell(cell)
	local item = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(cell.gameObject)
end

function RebatemallView:_updateSCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local item = goutil.findChild(cell, "item")
	local txtLimit = goutil.findChildTextComponent(cell, "txtLimit")
	local price = goutil.findChild(cell, "price")
	local txtPrice = goutil.findChildTextComponent(cell, "price/txtPrice")
	local priceIcon = goutil.findChild(cell, "price/txtPrice/coin")
	local sellOut = goutil.findChild(cell, "sellOut")
	local matType, matId, matNum = MaterialMgr.getMatParams(data.cfg.cost)

	MaterialMgr.setCellByCfg(data.cfg.content, item)
	MaterialMgr.setIcon(priceIcon, matType, matId)

	txtName.text = MaterialMgr.getMaterialsNameByCfg(data.cfg.content)
	txtPrice.text = matNum
	txtLimit.text = string.format("限购：%s/%s", data.cfg.limitTimes - data.buyTimes, data.cfg.limitTimes)

	GameUtil.SetActive(sellOut, data.isSellOut)
	GameUtil.addClickHandler(cell.gameObject, GameUtil.handler(self._onClickShopItem, self, data))
end

function RebatemallView:_clearSCell(cell)
	local item = goutil.findChild(cell, "item")
	local priceIcon = goutil.findChild(cell, "price/txtPrice/icon")

	MaterialMgr.resetAll(item)
	MaterialMgr.clearIcon(priceIcon)
	GameUtil.rmClickHandler(cell.gameObject)
end

function RebatemallView:_initPlayerParams()
	if not self._prizeCfgs then
		return
	end

	local playerParam = {}

	playerParam.view = self
	playerParam.prizeCfgs = self._prizeCfgs

	function playerParam.getPlayerProgress()
		return RebateMallModel.instance:getRechargeMoney() * 10
	end

	function playerParam.getNeedScoreByRewardCfg(rewardCfg)
		return rewardCfg.needMoney * 10
	end

	function playerParam.isPlayerRewardCanGet(rewardCfg)
		return RebateMallModel.instance:getRechargeMoney() >= rewardCfg.needMoney and not RebateMallModel.instance:isGainPrize(rewardCfg.id)
	end

	playerParam.effPath = "fx_ui_juqingfuben/fx_ui_juqingfuben02.prefab"

	function playerParam.isPlayerRewardGeted(rewardCfg)
		return RebateMallModel.instance:isGainPrize(rewardCfg.id)
	end

	function playerParam.sendGainPlayerPrizeReq(rewardCfg)
		RebateMallController.instance:sendPM_RebateMallGainPrizeReq(self._activityId, rewardCfg.id)
	end

	local isSkipAnimation = true

	self._playerSliderMo:initParam(playerParam, isSkipAnimation)
	self._playerSliderMo:onEnter()
	self._playerSliderMo:updatePlayerReward()
	self._playerSliderMo:relocation()
end

function RebatemallView:_onClickProgressItem(cell, itemStr)
	CommonTipsMgr.instance:openTipsByConfStr(cell, itemStr)
end

function RebatemallView:_onClickShopItem(itemData)
	if itemData.isSellOut then
		FloatWordMgr.instance:show("商品已售罄")

		return
	end

	UIStateManager.instance:push(ViewName.RebatemallbuyView, itemData.cfg)
end

function RebatemallView:_onClickTip()
	TipsFacade.instance:openRulesView("rabatemall_rule")
end

function RebatemallView:_onClickGoto()
	GotoMgr.gotoByString("mibao#GodDiamond")
end

function RebatemallView:_setNum()
	self._txtNum.text = RebateMallModel.instance:getRechargeMoney() * 10
end

return RebatemallView
