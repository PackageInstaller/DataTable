-- chunkname: @IQIGame\\UI\\ExploreHall\\MonsterAcademy\\MonsterAcademyController.lua

local m = {}
local MonsterAcademyTicketCell = require("IQIGame.UI.ExploreHall.MonsterAcademy.MonsterAcademyTicketCell")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetTextInChildren(self.NewGameBtn, ExploreHallUIApi:GetString("MonsterAcademyNewGameBtn"))
	UGUIUtil.SetTextInChildren(self.TaskBtn, ExploreHallUIApi:GetString("MonsterAcademyTaskBtn"))
	UGUIUtil.SetTextInChildren(self.ShopBtn, ExploreHallUIApi:GetString("MonsterAcademyShopBtn"))
	UGUIUtil.SetTextInChildren(self.OldMemoriesBtn, ExploreHallUIApi:GetString("MonsterAcademyOldMemoriesBtn"))
	UGUIUtil.SetTextInChildren(self.IntroductionBtn, ExploreHallUIApi:GetString("MonsterAcademyIntroductionBtn"))

	function self.delegateUpdateDailyDupEvent()
		self:OnUpdateDailyDupEvent()
	end

	function self.delegateNewGameBtn()
		self:OnNewGameBtn()
	end

	function self.delegateOldMemoriesBtn()
		self:OnOldMemoriesBtn()
	end

	function self.delegateTaskBtn()
		self:OnTaskBtn()
	end

	function self.delegateShopBtn()
		self:OnShopBtn()
	end

	function self.delegateIntroductionBtn()
		self:OnIntroductionBtn()
	end

	self.cfgGalGameMonsterGlobalData = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]
	self.TicketCell = MonsterAcademyTicketCell.New(self.TicketGo)
end

function m:AddListeners()
	self.NewGameBtn:GetComponent("Button").onClick:AddListener(self.delegateNewGameBtn)
	self.OldMemoriesBtn:GetComponent("Button").onClick:AddListener(self.delegateOldMemoriesBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.delegateTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.delegateShopBtn)
	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.delegateIntroductionBtn)
	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDupEvent)
end

function m:RemoveListeners()
	self.NewGameBtn:GetComponent("Button").onClick:RemoveListener(self.delegateNewGameBtn)
	self.OldMemoriesBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOldMemoriesBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.delegateTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.delegateShopBtn)
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.delegateIntroductionBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.delegateUpdateDailyDupEvent)
end

function m:OnUpdateDailyDupEvent()
	if MonsterAcademyModule.IsShow() then
		self:UpdateView()
	end
end

function m:UpdateView()
	local cfgDailyDupData = CfgDailyDupTable[MonsterAcademyModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = MonsterAcademyModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local label, startTimeText, endTimeText = ExploreHallUIApi:GetString("MonsterAcademyLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeLabel, label)
	UGUIUtil.SetText(self.StartTimeText, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)
	self.TicketCell:Refresh()
	self:RefreshTaskRedPoint()
end

function m:RefreshTaskRedPoint()
	self.TaskRedPoint:SetActive(false)
end

function m:OnNewGameBtn()
	if not MonsterAcademyModule.IsShow() then
		return
	end

	if MonsterAcademyModule.DailyDupPOD.common.status == 2 then
		NoticeModule.ShowNoticeNoCallback(21045030)

		return
	end

	local haveSaveDate = false

	if MonsterAcademyModule.DailyDupPOD then
		for i, v in pairs(MonsterAcademyModule.DailyDupPOD.miniGalGameDataPOD.saveList) do
			if v.saveTime > 0 then
				haveSaveDate = true

				break
			end
		end
	end

	if haveSaveDate then
		NoticeModule.ShowNotice(21045060, function()
			MonsterAcademyModule.StartNewGame()
		end, nil, self)
	else
		MonsterAcademyModule.StartNewGame()
	end
end

function m:OnOldMemoriesBtn()
	if not MonsterAcademyModule.IsShow() then
		return
	end

	if MonsterAcademyModule.DailyDupPOD.common.status == 2 then
		NoticeModule.ShowNoticeNoCallback(21045030)

		return
	end

	UIModule.Open(Constant.UIControllerName.MonsterAcademySLDataUI, Constant.UILayer.UI, {
		OpenType = 1
	})
end

function m:OnTaskBtn()
	UIModule.Open(Constant.UIControllerName.MonsterAcademyAchievementUI, Constant.UILayer.UI)
end

function m:OnShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.MonsterAcademyShop)
end

function m:OnIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.cfgGalGameMonsterGlobalData.Desc)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	MonsterAcademyModule.RefreshAreaData()

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()

	local cfgGlobalData = CfgGalgameMonsterActivityGlobalTable[MonsterAcademyModule.GlobalCid]

	self.Host.UIController:ChangeBGM(cfgGlobalData.UIBGM)
end

function m:Hide()
	if not self.IsShow and not self.View.activeSelf then
		return
	end

	self.IsShow = false

	self.View:SetActive(false)
	self:RemoveListeners()
	self.Host.UIController:ChangeBGM(7)
end

function m:Dispose()
	self.TicketCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
