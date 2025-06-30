-- chunkname: @IQIGame\\UI\\HomeLandPlantUI.lua

local HomeLandPlantUI = Base:Extend("HomeLandPlantUI", "IQIGame.Onigao.UI.HomeLandPlantUI", {
	EntityId = 0,
	isPlayEffect = false,
	plantComeItems = {},
	plantSeedCellPool = {},
	plantDragCellPool = {}
})
local HomeLandPlantTipsView = require("IQIGame.UI.HomeLandPlant.HomeLandPlantTipsView")
local HomeLandPlantMsgPanelView = require("IQIGame.UI.HomeLandPlant.HomeLandPlantMsgPanelView")
local HomeLandPlantSeedCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantSeedCell")
local HomeLandPlantComeItem = require("IQIGame.UI.HomeLandPlant.HomeLandPlantComeItem")
local HomeLandPantDragCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantDragCell")

function HomeLandPlantUI:OnInit()
	UGUIUtil.SetText(self.TextNull, HomeLandPlantUIApi:GetString("TextNullCome"))
	UGUIUtil.SetText(self.TextBtnPlant, HomeLandPlantUIApi:GetString("TextBtnPlant"))

	self.UICanvas = self.UIController:GetComponent("Canvas")
	self.btnCloseComponent = self.BtnClose:GetComponent("Button")
	self.btnHelpComponent = self.BtnHelp:GetComponent("Button")
	self.btnPlantComponent = self.BtnPlant:GetComponent("Button")
	self.scrollComponent = self.ScrollArea:GetComponent("ScrollAreaList")

	function self.scrollComponent.onSelectedCell(cell)
		self:OnSelectSeedCell(cell)
	end

	function self.scrollComponent.onRenderCell(cell)
		self:OnRenderSeedCell(cell)
	end

	function self.delegateBtnClose()
		self:OnBtnClose()
	end

	function self.delegateUpdatePlantEvent(buildingCid, lands)
		self:UpdatePlantEvent(buildingCid, lands)
	end

	function self.delegateBtnHelp()
		self:OnBtnHelp()
	end

	function self.delegateBtnHelpTip()
		self:OnBtnHelpTip()
	end

	function self.delegateBtnPlant()
		self:OnBtnPlant()
	end

	function self.delegateOnBuyGoodsSuccess()
		self:OnBuyGoodsSuccess()
	end

	self.plantTipView = HomeLandPlantTipsView.New(self.Tips, self.RewardMould)
	self.plantMsgPanelView = HomeLandPlantMsgPanelView.New(self.MsgPanel, self.RewardMould)

	function self.plantMsgPanelView.closeCallBack(decorateId)
		self:OnBtnCloseMsgPanel(decorateId)
	end

	self.plantMsgPanelView:Close()

	self.plantDragCellPool = {}

	for i = 1, #Constant.HomeLandPlantDecorates do
		local decorateId = Constant.HomeLandPlantDecorates[i]
		local dragCell = HomeLandPantDragCell.New(self["Plant" .. i])

		dragCell:SetDecorateCid(decorateId)

		function dragCell.clickTimeCellBack(decorateCid)
			self:OnSelectTimeCell(decorateCid)
		end

		self.plantDragCellPool[decorateId] = dragCell
	end
end

function HomeLandPlantUI:GetPreloadAssetPaths()
	return nil
end

function HomeLandPlantUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function HomeLandPlantUI:OnOpen(userData)
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, false))

	self.homeBuildingData = userData[1]

	self.Panel:SetActive(false)
	self:LookPlant()
	self:UpdateView()
end

function HomeLandPlantUI:OnClose(userData)
	self.plantTipView:Close()

	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil

	if UIModule.HasUI(Constant.UIControllerName.HomeLandRoomUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandRoomUI, true)
	end

	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandLuaModule.cameraPosition, HomeLandLuaModule.cameraSize))
	GameEntry.LuaEvent:Fire(nil, HomelandSetRoleVisibleEventArgs():Fill(0, true))
end

