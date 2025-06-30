-- chunkname: @IQIGame\\UI\\HomeLandUnlockFieldUI.lua

local HomeLandUnlockFieldUI = {
	ample = true,
	isCondition = true
}

HomeLandUnlockFieldUI = Base:Extend("HomeLandUnlockFieldUI", "IQIGame.Onigao.UI.HomeLandUnlockFieldUI", HomeLandUnlockFieldUI)

require("IQIGame.UIExternalApi.HomeLandUnlockFieldUIApi")

function HomeLandUnlockFieldUI:OnInit()
	UGUIUtil.SetText(self.TextBtnNoReached, HomeLandUnlockFieldUIApi:GetString("TextBtnNoReached"))
	UGUIUtil.SetText(self.TextDes, HomeLandUnlockFieldUIApi:GetString("TextDes"))

	function self.DelegateOnClickBtnReached()
		self:OnClickBtnReached()
	end

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end
end

function HomeLandUnlockFieldUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandUnlockFieldUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandUnlockFieldUI:IsManualShowOnOpen(userData)
	return false
end

function HomeLandUnlockFieldUI:GetBGM(userData)
	return nil
end

function HomeLandUnlockFieldUI:OnOpen(userData)
	self.decorateID = userData

	self:UpdateView()
end

function HomeLandUnlockFieldUI:OnClose(userData)
	return
end

function HomeLandUnlockFieldUI:OnAddListeners()
	self.BtnReached:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnReached)
	self.BtnClose1:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)
end

function HomeLandUnlockFieldUI:OnRemoveListeners()
	self.BtnReached:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnReached)
	self.BtnClose1:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)
end

function HomeLandUnlockFieldUI:OnPause()
	return
end

function HomeLandUnlockFieldUI:OnResume()
	return
end

function HomeLandUnlockFieldUI:OnCover()
	return
end

function HomeLandUnlockFieldUI:OnReveal()
	return
end

function HomeLandUnlockFieldUI:OnRefocus(userData)
	return
end

function HomeLandUnlockFieldUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandUnlockFieldUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandUnlockFieldUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandUnlockFieldUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandUnlockFieldUI:OnDestroy()
	return
end

function HomeLandUnlockFieldUI:UpdateView()
	self.buildingCid = nil
	self.landCid = nil
	self.cfgLand = nil

	local decorate = CfgHomeLandDecorateTable[self.decorateID]
	local HomeLandBuildingData = HomeLandLuaModule.GetBuildingDataByID(decorate.FunctionBuilding)

	if HomeLandBuildingData then
		self.buildingCid = HomeLandBuildingData.cfgBuildingID
	end

	for i, v in pairsCfg(CfgHomeLandPlantGridTable) do
		if v.Decorate == self.decorateID then
			self.cfgLand = v
			self.landCid = v.Id

			break
		end
	end

	UGUIUtil.SetText(self.TextName, decorate.Name)

	self.isCondition = ConditionModule.Check(self.cfgLand.ConditionId)

	if self.cfgLand.ConditionId > 0 then
		local cfgCondition = CfgConditionTable[self.cfgLand.ConditionId]

		UGUIUtil.SetText(self.TextCondition, HomeLandChooseCastleApi:GetString("TextCondition", cfgCondition.Name, self.isCondition))
	else
		UGUIUtil.SetText(self.TextCondition, HomeLandChooseCastleApi:GetString("TextCondition", "", self.isCondition))
	end

	local parentTransform = self.ItemGrid.transform
	local prefabItem = parentTransform:GetChild(0).gameObject

	prefabItem:SetActive(false)

	for i = 1, parentTransform.childCount - 1 do
		local obj = parentTransform:GetChild(1).gameObject

		UnityEngine.GameObject.DestroyImmediate(obj)
	end

	self.ample = true

	for i = 1, #self.cfgLand.OpenCost, 2 do
		local needItemID = self.cfgLand.OpenCost[i]
		local needNum = self.cfgLand.OpenCost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)

		if self.ample == true then
			self.ample = needNum <= haveNum
		end

		local itemData = CfgItemTable[needItemID]
		local obj = UnityEngine.Object.Instantiate(prefabItem)

		obj.transform:SetParent(parentTransform, false)
		obj:SetActive(true)

		local itemCell = ItemCell.PackageOrReuseView(self, obj)

		itemCell:SetItem(itemData)
		itemCell:SetCustomNum(haveNum, needNum)
	end

	if self.cfgLand.OpenCostPayPoint > 0 then
		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.ID_PAYPOINT_SHOW)
		local itemData = CfgItemTable[Constant.ItemID.ID_PAYPOINT_SHOW]
		local obj = UnityEngine.Object.Instantiate(prefabItem)

		obj.transform:SetParent(parentTransform, false)
		obj:SetActive(true)

		local itemCell = ItemCell.PackageOrReuseView(self, obj)

		itemCell:SetItem(itemData)
		itemCell:SetCustomNum(have, self.cfgLand.OpenCostPayPoint)
	end
end

function HomeLandUnlockFieldUI:OnClickBtnReached()
	if self.buildingCid == nil or self.landCid == nil then
		return
	end

	if self.isCondition == false then
		NoticeModule.ShowNotice(21042043)

		return
	end

	if self.ample == false then
		NoticeModule.ShowNotice(21042044)

		return
	end

	if self.cfgLand.OpenCostPayPoint > 0 and PlayerModule.PlayerInfo.baseInfo.payPoint < self.cfgLand.OpenCostPayPoint then
		NoticeModule.ShowNoticeNoCallback(21041006)

		return
	end

	if self.decorateID ~= nil then
		HomeLandLuaModule.UnlockLand(self.buildingCid, self.landCid)
	end

	self:OnClickBtnClose()
end

function HomeLandUnlockFieldUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

return HomeLandUnlockFieldUI
