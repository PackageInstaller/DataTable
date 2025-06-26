-- chunkname: @IQIGame\\UI\\ActivityList\\DiceGameActivity\\DiceGameActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local DiceItemClass = require("IQIGame/UI/ActivityList/DiceGameActivity/DiceGameDiceItem")
local RewardItemClass = require("IQIGame/UI/ActivityList/DiceGameActivity/DiceGameActivityView_rewardItem")
local m = Clone(ActivityViewBase)
local rollAnimationName = "UI_MazeJudge_Dice_Throw"

function m:__Init(view)
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function m:InitMembers()
	self.diceItemArray = {}
	self.rewardScrollCellList = {}
end

function m:InitDelegate()
	function self.delegateOnClickButtonRoll()
		self:OnClickButtonRoll()
	end

	function self.onReceiveRollRequestSuccessEvent(randSum, shows)
		self:onReceiveRollRequestSuccess(randSum, shows)
	end

	function self.delegateOnClickButtonGetCount()
		self:OnClickButtonGetCount()
	end

	function self.onRefreshFromSeverEvent()
		self:Refresh()
	end

	function self.redDotRefreshEvent()
		self:RefreshRedDot()
	end
end

function m:__AddListeners()
	self.buttonRoll:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonRoll)
	self.buttonGetCount:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonGetCount)
	EventDispatcher.AddEventListener(EventID.NetRichMamResultEvent, self.onReceiveRollRequestSuccessEvent)
	EventDispatcher.AddEventListener(EventID.DiceGameRefreshEvent, self.onRefreshFromSeverEvent)
	EventDispatcher.AddEventListener(EventID.DiceGameRedDotEvent, self.redDotRefreshEvent)
end

function m:__RemoveListeners()
	self.buttonRoll:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonRoll)
	self.buttonGetCount:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonGetCount)
	EventDispatcher.RemoveEventListener(EventID.NetRichMamResultEvent, self.onReceiveRollRequestSuccessEvent)
	EventDispatcher.RemoveEventListener(EventID.DiceGameRefreshEvent, self.onRefreshFromSeverEvent)
	EventDispatcher.RemoveEventListener(EventID.DiceGameRedDotEvent, self.redDotRefreshEvent)
end

function m:OnClickButtonGetCount()
	UIModule.Open(Constant.UIControllerName.DiceGameTaskUI, Constant.UILayer.UI)
end

function m:onReceiveRollRequestSuccess(randSum, shows)
	local len = #self.diceItemArray

	for i = 1, len do
		local item = self.diceItemArray[i]

		item:Refresh(randSum[i])
	end

	LuaUtility.PlayAnimation(self.DiceArea, rollAnimationName, nil, function()
		NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, shows, Constant.GetPanelType.Normal)

		self.isAnimation = false
	end)

	self.isAnimation = true
end

function m:OnClickButtonRoll()
	if self.isAnimation then
		return
	end

	local data = PlayerModule.GetRichManPOD()

	if not data then
		return
	end

	if data.richTime <= 0 then
		return
	end

	net_richMan.richMan(self.activityListCfg.ActivityID[1])
end

function m:InitComponent()
	self.rewardDetailScroll = self.rewardDetailScroll:GetComponent("OptimizedScrollRect")

	self.rewardDetailScroll:NormalInit(function(OptimizedParams, OptimizedViewsHolder)
		self:UpdateRewardDetailScroll(OptimizedParams, OptimizedViewsHolder)
	end)

	for i = 1, 5 do
		local diceNode = self.DiceArea.transform:Find("Dice" .. i)
		local diceGo = diceNode:Find("Dice(Clone)").gameObject
		local item = DiceItemClass.New(diceGo, self)

		table.insert(self.diceItemArray, item)
	end

	LuaUtility.SetText(self.textTip, CfgUtil.GetCfgTipsTextWithID(9000010))
end

