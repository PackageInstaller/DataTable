-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonPassPortBuyView.lua

module("logic.extensions.season.view.SeasonPassPortBuyView", package.seeall)

local SeasonPassPortBuyView = class("SeasonPassPortBuyView", ViewComponent)

function SeasonPassPortBuyView:ctor()
	SeasonPassPortBuyView.super.ctor(self)
end

function SeasonPassPortBuyView:buildUI()
	SeasonPassPortBuyView.super.buildUI(self)

	self._btnClose = self:getBtn("BG/btnClose")
	self._btnBuy = self:getBtn("BG/btnBuy")
	self._btnGet = self:getBtn("BG/btnGet")
	self._txtGoodCost = goutil.findChildTextComponent(self.mainGO, "BG/btnBuy/txt")
	self._goItem = self:getGo("BG/item")
	self._goBtnGet = self:getGo("BG/btnGet")
	self._goImgMark = self:getGo("BG/prizeAll/imgMark")
	self._goTableAll = self:getGo("BG/prizeAll/tableShow")
	self._goTableNow = self:getGo("BG/prizeNow/tableShow")
	self._goNowTxt1 = self:getGo("BG/prizeNow/txt_1")
	self._goAllTxt1 = self:getGo("BG/prizeAll/txt_1")
	self._tableviewAll = ScrollerList.create(self._goTableAll, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._tableviewNow = ScrollerList.create(self._goTableNow, self._goItem, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTitleNow = self:getTxt("BG/prizeNow/txt")
	self._txtTitleAll = self:getTxt("BG/prizeAll/txt")
	self._txtBtnBuy = self:getTxt("BG/btnBuy/txt")
	self._discountTip = self:getGo("BG/discountTip")

	goutil.setActive(self._goBtnGet, false)
	goutil.setActive(self._discountTip, false)
	goutil.setActive(self._goNowTxt1, false)
	goutil.setActive(self._goAllTxt1, false)
	goutil.setActive(self._goImgMark, false)
end

function SeasonPassPortBuyView:bindEvents()
	SeasonPassPortBuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
end

function SeasonPassPortBuyView:unbindEvents()
	SeasonPassPortBuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function SeasonPassPortBuyView:destroyUI()
	SeasonPassPortBuyView.super.destroyUI(self)
end

function SeasonPassPortBuyView:onEnter()
	SeasonPassPortBuyView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	self._viewData = params[1]

	local price = PayConfig.instance:getPayMoneyYuan(self._viewData.payGoodsId)

	self._txtBtnBuy.text = string.format("¥%s", price)

	self._tableviewAll:reloadData(self._viewData.rewardAllData)
	self._tableviewNow:reloadData(self._viewData.rewardNowData)
end

function SeasonPassPortBuyView:onEnterFinished()
	SeasonPassPortBuyView.super.onEnterFinished(self)
end

function SeasonPassPortBuyView:onExit()
	SeasonPassPortBuyView.super.onExit(self)
	self._tableviewAll:dispose()
	self._tableviewNow:dispose()
end

function SeasonPassPortBuyView:onExitFinished()
	SeasonPassPortBuyView.super.onExitFinished(self)
end

function SeasonPassPortBuyView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.item = goutil.findChild(cell.go, "point")
	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")

	MaterialMgr.resetAll(cell.item)
	self:_removeCellEff(cell.item)

	return cell
end

function SeasonPassPortBuyView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)
	local proxy = MaterialMgr.setCellByCfg(data, cell.item)

	if proxy then
		proxy:setAutoTips(true)
	end

	cell.txtName.text = MaterialMgr.getMaterialsNameByCfg(data)
end

function SeasonPassPortBuyView:_removeCellEff(go)
	if not go then
		return
	end

	self._effs = self._effs or {}

	if self._effs[go] then
		UIEffectManager.instance:stopEffect(self._effs[go])

		self._effs[go] = nil
	end
end

function SeasonPassPortBuyView:_onClickBtnBuy()
	SeasonModeWarOrderController.instance:sendSeasonPassPortBuy(self._viewData)
	self:close()
end

return SeasonPassPortBuyView
