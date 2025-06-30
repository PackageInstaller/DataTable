-- chunkname: @IQIGame\\UI\\GetPanelUI.lua

local GetPanelUI = Base:Extend("GetPanelUI", "IQIGame.Onigao.UI.GetPanelUI", {
	isShowAllItem = false,
	ShowIndex = 1,
	DelayTime = 0.2,
	isDelay = true,
	ItemList = {}
})
local GetPanelItemCell = require("IQIGame.UI.GetPanel.GetPanelItemCell")
local LotteryHeroShow = require("IQIGame.UI.Lottery.LotteryHeroShow")

function GetPanelUI:OnInit()
	function self.DelegateUpdateItem(cell)
		self:UpdateItem(cell)
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self:InitDelegate()

	local wrapContent = self.ItemContainer:GetComponent("ScrollAreaList")

	wrapContent.onRenderCell = self.DelegateUpdateItem
	self.HeroShowPanel = LotteryHeroShow.New(self.HeroShowView)

	UGUIUtil.SetText(self.TextEng, GetPanelUIApi:GetTextEng())

	self.goBtnTxt:GetComponent("Text").text = GetPanelUIApi:GetBtnTxt()
	self.ContentGridLayout = self.ItemContentParent:GetComponent("GridLayoutGroup")
	self.ContentSizeFitter = self.ItemContentParent:GetComponent("ContentSizeFitter")
	self.ConfirmBtnCom = self.ConfirmBtn:GetComponent("ButtonEx")

	self.ConfirmBtnCom:SetDelayClickStartEvent(self.DelegateOnRealClickStartEvent)
end

function GetPanelUI:InitDelegate()
	function self.refreshEvent(userData)
		self:RefreshShow(userData)
	end

	function self.DelegateOnRealClickStartEvent()
		if not self.isShowAllItem then
			return
		end

		self.isShowAllItem = false

		for k, v in pairs(self.ItemList) do
			v:PlayOutAnim()
			v:DisableEffect()
		end
	end
end

function GetPanelUI:GetPreloadAssetPaths()
	return nil
end

function GetPanelUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GetPanelUI:OnOpen(userData)
	LuaUtility.PlaySoundWithID(11100005)

	self.isDelay = true
	self.ConfirmBtnCom.interactable = false
	NoticeModule.isGetPanelUIShow = true

	self:HideItem()
	self:RefreshShow(userData)
end

function GetPanelUI:RefreshShow(userData)
	if userData == nil then
		return
	end

	self.callback = userData.callback
	self.isShowAllItem = false
	self.ShowIndex = 1

	self.HeroShowPanel:Hide()
	self:AwardShow(userData)
end

function GetPanelUI:AwardShow(userData)
	self.UserData = userData
	self.isOnlyShowHero = userData.showType ~= nil
	self.RawItemDatas = {}

	for i = 1, #self.UserData.items do
		local cfgItem = CfgItemTable[self.UserData.items[i].cid]

		if cfgItem and cfgItem.IsHide ~= 1 then
			local rawItemData = self.UserData.items[i]

			table.insert(self.RawItemDatas, rawItemData)
		end
	end

	if not self.isOnlyShowHero then
		self:UpdateView(self.RawItemDatas, self.UserData.args)
		self:SelectHeroShow()
	else
		self:SelectHeroShow()
	end
end

function GetPanelUI:OnClose(userData)
	if self.UserData.openType == "ReceiveFeedbackResult" then
		EventDispatcher.Dispatch(EventID.GetBackGiftReward)
	end

	EventDispatcher.DispatchSingleEvent(EventID.OnGetPanelUICloseEvent)

	NoticeModule.isGetPanelUIShow = false

	EventDispatcher.Dispatch(EventID.RemoveGlobalBuffNoticeLock)
end

function GetPanelUI:OnPause()
	return
end

function GetPanelUI:OnResume()
	return
end

function GetPanelUI:OnCover()
	return
end

function GetPanelUI:OnReveal()
	return
end

function GetPanelUI:OnRefocus(userData)
	return
end

function GetPanelUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GetPanelUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GetPanelUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GetPanelUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GetPanelUI:OnDestroy()
	for _, v in pairs(self.ItemList) do
		v:Dispose()
	end

	NoticeModule.isGetPanelUIShow = false
	self.ItemList = {}

	self.HeroShowPanel:Dispose()
	AssetUtil.UnloadAsset(self)
end

function GetPanelUI:OnAddListeners()
	self.ConfirmBtnCom.onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.GetPanelUIRefresh, self.refreshEvent)
end

