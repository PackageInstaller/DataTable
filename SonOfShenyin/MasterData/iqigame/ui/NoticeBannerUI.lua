-- chunkname: @IQIGame\\UI\\NoticeBannerUI.lua

local TabItem = {}

function TabItem.New(view)
	local obj = Clone(TabItem)

	obj:__Init(view)

	return obj
end

function TabItem:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)
end

function TabItem:Show(cfgData, isSelect)
	self.showData = cfgData
	self.SelectText1:GetComponent("Text").text = cfgData.Name
	self.SelectText2:GetComponent("Text").text = cfgData.Name
	self.NormalText1:GetComponent("Text").text = cfgData.Name
	self.NormalText2:GetComponent("Text").text = cfgData.Name

	local isNew = GameNoticeModule.GetPayActiveNoticeNewTag(self.showData.Id)

	LuaCodeInterface.SetGameObjectShow(self.SelectTagRoot.gameObject, isNew)
	LuaCodeInterface.SetGameObjectShow(self.NormalTagRoot.gameObject, isNew)
	self.gameObject:SetActive(true)
	self:ChangeSelected(isSelect)
end

function TabItem:ChangeSelected(isSelect)
	LuaCodeInterface.SetGameObjectShow(self.SelectRoot, isSelect)
	LuaCodeInterface.SetGameObjectShow(self.NormalRoot, not isSelect)
end

function TabItem:ChangeNewTag()
	LuaCodeInterface.SetGameObjectShow(self.SelectTagRoot.gameObject, false)
	LuaCodeInterface.SetGameObjectShow(self.NormalTagRoot.gameObject, false)
end

function TabItem:Hide()
	self.gameObject:SetActive(false)
end

function TabItem:Dispose()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local TabView = {}

function TabView.New(view, jumpCid)
	local obj = Clone(TabView)

	obj:__Init(view, jumpCid)

	return obj
end

function TabView:__Init(view, jumpCid)
	self.gameObject = view
	self.jumpCid = TryToNumber(jumpCid, 0)

	LuaCodeInterface.BindOutlet(self.gameObject, self)
	UIEventUtil.AddClickEventListener_Button(self, "JumpBtn", self.__OnJumpEventHandler)
end

function TabView:__OnJumpEventHandler()
	if self.jumpCid == 0 then
		return
	end

	JumpModule.Jump(self.jumpCid)
end

function TabView:Show()
	self.gameObject:SetActive(true)
end

function TabView:Hide()
	self.gameObject:SetActive(false)
end

