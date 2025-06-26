-- chunkname: @IQIGame\\UI\\WebNoticeUI.lua

local WebNoticeUI = {
	TabToggles = {}
}

WebNoticeUI = Base:Extend("WebNoticeUI", "IQIGame.Onigao.UI.WebNoticeUI", WebNoticeUI)

local WebNoticeTabController = require("IQIGame.UI.WebNotice.WebNoticeTabController")

function WebNoticeUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, NoticeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextTitleEng, NoticeUIApi:GetString("TextTitleEng"))
	UGUIUtil.SetText(self.TextBtn, NoticeUIApi:GetString("TextBtn"))

	self.btnCloseComponent = self.BtnClose:GetComponent("Button")

	function self.delegateBtnClose()
		self:OnClickBtnClose()
	end

	local scrollAreaList = self.TabGrid:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderTab(cell)
	end

	function scrollAreaList.onSelectedCell(cell)
		self:OnSelectTab(cell)
	end
end

function WebNoticeUI:GetPreloadAssetPaths()
	return nil
end

function WebNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function WebNoticeUI:IsManualShowOnOpen(userData)
	return false
end

function WebNoticeUI:GetBGM(userData)
	return nil
end

function WebNoticeUI:OnOpen(userData)
	UIModule.canPopTopConfirm = false
	self.NoticeDataList = userData.notices
	self.OnCloseCallback = userData.OnCloseCallback

	table.sort(self.NoticeDataList, function(data1, data2)
		return data1.sort > data2.sort
	end)

	local scrollAreaList = self.TabGrid:GetComponent("ScrollAreaList")

	scrollAreaList.defaultSelectedToggle = 0

	scrollAreaList:Refresh(#self.NoticeDataList)
end

function WebNoticeUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
end

function WebNoticeUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
end

function WebNoticeUI:OnClickBtnClose()
	UIModule.CloseSelf(self)

	if self.OnCloseCallback ~= nil then
		self.OnCloseCallback()
	end
end

function WebNoticeUI:OnClose(userData)
	if self.UniWebViewClone ~= nil then
		UnityEngine.GameObject.Destroy(self.UniWebViewClone)

		self.UniWebViewClone = nil
	end

	UIModule.canPopTopConfirm = true
end

function WebNoticeUI:OnPause()
	return
end

function WebNoticeUI:OnResume()
	return
end

function WebNoticeUI:OnCover()
	return
end

function WebNoticeUI:OnReveal()
	return
end

function WebNoticeUI:OnRefocus(userData)
	return
end

function WebNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function WebNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function WebNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function WebNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function WebNoticeUI:OnDestroy()
	for gameObject, tabToggle in pairs(self.TabToggles) do
		tabToggle:Dispose()
	end

	self.TabToggles = nil
end

function WebNoticeUI:OnRenderTab(cell)
	local tab = self.TabToggles[cell.gameObject]

	if tab == nil then
		tab = WebNoticeTabController.New(cell.gameObject)
		self.TabToggles[cell.gameObject] = tab
	end

	tab:SetData(self.NoticeDataList[cell.index + 1])
end

function WebNoticeUI:OnSelectTab(cell)
	self:ShowTab(cell.index + 1)
end

function WebNoticeUI:ShowTab(index)
	local noticeData = self.NoticeDataList[index]

	if IQIGame.Onigao.Game.Device.isMobile then
		if self.UniWebViewClone ~= nil then
			UnityEngine.GameObject.Destroy(self.UniWebViewClone)
		end

		self.UniWebViewClone = UnityEngine.Object.Instantiate(self.UniWebView)

		self.UniWebViewClone.transform:SetParent(self.UniWebViewPanel.transform, false)

		local uniWebViewCom = self.UniWebViewClone:GetComponent("UniWebView")

		uniWebViewCom:SetZoomEnabled(true)
		uniWebViewCom:SetBackButtonEnabled(false)
		uniWebViewCom:LoadHTMLString(noticeData.content, "", false)
		uniWebViewCom:Show()
		uniWebViewCom:UpdateFrame()
	else
		UGUIUtil.SetText(self.TextContent, noticeData.content)
	end
end

return WebNoticeUI
