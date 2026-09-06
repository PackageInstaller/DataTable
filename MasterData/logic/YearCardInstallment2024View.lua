-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcard/view/yearcard2024/main/YearCardInstallment2024View.lua

module("logic.extensions.yearcard.view.yearcard2024.main.YearCardInstallment2024View", package.seeall)

local YearCardInstallment2024View = class("YearCardInstallment2024View", ViewComponent)

function YearCardInstallment2024View:ctor()
	YearCardInstallment2024View.super.ctor(self)
end

function YearCardInstallment2024View:buildUI()
	YearCardInstallment2024View.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._slider = self:getSlider("progress/Slider")
	self._txtProgress = self:getTxt("progress/Text")
	self._cellList = {}
	self._cellGo = self:getGo("cellList/cell")
	self._cellListGo = self:getGo("cellList")
	self._singleLine = self:getGo("cellList"):GetComponent(ComponentType.UILayoutSingleLine)
end

function YearCardInstallment2024View:bindEvents()
	YearCardInstallment2024View.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function YearCardInstallment2024View:unbindEvents()
	YearCardInstallment2024View.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for k, v in pairs(self._cellList) do
		GameUtil.rmClickHandler(v.btn)
	end
end

function YearCardInstallment2024View:onEnter()
	YearCardInstallment2024View.super.onEnter(self)

	self._curActId = YearCardModel.instance:getCurAnnuityId()
	self._giftCfgs = self:_getGiftCfgs()

	GlobalDispatcher:addListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)

	self._totalGiftCfg = self:_getTotalGiftCfg()

	self:_refreshView()
end

function YearCardInstallment2024View:onExit()
	YearCardInstallment2024View.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.AnnuityInfoChange, self._refreshView, self)
end

function YearCardInstallment2024View:_onClickBuyGift(id)
	YearCardController.instance:payGiftId(self._curActId, id)
end

function YearCardInstallment2024View:_refreshView()
	self:_buildCells()

	self._actInfo = YearCardModel.instance:getAnnuityInfo(self._curActId)

	for i = 1, #self._giftCfgs do
		local cell = self._cellList[i]

		cell.txtTip.text = langPara("限购次数 %s/%s", checkint(self._actInfo.annuityGifts[i]), cell.cfg.timesLimit)
		cell.txtPrice.text = langPara("%s元", PayConfig.instance:getPayMoneyYuan(cell.cfg.payGoodsId))
		cell.txtNub.text = "x" .. self._giftCfgs[i].progressGain

		cell.imgChange:SetState(i - 1)
	end

	local curMoney = self._actInfo.money / 100
	local totalProgress = self._totalGiftCfg.progressGain / 100

	self._slider:SetValue(curMoney / checknumber(totalProgress))

	self._txtProgress.text = langPara("年费进度：%s/%s", curMoney, totalProgress)
end

function YearCardInstallment2024View:_getGiftCfgs()
	local list = {}
	local cfgs = YearCardConfig.instance:getNewGiftCfg(self._curActId)

	for i, v in ipairs(cfgs) do
		if v.isInstallment then
			table.insert(list, v)
		end
	end

	return list
end

function YearCardInstallment2024View:_getTotalGiftCfg()
	return YearCardConfig.instance:getNewTotalGiftCfg(self._curActId)
end

function YearCardInstallment2024View:_buildCells()
	goutil.setActive(self._cellGo, false)

	local cfgs = self:_getGiftCfgs()

	for i = 1, #cfgs do
		local cell = self._cellList[i]

		if not cell then
			cell = {
				go = goutil.cloneAndSetParent(self._cellGo, self._cellListGo.transform)
			}

			local btn = Framework.ButtonAdapter.GetFrom(cell.go, "btnBuy")

			cell.btn = btn
			cell.txtTip = goutil.findChildTextComponent(cell.go, "txtTip")
			cell.txtPrice = goutil.findChildTextComponent(cell.btn, "txt")
			cell.txtNub = goutil.findChildTextComponent(cell.go, "txtNub")
			cell.cfg = cfgs[i]
			cell.imgChange = goutil.findChild(cell.go, "img"):GetComponent(ComponentType.UIImageSpriteChange)

			GameUtil.addClickHandler(cell.btn, GameUtil.handler(self._onClickBuyGift, self, i))
			goutil.setActive(cell.go, true)
			btn:SetClickInterval(0.3)

			self._cellList[i] = cell
		end
	end

	self._singleLine:Layout()
end

return YearCardInstallment2024View
