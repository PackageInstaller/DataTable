-- chunkname: @IQIGame\\UI\\CelebrationGift\\CelebrationGiftView.lua

local m = {
	celebrationGiftRewardCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local CelebrationGiftRewardCell = require("IQIGame.UI.CelebrationGift.CelebrationGiftRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateBtnBuy()
		self:OnBtnBuy()
	end

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)

	self.RewardMould:SetActive(false)

	self.celebrationGiftRewardPool = UIObjectPool.New(5, function()
		local cellObj = UnityEngine.Object.Instantiate(self.RewardMould)

		return CelebrationGiftRewardCell.New(cellObj)
	end, function(cell)
		cell:Dispose()
	end)

	self:AddListener()
end

function m:AddListener()
	self.BtnBuy:GetComponent("Button").onClick:AddListener(self.DelegateBtnBuy)
end

function m:RemoveListener()
	self.BtnBuy:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnBuy)
end

function m:OnBtnBuy()
	UIModule.Open(Constant.UIControllerName.CelebrationGiftBuyUI, Constant.UILayer.UI, {
		Cid = self.cid
	})
end

function m:UpdateView()
	local cfgMallData = CfgMallTable[CfgGiftBoxTable[self.cid].GiftBoxMall[1]]
	local cfgPayData = CfgPayTable[cfgMallData.PayMoney]

	for i, v in pairs(self.celebrationGiftRewardCells) do
		v.View.transform:SetParent(self.View:GetComponentInParent(typeof(UIController)).transform, false)
		v.View:SetActive(false)
		self.celebrationGiftRewardPool:Release(v)
	end

	self.celebrationGiftRewardCells = {}

	for i = 1, #cfgPayData.GetItems, 2 do
		local itemID = cfgPayData.GetItems[i]
		local itemNum = cfgPayData.GetItems[i + 1]
		local cell = self.celebrationGiftRewardPool:Obtain()

		cell:SetData(itemID, itemNum)
		cell.View.transform:SetParent(self.ItemsNode.transform, false)
		cell.View:SetActive(true)
		table.insert(self.celebrationGiftRewardCells, cell)
	end

	self.timer:Start()
	self:ShowCD()
end

function m:ShowCD()
	local now = PlayerModule.GetServerTime()
	local startTime = PlayerModule.PlayerInfo.mallStartSellTime[CfgGiftBoxTable[self.cid].GiftBoxMall[1]]

	if startTime then
		local cd = startTime + CfgMallTable[CfgGiftBoxTable[self.cid].GiftBoxMall[1]].SalesTime - now

		if cd > 0 then
			if cd >= 172800 then
				UGUIUtil.SetText(self.TextTime, CelebrationGiftUIApi:GetString("TextTime", getTimeDurationText(cd, 1)))
			else
				UGUIUtil.SetText(self.TextTime, CelebrationGiftUIApi:GetString("TextTime", GetFormatTime(cd)))
			end
		end
	end
end

function m:SetData(cid)
	self.cid = cid
end

function m:Open()
	self.View:SetActive(true)
	self:UpdateView()
end

function m:Close()
	self.View:SetActive(false)
	self.timer:Stop()
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	for i, v in pairs(self.celebrationGiftRewardCells) do
		self.celebrationGiftRewardPool:Release(v)
	end

	self.celebrationGiftRewardCells = {}

	self.celebrationGiftRewardPool:Dispose()
	self.timer:Stop()

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
