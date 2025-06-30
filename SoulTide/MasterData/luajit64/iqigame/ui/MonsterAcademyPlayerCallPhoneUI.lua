-- chunkname: @IQIGame\\UI\\MonsterAcademyPlayerCallPhoneUI.lua

local MonsterAcademyPlayerCallPhoneUI = {}

MonsterAcademyPlayerCallPhoneUI = Base:Extend("MonsterAcademyPlayerCallPhoneUI", "IQIGame.Onigao.UI.MonsterAcademyPlayerCallPhoneUI", MonsterAcademyPlayerCallPhoneUI)

require("IQIGame.UIExternalApi.MonsterAcademyPlayerCallPhoneUIApi")

function MonsterAcademyPlayerCallPhoneUI:OnInit()
	UGUIUtil.SetText(self.TextDes, MonsterAcademyPlayerCallPhoneUIApi:GetString("TextDes"))
	UGUIUtil.SetTextInChildren(self.BtnHangUp, MonsterAcademyPlayerCallPhoneUIApi:GetString("BtnHangUpLabel"))

	function self.DelegateOnClickBtnHangUp()
		self:OnClickBtnHangUp()
	end
end

function MonsterAcademyPlayerCallPhoneUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyPlayerCallPhoneUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyPlayerCallPhoneUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyPlayerCallPhoneUI:GetBGM(userData)
	return nil
end

function MonsterAcademyPlayerCallPhoneUI:OnOpen(userData)
	self.girlID = userData.GirlID
	self.functionID = userData.FunctionCid

	self:UpdateView()
end

function MonsterAcademyPlayerCallPhoneUI:OnClose(userData)
	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil
end

function MonsterAcademyPlayerCallPhoneUI:OnAddListeners()
	self.BtnHangUp:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnHangUp)
end

function MonsterAcademyPlayerCallPhoneUI:OnRemoveListeners()
	self.BtnHangUp:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnHangUp)
end

function MonsterAcademyPlayerCallPhoneUI:OnPause()
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnResume()
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnCover()
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnReveal()
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnRefocus(userData)
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyPlayerCallPhoneUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function MonsterAcademyPlayerCallPhoneUI:UpdateView()
	local cfg = CfgGalgameMonsterGirlListTable[self.girlID]
	local path = UIGlobalApi.GetImagePath(cfg.HeadPortrait)

	AssetUtil.LoadImage(self, path, self.ImgHeadIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfg.Name)

	self.timer = Timer.New(function()
		MonsterAcademyModule.ExecutionAreaFunctionOption(self.functionID, nil, self.girlID)
		UIModule.CloseSelf(self)
	end, 5)

	self.timer:Start()
end

function MonsterAcademyPlayerCallPhoneUI:OnClickBtnHangUp()
	UIModule.CloseSelf(self)
end

return MonsterAcademyPlayerCallPhoneUI
