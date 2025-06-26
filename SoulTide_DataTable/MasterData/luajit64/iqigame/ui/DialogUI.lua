-- chunkname: @IQIGame\\UI\\DialogUI.lua

local DialogUI = {
	IsCreateRole = false,
	ServerMode = false,
	StartDialogCid = 0,
	PreparingNextDialog = false,
	AutoContinueWaitingTime = 0,
	IsInMaze = false,
	IsAutoPlay = false,
	LoadingAsset = false,
	IsSkipMode = false,
	AutoPlayStateBeforeReview = false,
	ChangedBgm = false,
	HasServiceFollowedWhenSkip = false,
	ContentStep = 0,
	Closed = false,
	ShowingOptions = false,
	MaxCountdownValue = 0,
	WaitServer = false,
	OptionBtnPools = {},
	LastSoundCid = {},
	LastSoundSerialID = {},
	SkipSelectIndexes = {},
	DialogIdRecords = {}
}

DialogUI = Base:Extend("DialogUI", "IQIGame.Onigao.UI.DialogUI", DialogUI)

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local NpcPortraitUI = require("IQIGame.UI.Dialog.NpcPortraitUI")
local DialogPerformanceHelper = require("IQIGame.UI.Dialog.DialogPerformanceHelper")
local DialogBackgroundPerformance = require("IQIGame.UI.Dialog.DialogBackgroundPerformance")
local DialogScreenPerformance = require("IQIGame.UI.Dialog.DialogScreenPerformance")
local ObjectPool = {
	Size = 8,
	Prefabs = {},
	InstancePool = {}
}

function ObjectPool.New(size)
	local objectPool = Clone(ObjectPool)

	objectPool.Size = size

	return objectPool
end

function ObjectPool:Register(path, prefab)
	self.Prefabs[path] = prefab
end

function ObjectPool:Obtain(path)
	local obj
	local objs = self.InstancePool[path]

	if objs ~= nil and #objs > 0 then
		obj = table.remove(objs, 1)

		obj:SetActive(true)
	elseif self.Prefabs[path] ~= nil then
		obj = UnityEngine.Object.Instantiate(self.Prefabs[path])
	end

	return obj
end

function ObjectPool:Release(path, obj)
	local objs = self.InstancePool[path]

	if objs == nil then
		objs = {}
		self.InstancePool[path] = objs
	end

	if #objs < self.Size then
		obj:SetActive(false)
		table.insert(objs, obj)
	else
		UnityEngine.Object.Destroy(obj)
	end
end

function ObjectPool:Dispose()
	for path, instances in pairs(self.InstancePool) do
		if #instances > 0 then
			for i = 1, #instances do
				UnityEngine.Object.Destroy(instances[i])
			end
		end
	end

	self.Prefabs = nil
end

function DialogUI:OnInit()
	function self.DelegateOnContinue()
		self:OnContinue()
	end

	function self.DelegateCreateOptionBtn1()
		return self:CreateOptionBtn(1)
	end

	function self.DelegateCreateOptionBtn2()
		return self:CreateOptionBtn(2)
	end

	function self.DelegateCreateOptionBtn3()
		return self:CreateOptionBtn(3)
	end

	function self.DelegateCreateOptionBtn4()
		return self:CreateOptionBtn(4)
	end

	function self.DelegateCountdownUpdate()
		self:CountdownUpdate()
	end

	function self.DelegateOnJumpToNextDialogResponded(nextCid)
		self:OnJumpToNextDialogResponded(nextCid)
	end

	function self.DelegateOnPlayMovieComplete()
		self:OnPlayMovieComplete()
	end

	function self.DelegateOnPlayMovieError()
		self:OnPlayMovieError()
	end

	function self.DelegateOnClickReviewBtn()
		self:OnClickReviewBtn()
	end

	function self.DelegateOnClickPlayBtn()
		self:OnClickPlayBtn()
	end

	function self.DelegateOnClickPauseBtn()
		self:OnClickPauseBtn()
	end

	function self.DelegateOnClickSkipBtn()
		self:OnClickSkipBtn()
	end

	self.NpcPortraitPool = ObjectPool.New(10)

	local npcPositions = {}

	self.NpcPortraitUIs = {}

	for i = 1, 5 do
		self.NpcPortraitUIs[i] = NpcPortraitUI.New(self["NpcPoint" .. i], UnityEngine.Object.Instantiate(self.NpcPortraitPrefab), self.NpcPortraitPool, function(path, userData)
			AssetUtil.LoadAsset(self, path, self.OnLoadSucceed, self.OnLoadFailed, userData)
		end, self.UIController.transform)

		table.insert(npcPositions, self.NpcPortraitUIs[i].PointGO.transform.anchoredPosition3D)
	end

	for i = 1, 4 do
		self.OptionBtnPools[i] = UIObjectPool.New(8, self["DelegateCreateOptionBtn" .. i])
	end

	self.Timer = Timer.New(self.DelegateCountdownUpdate, 1, -1, false)
	self.PerformanceHelper = DialogPerformanceHelper.New()

	self.PerformanceHelper.Screen:SetInitParam(self.Root.transform.anchoredPosition3D)
	self.PerformanceHelper.Background:SetInitParam(self.Background.transform.anchoredPosition3D)
	self.PerformanceHelper.NPC:SetNpcPositions(npcPositions)

	self.CanvasReferenceResolution = self.View:GetComponent("CanvasScaler").referenceResolution
	self.TextGenerator = IQIGame.Onigao.Game.PreBindSettingTextGenerator(self.SimpleContentText:GetComponent("Text"))
	self.Backgrounds = {}

	for i = 1, 2 do
		self.Backgrounds[i] = self.Background.transform:Find("Image" .. i):GetComponent("Image")
	end

	UGUIUtil.SetTextInChildren(self.SkipBtn, DialogUIApi:GetString("SkipBtnText"))
	UGUIUtil.SetTextInChildren(self.PauseBtn, DialogUIApi:GetString("PauseBtnText"))
	UGUIUtil.SetTextInChildren(self.ReviewBtn, DialogUIApi:GetString("ReviewBtnText"))
	UGUIUtil.SetTextInChildren(self.PlayBtn, DialogUIApi:GetString("PlayBtnText"))
