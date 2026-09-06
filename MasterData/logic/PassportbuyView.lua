-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportbuyView.lua

module("logic.extensions.passport.view.PassportbuyView", package.seeall)

local PassportbuyView = class("PassportbuyView", ViewComponent)
local json = require("cjson")

function PassportbuyView:ctor()
	PassportbuyView.super.ctor(self)
end

function PassportbuyView:buildUI()
	PassportbuyView.super.buildUI(self)

	self._btnClose = self:getBtn("BG/btnClose")
	self._btnBuy = self:getBtn("BG/btnBuy")
	self._btnGet = self:getBtn("BG/btnGet")
	self._txtGoodCost = goutil.findChildTextComponent(self.mainGO, "BG/btnBuy/txt")
	self._goItem = self:getGo("BG/item")
	self._goBtnGet = self:getGo("BG/btnGet")
	self._goImgMark = self:getGo("BG/prizeAll/imgMark")
	self._goTableAll = self:getGo("BG/prizeAll/tableShow")
	self._goTableNow = self:getGo("BG/prizeNow/tableShow")
	self._txtList, self._txtList1 = {}, {}

	table.insert(self._txtList, self:getGo("BG/prizeNow/txt"))
	table.insert(self._txtList1, self:getGo("BG/prizeNow/txt_1"))
	table.insert(self._txtList, self:getGo("BG/prizeAll/txt"))
	table.insert(self._txtList1, self:getGo("BG/prizeAll/txt_1"))
	table.insert(self._txtList, self:getGo("BG/btnBuy/txt"))
	table.insert(self._txtList1, self:getGo("BG/btnBuy/txt_1"))

	self._tableviewAll = ScrollerList.create(self._goTableAll, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewNow = ScrollerList.create(self._goTableNow, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtPrice = self:getTxt("BG/originalPrice")
	self._txtDesc = self:getTxt("BG/txtDesc")
	self._txtTitleAll = self:getTxt("BG/prizeAll/txt")
	self._bg4Rect = self:getGo("BG/bggroup_lv2/bg1/bg_4"):GetComponent(goutil.Type_RectTransform)
	self._bg5 = self:getGo("BG/bggroup_lv2/bg1/bg_5")
	self._prizeNow = self:getGo("BG/prizeNow")
	self._prizeAllRect = self:getGo("BG/prizeAll"):GetComponent(goutil.Type_RectTransform)
	self._tableLeft = self:getGo("BG/prizeAll/tableShow")
	self._discountTip = self:getGo("BG/discountTip")
	self._btnDiscount = goutil.findChild(self._discountTip, "btnBuy")
	self._txtDiscount = goutil.findChildTextComponent(self._btnDiscount, "txt")
	self._txtDiscount_1 = goutil.findChildTextComponent(self._btnDiscount, "txt_1")
end

function PassportbuyView:bindEvents()
	PassportbuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnGet:AddClickListener(self._onClickBtnGet, self)
	GameUtil.addClickHandler(self._btnDiscount, self._onClickBtnBuy, self)
end

function PassportbuyView:unbindEvents()
	PassportbuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnGet:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnDiscount)
end

function PassportbuyView:destroyUI()
	PassportbuyView.super.destroyUI(self)
end

function PassportbuyView:onEnter()
	PassportbuyView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil or #params < 3 then
		self:close()

		return
	end

	self._actCfg = params[1]
	self._funcCfg = params[2]
	self._state = params[3]
	self._sliderValue = params[4]
	self._extraParam = params[5]
	self._isAdd = checkbool(params[6])

	local goodsId = self._actCfg.goodsId

	if params[7] then
		goodsId = params[7]
	end

	self._isMaxProgress = self._sliderValue >= 1

	local isVipDiscount = VipModel.instance:getIsAbleToPassportDiscount()
	local isTimeDiscount = not string.nilorempty(self._actCfg.discountTime) and GameUtil.checkTimeStr(self._actCfg.discountTime)

	if isVipDiscount then
		goodsId = self._actCfg.vipGoodsId
	end

	local price = PayConfig.instance:getPayMoneyYuan((isTimeDiscount or nil) and self._actCfg.discountGoodsId)

	self._txtGoodCost.text = string.format("¥%s", price)
	self._txtDiscount.text = string.format("¥%s", price)
	self._txtDiscount_1.text = string.format("¥%s", PayConfig.instance:getPayMoneyYuan(self._actCfg.goodsId))

	for _, v in ipairs(self._txtList) do
		GameUtil.SetActive(v, self._state == 1)
	end

	for _, v in ipairs(self._txtList1) do
		GameUtil.SetActive(v, self._state == 2)
	end

	GameUtil.SetActive(self._discountTip, false)
	GameUtil.SetActive(self._btnBuy.gameObject, false)

	if self._state == 1 then
		if isTimeDiscount then
			GameUtil.SetActive(self._discountTip, true)
		else
			GameUtil.SetActive(self._btnBuy.gameObject, true)
		end
	end

	GameUtil.SetActive(self._goBtnGet, self._state == 2)
	GameUtil.SetActive(self._goImgMark, false)
	self:_refreshTable()
	self:_setTxtTitleAll()
end

function PassportbuyView:_setTxtTitleAll()
	self._txtTitleAll.text = self._extraParam and not string.nilorempty(self._extraParam.descAll) and self._extraParam.descAll or "购买后总计可获得"
end

function PassportbuyView:onEnterFinished()
	PassportbuyView.super.onEnterFinished(self)
end

function PassportbuyView:onExit()
	PassportbuyView.super.onExit(self)
	self._tableviewAll:dispose()
	self._tableviewNow:dispose()
end

function PassportbuyView:onExitFinished()
	PassportbuyView.super.onExitFinished(self)
end

function PassportbuyView:_refreshTable()
	local dataListNow, dataListAll = {}, {}
	local data1, data2, data3 = PassportModel.instance:getCurDataList(self._isAdd, self._funcCfg.id)

	if self._state == 1 then
		dataListNow = data2
		dataListAll = data3
	else
		dataListNow = data2
		dataListAll = data1
	end

	if dataListNow == nil or #dataListNow == 0 or GameUtil.isEmptyString(dataListNow[1]) then
		self._tableviewNow:regGetDataLen(function()
			return 0
		end)
	else
		self._tableviewNow:regGetDataLen(function()
			return #dataListNow
		end)
	end

	self._tableviewNow:reloadData(dataListNow)

	if dataListAll == nil or #dataListAll == 0 or GameUtil.isEmptyString(dataListAll[1]) then
		self._tableviewAll:regGetDataLen(function()
			return 0
		end)
	else
		self._tableviewAll:regGetDataLen(function()
			return #dataListAll
		end)
	end

	self._tableviewAll:reloadData(dataListAll)

	if self._isMaxProgress or dataListNow == nil or #dataListNow == 0 or GameUtil.isEmptyString(dataListNow[1]) then
		self:_setLeftToMiddle()
	else
		self:_resetMiddleToLeft()
	end
end

function PassportbuyView:_clearCell(cell)
	local point = goutil.findChild(cell, "point")

	MaterialMgr.resetAll(point)
end

function PassportbuyView:_updateCell(view, cell, data)
	local point = goutil.findChild(cell, "point")
	local txtName = goutil.findChildTextComponent(cell, "txtName")

	if data then
		MaterialMgr.setCellByCfg(data, point)

		txtName.text = MaterialMgr.getMaterialsNameByCfg(data)
	else
		MaterialMgr.resetAll(point)
	end
end

function PassportbuyView:_onClickBtnBuy()
	local periodData = PassportConfig.instance:getPeriodActivityCfgById(self._actCfg.actId)
	local paymentData = PassportConfig.instance:getPermanentPrizeCfgsByActId(self._actCfg.actId)

	if periodData then
		PassportController.instance:_buyPassportWithDifferentPayType(self._actCfg.actId, false, self._isAdd)
	elseif paymentData then
		local para = {
			prizeType = 2,
			funcId = self._funcCfg.id
		}

		if VipModel.instance:getIsAbleToPassportDiscount() then
			PayController.instance:sendGenOrderNoReq(self._actCfg.vipGoodsId, 3, self._actCfg.actId, json.encode(para))
		else
			PayController.instance:sendGenOrderNoReq(self._actCfg.goodsId, 3, self._actCfg.actId, json.encode(para))
		end
	else
		printError("找不到类型", self._actCfg.actId)
	end
end

function PassportbuyView:_onClickBtnGet()
	local function handler()
		GameUtil.SetActive(self._goBtnGet, false)
		GameUtil.SetActive(self._goImgMark, true)

		local isTimeDiscount = not string.nilorempty(self._actCfg.discountTime) and GameUtil.checkTimeStr(self._actCfg.discountTime)

		if isTimeDiscount then
			GameUtil.SetActive(self._discountTip, true)
		else
			GameUtil.SetActive(self._btnBuy.gameObject, true)
		end
	end

	PassportController.instance:sendOneKeyGainPrizeReq(self._actCfg.actId, self._funcCfg.id, handler, self)
end

function PassportbuyView:_resetMiddleToLeft()
	goutil.setActive(self._prizeNow, true)
	goutil.setActive(self._bg5, true)
	Framework.TransformUtil.SetAnchoredPos(self._bg4Rect, -182.41, -11.66)
	Framework.TransformUtil.SetAnchoredPos(self._prizeAllRect, -183.42, 10.03)
	GameUtil.setWidth(self._bg4Rect, 343.58)
	GameUtil.setWidth(self._tableLeft, 310)

	local ax, ay, az = Framework.TransformUtil.GetAnchoredPos(self._tableLeft.transform, 0, 0)

	GameUtil.setAnchoredPos(self._tableLeft, -155.02, ay)
end

function PassportbuyView:_setLeftToMiddle()
	goutil.setActive(self._prizeNow, false)
	goutil.setActive(self._bg5, false)
	Framework.TransformUtil.SetAnchoredPos(self._bg4Rect, 0, -11.66)
	Framework.TransformUtil.SetAnchoredPos(self._prizeAllRect, 0, 10.03)

	local ax, ay, az = Framework.TransformUtil.GetAnchoredPos(self._tableLeft.transform, 0, 0)
	local list = self._tableviewAll:getData()

	if list and #list > 2 then
		if #list == 3 then
			GameUtil.setWidth(self._bg4Rect, 510)
			GameUtil.setWidth(self._tableLeft, 480)
			GameUtil.setAnchoredPos(self._tableLeft, -232, ay)
		elseif #list == 4 then
			GameUtil.setWidth(self._bg4Rect, 680)
			GameUtil.setWidth(self._tableLeft, 650)
			GameUtil.setAnchoredPos(self._tableLeft, -315, ay)
		else
			GameUtil.setWidth(self._bg4Rect, 680)
			GameUtil.setWidth(self._tableLeft, 665)
			GameUtil.setAnchoredPos(self._tableLeft, -328, ay)
		end
	else
		GameUtil.setWidth(self._bg4Rect, 343.58)
		GameUtil.setWidth(self._tableLeft, 310)
		GameUtil.setAnchoredPos(self._tableLeft, -155.02, ay)
	end
end

return PassportbuyView