function TabView:Dispose()
	UIEventUtil.ClearEventListener(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

local NoticeBannerUI = {
	tabItemList = {},
	tabItemData = {},
	tabViewTable = {}
}

NoticeBannerUI = Base:Extend("NoticeBannerUI", "IQIGame.Onigao.UI.NoticeBannerUI", NoticeBannerUI)

function NoticeBannerUI:OnInit()
	self:__OnInit()
end

function NoticeBannerUI:GetPreloadAssetPaths()
	return nil
end

function NoticeBannerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function NoticeBannerUI:IsManualShowOnOpen(userData)
	return false
end

function NoticeBannerUI:GetBGM(userData)
	return nil
end

function NoticeBannerUI:OnOpen(userData)
	if userData ~= nil then
		self.__selectPayActiveCid = TryToNumber(userData.cid, 0)
	end

	self:__RefreshNoticeShow()
end

function NoticeBannerUI:OnClose(userData)
	GameNoticeModule.SavePayActiveNoticeTag()
end

function NoticeBannerUI:OnAddListeners()
	UIEventUtil.AddClickEventListener_Button(self, "BtnClose", self.__OnCloseBtnClickHandler)
	UIEventUtil.AddClickEventListener_Button(self, "CloseBtn", self.__OnCloseBtnClickHandler)
end

function NoticeBannerUI:OnRemoveListeners()
	UIEventUtil.ClearEventListener(self)
end

function NoticeBannerUI:OnPause()
	return
end

function NoticeBannerUI:OnResume()
	return
end

function NoticeBannerUI:OnCover()
	return
end

function NoticeBannerUI:OnReveal()
	return
end

function NoticeBannerUI:OnRefocus(userData)
	return
end

function NoticeBannerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function NoticeBannerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function NoticeBannerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function NoticeBannerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NoticeBannerUI:OnDestroy()
	self:__OnDispose()
end

function NoticeBannerUI:__OnInit()
	self.tabScrollAreaList = self.TabScrollAreaRoot:GetComponent("ScrollAreaList")

	function self.tabScrollAreaList.onRenderCell(cell)
		self:__OnRenderTabItem(cell)
	end

	function self.tabScrollAreaList.onSelectedCell(cell)
		self:__OnSelectTabItem(cell)
	end
end

function NoticeBannerUI:__OnDispose()
	GameNoticeModule.SavePayActiveNoticeTag()

	self.tabScrollAreaList.onRenderCell = nil
	self.tabScrollAreaList.onSelectedCell = nil
	self.tabScrollAreaList = nil

	ForPairs(self.tabViewTable, function(k, _view)
		_view:Dispose()
	end)

	self.tabViewTable = nil

	ForPairs(self.tabItemList, function(_, _tabItem)
		_tabItem:Dispose()
	end)

	self.tabItemData = nil
end

function NoticeBannerUI:__ShowEmpty()
	return
end

function NoticeBannerUI:__RefreshNoticeShow()
	self.tabItemData = GameNoticeModule.GetPayActiveNoticeList()

	if #self.tabItemData == 0 then
		self:__ShowEmpty()

		return
	end

	if TryToNumber(self.__selectPayActiveCid, 0) == 0 then
		self.__selectPayActiveCid = self.tabItemData[1].Id
	end

	self.tabScrollAreaList:Refresh(#self.tabItemData)
end

function NoticeBannerUI:__OnRenderTabItem(cell)
	local instanceId = cell.gameObject:GetInstanceID()
	local tabItem = self.tabItemList[instanceId]

	if tabItem == nil then
		tabItem = TabItem.New(cell.gameObject)
		self.tabItemList[instanceId] = tabItem
	end

	local cfg = self.tabItemData[cell.index + 1]
	local isSelect = cfg.Id == self.__selectPayActiveCid

	tabItem:Show(cfg, isSelect)

	if not isSelect then
		return
	end

	tabItem:ChangeNewTag()
	self:__RefreshNoticeInfoView(cfg)
end

function NoticeBannerUI:__OnSelectTabItem(cell)
	local instanceId = cell.gameObject:GetInstanceID()

	ForPairs(self.tabItemList, function(_insID, _tabItem)
		local isSelect = _insID == instanceId

		_tabItem:ChangeSelected(isSelect)

		if not isSelect then
			return
		end

		_tabItem:ChangeNewTag()
		self:__RefreshNoticeInfoView(_tabItem.showData)
	end)
end

function NoticeBannerUI:__RefreshNoticeInfoView(cfg)
	self.__selectPayActiveCid = cfg.Id

	GameNoticeModule.UpdatePayActiveNoticeTag(self.__selectPayActiveCid)

	local needLoadView = true

	ForPairs(self.tabViewTable, function(_cfgCid, _view)
		if _cfgCid ~= self.__selectPayActiveCid then
			_view:Hide()

			return
		end

		needLoadView = false

		_view:Show()
	end)

	if not needLoadView then
		return
	end

	local prefabPath = UIGlobalApi.GetUIPrefab(cfg.UIPrefab)

	AssetUtil.LoadAsset(self, prefabPath, function(_owner, _assetName, _asset, _duration, _userData)
		self:__OnViewLoaded(_asset, _userData)
	end, nil, {
		cid = self.__selectPayActiveCid,
		jumpCid = cfg.Skip
	})
end

function NoticeBannerUI:__OnViewLoaded(asset, userData)
	if self.tabViewTable == nil then
		return
	end

	local view = UnityEngine.Object.Instantiate(asset)

	view.name = tostring(userData.cid)

	view.gameObject.transform:SetParent(self.NoticeItemParent.transform)

	view.gameObject.transform.localPosition = Vector3.zero
	view.gameObject.transform.localScale = Vector3.one

	local tabView = TabView.New(view.gameObject, userData.jumpCid)

	self.tabViewTable[userData.cid] = tabView

	if self.__selectPayActiveCid ~= userData.cid then
		tabView:Hide()
	else
		tabView:Show()
	end
end

function NoticeBannerUI:__OnCloseBtnClickHandler()
	UIModule.Close(Constant.UIControllerName.NoticeBannerUI)
end

return NoticeBannerUI
