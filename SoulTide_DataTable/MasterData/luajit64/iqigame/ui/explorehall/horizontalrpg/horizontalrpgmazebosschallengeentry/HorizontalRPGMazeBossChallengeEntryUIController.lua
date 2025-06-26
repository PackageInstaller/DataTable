-- chunkname: @IQIGame\\UI\\ExploreHall\\HorizontalRPG\\HorizontalRPGMazeBossChallengeEntry\\HorizontalRPGMazeBossChallengeEntryUIController.lua

local HorizontalRPGMazeBossChallengeEntryUIController = {
	currentPage = 1,
	isUnlock = false,
	isFree = false,
	boosCellPool = {},
	toggles = {}
}
local HorizontalRpgMazeBossChallengeEntryCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGMazeBossChallengeEntry.HorizontalRpgMazeBossChallengeEntryCell")
local HorizontalRPGTicketCell = require("IQIGame.UI.ExploreHall.HorizontalRPG.HorizontalRPGTicketCell")

function HorizontalRPGMazeBossChallengeEntryUIController.New(uiController)
	local obj = Clone(HorizontalRPGMazeBossChallengeEntryUIController)

	obj:__Init(uiController)

	return obj
end

function HorizontalRPGMazeBossChallengeEntryUIController:__Init(uiController)
	self.UIController = uiController
end

function HorizontalRPGMazeBossChallengeEntryUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnInit()
	UGUIUtil.SetText(self.TextTitle, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("TextTitle", HorizontalRPGModule.globalCid))
	UGUIUtil.SetText(self.TextBtnChallenge, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("TextBtnChallenge"))
	UGUIUtil.SetText(self.TextBtnShop, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("TextBtnShop", HorizontalRPGModule.globalCid))
	UGUIUtil.SetText(self.TextBtnTitle, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("TextBtnTitle"))

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

	function self.delegateUnlockBoss()
		self:OnUnlockBoss()
	end

	function self.DelegateBtnQuick()
		self:OnBtnQuick()
	end

	self.TicketCell = HorizontalRPGTicketCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)

	self.CurrencyContainer:SetActive(false)
	AssetUtil.LoadImage(self, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("RpgBossCurrencyIcon", HorizontalRPGModule.globalCid), self.ImgCost:GetComponent("Image"))
	self.ToggleMould:SetActive(false)
	self:CreateToggle()
end

function HorizontalRPGMazeBossChallengeEntryUIController:GetPreloadAssetPaths()
	return nil
end

function HorizontalRPGMazeBossChallengeEntryUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HorizontalRPGMazeBossChallengeEntryUIController:IsManualShowOnOpen(userData)
	return false
end

function HorizontalRPGMazeBossChallengeEntryUIController:GetBGM(userData)
	return nil
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnOpen(userData)
	local cfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	self.moneyCell:RefreshView({
		cfgHorizontalRPGControlData.MoneyId
	})

	if userData then
		local bossList = table.clone(cfgHorizontalRPGControlData.BossList)

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

function HorizontalRPGMazeBossChallengeEntryUIController:OnClose(userData)
	for i, v in pairs(self.boosCellPool) do
		v:HideEntity()
	end
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.delegateBtnRight)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.delegateBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.delegateBtnChallenge)
	self.BtnChallengeChild:GetComponent("Button").onClick:AddListener(self.delegateBtnChallengeChild)
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.delegateBtnHelp)
	self.BtnQuick:GetComponent("Button").onClick:AddListener(self.DelegateBtnQuick)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
	EventDispatcher.AddEventListener(EventID.HorizontalRPGUnlockBossEvent, self.delegateUnlockBoss)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.delegateBtnClose)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.delegateBtnLeft)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.delegateBtnRight)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.delegateBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallenge)
	self.BtnChallengeChild:GetComponent("Button").onClick:RemoveListener(self.delegateBtnChallengeChild)
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHelp)
	self.BtnQuick:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnQuick)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateChallengeBoss)
	EventDispatcher.RemoveEventListener(EventID.HorizontalRPGUnlockBossEvent, self.delegateUnlockBoss)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnPause()
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnResume()
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnCover()
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnReveal()
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnRefocus(userData)
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnDestroy()
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

function HorizontalRPGMazeBossChallengeEntryUIController:OnUpdateChallengeBoss()
	self:UpdateView()
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnUnlockBoss()
	self:UpdateView()
end

function HorizontalRPGMazeBossChallengeEntryUIController:CreateToggle()
	self.toggles = {}

	for j = 1, self.ToggleBoss.transform.childCount - 1 do
		local obj = self.ToggleBoss.transform:GetChild(j).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	local CfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]
	local bossList = table.clone(CfgHorizontalRPGControlData.BossList)

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

