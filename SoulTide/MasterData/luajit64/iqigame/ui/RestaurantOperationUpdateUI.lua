-- chunkname: @IQIGame\\UI\\RestaurantOperationUpdateUI.lua

local RestaurantOperationUpdateUI = {
	NpcActionGroupId = 0,
	canUpdate = false,
	isSpend = false,
	roleAttrCells = {},
	roWorkers = {},
	roWorkerCellPool = {}
}

RestaurantOperationUpdateUI = Base:Extend("RestaurantOperationUpdateUI", "IQIGame.Onigao.UI.RestaurantOperationUpdateUI", RestaurantOperationUpdateUI)

require("IQIGame.UIExternalApi.RestaurantOperationUpdateUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")
local ROUpdateRoleAttrCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationUpdate.ROUpdateRoleAttrCell")
local ROPosWorkerCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationPlayer.ROPosWorkerCell")

function RestaurantOperationUpdateUI:OnInit()
	UGUIUtil.SetText(self.TitleText, RestaurantOperationUpdateUIApi:GetString("TitleText"))

	self.NpcView = NPCActionView.New(self.NpcActionGo)

	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnUpGrade()
		self:OnClickBtnUpGrade()
	end

	function self.DelegateUpdateROWorkerEvent(data, beforeAtt)
		self:OnUpdateROWorkerEvent(data, beforeAtt)
	end

	self.ScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderPlayerCell(cell)
	end
	self.ScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedPlayerCell(cell)
	end

	self.AttrPrefab:SetActive(false)

	self.roleAttrCellPool = UIObjectPool.New(6, function()
		return ROUpdateRoleAttrCell.New(UnityEngine.Object.Instantiate(self.AttrPrefab))
	end, function(cell)
		cell:Dispose()
	end)
end

function RestaurantOperationUpdateUI:GetPreloadAssetPaths()
	local cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]
	local cfgNpcActionData = NPCActionModule.GetAction(cfgControlData.NPCAction, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	return {
		UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)
	}
end

function RestaurantOperationUpdateUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationUpdateUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationUpdateUI:GetBGM(userData)
	return nil
end

function RestaurantOperationUpdateUI:OnOpen(userData)
	local playerCid = userData.ROPlayerCid

	if playerCid > 0 and CfgRestaurantOperationPlayerTable[playerCid].Type == RestaurantOperationConstant.RoleType.worker then
		self.roPlayerData = RestaurantOperationModule.GetROPlayerData(playerCid)
	end

	self.cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]

	self:RefreshNpc()
	self:UpdateView(nil, true)
end

function RestaurantOperationUpdateUI:OnClose(userData)
	self.NpcView:OnHide()
end

function RestaurantOperationUpdateUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnUpGrade)
	EventDispatcher.AddEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationUpdateUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnUpGrade)
	EventDispatcher.RemoveEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationUpdateUI:OnPause()
	return
end

function RestaurantOperationUpdateUI:OnResume()
	return
end

function RestaurantOperationUpdateUI:OnCover()
	return
end

function RestaurantOperationUpdateUI:OnReveal()
	return
end

function RestaurantOperationUpdateUI:OnRefocus(userData)
	return
end

function RestaurantOperationUpdateUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.NpcView:Update(elapseSeconds, realElapseSeconds)
end

function RestaurantOperationUpdateUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationUpdateUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationUpdateUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationUpdateUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.roleAttrCells) do
		self.roleAttrCellPool:Release(v)
	end

	self.roleAttrCells = {}

	self.roleAttrCellPool:Dispose()

	for i, v in pairs(self.roWorkerCellPool) do
		v:Dispose()
	end

	self.NpcView:OnDestroy()
end

function RestaurantOperationUpdateUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RestaurantOperationUpdateUI:OnUpdateROWorkerEvent(data, beforeAtt)
	if self.roPlayerData and self.roPlayerData.cid == data.cid then
		self.roPlayerData = data
	end

	self:UpdateView(beforeAtt, false)
end

