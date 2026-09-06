-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dressactivityshop/view/GiftPackSaleGodGemView.lua

module("logic.extensions.dressactivityshop.view.GiftPackSaleGodGemView", package.seeall)

local GiftPackSaleGodGemView = class("GiftPackSaleGodGemView", ViewComponent)
local SingleGiftShowParamsEnum = {
	SHOWDISCOUNT = "showdiscount"
}

function GiftPackSaleGodGemView:ctor()
	GiftPackSaleGodGemView.super.ctor(self)
end

function GiftPackSaleGodGemView:unbindEvents()
	GiftPackSaleGodGemView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnJump)
	GameUtil.rmClickHandler(self._btnBuy)

	for _, cell in ipairs(self._singleCells) do
		GameUtil.rmClickHandler(cell.btnBuy)
	end
end

function GiftPackSaleGodGemView:bindEvents()
	GiftPackSaleGodGemView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnJump, self._onClickBtnJump, self)
	GameUtil.addClickHandler(self._btnBuy, self._onClickBtnBuy, self)

	for id, cell in ipairs(self._singleCells) do
		GameUtil.addClickHandler(cell.btnBuy, GameUtil.handler(self._onClickBtnBuySingle, self, id), self)
	end
end

function GiftPackSaleGodGemView:buildUI()
	GiftPackSaleGodGemView.super.buildUI(self)

	self._txtTime = self:getTxt("txtTime")
	self._txtOpenTime = self:getTxt("openTime/txt")
	self._btnJump = self:getGo("btnJump")
	self._btnBuy = self:getGo("btnBuy")
	self._txtSale = self:getTxt("btnBuy/txtSale")
	self._txtCost = self:getTxt("btnBuy/txtCost")
	self._itemCost = self:getGo("btnBuy/txtCost/item")
	self._txtDiscount = self:getTxt("tagdiscount/txt")
	self._txtOriginal = self:getTxt("tipOriginal/txt")
	self._txtTip = self:getTxt("txtTip")
	self._conSinglecells = self:getGo("singlecells")
	self._singleCells = {}

	for i = 1, 6 do
		local cell = {}

		cell.go = self:getGo("singlecells/cell" .. i)
		cell.itemcon = goutil.findChild(cell.go, "itemcon")
		cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
		cell.conNoSale = goutil.findChild(cell.go, "notSale")
		cell.btnBuy = goutil.findChild(cell.go, "notSale/btnBuy")
		cell.txtCost = goutil.findChildTextComponent(cell.go, "notSale/btnBuy/txtCost")
		cell.iconCost = goutil.findChild(cell.go, "notSale/btnBuy/txtCost/item")
		cell.txtDiscount = goutil.findChildTextComponent(cell.go, "notSale/tagdiscount/txt")
		cell.conSale = goutil.findChild(cell.go, "sale")
		cell.petIcon = goutil.findChild(cell.go, "petIcon/icon")

		table.insert(self._singleCells, cell)
	end
end

function GiftPackSaleGodGemView:onExit()
	GiftPackSaleGodGemView.super.onExit(self)
	removetimer(self._updateTimerText, self)
	MaterialMgr.resetAll(self._itemCost)

	for _, cell in ipairs(self._singleCells) do
		MaterialMgr.resetAll(cell.itemcon)
		MaterialMgr.resetAll(cell.iconCost)
		MaterialMgr.resetAll(cell.petIcon)
	end
end

