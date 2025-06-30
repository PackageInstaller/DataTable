-- chunkname: @IQIGame\\UI\\CommunityUI.lua

local CommunityButtonView = {}

function CommunityButtonView.New(view)
	local obj = Clone(CommunityButtonView)

	obj:Init(view)

	return obj
end

function CommunityButtonView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function CommunityButtonView:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)
end

local CommunityUI = {}

CommunityUI = Base:Extend("CommunityUI", "IQIGame.Onigao.UI.CommunityUI", CommunityUI)

function CommunityUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickFacebook()
		self:OnClickFacebook()
	end

	function self.DelegateOnTaskNotifyFinish(tasks)
		self:OnTaskNotifyFinish(tasks)
	end

	function self.DelegateOnTaskNotifyTask(tasks)
		self:OnTaskNotifyFinish(tasks)
	end
end

function CommunityUI:GetPreloadAssetPaths()
	return nil
end

function CommunityUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function CommunityUI:IsManualShowOnOpen(userData)
	return false
end

function CommunityUI:GetBGM(userData)
	return nil
end

function CommunityUI:OnOpen(userData)
	self:Refresh()
end

function CommunityUI:OnClose(userData)
	return
end

function CommunityUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.Facebook:GetComponent("Button").onClick:AddListener(self.DelegateOnClickFacebook)
	EventDispatcher.AddEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
	EventDispatcher.AddEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
end

function CommunityUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.Facebook:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickFacebook)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyFinish, self.DelegateOnTaskNotifyFinish)
	EventDispatcher.RemoveEventListener(EventID.TaskNotifyTask, self.DelegateOnTaskNotifyTask)
end

function CommunityUI:OnPause()
	return
end

function CommunityUI:OnResume()
	return
end

function CommunityUI:OnCover()
	return
end

function CommunityUI:OnReveal()
	return
end

function CommunityUI:OnRefocus(userData)
	return
end

function CommunityUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function CommunityUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function CommunityUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function CommunityUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function CommunityUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
end

function CommunityUI:Refresh()
	local taskData = TaskSystemModule.GetTaskDataByCid(CfgDiscreteDataTable[Constant.DiscreteData.CommunityTaskID].Data[1])

	self.isReceivedReward = taskData == nil or taskData.status == Constant.TaskStatus.hadGot or taskData.status == Constant.TaskStatus.hasDone

	if not self.isReceivedReward then
		local CfgDiscreteData = CfgDiscreteDataTable[Constant.DiscreteData.CommunityReward]

		LuaUtility.SetGameObjectShow(self.FramebookFrame, true)
		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[CfgDiscreteData.Data[1]].Icon), self.FacebookIcon:GetComponent("Image"))
		LuaUtility.SetGameObjectShow(self.FacebookIcon, true)
		LuaUtility.SetGameObjectShow(self.infoTitle, true)
	else
		LuaUtility.SetGameObjectShow(self.FramebookFrame, false)
		LuaUtility.SetGameObjectShow(self.FacebookIcon, false)
		LuaUtility.SetGameObjectShow(self.infoTitle, false)
		RedDotModule.ClearRedDotByRedDotID(Constant.E_RedDotPath.Community)
	end
end

function CommunityUI:OnTaskNotifyFinish(tasks)
	self:Refresh()
end

function CommunityUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.CommunityUI)
end

function CommunityUI:OnClickFacebook()
	if not self.isReceivedReward then
		NoticeModule.ShowNotice(52001)
		UserInfoModule.TriggerEvent(Constant.TriggerEvent.Facebook)
	end
end

return CommunityUI
