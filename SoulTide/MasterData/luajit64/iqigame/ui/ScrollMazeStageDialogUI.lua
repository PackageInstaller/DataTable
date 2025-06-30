-- chunkname: @IQIGame\\UI\\ScrollMazeStageDialogUI.lua

local ScrollMazeStageDialogUI = {
	Pointer = 0,
	MazeSelectionCid = 0,
	DialogItems = {}
}

ScrollMazeStageDialogUI = Base:Extend("ScrollMazeStageDialogUI", "IQIGame.Onigao.UI.ScrollMazeStageDialogUI", ScrollMazeStageDialogUI)

local MazeStageDialogItem = require("IQIGame.UI.Maze.MazeStageDialogItem")

function ScrollMazeStageDialogUI:OnInit()
	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnStartDialog(mazeSelectionCid, selectionScrollDialog)
		self:OnStartDialog(mazeSelectionCid, selectionScrollDialog)
	end

	for i = 1, 2 do
		self.DialogItems[i] = MazeStageDialogItem.New(self["DialogItemGO" .. i])
	end

	self.NextBtn:SetActive(false)
end

function ScrollMazeStageDialogUI:GetPreloadAssetPaths()
	return nil
end

function ScrollMazeStageDialogUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ScrollMazeStageDialogUI:IsManualShowOnOpen(userData)
	return false
end

function ScrollMazeStageDialogUI:GetBGM(userData)
	return nil
end

function ScrollMazeStageDialogUI:OnOpen(userData)
	for i = 1, #self.DialogItems do
		self.DialogItems[i]:SetEnabled(false)
	end
end

function ScrollMazeStageDialogUI:OnClose(userData)
	return
end

function ScrollMazeStageDialogUI:OnAddListeners()
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	EventDispatcher.AddEventListener(EventID.MazeScrollStartDialog, self.DelegateOnStartDialog)
end

function ScrollMazeStageDialogUI:OnRemoveListeners()
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeScrollStartDialog, self.DelegateOnStartDialog)
end

function ScrollMazeStageDialogUI:OnPause()
	return
end

function ScrollMazeStageDialogUI:OnResume()
	return
end

function ScrollMazeStageDialogUI:OnCover()
	return
end

function ScrollMazeStageDialogUI:OnReveal()
	return
end

function ScrollMazeStageDialogUI:OnRefocus(userData)
	return
end

function ScrollMazeStageDialogUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.Contents ~= nil then
		for i = 1, #self.DialogItems do
			self.DialogItems[i]:Update(elapseSeconds, realElapseSeconds)
		end
	end
end

function ScrollMazeStageDialogUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ScrollMazeStageDialogUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ScrollMazeStageDialogUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ScrollMazeStageDialogUI:OnDestroy()
	for i = 1, #self.DialogItems do
		self.DialogItems[i]:Dispose()
	end
end

function ScrollMazeStageDialogUI:OnStartDialog(mazeSelectionCid, selectionScrollDialog)
	self:StartDialog(mazeSelectionCid, selectionScrollDialog)
end

function ScrollMazeStageDialogUI:StartDialog(mazeSelectionCid, scrollDialogs)
	self.MazeSelectionCid = mazeSelectionCid
	self.SpeakerNames = {}
	self.Contents = {}

	for i = 1, #scrollDialogs, 2 do
		table.insert(self.SpeakerNames, scrollDialogs[i])
		table.insert(self.Contents, scrollDialogs[i + 1])
	end

	self.Pointer = 1

	self:NextDialog()
end

function ScrollMazeStageDialogUI:OnClickNextBtn()
	self:NextDialog()
end

function ScrollMazeStageDialogUI:NextDialog()
	local item

	if self.DialogType ~= nil then
		item = self.DialogItems[self.DialogType]
	end

	if item ~= nil and not item:IsTypeFinished() then
		item:StopTyping()
	elseif self.Pointer > #self.Contents then
		self:Finish()
	else
		self:ShowDialog(self.SpeakerNames[self.Pointer], self.Contents[self.Pointer])
	end
end

function ScrollMazeStageDialogUI:ShowDialog(speakerName, content)
	self.DialogType = speakerName ~= "" and 1 or 2

	for i = 1, #self.DialogItems do
		self.DialogItems[i]:SetEnabled(i == self.DialogType)
	end

	local item = self.DialogItems[self.DialogType]

	item:SetDataByNameContent(speakerName, content)
	item:SetTypeInterval(1)
	self.NextBtn:SetActive(true)

	self.Pointer = self.Pointer + 1
end

function ScrollMazeStageDialogUI:Finish()
	for i = 1, #self.DialogItems do
		self.DialogItems[i]:SetEnabled(false)
	end

	self.SpeakerNames = nil
	self.Contents = nil
	self.DialogType = nil

	self.NextBtn:SetActive(false)
	EventDispatcher.Dispatch(EventID.MazeScrollEndDialog, self.MazeSelectionCid)
end

return ScrollMazeStageDialogUI
