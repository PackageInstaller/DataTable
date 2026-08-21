-- chunkname: @IQIGame\\UI\\CelebrationGift\\CelebrationGiftCell.lua

local m = {}

function m.New(view, type)
	local obj = Clone(m)

	obj:Init(view, type)

	return obj
end

function m:Init(view, type)
	self.View = view
	self.type = type

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnBuy()
		self:OnBtnBuy()
	end

	function self.DelegateBtnCard()
		self:OnBtnCard()
	end

	self:AddListener()
end

function m:AddListener()
	self.goBtnBuy:GetComponent("Button").onClick:AddListener(self.DelegateBtnBuy)
	self.BtnCard:GetComponent("Button").onClick:AddListener(self.DelegateBtnCard)
end

function m:RemoveListener()
	self.goBtnBuy:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBuy)
	self.BtnCard:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnCard)
end

function m:SetData(giftBoxID, mallID)
	self.giftBoxID = giftBoxID
	self.mallID = mallID

	local cfgGiftBoxData = CfgGiftBoxTable[self.giftBoxID]

	UGUIUtil.SetTextInChildren(self.goBtnBuy, cfgGiftBoxData.GiftBoxPrice[self.type])

	local path

	if self.type == 1 then
		path = UIGlobalApi.GetImagePath(cfgGiftBoxData.GiftBoxImage1)
	elseif self.type == 2 then
		path = UIGlobalApi.GetImagePath(cfgGiftBoxData.GiftBoxImage2)
	end

	AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

	local cfgMallData = CfgMallTable[self.mallID]

	if cfgMallData.ShowConditionId ~= 0 and not ConditionModule.Check(cfgMallData.ShowConditionId) then
		self.View:SetActive(false)
	else
		self.View:SetActive(true)
	end
end

function m:OnBtnBuy()
	NoticeModule.ShowNotice(21045111, function()
		local cfgMallData = CfgMallTable[self.mallID]

		MallModule.ReqPay(cfgMallData.PayMoney)
		UIModule.Close(Constant.UIControllerName.CelebrationGiftBuyUI)
	end, nil)
end

function m:OnBtnCard()
	local cfgMallData = CfgMallTable[self.mallID]
	local cfgPayData = CfgPayTable[cfgMallData.PayMoney]
	local rewards = {}

	for i = 1, #cfgPayData.GetItems, 2 do
		local itemID = cfgPayData.GetItems[i]
		local itemNum = cfgPayData.GetItems[i + 1]
		local reward = {}

		reward.id = itemID
		reward.num = itemNum

		table.insert(rewards, reward)
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		ShowBtn = false,
		Rewards = rewards
	})
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
