-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantMsgPanelView.lua

local HomeLandPlantMsgPanelView = {
	plantItemCells = {}
}
local HomeLandPlantItemCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantItemCell")

function HomeLandPlantMsgPanelView.New(view, RewardMould)
	local obj = Clone(HomeLandPlantMsgPanelView)

	obj:Init(view, RewardMould)

	return obj
end

function HomeLandPlantMsgPanelView:Init(view, RewardMould)
	self.View = view
	self.RewardMould = RewardMould

	LuaCodeInterface.BindOutlet(self.View, self)
	UGUIUtil.SetText(self.TextBtnCleanCD, HomeLandPlantUIApi:GetString("TextBtnCleanCD"))
	UGUIUtil.SetText(self.TextBtnGetReward, HomeLandPlantUIApi:GetString("TextBtnGetReward"))
	UGUIUtil.SetText(self.TextBtnCleanUp, HomeLandPlantUIApi:GetString("TextBtnCleanUp"))

	self.btnCleanCD = self.BtnCleanCD:GetComponent("Button")
	self.btnCleanUp = self.BtnCleanUp:GetComponent("Button")
	self.btnGetReward = self.BtnGetReward:GetComponent("Button")
	self.btnCloseTimeView = self.BtnCloseTimeView:GetComponent("Button")

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	function self.delegateBtnCleanCD()
		self:OnBtnCleanCD()
	end

	function self.delegateBtnCleanUp()
		self:OnBtnCleanUp()
	end

	function self.delegateCompletePlant()
		self:OnCompletePlant()
	end

	function self.delegateCancelPlant()
		self:OnCancelPlant()
	end

	function self.delegateBtnCloseTimeView()
		self:OnBtnCloseTimeView()
	end

	self.timerCD = Timer.New(function()
		self:ShowPlantCD()
	end, 1, -1)

	self:AddEventListener()
end

function HomeLandPlantMsgPanelView:AddEventListener()
	self.btnCleanCD.onClick:AddListener(self.delegateBtnCleanCD)
	self.btnCleanUp.onClick:AddListener(self.delegateBtnCleanUp)
	self.btnGetReward.onClick:AddListener(self.delegateBtnGetReward)
	self.btnCloseTimeView.onClick:AddListener(self.delegateBtnCloseTimeView)
end

function HomeLandPlantMsgPanelView:RemoveEventListener()
	self.btnCleanCD.onClick:RemoveListener(self.delegateBtnCleanCD)
	self.btnCleanUp.onClick:RemoveListener(self.delegateBtnCleanUp)
	self.btnGetReward.onClick:RemoveListener(self.delegateBtnGetReward)
	self.btnCloseTimeView.onClick:RemoveListener(self.delegateBtnCloseTimeView)
end

function HomeLandPlantMsgPanelView:UpdateView(homeBuildingData, data)
	self.timerCD:Stop()

	self.homeBuildingData = homeBuildingData
	self.plantData = data
	self.selectCfgData = CfgHomeLandPlantTable[self.plantData.landPOD.currentSeedCid]

	self.BtnCleanCD:SetActive(false)
	self.BtnCleanUp:SetActive(false)
	self.BtnGetReward:SetActive(false)

	if self.plantData then
		if self.plantData.landPOD.status == Constant.HomelandPlantType.landStatusIdle then
			UGUIUtil.SetText(self.TextTimeCD, "")
		elseif self.plantData.landPOD.status == Constant.HomelandPlantType.landStatusMature then
			self.BtnGetReward:SetActive(true)
			UGUIUtil.SetText(self.TextTimeCD, HomeLandPlantUIApi:GetString("TextFinish3"))
		else
			self.BtnCleanCD:SetActive(true)
			self.BtnCleanUp:SetActive(true)
			self:ShowPlantCD()
			self.timerCD:Start()
		end

		self:ShowItems()
	end
end

function HomeLandPlantMsgPanelView:ShowItems()
	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	self.plantItemCells = {}

	local itemId = self.selectCfgData.DropItem[1]

	if itemId > 0 then
		local obj = UnityEngine.Object.Instantiate(self.RewardMould)

		obj.transform:SetParent(self.RewardSlot.transform, false)
		obj:SetActive(true)

		local itemCell = HomeLandPlantItemCell:__New(obj)

		itemCell:SetDate(itemId, 1)
		table.insert(self.plantItemCells, itemCell)
	end

	local tab = {}

	for i = 1, #self.selectCfgData.RandomDropId do
		local dropTab = self.selectCfgData.RandomDropId[i]
		local isTimeout = false

		if cfgDateTimeToTimeStamp(self.selectCfgData.RandomDropStartTime[i]) < PlayerModule.GetServerTime() and cfgDateTimeToTimeStamp(self.selectCfgData.RandomDropEndTime[i]) > PlayerModule.GetServerTime() then
			isTimeout = true
		end

		if #dropTab > 0 and isTimeout then
			local id = dropTab[1]

			if id > 0 and table.indexOf(tab, id) == -1 then
				table.insert(tab, id)

				local obj = UnityEngine.Object.Instantiate(self.RewardMould)

				obj.transform:SetParent(self.RewardSlot.transform, false)
				obj:SetActive(true)

				local itemCell = HomeLandPlantItemCell:__New(obj)

				itemCell:SetDate(id, 2)
				table.insert(self.plantItemCells, itemCell)
			end
		end
	end
end

function HomeLandPlantMsgPanelView:ShowPlantCD()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, GetFormatTime(cd))
	end
end

function HomeLandPlantMsgPanelView:OnBtnGetReward()
	HomeLandLuaModule.HarvestLand(self.plantData.buildingID, self.plantData.landPOD.cid)
end

function HomeLandPlantMsgPanelView:OnBtnCleanUp()
	NoticeModule.ShowNotice(21042013, self.delegateCancelPlant, nil, self)
end

function HomeLandPlantMsgPanelView:OnCancelPlant()
	HomeLandLuaModule.CancelPlant(self.plantData.buildingID, self.plantData.plantCid)
end

function HomeLandPlantMsgPanelView:OnBtnCleanCD()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[4]

		self.spend = math.ceil(cd / value)

		local cfgPlant = CfgHomeLandPlantTable[self.plantData.landPOD.currentSeedCid]
		local itemName = CfgItemTable[cfgPlant.PlantItem].Name

		NoticeModule.ShowNoticeBuyConfirm(21042007, self.delegateCompletePlant, nil, self, {
			Constant.ItemID.TREASURE
		}, {
			self.spend
		}, itemName)
	end
end

function HomeLandPlantMsgPanelView:OnCompletePlant()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local have = WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE)

		if have < self.spend then
			NoticeModule.MoneyDeficitTip(1, self.spend - have)

			return
		end

		HomeLandLuaModule.CompletePlant(self.plantData.buildingID, self.plantData.plantCid, cd + 1)
	end
end

function HomeLandPlantMsgPanelView:OnBtnCloseTimeView()
	if self.closeCallBack then
		self.closeCallBack(self.plantData.decorateCid)
	end
end

function HomeLandPlantMsgPanelView:Open()
	self.View:SetActive(true)
end

function HomeLandPlantMsgPanelView:Close()
	self.View:SetActive(false)
end

function HomeLandPlantMsgPanelView:Dispose()
	self:RemoveEventListener()

	self.closeCallBack = nil

	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return HomeLandPlantMsgPanelView