function RestaurantOperationUpdateUI:UpdateView(beforeAtt, isFresh)
	self.canUpdate = false
	self.roWorkers = {}

	for i, v in pairs(RestaurantOperationModule.ROPlayers) do
		if v:GetCfgData().Type == RestaurantOperationConstant.RoleType.worker and v:IsUnlock() then
			table.insert(self.roWorkers, v)
		end
	end

	table.sort(self.roWorkers, function(a, b)
		if a:GetTotalAttrValue() == b:GetTotalAttrValue() then
			return a.cid < b.cid
		end

		return a:GetTotalAttrValue() < b:GetTotalAttrValue()
	end)

	if isFresh then
		self.ScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.roWorkers)
	else
		self.ScrollArea:GetComponent("ScrollAreaList"):RenderCellsDynamic(#self.roWorkers)
	end

	self:ShowSelectRole(beforeAtt)
	self.Right:SetActive(#self.roWorkers > 0)
	self.EmptyNode:SetActive(#self.roWorkers == 0)
end

function RestaurantOperationUpdateUI:ShowSelectRole(beforeAtt)
	if self.roPlayerData then
		UGUIUtil.SetText(self.TextTotalAttr, RestaurantOperationUpdateUIApi:GetString("TextTotalAttr", self.roPlayerData:GetTotalAttrValue()))
		UGUIUtil.SetText(self.TextCount, self.roPlayerData.posInfo.count)
		UGUIUtil.SetText(self.TextPlayerName, self.roPlayerData:GetCfgData().Name)

		local path = UIGlobalApi.GetImagePath(self.roPlayerData:GetCfgData().HeadIcon)

		AssetUtil.LoadImage(self, path, self.ImgHead:GetComponent("Image"))

		for i, v in pairs(self.roleAttrCells) do
			self.roleAttrCellPool:Release(v)
			v.View:SetActive(false)
			v.View.transform:SetParent(self.UIController.transform, false)
		end

		self.roleAttrCells = {}

		local attrTab = {}

		if self.roPlayerData.posInfo then
			for i, v in pairs(self.roPlayerData.posInfo.att) do
				local render = self.roleAttrCellPool:Obtain()

				render.View:SetActive(true)
				render.View.transform:SetParent(self.PlayerAttrNode.transform, false)

				local addValue = self:GetAddValue(self.roPlayerData, beforeAtt, i)

				render:SetData(i, v, addValue)
				table.insert(attrTab, {
					attrID = i,
					attrValue = v
				})
				table.insert(self.roleAttrCells, render)
			end
		end

		self:DrawRegion(attrTab)

		local cfgData = RestaurantOperationModule.GetModifyCostData(self.roPlayerData.posInfo.count + 1)
		local needID = cfgData.ModifyCost[1]
		local needNum = cfgData.ModifyCost[2]
		local have = WarehouseModule.GetItemNumByCfgID(needID)

		UGUIUtil.SetText(self.TextCost, RestaurantOperationUpdateUIApi:GetString("TextCost", needNum, needNum <= have))
	end
end

function RestaurantOperationUpdateUI:GetAddValue(newData, beforeAtt, type)
	local addValue = 0

	if newData and beforeAtt then
		local beforeValue = beforeAtt[type] or 0

		addValue = newData:GetAttrValue(type) - beforeValue
	end

	return addValue
end

function RestaurantOperationUpdateUI:DrawRegion(attrs)
	self.canUpdate = false

	for i = 1, #attrs do
		local attrID = attrs[i].attrID
		local attrValue = attrs[i].attrValue

		attrValue = attrValue > self.cfgControlData.AttMax and self.cfgControlData.AttMax or attrValue

		local value = attrValue / self.cfgControlData.AttMax

		self.RadarObj:GetComponent("RadarCustomComponent"):AddValue(value)

		local iconObj = self.AttrIconNode.transform:GetChild(i - 1).gameObject
		local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationAttributeTable[attrID].ImageIcon)

		AssetUtil.LoadImage(self, path, iconObj:GetComponent("Image"))

		if not self.canUpdate then
			self.canUpdate = attrValue < self.cfgControlData.AttMax
		end
	end

	self.RadarObj:GetComponent("RadarCustomComponent"):Draw()
end

function RestaurantOperationUpdateUI:RefreshNpc()
	local cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]

	self.NpcActionGroupId = cfgControlData.NPCAction

	local cfgNpcActionData = NPCActionModule.GetAction(self.NpcActionGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local pos = cfgNpcActionData.Position
	local scale = cfgNpcActionData.Scale
	local talkOffset = cfgNpcActionData.TalkPosition
	local goNpc = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)))

	self.NpcView:Refresh(cfgNpcActionData, goNpc, cfgNpcActionData.NPC, self.NpcPoint.transform, pos, scale, talkOffset)
end

function RestaurantOperationUpdateUI:OnRenderPlayerCell(cell)
	local roData = self.roWorkers[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local workerCell = self.roWorkerCellPool[instanceID]

	if workerCell == nil then
		workerCell = ROPosWorkerCell.New(cell.gameObject)
		self.roWorkerCellPool[instanceID] = workerCell
	end

	workerCell:SetData(roData, roData:GetTotalAttrValue())

	if self.roPlayerData then
		workerCell:SetSelect(self.roPlayerData.cid == roData.cid)
	end
end

function RestaurantOperationUpdateUI:OnSelectedPlayerCell(cell)
	self.roPlayerData = self.roWorkers[cell.index + 1]

	for i, v in pairs(self.roWorkerCellPool) do
		v:SetSelect(v.workerData.cid == self.roPlayerData.cid)
	end

	self:ShowSelectRole()
end

function RestaurantOperationUpdateUI:OnClickBtnUpGrade()
	if not self.canUpdate then
		NoticeModule.ShowNotice(21045092)

		return
	end

	self.isSpend = true

	local cfgData = RestaurantOperationModule.GetModifyCostData(self.roPlayerData.posInfo.count + 1)

	for i = 1, #cfgData.ModifyCost, 2 do
		if self.isSpend then
			local needID = cfgData.ModifyCost[i]
			local needNum = cfgData.ModifyCost[i + 1]
			local have = WarehouseModule.GetItemNumByCfgID(needID)

			self.isSpend = needNum <= have
		end
	end

	if not self.isSpend then
		NoticeModule.ShowNotice(21045089)

		return
	end

	RestaurantOperationModule.Practice(self.roPlayerData.cid)
end

return RestaurantOperationUpdateUI
