-- chunkname: @IQIGame\\UI\\Activity\\FreeReward\\ActivityFreeRewardView.lua

local ActivityFreeRewardTaskItem = require("IQIGame.UI.Activity.FreeReward.ActivityFreeRewardTaskItem")
local m = {
	OperateEventID = 0,
	TaskItemMap = {}
}

function m.New(view, host, operateEventID)
	local obj = Clone(m)

	obj:Init(view, host, operateEventID)

	return obj
end

function m:Init(view, host, operateEventID)
	self.View = view
	self.OperateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	local scrollAreaList = self.ScrollArea:GetComponent("ScrollAreaList")

	function scrollAreaList.onRenderCell(cell)
		self:OnRenderCell(cell)
	end
end

function m:AddListeners()
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
end

function m:RemoveListeners()
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
end

function m:Open()
	self.View:SetActive(true)
	self:AddListeners()
	self:Refresh()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListeners()
end

function m:Refresh()
	local eventPOD = ActiveOperationEventModule.GetActiveOperationData(self.OperateEventID)

	self.CfgTreasureQuestGlobalData = CfgTreasureQuestGlobalTable[eventPOD.dataCfgId]

	local scrollAreaList = self.ScrollArea:GetComponent("ScrollAreaList")

	scrollAreaList:Refresh(#self.CfgTreasureQuestGlobalData.Rewards)
end

function m:OnRenderCell(cell)
	local item = self.TaskItemMap[cell.gameObject:GetInstanceID()]

	if item == nil then
		item = ActivityFreeRewardTaskItem.New(cell.gameObject)
		self.TaskItemMap[cell.gameObject:GetInstanceID()] = item
	end

	item:SetData(self.CfgTreasureQuestGlobalData.Rewards[cell.index + 1])
end

function m:OnClickTipBtn()
	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, self.CfgTreasureQuestGlobalData.Desc)
end

function m:OnDestroy()
	for instanceId, item in pairs(self.TaskItemMap) do
		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.CfgTreasureQuestGlobalData = nil
end

return m
