-- chunkname: @IQIGame\\UI\\DualTeamExplore\\ActivityUI\\DualTeamExploreBossChallengeUIController.lua

local DualTeamBossChallengeEntryCell = require("IQIGame.UI.DualTeamExplore.DualTeamBossChallenge.DualTeamBossChallengeEntryCell")
local DualTeamExploreTicketCell = require("IQIGame.UI.DualTeamExplore.DualTeamExploreTicketCell")
local DualTeamExploreBossChallengeUIController = {
	currentPage = 1,
	isUnlock = false,
	isFree = false,
	boosCellPool = {},
	toggles = {}
}

function DualTeamExploreBossChallengeUIController.New(uiController)
	local obj = Clone(DualTeamExploreBossChallengeUIController)

	obj:__Init(uiController)

	return obj
end

function DualTeamExploreBossChallengeUIController:__Init(uiController)
	self.UIController = uiController
end

function DualTeamExploreBossChallengeUIController:InitView(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
end

function DualTeamExploreBossChallengeUIController:OnInit()
	function self.DelegateOnClickBtnChallengeChild()
		self:OnClickBtnChallengeChild()
	end

	function self.DelegateOnClickBtnRight()
		self:OnClickBtnRight()
	end

	function self.DelegateOnClickBtnLeft()
		self:OnClickBtnLeft()
	end

	function self.DelegateOnClickBtnShop()
		self:OnClickBtnShop()
	end

	function self.DelegateOnClickBtnChallenge()
		self:OnClickBtnChallenge()
	end

	function self.DelegateOnClickBtnHelp()
		self:OnClickBtnHelp()
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateUpdateDailyDup()
		self:OnUpdateDailyDup()
	end

	UGUIUtil.SetText(self.TextTitle, DualTeamExploreBossChallengeUIApi:GetString("TextTitle", DualTeamExploreModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetText(self.TextBtnChallenge, DualTeamExploreBossChallengeUIApi:GetString("TextBtnChallenge"))
	UGUIUtil.SetText(self.TextBtnShop, DualTeamExploreBossChallengeUIApi:GetString("TextBtnShop"))
	UGUIUtil.SetText(self.TextBtnTitle, DualTeamExploreBossChallengeUIApi:GetString("TextBtnTitle"))

	self.scrollList = self.ScrollArea:GetComponent("ScrollAreaListPage")

	function self.scrollList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollList.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	self:InitData()

	self.TicketCell = DualTeamExploreTicketCell.New(self.EnergyCom.transform:GetChild(0).gameObject)
	self.moneyCell = MoneyCellsBuilder.New(self.CurrencyContainer)

	self.ToggleMould:SetActive(false)
	self:CreateToggle()
end

function DualTeamExploreBossChallengeUIController:GetPreloadAssetPaths()
	return nil
end

function DualTeamExploreBossChallengeUIController:GetOpenPreloadAssetPaths(userData)
	return nil
end

function DualTeamExploreBossChallengeUIController:IsManualShowOnOpen(userData)
	return false
end

function DualTeamExploreBossChallengeUIController:GetBGM(userData)
	return nil
end

function DualTeamExploreBossChallengeUIController:OnOpen(userData)
	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	self.moneyCell:RefreshView({
		cfgDualTeamExploreControlData.ShopVoucher
	})

	if userData and self.bossList then
		for i = 1, #self.bossList do
			local id = self.bossList[i]

			if userData == id then
				self.currentPage = i

				break
			end
		end
	end

	self:UpdateView()
end

function DualTeamExploreBossChallengeUIController:OnClose(userData)
	return
end

function DualTeamExploreBossChallengeUIController:OnAddListeners()
	self.BtnChallengeChild:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnChallengeChild)
	self.BtnRight:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnLeft)
	self.BtnShop:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnChallenge)
	self.BtnHelp:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnHelp)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreBossChallengeUIController:OnRemoveListeners()
	self.BtnChallengeChild:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnChallengeChild)
	self.BtnRight:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnRight)
	self.BtnLeft:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnLeft)
	self.BtnShop:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnShop)
	self.BtnChallenge:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnChallenge)
	self.BtnHelp:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnHelp)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDup)
end

function DualTeamExploreBossChallengeUIController:OnPause()
	return
end

function DualTeamExploreBossChallengeUIController:OnResume()
	return
end

function DualTeamExploreBossChallengeUIController:OnCover()
	return
end

function DualTeamExploreBossChallengeUIController:OnReveal()
	return
end

function DualTeamExploreBossChallengeUIController:OnRefocus(userData)
	return
end

