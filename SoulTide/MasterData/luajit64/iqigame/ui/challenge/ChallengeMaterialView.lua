-- chunkname: @IQIGame\\UI\\Challenge\\ChallengeMaterialView.lua

local ChallengeMaterialView = {
	failureCD = 0,
	lastOpenMax = 1,
	currentTimes = 0,
	MonsterElementCells = {},
	ItemCells = {}
}
local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local MonsterElementCell = require("IQIGame.UI.MazeDetail.MonsterElementCell")
local MazeRewardCell = require("IQIGame.UI.MazeDetail.MazeRewardCell")

function ChallengeMaterialView.New(ui1, ui2, ui3, rootParent)
	local o = Clone(ChallengeMaterialView)

	o:InitView(ui1, ui2, ui3, rootParent)

	return o
end

function ChallengeMaterialView:InitView(ui1, ui2, ui3, rootParent)
	self.rootUI = ui1
	self.rightDown = ui2
	self.rightUp = ui3
	self.rootParent = rootParent

	LuaCodeInterface.BindOutlet(self.rootUI, self)
	LuaCodeInterface.BindOutlet(self.rightDown, self)
	LuaCodeInterface.BindOutlet(self.rightUp, self)
	UGUIUtil.SetText(self.TextTitle1, ChallengeUIApi:GetString("TextTitle1", 1))
	UGUIUtil.SetText(self.TextTitle2, ChallengeUIApi:GetString("TextTitle2", 1))
	UGUIUtil.SetText(self.TextTitle3, ChallengeUIApi:GetString("TextTitle3", 1))
	UGUIUtil.SetText(self.TimesTitle, ChallengeUIApi:GetString("TimesTitle"))
	UGUIUtil.SetText(self.TextSweepingBtn, ChallengeUIApi:GetString("TextSweepingBtn"))
	UGUIUtil.SetText(self.TextChallengeBtn, ChallengeUIApi:GetString("TextChallenge"))

	self.challengeBtnComponent = self.ChallengeBtn:GetComponent("Button")
	self.sweepingBtnComponent = self.SweepingBtn:GetComponent("Button")
	self.buyTimesBtnComponent = self.BuyTimesBtn:GetComponent("Button")
	self.scrollListPage = self.Toggle:GetComponent("ScrollAreaListPage")

	function self.scrollListPage.onRenderCell(cell)
		self:OnRenderCell(cell)
	end

	function self.scrollListPage.onPageReachedMainPos(page)
		self:OnPageReachedMain(page)
	end

	function self.delegateToggleValueChange(isOn)
		self:OnClickTog(isOn)
	end

	function self.delegateOnClickBtnChallenge()
		self:OnClickBtnChallenge()
	end

	function self.delegateOnClickBtnSweeping()
		self:OnClickBtnSweeping()
	end

	function self.delegateOnClickBtnBuyTimes()
		self:OnClickBtnBuyTimes()
	end

	function self.delegateAlertCall()
		self:OnAlertCall()
	end

	function self.delegateChallengeDup()
		self:ChallengeDupFun()
	end

	function self.delegateUpdateChallengeFailure(levelCid)
		self:OnUpdateChallengeFailure(levelCid)
	end

	function self.delegateUpdateTime()
		self:OnUpdateTime()
	end

	self.timer = Timer.New(self.delegateUpdateTime, 1, -1)
	self.MonsterElementPool = UIObjectPool.New(5, function()
		local cell = MonsterElementCell.New(UnityEngine.Object.Instantiate(self.Mould2))

		return cell
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)
	self.ItemCellPool = UIObjectPool.New(10, function()
		return MazeRewardCell.New(UnityEngine.Object.Instantiate(self.Mould1))
	end, function(cell)
		cell:Dispose()
	end)

	self:AddEventListener()
end

