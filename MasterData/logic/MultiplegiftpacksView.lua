-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/hdsummerlotteryrecommend/view/MultiplegiftpacksView.lua

module("logic.extensions.hdsummerlotteryrecommend.view.MultiplegiftpacksView", package.seeall)

local MultiplegiftpacksView = class("MultiplegiftpacksView", ViewComponent)

function MultiplegiftpacksView:ctor()
	MultiplegiftpacksView.super.ctor(self)
end

function MultiplegiftpacksView:unbindEvents()
	MultiplegiftpacksView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnBuy)
end

function MultiplegiftpacksView:bindEvents()
	MultiplegiftpacksView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, GameUtil.handler(self.close, self))
	GameUtil.addClickHandler(self._btnBuy, self._onClickBuy, self)
end

function MultiplegiftpacksView:buildUI()
	MultiplegiftpacksView.super.buildUI(self)

	self._txtTime = self:getTxt("time/txt")
	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._txtOldPrice = self:getTxt("btnBuy/txtOldPrice")
	self._oldPriceIcon = self:getImg("btnBuy/txtOldPrice/icon")
	self._txtBuy = self:getTxt("btnBuy/txtBuy")
	self._sellIcon = self:getImg("btnBuy/txtBuy/icon")
	self._soldout = self:getGo("soldout")
	self._gift = self:getGo("gift")
	self._giftList = {}

	for i = 1, self._gift.transform.childCount do
		local cellInfo = {}
		local go = goutil.findChild(self._gift, "cell_" .. i)

		if go then
			cellInfo.go = go
			cellInfo.txtName = goutil.findChildTextComponent(go, "txtName")
			cellInfo.item = goutil.findChild(go, "item")
			cellInfo.tip = goutil.findChild(go, "tip")
			cellInfo.outTime = goutil.findChild(go, "outTime")
			self._giftList[i] = cellInfo
		end
	end
end

function MultiplegiftpacksView:onExit()
	MultiplegiftpacksView.super.onExit(self)

	for id, cell in pairs(self._giftList) do
		MaterialMgr.resetAll(cell.item)
	end

	GlobalDispatcher:removeListener(GlobalNotify.QingGuGiftInfoRes, self._giftState, self)
	GlobalDispatcher:removeListener(GlobalNotify.QingGuGiftBuyRes, self._giftState, self)
	removetimer(self._timeCutDown, self)
end

function MultiplegiftpacksView:onEnter()
	MultiplegiftpacksView.super.onEnter(self)

	self._activityId = 202001
	self._activityCfg = MultiplegiftpacksConfig.instance:getActivityCfgById(self._activityId)
	self._giftBuyState = false

	GlobalDispatcher:addListener(GlobalNotify.QingGuGiftInfoRes, self._giftState, self)
	GlobalDispatcher:addListener(GlobalNotify.QingGuGiftBuyRes, self._giftState, self)
	QingGuGiftAgent.instance:sendPM_QingGuGiftInfoReq(self._activityId)
	self:_activityTime()
	self:_initCfg()
	self:_giftShowInfo()
end

function MultiplegiftpacksView:_activityTime()
	local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.MULTIPLEGIFTPACKS, self._activityId)

	self._endTime = endTime

	self:_timeCutDown()
	removetimer(self._timeCutDown, self)
	settimer(1, self._timeCutDown, self)
end

function MultiplegiftpacksView:_timeCutDown()
	local time = self._endTime - ServerTime.now()

	if time > 0 then
		self._txtTime.text = langPara("剩余时间：%s", GameUtil.FormatTimeSymbol(time))
	end
end

function MultiplegiftpacksView:_isPassTime()
	local passSaleAwardTime = GameUtil.string2time(self._activityCfg.passSaleAwardTime)
	local time = passSaleAwardTime - ServerTime.now()

	if time > 0 then
		-- block empty
	else
		return true
	end
end

function MultiplegiftpacksView:_initCfg()
	self._extraCfg = MultiplegiftpacksConfig.instance:getExtraCfgById(self._activityId)
end

function MultiplegiftpacksView:_giftShowInfo()
	for posId, cfg in ipairs(self._extraCfg) do
		local cell = self._giftList[posId]

		cell.txtName.text = MaterialMgr.getMaterialsNameByCfg(self._extraCfg[posId].extraPrize)

		MaterialMgr.setCellByCfg(self._extraCfg[posId].extraPrize, cell.item)
		GameUtil.SetActive(cell.tip, not cfg.maskSelection)
		GameUtil.SetActive(cell.outTime, self:_isPassTime() and not cfg.maskSelection)
	end
end

function MultiplegiftpacksView:_giftState()
	local info = MultiplegiftpacksController.instance:getGiftInfo()

	self._giftBuyState = checkbool(info.bought)

	if not self._giftBuyState then
		GameUtil.SetActive(self._soldout, false)
		GameUtil.SetActive(self._btnBuy, true)

		local fakeItemArr = string.split(self._activityCfg.fakeCost, ":")

		self._txtOldPrice.text = fakeItemArr[#fakeItemArr]

		local costItemArr = string.split(self._activityCfg.costItem, ":")

		self._txtBuy.text = costItemArr[#costItemArr]

		MaterialMgr.setIcon(self._oldPriceIcon, fakeItemArr[1], fakeItemArr[2])
		MaterialMgr.setIcon(self._sellIcon, costItemArr[1], costItemArr[2])
	else
		GameUtil.SetActive(self._soldout, true)
		GameUtil.SetActive(self._btnBuy, false)
	end
end

function MultiplegiftpacksView:_onClickBuy()
	local matType, matId, matNum = MaterialMgr.getMatParams(self._activityCfg.costItem)
	local matName = MaterialMgr.getMaterialsName(matType, matId)
	local content = langPara("是否花费%s%s进行购买此礼包", matNum, matName)

	TipsFacade.instance:openPopupCostMatViewNew(matType, matId, matNum, content, function()
		QingGuGiftAgent.instance:sendPM_QingGuGiftBuyReq(self._activityId)
	end, nil, nil, nil, nil, false)
end

return MultiplegiftpacksView
