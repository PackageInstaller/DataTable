-- chunkname: @IQIGame\\UI\\BuffTipsUI.lua

local BuffTipsUI = Base:Extend("BuffTipsUI", "IQIGame.Onigao.UI.BuffTipsUI", {})
local BuffInfoCell = require("IQIGame.UI.Tips.BuffInfoCell")
local BuffTipContent = require("IQIGame.UI.Tips.BuffTipContent")

function BuffTipsUI:OnInit()
	self:Initialize()
end

function BuffTipsUI:GetPreloadAssetPaths()
	return nil
end

function BuffTipsUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BuffTipsUI:OnOpen(userData)
	self:Refresh(userData)
end

function BuffTipsUI:OnClose(userData)
	return
end

function BuffTipsUI:OnAddListeners()
	self.goBtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.goBtnRemove:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRemove)
	EventDispatcher.AddEventListener(EventID.ClearSanBuffSuccess, self.onClearSanBuffSuccessDelegate)
end

function BuffTipsUI:OnRemoveListeners()
	self.goBtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.goBtnRemove:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRemove)
	EventDispatcher.RemoveEventListener(EventID.ClearSanBuffSuccess, self.onClearSanBuffSuccessDelegate)
end

function BuffTipsUI:OnPause()
	return
end

function BuffTipsUI:OnResume()
	return
end

function BuffTipsUI:OnCover()
	return
end

function BuffTipsUI:OnReveal()
	return
end

function BuffTipsUI:OnRefocus(userData)
	return
end

function BuffTipsUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function BuffTipsUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BuffTipsUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BuffTipsUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BuffTipsUI:OnDestroy()
	self.content:Dispose()
	self.infoCell:OnDestroy()
end

function BuffTipsUI:Initialize()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnClickBtnRemove()
		self:OnClickBtnRemove()
	end

	self.infoCell = BuffInfoCell.New(self.goSlotParent.transform:GetChild(0).gameObject)
	self.scrollRect = self.goScrollRect:GetComponent("ScrollRect")

	local go = self.scrollRect.viewport:GetChild(0).gameObject

	self.scrollRect.content = go:GetComponent("RectTransform")
	self.content = BuffTipContent.New(go)

	function self.onClearSanBuffSuccessDelegate(buffCid, dollId)
		self:OnClearSanBuffSuccess(buffCid, dollId)
	end

	self.goViewTitle:GetComponent("Text").text = BuffTipsUIApi:GetString("goTipsTitle")
	self.goBtnRemove.transform:Find("Text_1"):GetComponent("Text").text = BuffTipsUIApi:GetString("goBtnClearTxt")
end

function BuffTipsUI:Refresh(userData)
	self.cfgBuffData = CfgBuffTable[userData[1]]
	self.layers = userData[2]
	self.puppetData = userData[3]

	self:RefreshMisc()
	self:RefreshBtnVisible()
end

function BuffTipsUI:RefreshMisc()
	self.infoCell:Refresh(self.cfgBuffData, self.layers)
	self.content:Refresh(self.cfgBuffData, self.puppetData)
end

function BuffTipsUI:RefreshBtnVisible()
	self.goBtnRemove:SetActive(false)

	if PlayerModule.InMaze == false and self.cfgBuffData.Tag == 5 then
		self.goBtnRemove:SetActive(true)
	end
end

function BuffTipsUI:OnClickBtnClose()
	UIModule.Close(Constant.UIControllerName.BuffTipsUI)
end

function BuffTipsUI:OnClickBtnRemove()
	return
end

function BuffTipsUI:OnClearSanBuffSuccess(buffCid, dollId)
	self:OnClickBtnClose()
end

return BuffTipsUI