function m:UpdateRewardDetailScroll(OptimizedParams, OptimizedViewsHolder)
	local viewGameObject = OptimizedViewsHolder.root.gameObject
	local instanceID = OptimizedViewsHolder.instanceID
	local index = OptimizedViewsHolder.ItemIndex
	local data = self.rewardScrollDataArray[index + 1]

	if not self.rewardScrollCellList[instanceID] then
		self.rewardScrollCellList[instanceID] = RewardItemClass.New(viewGameObject, self)
	end

	self.rewardScrollCellList[instanceID]:Refresh(data)
end

function m:Refresh()
	local data = PlayerModule.GetRichManPOD()

	if not data then
		return
	end

	local num1 = string.sub(data.richTime, 1, 1)
	local num2 = string.sub(data.richTime, 2, 2)

	if data.richTime < 10 then
		LuaUtility.SetText(self.Num1, 0)
		LuaUtility.SetText(self.Num2, data.richTime)
	else
		LuaUtility.SetText(self.Num1, num1)
		LuaUtility.SetText(self.Num2, num2)
	end

	local cfgActivity = CfgUtil.GetCfgActivityDataWithID(self.activityListCfg.ActivityID[1])
	local len = #cfgActivity.ExtraParam

	self.rewardScrollDataArray = {}

	local data = {}

	data.left = 0
	data.right = cfgActivity.ExtraParam[1]
	data.drop = cfgActivity.ExtraParam[2]

	table.insert(self.rewardScrollDataArray, data)

	for i = 1, len, 2 do
		local data = {}

		data.left = cfgActivity.ExtraParam[i]

		if len >= i + 3 then
			data.right = cfgActivity.ExtraParam[i + 2]
			data.drop = cfgActivity.ExtraParam[i + 3]

			table.insert(self.rewardScrollDataArray, data)
		end
	end

	self.rewardDetailScroll:RefreshByItemCount(#self.rewardScrollDataArray)

	local activityPod = ActivityModule.GetActivityPodByID(cfgActivity.Id)

	if activityPod then
		self.endTime = tonumber(activityPod.closeDateTime) / 1000

		self:RefreshCountdown()
	end

	self.isAnimation = false

	self:RefreshRedDot()
end

function m:RefreshCountdown()
	self:UpdateSurplusTime()

	if self.timer == nil then
		self.timer = Timer.New(function()
			self:UpdateSurplusTime()
		end, 1, -1)

		self.timer:Start()
	end
end

function m:UpdateSurplusTime()
	local surplusTime = math.floor(self.endTime - tonumber(PlayerModule.GetServerTime()))

	surplusTime = math.max(0, surplusTime)

	UGUIUtil.SetText(self.textTime, DateStandardFormation(surplusTime))
end

function m:StopTimer()
	if self.timer ~= nil then
		self.timer:Stop()
	end

	self.timer = nil
end

function m:RefreshRedDot()
	LuaUtility.SetGameObjectShow(self.redDot_GetCount, RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.DiceGame) > 0)

	local diceGameData = PlayerModule.GetRichManPOD()

	LuaUtility.SetGameObjectShow(self.redDot_Roll, diceGameData and diceGameData.richTime > 0)
end

function m:__SetData(activityListCfg)
	self.activityListCfg = activityListCfg

	self:Refresh()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)

	local uiCamera = GameEntry.UICamera

	uiCamera.orthographic = true

	LuaUtility.SetGameObjectShow(self.DiceArea, true)
end

function m:__Dispose()
	self:StopTimer()

	for _, v in pairs(self.diceItemArray) do
		v:OnDestroy()
	end

	self.diceItemArray = {}

	LuaUtility.ClearAnimationEvent(self.DiceArea, rollAnimationName)

	local uiCamera = GameEntry.UICamera

	uiCamera.orthographic = false
end

function m:__OnCover()
	LuaUtility.SetGameObjectShow(self.DiceArea, false)
end

function m:__OnReveal()
	LuaUtility.SetGameObjectShow(self.DiceArea, true)
end

return m
