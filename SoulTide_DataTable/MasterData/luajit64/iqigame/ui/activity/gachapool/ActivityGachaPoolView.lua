-- chunkname: @IQIGame\\UI\\Activity\\GachaPool\\ActivityGachaPoolView.lua

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ActivityGachaItemCell = require("IQIGame.UI.Activity.GachaPool.ActivityGachaItemCell")
local ActivityGachaRefreshView = require("IQIGame.UI.Activity.GachaPool.ActivityGachaRefreshView")
local m = {
	RewardIndex = -1,
	RewardCells = {}
}

function m.New(view, host, operateEventID)
	local obj = Clone(m)

	obj:Init(view, host, operateEventID)

	return obj
end

function m:Init(view, host, operateEventID)
	self.View = view
	self.Host = host
	self.OperateEventID = operateEventID

	LuaCodeInterface.BindOutlet(self.View, self)
	UIUtil.InitSortedComponents(self.Host.UIController:GetComponent("Canvas"), self.View)

	function self.DelegateOnClickDrawBtnBtn()
		self:OnClickDrawBtnBtn()
	end

	function self.DelegateOnClickTipBtn()
		self:OnClickTipBtn()
	end

	function self.DelegateOnDrawResult(awardsId, itemShowPODList, operationEventDataPOD)
		self:OnDrawResult(awardsId, itemShowPODList, operationEventDataPOD)
	end

	function self.DelegateRefreshEvent()
		self:OnRefreshEvent()
	end

	self.RewardCellPool = UIObjectPool.New(10, function()
		return ActivityGachaItemCell.New(UnityEngine.Object.Instantiate(self.ItemCellPrefab))
	end, function(cell)
		local v = cell.View

		cell:Dispose()
		UnityEngine.Object.Destroy(v)
	end)

	self:StopAllEffect()

	self.TempTiling = Vector2.zero

	UGUIUtil.SetText(self.RateUpLabel, ActivityUIApi:GetString("GachaRateUpLabel"))
	UGUIUtil.SetTextInChildren(self.DrawBtn, ActivityUIApi:GetString("GachaDrawBtnText"))

	self.refreshView = ActivityGachaRefreshView.New(self.RefreshNode)
end

function m.GetPreloadAssetPaths()
	return
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.OnEffectEnd == nil then
		return
	end

	local rare = -1

	for i = 1, 4 do
		local progressEffect = self["EffectProgressLv" .. i]

		if progressEffect ~= nil and progressEffect.activeSelf then
			rare = i

			break
		end
	end

	if rare == -1 then
		return
	end

	if self.ProgressEffectStartTime == nil then
		self.ProgressEffectStartTime = UnityEngine.Time.realtimeSinceStartup
	end

	local tilingX0 = ActivityUIApi:GetString("GachaProgressEffectMaskTilingX", rare, 0)
	local targetTilingX = ActivityUIApi:GetString("GachaProgressEffectMaskTilingX", rare, self.RewardIndex)
	local speed = ActivityUIApi:GetString("GachaProgressEffectSpeed", rare) * -1
	local percent = (UnityEngine.Time.realtimeSinceStartup - self.ProgressEffectStartTime) / ((targetTilingX - tilingX0) / speed)

	if percent > 1 then
		percent = 1
	end

	if self.ProgressEffectRenderers ~= nil and #self.ProgressEffectRenderers > 0 then
		local tilingX = tilingX0 + (targetTilingX - tilingX0) * percent

		self.TempTiling.x = tilingX

		for i = 1, #self.ProgressEffectRenderers do
			local renderer = self.ProgressEffectRenderers[i]

			if renderer.material:HasProperty("_mask") then
				renderer.material:SetTextureScale("_mask", self.TempTiling)
			end
		end
	end

	if percent >= 1 then
		self.OnEffectEnd()
	end
end

function m:Open()
	self:AddListeners()
	self.View:SetActive(true)
	self:Refresh()
end

function m:Close()
	self.View:SetActive(false)
	self:OnHide()
end

function m:OnHide()
	self:RemoveListeners()
	self:StopAllEffect()
end

function m:AddListeners()
	self.DrawBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDrawBtnBtn)
	self.TipBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickTipBtn)
	EventDispatcher.AddEventListener(EventID.UpdateGachaRefreshEvent, self.DelegateRefreshEvent)
