-- chunkname: @IQIGame\\UI\\MazeStageAssistantUI.lua

local MazeStageAssistantUI = {}

MazeStageAssistantUI = Base:Extend("MazeStageAssistantUI", "IQIGame.Onigao.UI.MazeStageAssistantUI", MazeStageAssistantUI)

function MazeStageAssistantUI:OnInit()
	function self.DelegateOnClickSpeedBtn()
		self:OnClickSpeedBtn()
	end
end

function MazeStageAssistantUI:GetPreloadAssetPaths()
	return nil
end

function MazeStageAssistantUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeStageAssistantUI:IsManualShowOnOpen(userData)
	return false
end

function MazeStageAssistantUI:GetBGM(userData)
	return nil
end

function MazeStageAssistantUI:OnOpen(userData)
	local speed = PlayerModule.GetMazeStageSpeed()

	UGUIUtil.SetTextInChildren(self.SpeedBtn, MazeStageAssistantUIApi:GetString("SpeedBtnText", speed))
end

function MazeStageAssistantUI:OnClose(userData)
	return
end

function MazeStageAssistantUI:OnAddListeners()
	self.SpeedBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSpeedBtn)
end

function MazeStageAssistantUI:OnRemoveListeners()
	self.SpeedBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSpeedBtn)
end

function MazeStageAssistantUI:OnPause()
	return
end

function MazeStageAssistantUI:OnResume()
	return
end

function MazeStageAssistantUI:OnCover()
	return
end

function MazeStageAssistantUI:OnReveal()
	return
end

function MazeStageAssistantUI:OnRefocus(userData)
	return
end

function MazeStageAssistantUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeStageAssistantUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeStageAssistantUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeStageAssistantUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeStageAssistantUI:OnDestroy()
	return
end

function MazeStageAssistantUI:OnClickSpeedBtn()
	local availableSpeeds = {
		1,
		1.5,
		2
	}
	local speed = PlayerModule.GetMazeStageSpeed()
	local index = table.indexOf(availableSpeeds, speed)

	index = index + 1

	if index > #availableSpeeds then
		index = 1
	end

	speed = availableSpeeds[index]

	MazeModule.SetStageSpeed(speed)
	PlayerModule.SaveMazeStageSpeed(speed)
	UGUIUtil.SetTextInChildren(self.SpeedBtn, MazeStageAssistantUIApi:GetString("SpeedBtnText", speed))
end

return MazeStageAssistantUI
