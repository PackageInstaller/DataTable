-- chunkname: @IQIGame\\UI\\Lottery\\LotteryDrawBtnController.lua

local m = {
	NeedUpdateCD = false,
	UpdateElapsedTime = 0
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickDrawBtn()
		self:OnClickDrawBtn()
	end

	if self.FreeLabelText ~= nil then
		UGUIUtil.SetText(self.FreeLabelText, LotteryUIApi:GetString("FreeText"))
	end
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.NeedUpdateCD then
		self.UpdateElapsedTime = self.UpdateElapsedTime + realElapseSeconds

		if self.UpdateElapsedTime > 0.5 then
			self:UpdateFreeDrawShow(self.CfgLotteryData)
		end
	end
end

function m:GetCostItem(cfgLotteryData)
	if cfgLotteryData.payPoint > 0 then
		return Constant.ItemID.ID_PAYPOINT_SHOW, cfgLotteryData.payPoint, true
	end

	return cfgLotteryData.ItemCost[1], cfgLotteryData.ItemCost[2], false
end

function m:SetData(cfgLotteryData, cfgLotteryShowData, hideIfCannotAfford)
	self.View:SetActive(cfgLotteryData ~= nil)

	if cfgLotteryData == nil then
		return
	end

	self.CfgLotteryData = cfgLotteryData
	self.CfgLotteryShowData = cfgLotteryShowData

	local costItemCid, costItemNum, isPayPoint = self:GetCostItem(self.CfgLotteryData)
	local cfgItemData = CfgItemTable[costItemCid]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.CostItemNumText, LotteryUIApi:GetString("CostItemNumText", costItemNum))

	local prayCount = 0

	if self.CfgLotteryData.Type == Constant.Lottery.PoolTypeTen then
		for i = 1, #self.CfgLotteryData.PackId do
			if #self.CfgLotteryData.PackId[i] > 0 then
				prayCount = prayCount + 1
			end
		end
	else
		prayCount = 1
	end

	UGUIUtil.SetText(self.BtnLabel, LotteryUIApi:GetString("DrawBtnText", self.CfgLotteryData.Type, prayCount))
	self:UpdateFreeDrawShow(self.CfgLotteryData)

	if hideIfCannotAfford then
		local hasCostItemNum

		if isPayPoint then
			hasCostItemNum = PlayerModule.PlayerInfo.baseInfo.payPoint
		else
			hasCostItemNum = WarehouseModule.GetItemNumByCfgID(costItemCid)
		end

		self.View:SetActive(costItemNum <= hasCostItemNum)
	end

	if self.InsureTip ~= nil then
		local lotteryShowPOD = LotteryModule.GetLotteryShowPOD(self.CfgLotteryShowData.Id)

		self.InsureTip:SetActive(lotteryShowPOD.leftInsureTime ~= -1 and prayCount >= lotteryShowPOD.leftInsureTime)
	end
end

function m:UpdateFreeDrawShow(cfgLotteryData)
	local leftFreeTime, haveFreeFunc = LotteryModule.CanFreeDraw(cfgLotteryData)
	local canFreeDraw = leftFreeTime == 0

	if self.CostModule ~= nil then
		self.CostModule:SetActive(not canFreeDraw)
	end

	if self.FreeCountdownText ~= nil then
		self.FreeLabelText:SetActive(canFreeDraw)

		self.NeedUpdateCD = haveFreeFunc and not canFreeDraw

		self.FreeCountdownText:SetActive(self.NeedUpdateCD)

		if self.NeedUpdateCD then
			UGUIUtil.SetText(self.FreeCountdownText, LotteryUIApi:GetString("FreeCountdownText", leftFreeTime))
		end

		self.RedPoint:SetActive(canFreeDraw)
	end
end

function m:AddEventListeners()
	self.DrawBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDrawBtn)
end

function m:RemoveEventListeners()
	self.DrawBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDrawBtn)
end

function m:OnClickDrawBtn()
	LotteryModule.Draw(self.CfgLotteryShowData, self.CfgLotteryData)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveEventListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
