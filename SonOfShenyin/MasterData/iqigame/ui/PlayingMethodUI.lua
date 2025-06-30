-- chunkname: @IQIGame\\UI\\PlayingMethodUI.lua

local PlayingMethodUI = {}

PlayingMethodUI = Base:Extend("PlayingMethodUI", "IQIGame.Onigao.UI.PlayingMethodUI", PlayingMethodUI)

local commonCondition = require("IQIGame.UI.Common.Condition.CommonCondition")

function PlayingMethodUI:OnInit()
	function self.DelegateOnClickMapBtn()
		self:OnClickMapBtn()
	end

	function self.DelegateOnClickEquipBtn()
		self:OnClickEquipBtn()
	end

	function self.DelegateOnClickResBtn()
		self:OnClickResBtn()
	end

	function self.DelegateOnClickBossBtn()
		self:OnClickBossBtn()
	end

	function self.DelegateOnClickMazeBtn()
		self:OnClickMazeBtn()
	end

	function self.DelegateNotifyUpdateStage()
		self:NotifyUpdateStage()
	end

	function self.delegateOnClickButtonMaze()
		UIModule.Open(Constant.UIControllerName.MazeActivityUI, Constant.UILayer.UI)
	end

	function self.delegateOnClickButtonBattleActivity()
		UIModule.Open(Constant.UIControllerName.BattleActivityDungeonUI, Constant.UILayer.UI)
	end

	self.MapSignimgCom = self.MapSignimg:GetComponent("Image")
	self.commonReturnBtn = CommonReturnBtn.New(self.Com_ReturnBtn, self)
	self.resCommonCondition = commonCondition.New(self.resLockState)
	self.mainCommonCondition = commonCondition.New(self.mainLockState)
	self.equipCommonCondition = commonCondition.New(self.equipLockState)
	self.bossCommonCondition = commonCondition.New(self.bossLockState)
	self.mazeCommonCondition = commonCondition.New(self.mazeLockState)
end

function PlayingMethodUI:GetPreloadAssetPaths()
	return nil
end

function PlayingMethodUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function PlayingMethodUI:IsManualShowOnOpen(userData)
	return false
end

function PlayingMethodUI:GetBGM(userData)
	return nil
end

function PlayingMethodUI:OnOpen(userData)
	self.resCommonCondition:SetData(CfgDupTagTable[Constant.DupTagID.Equip].UnlockConditionId, true)
	self.equipCommonCondition:SetData(CfgDupTagTable[Constant.DupTagID.RoleDevelopment].UnlockConditionId, true)
	self.bossCommonCondition:SetData(CfgDupTagTable[Constant.DupTagID.BaseResource].UnlockConditionId, true)
	self.mainCommonCondition:SetData(CfgDupTagTable[Constant.DupTagID.MainLine].UnlockConditionId, true)
	self.mazeCommonCondition:SetData(CfgDupTagTable[Constant.DupTagID.MazeDup].UnlockConditionId, true)
	self:UpdateChapterInfo()
end

function PlayingMethodUI:OnClose(userData)
	return
end

function PlayingMethodUI:OnAddListeners()
	self.MapBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMapBtn)
	self.ResBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickResBtn)
	self.EquipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickEquipBtn)
	self.BossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBossBtn)
	self.MazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickMazeBtn)
	self.buttonMaze:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonMaze)
	self.buttonBattleActivity:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonBattleActivity)
	EventDispatcher.AddEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function PlayingMethodUI:OnRemoveListeners()
	self.MapBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMapBtn)
	self.ResBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickResBtn)
	self.EquipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickEquipBtn)
	self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBossBtn)
	self.MazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickMazeBtn)
	self.buttonMaze:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonMaze)
	self.buttonBattleActivity:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonBattleActivity)
	EventDispatcher.RemoveEventListener(EventID.OnNotifyStage, self.DelegateNotifyUpdateStage)
end

function PlayingMethodUI:OnPause()
	return
end

function PlayingMethodUI:OnResume()
	return
end

function PlayingMethodUI:OnCover()
	return
end

function PlayingMethodUI:OnReveal()
	return
end

function PlayingMethodUI:OnRefocus(userData)
	return
end

function PlayingMethodUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function PlayingMethodUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function PlayingMethodUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function PlayingMethodUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function PlayingMethodUI:OnDestroy()
	self.resCommonCondition:Dispose()
	self.mainCommonCondition:Dispose()
	self.equipCommonCondition:Dispose()
	self.bossCommonCondition:Dispose()
	self.mazeCommonCondition:Dispose()
	self.commonReturnBtn:Dispose()

	self.MapSignimgCom = nil

	AssetUtil.UnloadAsset(self)
end

function PlayingMethodUI:OnClickMapBtn()
	if not self.mainCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)
	end

	local data = {
		smallId = CfgWorldMapTable[10010].PartLocation
	}

	UIModule.Open(Constant.UIControllerName.ChapterStageMapUI, Constant.UILayer.UI, data)
end

function PlayingMethodUI:OnClickResBtn()
	if not self.resCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)

		return
	end

	UIModule.Open(Constant.UIControllerName.ResourceStageUI, Constant.UILayer.UI, {
		tagId = Constant.DupTagID.Equip
	})
end

function PlayingMethodUI:OnClickBossBtn()
	if not self.bossCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)

		return
	end

	UIModule.Open(Constant.UIControllerName.ResourceStageUI, Constant.UILayer.UI, {
		tagId = Constant.DupTagID.BaseResource
	})
end

function PlayingMethodUI:OnClickEquipBtn()
	if not self.equipCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)

		return
	end

	UIModule.Open(Constant.UIControllerName.ResourceStageUI, Constant.UILayer.UI, {
		tagId = Constant.DupTagID.RoleDevelopment
	})
end

function PlayingMethodUI:OnClickMazeBtn()
	if not self.mazeCommonCondition:GetAllConditionsIsUnlock() then
		NoticeModule.ShowNotice(19001)

		return
	end

	UIModule.Open(Constant.UIControllerName.LoopTowerDungeonUI, Constant.UILayer.UI)
end

function PlayingMethodUI:UpdateChapterInfo()
	local storyStageCfg = MapModule.GetMainLineNewUnlock()

	if storyStageCfg ~= nil then
		local chapterCfg = CfgGeneralDupChapterTable[storyStageCfg.ChapterId]

		UGUIUtil.SetText(self.MapName, storyStageCfg.Name)
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(chapterCfg.ChapterNumberImage), self.chapterNumImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(chapterCfg.ChapterNumberLowerImage), self.MapLowerNumberImg:GetComponent("Image"))
		AssetUtil.LoadImage(self, ChapterStageMapUIApi:GetMarkImagePath(storyStageCfg.SignImg), self.MapSignimgCom, function()
			self.MapSignimgCom:SetNativeSize()
		end)
	else
		UGUIUtil.SetText(self.MapName, "")
	end

	LuaUtility.SetGameObjectShow(self.mainNameParent, self.mainCommonCondition:GetAllConditionsIsUnlock())
	LuaUtility.SetGameObjectShow(self.dareNameParent, self.equipCommonCondition:GetAllConditionsIsUnlock())
	LuaUtility.SetGameObjectShow(self.resNameParent, self.resCommonCondition:GetAllConditionsIsUnlock())
	LuaUtility.SetGameObjectShow(self.mazeNameParent, self.mazeCommonCondition:GetAllConditionsIsUnlock())
end

function PlayingMethodUI:NotifyUpdateStage()
	self:UpdateChapterInfo()
end

return PlayingMethodUI
