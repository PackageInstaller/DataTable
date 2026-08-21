-- chunkname: @IQIGame\\UI\\EndlessPlusExBossDetailUI.lua

local EndlessPlusExBossDetailUI = {
	EntityId = 0,
	MonsterElementCells = {},
	RankCellPool = {},
	RuneSuitItemPool = {}
}

EndlessPlusExBossDetailUI = Base:Extend("EndlessPlusExBossDetailUI", "IQIGame.Onigao.UI.EndlessPlusExBossDetailUI", EndlessPlusExBossDetailUI)

require("IQIGame.UIExternalApi.EndlessPlusExBossDetailUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local RankingUIController = require("IQIGame.UI.Common.RankingUIController")
local EndlessPlusExBossRankCell = require("IQIGame.UI.ExploreHall.EndlessPlus.EndlessPlusExBossRankCell")
local EndlessPlusExBossRuneSuitItem = require("IQIGame.UI.ExploreHall.EndlessPlus.EndlessPlusExBossRuneSuitItem")

function EndlessPlusExBossDetailUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnRune, EndlessPlusExBossDetailUIApi:GetString("BtnRuneLabel"))
	UGUIUtil.SetText(self.RuneTitle, EndlessPlusExBossDetailUIApi:GetString("RuneTitle"))
	UGUIUtil.SetText(self.TextRuneNull, EndlessPlusExBossDetailUIApi:GetString("TextRuneNull"))
	UGUIUtil.SetText(self.TextMaxRunes, EndlessPlusExBossDetailUIApi:GetString("TextMaxRunes"))

	function self.DelegateOnClickBtnShop()
		self:OnClickBtnShop()
	end

	function self.DelegateOnClickChallengeBtn()
		self:OnClickChallengeBtn()
	end

	function self.DelegateOnClickBtnRankReward()
		self:OnClickBtnRankReward()
	end

	function self.DelegateOnClickBtnTip()
		self:OnClickBtnTip()
	end

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateRefreshRankEvent()
		self:RefreshRank()
	end

	function self.DelegateOnClickBtnRune()
		self:OnBtnRune()
	end

	function self.DelegateUpdateDailyDup()
		self:OnUpdateDailyDup()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	self.Mould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)
	self.RankingUIController = RankingUIController.New(self.RankView, function(cellGo, index, myRanking, myScore, rankings, customData, rankType)
		self:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	end)

	local labels = EndlessPlusExBossDetailUIApi:GetString("RankingLabels")

	self.RankingUIController:SetRankingLabels(labels)
	self.RankingUIController:SetNoneRankText(EndlessPlusExBossDetailUIApi:GetString("NoneRankText"))
	self.RuneModule:SetActive(false)
end

function EndlessPlusExBossDetailUI:GetPreloadAssetPaths()
	return nil
end

function EndlessPlusExBossDetailUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function EndlessPlusExBossDetailUI:IsManualShowOnOpen(userData)
	return false
end

function EndlessPlusExBossDetailUI:GetBGM(userData)
	return nil
end

function EndlessPlusExBossDetailUI:OnOpen(userData)
	self.lastMonsterSpine = nil

	self:UpDateView()
	self:RefreshRank()
end

function EndlessPlusExBossDetailUI:OnClose(userData)
	self:HideEntity()
end

function EndlessPlusExBossDetailUI:OnAddListeners()
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnShop)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnRune:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRune)
	self.FormationPanelController:AddEventListeners()
	EventDispatcher.AddEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function EndlessPlusExBossDetailUI:OnRemoveListeners()
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnShop)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickChallengeBtn)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRankReward)
	self.BtnTip:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnTip)
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnRune:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRune)
	self.FormationPanelController:RemoveEventListeners()
	EventDispatcher.RemoveEventListener(EventID.RefreshRankEvent, self.DelegateRefreshRankEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function EndlessPlusExBossDetailUI:OnPause()
	return
end

function EndlessPlusExBossDetailUI:OnResume()
	return
end

function EndlessPlusExBossDetailUI:OnCover()
	return
end

function EndlessPlusExBossDetailUI:OnReveal()
	return
end

function EndlessPlusExBossDetailUI:OnRefocus(userData)
	return
end

function EndlessPlusExBossDetailUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function EndlessPlusExBossDetailUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function EndlessPlusExBossDetailUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function EndlessPlusExBossDetailUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function EndlessPlusExBossDetailUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()
	self.RankingUIController:Dispose()

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	for i, v in pairs(self.RankCellPool) do
		v:Dispose()
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.RuneSuitItemPool) do
		v:Dispose()
	end

	self.RuneSuitItemPool = {}
