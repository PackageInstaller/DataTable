-- chunkname: @IQIGame\\UI\\ChallengeWorldBossPreviewUI.lua

local FormationEnemyView = require("IQIGame/UI/Formation/FormationEnemyView")
local MonsterHeadItem = {}

function MonsterHeadItem.New(view, clickHandler)
	local obj = Clone(MonsterHeadItem)

	obj:__Init(view, clickHandler)

	return obj
end

function MonsterHeadItem:__Init(view, clickHandler)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.__clickHandler = clickHandler

	UIEventUtil.AddClickEventListener_Button(self, "BtnRoot", self.__OnItemClickEventHandler)
end

function MonsterHeadItem:Show(monsterCid)
	self.gameObject:SetActive(true)

	self.monsterCid = monsterCid

	local monsterCfg = CfgMonsterTable[monsterCid]
	local headIconPath = SkinModule.GetHeroSkinImgPathByTypeWithSkinCid(monsterCfg.EntityID, Constant.SkinImageType.HeadIcon)

	AssetUtil.LoadImage(self, headIconPath, self.icon:GetComponent(typeof(UnityEngine.UI.Image)))

	local elementPath = WarlockApi:GetElementIconPath(monsterCfg.Elements)

	if not LuaUtility.StrIsNullOrEmpty(elementPath) then
		self.ElementIcon.gameObject:SetActive(true)
		AssetUtil.LoadImage(self, elementPath, self.ElementIcon:GetComponent("Image"))
	else
		self.ElementIcon.gameObject:SetActive(false)
	end
end

function MonsterHeadItem:__OnItemClickEventHandler()
	if self.__clickHandler == nil then
		return
	end

	self.__clickHandler(self.monsterCid)
end

function MonsterHeadItem:Hide()
	self.monsterCid = 0

	self.gameObject:SetActive(false)
end

function MonsterHeadItem:Dispose()
	UIEventUtil.ClearEventListener(self)
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

local ChallengeWorldBossPreviewUI = {
	curEnemyItemTable = {},
	nextEnemyItemTable = {}
}

ChallengeWorldBossPreviewUI = Base:Extend("ChallengeWorldBossPreviewUI", "IQIGame.Onigao.UI.ChallengeWorldBossPreviewUI", ChallengeWorldBossPreviewUI)

function ChallengeWorldBossPreviewUI:OnInit()
	ForTransformChild(self.CurrentEnemyRoot.transform, function(_trans, _index)
		local item = MonsterHeadItem.New(_trans.gameObject, function(_monsterCid)
			self:__OnShowCurMonsterTeamView(_monsterCid)
		end)

		table.insert(self.curEnemyItemTable, item)
	end)
	ForTransformChild(self.NextEnemyRoot.transform, function(_trans, _index)
		local item = MonsterHeadItem.New(_trans.gameObject, function(_monsterCid)
			self:__OnShowNextMonsterTeamView(_monsterCid)
		end)

		table.insert(self.nextEnemyItemTable, item)
	end)

	self.monsterTeamView = FormationEnemyView.New(self.EnemyTeamViewRoot)
	self.commonReturnBtn = CommonReturnBtn.New(self.CommonReturnBtnRoot, self)
end

function ChallengeWorldBossPreviewUI:GetPreloadAssetPaths()
	return nil
end

function ChallengeWorldBossPreviewUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function ChallengeWorldBossPreviewUI:IsManualShowOnOpen(userData)
	return false
end

function ChallengeWorldBossPreviewUI:GetBGM(userData)
	return nil
end

function ChallengeWorldBossPreviewUI:OnOpen(userData)
	self.monsterTeamView:Hide()
	self:__RefreshShow()
end

function ChallengeWorldBossPreviewUI:OnClose(userData)
	return
end

function ChallengeWorldBossPreviewUI:OnAddListeners()
	return
end

function ChallengeWorldBossPreviewUI:OnRemoveListeners()
	return
end

function ChallengeWorldBossPreviewUI:OnPause()
	return
end

function ChallengeWorldBossPreviewUI:OnResume()
	return
end

function ChallengeWorldBossPreviewUI:OnCover()
	return
end

function ChallengeWorldBossPreviewUI:OnReveal()
	return
end

function ChallengeWorldBossPreviewUI:OnRefocus(userData)
	return
end

function ChallengeWorldBossPreviewUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function ChallengeWorldBossPreviewUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function ChallengeWorldBossPreviewUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function ChallengeWorldBossPreviewUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function ChallengeWorldBossPreviewUI:OnDestroy()
	self.commonReturnBtn:Dispose()
	ForArray(self.curEnemyItemTable, function(k, v)
		v:Dispose()
	end)
	ForArray(self.nextEnemyItemTable, function(k, v)
		v:Dispose()
	end)
	self.monsterTeamView:Dispose()
end

function ChallengeWorldBossPreviewUI:__RefreshShow()
	local activityPOD = ChallengeWorldBossModule.GetCurWorldBossPOD()
	local curChapterCfg = ChallengeWorldBossModule.GetChapterCfgByActivityOpenCount(activityPOD.openCount)
	local curStageCfg = ChallengeWorldBossModule.GetCurWorldBossStageCfg(curChapterCfg.Id)

	self.curMonsterTeam = self:__RefreshData(curStageCfg, self.curEnemyItemTable, self.CurrentBossNameText)

	local nextChapterCfg = ChallengeWorldBossModule.GetChapterCfgByActivityOpenCount(activityPOD.openCount + 1)
	local nextStageCfg = ChallengeWorldBossModule.GetCurWorldBossStageCfg(nextChapterCfg.Id)

	self.nextMonsterTeam = self:__RefreshData(nextStageCfg, self.nextEnemyItemTable, self.NextBossNameText)
end

function ChallengeWorldBossPreviewUI:__RefreshData(stageData, enemyList, nameText)
	nameText:GetComponent("Text").text = stageData.Describe

	local monsters = CfgMonsterTeamTable[stageData.MonsterTeam[1]].MonsterTeam

	ForArray(enemyList, function(_index, _cell)
		local monsterCid = GetArrayValue(monsters, _index, 0)

		if monsterCid == 0 then
			_cell:Hide()
		else
			_cell:Show(monsterCid)
		end
	end)

	return stageData.MonsterTeam
end

function ChallengeWorldBossPreviewUI:__OnShowCurMonsterTeamView(monsterCid)
	self.monsterTeamView:Show(self.curMonsterTeam)
end

function ChallengeWorldBossPreviewUI:__OnShowNextMonsterTeamView(monsterCid)
	self.monsterTeamView:Show(self.nextMonsterTeam)
end

return ChallengeWorldBossPreviewUI
