-- chunkname: @IQIGame\\UI\\TaskAccomplishedNoticeUI.lua

local TaskAccomplishedNoticeUI = Base:Extend("TaskAccomplishedNoticeUI", "IQIGame.Onigao.UI.TaskAccomplishedNoticeUI", {})

function TaskAccomplishedNoticeUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnCloseBigFloatNoticeUI()
		self:OnCloseBigFloatNoticeUI()
	end

	self.TitleText:GetComponent("Text").text = TaskAccomplishedNoticeUIApi:GetString("TitleText")
end

function TaskAccomplishedNoticeUI:GetPreloadAssetPaths()
	return nil
end

function TaskAccomplishedNoticeUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function TaskAccomplishedNoticeUI:OnOpen(userData)
	local taskCid = userData.taskCid
	local cfgMainQuestData = CfgMainQuestTable[taskCid]

	self.TypeText:GetComponent("Text").text = TaskAccomplishedNoticeUIApi:GetString("TypeText", cfgMainQuestData.TypeParam)
	self.NameText:GetComponent("Text").text = TaskAccomplishedNoticeUIApi:GetString("NameText", cfgMainQuestData.Name)

	self.MainPanel.transform:SetParent(self["Pos" .. userData.index].transform, false)

	self.DelayCloseTimer = Timer.New(function()
		self.DelayCloseTimer = nil

		UIModule.Close(Constant.UIControllerName.TaskAccomplishedNoticeUI)
	end, 3)

	self.DelayCloseTimer:Start()
end

function TaskAccomplishedNoticeUI:OnClose(userData)
	self:StopDelayCloseTimer()
end

function TaskAccomplishedNoticeUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.AddEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function TaskAccomplishedNoticeUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	EventDispatcher.RemoveEventListener(EventID.CloseBigFloatNoticeUI, self.DelegateOnCloseBigFloatNoticeUI)
end

function TaskAccomplishedNoticeUI:OnPause()
	return
end

function TaskAccomplishedNoticeUI:OnResume()
	return
end

function TaskAccomplishedNoticeUI:OnCover()
	return
end

function TaskAccomplishedNoticeUI:OnReveal()
	return
end

function TaskAccomplishedNoticeUI:OnRefocus(userData)
	return
end

function TaskAccomplishedNoticeUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function TaskAccomplishedNoticeUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function TaskAccomplishedNoticeUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function TaskAccomplishedNoticeUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function TaskAccomplishedNoticeUI:OnDestroy()
	return
end

function TaskAccomplishedNoticeUI:StopDelayCloseTimer()
	if self.DelayCloseTimer ~= nil then
		self.DelayCloseTimer:Stop()

		self.DelayCloseTimer = nil
	end
end

function TaskAccomplishedNoticeUI:OnClickCloseBtn()
	EventDispatcher.Dispatch(EventID.CloseBigFloatNoticeUI)
end

function TaskAccomplishedNoticeUI:OnCloseBigFloatNoticeUI()
	self:StopDelayCloseTimer()
	UIModule.Close(Constant.UIControllerName.TaskAccomplishedNoticeUI)
end

return TaskAccomplishedNoticeUI
