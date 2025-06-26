-- chunkname: @IQIGame\\UI\\GuildChallengeDetailInfoUI.lua

local GuildChallengeDetailInfoUI = {
	EntityId = 0,
	index = 0,
	guildChallengeLayers = {},
	challengeLayerCellPool = {},
	MonsterElementCells = {},
	ItemCells = {},
	challengeRewards = {},
	canGetReward = {}
}

GuildChallengeDetailInfoUI = Base:Extend("GuildChallengeDetailInfoUI", "IQIGame.Onigao.UI.GuildChallengeDetailInfoUI", GuildChallengeDetailInfoUI)

require("IQIGame.UIExternalApi.GuildChallengeDetailInfoUIApi")

local FormationPanelController = require("IQIGame.UI.FormationUI.FormationPanelController")
local GuildChallengeLayerCell = require("IQIGame.UI.Guild.GuildChallenge.GuildChallengeLayerCell")
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local GuildChallengeRewardCell = require("IQIGame.UI.Guild.GuildChallenge.GuildChallengeRewardCell")

function GuildChallengeDetailInfoUI:OnInit()
	UGUIUtil.SetText(self.TitleName, GuildChallengeDetailInfoUIApi:GetString("TitleName"))
	UGUIUtil.SetText(self.BtnChallengeLabel, GuildChallengeDetailInfoUIApi:GetString("BtnChallengeLabel"))
	UGUIUtil.SetTextInChildren(self.BtnQuickChallenge, GuildChallengeDetailInfoUIApi:GetString("BtnQuickChallengeLabel"))
	UGUIUtil.SetText(self.TextRewardTitle, GuildChallengeDetailInfoUIApi:GetString("TextRewardTitle"))
	UGUIUtil.SetText(self.TextTarget, GuildChallengeDetailInfoUIApi:GetString("TextTarget"))

	local scrollAreaPage = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function scrollAreaPage.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function scrollAreaPage.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	self.FormationPanelController = FormationPanelController.New(self.Formation, function()
		self:OnUpdateFormation()
	end)

	function self.DelegateOnCloseBtn()
		self:OnCloseBtn()
	end

	function self.DelegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.DelegateBtnRight()
		self:OnBtnRight()
	end

	function self.DelegateBtnInfo()
		self:OnBtnInfo()
	end

	function self.DelegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.DelegateBtnQuickChallenge()
		self:OnBtnQuickChallenge()
	end

	function self.DelegateGuildChallengeUpdateEvent()
		self:OnGuildChallengeUpdate()
	end

	function self.DelegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateOnShowElementEntitySuccess(sender, args)
		self:OnShowElementEntitySuccess(sender, args)
	end

	function self.DelegateGuildUpdateEvent()
		self:OnGuildUpdateEvent()
	end

	function self.DelegateBtnReward()
		self:OnBtnReward()
	end

	self.WeakMould:SetActive(false)

	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.WeakMould))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self.RewardMould:SetActive(false)

	self.ItemCellPool = UIObjectPool.New(10, function()
		return GuildChallengeRewardCell.New(UnityEngine.Object.Instantiate(self.RewardMould))
	end, function(cell)
		cell:Dispose()
	end)
	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)
end

function GuildChallengeDetailInfoUI:GetPreloadAssetPaths()
	return nil
end

function GuildChallengeDetailInfoUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function GuildChallengeDetailInfoUI:IsManualShowOnOpen(userData)
	return false
end

function GuildChallengeDetailInfoUI:GetBGM(userData)
	return nil
end

function GuildChallengeDetailInfoUI:OnOpen(userData)
	self.moneyCell:RefreshView({
		Constant.ItemID.GUILD_CHALLENGE_TICKETS
	})
	self:UpdateView()
end

function GuildChallengeDetailInfoUI:OnClose(userData)
	self:HideEntity()
	EventDispatcher.Dispatch(EventID.GuildCameraChangePosEvent)
end

function GuildChallengeDetailInfoUI:OnAddListeners()
	self.FormationPanelController:AddEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnCloseBtn)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateBtnRight)
	self.BtnInfo:GetComponent("Button").onClick:AddListener(self.DelegateBtnInfo)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnChallenge)
	self.BtnQuickChallenge:GetComponent("Button").onClick:AddListener(self.DelegateBtnQuickChallenge)
	self.BtnReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnReward)
	EventDispatcher.AddEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	GameEntry.LuaEvent:Subscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function GuildChallengeDetailInfoUI:OnRemoveListeners()
	self.FormationPanelController:RemoveEventListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnCloseBtn)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRight)
	self.BtnInfo:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnInfo)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnChallenge)
	self.BtnQuickChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnQuickChallenge)
	self.BtnReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.GuildUpdateEvent, self.DelegateGuildUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.GuildChallengeUpdateEvent, self.DelegateGuildChallengeUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	GameEntry.LuaEvent:Unsubscribe(UnityGameFramework.Runtime.ShowEntitySuccessEventArgs.EventId, self.DelegateOnShowElementEntitySuccess)
