-- chunkname: @IQIGame\\UI\\MazeStageDialogUI.lua

local MazeStageDialogUI = Base:Extend("MazeStageDialogUI", "IQIGame.Onigao.UI.MazeStageDialogUI", {
	DialogItemMap = {}
})
local MazeStageDialogItem = require("IQIGame.UI.Maze.MazeStageDialogItem")

function MazeStageDialogUI:OnInit()
	function self.DelegateOnNextDialog()
		self:OnNextDialog()
	end

	function self.DelegateOnClickNextBtn()
		self:OnClickNextBtn()
	end

	function self.DelegateOnChangeSpeed()
		self:OnChangeSpeed()
	end

	for i = 1, 3 do
		self.DialogItemMap[i] = MazeStageDialogItem.New(self["DialogType" .. i])
	end

	self.NextBtn:SetActive(false)
end

function MazeStageDialogUI:GetPreloadAssetPaths()
	return nil
end

function MazeStageDialogUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeStageDialogUI:IsManualShowOnOpen(userData)
	return false
end

function MazeStageDialogUI:GetBGM(userData)
	return nil
end

function MazeStageDialogUI:OnOpen(userData)
	for i = 1, #self.DialogItemMap do
		local item = self.DialogItemMap[i]

		item:SetEnabled(false)
	end
end

function MazeStageDialogUI:OnClose(userData)
	return
end

function MazeStageDialogUI:OnAddListeners()
	self.NextBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickNextBtn)
	EventDispatcher.AddEventListener(EventID.MazeStageNextDialog, self.DelegateOnNextDialog)
	EventDispatcher.AddEventListener(EventID.MazeStageChangeSpeed, self.DelegateOnChangeSpeed)
end

function MazeStageDialogUI:OnRemoveListeners()
	self.NextBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickNextBtn)
	EventDispatcher.RemoveEventListener(EventID.MazeStageNextDialog, self.DelegateOnNextDialog)
	EventDispatcher.RemoveEventListener(EventID.MazeStageChangeSpeed, self.DelegateOnChangeSpeed)
end

function MazeStageDialogUI:OnPause()
	return
end

function MazeStageDialogUI:OnResume()
	return
end

function MazeStageDialogUI:OnCover()
	return
end

function MazeStageDialogUI:OnReveal()
	return
end

function MazeStageDialogUI:OnRefocus(userData)
	return
end

function MazeStageDialogUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.CfgMazeStageDialogData ~= nil then
		local item = self.DialogItemMap[self.CfgMazeStageDialogData.Type]

		item:Update(elapseSeconds, realElapseSeconds)
	end
end

function MazeStageDialogUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeStageDialogUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeStageDialogUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeStageDialogUI:OnDestroy()
	for i = 1, #self.DialogItemMap do
		local item = self.DialogItemMap[i]

		item:Dispose()
	end
end

function MazeStageDialogUI:OnNextDialog()
	local dialogCid

	if MazeModule.MazeStageModule.IsPlayingShowState then
		dialogCid = MazeModule.MazeStageModule.CurrentCfgMazeStageData.ShowDialog[MazeModule.MazeStageModule.DialogIndex]
	elseif MazeModule.MazeStageModule.AnimationCid ~= 0 then
		local cfgMazeStageAnimationData = CfgMazeStageAnimationTable[MazeModule.MazeStageModule.AnimationCid]

		dialogCid = cfgMazeStageAnimationData.StageDialogId[MazeModule.MazeStageModule.DialogIndex]
	end

	if dialogCid == nil then
		if MazeModule.MazeStageModule.IsPlayingShowState or MazeModule.MazeStageModule.AnimationCid ~= 0 then
			logError("没有找到地台对话。MazeStage.Id: " .. MazeModule.MazeStageModule.CurrentCfgMazeStageData.Id .. ", MazeStageAnimation.Id:  " .. MazeModule.MazeStageModule.AnimationCid .. ", 对话序号：" .. MazeModule.MazeStageModule.DialogIndex)
		else
			logError("没有找到地台对话，因为地台不处于可播放对话的状态。MazeStageModule.CheckStateName: " .. (MazeModule.MazeStageModule.CheckStateName == nil and "nil" or MazeModule.MazeStageModule.CheckStateName))
		end

		self:Finish()

		return
	end

	self:ShowDialog(dialogCid)
	self.NextBtn:SetActive(true)
end

function MazeStageDialogUI:ShowDialog(dialogCid)
	self.CfgMazeStageDialogData = CfgMazeStageDialogTable[dialogCid]

	for type, item in pairs(self.DialogItemMap) do
		item:SetEnabled(type == self.CfgMazeStageDialogData.Type)
	end

	local item = self.DialogItemMap[self.CfgMazeStageDialogData.Type]

	item:SetData(self.CfgMazeStageDialogData)

	local speed = PlayerModule.GetMazeStageSpeed()

	item:SetTypeInterval(speed)
end

function MazeStageDialogUI:Finish()
	for type, item in pairs(self.DialogItemMap) do
		item:SetEnabled(false)
	end

	self.CfgMazeStageDialogData = nil

	self.NextBtn:SetActive(false)
	EventDispatcher.Dispatch(EventID.MazeStageDialogComplete)
end

function MazeStageDialogUI:OnClickNextBtn()
	local item = self.DialogItemMap[self.CfgMazeStageDialogData.Type]

	if not item:IsTypeFinished() then
		item:StopTyping()
	elseif self.CfgMazeStageDialogData.JumpId <= 0 then
		self:Finish()
	else
		self:ShowDialog(self.CfgMazeStageDialogData.JumpId)
	end
end

function MazeStageDialogUI:OnChangeSpeed()
	if self.CfgMazeStageDialogData == nil then
		return
	end

	local speed = PlayerModule.GetMazeStageSpeed()
	local item = self.DialogItemMap[self.CfgMazeStageDialogData.Type]

	item:SetTypeInterval(speed)
end

return MazeStageDialogUI