function GiftPackSaleGodGemView:onEnter()
	GiftPackSaleGodGemView.super.onEnter(self)
	self.addGEvent(self, PayTrussGodGemAgent.PM_PayTrussGodGemInfoRes, self._updateUIByInfo, self)
	self.addGEvent(self, PayTrussGodGemAgent.PM_PayTrussGodGemBuyRes, self._handleBuySuc, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId == 0 then
		self._activityId = PayTrussGodGemController.instance:getDefaultGiftPackActivityId()
	end

	if not ActivityDefineController.instance:checkIsInActivityTimeByActivityId(self._activityId) then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	self:_updateTimer()
	PayTrussGodGemController.instance:_sendPayTrussGodGemInfoReq(self._activityId)
end

function GiftPackSaleGodGemView:_handleBuySuc()
	TipsFacade.instance:openCommonTips(lang("购买成功"))
	PayTrussGodGemController.instance:_sendPayTrussGodGemInfoReq(self._activityId)
end

function GiftPackSaleGodGemView:_updateUIByCfg()
	self._singleCfgs = DressActivityShopGodGemConfig.instance:getSingleCfgByActId(self._activityId)
	self._suitCfg = DressActivityShopGodGemConfig.instance:getSuitCfgByActId(self._activityId)
	self._txtOpenTime.text = TimeGateController.instance:getActTimeShow(self._activityId)

	if self._suitCfg then
		if not self._suitCfg.price then
			local priceStr = ""

			self._curCostType, self._curCostId, self._curCostNum = MaterialMgr.getMatParams(priceStr)

			MaterialMgr.setIcon(self._itemCost, self._curCostType, self._curCostId)

			self._curCostMatName = MaterialMgr.getMaterialsName(self._curCostType, self._curCostId)
			self._txtCost.text = self._curCostNum
			self._txtOriginal.text = self._suitCfg.desc2

			if not self._suitCfg.showDiscount then
				self._txtDiscount.text = langPara("%s折", self._suitCfg.showDiscount)
				self._txtTip.text = self._suitCfg.desc3

				local activityType = ActivityDefineController.instance:getActTypeByActId(self._activityId)
				local actCfg = ActivityDefineConfig.instance:getCfgById(activityType, self._activityId)

				self._endTime = GameUtil.string2time(actCfg.endTime)

				for id, cell in ipairs(self._singleCells) do
					local singleCfg = self._singleCfgs[id]

					if singleCfg then
						goutil.setActive(cell.go, true)

						local costType, costId, costNum = MaterialMgr.getMatParams(singleCfg.price)

						MaterialMgr.setIcon(cell.iconCost, costType, costId)

						cell.txtCost.text = costNum
						cell.txtName.text = singleCfg.name

						local discount = self:_parseSingleCfgShowParams(singleCfg.otherParams, SingleGiftShowParamsEnum.SHOWDISCOUNT)

						cell.txtDiscount.text = langPara("%s折", discount)

						if not singleCfg.giftContent then
							MaterialMgr.resetAll(cell.itemcon)
							MaterialMgr.setCellListByCfg(singleCfg.giftContent, cell.itemcon)

							if not singleCfg.skinId then
								MaterialMgr.resetAll(cell.petIcon)

								if singleCfg.skinId > 0 then
									MaterialMgr.setIcon(cell.petIcon, MatType.PET_SKIN, singleCfg.skinId)
								end
							end
						end
					else
						goutil.setActive(cell.go, false)
					end
				end
			end
		end
	end
end

function GiftPackSaleGodGemView:_updateUIByInfo()
	self._hasSaleSingleCount = 0
	self._hasBuySingleIdsMap = {}

	local hasPurchasedIds = PayTrussGodGemModel.instance:_getPayTrussInfoFormModel()

	for _, id in ipairs(hasPurchasedIds) do
		self._hasBuySingleIdsMap[id] = true
		self._hasSaleSingleCount = self._hasSaleSingleCount + 1
	end

	goutil.setActive(self._txtCost.gameObject, self._hasSaleSingleCount == 0)
	goutil.setActive(self._txtSale.gameObject, self._hasSaleSingleCount > 0)
	GameUtil.SetGray(self._btnBuy, self._hasSaleSingleCount > 0)

	for id, cell in ipairs(self._singleCells) do
		local canBuySingle = not self._hasBuySingleIdsMap[id] and self._hasSaleSingleCount < #self._singleCfgs

		goutil.setActive(cell.conNoSale, canBuySingle)
		goutil.setActive(cell.conSale, not canBuySingle)
	end
end

function GiftPackSaleGodGemView:_updateTimer()
	local leftTime = self._endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_1"))

		return
	end

	settimer(1, self._updateTimerText, self, true)
end

function GiftPackSaleGodGemView:_updateTimerText()
	local leftTime = self._endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show(lang("text_equip_desc_1"))
		removetimer(self._updateTimerText, self)

		return
	end

	self._txtTime.text = langPara("text_countdown_dhms", GameUtil.getTimeDDHHMMSS(leftTime))
end

function GiftPackSaleGodGemView:_onClickBtnJump()
	GotoMgr.gotoByString("func#1292")
end

function GiftPackSaleGodGemView:_onClickBtnBuy()
	if self._hasSaleSingleCount > 0 then
		local tips = lang("已购买单件商品，无法再享受打包价~")

		TipsFacade.instance:openCommonTips((self._hasSaleSingleCount >= #self._singleCfgs or nil) and lang("已购买所有单件商品，不能重复购买~"))

		return
	end

	local buyTips = langPara("确定花费%s%s购买【%s】吗?", self._curCostNum, self._curCostMatName, self._suitCfg.desc1)

	local function okFunc()
		local buyId = -1

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self._activityId, buyId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(self._curCostType, self._curCostId, self._curCostNum, buyTips, okFunc)
end

function GiftPackSaleGodGemView:_onClickBtnBuySingle(id)
	if self._hasSaleSingleCount >= #self._singleCfgs then
		TipsFacade.instance:openCommonTips(lang("已购买所有单件商品，不能重复购买~"))

		return
	end

	if self._hasBuySingleIdsMap[id] then
		TipsFacade.instance:openCommonTips(lang("已购买该单件商品，无法再购买~"))

		return
	end

	local singleCfg = self._singleCfgs[id]

	if not singleCfg then
		return
	end

	local costType, costId, costNum = MaterialMgr.getMatParams(singleCfg.price)
	local matName = MaterialMgr.getMaterialsName(costType, costId)
	local buyTips = langPara("确定花费%s%s购买【%s】吗?\n<size=20>注：购买其中任一礼包后，无法再使用打包价购买</size>", costNum, matName, singleCfg.name)

	local function okFunc()
		local buyId = singleCfg.id

		PayTrussGodGemController.instance:_sendPM_PayTrussGodGemBuyReq(self._activityId, buyId)
	end

	TipsFacade.instance:openPopupCostMatViewNew(costType, costId, costNum, buyTips, okFunc)
end

function GiftPackSaleGodGemView:_parseSingleCfgShowParams(paramsStr, paramsType)
	local params = string.split(paramsStr, "#")

	for _, param in ipairs(params) do
		local kv = string.split(param, ":")

		if #kv == 2 then
			local key = kv[1]
			local value = kv[2]

			if key == paramsType then
				return value
			end
		end
	end

	return ""
end

return GiftPackSaleGodGemView