end

function m:RemoveListeners()
	self.DrawBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDrawBtnBtn)
	self.TipBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickTipBtn)
	EventDispatcher.RemoveEventListener(EventID.UpdateGachaRefreshEvent, self.DelegateRefreshEvent)
end

function m:OnRefreshEvent()
	self:Refresh()
end

function m:Refresh()
	self.EventPOD = ActiveOperationEventModule.GetActiveOperationData(self.OperateEventID)
	self.OperationEventDataPOD = ActiveOperationEventModule.GetEventDataPOD(self.OperateEventID)

	local cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[self.EventPOD.dataCfgId]

	self:ClearRewards()

	local rewards = cfgGachaPoolGlobalData.Rewards

	self.RewardMap = {}

	local maxRare = 0

	for i = 1, #rewards do
		local cfgGachaPoolRewardData = CfgGachaPoolRewardTable[rewards[i]]

		self.RewardMap[cfgGachaPoolRewardData.Rare] = self.RewardMap[cfgGachaPoolRewardData.Rare] or {}

		table.insert(self.RewardMap[cfgGachaPoolRewardData.Rare], cfgGachaPoolRewardData)

		maxRare = math.max(maxRare, cfgGachaPoolRewardData.Rare)
	end

	local markNum = 0
	local hasGotMarkNum = 0

	for i = 1, maxRare do
		local rewardsOfThisRare = self.RewardMap[i]

		if rewardsOfThisRare ~= nil then
			for j = 1, #rewardsOfThisRare do
				local cfgData = rewardsOfThisRare[j]
				local cell = self.RewardCellPool:Obtain()

				cell.View:SetActive(true)
				cell.View.transform:SetParent(self["RewardGridLv" .. i].transform, false)
				cell:SetData(cfgData, self.OperationEventDataPOD.gachaPoolData.getAwards, self.OperationEventDataPOD.gachaPoolData.isRefresh)
				table.insert(self.RewardCells, cell)

				if cfgData.Mark then
					markNum = markNum + 1

					if cell.hasGot then
						hasGotMarkNum = hasGotMarkNum + 1
					end
				end
			end
		end
	end

	local drawCount = #self.OperationEventDataPOD.gachaPoolData.getAwards

	UGUIUtil.SetText(self.RateUpValueText, ActivityUIApi:GetString("GachaRateUpValueText", cfgGachaPoolGlobalData.WeightBonus * drawCount))

	local itemCid, itemNum = ActiveGachaModule.GetDrawCost()

	self.CostItemView:SetActive(itemCid ~= -1)
	self.DrawBtn:SetActive(itemCid ~= -1)

	if itemCid ~= -1 then
		self.CostItemIcon:SetActive(itemNum > 0)

		if itemNum > 0 then
			local cfgItemData = CfgItemTable[itemCid]

			AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), self.CostItemIcon:GetComponent("Image"))
		end

		UGUIUtil.SetText(self.CostItemNumText, ActivityUIApi:GetString("GachaCostItemNumText", itemNum))
	end

	UGUIUtil.SetText(self.RateUpDescText, ActivityUIApi:GetString("GachaRateUpDescText", getDateTimeMText(self.EventPOD.endTime)))

	local canFresh = false

	if markNum > 0 and markNum <= hasGotMarkNum and not self.OperationEventDataPOD.gachaPoolData.isRefresh then
		canFresh = true
	end

	self.refreshView:UpDateView(self.OperateEventID, canFresh, self.OperationEventDataPOD.gachaPoolData.isRefresh)
end

function m:ClearRewards(isDestroy)
	for i = 1, #self.RewardCells do
		local cell = self.RewardCells[i]

		cell.View:SetActive(false)

		if not isDestroy then
			cell.View.transform:SetParent(self.View.transform, false)
		end

		self.RewardCellPool:Release(cell)
	end

	self.RewardCells = {}
end