end

function GuildChallengeDetailInfoUI:OnPause()
	return
end

function GuildChallengeDetailInfoUI:OnResume()
	return
end

function GuildChallengeDetailInfoUI:OnCover()
	return
end

function GuildChallengeDetailInfoUI:OnReveal()
	return
end

function GuildChallengeDetailInfoUI:OnRefocus(userData)
	return
end

function GuildChallengeDetailInfoUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function GuildChallengeDetailInfoUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function GuildChallengeDetailInfoUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function GuildChallengeDetailInfoUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function GuildChallengeDetailInfoUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.FormationPanelController:Dispose()
	self.moneyCell:Dispose()

	self.moneyCell = nil

	for i, v in pairs(self.challengeLayerCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.MonsterElementCells) do
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	self.MonsterElementPool:Dispose()

	for i, v in pairs(self.ItemCells) do
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	self.ItemCellPool:Dispose()
end

function GuildChallengeDetailInfoUI:OnCloseBtn()
	UIModule.CloseSelf(self)
end

function GuildChallengeDetailInfoUI:OnGuildChallengeUpdate()
	self:UpdateView()
end

function GuildChallengeDetailInfoUI:OnUpdateDailyDupEvent()
	self:UpdateView()
end

function GuildChallengeDetailInfoUI:OnGuildUpdateEvent()
	self:RefreshDailyFund()
end

function GuildChallengeDetailInfoUI:OnBtnReward()
	GuildChallengeModule.GetScore(function()
		self:RefreshStageReward()

		if #self.canGetReward > 0 then
			GuildChallengeModule.GetRewards(self.canGetReward)
		else
			self:OnBtnInfo()
		end
	end)
end

