-- chunkname: @IQIGame\\UI\\ChatRoomUI.lua

local ChatRoomUI = Base:Extend("ChatRoomUI", "IQIGame.Onigao.UI.ChatRoomUI", {})

function ChatRoomUI:OnInit()
	LuaCodeInterface.BindOutlet(self.CloseBtn, self)

	self.CloseBtn = self.CloseBtn:GetComponent("Button")
	self.SendBtn = self.EnterBtn:GetComponent("Button")
	self.InfoInputField = self.InfoInput:GetComponent("IQIGame.Onigao.Game.UI.InputField")
	self.ContentText = self.ContentInputText:GetComponent("Text")

	function self.DelegateCloseBtn()
		UIModule.Close(Constant.UIControllerName.ChatRoomUI)
	end

	function self.DelegateSendBtn()
		self:SendBtnClick()
	end
end

function ChatRoomUI:GetPreloadAssetPaths()
	return nil
end

function ChatRoomUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChatRoomUI:IsManualShowOnOpen(userData)
	return false
end

function ChatRoomUI:GetBGM(userData)
	return nil
end

function ChatRoomUI:OnOpen(userData)
	return
end

function ChatRoomUI:OnClose(userData)
	return
end

function ChatRoomUI:OnAddListeners()
	self.CloseBtn.onClick:AddListener(self.DelegateCloseBtn)
	self.SendBtn.onClick:AddListener(self.DelegateSendBtn)
end

function ChatRoomUI:OnRemoveListeners()
	self.CloseBtn.onClick:RemoveListener(self.DelegateCloseBtn)
	self.SendBtn.onClick:RemoveListener(self.DelegateSendBtn)
end

function ChatRoomUI:OnPause()
	return
end

function ChatRoomUI:OnResume()
	return
end

function ChatRoomUI:OnCover()
	return
end

function ChatRoomUI:OnReveal()
	return
end

function ChatRoomUI:OnRefocus(userData)
	return
end

function ChatRoomUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChatRoomUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChatRoomUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChatRoomUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChatRoomUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function ChatRoomUI:SendBtnClick()
	if self.InfoInputField.text == nil or self.InfoInputField.text == "" then
		return
	end

	local CChatPOD = {}

	CChatPOD.channel = 3
	CChatPOD.type = 1
	CChatPOD.target = ""
	CChatPOD.content = tostring(self.InfoInputField.text)

	net_centerChat.sendChat(CChatPOD)
end

return ChatRoomUI
