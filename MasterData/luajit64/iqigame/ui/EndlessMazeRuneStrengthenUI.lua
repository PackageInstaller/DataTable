-- chunkname: @IQIGame\\UI\\EndlessMazeRuneStrengthenUI.lua

local EndlessMazeRuneStrengthenUI = Base:Extend("EndlessMazeRuneStrengthenUI", "IQIGame.Onigao.UI.EndlessMazeRuneStrengthenUI", {
	Discount = 0,
	Count = 0,
	StrengthenItems = {}
})
local EndlessMazeRuneStrengthenItem = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneStrengthenItem")

function EndlessMazeRuneStrengthenUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickStrengthBtn(mazeRunePOD)
		self:OnClickStrengthBtn(mazeRunePOD)
	end

	function self.DelegateOnRuneStrengthenSuccess(sender, args)
		self:OnRuneStrengthenSuccess(sender, args)
	end

	self.ScrollAreaList = self.StrengthenItemGrid:GetComponent("ScrollAreaList")

	function self.ScrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	UGUIUtil.SetText(self.TitleText, EndlessMazeRuneStrengthenUIApi:GetString("TitleText"))
end

function EndlessMazeRuneStrengthenUI:GetPreloadAssetPaths()
	return nil
end

function EndlessMazeRuneStrengthenUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessMazeRuneStrengthenUI:OnOpen(userData)
	self:UpdateView(userData.count, userData.discount)
end

function EndlessMazeRuneStrengthenUI:OnClose(userData)
	return
end

function EndlessMazeRuneStrengthenUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Subscribe(MazeCommandEventArgs.RuneStrengthenCommandEventId, self.DelegateOnRuneStrengthenSuccess)
end

function EndlessMazeRuneStrengthenUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	GameEntry.LuaEvent:Unsubscribe(MazeCommandEventArgs.RuneStrengthenCommandEventId, self.DelegateOnRuneStrengthenSuccess)
end

function EndlessMazeRuneStrengthenUI:OnPause()
	return
end

function EndlessMazeRuneStrengthenUI:OnResume()
	return
end

function EndlessMazeRuneStrengthenUI:OnCover()
	return
end

function EndlessMazeRuneStrengthenUI:OnReveal()
	return
end

function EndlessMazeRuneStrengthenUI:OnRefocus(userData)
	return
end

function EndlessMazeRuneStrengthenUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessMazeRuneStrengthenUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessMazeRuneStrengthenUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessMazeRuneStrengthenUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessMazeRuneStrengthenUI:OnDestroy()
	for instanceID, strengthenItem in pairs(self.StrengthenItems) do
		strengthenItem:Dispose()
	end
end

function EndlessMazeRuneStrengthenUI:UpdateView(count, discount)
	self.Count = count
	self.Discount = discount
	self.DataList = {}

	for i = 1, #MazeDataModule.PlayerInfo.Runes do
		local mazeRunePOD = MazeDataModule.PlayerInfo.Runes[i]
		local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

		if mazeRunePOD.Level < cfgRuneData.MaxStrengthenLevel then
			table.insert(self.DataList, mazeRunePOD)
		end
	end

	self.ScrollAreaList:Refresh(#self.DataList)
	self:SetLeftCount(count)
	self.NoneView:SetActive(#self.DataList == 0)
end

function EndlessMazeRuneStrengthenUI:SetLeftCount(count)
	UGUIUtil.SetText(self.LeftCountText, EndlessMazeRuneStrengthenUIApi:GetString("LeftCountText", count))
end

function EndlessMazeRuneStrengthenUI:OnRenderCell(cell)
	local mazeRunePOD = self.DataList[cell.index + 1]
	local strengthenItem = self.StrengthenItems[cell.gameObject:GetInstanceID()]

	if strengthenItem == nil then
		strengthenItem = EndlessMazeRuneStrengthenItem.New(cell.gameObject, self.DelegateOnClickStrengthBtn)
		self.StrengthenItems[cell.gameObject:GetInstanceID()] = strengthenItem
	end

	strengthenItem:SetData(mazeRunePOD, self.Discount)
end

function EndlessMazeRuneStrengthenUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.EndlessMazeRuneStrengthenUI)
	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_CLOSE_STRENGTH_RUNE)
end

function EndlessMazeRuneStrengthenUI:OnClickStrengthBtn(mazeRunePOD)
	if self.Count == 0 then
		NoticeModule.ShowNotice(21050001)

		return
	end

	local cfgRuneData = CfgRuneTable[mazeRunePOD.CID]

	if MazeDataModule.GetItemNumByCfgID(Constant.ItemID.CRYSTAL) < cfgRuneData.StrengthenCost[mazeRunePOD.Level] then
		NoticeModule.ShowNotice(21050003)

		return
	end

	MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_STRENGTH_RUNE, {
		Cid = mazeRunePOD.CID
	})

	self.Count = self.Count - 1
end

function EndlessMazeRuneStrengthenUI:OnRuneStrengthenSuccess(sender, args)
	self:UpdateView(self.Count, self.Discount)
end

return EndlessMazeRuneStrengthenUI