function GuildChallengeDetailInfoUI:GetIndex(guildChallengeLayers)
	local nextLV = GuildChallengeModule.GetPassMaxBossLevel() + 1
	local maxLv = guildChallengeLayers[#guildChallengeLayers].Level

	nextLV = maxLv < nextLV and maxLv or nextLV

	local pos = 0

	for i = 1, #guildChallengeLayers do
		local cfgData = self.guildChallengeLayers[i]

		if cfgData.Level == nextLV then
			local isUnLock = GuildChallengeModule.ChallengeLayerIsUnlock(cfgData.Id)

			if isUnLock then
				pos = i

				break
			end

			pos = i - 1

			break
		end
	end

	local index = pos - 1

	if index < 0 then
		index = 0
	end

	return index
end

function GuildChallengeDetailInfoUI:UpdateView()
	self.FormationPanelController:UpdateView()

	self.guildChallengeLayers = GuildChallengeModule.GetGuildChallengeLayerList()
	self.index = self:GetIndex(self.guildChallengeLayers)

	self:RefreshList(self.index)
end

function GuildChallengeDetailInfoUI:RefreshList(startIndex)
	self.ScrollArea:GetComponent("ScrollAreaListPage").startIndex = startIndex

	self.ScrollArea:GetComponent("ScrollAreaListPage"):Refresh(#self.guildChallengeLayers)
end

function GuildChallengeDetailInfoUI:OnRenderCell(pageCell)
	local cfgData = self.guildChallengeLayers[pageCell.index + 1]
	local instanceID = pageCell.gameObject:GetInstanceID()
	local cell = self.challengeLayerCellPool[instanceID]

	if cell == nil then
		cell = GuildChallengeLayerCell.New(pageCell.gameObject)
		self.challengeLayerCellPool[instanceID] = cell
	end

	local isPass = GuildChallengeModule.ChallengeLayerIsPass(cfgData.Id)
	local isUnLock = GuildChallengeModule.ChallengeLayerIsUnlock(cfgData.Id)

	cell:SetData(cfgData, isPass, isUnLock)
end

function GuildChallengeDetailInfoUI:OnPageReachedMain(page)
	self.index = page.index + 1

	self:ShowSelectPage()
end

function GuildChallengeDetailInfoUI:ShowSelectPage()
	self.BtnLeft:SetActive(self.index > 1)
	self.BtnRight:SetActive(self.index < #self.guildChallengeLayers)

	local selectData = self.guildChallengeLayers[self.index]

	for i, v in pairs(self.challengeLayerCellPool) do
		v:SetSelect(selectData.Id == v.guildChallengeLayerData.Id)
	end

	UGUIUtil.SetText(self.TextBossName, selectData.Name)

	for i, v in pairs(self.MonsterElementCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.MonsterElementPool:Release(v)
	end

	self.MonsterElementCells = {}

	local order = 1

	if GuildChallengeModule.CenterGuildChallengePOD then
		order = GuildChallengeModule.CenterGuildChallengePOD.buffOrder + 1
	end

	local weakTypes = selectData.WeakType[order]

	for i = 1, #weakTypes do
		local weakType = weakTypes[i]
		local cell = self.MonsterElementPool:Obtain()

		cell.View:SetActive(true)
		cell.View.transform:SetParent(self.WeakNode.transform, false)
		cell:SetData(weakType)
		table.insert(self.MonsterElementCells, cell)
	end

	for i, v in pairs(self.ItemCells) do
		v.View.transform:SetParent(self.UIController.transform, false)
		v.View:SetActive(false)
		self.ItemCellPool:Release(v)
	end

	self.ItemCells = {}

	for i = 1, #selectData.RewardShow, 2 do
		local itemId = selectData.RewardShow[i]
		local itemNum = selectData.RewardShow[i + 1]
		local itemCell = self.ItemCellPool:Obtain()

		itemCell.View:SetActive(true)
		itemCell.View.transform:SetParent(self.RewardNode.transform, false)
		itemCell:SetData(itemId, itemNum)
		table.insert(self.ItemCells, itemCell)
	end

	local itemID = selectData.Cost[1]
	local needNum = selectData.Cost[2]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(CfgItemTable[itemID].Icon), self.SpendIcon:GetComponent("Image"))

	local have = WarehouseModule.GetItemNumByCfgID(itemID)

	UGUIUtil.SetText(self.SpendNumber, GuildChallengeDetailInfoUIApi:GetString("SpendNumber", needNum, needNum <= have))
	self:ShowMonster(selectData.ElementEntityID)
	self:RefreshStageReward()
	self:OnUpdateFormation()
	self:RefreshDailyFund()
end

function GuildChallengeDetailInfoUI:RefreshDailyFund()
	local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(Constant.GuildBuilding.Guild_BuildingLV)
	local cfgGuildBuildingLevelUpData = GuildModule.GetBuildingLevelData(Constant.GuildBuilding.Guild_BuildingLV, buildLv)
	local cfgGuildEffectData = CfgGuildEffectTypeTable[cfgGuildBuildingLevelUpData.EffectType]
	local fundDailyGetRecord = GuildModule.guildPOD.fundDailyGetRecord

	fundDailyGetRecord = fundDailyGetRecord == nil and 0 or fundDailyGetRecord

	UGUIUtil.SetText(self.TextDailyGetRecord, GuildChallengeDetailInfoUIApi:GetString("TextDailyGetRecord", fundDailyGetRecord, cfgGuildEffectData.Param[2]))
end

function GuildChallengeDetailInfoUI:RefreshStageReward()
	self.challengeRewards, self.canGetReward = GuildChallengeModule.GetGuildChallengeRewardList()

	table.sort(self.challengeRewards, function(a, b)
		return a.cfgInfo.Sort < b.cfgInfo.Sort
	end)

	local currentData
	local index = 0
	local showNeedPoints = 0

	for i = 1, #self.challengeRewards do
		local data = self.challengeRewards[i]

		if data.score < data.maxScore then
			currentData = data
			index = i
			showNeedPoints = data.cfgInfo.NeedPoints

			break
		end
	end

	if currentData == nil then
		index = #self.challengeRewards
		currentData = self.challengeRewards[index]
		showNeedPoints = currentData.cfgInfo.NeedPoints
	end

	local before = index - 1
	local next = index + 1

	self.StageLeft:SetActive(index > 1)
	self.LeftOneMore:SetActive(index > 2)
	self.StateRight:SetActive(index < #self.challengeRewards)
	self.RightOneMore:SetActive(index < #self.challengeRewards - 1)
	self.NowImage:SetActive(currentData.state ~= 2)
	UGUIUtil.SetText(self.NowTextTarget, GuildChallengeDetailInfoUIApi:GetString("NowTextTarget", showNeedPoints))

	local leftStage = ""

	if before > 0 then
		leftStage = self.challengeRewards[before].cfgInfo.Stage
	end

	local rightStage = ""

	if next <= #self.challengeRewards then
		rightStage = self.challengeRewards[next].cfgInfo.Stage
	end

	UGUIUtil.SetText(self.TextStage, currentData.cfgInfo.Stage)
	UGUIUtil.SetText(self.TextStageLeft, leftStage)
	UGUIUtil.SetText(self.TextStageRight, rightStage)
	UGUIUtil.SetText(self.TextScore, GuildChallengeModule.score)

	self.ImgPer:GetComponent("Image").fillAmount = currentData.score / currentData.maxScore

	local canGet = #self.canGetReward > 0

	self.RewardState1:SetActive(not canGet and currentData.state == 2)
	self.RewardState2:SetActive(canGet)
	self.RewardState3:SetActive(not canGet and currentData.state == 3)
end

function GuildChallengeDetailInfoUI:ShowMonster(elementEntityCid)
	self:HideEntity()

	self.EntityId = GameEntry.Entity:GenerateEntityID()

	GameEntry.Entity:ShowUIElement(self.EntityId, elementEntityCid, 0, self.PointSpine.transform, Vector3.zero)
end

function GuildChallengeDetailInfoUI:HideEntity()
	if self.EntityId ~= 0 then
		GameEntry.Entity:HideEntity(self.EntityId)

		self.EntityId = 0
	end
end

function GuildChallengeDetailInfoUI:OnShowElementEntitySuccess(sender, args)
	if self.EntityId == args.Entity.Id then
		local animation = args.Entity.gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

		if animation ~= nil then
			animation.state:SetAnimation(0, "idle", true)
		end

		setGameObjectLayers(args.Entity.gameObject.transform, "UI")
	end
end

function GuildChallengeDetailInfoUI:OnUpdateFormation()
	local selectData = self.guildChallengeLayers[self.index]

	if selectData then
		self:ShowPower(self.FormationPanelController:GetPower(), selectData.RecPower)
	end
end

function GuildChallengeDetailInfoUI:ShowPower(power1, power2)
	UGUIUtil.SetText(self.TextPowerNum, GuildChallengeDetailInfoUIApi:GetString("RecommendPowerText", power2))
	UGUIUtil.SetText(self.TextCurrentNum, GuildChallengeDetailInfoUIApi:GetString("TextPower", power1, power2))
end

function GuildChallengeDetailInfoUI:OnBtnLeft()
	self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToBackward()
end

function GuildChallengeDetailInfoUI:OnBtnRight()
	self.ScrollArea:GetComponent("ScrollAreaListPage"):TurnToForward()
end

function GuildChallengeDetailInfoUI:OnBtnInfo()
	UIModule.Open(Constant.UIControllerName.GuildRewardShowUI, Constant.UILayer.UI)
end

function GuildChallengeDetailInfoUI:CheckChallenge()
	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice2"))

		return false, nil, nil
	end

	local valid, formationPOD = self.FormationPanelController:CheckValidation()

	if not valid then
		return false, nil, nil
	end

	local isOpen = GuildChallengeModule.IsOpen()

	if not isOpen then
		return false, nil, nil
	end

	local selectData = self.guildChallengeLayers[self.index]

	if selectData == nil then
		return false, nil, nil
	end

	if #selectData.NeedBuildingLv > 1 then
		for i = 1, #selectData.NeedBuildingLv, 2 do
			local buildID = selectData.NeedBuildingLv[i]
			local needLv = selectData.NeedBuildingLv[i + 1]
			local buildLv, buildMaxLv = GuildModule.GetBuildingLevel(buildID)

			if buildLv < needLv then
				NoticeModule.ShowNotice(21066704)

				return false, nil, nil
			end
		end
	end

	local ample = true

	if #selectData.Cost > 0 then
		for i = 1, #selectData.Cost, 2 do
			local id = selectData.Cost[i]
			local needNum = selectData.Cost[i + 1]
			local have = WarehouseModule.GetItemNumByCfgID(id)

			if have < needNum then
				ample = false

				break
			end
		end
	end

	if not ample then
		NoticeModule.ShowNotice(21047002)

		return false, nil, nil
	end

	return true, formationPOD.id, selectData.Id
end

function GuildChallengeDetailInfoUI:OnBtnChallenge()
	local top, formationID, layerCid = self:CheckChallenge()

	if top then
		GuildChallengeModule.Attack(formationID, layerCid)
	end
end

function GuildChallengeDetailInfoUI:OnBtnQuickChallenge()
	local top, formationID, layerCid = self:CheckChallenge()

	if top then
		local isPass = GuildChallengeModule.ChallengeLayerIsPass(layerCid)

		if not isPass then
			NoticeModule.ShowNotice(21066702)

			return
		end

		local cfg = CfgGuildChallengeLayerTable[layerCid]

		UIModule.Open(Constant.UIControllerName.SweepDetailConfirmUI, Constant.UILayer.UI, {
			CostEnergy = cfg.Cost[2],
			NeedItem = cfg.Cost[1],
			CallBack = function(count)
				GuildChallengeModule.MoPup(layerCid, count)
			end
		})
	end
end

return GuildChallengeDetailInfoUI
