-- chunkname: @IQIGame\\UI\\RestaurantOperationPlayerUI.lua

local RestaurantOperationPlayerUI = {
	roPostControls = {},
	roPosControlCellPool = {},
	roPosCellPool = {},
	roWorkers = {},
	roWorkerCellPool = {}
}

RestaurantOperationPlayerUI = Base:Extend("RestaurantOperationPlayerUI", "IQIGame.Onigao.UI.RestaurantOperationPlayerUI", RestaurantOperationPlayerUI)

require("IQIGame.UIExternalApi.RestaurantOperationPlayerUIApi")

local ROPosControlCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationPlayer.ROPosControlCell")
local ROPosCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationPlayer.ROPosCell")
local ROPosWorkerCell = require("IQIGame.UI.ExploreHall.RestaurantOperation.RestaurantOperationPlayer.ROPosWorkerCell")

function RestaurantOperationPlayerUI:OnInit()
	UGUIUtil.SetTextInChildren(self.BtnClose, RestaurantOperationPlayerUIApi:GetString("TextTitle"))

	function self.DelegateOnClickBtnClose()
		self:OnClickBtnClose()
	end

	function self.DelegateToggleControl(isOn)
		self:OnTogControl(isOn)
	end

	function self.DelegateUpdateROWorkerEvent(data, beforeAtt)
		self:OnUpdateROWorkerEvent(data, beforeAtt)
	end

	self.PosScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderPosCell(cell)
	end
	self.RoleScrollArea:GetComponent("ScrollAreaList").onRenderCell = function(cell)
		self:OnRenderPlayerCell(cell)
	end
	self.RoleScrollArea:GetComponent("ScrollAreaList").onSelectedCell = function(cell)
		self:OnSelectedPlayerCell(cell)
	end
	self.roPosControlCellPool = {}
	self.roPostControls = RestaurantOperationModule.ROPostControl

	table.sort(self.roPostControls, function(a, b)
		return a:GetCfgData().Type < b:GetCfgData().Type
	end)
	self.PosControlMould:SetActive(true)

	for i = 1, #self.roPostControls do
		local data = self.roPostControls[i]
		local controlCell = ROPosControlCell.New(UnityEngine.Object.Instantiate(self.PosControlMould))

		controlCell.View:SetActive(true)
		controlCell.View.transform:SetParent(self.PosControlNode.transform, false)
		controlCell:SetData(data)

		local tog = controlCell.View:GetComponent("Toggle")

		tog.group = self.PosControlNode:GetComponent("ToggleGroup")

		table.insert(self.roPosControlCellPool, controlCell)

		if self.selectControlData == nil then
			self.selectControlData = data
		end
	end
end

function RestaurantOperationPlayerUI:GetPreloadAssetPaths()
	return nil
end

function RestaurantOperationPlayerUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function RestaurantOperationPlayerUI:IsManualShowOnOpen(userData)
	return false
end

function RestaurantOperationPlayerUI:GetBGM(userData)
	return nil
end

function RestaurantOperationPlayerUI:OnOpen(userData)
	self:UpdateView()
end

function RestaurantOperationPlayerUI:OnClose(userData)
	return
end

function RestaurantOperationPlayerUI:OnAddListeners()
	self.BtnClose:GetComponent("Button").onClick:AddListener(self.DelegateOnClickBtnClose)

	for i, v in pairs(self.roPosControlCellPool) do
		v.View:GetComponent("Toggle").onValueChanged:AddListener(self.DelegateToggleControl)
	end

	EventDispatcher.AddEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationPlayerUI:OnRemoveListeners()
	self.BtnClose:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickBtnClose)

	for i, v in pairs(self.roPosControlCellPool) do
		v.View:GetComponent("Toggle").onValueChanged:RemoveListener(self.DelegateToggleControl)
	end

	EventDispatcher.RemoveEventListener(EventID.UpdateROWorkerEvent, self.DelegateUpdateROWorkerEvent)
end

function RestaurantOperationPlayerUI:OnPause()
	return
end

function RestaurantOperationPlayerUI:OnResume()
	return
end

function RestaurantOperationPlayerUI:OnCover()
	return
end

function RestaurantOperationPlayerUI:OnReveal()
	return
end

function RestaurantOperationPlayerUI:OnRefocus(userData)
	return
end

function RestaurantOperationPlayerUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function RestaurantOperationPlayerUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function RestaurantOperationPlayerUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function RestaurantOperationPlayerUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function RestaurantOperationPlayerUI:OnDestroy()
	AssetUtil.UnloadAsset(self)

	for i, v in pairs(self.roPosControlCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.roPosCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.roWorkerCellPool) do
		v:Dispose()
	end