function ChallengeMaterialView:AddEventListener()
	self.challengeBtnComponent.onClick:AddListener(self.delegateOnClickBtnChallenge)
	self.sweepingBtnComponent.onClick:AddListener(self.delegateOnClickBtnSweeping)
	self.buyTimesBtnComponent.onClick:AddListener(self.delegateOnClickBtnBuyTimes)
	EventDispatcher.AddEventListener(EventID.UpdateChallengeFailure, self.delegateUpdateChallengeFailure)
end

function ChallengeMaterialView:RemoveEventListener()
	self.challengeBtnComponent.onClick:RemoveListener(self.delegateOnClickBtnChallenge)
	self.sweepingBtnComponent.onClick:RemoveListener(self.delegateOnClickBtnSweeping)
	self.buyTimesBtnComponent.onClick:RemoveListener(self.delegateOnClickBtnBuyTimes)
	EventDispatcher.RemoveEventListener(EventID.UpdateChallengeFailure, self.delegateUpdateChallengeFailure)
end

function ChallengeMaterialView:Dispose()
	AssetUtil.UnloadAsset(self)

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

	if self.timer then
		self.timer:Stop()
	end

	self.timer = nil

	self:RemoveEventListener()
	LuaCodeInterface.ClearOutlet(self.rootUI, self)
	LuaCodeInterface.ClearOutlet(self.rightDown, self)
	LuaCodeInterface.ClearOutlet(self.rightUp, self)

	self.changeFun = nil
	self.rootUI = nil
	self.rightDown = nil
	self.rightUp = nil
end

