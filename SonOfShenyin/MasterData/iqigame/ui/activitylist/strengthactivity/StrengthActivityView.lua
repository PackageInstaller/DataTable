-- chunkname: @IQIGame\\UI\\ActivityList\\StrengthActivity\\StrengthActivityView.lua

local ActivityViewBase = require("IQIGame/UI/ActivityList/ActivityViewBase")
local strengthSupplyInfoItemView = require("IQIGame.UI.ActivityList.StrengthActivity.StrengthSupplyInfoItemView")
local m = Clone(ActivityViewBase)

function m:__Init()
	function self.DelegateOnActivityUpdateEvent()
		self:OnActivityUpdateEvent()
	end

	self.supplyItems = {}

	table.insert(self.supplyItems, strengthSupplyInfoItemView.New(self.supplyItem1))
	table.insert(self.supplyItems, strengthSupplyInfoItemView.New(self.supplyItem2))
end

function m:__AddListeners()
	EventDispatcher.AddEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
end

function m:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.ActivityUpdateEvent, self.DelegateOnActivityUpdateEvent)
end

function m:__SetData()
	self.activityPods = ActivityModule.GetActivityPodByID(Constant.ActivityID.StrengthActivity)

	self:RefreshStrengthSupplyDetail()
end

function m:RefreshStrengthSupplyDetail()
	local activityCfg = CfgActivityTable[self.activityPods.cid]
	local index = 1

	for i = 1, #activityCfg.ExtraParam, 3 do
		local item = self.supplyItems[index]

		item:Show()
		item:SetData(self.activityPods.cid, self.activityPods.supplyPOD.map[index - 1], index, activityCfg.ExtraParam[i], activityCfg.ExtraParam[i + 1], activityCfg.ExtraParam[i + 2])

		index = index + 1
	end
end

function m:__Dispose()
	for i = 1, #self.supplyItems do
		self.supplyItems[i]:Dispose()
	end
end

function m:OnActivityUpdateEvent()
	self:__SetData()
end

return m
