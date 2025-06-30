-- chunkname: @IQIGame\\UI\\RPGActivityUI\\MazeBossChallengeEntryUIController.lua

local RpgMazeBossChallengeEntryCell = require("IQIGame.UI.RpgMaze.RpgMazeBossChallengeEntryCell")
local RpgBossTicketCell = require("IQIGame.UI.ExploreHall.RpgBossTicketCell")
local MazeBossChallengeEntryUIController = {
	currentPage = 1,
	isUnlock = false,
	isFree = false,
	boosCellPool = {},
	toggles = {}
}

function MazeBossChallengeEntryUIController.New(uiController)
	local obj = Clone(MazeBossChallengeEntryUIController)

	obj:__Init(uiController)

	return obj
end

function MazeBossChallengeEntryUIController:__Init(uiController)
	self.UIController = uiController
end

function MazeBossChallengeEntryUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function MazeBossChallengeEntryUIController:OnInit()
	UGUIUtil.SetText(self.TextTitle, MazeBossChallengeEntryUIApi:GetString("TextTitle", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TextBtnChallenge, MazeBossChallengeEntryUIApi:GetString("TextBtnChallenge"))
	UGUIUtil.SetText(self.TextBtnShop, MazeBossChallengeEntryUIApi:GetString("TextBtnShop", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TextBtnTitle, MazeBossChallengeEntryUIApi:GetString("TextBtnTitle"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateBtnLeft()
		self:OnBtnLeft()
	end

	function self.delegateBtnRight()
		self:OnBtnRight()
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateBtnShop()
		self:OnBtnShop()
	end

	function self.delegateBtnChallenge()
		self:OnBtnChallenge()
	end

	function self.delegateUpdateChallengeBoss()
		self:OnUpdateChallengeBoss()
	end

	function self.delegateBtnChallengeChild()
		self:OnBtnChallengeChild()
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	self.TicketCell = RpgBossTicketCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)

	AssetUtil.LoadImage(self, MazeBossChallengeEntryUIApi:GetString("RpgBossCurrencyIcon", RpgMazeModule.DailyDupPOD.common.openCount), self.ImgCost:GetComponent("Image"))
	self.ToggleMould:SetActive(false)
	self:CreateToggle()
end

function MazeBossChallengeEntryUIController:GetPreloadAssetPaths()
	return nil
end

function MazeBossChallengeEntryUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function MazeBossChallengeEntryUIController:IsManualShowOnOpen(userData)
	return false
end

function MazeBossChallengeEntryUIController:GetBGM(userData)
	return 412
end

function MazeBossChallengeEntryUIController:OnOpen(userData)
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	self.moneyCell:RefreshView({
		cfgRPGMazeControlData.ScoreItem
	})

	if userData then
		local bossList = table.clone(cfgRPGMazeControlData.BossList)

		table.sort(bossList, function(a, b)
			return a < b
		end)

		if bossList then
			for i = 1, #bossList do
				local id = bossList[i]

				if userData == id then
					self.currentPage = i

					break
				end
			end
		end
	end

	self:UpdateView()
end

function MazeBossChallengeEntryUIController:OnClose(userData)
	return
end

function MazeBossChallengeEntryUIController:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnChallengeChild:GetComponent("Button").onClick:AddListener(self.delegateBtnChallengeChild)
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.delegateBtnHelp)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function MazeBossChallengeEntryUIController:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnChallengeChild:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallengeChild)
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHelp)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
end

function MazeBossChallengeEntryUIController:OnPause()
	return
end

function MazeBossChallengeEntryUIController:OnResume()
	return
end

function MazeBossChallengeEntryUIController:OnCover()
	return
end

function MazeBossChallengeEntryUIController:OnReveal()
	return
end

function MazeBossChallengeEntryUIController:OnRefocus(userData)
	return
end

function MazeBossChallengeEntryUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function MazeBossChallengeEntryUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function MazeBossChallengeEntryUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function MazeBossChallengeEntryUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function MazeBossChallengeEntryUIController:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.moneyCell:Dispose()

	self.moneyCell = nil

	self.TicketCell:Dispose()

	for i, v in pairs(self.boosCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

function MazeBossChallengeEntryUIController:OnUpdateChallengeBoss()
	self:UpdateView()
end

function MazeBossChallengeEntryUIController:CreateToggle()
	self.toggles = {}

	for j = 1, self.ToggleBoss.transform.childCount - 1 do
		local obj = self.ToggleBoss.transform:GetChild(j).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]
	local bossList = table.clone(cfgRPGMazeControlData.BossList)

	table.sort(bossList, function(a, b)
		return a < b
	end)

	if bossList then
		for i = 1, #bossList do
			local RPGMazeBossCid = bossList[i]
			local obj = UnityEngine.Object.Instantiate(self.ToggleMould)

			obj.transform:SetParent(self.ToggleBoss.transform, false)
			obj:SetActive(true)

			local tog = obj:GetComponent("Toggle")

			tog.interactable = false
			tog.group = self.ToggleBoss:GetComponent("ToggleGroup")
			self.toggles[RPGMazeBossCid] = tog
		end
	end
