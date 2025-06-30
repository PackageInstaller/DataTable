-- chunkname: @IQIGame\\UI\\Activity\\Food\\ActivityFoodView.lua

local m = {
	NpcActionGroupId = 0
}
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")
local ActivityFoodItem = require("IQIGame.UI.Activity.Food.ActivityFoodItem")

function m.GetPreloadAssetPaths()
	local npcGroupId

	for id, cfgDailySupportData in pairsCfg(CfgDailySupplyTable) do
		npcGroupId = cfgDailySupportData.NPC

		break
	end

	local cfgNpcActionData = NPCActionModule.GetAction(npcGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	return {
		UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)
	}
end

function m.New(view, uiController)
	local obj = Clone(m)

	obj:Init(view, uiController)

	return obj
end

function m:Init(view, uiController)
	self.View = view
	self.UIController = uiController

	LuaCodeInterface.BindOutlet(self.View, self)

	self.NpcView = NPCActionView.New(self.NpcActionGo)
	self.SupplyItems = {}

	for i = 1, 2 do
		local go = UnityEngine.Object.Instantiate(self.SupportItemPrefab)

		go.transform:SetParent(self.SupportItemGrid.transform, false)

		local item = ActivityFoodItem.New(go, i)

		table.insert(self.SupplyItems, item)
	end

	UGUIUtil.SetText(self.TitleText, ActivityUIApi:GetString("FoodTitleText"))
	UGUIUtil.SetText(self.SubTitleText, ActivityUIApi:GetString("FoodSubTitleText"))
	UGUIUtil.SetText(self.TipText, ActivityUIApi:GetString("FoodTipText"))
end

function m:Open()
	self.View:SetActive(true)
	self:RefreshData()
	self:RefreshItems()
	self:RefreshNpc()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:RefreshData()
	self.CfgDataList = {}

	for id, cfgDailySupplyData in pairsCfg(CfgDailySupplyTable) do
		self.NpcActionGroupId = cfgDailySupplyData.NPC

		table.insert(self.CfgDataList, cfgDailySupplyData)
	end

	table.sort(self.CfgDataList, function(cfgData1, cfgData2)
		return cfgData1.Id < cfgData2.Id
	end)
end

function m:RefreshItems()
	for i = 1, #self.CfgDataList do
		local cfgDailySupplyData = self.CfgDataList[i]
		local item = self.SupplyItems[i]

		item:SetData(cfgDailySupplyData)
	end
end

function m:RefreshNpc()
	local cfgNpcActionData = NPCActionModule.GetAction(self.NpcActionGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local pos = cfgNpcActionData.Position
	local scale = cfgNpcActionData.Scale
	local talkOffset = cfgNpcActionData.TalkPosition
	local goNpc = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)))

	self.NpcView:Refresh(cfgNpcActionData, goNpc, cfgNpcActionData.NPC, self.NpcPoint.transform, pos, scale, talkOffset)
end

function m:OnHide()
	self.NpcView:OnHide()
end

function m:Update(elapseSeconds, realElapseSeconds)
	self.NpcView:Update(elapseSeconds, realElapseSeconds)

	for i = 1, #self.SupplyItems do
		local item = self.SupplyItems[i]

		item:Update(elapseSeconds, realElapseSeconds)
	end
end

function m:OnDestroy()
	self.NpcView:OnDestroy()

	for i = 1, #self.SupplyItems do
		local item = self.SupplyItems[i]

		item:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.UIController = nil
end

return m
