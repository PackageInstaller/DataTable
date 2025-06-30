-- chunkname: @IQIGame\\UI\\LibraryEquipInfoUI.lua

local LibraryEquipInfoUI = Base:Extend("LibraryEquipInfoUI", "IQIGame.Onigao.UI.LibraryEquipInfoUI", {})
local LibraryEquipInfoView = require("IQIGame.UI.Library.LibraryEquipInfoView")

function LibraryEquipInfoUI:OnInit()
	function self.delegateClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	self.equipInfoView = LibraryEquipInfoView.New(self.EquipInfo, self)
end

function LibraryEquipInfoUI:GetPreloadAssetPaths()
	return nil
end

function LibraryEquipInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryEquipInfoUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryEquipInfoUI:GetBGM(userData)
	return nil
end

function LibraryEquipInfoUI:OnOpen(userData)
	self.equipTab = userData[1]
	self.index = userData[2]
	self.selectEquipData = self.equipTab[self.index]

	self:UpdateView()
	self.equipInfoView:Open()
end

function LibraryEquipInfoUI:OnClose(userData)
	self.equipInfoView:Close()
end

function LibraryEquipInfoUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
end

function LibraryEquipInfoUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
end

function LibraryEquipInfoUI:OnPause()
	return
end

function LibraryEquipInfoUI:OnResume()
	return
end

function LibraryEquipInfoUI:OnCover()
	return
end

function LibraryEquipInfoUI:OnReveal()
	return
end

function LibraryEquipInfoUI:OnRefocus(userData)
	return
end

function LibraryEquipInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryEquipInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryEquipInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryEquipInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryEquipInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.equipInfoView:Dispose()
end

function LibraryEquipInfoUI:UpdateView()
	self.BtnLeft:SetActive(self.index ~= 1)
	self.BtnRight:SetActive(self.index ~= #self.equipTab)
	self.Lock:SetActive(not self.selectEquipData.isLock)
	UGUIUtil.SetText(self.EquipName, self.selectEquipData.cfgInfo.Name)
	UGUIUtil.SetText(self.EquipType, LibraryEquipApi:GetString("EquipType", self.selectEquipData.cfgInfo.Quality))

	local typePath = LibraryEquipApi:GetString("EquipTypePath", self.selectEquipData.cfgInfo.Quality)

	AssetUtil.LoadImage(self, typePath, self.EquipTypeIcon:GetComponent("Image"))
	self.EquipIcon:GetComponent("GrayComponent"):SetGray(not self.selectEquipData.isLock)

	local iconPath = UIGlobalApi.GetImagePath(self.selectEquipData.cfgInfo.Drawing)

	AssetUtil.LoadImage(self, iconPath, self.EquipIcon:GetComponent("Image"))
	self.equipInfoView:UpdateView(self.selectEquipData)
end

function LibraryEquipInfoUI:ChangeSkinMsg(skinData)
	if skinData then
		UGUIUtil.SetText(self.EquipName, skinData.Name)

		local iconPath = UIGlobalApi.GetImagePath(skinData.Drawing)

		AssetUtil.LoadImage(self, iconPath, self.EquipIcon:GetComponent("Image"))
	else
		UGUIUtil.SetText(self.EquipName, self.selectEquipData.cfgInfo.Name)

		local iconPath = UIGlobalApi.GetImagePath(self.selectEquipData.cfgInfo.Drawing)

		AssetUtil.LoadImage(self, iconPath, self.EquipIcon:GetComponent("Image"))
	end
end

function LibraryEquipInfoUI:OnBtnRight()
	self.index = self.index + 1

	if self.index > #self.equipTab then
		self.index = #self.equipTab
	end

	self.selectEquipData = self.equipTab[self.index]

	self:UpdateView()
end

function LibraryEquipInfoUI:OnBtnLeft()
	self.index = self.index - 1

	if self.index < 1 then
		self.index = 1
	end

	self.selectEquipData = self.equipTab[self.index]

	self:UpdateView()
end

function LibraryEquipInfoUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryEquipInfoUI)
end

return LibraryEquipInfoUI
