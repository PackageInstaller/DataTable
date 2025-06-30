-- chunkname: @IQIGame\\UI\\RestaurantOperationUnlockPlayerUI.lua

local RestaurantOperationUnlockPlayerUI = {
	NpcActionGroupId = 0,
	roleAttrCells = {}
}

RestaurantOperationUnlockPlayerUI = Base:Extend("RestaurantOperationUnlockPlayerUI", "IQIGame.Onigao.UI.RestaurantOperationUnlockPlayerUI", RestaurantOperationUnlockPlayerUI)

require("IQIGame.UIExternalApi.RestaurantOperationUnlockPlayerUIApi")

local UIObjectPool = require("IQIGame.UI.Common.UIObjectPool")
local ROUpdateRoleAttrCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationUpdate.ROUpdateRoleAttrCell")
local NPCActionView = require("IQIGame.UI.NPCAction.NPCActionView")

function RestaurantOperationUnlockPlayerUI:OnInit()
	function self.DelegateOnClickCloseBtn()
		self:OnClickCloseBtn()
	end

	function self.DelegateOnClickBtnUpGrade()
		self:OnClickBtnUpGrade()
	end

	function self.DelegateUpdateROWorkerEvent(data, beforeAtt)
		self:OnUpdateROWorkerEvent(data, beforeAtt)
	end

	UGUIUtil.SetText(self.TitleText, RestaurantOperationUnlockPlayerUIApi:GetString("TitleText"))

	self.NpcView = NPCActionView.New(self.NpcActionGo)

	self.AttrPrefab:SetActive(false)

	self.roleAttrCellPool = UIObjectPool.New(6, function()
		return ROUpdateRoleAttrCell.New(UnityEngine.Object.Instantiate(self.AttrPrefab))
	end, function(cell)
		cell:Dispose()
	end)
end

function RestaurantOperationUnlockPlayerUI:GetPreloadAssetPaths()
	local cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]
	local cfgNpcActionData = NPCActionModule.GetAction(cfgControlData.NPCAction, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)

	return {
		UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)
	}
end

function RestaurantOperationUnlockPlayerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationUnlockPlayerUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationUnlockPlayerUI:GetBGM(userData)
	return nil
end

function RestaurantOperationUnlockPlayerUI:OnOpen(userData)
	self.cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]

	self:RefreshNpc()
	self:UpdateView()
end

function RestaurantOperationUnlockPlayerUI:OnClose(userData)
	self.NpcView:OnHide()

	self.roPlayerData = nil
end

function RestaurantOperationUnlockPlayerUI:OnAddListeners()
	self.CloseBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnUpGrade)
	EventDispatcher.AddEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationUnlockPlayerUI:OnRemoveListeners()
	self.CloseBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickCloseBtn)
	self.BtnUpGrade:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnUpGrade)
	EventDispatcher.RemoveEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationUnlockPlayerUI:OnPause()
	return
end

function RestaurantOperationUnlockPlayerUI:OnResume()
	return
end

function RestaurantOperationUnlockPlayerUI:OnCover()
	return
end

function RestaurantOperationUnlockPlayerUI:OnReveal()
	return
end

function RestaurantOperationUnlockPlayerUI:OnRefocus(userData)
	return
end

function RestaurantOperationUnlockPlayerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	self.NpcView:Update(elapseSeconds, realElapseSeconds)
end

function RestaurantOperationUnlockPlayerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationUnlockPlayerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationUnlockPlayerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationUnlockPlayerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self.NpcView:OnDestroy()

	for i, v in pairs(self.roleAttrCells) do
		self.roleAttrCellPool:Release(v)
	end

	self.roleAttrCells = {}

	self.roleAttrCellPool:Dispose()
end

function RestaurantOperationUnlockPlayerUI:OnClickCloseBtn()
	UIModule.CloseSelf(self)
end

function RestaurantOperationUnlockPlayerUI:OnClickBtnUpGrade()
	local needNum = self.cfgControlData.CreateCost[2]
	local have = WarehouseModule.GetItemNumByCfgID(self.cfgControlData.CreateCost[1])

	if have < needNum then
		NoticeModule.ShowNotice(21045089)

		return
	end

	local cfgData = RestaurantOperationModule.GetBuildingData()

	if #RestaurantOperationModule.ROAttributePOD.positionInformation >= cfgData.CreateMax then
		NoticeModule.ShowNotice(21045094)

		return
	end

	RestaurantOperationModule.TransactDocuments()