function ChallengeMaterialView:UpdateView(data)
	self.challengeData = data

	local maxOpenIndex = self.challengeData:GetLockIndex()

	if self.currentTabIndex == nil then
		self.lastOpenMax = maxOpenIndex
		self.currentTabIndex = maxOpenIndex
	elseif maxOpenIndex > self.lastOpenMax then
		self.lastOpenMax = maxOpenIndex
		self.currentTabIndex = maxOpenIndex
	end

	self.challengeLayerData = data.challengeLayerDic[self.currentTabIndex]

	self.BuyTimesBtn:SetActive(self.challengeData.isOpenTime)

	self.scrollListPage.startIndex = self.currentTabIndex - 1

	self.scrollListPage:Refresh(#self.challengeData.challengeLayerDic)
	self:ShowDetails()
end

function ChallengeMaterialView:OnRenderCell(cell)
	local layerData = self.challengeData.challengeLayerDic[cell.index + 1]
	local goObj = cell.gameObject
	local tab = {}

	LuaCodeInterface.BindOutlet(goObj, tab)
	UGUIUtil.SetText(tab.OnText1, ChallengeUIApi:GetString("TextDifficulty", layerData.cfgInfo.Difficulty, 1))
	UGUIUtil.SetText(tab.OffText2, ChallengeUIApi:GetString("TextDifficulty", layerData.cfgInfo.Difficulty, 1))
	UGUIUtil.SetText(tab.OffText1, ChallengeUIApi:GetString("TextDifficulty", layerData.cfgInfo.Difficulty, 1))
	UGUIUtil.SetText(tab.OnText2, ChallengeUIApi:GetString("OnText2"))
	UGUIUtil.SetText(tab.TextLock, ChallengeUIApi:GetString("TextTitle6", layerData.cfgInfo.LevelLimit))
	UGUIUtil.SetText(tab.TextLock1, ChallengeUIApi:GetString("TextLock1"))
	tab.nodeLock:SetActive(not layerData.isLock)
	tab.nodeUp:SetActive(layerData.isLock)
	tab.nodeDown:SetActive(layerData.isLock)

	if layerData.isLock then
		if self.currentTabIndex == cell.index + 1 then
			tab.nodeUp:SetActive(true)
			tab.nodeDown:SetActive(false)

			self.selectObj = goObj
			self.selectData = layerData
		else
			tab.nodeUp:SetActive(false)
			tab.nodeDown:SetActive(true)
		end
	end

	LuaCodeInterface.ClearOutlet(goObj, tab)
end

function ChallengeMaterialView:OnPageReachedMain(page)
	self.currentTabIndex = page.index + 1
	self.challengeLayerData = self.challengeData.challengeLayerDic[self.currentTabIndex]

	self:ChangeSelect(page.gameObject.transform:GetChild(0).gameObject, self.challengeLayerData)
end

function ChallengeMaterialView:ChangeSelect(goObj, data)
	if self.selectObj ~= goObj then
		self.selectObj = goObj
		self.selectData = data

		local newTab = {}

		LuaCodeInterface.BindOutlet(self.selectObj, newTab)
		newTab.nodeLock:SetActive(not self.challengeLayerData.isLock)

		if self.challengeLayerData.isLock then
			newTab.nodeUp:SetActive(true)
			newTab.nodeDown:SetActive(false)
		else
			newTab.nodeUp:SetActive(false)
			newTab.nodeDown:SetActive(false)
		end

		self:ShowDetails()
		LuaCodeInterface.ClearOutlet(self.selectObj, newTab)
	end
end

function ChallengeMaterialView:ShowDetails()
	if self.challengeLayerData ~= nil then
		self.TextName:GetComponent("Text").text = self.challengeLayerData.cfgInfo.Name

		UGUIUtil.SetText(self.TextDes, self.challengeLayerData.cfgInfo.RuleDescription)
		UGUIUtil.SetText(self.TextState, "")

		for i, v in pairs(self.MonsterElementCells) do
			v.View.transform:SetParent(nil, false)
			v.View:SetActive(false)
			self.MonsterElementPool:Release(v)
		end

		self.MonsterElementCells = {}

		local openCount = 1
		local dailyDupPod = DailyDupModule.GetDailyDupPOD(self.challengeData.cfgID)

		if dailyDupPod then
			openCount = dailyDupPod.common.openCount
		end

		local monsterLen = #self.challengeLayerData.cfgInfo.MonsterTeam
		local index = 1

		if monsterLen > 1 then
			index = openCount % monsterLen + 1
		end

		local monsterTeamID = self.challengeLayerData.cfgInfo.MonsterTeam[index]
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

		local sortTab = {}

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

		for i = 1, #sortTab do
			local b = sortTab[i]
			local cell = self.MonsterElementPool:Obtain()

			cell.View:SetActive(true)
			cell.View.transform:SetParent(self.MonsterGrid.transform, false)
			cell:SetData(b.weakType)
			table.insert(self.MonsterElementCells, cell)
		end

		self:OnUpdateFormation()

		for i, v in pairs(self.ItemCells) do
			v.View.transform:SetParent(nil, false)
			v.View:SetActive(false)
			self.ItemCellPool:Release(v)
		end

		self.ItemCells = {}

		for i = 1, #self.challengeLayerData.cfgInfo.Reward, 2 do
			local itemId = self.challengeLayerData.cfgInfo.Reward[i]
			local itemNum = self.challengeLayerData.cfgInfo.Reward[i + 1]
			local itemCell = self.ItemCellPool:Obtain()

			itemCell.View:SetActive(true)
			itemCell.View.transform:SetParent(self.Slot.transform, false)
			itemCell:SetData(itemId, itemNum)
			table.insert(self.ItemCells, itemCell)
		end

		if self.challengeData.isOpenTime then
			if dailyDupPod then
				self.totalTimes = self.challengeData.cfgInfo.Times
				self.currentTimes = self.totalTimes + dailyDupPod.buyCount - dailyDupPod.enterCount
				self.TextTimes:GetComponent("Text").text = ChallengeUIApi:GetString("TextTimes", self.currentTimes, self.totalTimes)
			end
		else
			self.TextTimes:GetComponent("Text").text = self.challengeData.cfgInfo.Describe
		end

		self:OnChangeFun(self.challengeLayerData)

		local iconPath = UIGlobalApi.GetIconPath(CfgItemTable[Constant.ItemID.ENERGY].Icon)

		AssetUtil.LoadImage(self, iconPath, self.ImgIcon:GetComponent("Image"))
		UGUIUtil.SetText(self.SpendNum, ChallengeUIApi:GetString("SpendEnergy", self.challengeLayerData.cfgInfo.CostEnergy, PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY)))
	end
