-- chunkname: @IQIGame\\UI\\MazeReviveUI.lua

local MazeReviveUI = Base:Extend("MazeReviveUI", "IQIGame.Onigao.UI.MazeReviveUI", {
	CostItemNum = 0
})

function MazeReviveUI:OnInit()
	function self.DelegateOnGiveUp()
		self:OnGiveUp()
	end

	function self.DelegateOnRevive()
		self:OnRevive()
	end

	function self.DelegateOnReviveSucceed(sender, args)
		self:OnReviveSucceed(sender, args)
	end

	UGUIUtil.SetText(self.goTitleTxt1, MazeReviveUIApi:GetString("goTitleTxt1"))
	UGUIUtil.SetText(self.goTitleTxt2, MazeReviveUIApi:GetString("goTitleTxt2"))
	UGUIUtil.SetText(self.goDescTxt, MazeReviveUIApi:GetString("goDescTxt"))
	UGUIUtil.SetText(self.goBtnGiveUpTxt, MazeReviveUIApi:GetString("goBtnGiveUpTxt"))
	UGUIUtil.SetText(self.goBtnReviveTxt, MazeReviveUIApi:GetString("goBtnReviveTxt"))
end

function MazeReviveUI:GetPreloadAssetPaths()
	return nil
end

function MazeReviveUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeReviveUI:OnOpen(userData)
	self:UpdateView(userData)
end

function MazeReviveUI:OnClose(userData)
	return
end

function MazeReviveUI:OnPause()
	return
end

function MazeReviveUI:OnResume()
	return
end

function MazeReviveUI:OnCover()
	return
end

function MazeReviveUI:OnReveal()
	return
end

function MazeReviveUI:OnRefocus(userData)
	return
end

function MazeReviveUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeReviveUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeReviveUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function MazeReviveUI:OnAddListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnGiveUp)
	self.ReviveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnRevive)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.ReviveCommandEventId, self.DelegateOnReviveSucceed)
end

function MazeReviveUI:OnRemoveListeners()
	self.GiveUpBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnGiveUp)
	self.ReviveBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnRevive)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.ReviveCommandEventId, self.DelegateOnReviveSucceed)
end

function MazeReviveUI:OnGiveUp()
	UIModule.Close(Constant.UIControllerName.MazeReviveUI)
	MazeModule.SendLeaveMazeOrder()
end

function MazeReviveUI:OnRevive()
	if self.ReviveType == 0 then
		return
	end

	if self.ReviveType == 4 then
		local isItemEnough = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE) >= self.CostItemNum

		if not isItemEnough then
			NoticeModule.ShowNotice(21040015)

			return
		end

		MazeModule.SendRevive()
	else
		MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_REVIVE, {
			Type = self.ReviveType
		})
	end
end

function MazeReviveUI:UpdateView(weakCommand)
	self.ReviveType = 0

	local cfgMazeInstanceData = CfgMazeInstanceTable[MazeDataModule.MazeInstanceID]
	local revivedCounts = {}

	revivedCounts[1] = weakCommand.FreeReviveCount
	revivedCounts[2] = weakCommand.BuffReviveCount
	revivedCounts[3] = weakCommand.PropReviveCount
	revivedCounts[4] = weakCommand.TreReviveCount

	local canReviveInThisMode
	local costItemCid = 0
	local costItemNum = 0
	local leftCount = 0

	for i = 1, 4 do
		self.ReviveType = i
		leftCount = cfgMazeInstanceData.ReviveTimes[i] - revivedCounts[i]

		if leftCount > 0 then
			canReviveInThisMode, costItemCid, costItemNum = self:CheckIfCanReviveAndCost(i, revivedCounts[i], cfgMazeInstanceData)

			if canReviveInThisMode then
				break
			end
		end
	end

	self.CostItemNum = costItemNum

	local isOK = false

	self.CurrencyIcon:SetActive(costItemCid > 0)

	if self.ReviveType == 1 then
		self.PriceNumText:GetComponent("Text").text = MazeReviveUIApi:GetString("PriceNumText", self.ReviveType, 0, true)
		isOK = true
	elseif self.ReviveType == 2 then
		-- block empty
	else
		local cfgItemData = CfgItemTable[costItemCid]

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CurrencyIcon:GetComponent("Image"))

		local bagItemNum = 0

		if self.ReviveType == 3 then
			bagItemNum = MazeDataModule.GetItemNumByCfgID(costItemCid)
		elseif self.ReviveType == 4 then
			bagItemNum = WarehouseModule.GetItemNumByCfgID(costItemCid)
		end

		isOK = costItemNum <= bagItemNum
		self.PriceNumText:GetComponent("Text").text = MazeReviveUIApi:GetString("PriceNumText", self.ReviveType, costItemNum, isOK, bagItemNum)
	end

	self.LeftCountText:GetComponent("Text").text = MazeReviveUIApi:GetString("LeftCountText", leftCount)
	self.goSubDescText:GetComponent("Text").text = MazeReviveUIApi:GetString("goSubDescText", self.ReviveType)
	self.PriceNumText:GetComponent("Text").color = hexStringToColor(MazeReviveUIApi:GetString("PriceTextColor", isOK))
end

function MazeReviveUI:CheckIfCanReviveAndCost(type, revivedCount, cfgMazeInstanceData)
	local costItemCid, costItemNum, isBuffOrItemEnough

	if type == 1 then
		costItemCid = 0
		costItemNum = 0
		isBuffOrItemEnough = true
	elseif type == 2 then
		costItemCid = 0
		costItemNum = 0
		isBuffOrItemEnough = false
	elseif type == 3 then
		local index = math.min(revivedCount + 1, #cfgMazeInstanceData.ItemRevive * 0.5)

		costItemCid = cfgMazeInstanceData.ItemRevive[(index - 1) * 2 + 1]
		costItemNum = cfgMazeInstanceData.ItemRevive[(index - 1) * 2 + 2]
		isBuffOrItemEnough = costItemNum <= MazeDataModule.GetItemNumByCfgID(costItemCid)
	elseif type == 4 then
		local index = math.min(revivedCount + 1, #cfgMazeInstanceData.TreRevive)

		costItemCid = Constant.ItemID.TREASURE
		costItemNum = cfgMazeInstanceData.TreRevive[index]

		if revivedCount == 0 and PlayerModule.PlayerInfo.globalBuffs ~= nil then
			for globalBuffCid, leftCount in pairs(PlayerModule.PlayerInfo.globalBuffs) do
				local cfgGlobalBuffData = CfgGlobalBuffTable[globalBuffCid]

				if cfgGlobalBuffData.EffectType == 1 then
					costItemNum = 0

					break
				end
			end
		end

		isBuffOrItemEnough = true
	end

	return isBuffOrItemEnough, costItemCid, costItemNum
end

function MazeReviveUI:OnReviveSucceed(sender, args)
	local command = args:ToLuaTable()

	if command.Code == 0 then
		UIModule.Close(Constant.UIControllerName.MazeReviveUI)
	else
		NoticeModule.ShowNoticeNoCallback(21040005, getErrorMsg(command.Code))
	end
end

return MazeReviveUI
