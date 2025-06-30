-- chunkname: @IQIGame\\UI\\InputPlayerNameTextUI.lua

local InputPlayerNameTextUI = Base:Extend("InputPlayerNameTextUI", "IQIGame.Onigao.UI.InputPlayerNameTextUI", {})

function InputPlayerNameTextUI:OnInit()
	self.TextTitle:GetComponent("Text").text = InputPlayerNameTextUIApi:GetString("TextTitle")
	self.TextTitle1:GetComponent("Text").text = InputPlayerNameTextUIApi:GetString("TextTitle1")
	self.TextBtnTitle:GetComponent("Text").text = InputPlayerNameTextUIApi:GetString("TextBtnTitle")

	function self.delegateBtnRandom()
		self:OnClickBtnRandom()
	end

	function self.delegateBtnLogin()
		self:OnClickBtnLogin()
	end

	function self.delegateOnValueChanged(text)
		self:OnValueChanged(text)
	end
end

function InputPlayerNameTextUI:GetPreloadAssetPaths()
	return nil
end

function InputPlayerNameTextUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function InputPlayerNameTextUI:OnOpen(userData)
	UIModule.Close(Constant.UIControllerName.LoginUI)

	self.maxCharNum = CfgDiscreteDataTable[6520052].Data[1]
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").characterLimit = self.maxCharNum

	self:OnClickBtnRandom()
end

function InputPlayerNameTextUI:OnClose(userData)
	return
end

function InputPlayerNameTextUI:OnAddListeners()
	self.BtnLogin:GetComponent("Button").onClick:AddListener(self.delegateBtnLogin)
	self.BtnRandom:GetComponent("Button").onClick:AddListener(self.delegateBtnRandom)
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:AddListener(self.delegateOnValueChanged)
end

function InputPlayerNameTextUI:OnRemoveListeners()
	self.BtnLogin:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLogin)
	self.BtnRandom:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRandom)
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").onValueChanged:RemoveListener(self.delegateOnValueChanged)
end

function InputPlayerNameTextUI:OnPause()
	return
end

function InputPlayerNameTextUI:OnResume()
	return
end

function InputPlayerNameTextUI:OnCover()
	return
end

function InputPlayerNameTextUI:OnReveal()
	return
end

function InputPlayerNameTextUI:OnRefocus(userData)
	return
end

function InputPlayerNameTextUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function InputPlayerNameTextUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function InputPlayerNameTextUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function InputPlayerNameTextUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function InputPlayerNameTextUI:OnDestroy()
	return
end

function InputPlayerNameTextUI:OnClickBtnRandom()
	local random1 = math.random(1, #CfgRoleRandomNameTable)
	local random2 = math.random(1, #CfgRoleRandomNameTable)
	local random3 = math.random(1, #CfgRoleRandomNameTable)
	local cfgRandom1 = CfgRoleRandomNameTable[random1]
	local cfgRandom2 = CfgRoleRandomNameTable[random2]
	local cfgRandom3 = CfgRoleRandomNameTable[random3]

	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = cfgRandom1.Name1 .. cfgRandom2.Name2 .. cfgRandom3.Name3
end

function InputPlayerNameTextUI:OnValueChanged(text)
	self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").text = string.subUTF8Length(text, 27)
end

function InputPlayerNameTextUI:OnClickBtnLogin()
	local name = self.TextInputName:GetComponent("IQIGame.Onigao.Game.UI.InputField").text

	if name == "" or name == nil then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, SettingPlayerInfoViewApi:GetString("ErrorMsg3"))

		return
	end

	if string.len(name) < 4 then
		NoticeModule.ShowNotice(21041055)

		return
	end

	CreateRoleModule.CreateRole(name)
end

return InputPlayerNameTextUI