end

function MazeBossChallengeEntryUIController:UpdateView()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	if cfgRPGMazeControlData then
		self.bossList = table.clone(cfgRPGMazeControlData.BossList)

		table.sort(self.bossList, function(a, b)
			return a < b
		end)
		self:RefreshList(self.currentPage)
		self.BtnChallenge:SetActive(RpgMazeModule.ExBossOpen())
		self.TicketCell:Refresh()
	end
end

function MazeBossChallengeEntryUIController:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex - 1

	self.scrollList:Refresh(#self.bossList)
end

function MazeBossChallengeEntryUIController:OnRenderCell(cell)
	local data = self.bossList[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.boosCellPool[instanceID]

	if bossCell == nil then
		bossCell = RpgMazeBossChallengeEntryCell.New(cell.gameObject, self)
		self.boosCellPool[instanceID] = bossCell
	end

	bossCell:SetData(data)
end

function MazeBossChallengeEntryUIController:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	local boosID = self.bossList[self.currentPage]

	self.cfgRPGMazeBossData = CfgRPGMazeBossTable[boosID]

	self.BtnLeft:SetActive(self.currentPage > 1)
	self.BtnRight:SetActive(self.currentPage < #self.bossList)
	self:ShowSelect()
end

function MazeBossChallengeEntryUIController:ShowSelect()
	self.isUnlock = RpgMazeModule.IsUnlockBoos(self.cfgRPGMazeBossData.Id)

	local freeCount = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid].BossFreeChallengeCount
	local useCont = RpgMazeModule.DailyDupPOD.rpgMazePOD.freeChallengeBossCount

	self.isFree = useCont < freeCount

	self.Cost:SetActive(not self.isFree)

	local showLock = RpgMazeModule.DailyDupPOD.common.status ~= 1 or not self.isUnlock

	self.Locked:SetActive(showLock)
	self.UnLockImg:SetActive(not showLock)
	UGUIUtil.SetText(self.TextChallenge, MazeBossChallengeEntryUIApi:GetString("TextChallenge", self.isFree, not self.isUnlock))
	UGUIUtil.SetText(self.TextNeedNum, self.cfgRPGMazeBossData.ChallengeBossCostTickets)

	self.toggles[self.cfgRPGMazeBossData.Id].isOn = true
end

function MazeBossChallengeEntryUIController:OnBtnChallengeChild()
	if not self.isUnlock then
		NoticeModule.ShowNoticeByType(1, MazeBossDetailUIApi:GetString("UnlockError"))

		return
	end

	if RpgMazeModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	if not self.isFree and self.cfgRPGMazeBossData.ChallengeBossCostTickets > RpgMazeModule.DailyDupPOD.rpgMazePOD.tickets then
		local cfgDailyDupData = CfgDailyDupTable[RpgMazeModule.DailyDupPOD.common.cid]
		local chapterName = cfgDailyDupData.ChapterName[RpgMazeModule.DailyDupPOD.common.openCount]

		NoticeModule.ShowNotice(21057001, function()
			JumpModule.Jump(10206028)
			UIModule.Close(Constant.UIControllerName.MazeBossChallengeEntryUI)
		end, nil, self, chapterName)
	else
		UIModule.Open(Constant.UIControllerName.MazeBossDetailUI, Constant.UILayer.UI, {
			self.cfgRPGMazeBossData,
			self.isFree
		})
	end
end

function MazeBossChallengeEntryUIController:OnBtnLeft()
	if self.currentPage > 1 then
		self.scrollList:TurnToBackward()
	end
end

function MazeBossChallengeEntryUIController:OnBtnRight()
	if self.currentPage < #self.bossList then
		self.scrollList:TurnToForward()
	end
end

function MazeBossChallengeEntryUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.MazeBossChallengeEntryUI)
end

function MazeBossChallengeEntryUIController:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.RpgMaze, RpgMazeModule.GetMallCidList())
end

function MazeBossChallengeEntryUIController:OnBtnChallenge()
	UIModule.Open(Constant.UIControllerName.MazeBossChallengeDetailUI, Constant.UILayer.UI)
end

function MazeBossChallengeEntryUIController:OnBtnHelp()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 9000)
end

return MazeBossChallengeEntryUIController