end

function DialogUI:GetPreloadAssetPaths()
	return nil
end

function DialogUI:GetOpenPreloadAssetPaths(userData)
	local paths = {}
	local dialogCid = userData.dialogCid

	if userData == nil or dialogCid == nil then
		logError("打开对话窗口时没有传递任何有效参数")

		return
	end

	local cfgDialogData = CfgDialogTable[dialogCid]

	if cfgDialogData == nil then
		logError("找不到对话id：" .. tostring(dialogCid))
	end

	if cfgDialogData.Background ~= "" then
		table.insert(paths, UIGlobalApi.GetImagePath(cfgDialogData.Background))
	end

	return paths
end

function DialogUI:OnOpen(userData)
	self.Cover:SetActive(true)

	self.Closed = false
	self.IsSkipMode = false

	if userData == nil then
		logError("DialogUI.OnOpen : UserData can not be null.")
	end

	self:ClearOptions()

	self.SkipSelectIndexes = {}
	self.WaitServer = false
	self.StartDialogCid = userData.dialogCid

	if userData.isInMaze == nil then
		self.IsInMaze = false
	else
		self.IsInMaze = userData.isInMaze
	end

	if userData.serverMode == nil then
		self.ServerMode = false
	else
		self.ServerMode = userData.serverMode
	end

	self:SetIsAutoPlay(false)
	self:ShowDialog(self.StartDialogCid)
	self.Timer:Start()
	self.ReviewBtn:SetActive(userData.CanReview == nil or userData.CanReview)
	EventDispatcher.Dispatch(EventID.OpenDialogUI, self.StartDialogCid)
end

function DialogUI:OnClose(userData)
	self.Closed = true
	self.DialogIdRecords = {}
	self.LastBGPerformanceCids = nil
	self.LastScreenPerformanceCids = nil

	self.Timer:Stop()
	self:SetSceneCameraBlur(false)

	self.LastBlurBg = nil

	self:StopAllSound()

	if self.ChangedBgm then
		self.ChangedBgm = false

		EventDispatcher.Dispatch(EventID.RestoreBGM)
	end

	EventDispatcher.Dispatch(EventID.CloseDialogUI, self.StartDialogCid)
	ModuleTimerUtil.Stop(Constant.UIControllerName.DialogUI)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "CloseDialogUI")
end

function DialogUI:OnPause()
	return
end

function DialogUI:OnResume()
	return
end

function DialogUI:OnCover()
	return
end

function DialogUI:OnReveal()
	return
end

function DialogUI:OnRefocus(userData)
	return
end

function DialogUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.PerformanceHelper:Update(elapseSeconds, realElapseSeconds)

	if self.PerformanceHelper.Text:IsTypeFinished() and (self.IsAutoPlay or self.CurrentCfgData ~= nil and self.CurrentCfgData.AutoJumpTime > 0) and not self.PreparingNextDialog then
		self.AutoContinueWaitingTime = self.AutoContinueWaitingTime + elapseSeconds
	end

	if self.AutoContinueWaitingTime > (self.CurrentCfgData ~= nil and self.CurrentCfgData.AutoJumpTime > 0 and self.CurrentCfgData.AutoJumpTime or 2) then
		self:OnContinue()
	end
end

function DialogUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	for i = 1, #self.NpcPortraitUIs do
		self.NpcPortraitUIs[i]:SetCanvasOrder(self.View:GetComponent("Canvas").sortingOrder)
	end
end

function DialogUI:OnLoadSucceed(assetName, asset, duration, userData)
	local img

	if userData.tag == "background" then
		for i = 1, #self.Backgrounds do
			local background = self.Backgrounds[i]

			background.sprite = LuaCodeInterface.ToSprite(asset)
		end
	elseif userData.tag == "portrait" then
		userData.controller:OnLoadSucceed(assetName, asset, duration, userData)
	else
		img = userData
		img.sprite = LuaCodeInterface.ToSprite(asset)
	end
end

function DialogUI:OnLoadFailed(assetName, status, errorMessage, userData)
	if userData.tag == "portrait" then
		userData.controller:OnLoadFailed(assetName, status, errorMessage, userData)
	end
end

function DialogUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearOptions(true)

	for i = 1, #self.OptionBtnPools do
		self.OptionBtnPools[i]:Dispose()
	end

	for i = 1, #self.NpcPortraitUIs do
		self.NpcPortraitUIs[i]:Dispose()
	end

	self.NpcPortraitPool:Dispose()

	self.TextGenerator = nil
end

function DialogUI:CountdownUpdate()
	if self.OptionCountdowns ~= nil then
		local maxCountdownValue = -1

		for i = 1, #self.OptionCountdowns do
			if self.OptionCountdowns[i] > 0 then
				self.OptionCountdowns[i] = self.OptionCountdowns[i] - 1
			end

			if self.OptionCountdowns[i] == 0 and self.OptionBtns[i] ~= nil then
				if self.OptionBtns[i].interactable then
					self:SetOptionBtnInteractable(self.OptionBtns[i], false)
				end
			elseif self.OptionCountdowns[i] > 0 and self.OptionBtns[i] ~= nil then
				maxCountdownValue = math.max(maxCountdownValue, self.OptionCountdowns[i])
			end
		end

		self.CountdownBar:SetActive(maxCountdownValue > 0)

		if maxCountdownValue > 0 then
			self.CountdownText:GetComponent("Text").text = tostring(maxCountdownValue)
			self.CountdownBar:GetComponent("Slider").value = maxCountdownValue / self.MaxCountdownValue
		end
	end
end

function DialogUI:SetOptionBtnInteractable(button, interactable)
	if button.interactable == interactable then
		return
	end

	button.interactable = interactable

	local color

	if interactable then
		color = Color.white
	else
		color = Color(0.3, 0.3, 0.3, 1)
	end

	local images = button.gameObject:GetComponentsInChildren(typeof(UnityEngine.UI.Image))

	for i = 0, images.Length - 1 do
		images[i].color = color
	end
end

function DialogUI:CreateOptionBtn(type)
	return UnityEngine.Object.Instantiate(self["OptionBtn" .. type])
