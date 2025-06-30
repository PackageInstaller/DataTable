-- chunkname: @IQIGame\\UI\\RefundsGiftPack\\RefundsGiftPackRenderCell.lua

local m = {
	rewardData = {},
	rewardCellPool = {}
}
local RefundsGiftPackRewardCell = require("IQIGame.UI.RefundsGiftPack.RefundsGiftPackRewardCell")

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.rewardList = self.RewardArea:GetComponent("ScrollAreaList")

	function self.rewardList.onRenderCell(grid)
		self:OnRenderReward(grid)
	end

	self.timer = Timer.New(function()
		self:ShowRefundsGiftCD()
	end, 1, -1)

	self.timer:Start()
	self:AddListener()
end

function m:AddListener()
	return
end

function m:RemoveListener()
	return
end

function m:SetData(cid)
	self.cfgRefundsGiftPackData = CfgRefundsGiftPackTable[cid]

	self:UpdateView()
end

function m:UpdateView()
	if self.cfgRefundsGiftPackData then
		local count = RefundsGiftPackModule.GetRewardCount(self.cfgRefundsGiftPackData.Id)

		self.rewardData = RefundsGiftPackModule.GetShowRewards(self.cfgRefundsGiftPackData.Id)

		UGUIUtil.SetText(self.TextName, self.cfgRefundsGiftPackData.Name)
		UGUIUtil.SetText(self.TextCount, RefundsGiftPackUIApi:GetString("TextCount", count, #self.cfgRefundsGiftPackData.RefundsGiftPackRewards))
		self.rewardList:Refresh(#self.rewardData)
		self:ShowRefundsGiftCD()
	end
end

function m:OnRenderReward(cell)
	local luaIndex = cell.index + 1
	local data = self.rewardData[luaIndex]
	local instanceID = cell.gameObject:GetInstanceID()
	local itemCell = self.rewardCellPool[instanceID]

	if itemCell == nil then
		itemCell = RefundsGiftPackRewardCell.New(cell.gameObject)
		self.rewardCellPool[instanceID] = itemCell
	end

	itemCell:SetData(data.itemCid, data.showNum)
end

function m:ShowRefundsGiftCD()
	if self.cfgRefundsGiftPackData then
		local nextIndex = RefundsGiftPackModule.GetNextRewardIndex(self.cfgRefundsGiftPackData.Id)
		local cfgTime = self.cfgRefundsGiftPackData.Time[nextIndex]
		local nowTime = PlayerModule.GetServerTime()
		local buyTime = 0

		if PlayerModule.PlayerInfo.refundsGiftPacks then
			buyTime = PlayerModule.PlayerInfo.refundsGiftPacks[self.cfgRefundsGiftPackData.Id]
		end

		self.TextTime:SetActive(buyTime ~= nil)

		if buyTime ~= nil then
			local cd = cfgTime - (nowTime - buyTime)

			UGUIUtil.SetText(self.TextTime, RefundsGiftPackUIApi:GetString("TextTime", cd))
		end
	end
end

function m:Dispose()
	self:RemoveListener()

	for i, v in pairs(self.rewardCellPool) do
		v:Dispose()
	end

	self.timer:Stop()

	self.timer = nil

	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
