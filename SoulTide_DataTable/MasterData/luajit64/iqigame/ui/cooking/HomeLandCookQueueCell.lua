-- chunkname: @IQIGame\\UI\\Cooking\\HomeLandCookQueueCell.lua

HomeLandCookQueueCell = {}

function HomeLandCookQueueCell:New(itemCellView)
	local itemCell = Clone(HomeLandCookQueueCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandCookQueueCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextToggleNullDown, HomeLandCookingUIApi:GetString("TextToggleNullDown"))
	UGUIUtil.SetText(self.TextToggleNullUp, HomeLandCookingUIApi:GetString("TextToggleNullUp"))
	self:AddListener()

	self.timerCD = Timer.New(function()
		self:ShowCookingCD()
	end, 1, -1)
end

function HomeLandCookQueueCell:AddListener()
	return
end

function HomeLandCookQueueCell:RemoveListener()
	return
end

function HomeLandCookQueueCell:SetDate(data)
	self.timerCD:Stop()
	self.Lock:SetActive(not data.unlock)
	self.Unlock:SetActive(data.unlock)

	self.cookingQueueData = data

	self.Finish:SetActive(false)
	self.Making:SetActive(false)
	self.Null:SetActive(false)

	local itemData, itemDownObj, itemUpObj
	local isLock = false
	local menuDataID
	local isShowItem = true

	if data.cid ~= nil and data.cid ~= "" then
		local itemID = CfgCookCombinationTable[data.cid].ItemId[1]

		itemData = CfgItemTable[itemID]

		local cookingMenuData = CookingModule.GetMenuDataByID(data.cid)

		isLock = cookingMenuData.unlock
		menuDataID = cookingMenuData.cid
	end

	if self.cookingQueueData.unlock then
		if self.cookingQueueData.status == 0 then
			self.Null:SetActive(true)
		elseif self.cookingQueueData.status == 1 then
			self.Making:SetActive(true)

			itemDownObj = self.CommonSlotMakingDown
			itemUpObj = self.CommonSlotMaking

			local cd = self.cookingQueueData.finishTime - PlayerModule.GetServerTime()

			UGUIUtil.SetText(self.TextMakingDown3, HomeLandCookingUIApi:GetString("TextNow3"))
			UGUIUtil.SetText(self.TextMaking3, HomeLandCookingUIApi:GetString("TextNow3"))

			if itemData and isLock then
				UGUIUtil.SetText(self.TextMakingDown1, HomeLandCookingUIApi:GetString("TextMakingName", itemData.Name, self.cookingQueueData:CookingNum()))
				UGUIUtil.SetText(self.TextMaking1, HomeLandCookingUIApi:GetString("TextMakingName", itemData.Name, self.cookingQueueData:CookingNum()))
				UGUIUtil.SetText(self.TextMakingDown2, GetFormatTime(cd))
				UGUIUtil.SetText(self.TextMaking2, GetFormatTime(cd))

				if cd > 0 then
					self.timerCD:Start()
				end

				isShowItem = true
			else
				isShowItem = false

				UGUIUtil.SetText(self.TextMakingDown1, HomeLandCookingUIApi:GetString("TextUnLock"))
				UGUIUtil.SetText(self.TextMaking1, HomeLandCookingUIApi:GetString("TextUnLock"))
				UGUIUtil.SetText(self.TextMakingDown2, HomeLandCookingUIApi:GetString("TextUnlockTime"))
				UGUIUtil.SetText(self.TextMaking2, HomeLandCookingUIApi:GetString("TextUnlockTime"))
			end

			self.SlotMaking:SetActive(not isShowItem)
			self.SlotMakingDown:SetActive(not isShowItem)
			self.CommonSlotMakingDown:SetActive(isShowItem)
			self.CommonSlotMaking:SetActive(isShowItem)
		elseif self.cookingQueueData.status == 2 then
			self.Finish:SetActive(true)

			itemDownObj = self.CommonSlotFinishDown
			itemUpObj = self.CommonSlotFinishUp

			UGUIUtil.SetText(self.TextFinishUp2, "")
			UGUIUtil.SetText(self.TextFinishDown2, "")
			UGUIUtil.SetText(self.TextFinishUp1, HomeLandCookingUIApi:GetString("TextFinish3"))
			UGUIUtil.SetText(self.TextFinishDown1, HomeLandCookingUIApi:GetString("TextFinish3"))

			if itemData then
				UGUIUtil.SetText(self.TextFinishUp2, itemData.Name)
				UGUIUtil.SetText(self.TextFinishDown2, itemData.Name)
			end
		end

		if itemDownObj ~= nil and isShowItem then
			local itemCell = ItemCell.PackageOrReuseView(self, itemDownObj, false)

			itemCell:SetItem(itemData)
		end

		if itemUpObj ~= nil and isShowItem then
			local itemCell = ItemCell.PackageOrReuseView(self, itemUpObj, false)

			itemCell:SetItem(itemData)
		end
	else
		UGUIUtil.SetText(self.TextLock1, HomeLandCookingUIApi:GetString("TextLock1"))
		UGUIUtil.SetText(self.TextLock2, HomeLandCookingUIApi:GetString("TextLock2"))
	end
end

function HomeLandCookQueueCell:SetSelect(select)
	if self.cookingQueueData and self.cookingQueueData.unlock then
		self.ToggleNullDown:SetActive(not select)
		self.ToggleNullUp:SetActive(select)
		self.ToggleMakingDown:SetActive(not select)
		self.ToggleMaking:SetActive(select)
		self.ToggleFinishDown:SetActive(not select)
		self.ToggleFinishUp:SetActive(select)
	end
end

function HomeLandCookQueueCell:ShowCookingCD()
	local cd = self.cookingQueueData.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextMakingDown2, GetFormatTime(cd))
		UGUIUtil.SetText(self.TextMaking2, GetFormatTime(cd))
	end
end

function HomeLandCookQueueCell:Dispose()
	self:RemoveListener()

	self.cookingQueueData = nil

	if self.timerCD ~= nil then
		self.timerCD:Stop()

		self.timerCD = nil
	end

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandCookQueueCell
