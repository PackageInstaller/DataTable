-- chunkname: @IQIGame\\UI\\DualTeamExplore\\DualTeamExploreLevelEntryCell.lua

local DualTeamExploreLevelEntryBossCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreLevelEntryBossCell")
local m = {
	Index = 0,
	IsUnlock = false,
	IsSelected = false,
	IsEasyMode = false
}

function m.New(view, refBossPool, onSelect, onEnterLevel)
	local obj = Clone(m)

	obj:Init(view, refBossPool, onSelect, onEnterLevel)

	return obj
end

function m:Init(view, refBossPool, onSelect, onEnterLevel)
	self.View = view
	self.OnSelectCallback = onSelect
	self.OnEnterLevelCallback = onEnterLevel

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickSelf()
		self:OnClickSelf()
	end

	function self.DelegateOnClickOnView()
		self:OnClickOnView()
	end

	self.BossCell = DualTeamExploreLevelEntryBossCell.New(self.BossView, refBossPool)

	self:SetSelect(false)
	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSelf)
	self.OnView:GetComponent("Button").onClick:AddListener(self.DelegateOnClickOnView)
end

function m:RemoveListener()
	self.View:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickSelf)
	self.OnView:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickOnView)
end

function m:SetData(levelCid, index, isEasyMode)
	self.CfgLevelData = CfgDualTeamExploreLevelTable[levelCid]
	self.Index = index
	self.IsEasyMode = isEasyMode

	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.CfgLevelData.CoverClose), self.OffImage:GetComponent("Image"))
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(self.CfgLevelData.CoverOpen), self.OnImage:GetComponent("Image"))

	local isPassPreLevel = self.CfgLevelData.PreLevel == 0 or DualTeamExploreModule.IsPassedLevel(self.CfgLevelData.PreLevel, self.IsEasyMode)
	local openTime = 0

	if self.CfgLevelData.OpenDate ~= "" then
		openTime = cfgDateTimeToTimeStamp(self.CfgLevelData.OpenDate, PlayerModule.TimeZone)
	end

	local closeTime = 0

	if self.CfgLevelData.CloseDate ~= "" then
		closeTime = cfgDateTimeToTimeStamp(self.CfgLevelData.CloseDate, PlayerModule.TimeZone)
	end

	local serverTime = PlayerModule.GetServerTime()
	local isInOpenTime = (openTime == 0 or openTime < serverTime) and (closeTime == 0 or serverTime < closeTime)
	local isConditionOK = ConditionModule.Check(self.CfgLevelData.Condition)

	self.IsUnlock = isPassPreLevel and isInOpenTime and isConditionOK

	self.OffNormalView:SetActive(self.IsUnlock)
	self.OffLockView:SetActive(not self.IsUnlock)
	self.OffPlotView:SetActive(self.CfgLevelData.DialogId ~= 0)
	self.BossCell:SetData(self.CfgLevelData.Boss, self.CfgLevelData.BossWeakType)

	local pPreLevelName, pOpenTime, pServerTime, pCloseTime, pConditionName

	if not isPassPreLevel then
		local cfgDualTeamExploreLevelData = CfgDualTeamExploreLevelTable[self.CfgLevelData.PreLevel]

		pPreLevelName = cfgDualTeamExploreLevelData.Title
	end

	if not isInOpenTime then
		if openTime ~= 0 then
			pOpenTime = openTime
		end

		if pCloseTime ~= 0 then
			pCloseTime = closeTime
		end

		pServerTime = serverTime
	end

	if not isConditionOK then
		local cfgConditionData = CfgConditionTable[self.CfgLevelData.Condition]

		pConditionName = cfgConditionData.Name
	end

	UGUIUtil.SetText(self.OffUnlockConditionText, DualTeamExploreLevelEntryUIApi:GetString("LevelCellOffUnlockConditionText", pPreLevelName, pOpenTime, pServerTime, pCloseTime, pConditionName))
	UGUIUtil.SetText(self.OnLevelOrderText1, DualTeamExploreLevelEntryUIApi:GetString("LevelCellIndexText", self.Index))
	UGUIUtil.SetText(self.OnLevelOrderText2, DualTeamExploreLevelEntryUIApi:GetString("LevelCellIndexText", self.Index))
	UGUIUtil.SetTextInChildren(self.OffPlotView, DualTeamExploreLevelEntryUIApi:GetString("LevelCellOffPlotViewText"))
	UGUIUtil.SetText(self.OnLevelTitleText, self.CfgLevelData.Title)
	UGUIUtil.SetText(self.OnLevelDescText, self.CfgLevelData.Describe)
end

function m:Reset()
	self:SetSelect(false)
end

function m:SetSelect(isSelected)
	self.IsSelected = isSelected

	self.OffView:SetActive(not isSelected)
	self.OnView:SetActive(isSelected)
end

function m:Select()
	if self.IsSelected then
		return
	end

	if not self.IsUnlock then
		return
	end

	self:SetSelect(true)

	if self.OnSelectCallback ~= nil then
		self.OnSelectCallback(self)
	end
end

function m:OnClickSelf()
	if not self.IsSelected then
		self:Select()
	end
end

function m:OnClickOnView()
	if self.OnEnterLevelCallback ~= nil then
		self.OnEnterLevelCallback(self)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	self.BossCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnSelectCallback = nil
	self.CfgLevelData = nil
end

return m