function m:OnClickDrawBtnBtn()
	local itemCid, itemNum = ActiveGachaModule.GetDrawCost()

	if itemCid == -1 then
		return
	end

	if itemNum == 0 then
		self:Draw()

		return
	end

	local cfgItemData = CfgItemTable[itemCid]
	local hasNum = WarehouseModule.GetItemNumByCfgID(itemCid)

	if itemNum <= hasNum then
		NoticeModule.ShowNoticeBuyConfirm(21045031, function()
			self:Draw()
		end, nil, nil, {
			itemCid
		}, {
			itemNum
		})
	elseif itemCid == Constant.ItemID.ID_PAYPOINT_SHOW then
		NoticeModule.MoneyDeficitTip(2, itemNum - hasNum)
	elseif itemCid == Constant.ItemID.TREASURE then
		NoticeModule.MoneyDeficitTip(1, itemNum - hasNum)
	else
		NoticeModule.ShowNoticeNoCallback(21045004, cfgItemData.Name)
	end
end

function m:Draw()
	self.Block:SetActive(true)
	ActiveGachaModule.SendDraw(self.EventPOD.eventCfgId, self.DelegateOnDrawResult)
end

function m:OnDrawResult(awardsId, itemShowPODList, operationEventDataPOD)
	local cfgGachaPoolRewardData = CfgGachaPoolRewardTable[awardsId]
	local rewardsOfThisRare = self.RewardMap[cfgGachaPoolRewardData.Rare]

	self.RewardIndex = -1

	for i = 1, #rewardsOfThisRare do
		local lCfgGachaPoolRewardData = rewardsOfThisRare[i]

		if lCfgGachaPoolRewardData.Id == awardsId then
			self.RewardIndex = i

			break
		end
	end

	local rollingEffect = self["EffectRollLv" .. cfgGachaPoolRewardData.Rare]

	if rollingEffect ~= nil then
		rollingEffect:SetActive(true)
	end

	self.RollingEndTimer = Timer.New(function()
		self.RollingEndTimer = nil

		rollingEffect:SetActive(false)

		local progressEffect = self["EffectProgressLv" .. cfgGachaPoolRewardData.Rare]

		progressEffect:SetActive(true)

		self.ProgressEffectRenderers = {}

		local renderers = progressEffect:GetComponentsInChildren(typeof(UnityEngine.Renderer))

		for i = 0, renderers.Length - 1 do
			local renderer = renderers[i]

			if renderer.material ~= nil and renderer.material:HasProperty("_mask") then
				table.insert(self.ProgressEffectRenderers, renderer)
			end
		end
	end, ActivityUIApi:GetString("GachaRollingEffectDuration", cfgGachaPoolRewardData.Rare))

	self.RollingEndTimer:Start()

	function self.OnEffectEnd()
		self.OnEffectEnd = nil

		for i = 1, #self.RewardCells do
			local cell = self.RewardCells[i]

			if cell.CfgGachaPoolRewardData.Id == awardsId then
				cell:PlayEffect()

				break
			end
		end

		self.CellEffectDelayTimer = Timer.New(function()
			self.CellEffectDelayTimer = nil

			self:StopAllEffect()
			self:Refresh()
			NoticeModule.ShowGetItems(Constant.TipConst.TIP_GET_ITEM_NOTICE_TEXT, itemShowPODList)
			self.Block:SetActive(false)
		end, ActivityUIApi:GetString("GachaCellEffectDuration"))

		self.CellEffectDelayTimer:Start()
	end
end

function m:StopAllEffect()
	for i = 1, 4 do
		self["EffectRollLv" .. i]:SetActive(false)
		self["EffectProgressLv" .. i]:SetActive(false)
	end

	if self.RollingEndTimer ~= nil then
		self.RollingEndTimer:Stop()

		self.RollingEndTimer = nil
	end

	if self.CellEffectDelayTimer ~= nil then
		self.CellEffectDelayTimer:Stop()

		self.CellEffectDelayTimer = nil
	end

	self.Block:SetActive(false)

	self.ProgressEffectStartTime = nil
	self.ProgressEffectRenderers = nil
end

function m:OnClickTipBtn()
	local cfgGachaPoolGlobalData = CfgGachaPoolGlobalTable[self.EventPOD.dataCfgId]

	UIModule.Open(Constant.UIControllerName.DailyActivityTipsUI, Constant.UILayer.UI, cfgGachaPoolGlobalData.Desc)
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:ClearRewards()
	self.RewardCellPool:Dispose()

	self.RewardCellPool = nil

	self.refreshView:Dispose()

	self.refreshView = nil

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.Host = nil
	self.EventPOD = nil
	self.OperationEventDataPOD = nil
end

return m
