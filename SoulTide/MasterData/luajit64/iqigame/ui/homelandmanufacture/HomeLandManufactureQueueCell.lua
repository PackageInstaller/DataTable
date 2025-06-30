-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandManufactureQueueCell.lua

HomeLandManufactureQueueCell = {}

function HomeLandManufactureQueueCell:New(itemCellView)
	local itemCell = Clone(HomeLandManufactureQueueCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandManufactureQueueCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextLock1, HomeLandManufactureUIApi:GetString("TextLock1"))
	UGUIUtil.SetText(self.TextLock2, HomeLandManufactureUIApi:GetString("TextLock2"))
	UGUIUtil.SetText(self.TextToggleNullUp, HomeLandManufactureUIApi:GetString("TextToggleNullUp"))
	UGUIUtil.SetText(self.TextToggleNullDown, HomeLandManufactureUIApi:GetString("TextToggleNullDown"))
	self:AddListener()

	self.timerCD = Timer.New(function()
		self:ShowMakeCD()
	end, 1, -1)
end

function HomeLandManufactureQueueCell:AddListener()
	return
end

function HomeLandManufactureQueueCell:RemoveListener()
	return
end

function HomeLandManufactureQueueCell:SetDate(data)
	self.timerCD:Stop()
	self.Lock:SetActive(not data.unlock)
	self.Unlock:SetActive(data.unlock)

	self.manufactureQueueData = data

	self.Finish:SetActive(false)
	self.Making:SetActive(false)
	self.Null:SetActive(false)

	if self.manufactureQueueData then
		if self.manufactureQueueData.status == 0 then
			self.Null:SetActive(true)
		elseif self.manufactureQueueData.status == 1 then
			self.Making:SetActive(true)
			self:ShowMaking()
			self:ShowMakeCD()

			local cd = self.manufactureQueueData.finishTime - PlayerModule.GetServerTime()

			if cd >= 0 then
				self.timerCD:Start()
			end
		elseif self.manufactureQueueData.status == 2 then
			self.Finish:SetActive(true)
			self:ShowFinish()
		end
	end
end

function HomeLandManufactureQueueCell:ShowFinish()
	local cfgManufactureItem = CfgHomeLandManufactureItemTable[self.manufactureQueueData.cid]
	local cfgItem = CfgItemTable[cfgManufactureItem.GetItem]

	UGUIUtil.SetText(self.TextFinishDown2, cfgItem.Name)
	UGUIUtil.SetText(self.TextFinishUp2, cfgItem.Name)

	local itemCellUp = ItemCell.PackageOrReuseView(self, self.ComSlotFinishUp)

	itemCellUp:SetItem(cfgItem)

	local itemCellDown = ItemCell.PackageOrReuseView(self, self.ComSlotFinishDown)

	itemCellDown:SetItem(cfgItem)
	UGUIUtil.SetText(self.TextFinishDown3, HomeLandManufactureUIApi:GetString("Finish2", cfgManufactureItem.ManufactureType))
	UGUIUtil.SetText(self.TextFinishDown1, HomeLandManufactureUIApi:GetString("Finish3"))
	UGUIUtil.SetText(self.TextFinishUp3, HomeLandManufactureUIApi:GetString("Finish2", cfgManufactureItem.ManufactureType))
	UGUIUtil.SetText(self.TextFinishUp1, HomeLandManufactureUIApi:GetString("Finish3"))
end

function HomeLandManufactureQueueCell:ShowMaking()
	local cfgManufactureItem = CfgHomeLandManufactureItemTable[self.manufactureQueueData.cid]
	local cfgItem = CfgItemTable[cfgManufactureItem.GetItem]

	UGUIUtil.SetText(self.TextMakingDown1, cfgItem.Name)
	UGUIUtil.SetText(self.TextMaking1, cfgItem.Name)

	local itemCellUp = ItemCell.PackageOrReuseView(self, self.ComSlotMaking)

	itemCellUp:SetItem(cfgItem)

	local itemCellDown = ItemCell.PackageOrReuseView(self, self.ComSlotMakingDown)

	itemCellDown:SetItem(cfgItem)
	UGUIUtil.SetText(self.TextMakingDown2, HomeLandManufactureUIApi:GetString("TextMaking2", cfgManufactureItem.ManufactureType))
	UGUIUtil.SetText(self.TextMaking2, HomeLandManufactureUIApi:GetString("TextMaking2", cfgManufactureItem.ManufactureType))
	UGUIUtil.SetText(self.TextMakingDown4, HomeLandManufactureUIApi:GetString("TextMaking4"))
	UGUIUtil.SetText(self.TextMaking4, HomeLandManufactureUIApi:GetString("TextMaking4"))
end

function HomeLandManufactureQueueCell:SetSelect(select)
	self.ToggleNullDown:SetActive(not select)
	self.ToggleNullUp:SetActive(select)
	self.ToggleMakingDown:SetActive(not select)
	self.ToggleMaking:SetActive(select)
	self.ToggleFinishDown:SetActive(not select)
	self.ToggleFinishUp:SetActive(select)
end

function HomeLandManufactureQueueCell:ShowMakeCD()
	local cd = self.manufactureQueueData.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextMakingDown3, GetFormatTime(cd))
		UGUIUtil.SetText(self.TextMaking3, GetFormatTime(cd))
	end
end

function HomeLandManufactureQueueCell:Dispose()
	self:RemoveListener()

	self.manufactureQueueData = nil

	if self.timerCD ~= nil then
		self.timerCD:Stop()

		self.timerCD = nil
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandManufactureQueueCell
