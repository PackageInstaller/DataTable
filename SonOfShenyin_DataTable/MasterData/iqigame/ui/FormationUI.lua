-- chunkname: @IQIGame\\UI\\FormationUI.lua

local FormationUI = {
	IsPresetFormation = true
}

FormationUI = Base:Extend("FormationUI", "IQIGame.Onigao.UI.FormationUI", FormationUI)

local gameFormationView = require("IQIGame.UI.Formation.GameFormationView")
local formationInfoView = require("IQIGame.UI.Formation.FormationInfoView")
local formationRoleInfoView = require("IQIGame.UI.Formation.FormationRoleInfoView")
local formationTerrainDetailsView = require("IQIGame.UI.Formation.FormationTerrainDetailsView")
local FormationEnemyView = require("IQIGame/UI/Formation/FormationEnemyView")

function FormationUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnOpenRoleDetailsEvent(isOpen, heroData, boxIndex)
		self:OnOpenRoleDetailsEvent(isOpen, heroData, boxIndex)
	end

	function self.DelegateOnOpenTerrsinDetailsPanelEvent()
		self:OnOpenTerrainDetailsPanel()
	end

	function self.DelegateOnOpenMonsterDetailUIEvent()
		self:OnOpenMonsterDetailUI()
	end

	function self.DelegateOnClickStartBtn()
		self:OnClickStartBtn()
	end

	function self.DelegateOnClickSaveBtn()
		self:OnClickSaveBtn()
	end

	function self.DelegateBtnHelperClickProxy()
		self.Help:SetActive(true)
	end

	self.GameFormationView = gameFormationView.New(self.GameFormationPanel, self.UIController, self)
	self.FormationInfoView = formationInfoView.New(self.FormationInfoPanel)
	self.FormationRoleInfoView = formationRoleInfoView.New(self.FormationRoleInfoPanel, self.UIController)
	self.FormationTerrainDetailsView = formationTerrainDetailsView.New(self.TerrainDetailsPanel)
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)

	self.commonReturnBtn:RegisterReturnEvent(self.DelegateOnClickCloseBtn)

	self.monsterTeamView = FormationEnemyView.New(self.EnemyTeamViewRoot)

	function self.DelegateOnShowMonsterTeamViewEventProxy()
		self:__OnShowMonsterTeamViewEvent()
	end
end

function FormationUI:GetPreloadAssetPaths()
	return nil
end

function FormationUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function FormationUI:IsManualShowOnOpen(userData)
	return false
end

function FormationUI:GetBGM(userData)
	return nil
end

function FormationUI:OnOpen(userData)
	self.FightCount = userData.FightCount ~= nil and userData.FightCount or 1

	self.monsterTeamView:Hide()

	self.CloseCallback = userData.CloseCallback
	self.startFunction = userData.startFunction
	self.CfgDupStageOrStoryBattle = nil
	FormationModule.CfgDupStageOrStoryBattleCfg = nil

	FormationModule.InitAboutMazeData()

	self.StageId = userData.StageId
	self.ChapterType = userData.ChapterType

	if userData.OpenType == Constant.FormationOpenType.Maze then
		FormationModule.FormationTypeIsMaze = true
	else
		FormationModule.FormationTypeIsMaze = false
	end

	self.BattleId = userData.StoryBattleId
	self.CfgDupStageOrStoryBattle = FormationModule.GetChapterConfigByType(userData.ChapterType, userData.StageId, userData.StoryBattleId)

	if userData.MonsterTeam ~= nil then
		self.MonsterTeam = userData.MonsterTeam
	elseif self.CfgDupStageOrStoryBattle ~= nil then
		if self.ChapterType == Constant.ChapterPassType.TYPE_RESOURCES then
			self.MonsterTeam = self.CfgDupStageOrStoryBattle.MonsterTeam
		else
			self.MonsterTeam = self.CfgDupStageOrStoryBattle.MonsterTeam
		end
	end

	if self.CfgDupStageOrStoryBattle then
		GlobalBuffModule.SetConditionData_CURRENT_FIGHT(userData.ChapterType, self.CfgDupStageOrStoryBattle.ChapterId, userData.StageId, self.MonsterTeam[1])
	end

	self.IsActiveHomeBtn = true

	if userData.IsActiveHomeBtn ~= nil then
		self.IsActiveHomeBtn = userData.IsActiveHomeBtn
	elseif self.CfgDupStageOrStoryBattle ~= nil and self.CfgDupStageOrStoryBattle.IsNotActiveHomeBtn ~= nil then
		self.IsActiveHomeBtn = self.CfgDupStageOrStoryBattle.IsNotActiveHomeBtn == false
	end

	self.IsActiveReturnBtn = true

	if userData.IsActiveReturnBtn ~= nil then
		self.IsActiveReturnBtn = userData.IsActiveReturnBtn
	elseif self.CfgDupStageOrStoryBattle ~= nil and self.CfgDupStageOrStoryBattle.IsNotActiveReturnBtn ~= nil then
		self.IsActiveReturnBtn = self.CfgDupStageOrStoryBattle.IsNotActiveReturnBtn == false
	end

	self.commonReturnBtn:SetState(self.IsActiveReturnBtn)
	self.commonReturnBtn:SetHomeBtnState(self.IsActiveHomeBtn)
	self.commonReturnBtn:RegisterBackHomeEvent(userData.backHomeCallBack)

	self.IsActiveCultivateBtn = userData.IsActiveReturnBtn == nil and true or userData.IsActiveReturnBtn

	if userData.OnlyFormation == nil then
		-- block empty
	end

	self.OnlyFormation = userData.OnlyFormation

	self:RefreshOnlyFormation()
	self:Init()
	self:ResetToDefault()
end

function FormationUI:OnClose(userData)
	GlobalBuffModule.ClearConditionData_CURRENT_FIGHT()
	self.GameFormationView:Hide()
	UIModule.Close(Constant.UIControllerName.FormationAgentSkillSelectUI)
	self:ResetToOrigin()
end

function FormationUI:OnAddListeners()
	self.btnHelp:GetComponent("Button").onClick:AddListener(self.DelegateBtnHelperClickProxy)
	self.StartBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickStartBtn)
	self.SaveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSaveBtn)
	EventDispatcher.AddEventListener(EventID.FormationHelpEvent, self.DelegateBtnHelperClickProxy)
	EventDispatcher.AddEventListener(EventID.FormationHeroOnLongClickEvent, self.DelegateOnOpenRoleDetailsEvent)
	EventDispatcher.AddEventListener(EventID.FormationOpenTerrainDetailsEvent, self.DelegateOnOpenTerrsinDetailsPanelEvent)
	EventDispatcher.AddEventListener(EventID.FormationOpenMonsterDetailEvent, self.DelegateOnOpenMonsterDetailUIEvent)
	EventDispatcher.AddEventListener(EventID.ShowFormationMonsterTeamView, self.DelegateOnShowMonsterTeamViewEventProxy)
end

function FormationUI:OnRemoveListeners()
	self.btnHelp:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnHelperClickProxy)
	self.StartBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickStartBtn)
	self.SaveBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickSaveBtn)
	EventDispatcher.RemoveEventListener(EventID.FormationHelpEvent, self.DelegateBtnHelperClickProxy)
	EventDispatcher.RemoveEventListener(EventID.FormationHeroOnLongClickEvent, self.DelegateOnOpenRoleDetailsEvent)
	EventDispatcher.RemoveEventListener(EventID.FormationOpenTerrainDetailsEvent, self.DelegateOnOpenTerrsinDetailsPanelEvent)
	EventDispatcher.RemoveEventListener(EventID.FormationOpenMonsterDetailEvent, self.DelegateOnOpenMonsterDetailUIEvent)
	EventDispatcher.RemoveEventListener(EventID.ShowFormationMonsterTeamView, self.DelegateOnShowMonsterTeamViewEventProxy)
end

function FormationUI:OnPause()
	return
end

function FormationUI:OnResume()
	self:ResetToDefault()
end

function FormationUI:OnCover()
	return
end

function FormationUI:OnReveal()
	self:ResetToDefault()
end

function FormationUI:OnRefocus(userData)
	return
end

function FormationUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.GameFormationView:Update(elapseSeconds, realElapseSeconds)
end

function FormationUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function FormationUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function FormationUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function FormationUI:OnDestroy()
	self.monsterTeamView:Dispose()
	self.GameFormationView:Dispose()
	self.FormationInfoView:Dispose()
	self.FormationRoleInfoView:Dispose()
	self.FormationTerrainDetailsView:Dispose()
	self.commonReturnBtn:Dispose()
	AssetUtil.UnloadAsset(self)
end

function FormationUI:Init()
	FormationModule.CfgDupStageOrStoryBattleCfg = self.CfgDupStageOrStoryBattle
	FormationModule.ChapterType = self.ChapterType
	FormationModule.TeamIndex = 1

	if self.OnlyFormation then
		self.FormationInfoView:Hide()
	else
		self.FormationInfoView:SetData()
		self.FormationInfoView:Show()
		self.FormationInfoView:SetTerrainInfo()
		self.FormationInfoView:SetDefaultInfo(FormationModule.FormationTypeIsMaze)
	end

	self.GameFormationView:Show(self.OnlyFormation)
	self.FormationRoleInfoView:Hide()
end

function FormationUI:OnOpenRoleDetailsEvent(isOpen, heroData, boxIndex)
	if heroData == nil or heroData.TheType == CombatFormationModel.WarkLockType.NPC then
		return
	end

	if isOpen then
		self.FormationRoleInfoView:Show()
		self.FormationRoleInfoView:SetData(heroData, boxIndex, self.IsActiveCultivateBtn)
	else
		self.FormationRoleInfoView:Hide()
	end
end

function FormationUI:OnOpenTerrainDetailsPanel()
	local friendly = self.GameFormationView.isSeePlayerTeam

	self.FormationTerrainDetailsView:SetData(friendly)
	self.FormationTerrainDetailsView:Show()
end

function FormationUI:OnOpenMonsterDetailUI()
	local userData = {
		MonsterTeam = self.MonsterTeam,
		IsActiveHomeBtn = self.IsActiveHomeBtn
	}

	UIModule.Open(Constant.UIControllerName.MonsterDetailUI, Constant.UILayer.UI, userData)
end

function FormationUI:OnClickStartBtn()
	if self.startFunction then
		self.startFunction()

		return
	end

	if table.len(FormationModule.CurFormationDataList) <= 0 then
		NoticeModule.ShowNotice(49008)

		return
	elseif table.len(FormationModule.CurFormationDataList) == 1 then
		for k, v in pairs(FormationModule.CurFormationDataList) do
			if v.isHelpHeroData then
				NoticeModule.ShowNotice(49008)

				return
			end
		end
	end

	local isBan = false

	for k, v in pairs(FormationModule.CurFormationDataList) do
		if v ~= nil then
			isBan = FormationModule.GetTerrainIsCanGointo(k, true).Used == 0

			if isBan then
				break
			end
		end
	end

	if isBan then
		NoticeModule.ShowNotice(49007)

		return
	end

	local isCanGointoBattle = self.GameFormationView.IsCanGointoBattle
	local enterDupData = {}

	enterDupData.ChapterType = self.ChapterType
	enterDupData.PassId = self.StageId
	enterDupData.StoryBattleID = self.BattleId
	enterDupData.IsCanGoIntoBattle = isCanGointoBattle
	enterDupData.Units = FormationModule.CreateFightData()
	enterDupData.FightCount = self.FightCount
	enterDupData.FormationID = FormationModule.TeamIndex

	log(string.format("【迷宫】FormationUi --> GameChapterModule.EnterDupByChapterType : enterDupData.ChapterType = %s, enterDupData.PassId = %s, enterDupData.FormationID = %s", enterDupData.ChapterType, enterDupData.PassId, enterDupData.FormationID))
	GameChapterModule.EnterDupByChapterType(enterDupData)
end

function FormationUI:OnClickSaveBtn()
	if table.len(FormationModule.CurFormationDataList) <= 0 then
		NoticeModule.ShowNotice(49008)

		return
	end

	if self.CloseCallback then
		self.CloseCallback()

		return
	end

	UIModule.Close(Constant.UIControllerName.FormationUI)
end

local enableSpineLightingGlobal = "_BaseMapToggle"

function FormationUI:ResetToDefault()
	self.previousConfig = SceneRenderConfigManager.GetCurrentConfig()

	SceneRenderConfigManager.SetDefaultConfig()
	UnityEngine.Shader.SetGlobalFloat(enableSpineLightingGlobal, 1)
end

function FormationUI:ResetToOrigin()
	if self.previousConfig then
		SceneRenderConfigManager.ApplyConfig(self.previousConfig)
	end

	UnityEngine.Shader.SetGlobalFloat(enableSpineLightingGlobal, 0)
end

function FormationUI:OnClickCloseBtn()
	if self.CloseCallback then
		self.CloseCallback()

		return
	end

	UIModule.CloseSelf(self)
end

function FormationUI:RefreshOnlyFormation()
	if self.OnlyFormation then
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn, false)
		LuaUtility.SetGameObjectShow(self.StartBtn, false)
		LuaUtility.SetGameObjectShow(self.SaveBtn, true)
	else
		LuaUtility.SetGameObjectShow(self.enemyDetailBtn, true)
		LuaUtility.SetGameObjectShow(self.StartBtn, true)
		LuaUtility.SetGameObjectShow(self.SaveBtn, false)
	end
end

function FormationUI:__OnShowMonsterTeamViewEvent()
	self.monsterTeamView:Show(self.MonsterTeam)
end

return FormationUI