function HorizontalRPGMazeBossChallengeEntryUIController:UpdateView()
	local CfgHorizontalRPGControlData = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid]

	if CfgHorizontalRPGControlData then
		self.bossList = table.clone(CfgHorizontalRPGControlData.BossList)

		table.sort(self.bossList, function(a, b)
			return a < b
		end)
		self:RefreshList(self.currentPage)
		self.BtnChallenge:SetActive(HorizontalRPGModule.ExBossOpen())
	end
end

function HorizontalRPGMazeBossChallengeEntryUIController:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex - 1

	self.scrollList:Refresh(#self.bossList)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnRenderCell(cell)
	local data = self.bossList[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.boosCellPool[instanceID]

	if bossCell == nil then
		bossCell = HorizontalRpgMazeBossChallengeEntryCell.New(cell.gameObject, self)
		self.boosCellPool[instanceID] = bossCell
	end

	bossCell:SetData(data)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	local boosID = self.bossList[self.currentPage]

	self.cfgHorizontalRPGBossData = CfgHorizontalRPGBossTable[boosID]

	self.BtnLeft:SetActive(self.currentPage > 1)
	self.BtnRight:SetActive(self.currentPage < #self.bossList)
	self:ShowSelect()
end

function HorizontalRPGMazeBossChallengeEntryUIController:ShowSelect()
	self.isUnlock = HorizontalRPGModule.IsUnlockBoos(self.cfgHorizontalRPGBossData.Id)

	local freeCount = CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid].BossFreeChallengeCount
	local useCont = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.freeChallengeBossCount or 0

	self.isFree = useCont < freeCount

	self.Cost:SetActive(not self.isFree)

	local showLock = HorizontalRPGModule.CanNotEnter()

	self.Locked:SetActive(not showLock)
	self.UnLockImg:SetActive(showLock)
	UGUIUtil.SetText(self.TextChallenge, HorizontalRPGMazeBossChallengeEntryUIApi:GetString("TextChallenge", self.isFree, not self.isUnlock))
	UGUIUtil.SetText(self.TextNeedNum, self.cfgHorizontalRPGBossData.ChallengeBossCostTickets)

	local isKill = table.indexOf(HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.killBoss or {}, self.cfgHorizontalRPGBossData.Id) ~= -1

	self.BtnQuick:SetActive(isKill)

	self.toggles[self.cfgHorizontalRPGBossData.Id].isOn = true
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnChallengeChild()
	if not self.isUnlock then
		return
	end

	if not HorizontalRPGModule.CanNotEnter() then
		NoticeModule.ShowNotice(21057003)

		return
	end

	local tickets = HorizontalRPGModule.dailyDupPOD.horizontalRPGPOD.tickets or 0

	if not self.isFree and tickets < self.cfgHorizontalRPGBossData.ChallengeBossCostTickets then
		local cfgDailyDupData = CfgDailyDupTable[HorizontalRPGModule.dailyDupPOD.common.cid]
		local chapterName = cfgDailyDupData.ChapterName[HorizontalRPGModule.dailyDupPOD.common.openCount]

		NoticeModule.ShowNotice(21057001, function()
			JumpModule.Jump(10206028)
			UIModule.CloseSelf(self)
		end, nil, self, chapterName)
	else
		UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeBossDetailUI, Constant.UILayer.UI, {
			self.cfgHorizontalRPGBossData,
			self.isFree
		})
	end
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnLeft()
	if self.currentPage > 1 then
		self.scrollList:TurnToBackward()
	end
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnRight()
	if self.currentPage < #self.bossList then
		self.scrollList:TurnToForward()
	end
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HorizontalRPGMazeBossChallengeEntryUI)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.HorizontalRPGShop)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnChallenge()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeBossChallengeDetailUI, Constant.UILayer.UI, CfgHorizontalRPGControlTable[HorizontalRPGModule.globalCid])
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnHelp()
	UIModule.Open(Constant.UIControllerName.ComUIInfoUI, Constant.UILayer.UI, 9000)
end

function HorizontalRPGMazeBossChallengeEntryUIController:OnBtnQuick()
	UIModule.Open(Constant.UIControllerName.HorizontalRPGMazeSweepDetailConfirmUI, Constant.UILayer.UI, {
		RPGBoss = self.cfgHorizontalRPGBossData,
		HaveFree = self.isFree
	})
end

return HorizontalRPGMazeBossChallengeEntryUIController