end

function DialogUI:OnAddListeners()
	self.ContinueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnContinue)
	self.SimpleContinueBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnContinue)
	self.ReviewBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickReviewBtn)
	self.PlayBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPlayBtn)
	self.PauseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPauseBtn)
	self.SkipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSkipBtn)
	EventDispatcher.AddEventListener(EventID.JumpToNextDialog, self.DelegateOnJumpToNextDialogResponded)
end

function DialogUI:OnRemoveListeners()
	self.ContinueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnContinue)
	self.SimpleContinueBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnContinue)
	self.ReviewBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickReviewBtn)
	self.PlayBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPlayBtn)
	self.PauseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPauseBtn)
	self.SkipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSkipBtn)
	EventDispatcher.RemoveEventListener(EventID.JumpToNextDialog, self.DelegateOnJumpToNextDialogResponded)
end

function DialogUI:OnContinue()
	if self:IsLocking() then
		return
	end

	if not self.PerformanceHelper.Text:IsTypeFinished() then
		self.PerformanceHelper.Text:StopAll()

		return
	end

	self.AutoContinueWaitingTime = 0
	self.PreparingNextDialog = true

	if #self.CurrentCfgData.Contents > 1 and self.ContentStep > 0 and self.ContentStep < #self.CurrentCfgData.Contents then
		self:NextContentStep(self.CurrentCfgData, true)

		return
	end

	if self.ShowingOptions then
		return
	end

	local nextIds = self.CurrentCfgData.JumpID
	local optionTexts = self.CurrentCfgData.NextDialogName
	local needShowOptions = false

	if #nextIds == 1 then
		if #optionTexts == 0 or optionTexts[1] == "" then
			needShowOptions = false
		elseif #optionTexts > 0 then
			needShowOptions = true
		end
	elseif #nextIds > 1 then
		needShowOptions = true
	end

	if needShowOptions and (not self.IsSkipMode or self.HasServiceFollowedWhenSkip) then
		self:ShowOptions()
	else
		local validIndex = 1

		if #nextIds > 1 then
			validIndex = -1

			for i = 1, #nextIds do
				if ConditionModule.Check(self.CurrentCfgData.ChooseCondition[i]) and not self:__CheckLoop(nextIds[i]) then
					validIndex = i

					break
				end
			end

			if validIndex == -1 then
				logError("跳过对话错误，所有选项均不满足可选条件（ChooseCondition）。id: " .. self.CurrentCfgData.Id)

				validIndex = 1
			end
		end

		self:ToNextDialog(validIndex)
	end
end

function DialogUI:IsLocking()
	return self.WaitServer or self.LoadingAsset
end

function DialogUI:ToNextDialog(index)
	local nextCid = self.CurrentCfgData.JumpID[index]

	if nextCid == nil then
		logError("尝试跳转到第 " .. index .. " 个选项，但没有配置选项对应的下一个对话，检查JumpID。")
		self:Close()

		return
	end

	local services = self.CurrentCfgData.JumService[index]

	if nextCid > 0 and #services == 0 then
		self:CheckSkipModeThenShowDialog(nextCid, index)
	else
		self.WaitServer = true

		if self.IsInMaze then
			MazeLogicAdapter.Instance:AddMazeOrderFromLua(MazeLogicAdapter.ORDER_DIALOG_SELECT, {
				SelectIndex = index,
				SkipSelectIndexs = self.SkipSelectIndexes
			})
		else
			if self.ServerMode and (ExecutionModule.HasServiceExecution(services) or nextCid == -1) then
				if self.CurrentCfgData.sysType == 11 then
					net_dreamMap.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 12 then
					net_operationsPanda.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 13 then
					net_taleChallenge.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 14 then
					net_dualTeamExplore.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 15 then
					net_magicTower.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 17 then
					net_miniGalGame.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 18 then
					net_mining.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 19 then
					net_restaurant.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 20 then
					net_placeGame.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 21 then
					net_amusementPark.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 22 then
					net_horizontalRPG.selectDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 23 then
					net_horizontalRPG.selectLevelDialog(index, self.SkipSelectIndexes)
				elseif self.CurrentCfgData.sysType == 24 then
					net_survival.selectDialog(index, self.SkipSelectIndexes)
				else
					net_dialog.selectDialog(index, self.SkipSelectIndexes)
				end
			else
				self.WaitServer = false

				if nextCid == -1 then
					self:Close()
				end
			end

			self:ExecuteClientModeService(services)
		end
	end
end

function DialogUI:ExecuteClientModeService(executions)
	if #executions > 0 then
		ExecutionModule.Execute(executions)
	end
end

function DialogUI:CheckSkipModeThenShowDialog(nextCid, lastSelectionIndex)
	if lastSelectionIndex ~= nil then
		table.insert(self.SkipSelectIndexes, lastSelectionIndex)
	end

	if self.IsSkipMode then
		local cfgDialogData = CfgDialogTable[nextCid]
		local jumpIdListOfNext = cfgDialogData.JumpID

		if #jumpIdListOfNext > 1 then
			if self.HasServiceFollowedWhenSkip then
				self:ShowDialog(nextCid, true)
			else
				local validIndex = -1

				for i = 1, #jumpIdListOfNext do
					if ConditionModule.Check(cfgDialogData.ChooseCondition[i]) and not self:__CheckLoop(jumpIdListOfNext[i]) then
						validIndex = i

						break
					end
				end

				if validIndex == -1 then
					logError("跳过对话错误，所有选项均不满足可选条件（ChooseCondition）。id: " .. nextCid)

					self.IsSkipMode = false

					self:ShowDialog(nextCid, true)

					return
				end

				self:SkipCurrentDialog(nextCid, validIndex)
			end
		else
			self:SkipCurrentDialog(nextCid, 1)
		end
	else
		self:ShowDialog(nextCid)
	end
end

