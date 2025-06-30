-- chunkname: @IQIGame\\UI\\MazeSoulDeadUI.lua

local MazeSoulDeadUI = Base:Extend("MazeSoulDeadUI", "IQIGame.Onigao.UI.MazeSoulDeadUI", {})

function MazeSoulDeadUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	self.Tweens = self.gameObject:GetComponentsInChildren(typeof(UITweener))
	self.CVFrame = CvUIFrame.New(self.CVNode, Constant.UIControllerName.MazeSoulDeadUI)
end

function MazeSoulDeadUI:GetPreloadAssetPaths()
	return nil
end

function MazeSoulDeadUI:GetOpenPreloadAssetPaths(userData)
	local soulData = MazeDataModule.GetSoulData(userData.dollPOD.soulCid)
	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local portraitPath = UIGlobalApi.GetImagePath(cfgSoulResData.SoulSoulImage)

	return {
		portraitPath
	}
end

function MazeSoulDeadUI:OnOpen(userData)
	self:UpdateView(userData.dollPOD)
end

function MazeSoulDeadUI:OnClose(userData)
	self.CVFrame:Dispose()
end

function MazeSoulDeadUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
end

function MazeSoulDeadUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
end

function MazeSoulDeadUI:OnPause()
	return
end

function MazeSoulDeadUI:OnResume()
	return
end

function MazeSoulDeadUI:OnCover()
	return
end

function MazeSoulDeadUI:OnReveal()
	return
end

function MazeSoulDeadUI:OnRefocus(userData)
	return
end

function MazeSoulDeadUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeSoulDeadUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeSoulDeadUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeSoulDeadUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeSoulDeadUI:OnDestroy()
	self.CVFrame:OnDestroy()
end

function MazeSoulDeadUI:UpdateView(dollPOD)
	self.Panel:SetActive(false)

	for i = 0, self.Tweens.Length - 1 do
		self.Tweens[i]:ResetToBeginning()

		self.Tweens[i].enabled = true
	end

	local soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
	local cfgSoulResData = soulData:GetCfgSoulRes2D()
	local portraitPath = UIGlobalApi.GetImagePath(cfgSoulResData.SoulSoulImage)

	self.PortraitImage:GetComponent("Image").sprite = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(portraitPath))

	self.PortraitImage:GetComponent("Image"):SetNativeSize()

	self.PortraitImage.transform.localScale = Vector3(cfgSoulResData.DeadScale[1], cfgSoulResData.DeadScale[2], cfgSoulResData.DeadScale[3])
	self.PortraitImage.transform.anchoredPosition3D = Vector3(cfgSoulResData.DeadPosition[1], cfgSoulResData.DeadPosition[2], cfgSoulResData.DeadPosition[3])

	local cfgSoulData = soulData:GetCfgSoul()

	self.NameText:GetComponent("Text").text = cfgSoulData.Name

	if cfgSoulData.DeadCV ~= 0 then
		self.CVFrame:Open(cfgSoulData.DeadCV)

		local cfgCVData = CfgCVTable[cfgSoulData.DeadCV]

		if cfgCVData.SoundID ~= 0 then
			self.CVSoundDelayTimer = Timer.New(function()
				self.CVSoundDelayTimer = nil

				GameEntry.Sound:PlaySound(cfgCVData.SoundID, Constant.SoundGroup.CHARACTER)
			end, cfgCVData.DelayTime)

			self.CVSoundDelayTimer:Start()
		end
	end

	self.Panel:SetActive(true)

	self.CloseDelayTimer = Timer.New(function()
		self.CloseDelayTimer = nil

		self:Close()
	end, 3)

	self.CloseDelayTimer:Start()
end

function MazeSoulDeadUI:OnClickCloseBtn()
	self:Close()
end

function MazeSoulDeadUI:Close()
	if not MazeModule.ShowingSoulDeadUI then
		return
	end

	if self.CloseDelayTimer ~= nil then
		self.CloseDelayTimer:Stop()

		self.CloseDelayTimer = nil
	end

	if self.CVSoundDelayTimer ~= nil then
		self.CVSoundDelayTimer:Stop()

		self.CVSoundDelayTimer = nil
	end

	UIModule.Close(Constant.UIControllerName.MazeSoulDeadUI)

	MazeModule.ShowingSoulDeadUI = false

	MazeModule.CheckOpenDollDeadUI()
end

return MazeSoulDeadUI
