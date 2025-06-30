-- chunkname: @IQIGame\\UI\\GirlMoodUI.lua

local GirlMoodUI = Base:Extend("GirlMoodUI", "IQIGame.Onigao.UI.GirlMoodUI", {})

function GirlMoodUI:OnInit()
	UGUIUtil.SetText(self.TextBtnSetMood, GirlMoodUINoticeUIApi:GetString("TextBtnSetMood"))
	UGUIUtil.SetText(self.TextTitle1, GirlMoodUINoticeUIApi:GetString("TextTitle1"))
	UGUIUtil.SetText(self.TextDes1_Title_1, GirlMoodUINoticeUIApi:GetString("TextDes1_Title_1"))
	UGUIUtil.SetText(self.TextDes1_Title_2, GirlMoodUINoticeUIApi:GetString("TextDes1_Title_2"))
	UGUIUtil.SetText(self.TextDes2_Title_1, GirlMoodUINoticeUIApi:GetString("TextDes2_Title_1"))
	UGUIUtil.SetText(self.TextDes2_Title_2, GirlMoodUINoticeUIApi:GetString("TextDes2_Title_2"))
	UGUIUtil.SetText(self.TextDes1, GirlMoodUINoticeUIApi:GetString("TextDes1"))
	UGUIUtil.SetText(self.TextDes2, GirlMoodUINoticeUIApi:GetString("TextDes2"))

	function self.delegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.delegateBtnSetMood()
		self:OnBtnSetMood()
	end
end

function GirlMoodUI:GetPreloadAssetPaths()
	return nil
end

function GirlMoodUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GirlMoodUI:OnOpen(userData)
	self.BtnMood:SetActive(false)

	self.soulDate = userData

	self:UpdateView()
end

function GirlMoodUI:OnClose(userData)
	return
end

function GirlMoodUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateOnClickCloseBtn)
	self.BtnMood:GetComponent("Button").onClick:AddListener(self.delegateBtnSetMood)
end

function GirlMoodUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickCloseBtn)
	self.BtnMood:GetComponent("Button").onClick:RemoveListener(self.delegateBtnSetMood)
end

function GirlMoodUI:OnPause()
	return
end

function GirlMoodUI:OnResume()
	return
end

function GirlMoodUI:OnCover()
	return
end

function GirlMoodUI:OnReveal()
	return
end

function GirlMoodUI:OnRefocus(userData)
	return
end

function GirlMoodUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GirlMoodUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GirlMoodUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GirlMoodUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GirlMoodUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GirlMoodUI:UpdateView()
	if self.soulDate then
		UGUIUtil.SetText(self.TextTitle, self.soulDate:GetCfgSoul().Name)

		local state = SoulModule.GetMoodState(self.soulDate.soulCid, self.soulDate.mood)
		local stateStr = GirlMoodUINoticeUIApi:GetString("TextState", state)

		UGUIUtil.SetText(self.ContentText, GirlMoodUINoticeUIApi:GetString("TextMood", stateStr))

		local path = GirlMoodUINoticeUIApi:GetString("StatePath", state)

		AssetUtil.LoadImage(self, path, self.ImgIcon:GetComponent("Image"))

		local pathBG = GirlMoodUINoticeUIApi:GetString("StateBGPath", state)

		AssetUtil.LoadImage(self, pathBG, self.ImgBG:GetComponent("Image"))

		local pathTitleBG = GirlMoodUINoticeUIApi:GetString("ImgTitleBG", state)

		AssetUtil.LoadImage(self, pathTitleBG, self.ImgTitleBG:GetComponent("Image"))

		local pathValueBG = GirlMoodUINoticeUIApi:GetString("ImgValueBG", state)

		AssetUtil.LoadImage(self, pathValueBG, self.ImgValueBG:GetComponent("Image"))

		local per = SoulModule.GetMoodPer(self.soulDate.soulCid, self.soulDate.mood)

		self.ImgPer:GetComponent("Image").fillAmount = per

		local cfgMood = self:GetCfgSoulMood(self.soulDate.soulCid)

		UGUIUtil.SetText(self.TextPer, self.soulDate.mood .. "/" .. cfgMood.MoodRange[2])
		UGUIUtil.SetText(self.TextSpeed, GirlMoodUINoticeUIApi:GetString("TextSpeed", self.soulDate.moodTimeInterval))
		UGUIUtil.SetText(self.TextMoodValue, GirlMoodUINoticeUIApi:GetString("TextMoodValue", state))

		if not UIModule.HasUI(Constant.UIControllerName.GirlUI) then
			self.BtnMood:SetActive(true)
		else
			self.BtnMood:SetActive(false)
		end
	end
end

function GirlMoodUI:GetCfgSoulMood(soulCid)
	for i, v in pairsCfg(CfgSoulMoodTable) do
		if v.SoulId == soulCid then
			return v
		end
	end

	return nil
end

function GirlMoodUI:OnBtnSetMood()
	JumpModule.Jump(10708001)
end

function GirlMoodUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.GirlMoodUI)
end

return GirlMoodUI
