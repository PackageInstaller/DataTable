-- chunkname: @IQIGame\\UI\\SoulListUI.lua

local SoulListUI = Base:Extend("SoulListUI", "IQIGame.Onigao.UI.SoulListUI", {
	cellList = {},
	sortedSoulDatum = {}
})

function SoulListUI:OnInit()
	self:Initialize()
end

function SoulListUI:GetPreloadAssetPaths()
	return nil
end

function SoulListUI:GetOpenPreloadAssetPaths(userData)
	local ret = {}

	self:RefreshDatum()

	for i, v in ipairs(self.sortedSoulDatum) do
		ret[#ret + 1] = UIGlobalApi.GetHarmoniousImagePath(v:GetCfgSoulRes2D().SoulSoulCard)
	end

	return ret
end

function SoulListUI:OnOpen(userData)
	self:Refresh()
end

function SoulListUI:OnClose(userData)
	self:OnHide()
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseSoulListUI")
end

function SoulListUI:OnPause()
	return
end

function SoulListUI:OnResume()
	return
end

function SoulListUI:OnCover()
	return
end

function SoulListUI:OnReveal()
	return
end

function SoulListUI:OnRefocus(userData)
	return
end

function SoulListUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SoulListUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SoulListUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SoulListUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SoulListUI:Initialize()
	self.scrollPageList = self.goScrollList:GetComponent("ScrollAreaList")

	function self.scrollPageList.onSelectedCell(gridCell)
		self:OnSelectedGridCell(gridCell)
	end

	function self.scrollPageList.onRenderCell(gridCell)
		self:OnRenderGridCell(gridCell)
	end

	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnGuide = self.goBtnGuide:GetComponent("Button")
	self.btnRecover = self.goBtnRecover:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnGuideDelegate()
		self:OnClickBtnGuide()
	end

	function self.onSoulUnlockSuccessDelegate(soulID)
		self:OnSoulUnlockSuccess(soulID)
	end

	function self.onEvolveSoulSuccessDelegate(soulCid)
		self:OnEvolveSoulSuccess(soulCid)
	end

	function self.onRefreshSoulListDelegate()
		self:OnRefreshSoulList()
	end

	function self.onRefreshRedPointDelegate()
		self:OnRefreshRedPoint()
	end

	function self.onSoulExpAddSuccessDelegate(soulData)
		self:OnSoulExpAddSuccess(soulData)
	end

	function self.onClickBtnRecoverDelegate()
		self:OnClickBtnRecover()
	end

	function self.onExchangeSuccessDelegate()
		self:OnExchangeSuccess()
	end

	self.goDesc1:GetComponent("Text").text = SoulListUIApi:GetString("bottomDesc_1")
	self.goDesc2:GetComponent("Text").text = SoulListUIApi:GetString("bottomDesc_2")
	self.goDesc3:GetComponent("Text").text = SoulListUIApi:GetString("bottomDesc_3")
	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = SoulListUIApi:GetString("goTitle")
	self.goBtnRecover.transform:Find("Text"):GetComponent("Text").text = SoulListUIApi:GetString("goBtnRecoverTxt")
end

function SoulListUI:Refresh()
	self.scrollPageList:Refresh(#self.sortedSoulDatum)
	self:CheckToDoOnExistUnlockedSoul()
	self:RefreshMisc()
end

function SoulListUI:OnHide()
	for i, v in pairs(self.cellList) do
		v:OnHide()
	end
end

function SoulListUI:OnDestroy()
	for i, v in pairs(self.cellList) do
		v:OnDestroy()
	end

	AssetUtil.UnloadAsset(self)
end

function SoulListUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:AddListener(self.onClickBtnGuideDelegate)
	self.btnRecover.onClick:AddListener(self.onClickBtnRecoverDelegate)
	EventDispatcher.AddEventListener(EventID.SoulUnlockSuccess, self.onSoulUnlockSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EvolveSoulSuccess, self.onEvolveSoulSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.RefreshSoulList, self.onRefreshSoulListDelegate)
	EventDispatcher.AddEventListener(EventID.RefreshSoulListRedPoint, self.onRefreshRedPointDelegate)
	EventDispatcher.AddEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
end

function SoulListUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnGuide.onClick:RemoveListener(self.onClickBtnGuideDelegate)
	self.btnRecover.onClick:RemoveListener(self.onClickBtnRecoverDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulUnlockSuccess, self.onSoulUnlockSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EvolveSoulSuccess, self.onEvolveSoulSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.RefreshSoulList, self.onRefreshSoulListDelegate)
	EventDispatcher.RemoveEventListener(EventID.RefreshSoulListRedPoint, self.onRefreshRedPointDelegate)
	EventDispatcher.RemoveEventListener(EventID.SoulExpAddSuccess, self.onSoulExpAddSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.BatchExchangeSuccess, self.onExchangeSuccessDelegate)
end

function SoulListUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.SoulListUI)
end

function SoulListUI:OnClickBtnGuide()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 1000)
end

