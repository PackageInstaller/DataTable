-- chunkname: @IQIGame\\UI\\Maze\\MazeInstanceCell.lua

local m = {
	IsUnlock = false,
	PlayedUnlockAnim = false,
	IsQuickUnlock = false,
	IsLevelEnough = false,
	UnlockEffectPlayIds = {}
}

function m.New(view, canvas, clickCallback)
	local obj = Clone(m)

	obj:Init(view, canvas, clickCallback)

	return obj
end

function m:Init(view, canvas, clickCallback)
	self.View = view
	self.Canvas = canvas
	self.ClickCallback = clickCallback

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClick()
		self:OnClick()
	end

	function self.DelegateOnQuickClick()
		self:OnQuickClick()
	end

	self.FirstRewardCell = ItemCell.New(self.FirstRewardCellGo, false)

	self.FirstRewardCell:SetMouseEnabled(false)
	self.ClearView:SetActive(false)
end

function m:AddListeners()
	local button = self.Background:GetComponent("Button")

	if button == nil then
		button = self.Background:AddComponent(typeof(UnityEngine.UI.Button))
	end

	button.onClick:AddListener(self.DelegateOnClick)

	local quickButton = self.QuickChallenge:GetComponentInChildren(typeof(UnityEngine.UI.Button))

	quickButton.onClick:AddListener(self.DelegateOnQuickClick)
end

function m:RemoveListeners()
	local button = self.Background:GetComponent("Button")

	if button ~= nil then
		button.onClick:RemoveListener(self.DelegateOnClick)
	end

	local quickButton = self.QuickChallenge:GetComponentInChildren(typeof(UnityEngine.UI.Button))

	quickButton.onClick:RemoveListener(self.DelegateOnQuickClick)
end

function m:SetData(bg, cfgMazeInstanceData, isAreaUnlock, chapterOrder, minOrderLockCfg)
	self.Background = bg

	self.View.transform:SetParent(self.Background.transform:Find("Point"), false)

	self.CfgMazeInstanceData = cfgMazeInstanceData
	self.IsLevelEnough = PlayerModule.PlayerInfo.baseInfo.pLv >= cfgMazeInstanceData.LockLevel
	self.IsUnlock = ConditionModule.Check(cfgMazeInstanceData.LockCondition)
	self.IsQuickUnlock = ConditionModule.Check(cfgMazeInstanceData.QuickChallengeLockCondition)

	if cfgMazeInstanceData.QuickChallengeLockCondition == 0 then
		self.IsQuickUnlock = self.IsUnlock
	end

	self.View:SetActive(isAreaUnlock and (self.IsQuickUnlock or minOrderLockCfg.Id == self.CfgMazeInstanceData.Id))
	self.Background:SetActive(true)

	self.Background:GetComponentInChildren(typeof(UnityEngine.UI.HighlightImage)).color = hexStringToColor(MazeSelectLevelUIApi:GetString("BackgroundColor", isAreaUnlock))

	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.CfgMazeInstanceData.Id]
	local isComplete = mazeInfoPOD ~= nil and mazeInfoPOD.score >= 100

	self.NormalView:SetActive(not isComplete)

	if not isComplete then
		local progress = 0

		if mazeInfoPOD ~= nil then
			progress = mazeInfoPOD.score / 100
		end

		self.ExploreProgressBar:GetComponent("Image").fillAmount = progress
	end

	self.CompleteView:SetActive(self.IsUnlock and isComplete)
	self.LockView:SetActive(not self.IsQuickUnlock)

	if not self.IsQuickUnlock then
		local cfgConditionData = (cfgMazeInstanceData.QuickChallengeLockCondition ~= 0 and {
			CfgConditionTable[cfgMazeInstanceData.QuickChallengeLockCondition]
		} or {
			CfgConditionTable[cfgMazeInstanceData.LockCondition]
		})[1]

		UGUIUtil.SetText(self.UnlockConditionText, cfgConditionData.Name)
	end

	local orderText = MazeSelectLevelUIApi:GetString("MazeInstanceNameText", false, chapterOrder, cfgMazeInstanceData.Order, cfgMazeInstanceData.Name, PlayerModule.PlayerInfo.baseInfo.pLv, cfgMazeInstanceData.LockLevel)

	UGUIUtil.SetText(self.OrderText1, orderText)
	UGUIUtil.SetText(self.OrderText2, orderText)
	AssetUtil.LoadImage(self, MazeSelectLevelUIApi:GetString("MazeInstanceTypeIcon", cfgMazeInstanceData.MapCellRes), self.TypeIcon:GetComponent("Image"))
	self.FirstRewardCell:SetItemByCID(cfgMazeInstanceData.RewardShow[1])

	self.View.name = "Maze_" .. self.CfgMazeInstanceData.Id

	if self:IsNormalMazeNewUnlock() and not self.PlayedUnlockAnim then
		self.UnlockEffectTimer = Timer.New(function()
			self.UnlockEffectTimer = nil

			table.insert(self.UnlockEffectPlayIds, GameEntry.Effect:PlayUIMountPointEffect(9000918, 50000, 0, self.View, self.Canvas.sortingOrder + 6))
		end, 0.5)

		self.UnlockEffectTimer:Start()

		self.PlayedUnlockAnim = true
	end

	local isFinished = table.indexOf(PlayerModule.PlayerInfo.finishMazes, self.CfgMazeInstanceData.Id) ~= -1
	local isQuickFinished = table.indexOf(PlayerModule.PlayerInfo.quickChallenge, self.CfgMazeInstanceData.Id) ~= -1

	self.ClearView:SetActive(isFinished)
	self.ClearQuickView:SetActive(not isFinished and isQuickFinished)
	self.QuickChallenge:SetActive(not isQuickFinished and self.IsQuickUnlock and cfgMazeInstanceData.QuickChallengeOpen)

	local showTipsCondition = ConditionModule.Check(cfgMazeInstanceData.ShowTipsCondition)

	self.Effect:SetActive(showTipsCondition)
	self.QuickChallengeStatus:SetActive(cfgMazeInstanceData.QuickChallengeOpen)
	self.ChallengeStatus.transform:GetChild(1).gameObject:SetActive(isFinished)
	self.QuickChallengeStatus.transform:GetChild(1).gameObject:SetActive(isQuickFinished)
	self:AddListeners()