function HomeLandPlantUI:OnAddListeners()
	self.btnCloseComponent.onClick:AddListener(self.delegateBtnClose)
	self.btnHelpComponent.onClick:AddListener(self.delegateBtnHelp)
	self.BtnHelpTip:GetComponent("Button").onClick:AddListener(self.delegateBtnHelpTip)
	self.btnPlantComponent.onClick:AddListener(self.delegateBtnPlant)
	EventDispatcher.AddEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
	EventDispatcher.AddEventListener(EventID.BuyGoodsSuccess, self.delegateOnBuyGoodsSuccess)
end

function HomeLandPlantUI:OnRemoveListeners()
	self.btnCloseComponent.onClick:RemoveListener(self.delegateBtnClose)
	self.btnHelpComponent.onClick:RemoveListener(self.delegateBtnHelp)
	self.BtnHelpTip:GetComponent("Button").onClick:RemoveListener(self.delegateBtnHelpTip)
	self.btnPlantComponent.onClick:RemoveListener(self.delegateBtnPlant)
	EventDispatcher.RemoveEventListener(EventID.HomeLandUpdatePlantEvent, self.delegateUpdatePlantEvent)
	EventDispatcher.RemoveEventListener(EventID.BuyGoodsSuccess, self.delegateOnBuyGoodsSuccess)
end

function HomeLandPlantUI:OnPause()
	return
end

function HomeLandPlantUI:OnResume()
	return
end

function HomeLandPlantUI:OnCover()
	return
end

function HomeLandPlantUI:OnReveal()
	return
end

function HomeLandPlantUI:OnRefocus(userData)
	return
end

function HomeLandPlantUI:OnUpdate(elapseSeconds, realElapseSeconds)
	return
end

function HomeLandPlantUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function HomeLandPlantUI:OnLoadSucceed(assetName, asset, duration, userData)
	return
end

function HomeLandPlantUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function HomeLandPlantUI:OnDestroy()
	self.plantMsgPanelView:Dispose()
	self.plantTipView:Dispose()

	for i, v in pairs(self.plantComeItems) do
		v:Dispose()
	end

	for i, v in pairs(self.plantDragCellPool) do
		v:Dispose()
	end

	for i, v in pairs(self.plantSeedCellPool) do
		v:Dispose()
	end
end

function HomeLandPlantUI:OnBtnClose()
	UIModule.Close(Constant.UIControllerName.HomeLandPlantUI)
end

function HomeLandPlantUI:OnBuyGoodsSuccess()
	self:UpdateView()
end

function HomeLandPlantUI:LookPlant()
	self.Panel:SetActive(false)
	GameEntry.LuaEvent:Fire(nil, HomelandLookObjEventArgs():Fill(HomeLandPlantUIApi:GetString("CameraPosition"), HomeLandPlantUIApi:GetString("CameraSize")))

	if self.timerShow then
		self.timerShow:Stop()
	end

	self.timerShow = nil
	self.timerShow = Timer.New(function()
		self.Panel:SetActive(true)
		self:UpdatePlantDragPos()
	end, 0.6)

	self.timerShow:Start()

	if UIModule.HasUI(Constant.UIControllerName.HomeLandRoomUI) then
		GameEntry.UI:ChangeDisableUIFormByName(Constant.UIControllerName.HomeLandRoomUI, false)
	end
end

function HomeLandPlantUI:UpdatePlantEvent(buildingCid, lands)
	if self.homeBuildingData and self.homeBuildingData.cfgBuildingID == buildingCid then
		self.homeBuildingData = HomeLandLuaModule.GetBuildingDataByID(buildingCid)

		if not self.isPlayEffect then
			self:UpdateView()
		end
	end
end

function HomeLandPlantUI:GetSeeds()
	local tab = {}

	for i, v in pairsCfg(CfgHomeLandPlantTable) do
		local num = WarehouseModule.GetItemNumByCfgID(v.CostItem)

		if num > 0 then
			table.insert(tab, v)
		end
	end

	table.sort(tab, function(a, b)
		return a.Sort < b.Sort
	end)

	return tab
end

