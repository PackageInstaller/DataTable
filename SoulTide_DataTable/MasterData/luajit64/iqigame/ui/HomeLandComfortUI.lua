-- chunkname: @IQIGame\\UI\\HomeLandComfortUI.lua

local HomeLandComfortUI = Base:Extend("HomeLandComfortUI", "IQIGame.Onigao.UI.HomeLandComfortUI", {})
local HomeLandComfortPageView = require("IQIGame.UI.HomeLandComfort.HomeLandComfortPageView")

function HomeLandComfortUI:OnInit()
	UGUIUtil.SetText(self.TextName, HomeLandComfortUIApi:GetString("TextName", false))
	UGUIUtil.SetText(self.TextNameEng, HomeLandComfortUIApi:GetString("TextName", true))
	UGUIUtil.SetText(self.TextTitle1, HomeLandComfortUIApi:GetString("TextTitle1"))
	UGUIUtil.SetText(self.TextTitle2, HomeLandComfortUIApi:GetString("TextTitle2"))
	UGUIUtil.SetText(self.TextDes, HomeLandComfortUIApi:GetString("TextDes"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnLeftComponent = self.BtnLeft:GetComponent("Button")
	self.btnRightComponent = self.BtnRight:GetComponent("Button")
	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateOnBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	function self.delegateUpdateBaseInfo()
		self:UpDataBaseInfo()
	end

	self.cfgDateTab = {}

	for i, v in pairsCfg(CfgHomeLandComfortTable) do
		table.insert(self.cfgDateTab, v)
	end

	table.sort(self.cfgDateTab, function(a, b)
		return a.Id < b.Id
	end)
end

function HomeLandComfortUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandComfortUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandComfortUI:OnOpen(userData)
	self.currentStateInfo, self.currentIndex = self:GetData()

	self:RefreshList(self.currentIndex)
end

function HomeLandComfortUI:OnClose(userData)
	return
end

function HomeLandComfortUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateOnBtnClose)
	self.btnLeftComponent.onClick:AddListener(self.delegateBtnLeft)
	self.btnRightComponent.onClick:AddListener(self.delegateBtnRight)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
end

function HomeLandComfortUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateOnBtnClose)
	self.btnLeftComponent.onClick:RemoveListener(self.delegateBtnLeft)
	self.btnRightComponent.onClick:RemoveListener(self.delegateBtnRight)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdateBaseInfo, self.delegateUpdateBaseInfo)
end

function HomeLandComfortUI:OnPause()
	return
end

function HomeLandComfortUI:OnResume()
	return
end

function HomeLandComfortUI:OnCover()
	return
end

function HomeLandComfortUI:OnReveal()
	return
end

function HomeLandComfortUI:OnRefocus(userData)
	return
end

function HomeLandComfortUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandComfortUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandComfortUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandComfortUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandComfortUI:OnDestroy()
	HomeLandComfortPageView.DisposeIn(self)
end

function HomeLandComfortUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandComfortUI)
end

function HomeLandComfortUI:UpDataBaseInfo()
	self:RefreshList(self.currentIndex)
end

function HomeLandComfortUI:ShowCurrentPage()
	self.BtnLeft:SetActive(self.currentIndex > 1)

	if self.currentIndex > 1 then
		local stateInfo, index = self:GetData(self.currentIndex - 1)
		local rewardState = HomeLandLuaModule.GetRewardState(stateInfo.Id)

		self.RedLeft:SetActive(rewardState == 2)
	end

	self.BtnRight:SetActive(self.currentIndex < #self.cfgDateTab)

	if self.currentIndex < #self.cfgDateTab then
		local stateInfo, index = self:GetData(self.currentIndex + 1)
		local rewardState = HomeLandLuaModule.GetRewardState(stateInfo.Id)

		self.RedRight:SetActive(rewardState == 2)
	end
end

function HomeLandComfortUI:GetData(index)
	local currentSate, currentIndex

	if index == nil then
		local currentComfort = HomeLandLuaModule.homeLandBaseInfo.currentComfort

		for i = 1, #self.cfgDateTab do
			local cfgInfo = self.cfgDateTab[i]

			if currentComfort >= cfgInfo.ComfortInterval then
				currentSate = cfgInfo
				currentIndex = i
			end
		end
	else
		currentIndex = index

		if currentIndex <= #self.cfgDateTab then
			currentSate = self.cfgDateTab[currentIndex]
		end
	end

	return currentSate, currentIndex
end

function HomeLandComfortUI:OnBtnLeft()
	self.currentIndex = self.currentIndex - 1
	self.currentIndex = self.currentIndex <= 0 and 1 or self.currentIndex

	self.scrollList:TurnToBackward()
end

function HomeLandComfortUI:OnBtnRight()
	self.currentIndex = self.currentIndex + 1

	local totalPage = #self.cfgDateTab

	self.currentIndex = totalPage < self.currentIndex and totalPage or self.currentIndex

	self.scrollList:TurnToForward()
end

function HomeLandComfortUI:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex - 1

	self.scrollList:Refresh(#self.cfgDateTab)
end

function HomeLandComfortUI:OnRenderCell(pageCell)
	local goObj = pageCell.gameObject

	goObj:SetActive(true)

	local index = pageCell.index + 1
	local stateInfo, indexTab = self:GetData(index)
	local page = HomeLandComfortPageView.PackageOrReuseView(self, goObj)

	page:SetData(stateInfo)
end

function HomeLandComfortUI:OnPageReachedMain(page)
	local index = page.index + 1

	self.currentStateInfo, self.currentIndex = self:GetData(index)

	local page = HomeLandComfortPageView.PackageOrReuseView(self, page.transform:GetChild(0).gameObject)

	page:SetData(self.currentStateInfo)
	self:ShowCurrentPage()
end

return HomeLandComfortUI
