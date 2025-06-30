-- chunkname: @IQIGame\\UI\\Lottery\\LotteryPickUpItem.lua

local m = {}

function m.New(view, onClickTipBtn)
	local obj = Clone(m)

	obj:Init(view, onClickTipBtn)

	return obj
end

function m:Init(view, onClickTipBtn)
	self.View = view
	self.OnClickTipBtnCallback = onClickTipBtn

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	UGUIUtil.SetText(self.OffRightText, LotteryPickUpUIApi:GetString("ItemOffRightText"))
	UGUIUtil.SetText(self.OnRightText, LotteryPickUpUIApi:GetString("ItemOnRightText"))
	self:AddListeners()
end

function m:AddListeners()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
end

function m:RemoveListeners()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
end

function m:SetData(cfgLotteryPackUpData)
	self.CfgLotteryPackUpData = cfgLotteryPackUpData

	UGUIUtil.SetText(self.NameText, self.CfgLotteryPackUpData.Name)
	UGUIUtil.SetText(self.DescText, self.CfgLotteryPackUpData.Desc)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.CfgLotteryPackUpData.Icon), self.TypeIcon:GetComponent("Image"))
end

function m:OnClickTipBtn()
	self.OnClickTipBtnCallback(self.CfgLotteryPackUpData)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnClickTipBtnCallback = nil
	self.CfgLotteryPackUpData = nil
end

return m