function HomeLandPlantUI:UpdateView()
	if self.plantMsgPanelView.View.activeSelf == true then
		if self.homeBuildingData and self.selectPlantData and self.selectPlantData.landPOD.status ~= Constant.HomelandPlantType.landStatusIdle then
			self.List:SetActive(false)
			self.plantMsgPanelView:UpdateView(self.homeBuildingData, self.selectPlantData)
			self.plantDragCellPool[self.selectPlantData.decorateCid]:ShowTimeCell(false)
		else
			self.List:SetActive(true)
			self.plantMsgPanelView:Close()
		end
	else
		self.List:SetActive(true)
	end

	self:ShowList()

	local num, maxNum = self.homeBuildingData:GetHelpTimes()

	UGUIUtil.SetText(self.TextHelp, HomeLandPlantUIApi:GetString("TextHelp", num, maxNum))
end

function HomeLandPlantUI:ShowList()
	self.seedTable = self:GetSeeds()

	self.scrollComponent:Refresh(#self.seedTable)

	local temp = #self.seedTable > 0

	self.ScrollAreaEmpty:SetActive(not temp)
	self.ScrollArea:SetActive(temp)

	if not temp then
		self:CreateJump()
	end
end

function HomeLandPlantUI:OnSelectSeedCell(cell)
	local cfgData = self.seedTable[cell.index + 1]

	self.plantTipView:Open()
	self.plantTipView:UpdateView(cfgData)
end

function HomeLandPlantUI:OnRenderSeedCell(cell)
	local cfgData = self.seedTable[cell.index + 1]

	if cfgData == nil then
		cell.gameObject:SetActive(false)

		return
	end

	cell.gameObject:SetActive(true)

	local instanceID = cell.gameObject:GetInstanceID()
	local seedCell = self.plantSeedCellPool[instanceID]

	if seedCell == nil then
		seedCell = HomeLandPlantSeedCell:New(cell.gameObject)
		self.plantSeedCellPool[instanceID] = seedCell

		function seedCell.plantCallBack(decorateId, cfgPlantData)
			self:OnPlant(decorateId, cfgPlantData)
		end
	end

	seedCell:SetDate(cfgData, self)
end

function HomeLandPlantUI:OnBtnHelp()
	UIModule.Open(Constant.UIControllerName.HomeLandVisitHistoryUI, Constant.UILayer.UI, self.homeBuildingData)
end

function HomeLandPlantUI:CreateJump()
	for i, v in pairs(self.plantComeItems) do
		v:Dispose()
	end

	self.plantComeItems = {}

	local tab = HomeLandPlantUIApi:GetString("SeedCome")

	for i = 1, #tab do
		local t = tab[i]
		local obj = UnityEngine.Object.Instantiate(self.JumpMould)

		obj.transform:SetParent(self.Sort.transform, false)
		obj:SetActive(true)

		local itemCell = HomeLandPlantComeItem.New(obj)

		itemCell:SetData(t[1], t[2])
		table.insert(self.plantComeItems, itemCell)
	end
end

function HomeLandPlantUI:PlayPlantEffect(selectCfgData, decorateId)
	self.selectCfgData = selectCfgData

	if self.selectCfgData then
		self:ShowNumChange(decorateId)
		self:Plant(self.selectCfgData.EntityIDSeed)
	end
end

function HomeLandPlantUI:ShowNumChange(decorateId)
	local goEff = UnityEngine.Object.Instantiate(self.MoveMould)

	goEff.transform:SetParent(self.plantDragCellPool[decorateId].View.transform:Find("NumChange"), false)
	goEff:SetActive(true)

	self.isPlayEffect = true

	local time = Timer.New(function()
		UnityEngine.Object.Destroy(goEff)

		self.isPlayEffect = false

		self:UpdateView()
	end, 0.5)

	time:Start()
end

function HomeLandPlantUI:OnBtnHelpTip()
	UIModule.Open(Constant.UIControllerName.TextTipsUI, Constant.UILayer.UI, {
		HomeLandPlantUIApi:GetString("TextTip", HomeLandLuaModule.GetHomeLandComfortLv())
	})
end

function HomeLandPlantUI:Plant(elementEntityCid)
	HomeLandLuaModule.Plant(self.homeBuildingData.cfgBuildingID, self.selectPlantData.plantCid, self.selectCfgData.Id)
end

function HomeLandPlantUI:OnBtnPlant()
	if self.homeBuildingData ~= nil and self.plantTipView.selectCfgData ~= nil then
		local plantData

		for i = 1, #Constant.HomeLandPlantDecorates do
			local decorateId = Constant.HomeLandPlantDecorates[i]
			local pd = self.homeBuildingData:GetPlantDataByDecorateCid(decorateId)

			if pd and pd.landPOD.status == Constant.HomelandPlantType.landStatusIdle then
				plantData = pd

				break
			end
		end

		if plantData == nil then
			NoticeModule.ShowNoticeByType(1, HomeLandPlantUIApi:GetString("ErrorMsg"))

			return
		end

		local haveNum = WarehouseModule.GetItemNumByCfgID(self.plantTipView.selectCfgData.CostItem)

		if haveNum <= 0 then
			NoticeModule.ShowNotice(21040078)

			return
		end

		self.selectPlantData = plantData

		self:PlayPlantEffect(self.plantTipView.selectCfgData, self.selectPlantData.decorateCid)
	end

	self.plantTipView:Close()
end

function HomeLandPlantUI:OnBtnCloseMsgPanel(decorateId)
	self.plantMsgPanelView:Close()
	self.plantDragCellPool[decorateId]:ShowTimeCell(true)
	self.List:SetActive(true)
end

function HomeLandPlantUI:OnSelectTimeCell(decorateId)
	self.selectPlantData = self.homeBuildingData:GetPlantDataByDecorateCid(decorateId)

	self:ShowSelectPlantMsg()
	self.List:SetActive(false)
end

function HomeLandPlantUI:ShowSelectPlantMsg()
	self.plantMsgPanelView:Open()

	if self.selectPlantData then
		self.plantDragCellPool[self.selectPlantData.decorateCid]:ShowTimeCell(false)

		local pos = Vector2.New(self.plantDragCellPool[self.selectPlantData.decorateCid].View.transform.localPosition.x, self.plantDragCellPool[self.selectPlantData.decorateCid].View.transform.localPosition.y)

		self.plantMsgPanelView.TimePanel.transform.localPosition = pos + Vector3.New(0, -50, 0)

		self.plantMsgPanelView:UpdateView(self.homeBuildingData, self.selectPlantData)
	end
end

function HomeLandPlantUI:OnPlant(decorateId, cfgPlantData)
	if self.homeBuildingData ~= nil and cfgPlantData ~= nil then
		self.selectPlantData = self.homeBuildingData:GetPlantDataByDecorateCid(decorateId)

		if self.selectPlantData then
			if self.selectPlantData.landPOD.status ~= Constant.HomelandPlantType.landStatusIdle then
				NoticeModule.ShowNoticeByType(1, HomeLandPlantUIApi:GetString("ErrorMsg"))

				return
			end

			local haveNum = WarehouseModule.GetItemNumByCfgID(cfgPlantData.CostItem)

			if haveNum <= 0 then
				NoticeModule.ShowNotice(21040078)

				return
			end

			self:PlayPlantEffect(cfgPlantData, decorateId)
		end
	end
end

function HomeLandPlantUI:UpdatePlantDragPos()
	for i, v in pairs(self.plantDragCellPool) do
		local plantObj = UnityEngine.GameObject.Find("Root/Castle/Rooms/Room19/Objects/decorate_" .. i .. "/EntityObject_" .. i .. "/Image_centre")

		if plantObj then
			local pos = plantObj.transform.position
			local uiPos = self:ConvertPosToUI(pos)

			v.View.transform.position = uiPos
		end
	end
end

function HomeLandPlantUI:ConvertPosToUI(pos)
	local v_v3 = pos

	if UnityEngine.Camera.main and not LuaCodeInterface.GameObjIsDestroy(UnityEngine.Camera.main) then
		v_v3 = UnityEngine.Camera.main:WorldToScreenPoint(pos)
	end

	local v_ui = self.UICanvas.worldCamera:ScreenToWorldPoint(v_v3)
	local v_new = Vector3(v_ui.x, v_ui.y, self.UICanvas.transform.anchoredPosition3D.z - 1)

	return v_new
end

return HomeLandPlantUI
