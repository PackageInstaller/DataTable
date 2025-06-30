-- chunkname: @IQIGame\\UI\\InputTextUI.lua

local InputTextUI = Base:Extend("InputTextUI", "IQIGame.Onigao.UI.InputTextUI", {})

function InputTextUI:OnInit()
	function self.DelegateOnClickYesBtn()
		self:OnClickYesBtn()
	end

	function self.DelegateOnClickNoBtn()
		self:OnClickNoBtn()
	end

	UGUIUtil.SetText(self.TitleText, InputTextUIApi:GetString("TitleText"))
	UGUIUtil.SetTextInChildren(self.YesBtn, InputTextUIApi:GetString("YesBtnText"))
	UGUIUtil.SetTextInChildren(self.NoBtn, InputTextUIApi:GetString("NoBtnText"))
end

function InputTextUI:GetPreloadAssetPaths()
	return nil
end

function InputTextUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function InputTextUI:OnOpen(userData)
	self.YesCallback = userData.yes
	self.NoCallback = userData.no

	if userData.defaultTxt ~= nil then
		self.InputText:GetComponent("IQIGame.Onigao.Game.UI.InputField").placeholder.text = userData.defaultTxt
	end
end

function InputTextUI:OnClose(userData)
	self.InputText:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = ""
end

function InputTextUI:OnPause()
	return
end

function InputTextUI:OnResume()
	return
end

function InputTextUI:OnCover()
	return
end

function InputTextUI:OnReveal()
	return
end

function InputTextUI:OnRefocus(userData)
	return
end

function InputTextUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function InputTextUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function InputTextUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function InputTextUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function InputTextUI:OnDestroy()
	return
end

function InputTextUI:OnAddListeners()
	self.YesBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickYesBtn)
	self.NoBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNoBtn)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNoBtn)
end

function InputTextUI:OnRemoveListeners()
	self.YesBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickYesBtn)
	self.NoBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNoBtn)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNoBtn)
end

function InputTextUI:OnClickYesBtn()
	local inputFieldText = self.InputText:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if string.match(inputFieldText, "[%s%p%c]") then
		NoticeModule.ShowNotice(21046002)

		return
	end

	SDKLoginModule.checkDirtyWords(inputFieldText, function(hasDirtyWord, replaceContent)
		if hasDirtyWord then
			NoticeModule.ShowNotice(21046001)

			return
		end

		UIModule.CloseSelf(self)

		if self.YesCallback ~= nil then
			self.YesCallback(inputFieldText)
		end
	end)
end

function InputTextUI:OnClickNoBtn()
	UIModule.CloseSelf(self)

	if self.NoCallback ~= nil then
		self.NoCallback()
	end
end

return InputTextUI