end

function RestaurantOperationPlayerUI:OnClickBtnClose()
	UIModule.CloseSelf(self)
end

function RestaurantOperationPlayerUI:UpdateView()
	self:ShowSelectControl()
end

function RestaurantOperationPlayerUI:OnUpdateROWorkerEvent(data, beforeAtt)
	self:UpdateView()
end

function RestaurantOperationPlayerUI:OnTogControl(isOn)
	if isOn then
		for i = 1, #self.roPosControlCellPool do
			local control = self.roPosControlCellPool[i]

			if control.View:GetComponent("Toggle").isOn and self.selectControlData and self.selectControlData.cid ~= control.controlData.cid then
				self.selectControlData = control.controlData

				self:ShowSelectControl()

				break
			end
		end
	end
end

function RestaurantOperationPlayerUI:ShowRoleList()
	self.roWorkers = {}

	for i, v in pairs(RestaurantOperationModule.ROPlayers) do
		if v:GetCfgData().Type == RestaurantOperationConstant.RoleType.worker and v.posInfo and v.posInfo.location == 0 then
			table.insert(self.roWorkers, v)
		end
	end

	self.RoleScrollArea:GetComponent("ScrollAreaList"):Refresh(#self.roWorkers)
end

function RestaurantOperationPlayerUI:ShowSelectControl()
	local maxNum = 0

	if self.selectControlData then
		log(self.selectControlData:GetCfgData().PostName)

		maxNum = self.selectControlData:GetMaxPosNum()

		local mainAttr = CfgRestaurantOperationAttributeTable[self.selectControlData:GetCfgData().MainAtt].AttName

		UGUIUtil.SetText(self.TextSelectDes, RestaurantOperationPlayerUIApi:GetString("TextSelectDes", self.selectControlData:GetCfgData().PostName, mainAttr, self:GetMainAttr(self.selectControlData.cid)))

		local incomeID = self.selectControlData:GetCfgData().InComeID

		if incomeID > 0 then
			local incomeValue = self:GetIncome(incomeID)

			UGUIUtil.SetText(self.TextSelectValue, RestaurantOperationPlayerUIApi:GetString("TextSelectValue", CfgRestaurantOperationIncomeTable[incomeID].AttName, incomeValue))
		else
			UGUIUtil.SetText(self.TextSelectValue, "")
		end
	end

	self.PosScrollArea:GetComponent("ScrollAreaList"):Refresh(maxNum)
	self:ShowRoleList()
end

function RestaurantOperationPlayerUI:GetMainAttr(cid)
	local num = 0

	if RestaurantOperationModule.ROAttributePOD and RestaurantOperationModule.ROAttributePOD.postInfo then
		for i, v in pairs(RestaurantOperationModule.ROAttributePOD.postInfo) do
			if v.type == cid then
				num = v.value + v.restaurantMarkUp

				break
			end
		end
	end

	return num
end

function RestaurantOperationPlayerUI:GetIncome(inComeID)
	local incomeValue = RestaurantOperationModule.ROAttributePOD.income[inComeID]

	incomeValue = incomeValue or 0

	return incomeValue
end

function RestaurantOperationPlayerUI:OnRenderPosCell(cell)
	local pos = cell.index + 1
	local unlock, posFormation = self.selectControlData:GetFormation(pos)
	local instanceID = cell.gameObject:GetInstanceID()
	local roPosCell = self.roPosCellPool[instanceID]

	if roPosCell == nil then
		roPosCell = ROPosCell.New(cell.gameObject)
		self.roPosCellPool[instanceID] = roPosCell
	end

	roPosCell:SetData(self.selectControlData.cid, pos, unlock, posFormation)
end

function RestaurantOperationPlayerUI:OnRenderPlayerCell(cell)
	local roData = self.roWorkers[cell.index + 1]
	local instanceID = cell.gameObject:GetInstanceID()
	local workerCell = self.roWorkerCellPool[instanceID]

	if workerCell == nil then
		workerCell = ROPosWorkerCell.New(cell.gameObject)
		self.roPosCellPool[instanceID] = workerCell
	end

	workerCell:SetData(roData, roData:GetAttrValue(self.selectControlData:GetCfgData().MainAtt))
end

function RestaurantOperationPlayerUI:OnSelectedPlayerCell(cell)
	local selectRoData = self.roWorkers[cell.index + 1]

	if selectRoData.posInfo.location ~= 0 then
		return
	end

	local targetPos = self.selectControlData:GetIdlePositions()

	if targetPos > 0 then
		RestaurantOperationModule.Work(selectRoData.cid, self.selectControlData.cid, targetPos, 1)
	end
end

return RestaurantOperationPlayerUI
