-- chunkname: @IQIGame\\UI\\Mall\\MallCellTwo.lua

local MallCellTwo = {
	cellPool = {}
}

function MallCellTwo.New(go)
	local o = Clone(MallCellTwo)

	o:Initialize(go)

	return o
end

function MallCellTwo:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)
	self.goCell:SetActive(false)

	self.tfName = self.goName:GetComponent("Text")
	self.tfDiscount = self.goDiscount:GetComponent("Text")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfTag1 = self.goTagText1:GetComponent("Text")
	self.tfTag2 = self.goTagText2:GetComponent("Text")
	self.tfTag3 = self.goTagText3:GetComponent("Text")
	self.tfBuyTimes = self.goBuyTimes:GetComponent("Text")
	self.tfTime = self.goTime:GetComponent("Text")
	self.tfCondition = self.goConditionBlock.transform:Find("Text"):GetComponent("Text")
	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
	self.icon = self.goIcon:GetComponent("Image")
	self.goClickTip:GetComponent("Text").text = MallUIApi:GetString("goClickTip")

	function self.onAttChangeDelegate(key, value)
		self:OnAttChange(key, value)
	end

	self.goMoneyUnit:GetComponent("Text").text = MiscApi:GetString("moneySign")
end

function MallCellTwo:Refresh(cfgMallData)
	self.cfgMallData = cfgMallData

	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.STAY then
		self.timer = -1
	else
		self.timer = 0
	end

	self.tfName.text = MallUIApi:GetString("goItemName", self.cfgMallData.Name)
	self.tfBuyTimes.text = MallUIApi:GetString("goBuyTimes", self.cfgMallData.LimitType, MallModule.GetResidueBuyTimes(self.cfgMallData.Id), self.cfgMallData.LimitTimes)
	self.isSellOut = self.cfgMallData.LimitTimes ~= 0 and MallModule.GetResidueBuyTimes(self.cfgMallData.Id) == 0

	self:RefreshMoneyNum()
	self:RefreshAboutTime()
	self:RefreshItemBlock()
	self:RefreshCondition()

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

	if self.cfgMallData.BG ~= nil and self.cfgMallData.BG ~= "" then
		AssetUtil.LoadImage(self, UIGlobalApi.GetAssetPath(self.cfgMallData.BG), self.icon)
	end

	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.RMB and self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)
	self.goMoneyUnit:SetActive(self.cfgMallData.SellType == Constant.Mall_SellType.RMB)

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMallData.Price[1]].Icon), self.imgMoney)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoney)
	end

	self.goDiscount.transform.parent.gameObject:SetActive(self.cfgMallData.Discount ~= 0)
	self.goTag1:SetActive(self.cfgMallData.Tag == 1)
	self.goTag2:SetActive(self.cfgMallData.Tag == 2)
	self.goTag3:SetActive(self.cfgMallData.Tag == 3)

	for i = 1, 4 do
		if self["goFashionTag" .. i] then
			self["goFashionTag" .. i]:SetActive(self.cfgMallData.DressTag == i)
		end
	end

	self:OnAddListeners()
end

function MallCellTwo:OnUpdate(elapseTime, realElapseTime)
	if self.timer == -1 then
		return
	end

	self.timer = self.timer + elapseTime

	if self.timer >= 1 then
		self.timer = 0

		self:RefreshAboutTime()
	end
end

function MallCellTwo:OnHide()
	self:OnRemoveListener()

	self.timer = -1
end

function MallCellTwo:OnDestroy()
	for i, v in pairs(self.cellPool) do
		v:Dispose()
	end

	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallCellTwo:OnAddListeners()
	self:OnRemoveListener()
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallCellTwo:OnRemoveListener()
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallCellTwo:OnAttChange(key, value)
	if key == Constant.ItemID.MONEY or key == Constant.ItemID.TREASURE then
		self:RefreshMoneyNum()
	end
end

function MallCellTwo:RefreshAboutTime()
	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		self.tfTime.text = MallUIApi:GetString("goTime", cfgDateTimeToTimeStamp(self.cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) - math.floor(PlayerModule.GetServerTime()))
	elseif self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.LIMIT_SELL_TIME then
		local now = PlayerModule.GetServerTime()
		local startTime = PlayerModule.PlayerInfo.mallStartSellTime[self.cfgMallData.Id]

		if startTime then
			local cd = startTime + self.cfgMallData.SalesTime - now

			if cd >= 0 then
				if cd >= 172800 then
					self.tfTime.text = MallUIApi:GetString("TimeCDText", getTimeDurationText(cd, 1))
				else
					self.tfTime.text = MallUIApi:GetString("TimeCDText", GetFormatTime(cd))
				end
			end
		end
	end

	self.goTime.transform.parent.gameObject:SetActive(self.cfgMallData.TimeLimitType > Constant.MallTimeLimitType.STAY)
end

function MallCellTwo:RefreshItemBlock()
	self.goItemBlock:SetActive(self.cfgMallData.GoodsType == 1)

	if self.cfgMallData.GoodsType == 0 then
		return
	end

	for i, v in ipairs(self.cellPool) do
		v.ViewGo:SetActive(i <= #self.cfgMallData.Item)
	end

	for i, v in ipairs(self.cfgMallData.Item) do
		if i > 3 then
			return
		end

		local cell = self.cellPool[i]

		if cell == nil then
			local goCellClone = UnityEngine.Object.Instantiate(self.goCell)

			goCellClone.transform:SetParent(self.goCell.transform.parent, false)

			cell = ItemCell.PackageOrReuseView(self, goCellClone.transform:Find("CommonSlotUI").gameObject, true, true)
			self.cellPool[i] = cell
		end

		cell.ViewGo.transform.parent.gameObject:SetActive(true)
		cell:SetItemByCID(v, self.cfgMallData.ItemNum[i])
	end
end

function MallCellTwo:RefreshCondition()
	self.isConditionOk = true

	if self.cfgMallData.ConditionId > 0 then
		local canBuy, limitResult = ConditionModule.Check(self.cfgMallData.ConditionId)

		if canBuy == false then
			self.goConditionBlock:SetActive(true)

			self.tfCondition.text = MallUIApi:GetString("goCondition", CfgConditionTable[self.cfgMallData.ConditionId].Name, self.isSellOut)
			self.isConditionOk = false

			return
		end
	end

	self.goConditionBlock:SetActive(false)
end

function MallCellTwo:RefreshMoneyNum()
	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", self.cfgMallData.Price[2], WarehouseModule.GetItemNumByCfgID(self.cfgMallData.Price[1]), self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", self.cfgMallData.PayPoint, PlayerModule.PlayerInfo.baseInfo.payPoint, self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.RMB then
		local cost = CfgPayTable[self.cfgMallData.PayMoney].Amount

		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", cost, 0, true, self.cfgMallData.SellType == Constant.Mall_SellType.Free)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.Free then
		self.tfMoneyNum.text = MallUIApi:GetString("goMoneyCost", 0, 0, false, true)
	end
end

function MallCellTwo:OnBuyGoodsSuccess(id)
	self:Refresh(self.cfgMallData)
end

return MallCellTwo