function DialogUI:__CheckLoop(dialogCid, record)
	if dialogCid == 0 or dialogCid == -1 then
		return false
	end

	record = record or {}

	if record[dialogCid] ~= nil then
		return true
	end

	record[dialogCid] = dialogCid

	local cfgDialogData = CfgDialogTable[dialogCid]
	local branchRecords = {}

	table.insert(branchRecords, record)

	if #cfgDialogData.JumpID > 1 then
		for i = 1, #cfgDialogData.JumpID - 1 do
			local newRecord = table.clone(record)

			table.insert(branchRecords, newRecord)
		end
	end

	for i = 1, #cfgDialogData.JumpID do
		if self:__CheckLoop(cfgDialogData.JumpID[i], branchRecords[i]) then
			return true
		end
	end

	return false
end

function DialogUI:OnJumpToNextDialogResponded(nextCid)
	self.WaitServer = false
	self.SkipSelectIndexes = {}

	if nextCid > 0 then
		self:CheckSkipModeThenShowDialog(nextCid)
	else
		self:Close()
	end
end

function DialogUI:Close()
	if not self.Closed then
		self.Closed = true

		UIModule.Close(Constant.UIControllerName.DialogUI)
	end
end

function DialogUI:ShowDialog(dialogCid, inSkipMode)
	self.SkipBtn:SetActive(true)

	local cfgDialogData = CfgDialogTable[dialogCid]

	if cfgDialogData == nil then
		logError("对话ID错误：" .. dialogCid)

		return
	end

	self:SetSceneCameraBlur(cfgDialogData.BlurBg)

	self.LoadingAsset = true

	local function actionAfterLoadAllAssets(preloadAssetNum, backgroundPath)
		if cfgDialogData.Movie ~= "" then
			self.CachedCfgDialogDataForMovie = cfgDialogData

			GameEntry.Video:Play(cfgDialogData.Movie, self.DelegateOnPlayMovieComplete, self.DelegateOnPlayMovieError)

			return
		end

		if preloadAssetNum > 0 and (preloadAssetNum ~= 1 or backgroundPath == nil) then
			local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.DialogUI, function()
				self.LoadingAsset = false

				self.Cover:SetActive(false)
			end, 1)

			timer:Start()
		else
			self.LoadingAsset = false

			self.Cover:SetActive(false)
		end

		self:ChangeBackground(backgroundPath, preloadAssetNum)
		self:ShowDialogAfterMovie(cfgDialogData)
	end

	local assetPaths, backgroundPath = self:GetNextAssets(cfgDialogData, inSkipMode)
	local assetNum = #assetPaths

	if assetNum > 0 then
		for i = assetNum, 1, -1 do
			AssetUtil.LoadAsset(self, assetPaths[i], self.OnLoadCurDialogAssetSuccess, self.OnLoadCurDialogAssetFail, {
				allPaths = assetPaths,
				assetNum = assetNum,
				onAllComplete = actionAfterLoadAllAssets,
				backgroundPath = backgroundPath
			})
		end
	else
		actionAfterLoadAllAssets(0, backgroundPath)
	end
end

function DialogUI:OnLoadCurDialogAssetSuccess(assetName, asset, duration, userData)
	self:OnLoadCurDialogAssetComplete(assetName, userData)
end

function DialogUI:OnLoadCurDialogAssetFail(assetName, status, errorMessage, userData)
	self:OnLoadCurDialogAssetComplete(assetName, userData)
end

function DialogUI:OnLoadCurDialogAssetComplete(assetName, userData)
	local paths = userData.allPaths
	local index = table.indexOf(paths, assetName)

	table.remove(paths, index)

	if #paths == 0 then
		userData.onAllComplete(userData.assetNum, userData.backgroundPath)
	end
end

function DialogUI:GetNextAssets(cfgDialogData, inSkipMode)
	local paths = {}
	local backgroundPath

	if inSkipMode then
		if cfgDialogData.Background ~= "" then
			backgroundPath = cfgDialogData.Background
		else
			backgroundPath = self.LastCfgBackgroundPath
		end
	elseif cfgDialogData.Background ~= "" and cfgDialogData.Background ~= self.LastUsedBackgroundPath then
		backgroundPath = cfgDialogData.Background
	end

	if backgroundPath ~= nil then
		table.insert(paths, UIGlobalApi.GetImagePath(backgroundPath))
	end

	for i = 1, #cfgDialogData.ScreenPerformance do
		local screenPerformanceCid = cfgDialogData.ScreenPerformance[i]

		if screenPerformanceCid ~= 0 then
			local cfgScreenPerformanceData = CfgScreenPerformanceTable[screenPerformanceCid]

			if cfgScreenPerformanceData.PerformanceType == DialogScreenPerformance.TYPE_EFFECT then
				local effectCid = tonumber(cfgScreenPerformanceData.PerformanceParameter[1])
				local cfgEffectData = CfgEffectTable[effectCid]
				local cfgEffectEntityData = CfgEffectEntityTable[cfgEffectData.EntityID]
				local path = AssetPath.Get(GlobalKey.EffectPath, cfgEffectEntityData.PrefabName)

				table.insert(paths, path)
			end
		end
	end

	return paths, backgroundPath
end

function DialogUI:OnPlayMovieComplete()
	self:ShowDialogAfterMovie(self.CachedCfgDialogDataForMovie)

	self.CachedCfgDialogDataForMovie = nil
end

function DialogUI:OnPlayMovieError()
	self:ShowDialogAfterMovie(self.CachedCfgDialogDataForMovie)

	self.CachedCfgDialogDataForMovie = nil
end

function DialogUI:ShowDialogAfterMovie(cfgDialogData)
	self.NormalCom:SetActive(cfgDialogData.Type ~= Constant.Dialog.TypeSimple)
	self.SimpleCom:SetActive(cfgDialogData.Type == Constant.Dialog.TypeSimple)

	self.ContentStep = 0

	self:PlaySoundEffect(cfgDialogData)

	if cfgDialogData.Type ~= Constant.Dialog.TypeSimple then
		self:ShowNormalTypeDialog(cfgDialogData)
	else
		self:ShowSimpleTypeDialog(cfgDialogData)
	end

	table.insert(self.DialogIdRecords, cfgDialogData.Id)
	self:PlayDialogPerformance(cfgDialogData)
	self:NextContentStep(cfgDialogData)

	local isBgVisible = cfgDialogData.Type ~= Constant.Dialog.TypeSimple and not cfgDialogData.BlurBg

	self.Background:SetActive(isBgVisible)

	if isBgVisible then
		if #cfgDialogData.BgOffset >= 2 then
			local bgAnchoredPosition = Vector2(cfgDialogData.BgOffset[1], cfgDialogData.BgOffset[2])

			self.Background.transform.anchoredPosition = bgAnchoredPosition
		end

		if cfgDialogData.BgScale > 0 then
			local bgScale = Vector3(cfgDialogData.BgScale, cfgDialogData.BgScale, 1)

			self.Background.transform.localScale = bgScale
		end
	end

	self.CurrentCfgData = cfgDialogData

	if cfgDialogData.Background ~= "" then
		self.LastCfgBackgroundPath = cfgDialogData.Background
		self.LastUsedBackgroundPath = self.LastCfgBackgroundPath
	end

	if self.IsSkipMode then
		self.PerformanceHelper.Text:StopAll()
		self:OnContinue()
	end
