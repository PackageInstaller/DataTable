-- chunkname: @IQIGame\\UI\\PlayerLevelUpTipUI.lua

local PlayerLevelUpTipUI = Base:Extend("PlayerLevelUpTipUI", "IQIGame.Onigao.UI.PlayerLevelUpTipUI", {})

function PlayerLevelUpTipUI:OnInit()
	self:Initialize()
end

function PlayerLevelUpTipUI:GetPreloadAssetPaths()
	return nil
end

function PlayerLevelUpTipUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlayerLevelUpTipUI:OnOpen(userData)
	self.userData = userData

	self:Refresh(userData)
end

function PlayerLevelUpTipUI:OnClose(userData)
	self:OnHide()
end

function PlayerLevelUpTipUI:OnPause()
	return
end

function PlayerLevelUpTipUI:OnResume()
	return
end

function PlayerLevelUpTipUI:OnCover()
	return
end

function PlayerLevelUpTipUI:OnReveal()
	return
end

function PlayerLevelUpTipUI:OnRefocus(userData)
	return
end

function PlayerLevelUpTipUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlayerLevelUpTipUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlayerLevelUpTipUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlayerLevelUpTipUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlayerLevelUpTipUI:Initialize()
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onPlayerSomeInfoChangeDelegate(key, value)
		self:OnPlayerSomeInfoChange(key, value)
	end

	self.goBtnClose.transform:Find("Text"):GetComponent("Text").text = PlayerLevelUpTipUIApi:GetString("goBtnClose")
	self.goTitle:GetComponent("Text").text = PlayerLevelUpTipUIApi:GetString("goTitle")
	self.goTitleEng:GetComponent("Text").text = PlayerLevelUpTipUIApi:GetString("goTitleEng")
end

function PlayerLevelUpTipUI:Refresh(userData)
	local cfgDataOld = CfgPlayerLevelTable[userData[1]]
	local cfgDataNew = CfgPlayerLevelTable[userData[2]]

	self:RefreshBlock(self.goOldBlock, cfgDataOld, cfgDataNew)
	self:RefreshBlock(self.goNewBlock, cfgDataNew, cfgDataOld)
end

function PlayerLevelUpTipUI:OnHide()
	return
end

function PlayerLevelUpTipUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function PlayerLevelUpTipUI:RefreshBlock(block, cfgData, sCfgData)
	local imgIcon = block.transform:Find("Icon/Image_Icon"):GetComponent("Image")
	local tfLv = block.transform:Find("Panel/Text_02"):GetComponent("Text")
	local tfLvTitle = block.transform:Find("Panel/Text_01"):GetComponent("Text")
	local tfEnergy = block.transform:Find("Panel/Text_03"):GetComponent("Text")
	local tfTime = block.transform:Find("Panel/Text_04"):GetComponent("Text")
	local starComp = block.transform:Find("Icon/StarGrid"):GetComponent("SimpleStarComponent")

	tfLv.text = PlayerLevelUpTipUIApi:GetString("goLv", cfgData.Id)
	tfLvTitle.text = PlayerLevelUpTipUIApi:GetString("goLvTitle", cfgData.Name)
	tfEnergy.text = PlayerLevelUpTipUIApi:GetString("goEnergy", cfgData.EnergyMax)
	tfTime.text = PlayerLevelUpTipUIApi:GetString("goTime", cfgData.RestTime)

	tfEnergy.gameObject:SetActive(cfgData.EnergyMax ~= sCfgData.EnergyMax)
	tfTime.gameObject:SetActive(cfgData.RestTime ~= sCfgData.RestTime)
	starComp.gameObject:SetActive(false)
	imgIcon.gameObject:SetActive(false)
end

function PlayerLevelUpTipUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.PlayerSomeInfoChange, self.onPlayerSomeInfoChangeDelegate)
end

function PlayerLevelUpTipUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.PlayerSomeInfoChange, self.onPlayerSomeInfoChangeDelegate)
end

function PlayerLevelUpTipUI:OnLoadIconSuccess(assetName, asset, duration, userData)
	userData:SetNativeSize()
end

function PlayerLevelUpTipUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.PlayerLevelUpTipUI)
end

function PlayerLevelUpTipUI:OnPlayerSomeInfoChange(key, value)
	if key == "pLv" then
		self:Refresh({
			self.userData[1],
			value
		})
	end
end

return PlayerLevelUpTipUI