end

function EndlessPlusExBossDetailUI:OnClickBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.EndlessPlusMaze)
end

function EndlessPlusExBossDetailUI:OnClickChallengeBtn()
	local isInChallengeTime = EndlessPlusMazeModule.IsInChallengeLimitTime()

	if not isInChallengeTime then
		return
	end

	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, EndlessPlusExBossDetailUIApi:GetString("TextNotice3"))

		return
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not formationPOD then
		return
	end

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	EndlessPlusMazeModule.ChallengeExBoss(self.formationID)
end

function EndlessPlusExBossDetailUI:OnClickBtnRankReward()
	if self.myRanking then
		UIModule.Open(Constant.UIControllerName.EndlessPlusExBossRewardUI, Constant.UILayer.UI, {
			self.myRanking,
			self.rankType
		})
	end
end

function EndlessPlusExBossDetailUI:OnClickBtnTip()
	return
end

function EndlessPlusExBossDetailUI:OnBtnRune()
	local isInChallengeTime = EndlessPlusMazeModule.IsInChallengeLimitTime()

	if not isInChallengeTime then
		return
	end

	UIModule.Open(Constant.UIControllerName.EndlessPlusSelectRuneUI, Constant.UILayer.UI, {
		viewMode = false,
		defaultSelects = EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.usedRunes,
		onConfirm = function(list)
			EndlessPlusMazeModule.SendUseRunes(list)
		end
	})
end

function EndlessPlusExBossDetailUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function EndlessPlusExBossDetailUI:OnUpdateDailyDup()
	self:UpDateView()
end

function EndlessPlusExBossDetailUI:UpDateView()
	self.cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	UGUIUtil.SetText(self.TitleName, self.cfgEndlessPlusGlobalData.ButtonWord)

	local bgPath = UIGlobalApi.GetImagePath(self.cfgEndlessPlusGlobalData.BossImage)

	AssetUtil.LoadImage(self, bgPath, self.ImgBG:GetComponent("Image"))
	UGUIUtil.SetText(self.TextBossName, self.cfgEndlessPlusGlobalData.BossName)
	self.FormationPanelController:UpdateView()
	self:ShowMonster(self.cfgEndlessPlusGlobalData.MonsterSpine)

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local sortTab = self:GetExBossWeakTypes(self.cfgEndlessPlusGlobalData.BossTeam)

	for i = 1, #sortTab do
		local b = sortTab[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.MonsterGrid.transform, false)
		cell:SetData(b.weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	self:RefreshRune()
end

function EndlessPlusExBossDetailUI:ShowMonster(elementEntityCid)
	if self.lastMonsterSpine ~= elementEntityCid then
		self.lastMonsterSpine = elementEntityCid

		self:HideEntity()

		self.EntityId = GameEntry.Entity:GenerateEntityID()

		GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.Spine.transform, Vector3.zero)
	end
end

function EndlessPlusExBossDetailUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
		self.lastMonsterSpine = nil
	end
end

function EndlessPlusExBossDetailUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		args.Entity.gameObject.transform.localScale = Vector3(self.cfgEndlessPlusGlobalData.ShowUiSize, self.cfgEndlessPlusGlobalData.ShowUiSize, self.cfgEndlessPlusGlobalData.ShowUiSize)
		args.Entity.gameObject.transform.localPosition = Vector3(self.cfgEndlessPlusGlobalData.ShowUiPosition[1], self.cfgEndlessPlusGlobalData.ShowUiPosition[2], self.cfgEndlessPlusGlobalData.ShowUiPosition[3])

		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function EndlessPlusExBossDetailUI:RefreshRune()
	for i, v in pairs(self.RuneSuitItemPool) do
		v:Dispose()
	end

	self.RuneSuitItemPool = {}

	local runes = {}

	for i = 1, #EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.usedRunes do
		local cid = EndlessPlusMazeModule.DailyDupPOD.abyssPlusPOD.usedRunes[i]

		table.insert(runes, CfgRuneTable[cid])
	end

	table.sort(runes, function(a, b)
		return a.Quality > b.Quality
	end)

	for i = 1, #runes do
		local cfgRuneData = runes[i]
		local obj = UnityEngine.Object.Instantiate(self.RuneModule)

		obj.transform:SetParent(self.RuneSort.transform, false)

		local runeSuitItem = EndlessPlusExBossRuneSuitItem.New(obj)

		runeSuitItem:SetData(cfgRuneData)
		table.insert(self.RuneSuitItemPool, runeSuitItem)
	end

	self.RuneNullNode:SetActive(#runes == 0)
end

function EndlessPlusExBossDetailUI:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)
	self.myRanking = myRanking
	self.rankType = rankType

	self.RankingUIController:SetData(rankings, myRanking, myScore, customData, rankType)