end

function DialogUI:ShowSimpleTypeDialog(cfgDialogData)
	local content = ""

	for i = 1, #cfgDialogData.Contents do
		content = content .. self:GetFinalText(cfgDialogData.Contents[i])
	end

	local textWidth = self.TextGenerator:GetPreferredWidth(content)
	local sizeDelta = self.SimpleContentText.transform.sizeDelta

	sizeDelta.x = textWidth * 1.01
	self.SimpleContentText.transform.sizeDelta = sizeDelta
end

function DialogUI:ShowNormalTypeDialog(cfgDialogData)
	self:RefreshNpcImage(cfgDialogData.Player, cfgDialogData.PlayerAction, cfgDialogData.SpineAction, cfgDialogData.CurrentPlayer)
	self.ContentViewNormal:SetActive(cfgDialogData.Type == Constant.Dialog.TypeNormal and #cfgDialogData.Contents ~= 0)
	self.ContentViewCover:SetActive(cfgDialogData.Type == Constant.Dialog.TypeCover and #cfgDialogData.Contents ~= 0)

	if cfgDialogData.Type == Constant.Dialog.TypeNormal then
		local cfgNpcData
		local npcCid = cfgDialogData.Player[cfgDialogData.CurrentPlayer]

		if npcCid ~= nil and npcCid ~= 0 then
			cfgNpcData = CfgNPCTable[npcCid]
		end

		if cfgNpcData ~= nil then
			if npcCid == 100 and PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
				self.NameText:GetComponent("Text").text = DialogUIApi:GetString("NameText", PlayerModule.PlayerInfo.baseInfo.pName)
			else
				self.NameText:GetComponent("Text").text = DialogUIApi:GetString("NameText", cfgNpcData.Name)
			end
		else
			self.NameText:GetComponent("Text").text = ""
		end

		self.NameTextBg:SetActive(cfgNpcData ~= nil)
		self.NpcHeadView:SetActive(cfgDialogData.HeadImage ~= "")

		if cfgDialogData.HeadImage ~= "" then
			AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(cfgDialogData.HeadImage), self.NpcHeadIcon:GetComponent("Image"))
		end
	end
end

function DialogUI:NextContentStep(cfgDialogData, doNotResetPerformance)
	self.ContentStep = self.ContentStep + 1

	self:PlayDialogTextPerformance(cfgDialogData, doNotResetPerformance)

	local cvCid = cfgDialogData.CV[self.ContentStep]

	if cvCid ~= nil then
		self:PlaySound(cvCid, Constant.SoundGroup.CHARACTER, true)
	end
end

function DialogUI:ChangeBackground(backgroundPath, preloadAssetNum)
	if backgroundPath ~= nil then
		local preloadedBgSprite = self.UIController:GetPreloadedAsset(UIGlobalApi.GetImagePath(backgroundPath))

		if preloadedBgSprite ~= nil then
			for i = 1, #self.Backgrounds do
				local background = self.Backgrounds[i]

				background.sprite = LuaCodeInterface.ToSprite(preloadedBgSprite)
			end
		else
			local function loadBg()
				AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(backgroundPath), self.OnLoadSucceed, self.OnLoadFailed, {
					tag = "background"
				})
			end

			if preloadAssetNum == 1 then
				loadBg()
			else
				local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.DialogUI, function()
					loadBg()
				end, 1)

				timer:Start()
			end
		end
	end
end

function DialogUI:PlayDialogPerformance(cfgDialogData)
	local playerformanceCidsList, bgPerformanceCids, screenPerformanceCids = self:GetContinuousPerformanceCids(cfgDialogData)
	local keepBgPerformance = self:ComparePerformanceList(self.LastBGPerformanceCids, bgPerformanceCids)
	local keepScreenPerformance = self:ComparePerformanceList(self.LastScreenPerformanceCids, screenPerformanceCids)

	self.PerformanceHelper.NPC:StopAll()

	for i = 1, #self.NpcPortraitUIs do
		self.PerformanceHelper.NPC:ResetGameObject(self.NpcPortraitUIs[i].PointGO, i)
	end

	if not keepBgPerformance then
		self.PerformanceHelper.Background:StopAll()
		self.PerformanceHelper.Background:ResetGameObject(self.Background)
	end

	if not keepScreenPerformance then
		self.PerformanceHelper.Screen:StopAll()
		self.PerformanceHelper.Screen:ResetGameObject(self.Root)
	end

	local playerPerformance = cfgDialogData.PlayerPerformance
	local backgroundPerformance = {}

	for i = 1, #cfgDialogData.BackgroundPerformance do
		local cid = cfgDialogData.BackgroundPerformance[i]

		if not keepBgPerformance or self.LastBGPerformanceCids == nil or table.indexOf(self.LastBGPerformanceCids, cid) == -1 then
			table.insert(backgroundPerformance, cid)
		end
	end

	local screenPerformance = {}

	for i = 1, #cfgDialogData.ScreenPerformance do
		local cid = cfgDialogData.ScreenPerformance[i]

		if not keepScreenPerformance or self.LastScreenPerformanceCids == nil or table.indexOf(self.LastScreenPerformanceCids, cid) == -1 then
			table.insert(screenPerformance, cid)
		end
	end

	self.LastBGPerformanceCids = bgPerformanceCids
	self.LastScreenPerformanceCids = screenPerformanceCids

	for i = 1, #self.NpcPortraitUIs do
		self.PerformanceHelper.NPC:Perform(self.NpcPortraitUIs[i], playerPerformance[i], self)
	end

	self.PerformanceHelper.Background:Perform(self.Background, backgroundPerformance)
	self.PerformanceHelper.Screen:Perform(self.Root, screenPerformance, self)

	self.PreparingNextDialog = false
