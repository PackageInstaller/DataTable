-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameController.lua

local m = {
	lastChangeTime = 0,
	timeSce = 0,
	IsShow = false,
	moneyCellPool = {}
}
local PlaceGameNpcTalkView = require("IQIGame.UI.ExploreHall.PlaceGame.PlaceGameNpcTalkView")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	self.placeGameNpcTalk = PlaceGameNpcTalkView.New(self.Npc)

	self.placeGameNpcTalk:Close()

	self.cfgControlData = CfgPlaceGameControlTable[PlaceGameModule.GlobalCid]

	function self.DelegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.DelegateIntroductionBtn()
		self:OnIntroductionBtn()
	end

	function self.DelegateShopBtn()
		self:OnShopBtn()
	end

	function self.DelegateEventBtn()
		self:OnEventBtn()
	end

	function self.DelegateGetRewardBtn()
		self:OnGetRewardBtn()
	end

	function self.DelegateChallengeBtn()
		self:OnChallengeBtn()
	end

	function self.DelegateRankBtn()
		self:OnRankBtn()
	end

	function self.DelegateSoulBtn()
		self:OnSoulBtn()
	end

	function self.DelegateFormationBtn()
		self:OnFormationBtn()
	end

	function self.DelegateBagBtn()
		self:OnBagBtn()
	end

	function self.DelegateRecruitBtn()
		self:OnRecruitBtn()
	end

	function self.DelegateUpdateTower()
		self:OnUpdateTower()
	end

	function self.DelegateUpdateEvent()
		self:OnUpdateEvent()
	end

	function self.DelegateUpdateAward()
		self:OnUpdateAward()
	end

	function self.DelegateBtnRankReward()
		self:OnBtnRankReward()
	end

	function self.DelegateMonsterFightEnd()
		self:OnMonsterFightEnd()
	end

	self.TicketGo:SetActive(false)

	for i = 1, #self.cfgControlData.MoneyId do
		local moneyID = self.cfgControlData.MoneyId[i]
		local moneyObj = UnityEngine.Object.Instantiate(self.TicketGo)

		moneyObj:SetActive(true)
		moneyObj.transform:SetParent(self.TicketNode.transform, false)

		local moneyCell = CurrencyCell.New(moneyObj, moneyID)

		table.insert(self.moneyCellPool, moneyCell)
	end

	self.roleAnimation = self.Role:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	self.monsterAnimation = self.Monster:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	self.monsterSpineRenderers = self.Monster:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	self.EffectBattle:SetActive(false)
end

function m:OnUpdate(elapseSeconds, realElapseSeconds)
	local nowTime = PlayerModule.GetServerTime()

	if nowTime - self.lastChangeTime < 1 then
		return
	end

	self.lastChangeTime = nowTime

	local date = getDateTimeTable(nowTime)

	self.timeSce = date.sec

	self:PlayEffectBySec()
end

function m:OnReveal()
	self:RefreshEventRed()
end

function m:AddListeners()
	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateShopBtn)
	self.EventBtn:GetComponent("Button").onClick:AddListener(self.DelegateEventBtn)
	self.GetRewardBtn:GetComponent("Button").onClick:AddListener(self.DelegateGetRewardBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:AddListener(self.DelegateChallengeBtn)
	self.RankBtn:GetComponent("Button").onClick:AddListener(self.DelegateRankBtn)
	self.SoulBtn:GetComponent("Button").onClick:AddListener(self.DelegateSoulBtn)
	self.FormationBtn:GetComponent("Button").onClick:AddListener(self.DelegateFormationBtn)
	self.BagBtn:GetComponent("Button").onClick:AddListener(self.DelegateBagBtn)
	self.RecruitBtn:GetComponent("Button").onClick:AddListener(self.DelegateRecruitBtn)
	self.BtnRankReward:GetComponent("Button").onClick:AddListener(self.DelegateBtnRankReward)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.AddEventListener(EventID.PlaceGameUpdateTower, self.DelegateUpdateTower)
	EventDispatcher.AddEventListener(EventID.PlaceGameUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.AddEventListener(EventID.PlaceGameUpdateAward, self.DelegateUpdateAward)
end

function m:RemoveListeners()
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateIntroductionBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateShopBtn)
	self.EventBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateEventBtn)
	self.GetRewardBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateGetRewardBtn)
	self.ChallengeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateChallengeBtn)
	self.RankBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRankBtn)
	self.SoulBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateSoulBtn)
	self.FormationBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateFormationBtn)
	self.BagBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateBagBtn)
	self.RecruitBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateRecruitBtn)
	self.BtnRankReward:GetComponent("Button").onClick:RemoveListener(self.DelegateBtnRankReward)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateDailyDupEvent)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameUpdateTower, self.DelegateUpdateTower)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameUpdateEvent, self.DelegateUpdateEvent)
	EventDispatcher.RemoveEventListener(EventID.PlaceGameUpdateAward, self.DelegateUpdateAward)
