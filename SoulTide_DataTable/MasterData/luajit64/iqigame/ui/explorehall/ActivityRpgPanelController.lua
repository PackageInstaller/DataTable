-- chunkname: @IQIGame\\UI\\ExploreHall\\ActivityRpgPanelController.lua

local m = {
	IsShow = false
}
local RpgBossTicketCell = require("IQIGame.UI.ExploreHall.RpgBossTicketCell")

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickRpgMazeBtn()
		self:OnClickRpgMazeBtn()
	end

	function self.DelegateOnClickExBossBtn()
		self:OnClickExBossBtn()
	end

	function self.DelegateOnClickTaskBtn()
		self:OnClickTaskBtn()
	end

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickBossBtn()
		self:OnClickBossBtn()
	end

	function self.DelegateUpdateChallengeBoss()
		self:OnUpdateChallengeBoss()
	end

	function self.DelegateOnUpdateTask()
		self:OnUpdateTask()
	end

	function self.DelegateOnClickIntroductionBtn()
		self:OnClickIntroductionBtn()
	end

	function self.DelegateOnClickPvBtn()
		self:OnClickPvBtn()
	end

	self.TicketCell = RpgBossTicketCell.New(self.TicketGo)

	UGUIUtil.SetTextInChildren(self.RpgMazeBtn, ExploreHallUIApi:GetString("RpgRpgMazeBtnText", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.BossBtn, ExploreHallUIApi:GetString("RpgBossBtnText", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ExBossBtn, ExploreHallUIApi:GetString("RpgExBossBtnText", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.ShopBtn, ExploreHallUIApi:GetString("ShopExBossBtnText", RpgMazeModule.DailyDupPOD.common.openCount))
	UGUIUtil.SetTextInChildren(self.TaskBtn, ExploreHallUIApi:GetString("TaskTaskBtnText", RpgMazeModule.DailyDupPOD.common.openCount))

	if self.PvBtn ~= nil then
		UGUIUtil.SetTextInChildren(self.PvBtn, ExploreHallUIApi:GetString("RpgPvBtnText"))
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

	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	self.Host.UIController:ChangeBGM(cfgRPGMazeControlData.BGM)

	local openedBefore = PlayerPrefsUtil.GetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.OpenedRpgBefore .. "_" .. RpgMazeModule.DailyDupPOD.common.openCount)

	if openedBefore ~= 1 then
		self:PlayPV()
		PlayerPrefsUtil.SetInt(PlayerModule.PlayerInfo.baseInfo.pid, Constant.PlayerPrefsConst.OpenedRpgBefore .. "_" .. RpgMazeModule.DailyDupPOD.common.openCount, 1)
	end
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

function m:AddListeners()
	self.RpgMazeBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickRpgMazeBtn)
	self.ExBossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickExBossBtn)
	self.TaskBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.BossBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBossBtn)
	self.IntroductionBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickIntroductionBtn)

	if self.PvBtn then
		self.PvBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickPvBtn)
	end

	EventDispatcher.AddEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.AddEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
end

function m:RemoveListeners()
	self.RpgMazeBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickRpgMazeBtn)
	self.ExBossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickExBossBtn)
	self.TaskBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTaskBtn)
	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.BossBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBossBtn)
	self.IntroductionBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickIntroductionBtn)

	if self.PvBtn then
		self.PvBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickPvBtn)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateDailyDupEvent, self.DelegateUpdateChallengeBoss)
	EventDispatcher.RemoveEventListener(EventID.TaskUpdate, self.DelegateOnUpdateTask)
end

function m:OnUpdateChallengeBoss()
	self.ExBossBtn:SetActive(RpgMazeModule.ExBossOpen())
end

function m:UpdateView()
	self.TicketCell:Refresh()
	self.ExBossBtn:SetActive(RpgMazeModule.ExBossOpen())

	local cfgDailyDupData = CfgDailyDupTable[RpgMazeModule.DailyDupPOD.common.cid]
	local closeTime = RpgMazeModule.DailyDupPOD.common.openDate + cfgDailyDupData.AccessibleTime
	local timeText = getDateTimeMText(closeTime)

	UGUIUtil.SetText(self.MazeLimitTimeText, ExploreHallUIApi:GetString("RpgMazeLimitTimeText", timeText))
	self:UpdateRedPoint()

	if self.BgDay ~= nil then
		self.BgDay:SetActive(WeatherModule.periodOfTime <= 3)
		self.BgNight:SetActive(WeatherModule.periodOfTime > 3)
	end
end

function m:UpdateRedPoint()
	local showTaskRedPoint = RPGMissionModule.CheckRedPoint()

	self.TaskBtn.transform:Find("RedPoint").gameObject:SetActive(showTaskRedPoint)
end

function m:JumpPanel(cid)
	return
end

function m:OnClickRpgMazeBtn()
	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeRpg)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)
	else
		UIModule.Open(Constant.UIControllerName.RpgMazeEntryUI, Constant.UILayer.UI)
	end
end

function m:OnClickExBossBtn()
	UIModule.Open(Constant.UIControllerName.MazeBossChallengeDetailUI, Constant.UILayer.UI)
end

function m:OnClickTaskBtn()
	UIModule.Open(Constant.UIControllerName.RPGMissionUI, Constant.UILayer.UI)
end

function m:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.RpgMaze, RpgMazeModule.GetMallCidList())
end

function m:OnClickBossBtn()
	UIModule.Open(Constant.UIControllerName.MazeBossChallengeEntryUI, Constant.UILayer.UI)
end

function m:OnClickIntroductionBtn()
	UIModule.Open(Constant.UIControllerName.RpgIntroduceTipsUI, Constant.UILayer.UI)
end

function m:OnUpdateTask()
	self:UpdateRedPoint()
end

function m:OnClickPvBtn()
	self:PlayPV()
end

function m:PlayPV()
	local cfgRPGMazeControlData = CfgRPGMazeControlTable[RpgMazeModule.DailyDupPOD.rpgMazePOD.controlCid]

	if cfgRPGMazeControlData.PV == 0 then
		return
	end

	self.VideoBlock:SetActive(true)
	UIModule.Open(Constant.UIControllerName.VideoPlayerUI, Constant.UILayer.Mid, {
		videoCid = cfgRPGMazeControlData.PV,
		onComplete = function()
			self.VideoBlock:SetActive(false)
		end
	})
end

function m:Dispose()
	self.TicketCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
end

return m