end

function DialogUI:PlayDialogTextPerformance(cfgDialogData, doNotResetPerformance)
	self.PerformanceHelper.Text:StopAll()

	local contentTextGo

	if cfgDialogData.Type == Constant.Dialog.TypeNormal then
		contentTextGo = self.ContentTextNormal
	elseif cfgDialogData.Type == Constant.Dialog.TypeSimple then
		contentTextGo = self.SimpleContentText
	elseif cfgDialogData.Type == Constant.Dialog.TypeCover then
		contentTextGo = self.ContentTextCover
	end

	if not doNotResetPerformance then
		self.PerformanceHelper.Text:ResetGameObject(contentTextGo)
	end

	local curContent, beforeContents = self:GetCurContent(cfgDialogData.Contents)

	if curContent ~= nil then
		self.PerformanceHelper.Text:Perform(contentTextGo, curContent, beforeContents)
	end
end

function DialogUI:ComparePerformanceList(oldList, newList)
	if oldList == nil or newList == nil then
		return false
	end

	local matchNum = 0

	for i = 1, #oldList do
		if table.indexOf(newList, oldList[i]) ~= -1 then
			matchNum = matchNum + 1
		end
	end

	return matchNum > 0 and matchNum == #oldList
end

function DialogUI:GetContinuousPerformanceCids(cfgDialogData)
	local playerPerformanceCids = {}
	local backgroundPerformanceCids = {}
	local screenPerformance = {}

	for i = 1, #cfgDialogData.BackgroundPerformance do
		local performanceCid = cfgDialogData.BackgroundPerformance[i]
		local cfgBackgroundPerformanceData = CfgBackgroundPerformanceTable[performanceCid]

		if cfgBackgroundPerformanceData.PerformanceType == DialogBackgroundPerformance.TYPE_ROLL then
			table.insert(backgroundPerformanceCids, performanceCid)
		end
	end

	for i = 1, #cfgDialogData.ScreenPerformance do
		local performanceCid = cfgDialogData.ScreenPerformance[i]
		local cfgScreenPerformanceData = CfgScreenPerformanceTable[performanceCid]

		if cfgScreenPerformanceData.PerformanceType == DialogScreenPerformance.TYPE_EFFECT then
			table.insert(screenPerformance, performanceCid)
		end
	end

	return playerPerformanceCids, backgroundPerformanceCids, screenPerformance
end

function DialogUI:PlaySoundEffect(cfgDialogData)
	self:PlaySound(cfgDialogData.BGM, Constant.SoundGroup.BGM)
	self:PlaySound(cfgDialogData.SE, Constant.SoundGroup.ENVIRONMENT)
end

function DialogUI:PlaySound(soundCid, group, forceSwitch)
	if soundCid == 0 then
		soundCid = nil
	end

	local curSoundCid

	if self.LastSoundCid[group] ~= nil then
		curSoundCid = self.LastSoundCid[group]
	end

	if soundCid ~= nil and (curSoundCid ~= soundCid or forceSwitch) then
		if curSoundCid ~= nil then
			self:StopSound(group)
		end

		if group == Constant.SoundGroup.BGM then
			EventDispatcher.Dispatch(EventID.StopBGM)

			self.ChangedBgm = true
		end

		self.LastSoundCid[group] = soundCid
		self.LastSoundSerialID[group] = GameEntry.Sound:PlaySound(soundCid, group)
	end
end

function DialogUI:StopSound(group)
	local lastCid = self.LastSoundCid[group]

	if lastCid ~= nil then
		local lastSerialId = self.LastSoundSerialID[group]
		local cfgSoundData = CfgSoundTable[lastCid]

		GameEntry.Sound:StopSound(lastSerialId, cfgSoundData.FadeOutSeconds)

		self.LastSoundCid[group] = nil
		self.LastSoundSerialID[group] = nil
	end
end

function DialogUI:StopAllSound()
	for group, lastCid in pairs(self.LastSoundCid) do
		self:StopSound(group)
	end
end

function DialogUI:RefreshNpcImage(npcCids, soulActionCids, spineActionCids, currentPlayerIndex)
	for i = 1, 5 do
		local npcPortraitUI = self.NpcPortraitUIs[i]
		local npcCid = npcCids[i]

		if npcCid == nil then
			npcCid = 0
		end

		local soulActionCid = soulActionCids[i]

		if soulActionCid == nil then
			soulActionCid = 0
		end

		local spineActionCid = spineActionCids[i]

		if spineActionCid == nil then
			spineActionCid = "0"
		end

		npcPortraitUI:Show(npcCid, soulActionCid, spineActionCid, i == currentPlayerIndex)
	end
end