end

function ChallengeMaterialView:OnUpdateFormation()
	if self.challengeLayerData then
		self.rootParent:ShowPower(self.rootParent.FormationPanelController:GetPower(), self.challengeLayerData.cfgInfo.RecPower)
	end
end

function ChallengeMaterialView:OnUpdateChallengeFailure(levelCid)
	if levelCid == self.challengeLayerData.cfgID then
		self:SetPlayerPrefabs(self.challengeLayerData.cfgID, PlayerModule.GetServerTime())
		self:OnChangeFun(self.challengeLayerData)
	end
end

function ChallengeMaterialView:OnClickMonsterCell(monsterID)
	UIModule.Open(Constant.UIControllerName.BattleMonsterInfoUI, Constant.UILayer.UI, {
		monsterCid = monsterID
	})
end

function ChallengeMaterialView:OnclickBtnMsg()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		Constant.UILayer.UI,
		self.challengeLayerData.cfgInfo.RuleDescription
	})
end

function ChallengeMaterialView:SetPlayerPrefabs(key, value)
	local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeCD)

	if dataTab == nil then
		dataTab = {}
	end

	dataTab[tostring(key)] = value

	PlayerPrefsUtil.SetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeCD, dataTab)
end

function ChallengeMaterialView:OnChangeFun(challengeLayerData)
	local preData = self:GetChallengeCD(challengeLayerData.cfgID)

	if preData ~= nil then
		self.failureCD = challengeLayerData.cfgInfo.ColdDown - (PlayerModule.GetServerTime() - tonumber(preData))

		self:OnUpdateTime()
	else
		self.failureCD = 0
		self.TextChallengeBtn:GetComponent("Text").text = ChallengeUIApi:GetString("TextChallenge")
	end

	if self.failureCD > 0 then
		self.timer:Start()
	end
end

function ChallengeMaterialView:OnUpdateTime()
	self.failureCD = self.failureCD - 1

	if self.failureCD > 0 then
		self.TextChallengeBtn:GetComponent("Text").text = self:GetFormatTime(self.failureCD)
	else
		self.TextChallengeBtn:GetComponent("Text").text = ChallengeUIApi:GetString("TextChallenge")

		self.timer:Stop()
	end
end

function ChallengeMaterialView:GetFormatTime(second)
	local timeText = ""
	local h = math.floor(second / 3600)

	h = h < 10 and "0" .. h or tostring(h)

	local m = math.floor(second % 3600 / 60)

	m = m < 10 and "0" .. m or tostring(m)

	local s = math.floor(second % 60)

	s = s < 10 and "0" .. s or tostring(s)
	timeText = string.format("%s:%s:%s", h, m, s)

	return timeText
end

function ChallengeMaterialView:GetChallengeCD(id)
	local dataTab = PlayerPrefsUtil.GetLuaTable(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.ChallengeCD)

	if dataTab then
		return dataTab[tostring(id)]
	end

	return nil
end

function ChallengeMaterialView:IsMaxLv(layerID)
	local index

	for i = 1, #self.challengeData.challengeLayerDic do
		local layerData = self.challengeData.challengeLayerDic[i]

		if layerData.cfgID == layerID then
			index = i

			break
		end
	end

	if index < #self.challengeData.challengeLayerDic then
		local data = self.challengeData.challengeLayerDic[index + 1]

		return not data.isLock
	end

	return true
end

function ChallengeMaterialView:ChallengeDupFun()
	ChallengeModule.ChallengeDup(self.challengeLayerData.cfgID, self.formationID)
end

