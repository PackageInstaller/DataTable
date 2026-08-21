-- chunkname: @IQIGame\\UI\\UnlockSkillNoticeUI.lua

local UnlockSkillNoticeUI = Base:Extend("UnlockSkillNoticeUI", "IQIGame.Onigao.UI.UnlockSkillNoticeUI", {})

function UnlockSkillNoticeUI:OnInit()
	self:Initialize()
end

function UnlockSkillNoticeUI:GetPreloadAssetPaths()
	return nil
end

function UnlockSkillNoticeUI:GetOpenPreloadAssetPaths(userData)
	return self:GetPreloadPathsOnOpen(userData)
end

function UnlockSkillNoticeUI:OnOpen(userData)
	self:Refresh(userData)
end

function UnlockSkillNoticeUI:OnClose(userData)
	self:OnHide()
end

function UnlockSkillNoticeUI:OnPause()
	return
end

function UnlockSkillNoticeUI:OnResume()
	return
end

function UnlockSkillNoticeUI:OnCover()
	return
end

function UnlockSkillNoticeUI:OnReveal()
	return
end

function UnlockSkillNoticeUI:OnRefocus(userData)
	return
end

function UnlockSkillNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function UnlockSkillNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function UnlockSkillNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function UnlockSkillNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function UnlockSkillNoticeUI:GetPreloadPathsOnOpen(userData)
	self.cfgSkillData = CfgSkillTable[userData.skillId]
	self.soulData = userData.soulData

	local ret = {}

	ret[#ret + 1] = UIGlobalApi.ImagePath .. self.soulData:GetCfgSoulRes3D().HeadIcon

	if self.cfgSkillData.Icon ~= "" and self.cfgSkillData.Icon ~= nil then
		ret[#ret + 1] = UIGlobalApi.GetIconPath(self.cfgSkillData.Icon)
	end

	return ret
end

function UnlockSkillNoticeUI:Initialize()
	self.tfName = self.goName:GetComponent("Text")
	self.tfType = self.goSkillType:GetComponent("Text")
	self.tfReleaseType = self.goReleaseType:GetComponent("Text")
	self.tfAnger = self.goAnger:GetComponent("Text")
	self.tfCd = self.goCd:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onCloseBigFloatNoticeUIDelegate()
		self:OnCloseBigFloatNoticeUI()
	end

	self.skillCell = SkillCell.PackageOrReuseView(self, self.goSkillCell)
	self.headCell = SoulHeadCell.New(self.goHeadCell)
	self.goTitle:GetComponent("Text").text = UnlockSkillNoticeUIApi:GetString("goTitle")
	self.goSignNew:GetComponent("Text").text = UnlockSkillNoticeUIApi:GetString("goSignNew")
end

function UnlockSkillNoticeUI:Refresh(userData)
	self:RefreshMisc()

	self.delayCloseTimer = Timer.New(function()
		self:OnDelayCloseTimer()
	end, 3)

	self.delayCloseTimer:Start()
end

function UnlockSkillNoticeUI:OnHide()
	self:StopDelayCloseTimer()
end

function UnlockSkillNoticeUI:OnDestroy()
	self.skillCell:Dispose()
	self.headCell:Dispose()
end

function UnlockSkillNoticeUI:OnAddListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	EventDispatcher.AddEventListener(EventID.CloseBigFloatNoticeUI, self.onCloseBigFloatNoticeUIDelegate)
end

function UnlockSkillNoticeUI:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	EventDispatcher.RemoveEventListener(EventID.CloseBigFloatNoticeUI, self.onCloseBigFloatNoticeUIDelegate)
end

function UnlockSkillNoticeUI:OnClickBtnClose()
	EventDispatcher.Dispatch(EventID.CloseBigFloatNoticeUI)
end

function UnlockSkillNoticeUI:OnCloseBigFloatNoticeUI()
	UIModule.Close(Constant.UIControllerName.UnlockSkillNoticeUI)
end

function UnlockSkillNoticeUI:OnDelayCloseTimer()
	UIModule.Close(Constant.UIControllerName.UnlockSkillNoticeUI)
end

function UnlockSkillNoticeUI:RefreshMisc()
	self.tfName.text = SkillTipApi:GetString("goName", self.cfgSkillData.Name)
	self.tfReleaseType.text = SkillTipApi:GetString("goReleaseType", self.cfgSkillData.ReleaseType)

	local cfgSkillDetailData = CfgSkillDetailTable[self.cfgSkillData.SkillDetail]

	self.tfCd.text = SkillTipApi:GetString("goCd", cfgSkillDetailData.CoolDown)
	self.tfAnger.text = SkillTipApi:GetString("goAnger", cfgSkillDetailData.CostEnergy)

	local isShow = SkillTipApi:GetString("showSkillType", self.cfgSkillData.ShowType)

	self.goSkillType.transform.parent.gameObject:SetActive(isShow)

	if isShow then
		self.tfType.text = SkillTipApi:GetString("goSkillTypeTxtInCellInfo", self.cfgSkillData.ShowType)
	end

	self.skillCell:SetSkill(self.cfgSkillData.Id, self.soulData)
	self.headCell:RefreshView(self.soulData)
end

function UnlockSkillNoticeUI:StopDelayCloseTimer()
	if self.delayCloseTimer ~= nil then
		self.delayCloseTimer:Stop()

		self.delayCloseTimer = nil
	end
end

return UnlockSkillNoticeUI
