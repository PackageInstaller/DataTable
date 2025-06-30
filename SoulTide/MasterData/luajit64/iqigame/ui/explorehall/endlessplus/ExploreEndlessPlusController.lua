-- chunkname: @IQIGame\\UI\\ExploreHall\\EndlessPlus\\ExploreEndlessPlusController.lua

local EndlessPlusMazeLevelBtnController = require("IQIGame.UI.EndlessPlusMaze.EndlessPlusMazeLevelBtnController")
local EndlessPlusExBossBtnController = require("IQIGame.UI.EndlessPlusMaze.EndlessPlusExBossBtnController")
local m = {
	CHAPTER_NUM = 3,
	IsShow = false,
	LevelBtnComList = {}
}

function m.New(view, host)
	local obj = Clone(m)

	obj:Init(view, host)

	return obj
end

function m:Init(view, host)
	self.View = view
	self.Host = host

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickShopBtn()
		self:OnClickShopBtn()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnClickLevelBtn(index)
		self:OnClickLevelBtn(index)
	end

	function self.DelegateOnClickExBossBtn()
		self:OnClickExBossBtn()
	end

	for i = 1, m.CHAPTER_NUM do
		local com = EndlessPlusMazeLevelBtnController.New(self["LevelBtnCom" .. i], i, self.DelegateOnClickLevelBtn)

		self.LevelBtnComList[i] = com
	end

	self.ExBossBtnCom = EndlessPlusExBossBtnController.New(self.ExBossBtn, self.DelegateOnClickExBossBtn)

	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	self.CurrencyCell = CurrencyCell.New(self.CurrencyCellGO, cfgEndlessPlusGlobalData.ScoreItem)
end

function m:Show()
	if self.IsShow and self.View.activeSelf then
		return
	end

	self.IsShow = true

	self.View:SetActive(true)
	self:AddListeners()
	self:UpdateView()

	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	self.Host.UIController:ChangeBGM(cfgEndlessPlusGlobalData.UIBGM)
	EventDispatcher.Dispatch(EventID.CustomGuideTriggerEvent, "ExploreHallUIEndlessPlusTab")
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
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:AddListeners()
	end

	self.ShopBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickShopBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
end

function m:RemoveListeners()
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:RemoveListeners()
	end

	self.ShopBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickShopBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
end

function m:UpdateView()
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	UGUIUtil.SetTextInChildren(self.ShopBtn, cfgEndlessPlusGlobalData.MallName)
	UGUIUtil.SetText(self.SubTitleText, cfgEndlessPlusGlobalData.SubTitle)

	local cfgDailyDupData = CfgDailyDupTable[EndlessPlusMazeModule.DailyDupPOD.common.cid]
	local currentServerTime = PlayerModule.GetServerTime()
	local openDate = EndlessPlusMazeModule.DailyDupPOD.common.openDate
	local accessEndTime = openDate + cfgDailyDupData.AccessibleTime
	local activityEndTime = openDate + cfgDailyDupData.Duration
	local label, startTimeText, endTimeText = ExploreHallUIApi:GetString("EndlessPlusLimitTimeTexts", currentServerTime, openDate, accessEndTime, activityEndTime)

	UGUIUtil.SetText(self.LimitTimeLabel, label)
	UGUIUtil.SetText(self.StartTimeText, startTimeText)
	UGUIUtil.SetText(self.EndTimeText, endTimeText)

	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:Refresh()
	end

	self.ExBossBtnCom:Refresh()
end

function m:OnClickLevelBtn(index)
	local isInChallengeTime = EndlessPlusMazeModule.IsInChallengeLimitTime()

	if not isInChallengeTime then
		return
	end

	local unfinishedMazeCid = PlayerModule.GetUnfinishedMazeCid(Constant.Maze.ChapterTypeEndlessPlus)

	if unfinishedMazeCid ~= nil then
		MazeModule.SendRestore(unfinishedMazeCid)
	else
		local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]
		local levelCid = cfgEndlessPlusGlobalData.Level[index]

		UIModule.Open(Constant.UIControllerName.EndlessPlusMazeDetailUI, Constant.UILayer.UI, {
			levelCid = levelCid
		})
	end
end

function m:OnClickShopBtn()
	MallModule.OpenActivityMall(Constant.Mall_EntranceType.EndlessPlusMaze, EndlessPlusMazeModule.GetMallCidList())
end

function m:OnClickTipBtn()
	local cfgEndlessPlusGlobalData = CfgEndlessPlusGlobalTable[EndlessPlusMazeModule.GlobalCid]

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgEndlessPlusGlobalData.Desc)
end

function m:OnClickExBossBtn()
	UIModule.Open(Constant.UIControllerName.EndlessPlusExBossDetailUI, Constant.UILayer.UI)
end

function m:Dispose()
	for i = 1, #self.LevelBtnComList do
		local com = self.LevelBtnComList[i]

		com:Dispose()
	end

	self.ExBossBtnCom:Dispose()
	self.CurrencyCell:Dispose()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
