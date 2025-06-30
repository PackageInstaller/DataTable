-- chunkname: @IQIGame\\UI\\BattleLoadingUI.lua

local BattleLoadingUI = Base:Extend("BattleLoadingUI", "IQIGame.Onigao.UI.BattleLoadingUI", {
	_isStartPreLoadingRes = false,
	MAX_FAKE_PROGRESS = 0.8,
	MAX_FAKE_DURATION = 4,
	realLoadedNum = 0,
	totalNum = 0,
	_loadingViewTable = {}
})

function BattleLoadingUI:OnInit()
	function self.DelegateFinishStartTween()
		self:FinishStartTween()
	end

	function self.DelegateFinishEndTween()
		self:FinishEndTween()
	end

	function self.DelegateOnLoadingResHandler(sender, arg)
		self:OnLoadingResHandler(sender, arg)
	end

	function self.DelegateOnLoadingResOverHandler(sender, arg)
		self:OnLoadingResOverHandler(sender, arg)
	end

	self._isUIInit = false
end

function BattleLoadingUI:GetPreloadAssetPaths()
	return nil
end

function BattleLoadingUI:GetOpenPreloadAssetPaths(userData)
	local fightPODs = BattleModule.GetAttackTroopPodsTable()

	self.FightPOD = fightPODs[math.random(1, #fightPODs)]

	local cfgMonsterData = CfgMonsterTable[self.FightPOD.MonsterCfgId]
	local loadings = {}

	for i, v in pairsCfg(CfgBattleLoadingImageTable) do
		table.insert(loadings, v)
	end

	local randomIndex = math.random(1, #loadings)
	local cfgBattleLoadingImageData = loadings[randomIndex]

	self.bgRes = UIGlobalApi.GetImagePath(cfgBattleLoadingImageData.Url)

	local soulCid

	for id, cfgDressData in pairsCfg(CfgDressTable) do
		if cfgDressData.SoulResID == cfgMonsterData.SoulRes then
			soulCid = cfgDressData.SoulID

			break
		end
	end

	self.verticalDrawingRes = UIGlobalApi.GetSoulPortraitPath(soulCid, cfgMonsterData.SoulRes)

	return {
		AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleLoadingUI/BattleLoadingUI_01"),
		self.bgRes,
		self.verticalDrawingRes
	}
end

function BattleLoadingUI:OnOpen(userData)
	self.totalNum = 0
	self.realLoadedNum = 0
	self.fakeLoadingElapseTime = 0
	self._isStartPreLoadingRes = false

	self:InitLoadingUI()
end

function BattleLoadingUI:OnAddListeners()
	GameEntry.LuaEvent:Subscribe(BattleLoadingResEventArgs.EventId, self.DelegateOnLoadingResHandler)
	GameEntry.LuaEvent:Subscribe(BattleLoadingResOverEventArgs.EventId, self.DelegateOnLoadingResOverHandler)
end

function BattleLoadingUI:OnRemoveListeners()
	GameEntry.LuaEvent:Unsubscribe(BattleLoadingResEventArgs.EventId, self.DelegateOnLoadingResHandler)
	GameEntry.LuaEvent:Unsubscribe(BattleLoadingResOverEventArgs.EventId, self.DelegateOnLoadingResOverHandler)
end

function BattleLoadingUI:InitLoadingUI()
	local contentPrefab = self.UIController:GetPreloadedAsset(AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleLoadingUI/BattleLoadingUI_01"))
	local loadingObj = UnityEngine.Object.Instantiate(contentPrefab)

	loadingObj.transform:SetParent(self.BattleLoadingUI.transform, false)

	self._loadingPrefab = loadingObj
	self._loadingViewTable = {}

	LuaCodeInterface.BindOutlet(loadingObj, self._loadingViewTable)

	local bgImg = LuaCodeInterface.ToSprite(self.UIController:GetPreloadedAsset(self.bgRes))

	self._loadingViewTable.ImgBg:GetComponent("Image").sprite = bgImg

	local prefab = self.UIController:GetPreloadedAsset(self.verticalDrawingRes)

	if prefab ~= nil then
		self.SoulPortrait = UnityEngine.Object.Instantiate(prefab)

		self.SoulPortrait.transform:SetParent(self._loadingViewTable.PortraitNode.transform, false)
	else
		logError("找不到灵魂肖像预设：" .. self.verticalDrawingRes)
	end

	local cfgMonster = CfgMonsterTable[self.FightPOD.MonsterCfgId]

	self._loadingViewTable.playerNameTxt:GetComponent("Text").text = cfgMonster.Name
	self._loadingViewTable.playerInfoTxt:GetComponent("Text").text = cfgMonster.LoadingTxt
	self._loadingViewTable.BattleLoadingProgressBg:GetComponent("Image").fillAmount = 0
	self._loadingViewTable.BattleLoadingTxt:GetComponent("Text").text = LoadingUIApi:GetString("Message8", self.FightPOD.MonsterCfgId)

	UGUIUtil.SetText(self._loadingViewTable.BattleLoadingProgressText, LoadingUIApi:GetString("goProgressTxt", 0))

	local sortComponent = loadingObj:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponent.Length - 1 do
		sortComponent[i].UIRootCanvas = self.UIController:GetComponent("Canvas")
	end

	self:OnUpdateProgress(0, 1, 1)
end

function BattleLoadingUI:OnLoadingResHandler(sender, arg)
	return
end

function BattleLoadingUI:OnUpdateProgress(loadedNum, totalNum, resType)
	self.realLoadedNum = loadedNum
	self.totalNum = totalNum

	self:UpdateProgressLabel(resType)
	self:UpdateProgressTextAndBar()
end

function BattleLoadingUI:UpdateProgressLabel(resType)
	local str = ""

	if resType == 1 then
		str = LoadingUIApi:GetString("Message1", self.FightPOD.MonsterCfgId)
	elseif resType == 2 then
		str = LoadingUIApi:GetString("Message2", self.FightPOD.MonsterCfgId)
	elseif resType == 3 then
		str = LoadingUIApi:GetString("Message3", self.FightPOD.MonsterCfgId)
	elseif resType == 4 then
		str = LoadingUIApi:GetString("Message4", self.FightPOD.MonsterCfgId)
	elseif resType == 5 then
		str = LoadingUIApi:GetString("Message5", self.FightPOD.MonsterCfgId)
	elseif resType == 6 then
		str = LoadingUIApi:GetString("Message6", self.FightPOD.MonsterCfgId)
	end

	self.progressLabelText = str
end

function BattleLoadingUI:UpdateProgressTextAndBar()
	local realProgress = self.realLoadedNum / self.totalNum
	local fakeProgress = self.fakeLoadingElapseTime / BattleLoadingUI.MAX_FAKE_DURATION

	if fakeProgress > BattleLoadingUI.MAX_FAKE_PROGRESS then
		fakeProgress = BattleLoadingUI.MAX_FAKE_PROGRESS
	end

	local progress

	if realProgress < fakeProgress then
		progress = fakeProgress
	else
		progress = realProgress
	end

	self._loadingViewTable.BattleLoadingProgressBg:GetComponent("Image").fillAmount = progress

	if self._loadingViewTable.BattleLoadingProgressText ~= nil then
		UGUIUtil.SetText(self._loadingViewTable.BattleLoadingProgressText, LoadingUIApi:GetString("goProgressTxt", progress))
		UGUIUtil.SetText(self._loadingViewTable.BattleLoadingTxt, self.progressLabelText)
	else
		UGUIUtil.SetText(self._loadingViewTable.BattleLoadingTxt, LoadingUIApi:GetString("goLabeledProgressTxt", self.progressLabelText, progress, self.FightPOD.MonsterCfgId))
	end
end

function BattleLoadingUI:OnLoadingResOverHandler(sender, arg)
	self:OnUpdateProgress(arg.ResLoadNum, arg.LoadResTotalNum, arg.ResType)
end

function BattleLoadingUI:OnClose(userData)
	if self.SoulPortrait ~= nil then
		UnityEngine.Object.DestroyImmediate(self.SoulPortrait)

		self.SoulPortrait = nil
	end

	LuaCodeInterface.ClearOutlet(self._loadingPrefab, self._loadingViewTable)
	UnityEngine.Object.Destroy(self._loadingPrefab)

	self._loadingPrefab = nil
	self._loadingViewTable = nil
	self.randomSoulData = nil
	self.fakeLoadingElapseTime = nil
end

function BattleLoadingUI:OnPause()
	return
end

function BattleLoadingUI:OnResume()
	return
end

function BattleLoadingUI:OnCover()
	return
end

function BattleLoadingUI:OnReveal()
	return
end

function BattleLoadingUI:OnRefocus(userData)
	return
end

function BattleLoadingUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self.fakeLoadingElapseTime ~= nil then
		self.fakeLoadingElapseTime = self.fakeLoadingElapseTime + realElapseSeconds

		self:UpdateProgressTextAndBar()
	end
end

function BattleLoadingUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleLoadingUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function BattleLoadingUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleLoadingUI:OnDestroy()
	return
end

return BattleLoadingUI