end

function m:OnUpdateDailyDupEvent()
	if not PlaceGameModule.IsShow() then
		UIModule.Close(Constant.UIControllerName.ExploreHallUI)
		UIModule.Close(Constant.UIControllerName.PlaceGameChallengeDetailUI)

		return
	end

	if self.View then
		self:UpdateView()
	end
end

function m:OnUpdateTower()
	local placeGameTowerData = PlaceGameModule.GetCurrentTowerData()

	if placeGameTowerData then
		UGUIUtil.SetText(self.TextLevel, placeGameTowerData.Name)
		UGUIUtil.SetText(self.TextFloor, placeGameTowerData.Name)
		UGUIUtil.SetText(self.TextOutPut1, ExploreHallUIApi:GetString("PlaceGameOutPut", CfgItemTable[placeGameTowerData.Reward[1]].Name, placeGameTowerData.Reward[2]))
		UGUIUtil.SetText(self.TextOutPut2, ExploreHallUIApi:GetString("PlaceGameOutPut", CfgItemTable[placeGameTowerData.Reward[3]].Name, placeGameTowerData.Reward[4]))
	end
end

function m:OnUpdateEvent()
	self:RefreshEventRed()
end

function m:HideOrShowMonsterRender(top)
	for j = 0, self.monsterSpineRenderers.Length - 1 do
		local renderer = self.monsterSpineRenderers[j]

		renderer.enabled = top
	end
end

function m:PlayRoleDefaultState()
	self.EffectBattle:SetActive(false)

	if self.roleAnimation ~= nil and self.roleAnimation.AnimationName ~= "run" then
		self.roleAnimation.state:SetEmptyAnimation(0, 0)
		self.roleAnimation.state:SetAnimation(0, "run", true)
	end
end

function m:PlayMonsterDefaultState()
	if self.monsterAnimation ~= nil and self.monsterAnimation.AnimationName ~= "idle" then
		self.monsterAnimation.state:SetEmptyAnimation(0, 0)
		self.monsterAnimation.state:SetAnimation(0, "idle", true)
	end

	self:HideOrShowMonsterRender(self.Host.UIController:GetComponent("Canvas").enabled)
end

function m:PlayMonsterDie()
	if self.monsterAnimation ~= nil then
		self.monsterAnimation.state:SetEmptyAnimation(0, 0)
		self.monsterAnimation.state:SetAnimation(0, "die", false)
	end
end

function m:PlayEffectBySec()
	self:PlayAddNumEffect(false)

	if self.timeSce < 57 then
		self:PlayRoleDefaultState()
		self.Monster:SetActive(self.timeSce >= 56)

		if self.timeSce >= 56 then
			self:PlayMonsterDefaultState()
		end

		if self.timeSce == 25 then
			self.placeGameNpcTalk:Open()
		end
	elseif self.timeSce == 57 then
		self:PlayAttackEffect()
	elseif self.timeSce == 59 then
		self:PlayMonsterDie()
		self:PlayAddNumEffect(self.Host.UIController:GetComponent("Canvas").enabled)
	end
end

function m:PlayAttackEffect()
	if self.roleAnimation ~= nil then
		self.roleAnimation.state:SetEmptyAnimation(0, 0)
		self.roleAnimation.state:SetAnimation(0, "battle", true)
		self.EffectBattle:SetActive(true)
	end

	if self.monsterAnimation ~= nil then
		self.monsterAnimation.state:SetEmptyAnimation(0, 0)
		self.monsterAnimation.state:SetAnimation(0, "fight", false)

		self.monsterAnimation.state.Complete = self.monsterAnimation.state.Complete + self.DelegateMonsterFightEnd
	end
end

function m:OnMonsterFightEnd()
	self.monsterAnimation.state.Complete = self.monsterAnimation.state.Complete - self.DelegateMonsterFightEnd
	self.monsterAnimation.AnimationName = nil

	self.monsterAnimation.state:SetEmptyAnimation(0, 0)
	self.monsterAnimation.state:SetAnimation(0, "idle2", true)