end

function EndlessPlusExBossDetailUI:RenderCell(cellGo, index, myRanking, myScore, rankings, customData, rankType)
	local instanceID = cellGo.gameObject:GetInstanceID()
	local rankingItem = self.RankCellPool[instanceID]

	if rankingItem == nil then
		rankingItem = EndlessPlusExBossRankCell.New(cellGo.gameObject)
		self.RankCellPool[instanceID] = rankingItem
	end

	if index == 0 then
		rankingItem.showFormationUI = false

		rankingItem:SetMyData(myRanking, myScore, customData, rankType)
	elseif index == -1 then
		rankingItem.showFormationUI = false

		rankingItem:SetGoalieData(myScore, myRanking, rankType)
		self.RankingUIController.RankingGoalieGo:SetActive(true)
	else
		rankingItem.showFormationUI = true

		rankingItem:SetData(index, rankings[index])
	end
end

function EndlessPlusExBossDetailUI:RefreshRank()
	CenterRankModule.GetRanking(Constant.RankingType.EndlessPlusEXBossRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		self:ShowRank(rankId, isOpen, rankings, myRanking, myScore, customData, rankType)

		if myRanking >= 1 and myRanking <= 100 and rankType == 1 or myRanking < 0 then
			self.RankingUIController.RankingGoalieGo:SetActive(false)
		else
			self:RefreshRankGoalie(myRanking, rankType)
			self.RankingUIController.MyRankNode:SetActive(true)
		end
	end)
end

function EndlessPlusExBossDetailUI:RefreshRankGoalie(myRanking, rankType)
	local exBossRankReward = {}
	local cfgMyRank

	for i, v in pairsCfg(CfgEndlessPlusBossRankTable) do
		if v.Group == EndlessPlusMazeModule.GlobalCid then
			table.insert(exBossRankReward, v)

			if rankType == v.RankType and cfgMyRank == nil and myRanking >= v.RankLowerLimit and myRanking <= v.RankUpperLimit then
				cfgMyRank = v
			end
		end
	end

	table.sort(exBossRankReward, function(tb1, tb2)
		return tb1.Id < tb2.Id
	end)

	local cfgRankGoalie

	for i = 1, #exBossRankReward do
		local cfg = exBossRankReward[i]

		if cfg.Id == cfgMyRank.Id then
			cfgRankGoalie = exBossRankReward[i - 1]

			break
		end
	end

	CenterRankModule.GetRankGoalie(Constant.RankingType.EndlessPlusEXBossRank, cfgRankGoalie.RankType, cfgRankGoalie.RankUpperLimit, function(rankingPOD, ranking, rankType)
		self.RankingUIController:SetRankingGoalieData(ranking, rankingPOD, rankType)
	end)
end

function EndlessPlusExBossDetailUI:GetExBossWeakTypes(monsterTeamID)
	local sortTab = {}
	local tab = {}
	local cfgMonsterTeam = CfgMonsterTeamTable[monsterTeamID]

	for i = 1, #cfgMonsterTeam.TeamUnit do
		local monsterID = cfgMonsterTeam.TeamUnit[i]

		if monsterID > 0 then
			local cfgMonster = CfgMonsterTable[monsterID]

			if #cfgMonster.WeakType > 0 then
				for i = 1, #cfgMonster.WeakType do
					local id = cfgMonster.WeakType[i]

					if tab[id] == nil then
						local t = {}

						t.weakType = id
						t.num = 1
						tab[id] = t
					else
						tab[id].num = tab[id].num + 1
					end
				end
			end
		end
	end

	for i, v in pairs(tab) do
		table.insert(sortTab, v)
	end

	table.sort(sortTab, function(a, b)
		local res = false

		if a.num == b.num then
			res = a.weakType < b.weakType
		else
			res = a.num > b.num
		end

		return res
	end)

	return sortTab
end

function EndlessPlusExBossDetailUI:OnUpdateFormation()
	self:ShowPower(self.FormationPanelController:GetPower(), 10000)
end

function EndlessPlusExBossDetailUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, EndlessPlusExBossDetailUIApi:GetString("RecommendPowerText", power2))
	self.TextPowerNum:SetActive(false)
	UGUIUtil.SetText(self.TextCurrentNum, EndlessPlusExBossDetailUIApi:GetString("TextPower", power1, power2))
end

return EndlessPlusExBossDetailUI
