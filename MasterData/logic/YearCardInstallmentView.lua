-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/YearCard2022/YearCardInstallmentView.lua

module("logic.extensions.yearcard.view.2022.YearCardInstallmentView", package.seeall)

local YearCardInstallmentView = class("YearCardInstallmentView", ViewComponent)

function YearCardInstallmentView:ctor()
	YearCardInstallmentView.super.ctor(self)

	self._curCellCount = 3
end

function YearCardInstallmentView:buildUI()
	YearCardInstallmentView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._slider = self:getSlider("progress/Slider")
	self._txtProgress = self:getTxt("progress/Text")
	self._cellList = {}

	for i = 1, self._curCellCount do
		local cell = {}

		cell.go = self:getGo("cellList/cell_" .. i)
		cell.btn = goutil.findChild(cell.go, "btnBuy")
		cell.txtTip = goutil.findChildTextComponent(cell.go, "txtTip")
		cell.txtPrice = goutil.findChildTextComponent(cell.btn, "txt")
		cell.cfg = nil
		self._cellList[i] = cell
	end
end

function YearCardInstallmentView:bindEvents()
	YearCardInstallmentView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, self._curCellCount do
		GameUtil.addClickHandler(self._cellList[i].btn, GameUtil.handler(self._onClickBuyGift, self, i))
	end
end

function YearCardInstallmentView:unbindEvents()
	YearCardInstallmentView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, self._curCellCount do
		GameUtil.rmClickHandler(self._cellList[i].btn)
	end
end

function YearCardInstallmentView:onEnter()
	YearCardInstallmentView.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()
	self._giftCfgs = self:_getGiftCfgs()

	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)

	self._totalGiftCfg = self:_getTotalGiftCfg()

	self:_refreshView()
end

function YearCardInstallmentView:onExit()
	YearCardInstallmentView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
end

function YearCardInstallmentView:_onClickBuyGift(id)
	YearCardController.instance:payGiftId(self._curActId, id)
end

function YearCardInstallmentView:_refreshView()
	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	for i = 1, self._curCellCount do
		local cell = self._cellList[i]

		cell.cfg = self._giftCfgs[i]
		cell.txtTip.text = langPara("限购次数 %s/%s", checkint(self._actInfo.annuityGifts[i]), cell.cfg.timesLimit)
		cell.txtPrice.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(cell.cfg.payGoodsId))
	end

	local curMoney = self._actInfo.money / 100
	local totalProgress = self._totalGiftCfg.progressGain / 100

	self._slider:SetValue(curMoney / checknumber(totalProgress))

	self._txtProgress.text = langPara("年费进度：%s/%s", curMoney, totalProgress)
end

function YearCardInstallmentView:_getGiftCfgs()
	return YearCardConfig.instance:getGiftCfg(self._curActId)
end

function YearCardInstallmentView:_getTotalGiftCfg()
	return YearCardConfig.instance:getTotalGiftCfg(self._curActId)
end

return YearCardInstallmentView
