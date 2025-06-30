-- chunkname: @IQIGame\\UI\\Mall\\MallCellOne.lua

local MallCellOne = {}

function MallCellOne.New(go)
	local o = Clone(MallCellOne)

	o:Initialize(go)

	return o
end

function MallCellOne:Initialize(go)
	self.View = go

	LuaCodeInterface.BindOutlet(go, self)

	self.tfName = self.goName:GetComponent("Text")
	self.tfSellNum = self.goSellNum:GetComponent("Text")
	self.tfDiscount = self.goDiscount:GetComponent("Text")
	self.tfMoneyNum = self.goMoneyNum:GetComponent("Text")
	self.tfBuyTimes = self.goBuyTimes:GetComponent("Text")
	self.tfTime = self.goTime:GetComponent("Text")
	self.tfCondition = self.goConditionBlock.transform:Find("Text"):GetComponent("Text")
	self.btnIcon = self.goBtnIcon:GetComponent("Button")

	function self.onClickBtnIconDelegate()
		self:OnClickBtnIcon()
	end

	function self.onAttChangeDelegate(key, value)
		self:OnAttChange(key, value)
	end

	self.icon = self.goIcon:GetComponent("Image")
	self.imgQualityLine = self.goQualityLine:GetComponent("Image")
	self.imgQualityNum = self.goQualityNum:GetComponent("Image")
	self.imgMoney = self.goMoneyIcon:GetComponent("Image")
end

function MallCellOne:Refresh(cfgMallData)
	self.cfgMallData = cfgMallData
	self.cfgItemData = CfgItemTable[self.cfgMallData.Item[1]]

	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		self.timer = 0
	else
		self.timer = -1
	end

	self.isSellOut = self.cfgMallData.LimitTimes ~= 0 and MallModule.GetResidueBuyTimes(self.cfgMallData.Id) == 0
	self.tfName.text = MallUIApi:GetString("goItemName", self.cfgItemData.Name)
	self.tfSellNum.text = MallUIApi:GetString("goSellNum", self.cfgMallData.ItemNum[1])
	self.tfBuyTimes.text = MallUIApi:GetString("goBuyTimes", self.cfgMallData.LimitType, MallModule.GetResidueBuyTimes(self.cfgMallData.Id), self.cfgMallData.LimitTimes)

	self:RefreshMoneyNum()
	self:RefreshAboutTime()
	self:RefreshCondition()

	if self.cfgMallData.Discount ~= 0 then
		self.tfDiscount.text = MallUIApi:GetString("goDiscount", self.cfgMallData.Discount)
	end

	if self.cfgMallData.Tag ~= 0 then
		local tfTag = self["goTagText" .. self.cfgMallData.Tag]:GetComponent("Text")

		if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, self.cfgMallData.Price, self.cfgMallData.Discount)
		elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, self.cfgMallData.PayPoint, self.cfgMallData.Discount)
		elseif self.cfgMallData.SellType == Constant.Mall_SellType.RMB then
			tfTag.text = MallUIApi:GetString("goTag", self.cfgMallData.Tag, CfgPayTable[self.cfgMallData.PayMoney].Amount, self.cfgMallData.Discount)
		end
	end

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(self.cfgItemData.Icon), self.icon)
	AssetUtil.LoadImage(self, MallUIApi:GetString("goQualityLinePath", self.cfgItemData.Quality), self.imgQualityLine)
	AssetUtil.LoadImage(self, MallUIApi:GetString("goQualityNumPath", self.cfgItemData.Quality), self.imgQualityNum)
	self.goMoneyIcon:SetActive(self.cfgMallData.SellType ~= Constant.Mall_SellType.RMB and self.cfgMallData.SellType ~= Constant.Mall_SellType.Free)

	if self.cfgMallData.SellType == Constant.Mall_SellType.Item then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[self.cfgMallData.Price[1]].Icon), self.imgMoney)
	elseif self.cfgMallData.SellType == Constant.Mall_SellType.PayPoint then
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW].Icon), self.imgMoney)
	end

	local showTimes = MallModule.GetResidueBuyTimes(self.cfgMallData.Id)
	local isShow = self.cfgItemData.LimitType == Constant.Mall_LimitType.Day

	if self.goShowTimes then
		self.goShowTimes:SetActive(isShow)
	end

	if self.textNum then
		UGUIUtil.SetText(self.textNum, showTimes)
	end

	self.goDiscount.transform.parent.gameObject:SetActive(self.cfgMallData.Discount ~= 0)
	self.goTag1:SetActive(self.cfgMallData.Tag == 1)
	self.goTag2:SetActive(self.cfgMallData.Tag == 2)
	self.goTag3:SetActive(self.cfgMallData.Tag == 3)
	self.goTag4:SetActive(self.cfgMallData.Tag == 4)
	self:OnAddListener()
end

function MallCellOne:OnUpdate(elapseTime, realElapseTime)
	if self.timer == -1 then
		return
	end

	self.timer = self.timer + elapseTime

	if self.timer >= 1 then
		self.timer = 0

		self:RefreshAboutTime()
	end
end

function MallCellOne:OnHide()
	self:OnRemoveListener()

	self.timer = -1
end

function MallCellOne:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function MallCellOne:OnAddListener()
	self:OnRemoveListener()
	self.btnIcon.onClick:AddListener(self.onClickBtnIconDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallCellOne:OnRemoveListener()
	self.btnIcon.onClick:RemoveListener(self.onClickBtnIconDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerNumAttrsChange, self.onAttChangeDelegate)
end

function MallCellOne:OnClickBtnIcon()
	return
end

function MallCellOne:OnAttChange(key, value)
	if key == Constant.ItemID.MONEY or key == Constant.ItemID.TREASURE then
		self:RefreshMoneyNum()
	end
end

function MallCellOne:RefreshAboutTime()
	if self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP then
		self.tfTime.text = MallUIApi:GetString("goTime", cfgDateTimeToTimeStamp(self.cfgMallData.TimeLimitEnd, PlayerModule.TimeZone) - math.floor(PlayerModule.GetServerTime()))
	end

	self.goTime.transform.parent.gameObject:SetActive(self.cfgMallData.TimeLimitType == Constant.MallTimeLimitType.TIME_STAMP)
end

function MallCellOne:RefreshCondition()
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

function MallCellOne:RefreshMoneyNum()
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

function MallCellOne:OnBuyGoodsSuccess(id)
	self:Refresh(self.cfgMallData)
end

return MallCellOne