function DualTeamExploreBossChallengeUIController:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function DualTeamExploreBossChallengeUIController:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function DualTeamExploreBossChallengeUIController:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function DualTeamExploreBossChallengeUIController:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function DualTeamExploreBossChallengeUIController:OnDestroy()
	self.moneyCell:Dispose()

	self.moneyCell = nil

	self.TicketCell:Dispose()

	for i, v in pairs(self.boosCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
	self.scrollList = nil
end

function DualTeamExploreBossChallengeUIController:InitData()
	self.bossList = {}

	local cfgDualTeamExploreControlData = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid]

	for i = 1, #cfgDualTeamExploreControlData.Level do
		local id = cfgDualTeamExploreControlData.Level[i]
		local cfgExploreLevelData = CfgDualTeamExploreLevelTable[id]

		if cfgExploreLevelData.Boss > 0 and table.indexOf(self.bossList, cfgExploreLevelData.Boss) == -1 then
			table.insert(self.bossList, cfgExploreLevelData.Boss)
		end
	end

	table.sort(self.bossList, function(a, b)
		return a < b
	end)
end

function DualTeamExploreBossChallengeUIController:CreateToggle()
	self.toggles = {}

	for j = 1, self.ToggleBoss.transform.childCount - 1 do
		local obj = self.ToggleBoss.transform:GetChild(j).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	if self.bossList then
		for i = 1, #self.bossList do
			local RPGMazeBossCid = self.bossList[i]
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

function DualTeamExploreBossChallengeUIController:OnUpdateDailyDup()
	self:UpdateView()
end

function DualTeamExploreBossChallengeUIController:UpdateView()
	self:RefreshList(self.currentPage)
	self.BtnChallenge:SetActive(DualTeamExploreModule.ExBossOpen())
	self.TicketCell:Refresh()
end

function DualTeamExploreBossChallengeUIController:RefreshList(startIndex)
	self.scrollList.startIndex = startIndex - 1

	self.scrollList:Refresh(#self.bossList)
end

function DualTeamExploreBossChallengeUIController:OnRenderCell(cell)
	local data = self.bossList[cell.index + 1]

	if data == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local bossCell = self.boosCellPool[instanceID]

	if bossCell == nil then
		bossCell = DualTeamBossChallengeEntryCell.New(cell.gameObject, self)
		self.boosCellPool[instanceID] = bossCell
	end

	bossCell:SetData(data)
end

function DualTeamExploreBossChallengeUIController:OnPageReachedMain(page)
	self.currentPage = page.index + 1

	local boosID = self.bossList[self.currentPage]

	self.cfgBossData = CfgDualTeamExploreBossTable[boosID]

	self.BtnLeft:SetActive(self.currentPage > 1)
	self.BtnRight:SetActive(self.currentPage < #self.bossList)
	self:ShowSelect()
end

function DualTeamExploreBossChallengeUIController:ShowSelect()
	self.isUnlock = DualTeamExploreModule.IsUnlockBoos(self.cfgBossData.Id)

	local freeCount = CfgDualTeamExploreControlTable[DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.controlCid].BossFreeChallengeCount
	local useCont = DualTeamExploreModule.DailyDupPOD.dualTeamExplorePOD.freeChallengeBossCount

	self.isFree = useCont < freeCount

	self.Cost:SetActive(not self.isFree)

	local showLock = DualTeamExploreModule.DailyDupPOD.common.status ~= 1 or not self.isUnlock

	self.Locked:SetActive(showLock)
	self.UnLockImg:SetActive(not showLock)
	UGUIUtil.SetText(self.TextChallenge, DualTeamExploreBossChallengeUIApi:GetString("TextChallenge", self.isFree, not self.isUnlock))
	UGUIUtil.SetText(self.TextNeedNum, self.cfgBossData.ChallengeBossCostTickets)

	self.toggles[self.cfgBossData.Id].isOn = true
end

function DualTeamExploreBossChallengeUIController:OnClickBtnChallengeChild()
	if not self.isUnlock then
		NoticeModule.ShowNotice(21040128)

		return
	end

	if DualTeamExploreModule.DailyDupPOD.common.status ~= 1 then
		NoticeModule.ShowNotice(21057003)

		return
	end

	UIModule.Open(Constant.UIControllerName.DualTeamExploreBossDetailUI, Constant.UILayer.UI, {
		self.cfgBossData,
		self.isFree
	})
end

function DualTeamExploreBossChallengeUIController:OnClickBtnRight()
	if self.currentPage < #self.bossList then
		self.scrollList:TurnToForward()
	end
end

function DualTeamExploreBossChallengeUIController:OnClickBtnLeft()
	if self.currentPage > 1 then
		self.scrollList:TurnToBackward()
	end
end

function DualTeamExploreBossChallengeUIController:OnClickBtnShop()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.DualTeamExploreShop, DualTeamExploreModule.GetMallCidList())
end

function DualTeamExploreBossChallengeUIController:OnClickBtnChallenge()
	return
end

function DualTeamExploreBossChallengeUIController:OnClickBtnHelp()
	return
end

function DualTeamExploreBossChallengeUIController:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return DualTeamExploreBossChallengeUIController
