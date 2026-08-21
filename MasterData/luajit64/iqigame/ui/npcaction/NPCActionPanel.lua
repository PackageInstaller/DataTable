-- chunkname: @IQIGame\\UI\\NPCAction\\NPCActionPanel.lua

local NPCActionPanel = {
	_timingNum = 0,
	_isShowCV = false,
	_standTimerCV = 10,
	_isDoingSomething = false,
	_cvSoundId = 0,
	_cvTime = false,
	_stopTimer = false,
	_cvEndTime = 5
}
local TextHelper = require("IQIGame.UI.Dialog.DialogTextPerformance")

function NPCActionPanel.PackageOrReuseView(ui, itemCellPrefab)
	if ui == nil or itemCellPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_NPCActionPanel == nil then
		ui.__SUB_UI_MAP_NPCActionPanel = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_NPCActionPanel
	local itemCell

	if subUIMap[itemCellPrefab:GetInstanceID()] ~= nil then
		itemCell = subUIMap[itemCellPrefab:GetInstanceID()]
	else
		itemCell = NPCActionPanel.New(ui, itemCellPrefab)
		subUIMap[itemCellPrefab:GetInstanceID()] = itemCell
	end

	return itemCell
end

function NPCActionPanel.New(parentUI, itemCellPrefab)
	local itemCell = Clone(NPCActionPanel)

	itemCell.cellObj = itemCellPrefab
	itemCell.cellView = {}

	LuaCodeInterface.BindOutlet(itemCell.cellObj, itemCell.cellView)

	itemCell._txtHelper = TextHelper.New()

	return itemCell
end

function NPCActionPanel:LoadRole(npcId)
	local meta = CfgNPCTable[npcId]
	local npcPath = UIGlobalApi.GetNpcPortraitPath(meta.Portrait2D)

	AssetUtil.LoadAsset(self, npcPath, self.OnLoadSucceed, self.OnLoadFailed, self.cellView.npcbg)
end

function NPCActionPanel:GetRolePath(npcId)
	local meta = CfgNPCTable[npcId]
	local npcPath = UIGlobalApi.GetNpcPortraitPath(meta.Portrait2D)

	return npcPath
end

function NPCActionPanel:GetRoleSpinePath(npcId)
	local meta = CfgNPCTable[npcId]
	local npcPath = UIGlobalApi.GetNpcPortraitPath(meta.Spine)

	return npcPath
end

function NPCActionPanel:GetRoleBackgroundPath(npcId)
	local meta = CfgNPCTable[npcId]
	local npcPath = UIGlobalApi.GetNpcPortraitPath(meta.Portrait2D)

	return npcPath
end

function NPCActionPanel:DoStandByCV()
	if self._npcStandbyActionData ~= nil then
		self:Speak(self._npcStandbyActionData.CVid)
	end
end

function NPCActionPanel:Start()
	self._stopTimer = true
end

function NPCActionPanel:Stop()
	self._stopTimer = false
end

function NPCActionPanel:Update(elapseSeconds, realElapseSeconds)
	if self._txtHelper ~= nil then
		self._txtHelper:Update(elapseSeconds, realElapseSeconds)
	end

	if self._stopTimer == false then
		return
	end

	if self._isShowCV == true and self._txtHelper ~= nil then
		local isFinished = self._txtHelper:IsTypeFinished()

		if isFinished == true then
			self._cvTime = self._cvTime + elapseSeconds
		end

		if self._cvTime >= self._cvEndTime then
			self:SetDisplay(false)

			self._isShowCV = false
		end
	elseif self._isDoingSomething == false then
		if self._timingNum < self._standTimerCV then
			self._timingNum = self._timingNum + elapseSeconds
		else
			self._timingNum = 0

			self:DoStandByCV()
		end
	else
		self._timingNum = self._timingNum + elapseSeconds

		if self._timingNum > self._standTimerCV then
			self._isDoingSomething = false

			self:DoStandByCV()

			self._timingNum = 0
		end
	end
end

function NPCActionPanel:Speak(cvId)
	self:SetDisplay(true)
	self._txtHelper:ResetGameObject(self.cellView.speakText)

	local cvData = CfgCVTable[cvId]

	if cvData ~= nil then
		if cvData.SoundID > 0 then
			GameEntry.Sound:StopSound(self._cvSoundId)

			self._cvSoundId = GameEntry.Sound:PlaySound(cvData.SoundID, Constant.SoundGroup.CHARACTER)
		end

		if cvData.Text ~= "" then
			self._txtHelper:Perform(self.cellView.speakText, cvData.Text)
		end

		self._isShowCV = true
		self._cvTime = 0
	end
end

function NPCActionPanel:SetDisplay(display)
	self.cellView.npcTalkNode:SetActive(display)
end

function NPCActionPanel:Clear()
	self:SetDisplay(false)

	self.cellView.speakText:GetComponent("Text").text = ""
	self._isDoingSomething = true
	self._timingNum = 0

	if self._cvSoundId > 0 then
		GameEntry.Sound:StopSound(self._cvSoundId)
	end
end

function NPCActionPanel.OnLoadSucceed(assetName, assetPath, asset, time, userdata)
	local npcbg = UnityEngine.GameObject.Instantiate(asset)

	npcbg.transform:SetParent(userdata.transform, false)
end

function NPCActionPanel.OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function NPCActionPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.cellObj, self.cellView)

	self.cellObj = nil
	self.cellView = nil
end

return NPCActionPanel
