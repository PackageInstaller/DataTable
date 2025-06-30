-- chunkname: @IQIGame\\UI\\MazeTaskUI.lua

local MazeTaskUI = Base:Extend("MazeTaskUI", "IQIGame.Onigao.UI.MazeTaskUI", {})

function MazeTaskUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end
end

function MazeTaskUI:GetPreloadAssetPaths()
	return nil
end

function MazeTaskUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeTaskUI:OnOpen(userData)
	self:UpdateView(userData.taskCid)
end

function MazeTaskUI:OnClose(userData)
	return
end

function MazeTaskUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MazeTaskUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MazeTaskUI:OnPause()
	return
end

function MazeTaskUI:OnResume()
	return
end

function MazeTaskUI:OnCover()
	return
end

function MazeTaskUI:OnReveal()
	return
end

function MazeTaskUI:OnRefocus(userData)
	return
end

function MazeTaskUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeTaskUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeTaskUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeTaskUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeTaskUI:OnDestroy()
	return
end

function MazeTaskUI:OnClickCloseBtn()
	UIModule.Close(Constant.UIControllerName.MazeTaskUI)
end

function MazeTaskUI:UpdateView(taskCid)
	local cfgMazeTaskData = CfgMazeTaskTable[taskCid]

	self.TitleText:GetComponent("Text").text = cfgMazeTaskData.Title
	self.DescText:GetComponent("Text").text = cfgMazeTaskData.Detail
end

return MazeTaskUI