function DialogUI:ShowOptions()
	self.IsSkipMode = false

	self.SkipBtn:SetActive(false)

	local gridComponent = self.SelectBtnGroup:GetComponent("GridLayoutGroup")

	gridComponent.enabled = false
	self.OptionBtns = {}
	self.OptionCountdowns = {}
	self.DelegateOnClickOptionList = {}

	local text, title, button, buttonComponent, optionBtnType
	local maxCountdownValue = -1

	for i = 1, #self.CurrentCfgData.JumpID do
		if ConditionModule.Check(self.CurrentCfgData.ChooseCondition[i]) then
			text = self.CurrentCfgData.NextDialogName[i]
			title = self.CurrentCfgData.NextDialogTitle[i]
			optionBtnType = self.CurrentCfgData.NextDialogType[i]
			optionBtnType = optionBtnType ~= nil and optionBtnType or 1
			button = self.OptionBtnPools[optionBtnType]:Obtain()

			local optionButtonMap = {}

			LuaCodeInterface.BindOutlet(button, optionButtonMap)
			button:SetActive(true)

			if optionBtnType == 1 or optionBtnType == 2 then
				button.transform:SetParent(self.SelectBtnGroup.transform, false)
			else
				button.transform:SetParent(self.ImgOptionBtnGroup.transform, false)
			end

			button.transform.localScale = Vector3.one

			local realSelectionConditionCid = self.CurrentCfgData.RealSelectionCondition[i]

			realSelectionConditionCid = realSelectionConditionCid or 0

			local canClick = ConditionModule.Check(realSelectionConditionCid)
			local canClickConditionDesc

			if not canClick then
				local cfgConditionData = CfgConditionTable[realSelectionConditionCid]

				canClickConditionDesc = cfgConditionData.Name
			end

			UGUIUtil.SetText(optionButtonMap.Text, DialogUIApi:GetString("BtnSelectTxt", text, canClick, canClickConditionDesc))

			if optionButtonMap.DisabledText ~= nil then
				UGUIUtil.SetText(optionButtonMap.DisabledText, DialogUIApi:GetString("BtnSelectTxt", text, canClick, canClickConditionDesc))
			end

			if optionButtonMap.TitleText ~= nil then
				optionButtonMap.TitleText:GetComponent("Text").text = DialogUIApi:GetString("BtnSelectTitleTxt", title)
			end

			if optionButtonMap.Icon ~= nil then
				AssetUtil.LoadAsset(self, UIGlobalApi.GetImagePath(self.CurrentCfgData.NextDialogPicture[i]), self.OnLoadSucceed, self.OnLoadFailed, optionButtonMap.Icon:GetComponent("Image"))
			end

			buttonComponent = button:GetComponent("Button")

			local function delegateOnClickOption()
				if canClick then
					self:OnClickOption(i)
				else
					NoticeModule.ShowNotice(21045063)
				end
			end

			buttonComponent.onClick:AddListener(delegateOnClickOption)

			self.OptionBtns[i] = buttonComponent
			self.DelegateOnClickOptionList[i] = delegateOnClickOption

			self:SetOptionBtnInteractable(buttonComponent, canClick)
			LuaCodeInterface.ClearOutlet(button, optionButtonMap)
		else
			self.OptionBtns[i] = nil
			self.DelegateOnClickOptionList[i] = nil
		end

		if self.CurrentCfgData.ContinueTime[i] > 0 then
			self.OptionCountdowns[i] = self.CurrentCfgData.ContinueTime[i]
		else
			self.OptionCountdowns[i] = -1
		end

		if self.OptionCountdowns[i] > 0 then
			maxCountdownValue = math.max(maxCountdownValue, self.OptionCountdowns[i])
		end
	end

	self.MaxCountdownValue = maxCountdownValue

	self.CountdownBar:SetActive(maxCountdownValue > 0)

	if maxCountdownValue > 0 then
		self.CountdownText:GetComponent("Text").text = tostring(maxCountdownValue)
		self.CountdownBar:GetComponent("Slider").value = 1
	end

	gridComponent.enabled = true
	self.ShowingOptions = true
end

function DialogUI:OnClickOption(index)
	if self:IsLocking() then
		return
	end

	self:ClearOptions()
	self:ToNextDialog(index)

	self.ShowingOptions = false
end

function DialogUI:ClearOptions(isDestroy)
	if self.OptionBtns ~= nil then
		for i, buttonComponent in pairs(self.OptionBtns) do
			if buttonComponent ~= nil then
				local delegateOnClickOption = self.DelegateOnClickOptionList[i]

				buttonComponent.onClick:RemoveListener(delegateOnClickOption)
				self:SetOptionBtnInteractable(buttonComponent, true)

				if not isDestroy then
					buttonComponent.transform:SetParent(self.UIController.transform, false)
				end

				buttonComponent.gameObject:SetActive(false)

				local optionButtonType = self.CurrentCfgData.NextDialogType[i]

				optionButtonType = optionButtonType ~= nil and optionButtonType or 1

				self.OptionBtnPools[optionButtonType]:Release(buttonComponent.gameObject)
			end
		end
	end

	self.OptionBtns = nil
	self.DelegateOnClickOptionList = nil
	self.OptionCountdowns = nil
	self.OptionCDText = nil
	self.CountdownText:GetComponent("Text").text = ""

	self.CountdownBar:SetActive(false)
end

function DialogUI:GetFinalText(content)
	if PlayerModule.PlayerInfo.baseInfo.pName ~= nil then
		content = string.gsub(content, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)
	end

	return content
end

function DialogUI:GetCurContent(contents)
	local len = #contents

	if len == 0 then
		return nil, nil
	end

	local beforeContents, curContent

	for i = 1, #contents do
		if i < self.ContentStep then
			if i == 1 then
				beforeContents = {}
			end

			table.insert(beforeContents, self:GetFinalText(contents[i]))
		else
			curContent = self:GetFinalText(contents[i])

			break
		end
	end

	return curContent, beforeContents
end

function DialogUI:OnClickReviewBtn()
	self.AutoPlayStateBeforeReview = self.IsAutoPlay

	self:SetIsAutoPlay(false)
	self.ReviewBtn:SetActive(false)
	UIModule.Open(Constant.UIControllerName.DialogReviewUI, Constant.UILayer.UI, {
		records = self.DialogIdRecords,
		onClose = function()
			self:OnReviewUIClosed()
		end
	})
end

function DialogUI:OnReviewUIClosed()
	self.ReviewBtn:SetActive(true)
	self:SetIsAutoPlay(self.AutoPlayStateBeforeReview)
end

function DialogUI:OnClickPlayBtn()
	self:SetIsAutoPlay(true)
end

function DialogUI:OnClickPauseBtn()
	self:SetIsAutoPlay(false)
end

function DialogUI:SetIsAutoPlay(value)
	self.IsAutoPlay = value

	self.PlayBtn:SetActive(not value)
	self.PauseBtn:SetActive(value)

	local sfAnimation = self.AutoPlayAnimationNode:GetComponentInChildren(typeof(IQIGame.Onigao.Game.FrameSequenceComponent))

	if self.IsAutoPlay then
		sfAnimation:Play()
	else
		sfAnimation:Stop()
	end
end

