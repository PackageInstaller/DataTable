-- chunkname: @IQIGame\\UI\\ShopRecoveryUI.lua

local ShopRecoveryUI = Base:Extend("ShopRecoveryUI", "IQIGame.Onigao.UI.ShopRecoveryUI", {
	itemCellPool = {},
	datum = {},
	exchangeCid2CountDic = {}
})
local ShopRecoveryCell = require("IQIGame.UI.ShopRecovery.ShopRecoveryCell")

function ShopRecoveryUI:OnInit()
	self:Initialize()
end

function ShopRecoveryUI:GetPreloadAssetPaths()
	return nil
end

function ShopRecoveryUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ShopRecoveryUI:IsManualShowOnOpen(userData)
	return false
end

function ShopRecoveryUI:GetBGM(userData)
	return nil
end

function ShopRecoveryUI:OnOpen(userData)
	self:Refresh(userData)
end

function ShopRecoveryUI:OnClose(userData)
	self:OnHide()
end

function ShopRecoveryUI:OnPause()
	return
end

function ShopRecoveryUI:OnResume()
	return
end

function ShopRecoveryUI:OnCover()
	return
end

function ShopRecoveryUI:OnReveal()
	return
end

function ShopRecoveryUI:OnRefocus(userData)
	return
end

function ShopRecoveryUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ShopRecoveryUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ShopRecoveryUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ShopRecoveryUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ShopRecoveryUI:Initialize()
	self.tfTotalNum = self.goTotalNum:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnClose2 = self.goBtnClose2:GetComponent("Button")
	self.btnRecover = self.goBtnRecover:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	self.goTitle:GetComponent("Text").text = ShopRecoveryUIApi:GetString("goTitle")
	self.goCostDesc:GetComponent("Text").text = ShopRecoveryUIApi:GetString("goCostDesc")
	self.scrollList = self.goList:GetComponent("ScrollAreaList")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	self.btnRecover = self.goBtnRecover:GetComponent("Button")

	function self.onClickBtnRecoverDelegate()
		self:OnClickBtnRecover()
	end

	function self.onExchangeSuccessDelegate()
		self:OnExchangeSuccess()
	end

	self.goBtnRecover.transform:Find("Text"):GetComponent("Text").text = ShopRecoveryUIApi:GetString("btnRecoverTxt")
end

function ShopRecoveryUI:Refresh(userData)
	self.datum = {}

	local fullStartSoulDatum = {}

	for i, v in pairs(SoulModule.GetUnlockSoulDataDic()) do
		local cfgData = v:GetCfgSoulQuality()

		if cfgData.Quality == 5 then
			fullStartSoulDatum[#fullStartSoulDatum + 1] = v
		end
	end

	table.sort(fullStartSoulDatum, function(a, b)
		return a.soulCid < b.soulCid
	end)

	local cid2CountDic = {}

	for i, v in ipairs(fullStartSoulDatum) do
		local cfgData = CfgSoulTable[v.soulCid]
		local itemCid = cfgData.UnlockItem[1]
		local ownCount = WarehouseModule.GetItemNumByCfgID(itemCid)

		if ownCount > 0 then
			self.datum[#self.datum + 1] = {
				itemCid,
				ownCount
			}
			cid2CountDic[itemCid] = ownCount
		end
	end

	self.scrollList:Refresh(#self.datum)

	self.exchangeCid2CountDic = {}

	local totalNum = 0

	if #self.datum ~= 0 then
		for i, v in pairs(self.datum) do
			local itemCid = v[1]

			for m, n in pairsCfg(CfgExchangeTable) do
				if n.CostItems[1][1] == itemCid then
					self.exchangeCid2CountDic[n.Id] = cid2CountDic[itemCid]
					totalNum = totalNum + n.GetItems[1][2] * cid2CountDic[itemCid]
				end
			end
		end
	end

	self.tfTotalNum.text = ShopRecoveryUIApi:GetString("goTotalNum", totalNum)
end

function ShopRecoveryUI:OnHide()
	return
end

function ShopRecoveryUI:OnDestroy()
	for i, v in pairs(self.itemCellPool) do
		v:OnDestroy()
	end
end

function ShopRecoveryUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnRecover.onClick:AddListener(self.onClickBtnRecoverDelegate)
	EventDispatcher.AddEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
end

function ShopRecoveryUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnClose2.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnRecover.onClick:RemoveListener(self.onClickBtnRecoverDelegate)
	EventDispatcher.RemoveEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
end

function ShopRecoveryUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function ShopRecoveryUI:OnClickBtnRecover()
	ChurchModule.SendBatchExchangeMsg(self.exchangeCid2CountDic)
end

function ShopRecoveryUI:OnExchangeSuccess()
	self:OnClickBtnClose()
end

function ShopRecoveryUI:OnRenderCell(cell)
	local luaIndex = cell.index + 1
	local insID = cell.gameObject:GetInstanceID()
	local data = self.datum[luaIndex]
	local itemCell = self.itemCellPool[insID]

	if itemCell == nil then
		itemCell = ShopRecoveryCell.New(cell.gameObject)
		self.itemCellPool[insID] = itemCell
	end

	itemCell:Refresh(data[1], data[2])
end

return ShopRecoveryUI
