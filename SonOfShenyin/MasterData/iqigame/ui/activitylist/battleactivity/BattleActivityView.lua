-- chunkname: @IQIGame\\UI\\ActivityList\\BattleActivity\\BattleActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local m = Clone(ActivityViewBase)

function m:__Init(view)
	self:InitMembers()
	self:InitDelegate()
	self:InitComponent()
end

function m:InitMembers()
	self.rewardItemArray = {}
end

function m:InitComponent()
	local item = ItemCell.New(self.rewardItem)

	table.insert(self.rewardItemArray, item)
end

function m:InitDelegate()
	function self.delegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end

	function self.onNotifyDupEvent()
		self:Refresh()
	end
end

function m:__AddListeners()
	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.delegateOnClickDetailBtn)
	EventDispatcher.AddEventListener(EventID.BattleActivityNotifyDupEvent, self.onNotifyDupEvent)
end

function m:__RemoveListeners()
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickDetailBtn)
	EventDispatcher.RemoveEventListener(EventID.BattleActivityNotifyDupEvent, self.onNotifyDupEvent)
end

function m:OnClickDetailBtn()
	UIModule.Open(Constant.UIControllerName.BattleActivityDungeonUI, Constant.UILayer.UI)
end

function m:__SetData(activityListCfg)
	RedDotModule.CheckRedDot_BattleActivity()

	self.cfgActivityList = activityListCfg

	self:Refresh()
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.View, true)
end

function m:__Dispose()
	if self.timer then
		self.timer:Stop()

		self.timer = nil
	end
end

function m:__OnCover()
	return
end

function m:__OnReveal()
	return
end

function m:Refresh()
	LuaUtility.SetText(self.textName, self.cfgActivityList.Name)
	LuaUtility.SetText(self.textDesc, self.cfgActivityList.Desc)

	local rewardArray = self.cfgActivityList.Reward
	local len = #rewardArray
	local index = 1

	for i = 1, len do
		local cell = self:_GetCell(i)

		cell:SetItemByCid(rewardArray[i])
		cell:Show()

		index = index + 1
	end

	for i = index, #self.rewardItemArray do
		self.rewardItemArray[i]:Hide()
	end

	local activityPod = ActivityModule.GetActivityPodByID(self.cfgActivityList.ActivityID[1])

	if activityPod then
		self.endTime = tonumber(activityPod.closeDateTime) / 1000

		self:RefreshCountdown()
	end

	self:RefreshDot()
end

function m:RefreshDot()
	LuaUtility.SetGameObjectShow(self.RedDot_DetailBtn, RedDotModule.GetRedDotCntByRedDotID(Constant.E_RedDotPath.BattleActivity) >= 1)
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

	LuaUtility.SetText(self.textTime, DateStandardFormation(surplusTime))
end

function m:_GetCell(index)
	if not self.rewardItemArray[index] then
		local o = GameObject.Instantiate(self.rewardItem, self.ItemGrid.transform)

		self.rewardItemArray[index] = ItemCell.New(o)
	end

	return self.rewardItemArray[index]
end

return m