function ChallengeMaterialView:OnClickBtnChallenge()
	if self.challengeData.isOpenTime == false then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice1"))

		return
	end

	if #PlayerModule.PlayerInfo.formations == 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice2"))

		return
	end

	local valid, formationPOD = self.rootParent.FormationPanelController:CheckValidation()

	if not valid then
		return
	end

	self.formationID = formationPOD.id

	if self.currentTimes <= 0 then
		local dailyDupPOD = DailyDupModule.GetDailyDupPOD(self.challengeData.cfgID)
		local times = #self.challengeData.cfgInfo.BuyTimesCost - dailyDupPOD.buyCount

		if times > 0 then
			self:OnClickBtnBuyTimes()
		else
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice4"))
		end

		return
	end

	if self.failureCD > 0 then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice3"))

		return
	end

	if PlayerModule.PlayerInfo.baseInfo.pLv < self.challengeLayerData.cfgInfo.LevelLimit then
		NoticeModule.ShowNoticeNoCallback(21045022)

		return
	end

	if not self.challengeLayerData.isLock then
		NoticeModule.ShowNoticeNoCallback(21045023)

		return
	end

	if PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY) < self.challengeLayerData.cfgInfo.CostEnergy then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice8"))

		return
	end

	if self:IsMaxLv(self.challengeLayerData.cfgID) then
		self:ChallengeDupFun()
	else
		NoticeModule.ShowNotice(21048002, self.delegateChallengeDup, nil, self, self.challengeLayerData.cfgInfo.Name)
	end
end

function ChallengeMaterialView:OnClickBtnSweeping()
	if self.challengeData.isOpenTime == false then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice1"))

		return
	end

	if self.currentTimes <= 0 then
		local dailyDupPOD = DailyDupModule.GetDailyDupPOD(self.challengeData.cfgID)
		local times = #self.challengeData.cfgInfo.BuyTimesCost - dailyDupPOD.buyCount

		if times > 0 then
			self:OnClickBtnBuyTimes()
		else
			NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice4"))
		end

		return
	end

	if not ChallengeModule.IsSweepAway(self.challengeLayerData.cfgID) then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice5"))

		return
	end

	if PlayerModule.GetNumAttrValue(Constant.ItemID.ENERGY) < self.challengeLayerData.cfgInfo.CostEnergy then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice8"))

		return
	end

	UIModule.Open(Constant.UIControllerName.SweepDetailConfirmUI, Constant.UILayer.UI, {
		CostEnergy = self.challengeLayerData.cfgInfo.CostEnergy,
		CallBack = function(count)
			ChallengeModule.Sweeping(self.challengeLayerData.cfgID, count)
		end
	})
end

function ChallengeMaterialView:OnClickBtnBuyTimes()
	if self.currentTimes >= self.totalTimes then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice6"))

		return
	end

	local dailyDupPod = DailyDupModule.GetDailyDupPOD(self.challengeData.cfgID)

	if dailyDupPod.buyCount >= #self.challengeData.cfgInfo.BuyTimesCost then
		NoticeModule.ShowNoticeNoCallback(Constant.Notice.BlankFloatNoticeID, ChallengeUIApi:GetString("TextNotice7"))

		return
	end

	local times = #self.challengeData.cfgInfo.BuyTimesCost - dailyDupPod.buyCount
	local moneys = self.challengeData.cfgInfo.BuyTimesCost[dailyDupPod.buyCount + 1]

	NoticeModule.ShowNoticeBuyConfirm(21048001, self.delegateAlertCall, nil, self, {
		2
	}, {
		moneys
	}, times)
end

function ChallengeMaterialView:OnAlertCall()
	DailyDupModule.BuyCount(self.challengeData.cfgID)
end

function ChallengeMaterialView:Open()
	self.currentTabIndex = nil

	self.rootUI:SetActive(true)
	self.rightDown:SetActive(true)
	self.rightUp:SetActive(true)
end

function ChallengeMaterialView:Close()
	self.rootUI:SetActive(false)
	self.rightDown:SetActive(false)
	self.rightUp:SetActive(false)
end

return ChallengeMaterialView
