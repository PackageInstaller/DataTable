-- chunkname: @IQIGame\\UI\\HomeLandPlant\\HomeLandPlantCell.lua

HomeLandPlantCell = {}

function HomeLandPlantCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_PlantCell == nil then
		ui.__SUB_UI_MAP_PlantCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_PlantCell
	local queueRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		queueRender = HomeLandPlantCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = queueRender
	else
		queueRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return queueRender
end

function HomeLandPlantCell:__New(itemCellView)
	local itemCell = Clone(HomeLandPlantCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandPlantCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	self:AddListener()

	self.timerCD = Timer.New(function()
		self:ShowPlantCD()
	end, 1, -1)
end

function HomeLandPlantCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_PlantCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_PlantCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_PlantCell = nil
end

function HomeLandPlantCell:AddListener()
	return
end

function HomeLandPlantCell:RemoveListener()
	return
end

function HomeLandPlantCell:SetDate(data)
	self.homeLandPlantData = data

	self.timerCD:Stop()
	self.Null:SetActive(false)
	self.GrowUp:SetActive(false)
	self.Finish:SetActive(false)

	if self.homeLandPlantData then
		if self.homeLandPlantData.landPOD.status == Constant.HomelandPlantType.landStatusIdle then
			self.Null:SetActive(true)
			UGUIUtil.SetText(self.TextNullDown, HomeLandPlantUIApi:GetString("TextNull"))
			UGUIUtil.SetText(self.TextNullUp, HomeLandPlantUIApi:GetString("TextNull"))
		elseif self.homeLandPlantData.landPOD.status == Constant.HomelandPlantType.landStatusMature then
			self.Finish:SetActive(true)
			self:ShowFinish()
		else
			self.GrowUp:SetActive(true)
			self:ShowGrowUp()
		end
	end
end

function HomeLandPlantCell:ShowFinish()
	if self.homeLandPlantData.landPOD then
		local cfgPlant = CfgHomeLandPlantTable[self.homeLandPlantData.landPOD.currentSeedCid]
		local cfgItem = CfgItemTable[cfgPlant.PlantItem]

		UGUIUtil.SetText(self.TextFinishDown1, cfgItem.Name)
		UGUIUtil.SetText(self.TextFinishUp1, cfgItem.Name)

		local itemCellUp = ItemCell.PackageOrReuseView(self, self.ComSlotFinishUp)

		itemCellUp:SetItem(cfgItem)

		local itemCellDown = ItemCell.PackageOrReuseView(self, self.ComSlotFinishDown)

		itemCellDown:SetItem(cfgItem)
	end

	UGUIUtil.SetText(self.TextFinishDown2, HomeLandPlantUIApi:GetString("TextFinish2"))
	UGUIUtil.SetText(self.TextFinishDown3, HomeLandPlantUIApi:GetString("TextFinish3"))
	UGUIUtil.SetText(self.TextFinishUp2, HomeLandPlantUIApi:GetString("TextFinish2"))
	UGUIUtil.SetText(self.TextFinishUp3, HomeLandPlantUIApi:GetString("TextFinish3"))
end

function HomeLandPlantCell:ShowGrowUp()
	if self.homeLandPlantData.landPOD then
		local cfgPlant = CfgHomeLandPlantTable[self.homeLandPlantData.landPOD.currentSeedCid]
		local cfgItem = CfgItemTable[cfgPlant.PlantItem]

		UGUIUtil.SetText(self.TextGrowUpDown1, cfgItem.Name)
		UGUIUtil.SetText(self.TextGrowUp1, cfgItem.Name)

		local itemCellUp = ItemCell.PackageOrReuseView(self, self.ComSlotGrowUp)

		itemCellUp:SetItem(cfgItem)

		local itemCellDown = ItemCell.PackageOrReuseView(self, self.ComSlotGrowUpDown)

		itemCellDown:SetItem(cfgItem)
		self:ShowPlantCD()
		self.timerCD:Start()
	end

	UGUIUtil.SetText(self.TextGrowUpDown2, HomeLandPlantUIApi:GetString("TextGrowUp2"))
	UGUIUtil.SetText(self.TextGrowUp2, HomeLandPlantUIApi:GetString("TextGrowUp2"))
end

function HomeLandPlantCell:SetSelect(select)
	self.ToggleNullDown:SetActive(not select)
	self.ToggleNullUp:SetActive(select)
	self.ToggleGrowUpDown:SetActive(not select)
	self.ToggleGrowUp:SetActive(select)
	self.ToggleFinishDown:SetActive(not select)
	self.ToggleFinishUp:SetActive(select)
end

function HomeLandPlantCell:ShowPlantCD()
	local cd = self.homeLandPlantData.landPOD.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextGrowUpDown3, GetFormatTime(cd))
		UGUIUtil.SetText(self.TextGrowUp3, GetFormatTime(cd))
	end
end

function HomeLandPlantCell:Dispose()
	self:RemoveListener()

	self.cookingQueueData = nil

	if self.timerCD ~= nil then
		self.timerCD:Stop()

		self.timerCD = nil
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandPlantCell
