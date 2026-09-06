-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/payshop/view/PayshopjumptopageView.lua

module("logic.extensions.payshop.view.PayshopjumptopageView", package.seeall)

local PayshopjumptopageView = class("PayshopjumptopageView", TableViewComponent)
local json = require("cjson")

function PayshopjumptopageView:ctor()
	PayshopjumptopageView.super.ctor(self)
end

function PayshopjumptopageView:unbindEvents()
	PayshopjumptopageView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._btnGetDisc:RemoveClickListener()
	self._btnLijian:RemoveClickListener()
end

function PayshopjumptopageView:bindEvents()
	PayshopjumptopageView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnTip:AddClickListener(self._onClickbtnTip, self)
	self._btnGetDisc:AddClickListener(self._onClickbtnGetDisc, self)
	self._btnLijian:AddClickListener(self._onClickbtnLijian, self)
end

function PayshopjumptopageView:buildUI()
	PayshopjumptopageView.super.buildUI(self)

	self._btnClose = self:getBtn("lefttop/btnClose")
	self._btnTip = self:getBtn("lefttop/btnTip")
	self._btnGetDisc = self:getBtn("btnGetDisc")
	self._btnLijian = self:getBtn("btnLijian")
	self._tip = self:getGo("lefttop/tip")
	self._updateTip = self:getTxt("lefttop/tip/txtUpdateTip")
end

function PayshopjumptopageView:onExit()
	PayshopjumptopageView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.GetDiscountGiftInfoRes, self._GetDiscountGiftInfoRes, self)
end

function PayshopjumptopageView:onEnter()
	PayshopjumptopageView.super.onEnter(self)
	GlobalDispatcher:addListener(PayShopController.GetDiscountGiftInfoRes, self._GetDiscountGiftInfoRes, self)
	self:_updateUI()
	self:_autoOpenTip()
	self:_checkOpDiscountView()
end

function PayshopjumptopageView:_onClickbtnClose()
	self:close()
end

function PayshopjumptopageView:_onClickbtnTip()
	TipsFacade.instance:openRulesView("payshopjumptopage")
end

function PayshopjumptopageView:_onClickbtnGetDisc()
	UIStateManager.instance:push(ViewName.PayshopdiscgiftView)
end

function PayshopjumptopageView:_onClickbtnLijian()
	UIStateManager.instance:push(ViewName.MallautotabpopView)
end

function PayshopjumptopageView:_getPath()
	return {
		cellPath = "cell",
		viewPath = "ScrollView"
	}
end

function PayshopjumptopageView:_updateCell(view, cell, data)
	local goImgIcon = goutil.findChild(cell.gameObject, "imgIcon")
	local goImgPoint = goutil.findChild(cell.gameObject, "imgPoint")
	local goLock = goutil.findChild(cell.gameObject, "lock")
	local txtLock = goutil.findChildTextComponent(cell.gameObject, "lock/txtLock")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local tagGo = goutil.findChild(cell.gameObject, "tag")
	local txtTag = goutil.findChildTextComponent(cell.gameObject, "tag/txt")
	local isLock = data.funcId > 0 and not FuncOpenModel.instance:getFuncIsOpen(data.funcId)
	local lockTip = ""

	goutil.setActive(goImgPoint, false)

	if data.redPoints then
		for i, rid in ipairs(data.redPoints) do
			if RedPointModel.instance:isActive(rid) then
				goutil.setActive(goImgPoint, true)

				break
			end
		end
	end

	goutil.setActive(goLock, isLock)

	txtName.text = data.name

	uGuiUtil.setSpriteToImage(goImgIcon, nil, GameUrl.getBigbgFolderUrl("payshop", data.bgName))

	if isLock then
		lockTip = FuncOpenModel.instance:getFuncLockDescription(data.funcId)
		txtLock.text = lockTip
	end

	btn:AddClickListener(function()
		if isLock then
			FloatWordMgr.instance:show(lockTip)

			return
		end

		PayShopController.instance:openShopByJumpPageConfig(data.id)
	end)
	goutil.setActive(tagGo, data.tagDesc ~= "")

	txtTag.text = data.tagDesc
end

function PayshopjumptopageView:_clearTableview(cell)
	local goImgIcon = goutil.findChild(cell.gameObject, "imgIcon")

	uGuiUtil.clearImage(goImgIcon)
end

function PayshopjumptopageView:_updateUI()
	local desc = PayShopConfig.instance:getUpdateTipCfg()

	GameUtil.SetActive(self._tip, not string.nilorempty(desc))

	if desc then
		self._updateTip.text = desc
	end

	local temps = PayShopConfig.instance:getJumpPageCfgs()
	local cfgs = {}

	for i, v in ipairs(temps) do
		if v.funcId <= 0 or FuncOpenModel.instance:getFuncIsOpen(v.funcId) then
			table.insert(cfgs, v)
		end
	end

	table.sort(cfgs, function(a, b)
		return a.rank < b.rank
	end)

	self._curViewDatas = cfgs

	self:reloadData()
end

function PayshopjumptopageView:_autoOpenTip()
	local key = "payshopjumptopage"
	local value = GameUtil.getUserData(key)

	if string.nilorempty(value) then
		GameUtil.saveUserData(key, "ok")
		self:_onClickbtnTip()
	end
end

function PayshopjumptopageView:_checkOpDiscountView()
	local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
	local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

	goutil.setActive(self._btnGetDisc.gameObject, acfg)

	if acfg then
		PayShopAgent.instance:sendGetDiscountGiftInfoReq(acfg.activityId)
	end
end

function PayshopjumptopageView:_GetDiscountGiftInfoRes(status)
	if status == 0 then
		local activityType = GameEnum.ActivityType.PAY_SHOP_DISCOUNT_GIFT
		local acfg = ActivityDefineController.instance:getActivityCfgByType(activityType)

		if acfg and not PayShopModel.instance:isGetAllDiscountGift(acfg.activityId) then
			UIStateManager.instance:push(ViewName.PayshopdiscgiftView)
		end
	end
end

return PayshopjumptopageView
