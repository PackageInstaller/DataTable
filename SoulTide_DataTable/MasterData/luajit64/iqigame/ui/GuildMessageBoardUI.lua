-- chunkname: @IQIGame\\UI\\GuildMessageBoardUI.lua

local GuildMessageBoardUI = {
	isEditConfirm = false
}

GuildMessageBoardUI = Base:Extend("GuildMessageBoardUI", "IQIGame.Onigao.UI.GuildMessageBoardUI", GuildMessageBoardUI)

require("IQIGame.UIExternalApi.GuildMessageBoardUIApi")

function GuildMessageBoardUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, GuildMessageBoardUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.PlaceHolder, GuildMessageBoardUIApi:GetString("PlaceHolder"))

	self.InputBoardCom = self.InputField:GetComponent("IQIGame.Onigao.Game.UI.InputField")

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateOnBtnSave()
		self:OnBtnSave()
	end

	function self.DelegateUpdateGuildEvent()
		self:OnUpdateNoticeEvent()
	end

	function self.DelegateUpdateGuildNoticeEvent()
		self:OnUpdateNoticeEvent()
	end
end

function GuildMessageBoardUI:GetPreloadAssetPaths()
	return nil
end

function GuildMessageBoardUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildMessageBoardUI:IsManualShowOnOpen(userData)
	return false
end

function GuildMessageBoardUI:GetBGM(userData)
	return nil
end

function GuildMessageBoardUI:OnOpen(userData)
	self:UpdateView()
end

function GuildMessageBoardUI:OnClose(userData)
	return
end

function GuildMessageBoardUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnSave:GetComponent("Button").onClick:AddListener(self.DelegateOnBtnSave)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateUpdateGuildEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateNoticeEvent, self.DelegateUpdateGuildNoticeEvent)
end

function GuildMessageBoardUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnSave:GetComponent("Button").onClick:RemoveListener(self.DelegateOnBtnSave)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateUpdateGuildEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateNoticeEvent, self.DelegateUpdateGuildNoticeEvent)
end

function GuildMessageBoardUI:OnPause()
	return
end

function GuildMessageBoardUI:OnResume()
	return
end

function GuildMessageBoardUI:OnCover()
	return
end

function GuildMessageBoardUI:OnReveal()
	return
end

function GuildMessageBoardUI:OnRefocus(userData)
	return
end

function GuildMessageBoardUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.InputBoardCom.isFocused ~= self.isEditConfirm then
		self.isEditConfirm = self.InputBoardCom.isFocused

		if self.isEditConfirm == true then
			self.BtnSave:SetActive(true)
		end
	end
end

function GuildMessageBoardUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildMessageBoardUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildMessageBoardUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildMessageBoardUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function GuildMessageBoardUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function GuildMessageBoardUI:OnUpdateNoticeEvent()
	self:UpdateView()
end

function GuildMessageBoardUI:UpdateView()
	self.BtnSave:SetActive(false)

	self.InputBoardCom.interactable = not GuildModule.guildPOD.banNotice

	if GuildModule.guildPOD.banNotice then
		self.InputBoardCom.text = GuildMainUIApi:GetString("BanNotice")
	else
		self.InputBoardCom.text = GuildModule.guildPOD.notice
	end
end

function GuildMessageBoardUI:OnBtnSave()
	local strValue = self.InputBoardCom.text

	if strValue == nil or strValue == "" then
		self.PlaceHolder:SetActive(true)
		NoticeModule.ShowNotice(21066714)

		return
	end

	GuildModule.EditNotice(strValue)
end

return GuildMessageBoardUI
