-- chunkname: @IQIGame\\UI\\LibraryMonsterEventUI.lua

local LibraryMonsterEventUI = Base:Extend("LibraryMonsterEventUI", "IQIGame.Onigao.UI.LibraryMonsterEventUI", {})

function LibraryMonsterEventUI:OnInit()
	UGUIUtil.SetText(self.TextTitle, LibraryMazeUIApi:GetString("TextTitle"))
	UGUIUtil.SetText(self.TextBtnEvent, LibraryMazeUIApi:GetString("TextBtnEvent"))
	UGUIUtil.SetText(self.TextEventDes, LibraryMazeUIApi:GetString("TextEventDes"))
	UGUIUtil.SetText(self.TextBtnMonster, LibraryMazeUIApi:GetString("TextBtnMonster"))
	UGUIUtil.SetText(self.TextMonsterDes, LibraryMazeUIApi:GetString("TextMonsterDes"))

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnEvent()
		self:OnBtnEvent()
	end

	function self.delegateBtnMonster()
		self:OnBtnMonster()
	end

	function self.delegateTaskCommitResponse(cids, awards)
		self:OnTaskCommitResponse(cids, awards)
	end

	function self.delegateBtnReward()
		self:OnClickBtnReward()
	end
end

function LibraryMonsterEventUI:GetPreloadAssetPaths()
	return nil
end

function LibraryMonsterEventUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function LibraryMonsterEventUI:IsManualShowOnOpen(userData)
	return false
end

function LibraryMonsterEventUI:GetBGM(userData)
	return nil
end

function LibraryMonsterEventUI:OnOpen(userData)
	self:UpdateReward()
end

function LibraryMonsterEventUI:OnClose(userData)
	return
end

function LibraryMonsterEventUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnEvent:GetComponent("Button").onClick:AddListener(self.delegateBtnEvent)
	self.BtnMonster:GetComponent("Button").onClick:AddListener(self.delegateBtnMonster)
	self.BtnRewardBox:GetComponent("Button").onClick:AddListener(self.delegateBtnReward)
	EventDispatcher.AddEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryMonsterEventUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnEvent:GetComponent("Button").onClick:RemoveListener(self.delegateBtnEvent)
	self.BtnMonster:GetComponent("Button").onClick:RemoveListener(self.delegateBtnMonster)
	self.BtnRewardBox:GetComponent("Button").onClick:RemoveListener(self.delegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.TaskCommitResponse, self.delegateTaskCommitResponse)
end

function LibraryMonsterEventUI:OnPause()
	return
end

function LibraryMonsterEventUI:OnResume()
	return
end

function LibraryMonsterEventUI:OnCover()
	return
end

function LibraryMonsterEventUI:OnReveal()
	return
end

function LibraryMonsterEventUI:OnRefocus(userData)
	return
end

function LibraryMonsterEventUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function LibraryMonsterEventUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function LibraryMonsterEventUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function LibraryMonsterEventUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function LibraryMonsterEventUI:OnDestroy()
	return
end

function LibraryMonsterEventUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.LibraryMonsterEventUI)
end

function LibraryMonsterEventUI:OnBtnEvent()
	UIModule.Open(Constant.UIControllerName.LibraryEventUI, Constant.UILayer.UI)
end

function LibraryMonsterEventUI:OnBtnMonster()
	UIModule.Open(Constant.UIControllerName.LibraryMonsterListUI, Constant.UILayer.UI)
end

function LibraryMonsterEventUI:OnTaskCommitResponse(cids, awards)
	self:UpdateReward()
end

function LibraryMonsterEventUI:UpdateReward()
	local red = TownLibraryModule.GetRedPoint(Constant.LibraryTaskType.TaskTypeMaze)

	self.ImgRedPoint:SetActive(red)

	local num, totalNum = TownLibraryModule.GetUnLockMazesRes()

	UGUIUtil.SetText(self.TextReward, LibraryMazeUIApi:GetString("TextReward", num, totalNum))

	self.ImgReward:GetComponent("Image").fillAmount = num / totalNum
end

function LibraryMonsterEventUI:OnClickBtnReward()
	UIModule.Open(Constant.UIControllerName.LibraryRewardUI, Constant.UILayer.UI, Constant.LibraryTaskType.TaskTypeMaze)
end

return LibraryMonsterEventUI
