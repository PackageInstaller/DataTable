-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantPutView.lua

local HomeLandPlantPutView = {
	plantItemCells = {}
}
local HomeLandPlantItemCell = require("IQIGame.UI.HomeLandPlant.HomeLandPlantItemCell")

function HomeLandPlantPutView.__New(ui)
	local o = Clone(HomeLandPlantPutView)

	o:InitView(ui)

	return o
end

function HomeLandPlantPutView:InitView(ui)
	self.goView = ui

	self.goView:SetActive(false)
	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextBtnCleanCD, HomeLandPlantUIApi:GetString("TextBtnCleanCD"))
	UGUIUtil.SetText(self.TextCleanUpMsg, HomeLandPlantUIApi:GetString("TextCleanUpMsg"))
	UGUIUtil.SetText(self.TextBtnGetReward, HomeLandPlantUIApi:GetString("TextBtnGetReward"))
	UGUIUtil.SetText(self.TextBtnCleanUp, HomeLandPlantUIApi:GetString("TextBtnCleanUp"))

	self.btnCleanCD = self.BtnCleanCD:GetComponent("Button")
	self.btnCleanUp = self.BtnCleanUp:GetComponent("Button")
	self.btnGetReward = self.BtnGetReward:GetComponent("Button")

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

	self.timerCD = Timer.New(function()
		self:ShowPlantCD()
	end, 1, -1)
end

function HomeLandPlantPutView:AddEventListener()
	self.btnCleanCD.onClick:AddListener(self.delegateBtnCleanCD)
	self.btnCleanUp.onClick:AddListener(self.delegateBtnCleanUp)
	self.btnGetReward.onClick:AddListener(self.delegateBtnGetReward)
end

function HomeLandPlantPutView:RemoveEventListener()
	self.btnCleanCD.onClick:RemoveListener(self.delegateBtnCleanCD)
	self.btnCleanUp.onClick:RemoveListener(self.delegateBtnCleanUp)
	self.btnGetReward.onClick:RemoveListener(self.delegateBtnGetReward)
end

function HomeLandPlantPutView:UpdateView(homeBuildingData, data)
	self.timerCD:Stop()

	self.homeBuildingData = homeBuildingData
	self.plantData = data

	self.Null:SetActive(false)
	self.GrowUp:SetActive(false)
	self.Finish:SetActive(false)

	if self.plantData then
		if self.plantData.landPOD.status == Constant.HomelandPlantType.landStatusIdle then
			self.Null:SetActive(true)
			UGUIUtil.SetText(self.TextNull, HomeLandPlantUIApi:GetString("TextNullPutView"))
		elseif self.plantData.landPOD.status == Constant.HomelandPlantType.landStatusMature then
			self.Finish:SetActive(true)
			UGUIUtil.SetText(self.TextFinishMsg, HomeLandPlantUIApi:GetString("TextFinishMsg"))
			self:ShowItems(self.FinishSort.transform)
		else
			self.GrowUp:SetActive(true)
			UGUIUtil.SetText(self.TextGrowUpMsg, HomeLandPlantUIApi:GetString("TextFinishMsg"))
			self:ShowItems(self.GrowUpSort.transform)
			self:ShowPlantCD()
			self.timerCD:Start()
		end
	end

	if self.homeBuildingData then
		local num, maxNum = self.homeBuildingData:GetHelpTimes()

		UGUIUtil.SetText(self.TextHelpNum, HomeLandPlantUIApi:GetString("TextHelpNum", num, maxNum))
	end
end

function HomeLandPlantPutView:ShowItems(transform)
	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	self.plantItemCells = {}

	if self.plantData.landPOD then
		local cfgPlant = CfgHomeLandPlantTable[self.plantData.landPOD.currentSeedCid]
		local itemId = cfgPlant.DropItem[1]

		if itemId > 0 then
			local obj = UnityEngine.Object.Instantiate(self.Mould)

			obj.transform:SetParent(transform, false)
			obj:SetActive(true)

			local itemCell = HomeLandPlantItemCell:__New(obj)

			itemCell:SetDate(itemId, 1)
			table.insert(self.plantItemCells, itemCell)
		end

		local tab = {}

		for i = 1, #cfgPlant.RandomDropId do
			local dropTab = cfgPlant.RandomDropId[i]

			if #dropTab > 0 then
				local id = dropTab[1]

				if id > 0 and table.indexOf(tab, id) == -1 then
					table.insert(tab, id)

					local obj = UnityEngine.Object.Instantiate(self.Mould)

					obj.transform:SetParent(transform, false)
					obj:SetActive(true)

					local itemCell = HomeLandPlantItemCell:__New(obj)

					itemCell:SetDate(id, 2)
					table.insert(self.plantItemCells, itemCell)
				end
			end
		end
	end
end

function HomeLandPlantPutView:OnBtnGetReward()
	HomeLandLuaModule.HarvestLand(self.plantData.buildingID, self.plantData.landPOD.cid)
end

function HomeLandPlantPutView:OnBtnCleanUp()
	local cfgPlant = CfgHomeLandPlantTable[self.plantData.landPOD.currentSeedCid]

	NoticeModule.ShowNotice(21042013, self.delegateCancelPlant, nil, self)
end

function HomeLandPlantPutView:OnCancelPlant()
	HomeLandLuaModule.CancelPlant(self.plantData.buildingID, self.plantData.plantCid)
end

function HomeLandPlantPutView:OnBtnCleanCD()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[4]
		local spend = math.ceil(cd / value)

		NoticeModule.ShowNoticeBuyConfirm(21042007, self.delegateCompletePlant, nil, self, {
			2
		}, {
			spend
		})
	end
end

function HomeLandPlantPutView:OnCompletePlant()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		HomeLandLuaModule.CompletePlant(self.plantData.buildingID, self.plantData.plantCid, cd + 1)
	end
end

function HomeLandPlantPutView:ShowPlantCD()
	local cd = self.plantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextTimeCD, GetFormatTime(cd))
	end
end

function HomeLandPlantPutView:OnOpen()
	self:AddEventListener()
	self.goView:SetActive(true)
end

function HomeLandPlantPutView:OnClose()
	self:RemoveEventListener()

	if self.timerCD ~= nil then
		self.timerCD:Stop()
	end

	self.goView:SetActive(false)
end

function HomeLandPlantPutView:OnDestroy()
	if self.timerCD ~= nil then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	for i, v in pairs(self.plantItemCells) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandPlantPutView
