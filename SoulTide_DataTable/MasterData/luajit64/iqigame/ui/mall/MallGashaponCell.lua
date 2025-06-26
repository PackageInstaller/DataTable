-- chunkname: @IQIGame\\UI\\Mall\\MallGashaponCell.lua

local MallGashaponCell = {}

function MallGashaponCell.New(go)
	local o = Clone(MallGashaponCell)

	o:Initialize(go)

	return o
end

function MallGashaponCell:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfDiscount = self.goDiscount:GetComponent("Text")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfTag1 = self.goTagText1:GetComponent("Text")
	self.tfTag2 = self.goTagText2:GetComponent("Text")
	self.tfTag3 = self.goTagText3:GetComponent("Text")
	self.tfTime = self.goTime:GetComponent("Text")
	self.btnBuy = self.goBtnBuy:GetComponent("Button")
	self.btnBatchBuy = self.goBtnBatchBuy:GetComponent("Button")

	function self.onClickBtnBuyDelegate()
		self:OnClickBtnBuy()
	end

	function self.onClickBtnBatchBuyDelegate()
		self:OnClickBtnBatchBuy()
	end

	function self.onAttChangeDelegate(key, value)
		self:OnAttChange(key, value)
	end

	self.icon = self.goIcon:GetComponent("Image")
	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
	self.goBtnBuy.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("gashaponCellBtnBuyTxt")
	self.goBtnBatchBuy.transform:Find("Text"):GetComponent("Text").text = MallUIApi:GetString("gashaponCellBtnBatchBuyTxt")
	self.goDesc:GetComponent("Text").text = MallUIApi:GetString("gashaponCellDesc")
end

function MallGashaponCell:Refresh(cfgMallData)
	self.cfgMallData = cfgMallData

	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		self.timer = 0
	else
		self.timer = -1
	end

	self.isSellOut = self.cfgMallData.LimitTimes ~= 0 and MallModule.GetResidueBuyTimes(self.cfgMallData.Id) == 0
	self.tfName.text = MallUIApi:GetString("goItemName", self.cfgMallData.Name)

	self:RefreshMoneyNum()
	self:RefreshAboutTime()

	if self.cfgMallData.Discount ~= 0 then
		self.tfDiscount.text = MallUIApi:GetString("goDiscount", self.cfgMallData.Discount)
	end

	if self.cfgMallData.Tag ~= 0 then
		local tfTag = self.cfgMallData.Tag == 1 and self.tfTag1 or self.cfgMallData.Tag == 2 and self.tfTag2 or self.cfgMallData.Tag == 3 and self.tfTag3

		if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, self.cfgMallData.Price, self.cfgMallData.Discount)
		elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, self.cfgMallData.PayPoint, self.cfgMallData.Discount)
		elseif self.cfgMallData.SellType == Constant.Mall_SellType.RMB then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, CfgPayTable[self.cfgMallData.PayMoney].Amount, self.cfgMallData.Discount)
		end
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.cfgMallData.BG), self.icon)
	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.RMB)

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMallData.Price[1]].Icon), self.imgMoney)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoney)
	end

	self.goDiscount.transform.parent.gameObject:SetActive(self.cfgMallData.Discount ~= 0)
	self.goTag1:SetActive(self.cfgMallData.Tag == 1)
	self.goTag2:SetActive(self.cfgMallData.Tag == 2)
	self.goTag3:SetActive(self.cfgMallData.Tag == 3)
	self:OnAddListener()
end

function MallGashaponCell:OnUpdate(elapseTime, realElapseTime)
	if self.timer == -1 then
		return
	end

	self.timer = self.timer + elapseTime

	if self.timer >= 1 then
		self.timer = 0

		self:RefreshAboutTime()
	end
end

function MallGashaponCell:OnHide()
	self:OnRemoveListener()

	self.timer = -1
end

function MallGashaponCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallGashaponCell:OnAddListener()
	self:OnRemoveListener()
	self.btnBuy.onClick:AddListener(self.onClickBtnBuyDelegate)
	self.btnBatchBuy.onClick:AddListener(self.onClickBtnBatchBuyDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallGashaponCell:OnRemoveListener()
	self.btnBuy.onClick:RemoveListener(self.onClickBtnBuyDelegate)
	self.btnBatchBuy.onClick:RemoveListener(self.onClickBtnBatchBuyDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallGashaponCell:OnAttChange(key, value)
	if key == Constant.ItemID.MONEY or key == Constant.ItemID.TREASURE then
		self:RefreshMoneyNum()
	end
end

function MallGashaponCell:OnClickBtnBuy()
	if self:CheckCanBuy(1) then
		MallModule.BuyGoods(self.cfgMallData.Id, 1)
	end
end

function MallGashaponCell:OnClickBtnBatchBuy()
	if self:CheckCanBuy(10) then
		MallModule.BuyGoods(self.cfgMallData.Id, 10)
	end
end

function MallGashaponCell:RefreshAboutTime()
	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		self.tfTime.text = MallUIApi:GetString("goTime", cfgDateTimeToTimeStamp(self.cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) - math.floor(PlayerModule.GetServerTime()))
	end

	self.goTime.transform.parent.gameObject:SetActive(self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP)
end

function MallGashaponCell:RefreshMoneyNum()
	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", self.cfgMallData.Price[2], WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]), self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", self.cfgMallData.PayPoint, PlayerModule.PlayerInfo.baseInfo.payPoint, self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.RMB then
		local cost = CfgPayTable[self.cfgMallData.PayMoney].Amount

		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", cost, 0, true, self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	end
end

function MallGashaponCell:CheckCanBuy(buyNum)
	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		if cfgDateTimeToTimeStamp(self.cfgMallData.TimeLimitOpen, PlayerModule.TimeZone) > math.floor(PlayerModule.GetServerTime()) then
			NoticeModule.ShowNotice(21040055)

			return false
		end

		if cfgDateTimeToTimeStamp(self.cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) < math.floor(PlayerModule.GetServerTime()) then
			NoticeModule.ShowNotice(21040055)

			return false
		end
	end

	if self.cfgMallData.ConditionId ~= 0 and not ConditionModule.Check(self.cfgMallData.ConditionId) then
		NoticeModule.ShowNotice(21040055)

		return false
	end

	local isSellOut = self.cfgMallData.LimitTimes ~= 0 and MallModule.GetResidueBuyTimes(self.cfgMallData.Id) == 0

	if isSellOut then
		NoticeModule.ShowNotice(21040020)

		return false
	end

	if self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		if PlayerModule.PlayerInfo.baseInfo.payPoint < self.cfgMallData.PayPoint * buyNum then
			NoticeModule.MoneyDeficitTip(2, self.cfgMallData.PayPoint * buyNum - PlayerModule.PlayerInfo.baseInfo.payPoint)

			return false
		end
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.Item and self.cfgMallData.Price[2] * buyNum > WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]) then
		if self.cfgMallData.Price[1] == Constant.ItemID.TREASURE then
			NoticeModule.MoneyDeficitTip(1, self.cfgMallData.Price[2] * buyNum - WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]))
		else
			local costCfgMallData

			for i, v in pairsCfg(CfgMallTable) do
				if #v.Item == 1 and v.Item[1] == self.cfgMallData.Price[1] then
					if v.LimitTimes ~= 0 then
						if MallModule.GetResidueBuyTimes(v.Id) ~= 0 then
							costCfgMallData = v
						end
					else
						costCfgMallData = v

						break
					end
				end
			end

			if costCfgMallData ~= nil then
				UIModule.Open(Constant.UIControllerName.BuyPanelUI, Constant.UILayer.UI, {
					type = 1,
					mallCid = costCfgMallData.Id,
					num = self.cfgMallData.Price[2] * buyNum - WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1])
				})
			end
		end

		return false
	end

	return true
end

function MallGashaponCell:OnBuyGoodsSuccess(id)
	self:Refresh(self.cfgMallData)
end

return MallGashaponCell