function DialogUI:OnClickSkipBtn()
	if self:IsLocking() then
		return
	end

	DialogModule.CheckSkip(self.CurrentCfgData.Id, function()
		self.IsSkipMode = true
		self.HasServiceFollowedWhenSkip = self:CheckHasFollowedServiceNeedToChoose()

		self.PerformanceHelper.Text:StopAll()
		self:OnContinue()
	end)
end

function DialogUI:CheckHasFollowedServiceNeedToChoose()
	local needChoose = self:__CheckServiceFollowedRecursively(self.CurrentCfgData.Id)

	return needChoose
end

function DialogUI:__CheckServiceFollowedRecursively(dialogCid)
	if dialogCid == 0 or dialogCid == -1 then
		return false
	end

	local cfgDialogData = CfgDialogTable[dialogCid]

	if cfgDialogData == nil then
		logError("找不到对话id：" .. dialogCid)

		return true
	end

	local jumpIDLength = #cfgDialogData.JumpID
	local sampleAvailableOptionIndex = 1

	if jumpIDLength > 1 then
		jumpIDLength = 0

		for i = 1, #cfgDialogData.JumpID do
			if ConditionModule.Check(cfgDialogData.ChooseCondition[i]) then
				jumpIDLength = jumpIDLength + 1
				sampleAvailableOptionIndex = i
			end
		end
	end

	if jumpIDLength == 0 then
		logError("存在所有选择都不符合条件的节点。对话id：" .. dialogCid)

		return true
	end

	if jumpIDLength == 1 then
		return self:__CheckServiceFollowedRecursively(cfgDialogData.JumpID[sampleAvailableOptionIndex])
	end

	local allRootServiceBranchList = {}
	local layer = 1

	for i = 1, #cfgDialogData.JumpID do
		table.insert(allRootServiceBranchList, {
			isLoop = false,
			list = {}
		})
		self:__CheckBranchServiceRecursively(cfgDialogData.JumpID[i], cfgDialogData.JumService[i], {}, allRootServiceBranchList, allRootServiceBranchList[#allRootServiceBranchList], layer)
	end

	local notEquals = false
	local lastBranchServiceDataList

	for i = 1, #allRootServiceBranchList do
		local oneBranchServiceData = allRootServiceBranchList[i]

		if not oneBranchServiceData.isLoop or #oneBranchServiceData.list > 0 then
			local oneBranchServiceDataList = oneBranchServiceData.list

			table.sort(oneBranchServiceDataList, function(data1, data2)
				return data1.layer < data2.layer
			end)

			if lastBranchServiceDataList ~= nil then
				if #oneBranchServiceDataList ~= #lastBranchServiceDataList then
					notEquals = true

					break
				end

				local serviceList1 = {}

				for j = 1, #oneBranchServiceDataList do
					serviceList1[j] = oneBranchServiceDataList[j].services
				end

				local serviceList2 = {}

				for j = 1, #lastBranchServiceDataList do
					serviceList2[j] = lastBranchServiceDataList[j].services
				end

				for j = 1, #oneBranchServiceDataList do
					local oneOptionServices1 = serviceList1[j]
					local oneOptionServices2 = serviceList2[j]

					if not table.elementEquals(oneOptionServices1, oneOptionServices2) then
						notEquals = true

						break
					end
				end
			end

			lastBranchServiceDataList = oneBranchServiceDataList
		end
	end

	return notEquals
end

function DialogUI:__CheckBranchServiceRecursively(dialogCid, services, checkedIdRecords, allServiceBranchList, thisBranchData, layer)
	local cfgDialogData

	if dialogCid ~= 0 and dialogCid ~= -1 then
		cfgDialogData = CfgDialogTable[dialogCid]

		if cfgDialogData == nil then
			logError("找不到对话id：" .. dialogCid)

			return
		end

		if checkedIdRecords[dialogCid] ~= nil then
			thisBranchData.isLoop = true

			return
		end

		checkedIdRecords[dialogCid] = dialogCid
	end

	if services == nil then
		services = {}
	end

	if #services > 1 or #services == 1 and services[1] ~= 38900001 and services[1] ~= 38900010 and services[1] ~= 38900020 and services[1] ~= 38000101 then
		table.insert(thisBranchData.list, {
			layer = layer,
			services = services
		})
	end

	if dialogCid == 0 or dialogCid == -1 then
		return
	end

	local curBranchList = {}
	local records = {}

	table.insert(curBranchList, thisBranchData)
	table.insert(records, checkedIdRecords)

	if #cfgDialogData.JumpID > 1 then
		for i = 1, #cfgDialogData.JumpID - 1 do
			local newBranch = {}

			newBranch.isLoop = thisBranchData.isLoop
			newBranch.list = table.clone(thisBranchData.list)

			table.insert(curBranchList, newBranch)
			table.insert(allServiceBranchList, newBranch)

			local newRecords = table.clone(checkedIdRecords)

			table.insert(records, newRecords)
		end
	end

	layer = layer + 1

	for i = 1, #cfgDialogData.JumpID do
		self:__CheckBranchServiceRecursively(cfgDialogData.JumpID[i], cfgDialogData.JumService[i], records[i], allServiceBranchList, curBranchList[i], layer)
	end
end

function DialogUI:SkipCurrentDialog(dialogCid, index)
	if dialogCid > 0 then
		self.CurrentCfgData = CfgDialogTable[dialogCid]

		if self.CurrentCfgData.Background ~= "" then
			self.LastCfgBackgroundPath = self.CurrentCfgData.Background
		end
	end

	self:ToNextDialog(index)
end

function DialogUI:SetSceneCameraBlur(value)
	if self.LastBlurBg == value then
		return
	end

	self.LastBlurBg = value

	local blurCameraGo = UnityEngine.GameObject.Find("Blur Camera")

	self.BlurBackground:SetActive(blurCameraGo ~= nil and value)

	if blurCameraGo ~= nil then
		local imageBlurController = blurCameraGo:GetComponent("ImageBlurController")

		if imageBlurController ~= nil then
			self.BlurBackground:GetComponent("RawImage").texture = imageBlurController.RtTexture

			imageBlurController:RefreshRt()
		end
	end
end

return DialogUI
