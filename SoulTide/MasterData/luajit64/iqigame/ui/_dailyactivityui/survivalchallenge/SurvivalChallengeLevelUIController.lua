-- chunkname: @IQIGame\\UI\\_DailyActivityUI\\SurvivalChallenge\\SurvivalChallengeLevelUIController.lua

local SurvivalChallengeLevelUIController = {
	survivalLevels = {},
	survivalLevelCellPool = {}
}
local SurvivalChallengeLevelCell = require("IQIGame.UI.ExploreHall.Survival.SurvivalChallengeLevel.SurvivalChallengeLevelCell")

function SurvivalChallengeLevelUIController.New(uiController)
	local obj = Clone(SurvivalChallengeLevelUIController)

	obj:__Init(uiController)

	return obj
end

function SurvivalChallengeLevelUIController:__Init(uiController)
	self.UIController = uiController
end

function SurvivalChallengeLevelUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function SurvivalChallengeLevelUIController:OnInit()
	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpDateLevel()
		self:OnUpDateLevel()
	end

	self.ScrollLevels:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderLevelCell(cell)
	end
	self.ScrollLevels:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectLevelCell(cell)
	end
end

function SurvivalChallengeLevelUIController:GetPreloadAssetPaths()
	return nil
end

function SurvivalChallengeLevelUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function SurvivalChallengeLevelUIController:IsManualShowOnOpen(userData)
	return false
end

function SurvivalChallengeLevelUIController:GetBGM(userData)
	return nil
end

function SurvivalChallengeLevelUIController:OnOpen(userData)
	self:UpdateView()
end

function SurvivalChallengeLevelUIController:OnClose(userData)
	return
end

function SurvivalChallengeLevelUIController:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.SurvivalUpDateLevelEvent, self.DelegateUpDateLevel)
end

function SurvivalChallengeLevelUIController:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.SurvivalUpDateLevelEvent, self.DelegateUpDateLevel)
end

function SurvivalChallengeLevelUIController:OnPause()
	return
end

function SurvivalChallengeLevelUIController:OnResume()
	return
end

function SurvivalChallengeLevelUIController:OnCover()
	return
end

function SurvivalChallengeLevelUIController:OnReveal()
	return
end

function SurvivalChallengeLevelUIController:OnRefocus(userData)
	return
end

function SurvivalChallengeLevelUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function SurvivalChallengeLevelUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function SurvivalChallengeLevelUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function SurvivalChallengeLevelUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function SurvivalChallengeLevelUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.survivalLevelCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function SurvivalChallengeLevelUIController:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function SurvivalChallengeLevelUIController:OnUpDateLevel()
	self:UpdateView()
end

function SurvivalChallengeLevelUIController:UpdateView()
	self.survivalLevels = {}

	for i, v in pairs(SurvivalModule.survivalChallengeLevels) do
		if v:IsOpen() then
			table.insert(self.survivalLevels, v)
		end
	end

	table.sort(self.survivalLevels, function(a, b)
		return a:GetCfgData().Id < b:GetCfgData().Id
	end)
	self.ScrollLevels:GetComponent("ScrollAreaList"):Refresh(#self.survivalLevels)
end

function SurvivalChallengeLevelUIController:OnRenderLevelCell(cell)
	local levelData = self.survivalLevels[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local survivalChallengeCell = self.survivalLevelCellPool[instanceID]

	if survivalChallengeCell == nil then
		survivalChallengeCell = SurvivalChallengeLevelCell.New(cell.gameObject)
		self.survivalLevelCellPool[instanceID] = survivalChallengeCell
	end

	survivalChallengeCell:SetData(levelData)
end

function SurvivalChallengeLevelUIController:OnSelectLevelCell(cell)
	local selectLevelData = self.survivalLevels[cell.index + 1]

	if selectLevelData:GetCfgData().Type == 1 then
		UIModule.Open(Constant.UIControllerName.SurvivalChallengeFormationUI, Constant.UILayer.UI, {
			Type = FlyGameConstant.ChallengeType.Challenge_Level_Mode,
			LevelCid = selectLevelData.cid
		})
	elseif selectLevelData:GetCfgData().Type == 2 then
		if selectLevelData.levelStatusPod then
			DialogModule.OpenDialog(selectLevelData:GetCfgData().DialogId, false, false)
		else
			SurvivalModule.StartChallenge(nil, selectLevelData.cid)
		end
	end
end

return SurvivalChallengeLevelUIController