end

function m:PlayAddNumEffect(isShow)
	self.AddNumEffect:SetActive(isShow)
end

function m:UpdateView()
	local cfgDailyDupData = CfgDailyDupTable[PlaceGameModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = PlaceGameModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local startTimeText, accessEndText, endTimeText = ExploreHallUIApi:GetString("PlaceGameTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.ChallengeStartTime, startTimeText)
	UGUIUtil.SetText(self.ChallengeEndTimeText, endTimeText)
	UGUIUtil.SetText(self.ShopStartTimeText, startTimeText)
	UGUIUtil.SetText(self.ShopEndTimeText, accessEndText)
	self:OnUpdateTower()
	self:RefreshAward()
	self:RefreshEventRed()
end

function m:OnUpdateAward()
	self:RefreshAward()
	self:RefreshEventRed()
end

function m:RefreshAward()
	UGUIUtil.SetText(self.TextRewardNum, ExploreHallUIApi:GetString("PlaceGameTextRewardNum", PlaceGameModule.DailyDupPOD.placeGamePOD.award, self.cfgControlData.MaxTimes))
end

function m:RefreshEventRed()
	local isRed = PlaceGameModule.CheckPlaceGameEventRed()

	self.EventRedPoint:SetActive(isRed)

	local isGerReward = PlaceGameModule:PlaceGameIsGerReward()
	local canvasEnabled = self.Host.UIController:GetComponent("Canvas").enabled

	self.GetRewardRed:SetActive(isGerReward and canvasEnabled)
	self.Host:UpdateRedPoint()
end

function m:OnRecruitBtn()
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerRecruitUI, Constant.UILayer.UI)
end

function m:OnBagBtn()
	UIModule.Open(Constant.UIControllerName.PlaceGameBagUI, Constant.UILayer.UI)
end

function m:OnFormationBtn()
	if not PlaceGameModule.IsShow() then
		return
	end

	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerFormationUI, Constant.UILayer.UI)
end

function m:OnSoulBtn()
	UIModule.Open(Constant.UIControllerName.PlaceGamePlayerUpdateUI, Constant.UILayer.UI)
end

function m:OnRankBtn()
	UIModule.Open(Constant.UIControllerName.PlaceGameRankUI, Constant.UILayer.UI)
end

function m:OnChallengeBtn()
	if not PlaceGameModule.IsShow() then
		return
	end

	UIModule.Open(Constant.UIControllerName.PlaceGameChallengeDetailUI, Constant.UILayer.UI)
end

function m:OnGetRewardBtn()
	PlaceGameModule.OpenTheBox()
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.PlaceGameShop)
end

function m:OnEventBtn()
	UIModule.Open(Constant.UIControllerName.PlaceGameEventUI, Constant.UILayer.UI)
end

function m:OnIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgControlData.Desc)
end

function m:OnBtnRankReward()
	CenterRankModule.GetRanking(Constant.RankingType.PlaceGameRank, 50, false, function(rankId, isOpen, rankings, lastRankings, myRanking, myScore, customData, rankType)
		UIModule.Open(Constant.UIControllerName.PlaceGameRankRewardUI, Constant.UILayer.UI, {
			myRanking,
			rankType
		})
	end)
end

function m:ShowHostMoneyCell(top)
	for i = 1, #self.Host.CurrencyControllers do
		self.Host.CurrencyControllers[i].ViewGo:SetActive(top)
	end

	self.Host.EnergyCell.ViewGo:SetActive(top)
end

function m:RefreshBG()
	if self.randomIndex == nil then
		self.randomIndex = math.random(1, 4)
	else
		self.randomIndex = self.randomIndex + 1
		self.randomIndex = self.randomIndex > 4 and 1 or self.randomIndex
	end

	for i = 1, 4 do
		self["BgNode" .. i]:SetActive(i == self.randomIndex)
	end
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()
	self.Host.UIController:ChangeBGM(self.cfgControlData.UIBGM)
	PlaceGameModule.CheckResumeDialog()
	self:ShowHostMoneyCell(false)
	self:RefreshBG()
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
	self.Host.UIController:ChangeBGM(7)
	self:ShowHostMoneyCell(true)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListeners()
	self.placeGameNpcTalk:Dispose()

	for i, v in pairs(self.moneyCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
