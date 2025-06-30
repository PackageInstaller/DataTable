-- chunkname: @IQIGame\\UI\\HorizontalRPGChatDialogUI.lua

local HorizontalRPGChatDialogUI = {}

HorizontalRPGChatDialogUI = Base:Extend("HorizontalRPGChatDialogUI", "IQIGame.Onigao.UI.HorizontalRPGChatDialogUI", HorizontalRPGChatDialogUI)

function HorizontalRPGChatDialogUI:OnInit()
	function self.DelegateOnClickBtnNext()
		self:OnClickBtnNext()
	end
end

function HorizontalRPGChatDialogUI:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGChatDialogUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGChatDialogUI:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGChatDialogUI:GetBGM(userData)
	return nil
end

function HorizontalRPGChatDialogUI:OnOpen(userData)
	self.CurrentChatID = userData.ChatID

	self:UpdateView()
end

function HorizontalRPGChatDialogUI:OnClose(userData)
	HorizontalRPGModule.horizontalRPGScene.SpeakerPos = nil

	EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
	HorizontalRPGModule.horizontalRPGScene.CameraCtrl:ChangeCameraSize(45)
end

function HorizontalRPGChatDialogUI:OnAddListeners()
	self.BtnNext:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnNext)
end

function HorizontalRPGChatDialogUI:OnRemoveListeners()
	self.BtnNext:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnNext)
end

function HorizontalRPGChatDialogUI:OnPause()
	return
end

function HorizontalRPGChatDialogUI:OnResume()
	return
end

function HorizontalRPGChatDialogUI:OnCover()
	return
end

function HorizontalRPGChatDialogUI:OnReveal()
	return
end

function HorizontalRPGChatDialogUI:OnRefocus(userData)
	return
end

function HorizontalRPGChatDialogUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGChatDialogUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGChatDialogUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGChatDialogUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGChatDialogUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function HorizontalRPGChatDialogUI:UpdateView()
	local cfgData = CfgHorizontalRPGChatTable[self.CurrentChatID]

	if cfgData.ChatType == HorizontalRPGConstant.ChatType.ChatType_Notice then
		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, false)
	elseif cfgData.ChatType == HorizontalRPGConstant.ChatType.ChatType_Dialog then
		EventDispatcher.Dispatch(EventID.HorizontalRPGLockInputEvent, true)
		HorizontalRPGModule.horizontalRPGScene.CameraCtrl:ChangeCameraSize(45)
	end

	self:NextDialog()
end

function HorizontalRPGChatDialogUI:NextDialog()
	HorizontalRPGModule.horizontalRPGScene.SpeakerPos = nil

	local cfgData = CfgHorizontalRPGChatTable[self.CurrentChatID]

	if cfgData.Speaker > 0 then
		local element = HorizontalRPGModule.horizontalRPGScene.HorizontalSceneObjManager:GetElementByID(cfgData.Speaker)

		if element == nil then
			logError("没有找到说话人 " .. cfgData.Speaker)

			return
		end

		HorizontalRPGModule.horizontalRPGScene.SpeakerPos = element.View.transform.position
		self.CurrentChatView = element.ChatView
	else
		self.CurrentChatView = HorizontalRPGModule.horizontalRPGScene.HorizontalGamePaler.chatView
	end

	if self.CurrentChatView then
		self.CurrentChatView:ShowChatMsg(self.CurrentChatID, function(chatID, elementID)
			self:CheckTalkEndService(chatID, elementID)
		end)
	end
end

function HorizontalRPGChatDialogUI:CheckTalkEndService(chatID, elementID)
	local cfgData = CfgHorizontalRPGChatTable[chatID]

	if #cfgData.ServiceID > 0 then
		HorizontalRPGModule.ExecutionTalkEndService(chatID, elementID)
	end

	if cfgData.JumpID[1] == -1 then
		UIModule.CloseSelf(self)
	else
		self.CurrentChatID = cfgData.JumpID[1]

		self:NextDialog()
	end
end

function HorizontalRPGChatDialogUI:OnClickBtnNext()
	if self.CurrentChatView then
		self.CurrentChatView:EndShow()
	end
end

return HorizontalRPGChatDialogUI
