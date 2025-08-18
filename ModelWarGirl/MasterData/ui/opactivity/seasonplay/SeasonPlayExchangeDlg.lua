-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlayExchangeDlg.lua

local ResItemConvertLimit = require("ClientData/ResItemConvertLimit")
local ResShopExchg = require("ClientData/ResShopExchg")
local SeasonPlayExchangeDlg = Class("SeasonPlayExchangeDlg", UIControls.Window)

function SeasonPlayExchangeDlg:ctor(...)
	self:initUI()
end

function SeasonPlayExchangeDlg:initUI(...)
	self.imgSkinPortraitL = UIControls.Image(self, "BgPanel/ImgSkinPortraitL")
	self.imgSkinPortraitR = UIControls.Image(self, "BgPanel/ImgSkinPortraitR")
	self.txtNowHaveNum = UIControls.Label(self, "BgPanel/CurrencyPanel/Text")
	self.txtPiecesNum = UIControls.Label(self, "BgPanel/GridNub/Nubtext/Text")
	self.btnMax = UIControls.Button(self, "BgPanel/GridNub/BtnMax")

	self.btnMax:addEventClick(self.onBtnMaxClick)

	self.btnMinus = UIControls.Button(self, "BgPanel/GridNub/BtnMinus")

	self.btnMinus:addEventClick(self.onBtnMinusClick)

	self.btnAdd = UIControls.Button(self, "BgPanel/GridNub/BtnAdd")

	self.btnAdd:addEventClick(self.onBtnAddClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.iconCurrency = UIControls.Image(self, "BgPanel/CurrencyPanel/IconCurrency")
	self.txtHaveCoinNum = UIControls.Label(self, "BgPanel/CurrencyPanel/Text")
	self.iconCostCurrency = UIControls.Image(self, "BgPanel/CostPanel/IconCurrency")
	self.txtNowCostNum = UIControls.Label(self, "BgPanel/CostPanel/TextNum")
	self.nubtext = UIControls.Button(self, "BgPanel/GridNub/Nubtext")

	self.nubtext:addEventClick(self.onNubtextClick)

	self.currencyPanel = UIControls.Button(self, "BgPanel/CurrencyPanel")

	self.currencyPanel:addEventClick(self.onCurrencyPanelClick)

	self.pieceCells = {}
	self.piecceData = {}

	for index = 1, 4 do
		local path = "BgPanel/PiecePanel/BtnPiece" .. index
		local newcell = {}

		newcell.btn = UIControls.Button(self, path)
		newcell.btn.index = index

		newcell.btn:addEventClick(self.onBtnPieceClick)

		newcell.img = UIControls.Image(self, path .. "/ImgPiece")
		newcell.txtNum = UIControls.Label(self, path .. "/TextNum")
		newcell.maxPanel = UIControls.Image(self, path .. "/MaxPanel")
		self.pieceCells[index] = newcell
	end

	self.keyboard = UIControls.NumKeyboard(self, "BgPanel/KeyboardPanel")
	self._slot4NumInput = Slot(self.onNumInput, self)
	self.btnStore = UIControls.Button(self, "BgPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)
end

function SeasonPlayExchangeDlg:onNumInput(value)
	self.nowExchange = value

	self:refreshState()
end

function SeasonPlayExchangeDlg:setData(actObject, index)
	if not self.index then
		self.index = index or 1
	end

	self.actObject = actObject or self.actObject
	self.actData = self.actObject.actData

	self.imgSkinPortraitR:setVisible(self.index == 2)
	self.imgSkinPortraitL:setVisible(self.index == 1)

	if self.actData then
		local resData = self.actData:getResDetailData()

		self.resDetailData = resData

		if resData and resData.replace_icon_path then
			local path = resData.replace_icon_path .. "/SeasonPlaySkinAtlas"

			self.imgSkinPortraitL:setImage(path, "BgRole1A")
			self.imgSkinPortraitR:setImage(path, "BgRole1B")
		end
	end

	self.relateActObject = self.actData:getRelatedActivityShopActObj()

	if self.relateActObject then
		self:initShowData()
	end
end

function SeasonPlayExchangeDlg:refreshUI(...)
	self:initShowData()

	local commonBonusDlg = UIManager.tryGetUI("commonBonusDlg")

	if commonBonusDlg and commonBonusDlg:getVisible() then
		self:setFlyShowData(commonBonusDlg)
	end
end

function SeasonPlayExchangeDlg:setFlyShowData(ui)
	if ui and ui.setSpecialCustomizeFlyConfig then
		for index = 1, 4 do
			if self.piecceData[index] and self.piecceData[index].ID and self.piecceData[index].btn then
				ui:setSpecialCustomizeFlyConfig(self.piecceData[index].ID, self.piecceData[index].btn)
			end
		end
	end
end

function SeasonPlayExchangeDlg:initShowData(...)
	local mapVis = {}
	local resData = self.actData:getResShopExchgData()

	if resData and resData[self.index] then
		for index, data in ipairs(resData[self.index].use or {}) do
			local newData = {}

			newData.ID = data.ID
			newData.discount = data.discount

			table.insert(self.piecceData, newData)

			mapVis[data.ID] = newData
		end
	end

	self.relateActData = self.relateActObject.actData

	if self.relateActData then
		for id, data in pairs(self.relateActData.clientData) do
			if ResShopExchg[id] and ResShopExchg[id].exchg then
				local resD = ResShopExchg[id].exchg

				if mapVis[resD[1].key] then
					if not self.coninItemId then
						self.coninItemId = ResShopExchg[id].use[1].ID
					end

					mapVis[resD[1].key].rate = ResShopExchg[id].use[1].discount
					mapVis[resD[1].key].exchgid = id
				end
			end
		end

		if self.coninItemId then
			local iconData = BaseObject.getItemIconPath(self.coninItemId)

			self.iconCurrency:setImage(iconData[1], iconData[2])
			self.iconCostCurrency:setImage(iconData[1], iconData[2])

			self.nowHaveCoinNum = CurAvatar:getItemNumById(self.coninItemId)

			self.txtHaveCoinNum:setText(self.nowHaveCoinNum)
		end
	end

	for index = 1, 4 do
		if self.piecceData[index] then
			self.pieceCells[index].btn:setVisible(true)

			self.pieceCells[index].btn.data = self.piecceData[index]

			local itemId = self.piecceData[index].ID
			local showData = CurAvatar:getItemSeasonDrawShowData(itemId)

			if showData and showData.icon_path then
				self.pieceCells[index].img:setImage(showData.icon_path, showData.icon_name)
			end

			local haveNum = CurAvatar:getItemNumById(itemId)

			self.pieceCells[index].txtNum:setText(utils.format("%1s/%2s", haveNum, self.piecceData[index].discount))
			self.pieceCells[index].maxPanel:setVisible(haveNum == self.piecceData[index].discount)

			self.piecceData[index].btn = self.pieceCells[index].btn
		else
			self.pieceCells[index].btn:setVisible(false)
		end
	end

	self:refreshState()
end

function SeasonPlayExchangeDlg:refreshState(...)
	if not self.nowSelectIndex then
		self.nowSelectIndex = 1
	end

	for index = 1, 4 do
		self.pieceCells[index].btn:setEnable(index ~= self.nowSelectIndex)
	end

	self.nowSelectRate = self.piecceData[self.nowSelectIndex].rate or 1

	local num1 = math.floor(self.nowHaveCoinNum / self.nowSelectRate)
	local numHaveSelectNum = CurAvatar:getItemNumById(self.piecceData[self.nowSelectIndex].ID)

	self.remainExcNum = self.piecceData[self.nowSelectIndex].discount - numHaveSelectNum

	if not self.nowExchange then
		if self.remainExcNum > 0 then
			self.nowExchange = 1
		else
			self.nowExchange = 0
		end
	end

	self.nowExchange = math.min(self.nowExchange, self.remainExcNum)

	self.txtPiecesNum:setText(self.nowExchange)

	self.maxCanExcNum = math.max(math.min(num1, self.remainExcNum), 0)

	self.txtNowCostNum:setText(self.nowExchange * self.nowSelectRate)

	if self.nowHaveCoinNum >= self.nowExchange * self.nowSelectRate then
		self.btnConfirm:setEnable(self.nowExchange ~= 0)
		self.txtNowCostNum:setFontColor(ResColor.WHITE)
	else
		self.txtNowCostNum:setFontColor(ResColor.RED)
		self.btnConfirm:setEnable(false)
	end

	self.btnMinus:setEnable(self.nowExchange > 0)
end

function SeasonPlayExchangeDlg:onBtnMinusClick()
	self.nowExchange = self.nowExchange - 1

	self:refreshState()
end

function SeasonPlayExchangeDlg:onBtnAddClick()
	if self.nowExchange < self.remainExcNum then
		self.nowExchange = self.nowExchange + 1

		self:refreshState()
	else
		MsgManager.notice(Lang.get(110035))
	end
end

function SeasonPlayExchangeDlg:onBtnMaxClick()
	self.nowExchange = self.maxCanExcNum

	self:refreshState()
end

function SeasonPlayExchangeDlg:onBtnConfirmClick()
	self.relateActData:onBuyCB(self.piecceData[self.nowSelectIndex].exchgid, self.nowExchange)
end

function SeasonPlayExchangeDlg:onBtnPieceClick(sender)
	self.nowSelectIndex = sender.index

	self:refreshState()
end

function SeasonPlayExchangeDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SeasonPlayExchangeDlg:onNubtextClick()
	self.keyboard:setVisible(true)
	self.keyboard:show(self._slot4NumInput, self.nowExchange, self.maxCanExcNum, 0)
end

function SeasonPlayExchangeDlg:onCurrencyPanelClick()
	if self.coninItemId then
		CurAvatar:jumpToShowItem(self.coninItemId, self.mWindow)
	end
end

function SeasonPlayExchangeDlg:onBtnStoreClick()
	local jumpId = 1260

	if self.resDetailData then
		jumpId = self.resDetailData.jump_gift_id
	end

	if JumpGuideManager.checkCanJump(jumpId, true) then
		JumpGuideManager.jump(jumpId)
		self:setVisible(false)
	end
end

function SeasonPlayExchangeDlg:onClose(...)
	local ui = UIManager.tryGetUI("seasonPlaySkinPoolDlg")

	if ui and ui:getVisible() then
		ui:checkGetSkinShow()
	end

	SeasonPlayExchangeDlg.super.onClose(self)
end

return SeasonPlayExchangeDlg