function GetPanelUI:OnRemoveListeners()
	self.ConfirmBtnCom.onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.GetPanelUIRefresh, self.refreshEvent)
end

function GetPanelUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)

	if self.callback then
		self.callback()

		self.callback = nil
	end

	NoticeModule.ShowNextGetItems()
end

function GetPanelUI:HideItem()
	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end
end

function GetPanelUI:UpdateView(items, args)
	self:CreateSlotItem()
end

function GetPanelUI:CreateSlotItem()
	self.ContentSizeFitter.enabled = true
	self.ContentGridLayout.enabled = true

	for i = 1, #self.ItemList do
		self.ItemList[i]:Hide()
	end

	local tag = 0
	local itemData

	for i = 1, #self.RawItemDatas do
		local itemObj = self:InstantiateItemObj(i)
		local rawItemData = self.RawItemDatas[i]

		if rawItemData ~= nil then
			itemData = ItemData.CreateItemShowDataByItemShowPOD(rawItemData)
			tag = rawItemData.tag
		end

		self.ItemList[i]:Show()
		itemObj:SetItem(itemData, tag)
	end

	CoroutineUtility.StartCoroutine(function()
		CoroutineUtility.Yield(CustomWaitForSeconds(0.02))

		for i = 1, #self.ItemList do
			self.ItemList[i]:Hide()
		end

		self.ContentSizeFitter.enabled = false
		self.ContentGridLayout.enabled = false

		CoroutineUtility.Yield(CustomWaitForSeconds(0.35))

		for i = 1, #self.RawItemDatas do
			if self.isDelay then
				CoroutineUtility.Yield(CustomWaitForSeconds(self.DelayTime))
			end

			self.ItemList[i]:Show()
			self.ItemList[i]:PlayInAnim()
			self.ItemList[i]:EnableEffect()
		end

		CoroutineUtility.Yield(CustomWaitForSeconds(0.5))

		self.isShowAllItem = true
		self.ConfirmBtnCom.interactable = true
	end)
end

function GetPanelUI:InstantiateItemObj(index)
	local itemObj = self.ItemList[index]

	if itemObj == nil then
		local obj = UnityEngine.Object.Instantiate(self.Grid_Mould)

		itemObj = GetPanelItemCell.New(obj)

		obj.transform:SetParent(self.ItemContentParent.transform, false)

		self.ItemList[index] = itemObj
	end

	return itemObj
end

function GetPanelUI:UpdateItem(cell)
	local rawItemData = self.RawItemDatas[cell.index + 1]
	local instanceId = cell.gameObject:GetInstanceID()
	local itemCell = self.ItemList[instanceId]

	if itemCell == nil then
		itemCell = GetPanelItemCell.New(cell.gameObject)
		self.ItemList[instanceId] = itemCell
	end

	local itemData
	local tag = 0

	if rawItemData ~= nil then
		itemData = ItemData.CreateItemShowDataByItemShowPOD(rawItemData)
		tag = rawItemData.tag
	end

	itemCell:SetItem(itemData, tag)
end

function GetPanelUI:SelectHeroShow()
	local resultList = {
		drawResults = {}
	}

	for i = self.ShowIndex, #self.RawItemDatas do
		if self.RawItemDatas[i].srcId ~= nil and self.RawItemDatas[i].srcId ~= 0 then
			local itemCfg = CfgItemTable[self.RawItemDatas[i].srcId]

			if itemCfg.ItemTypes == Constant.ItemType.Hero then
				table.insert(resultList.drawResults, {
					srcId = self.RawItemDatas[i].srcId,
					itemShowPODs = {
						{
							cid = self.RawItemDatas[i].cid,
							num = self.RawItemDatas[i].num
						}
					}
				})
			end
		elseif CfgItemTable[self.RawItemDatas[i].cid].ItemTypes == Constant.ItemType.Hero then
			table.insert(resultList.drawResults, {
				srcId = self.RawItemDatas[i].cid,
				itemShowPODs = {}
			})
		end

		self.ShowIndex = i + 1
	end

	if table.len(resultList.drawResults) == 0 then
		return
	end

	self.HeroShowPanel:SetData(resultList, function()
		self:ConfirmHeroCallBack()
	end)
end

function GetPanelUI:ShowHeroDraw(heroId)
	self.HeroShowPanel:ShowHeroEffectByHeroCid(heroId)
end

function GetPanelUI:ConfirmHeroCallBack()
	if self.isOnlyShowHero then
		NoticeModule.isGetPanelUIShow = false

		self:OnClickCloseBtn()
	end
end

return GetPanelUI