end

function RestaurantOperationUnlockPlayerUI:OnUpdateROWorkerEvent(data, beforeAtt)
	self.roPlayerData = data

	self:UpdateView()
end

function RestaurantOperationUnlockPlayerUI:UpdateView()
	local isUnlock = false

	if self.roPlayerData then
		isUnlock = self.roPlayerData:IsUnlock()
	end

	self.UnlockNode:SetActive(isUnlock)

	if isUnlock then
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
		local totalAttr = 0

		if self.roPlayerData.posInfo then
			for i, v in pairs(self.roPlayerData.posInfo.att) do
				local render = self.roleAttrCellPool:Obtain()

				render.View:SetActive(true)
				render.View.transform:SetParent(self.PlayerAttrNode.transform, false)
				render:SetData(i, v, 0)
				table.insert(attrTab, {
					attrID = i,
					attrValue = v
				})
				table.insert(self.roleAttrCells, render)

				totalAttr = totalAttr + v
			end
		end

		UGUIUtil.SetText(self.TextTotalAttr, RestaurantOperationUnlockPlayerUIApi:GetString("TextTotalAttr", totalAttr))
		self:DrawRegion(attrTab)
	else
		UGUIUtil.SetText(self.CostNum, self.cfgControlData.CreateCost[2])
	end

	local cfgData = RestaurantOperationModule.GetBuildingData()

	self.TextGetAllPlayer:SetActive(#RestaurantOperationModule.ROAttributePOD.positionInformation >= cfgData.CreateMax)
	UGUIUtil.SetText(self.TextGetAllPlayer, RestaurantOperationUnlockPlayerUIApi:GetString("TextGetAllPlayer", #RestaurantOperationModule.ROAttributePOD.positionInformation))
	UGUIUtil.SetText(self.TextDes, RestaurantOperationUnlockPlayerUIApi:GetString("TextDes", cfgData.Level, cfgData.CreateMax))
end

function RestaurantOperationUnlockPlayerUI:DrawRegion(attrs)
	local component = self.RadarObj:GetComponent("RadarCustomComponent")
	local list = component.ratioList

	list:Clear()

	for i = 1, #attrs do
		local attrID = attrs[i].attrID
		local attrValue = attrs[i].attrValue

		attrValue = attrValue > self.cfgControlData.AttMax and self.cfgControlData.AttMax or attrValue

		local value = attrValue / self.cfgControlData.AttMax

		list:Add(value)

		local iconObj = self.AttrIconNode.transform:GetChild(i - 1).gameObject

		iconObj.name = attrID

		local path = UIGlobalApi.GetImagePath(CfgRestaurantOperationAttributeTable[attrID].ImageIcon)

		AssetUtil.LoadImage(self, path, iconObj:GetComponent("Image"))
	end

	component:Refresh()
end

function RestaurantOperationUnlockPlayerUI:RefreshNpc()
	local cfgControlData = CfgRestaurantOperationControlTable[RestaurantOperationModule.GlobalCid]

	self.NpcActionGroupId = cfgControlData.NPCAction

	local cfgNpcActionData = NPCActionModule.GetAction(self.NpcActionGroupId, PlayerModule.PlayerInfo.baseInfo.pLv, Constant.NPCTriggerType.OpenUI, getDateTimeTable(PlayerModule.GetServerTime()).hour)
	local pos = cfgNpcActionData.Position
	local scale = cfgNpcActionData.Scale
	local talkOffset = cfgNpcActionData.TalkPosition
	local goNpc = UnityEngine.GameObject.Instantiate(self.UIController:GetPreloadedAsset(UIGlobalApi.GetPrefabRoot(cfgNpcActionData.NPC)))

	self.NpcView:Refresh(cfgNpcActionData, goNpc, cfgNpcActionData.NPC, self.NpcPoint.transform, pos, scale, talkOffset)
end

return RestaurantOperationUnlockPlayerUI