end

function m:SetUnlockConditionViewVisible(value)
	self.UnlockConditionText:SetActive(value)
end

function m:IsNormalMazeNewUnlock()
	local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[self.CfgMazeInstanceData.Id]

	return self.IsUnlock and mazeInfoPOD == nil
end

function m:OnClick()
	if not self.IsQuickUnlock then
		local cfgConditionData = CfgConditionTable[self.CfgMazeInstanceData.LockCondition]

		NoticeModule.ShowNoticeNoCallback(21045025, cfgConditionData.Name)

		return
	end

	if not self.IsLevelEnough then
		NoticeModule.ShowNotice(21045024)

		return
	end

	UIModule.Open(Constant.UIControllerName.MazeDetailUI, Constant.UILayer.UI, {
		mazeCid = self.CfgMazeInstanceData.Id
	})

	if self.ClickCallback ~= nil then
		self.ClickCallback(self)
	end
end

function m:OnQuickClick()
	UIModule.Open(Constant.UIControllerName.MazeBossUI, Constant.UILayer.UI, {
		mazeCid = self.CfgMazeInstanceData.Id
	})
end

function m:Highlight(value)
	if self.Background then
		self.Background:GetComponentInChildren(typeof(UnityEngine.UI.HighlightImage)).highlight = value
	end
end

function m:SetIsNewestMaze()
	self.NewMazeBg:SetActive(true)

	self.OrderText1:GetComponent("Text").color = Color.black
end

function m:StopEffects()
	for i = 1, #self.UnlockEffectPlayIds do
		GameEntry.Effect:StopEffect(self.UnlockEffectPlayIds[i])
	end

	self.UnlockEffectPlayIds = {}
end

function m:Clear(isDestroy)
	self:RemoveListeners()
	self.NewMazeBg:SetActive(false)

	self.OrderText1:GetComponent("Text").color = Color.white
	self.PlayedUnlockAnim = false

	if self.UnlockEffectTimer ~= nil then
		self.UnlockEffectTimer:Stop()

		self.UnlockEffectTimer = nil
	end

	if not isDestroy then
		self:StopEffects()
		self.View.transform:SetParent(GameEntry.UICom.transform, false)
	end

	self.View:SetActive(false)

	self.Background = nil
	self.CfgMazeInstanceData = nil
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Canvas = nil
	self.ClickCallback = nil
end

return m