function SoulListUI:OnClickBtnRecover()
	UIModule.Open(Constant.UIControllerName.ShopRecoveryUI, Constant.UILayer.UI)
end

function SoulListUI:OnExchangeSuccess()
	self:RefreshMisc()
end

function SoulListUI:OnRenderGridCell(gridCell)
	local data = self.sortedSoulDatum[gridCell.index + 1]
	local insID = gridCell.gameObject:GetInstanceID()
	local cell = self.cellList[insID]

	if cell == nil then
		cell = SoulListCell.New(gridCell.gameObject, self)
		self.cellList[insID] = cell
	end

	cell:Refresh(data)

	gridCell.gameObject.name = data.soulCid
	gridCell.transform.parent.gameObject.name = "Index"
end

function SoulListUI:OnSelectedGridCell(gridCell)
	local data = self.sortedSoulDatum[gridCell.index + 1]

	if data.isUnlock == true then
		local switchList = {}

		for i, v in ipairs(self.sortedSoulDatum) do
			if v.isUnlock then
				switchList[#switchList + 1] = v
			end
		end

		UIModule.Open(Constant.UIControllerName.SoulUI, Constant.UILayer.UI, {
			[UIParam.soulUI.soulData] = data,
			[UIParam.soulUI.switchList] = switchList
		})
	else
		UIModule.Open(Constant.UIControllerName.SoulLockUI, Constant.UILayer.UI, data)
	end
end

function SoulListUI:OnSoulUnlockSuccess(soulCid)
	for i, v in pairs(self.cellList) do
		if v.soulData.soulCid == soulCid then
			v:OnUnlockSoul()

			break
		end
	end

	self:RefreshRedPoint()
end

function SoulListUI:OnEvolveSoulSuccess(soul)
	for i, v in pairs(self.cellList) do
		if v.soulData.soulCid == soul.cid then
			v:OnEvolveSoulSuccess()

			break
		end
	end

	self:RefreshRedPoint()
	self:RefreshMisc()
end

function SoulListUI:OnSoulExpAddSuccess(soul)
	for i, v in pairs(self.cellList) do
		if v.soulData.soulCid == soul.soulCid then
			v:OnSoulExpAddSuccess()

			break
		end
	end

	self:RefreshRedPoint()
end

function SoulListUI:OnRefreshRedPoint()
	self:RefreshRedPoint()
end

function SoulListUI:OnRefreshSoulList()
	self:RefreshDatum()
	self.scrollPageList:Refresh(#self.sortedSoulDatum)
end

function SoulListUI:RefreshDatum()
	self.sortedSoulDatum = {}

	for i, v in ipairs(SoulModule.GetSortedSoulDataList()) do
		self.sortedSoulDatum[i] = v
	end
end

function SoulListUI:RefreshMisc()
	self.goBtnRecover:SetActive(SoulModule.CheckExistNeedRecover())
end

function SoulListUI:RefreshRedPoint()
	for i, v in pairs(self.cellList) do
		v:RefreshRetPoint()
	end
end

function SoulListUI:CheckToDoOnExistUnlockedSoul()
	local canUnlockIds = SoulModule.GetCanUnlockSoulIDList()
	local sortedIds = {}

	for i, v in ipairs(self.sortedSoulDatum) do
		if table.indexOf(canUnlockIds, v.soulCid) ~= -1 then
			sortedIds[#sortedIds + 1] = v.soulCid
		end
	end

	if #sortedIds > 0 then
		UIModule.Open(Constant.UIControllerName.SoulUnlockUI, Constant.UILayer.UI, {
			[UIParam.soulUnlockUI.soulIds] = sortedIds
		})
	end
end

return SoulListUI
