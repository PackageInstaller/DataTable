-- chunkname: @IQIGame\\UI\\Main\\PurchaseTipView.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnRender()
		self:OnBtnRender()
	end

	function self.delegatePurchaseTipEvent(data)
		self:UpdateView(data)
	end

	self.timer = Timer.New(function()
		self:ShowCD()
	end, 1, -1)

	self.View:SetActive(false)
	self:AddListener()
end

function m:AddListener()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnRender:GetComponent("Button").onClick:AddListener(self.delegateBtnRender)
	EventDispatcher.AddEventListener(EventID.PurchaseTipEvent, self.delegatePurchaseTipEvent)
end

function m:RemoveListener()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnRender:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRender)
	EventDispatcher.RemoveEventListener(EventID.PurchaseTipEvent, self.delegatePurchaseTipEvent)
end

function m:UpdateView(data)
	if data == nil then
		self.View:SetActive(false)

		return
	end

	if self.showMsgData and self.showMsgData.Id == data.Id then
		return
	end

	self.showMsgData = data

	if self.showMsgData then
		self.View:SetActive(true)

		if self.showMsgData.Type == 3 then
			self.timer:Start()
			self:ShowCD()
		else
			self.timer:Stop()
			UGUIUtil.SetText(self.TextName, self.showMsgData.Describe)
		end

		local path = UIGlobalApi.GetImagePath(self.showMsgData.ImageIcon)

		AssetUtil.LoadImage(self, path, self.ImageIcon:GetComponent("Image"))
	end
end

function m:ShowCD()
	local now = PlayerModule.GetServerTime()
	local startTime = PlayerModule.PlayerInfo.mallStartSellTime[self.showMsgData.MallId]

	if startTime then
		local cd = startTime + CfgMallTable[self.showMsgData.MallId].SalesTime - now

		if cd > 0 then
			if cd >= 172800 then
				UGUIUtil.SetText(self.TextName, MainUIApi:GetString("PurchaseTipCDText", self.showMsgData.Describe, getTimeDurationText(cd, 1)))
			else
				UGUIUtil.SetText(self.TextName, MainUIApi:GetString("PurchaseTipCDText", self.showMsgData.Describe, GetFormatTime(cd)))
			end
		end
	end
end

function m:OnBtnClose()
	PurchaseTipModule.isClosePurchaseTip = true

	self:Close()
end

function m:OnBtnRender()
	if self.showMsgData then
		JumpModule.Jump(self.showMsgData.FunctionId, self.showMsgData.MallId)
	end
end

function m:Open()
	if PurchaseTipModule.isClosePurchaseTip == false then
		self.View:SetActive(true)

		local purchaseTipData = PurchaseTipModule.CheckPurchaseTipMsg()

		self:UpdateView(purchaseTipData)
	else
		self:Close()
	end
end

function m:Close()
	self.View:SetActive(false)
	self.timer:Stop()
end

function m:Dispose()
	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	self.timer:Stop()

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
