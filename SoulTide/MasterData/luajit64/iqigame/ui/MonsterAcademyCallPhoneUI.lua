-- chunkname: @IQIGame\\UI\\MonsterAcademyCallPhoneUI.lua

local MonsterAcademyCallPhoneUI = {}

MonsterAcademyCallPhoneUI = Base:Extend("MonsterAcademyCallPhoneUI", "IQIGame.Onigao.UI.MonsterAcademyCallPhoneUI", MonsterAcademyCallPhoneUI)

require("IQIGame.UIExternalApi.MonsterAcademyCallPhoneUIApi")

function MonsterAcademyCallPhoneUI:OnInit()
	UGUIUtil.SetText(self.TitleText, MonsterAcademyCallPhoneUIApi:GetString("TitleText"))
	UGUIUtil.SetText(self.TextDes, MonsterAcademyCallPhoneUIApi:GetString("TextDes"))
	UGUIUtil.SetTextInChildren(self.BtnHangUp, MonsterAcademyCallPhoneUIApi:GetString("BtnHangUpLabel"))
	UGUIUtil.SetTextInChildren(self.BtnAnswer, MonsterAcademyCallPhoneUIApi:GetString("BtnAnswerLabel"))

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateBtnHangUp()
		self:OnBtnHangUp()
	end

	function self.DelegateBtnAnswer()
		self:OnBtnAnswer()
	end
end

function MonsterAcademyCallPhoneUI:GetPreloadAssetPaths()
	return nil
end

function MonsterAcademyCallPhoneUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MonsterAcademyCallPhoneUI:IsManualShowOnOpen(userData)
	return false
end

function MonsterAcademyCallPhoneUI:GetBGM(userData)
	return nil
end

function MonsterAcademyCallPhoneUI:OnOpen(userData)
	self.girlID = userData

	self:UpdateView()
end

function MonsterAcademyCallPhoneUI:OnClose(userData)
	return
end

function MonsterAcademyCallPhoneUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnHangUp:GetComponent("Button").onClick:AddListener(self.DelegateBtnHangUp)
	self.BtnAnswer:GetComponent("Button").onClick:AddListener(self.DelegateBtnAnswer)
end

function MonsterAcademyCallPhoneUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnHangUp:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHangUp)
	self.BtnAnswer:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnAnswer)
end

function MonsterAcademyCallPhoneUI:OnPause()
	return
end

function MonsterAcademyCallPhoneUI:OnResume()
	return
end

function MonsterAcademyCallPhoneUI:OnCover()
	return
end

function MonsterAcademyCallPhoneUI:OnReveal()
	return
end

function MonsterAcademyCallPhoneUI:OnRefocus(userData)
	return
end

function MonsterAcademyCallPhoneUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MonsterAcademyCallPhoneUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MonsterAcademyCallPhoneUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MonsterAcademyCallPhoneUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MonsterAcademyCallPhoneUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function MonsterAcademyCallPhoneUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function MonsterAcademyCallPhoneUI:UpdateView()
	local cfg = CfgGalgameMonsterGirlListTable[self.girlID]
	local path = UIGlobalApi.GetImagePath(cfg.HeadPortrait)

	AssetUtil.LoadImage(self, path, self.ImgHeadIcon:GetComponent("Image"))
	UGUIUtil.SetText(self.TextName, cfg.Name)
end

function MonsterAcademyCallPhoneUI:OnBtnHangUp()
	MonsterAcademyModule.CallFromGirl(self.girlID, 0)
	self:OnClickCloseBtn()
end

function MonsterAcademyCallPhoneUI:OnBtnAnswer()
	MonsterAcademyModule.CallFromGirl(self.girlID, 1)
	self:OnClickCloseBtn()
end

return MonsterAcademyCallPhoneUI
