-- chunkname: @IQIGame\\UI\\HomeLandOverview\\HomeLandOverviewRenderCell.lua

HomeLandOverviewRenderCell = {}

function HomeLandOverviewRenderCell:New(itemCellView)
	local itemCell = Clone(HomeLandOverviewRenderCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function HomeLandOverviewRenderCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.Text_Lock1, HomeLandOverviewUIApi:GetString("Text_Lock1"))
	UGUIUtil.SetText(self.TextBtnGetReward, HomeLandOverviewUIApi:GetString("TextBtnGetReward"))
	UGUIUtil.SetText(self.TextBtnLook, HomeLandOverviewUIApi:GetString("TextBtnLook"))

	self.btnGetReward = self.Btn_GetReward:GetComponent("Button")
	self.btnLook = self.Btn_Look:GetComponent("Button")

	function self.delegateBtnReward()
		self:OnBtnReward()
	end

	function self.delegateBtnLook()
		self:OnBtnLook()
	end

	function self.delegateHomeUpdateBuildingEvent(cfgBuildingID)
		self:OnHomeUpdateBuildingEvent(cfgBuildingID)
	end

	self.timer = Timer.New(function()
		self:UpdateTime()
	end, 1, -1)

	self.timer:Start()
	self:AddListener()
end

function HomeLandOverviewRenderCell:AddListener()
	self.btnLook.onClick:AddListener(self.delegateBtnLook)
	self.btnGetReward.onClick:AddListener(self.delegateBtnReward)
	EventDispatcher.AddEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandOverviewRenderCell:RemoveListener()
	self.btnLook.onClick:RemoveListener(self.delegateBtnLook)
	self.btnGetReward.onClick:RemoveListener(self.delegateBtnReward)
	EventDispatcher.RemoveEventListener(EventID.HomeUpdateBuildingEvent, self.delegateHomeUpdateBuildingEvent)
end

function HomeLandOverviewRenderCell:SetDate(data)
	self.homelandBuildType = data
	self.buildingData = HomeLandLuaModule.GetBuildingDataByID(self.homelandBuildType)

	local cfgHomeLandBuilding = CfgHomeLandBuildingTable[self.homelandBuildType]
	local cfgRoom = CfgHomeLandRoomTable[cfgHomeLandBuilding.BelongRoom]

	UGUIUtil.SetText(self.Text_Lock2, HomeLandOverviewUIApi:GetString("Text_Lock2", cfgRoom.Name))
	self:UpdateView()
end

function HomeLandOverviewRenderCell:OnHomeUpdateBuildingEvent(cfgBuildingID)
	if self.buildingData ~= nil and self.buildingData.buildingPOD.cid == cfgBuildingID then
		self.buildingData = HomeLandLuaModule.GetBuildingDataByID(cfgBuildingID)

		self:UpdateView()
	end
end

function HomeLandOverviewRenderCell:UpdateView()
	local isEmptyQueue = false
	local isOpen = self.buildingData ~= nil

	self.Lock:SetActive(not isOpen)
	self.Unlock:SetActive(isOpen)
	self.Num:SetActive(false)

	local isShowBtnGift = false
	local isShowBtnGetReward = false

	self.TextTime:SetActive(false)
	self.TextSort:SetActive(false)
	self.Slider:SetActive(false)

	if self.buildingData ~= nil then
		isEmptyQueue = self.buildingData:IsEmptyQueue()
		isShowBtnGetReward = self.buildingData:IsGetReward()

		if self.homelandBuildType == Constant.HomelandBuildType.BuildBackGift then
			local backGiftNum = HomeLandLuaModule.BackGiftNum()

			isShowBtnGift = backGiftNum > 0

			self.Num:SetActive(backGiftNum > 0)
			UGUIUtil.SetText(self.TextNum, tostring(backGiftNum))
			self.TextSort:SetActive(isShowBtnGift)
			UGUIUtil.SetText(self.TextSort, HomeLandOverviewUIApi:GetString("TextSortGift"))
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildGold then
			local productionPOD = self.buildingData.buildingPOD.productionData
			local num = 0

			if productionPOD ~= nil then
				for i, v in pairs(productionPOD.output) do
					num = num + v
				end
			end

			isShowBtnGetReward = num > 0

			self.TextTime:SetActive(true)
			self.TextSort:SetActive(true)
			self.Slider:SetActive(true)
			self:UpdateTime()
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildManufacture then
			self.TextSort:SetActive(true)

			local queueData, maxCD = HomeLandManufactureMould.GetLongTimeQueue()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeManufacture", GetFormatTime(maxCD)))
			end

			UGUIUtil.SetText(self.TextSort, HomeLandOverviewUIApi:GetString("TextSortManufacture", HomeLandManufactureMould.workingQueueCount, HomeLandManufactureMould.maxQueueCount))
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildCooking then
			self.TextSort:SetActive(true)
			UGUIUtil.SetText(self.TextSort, HomeLandOverviewUIApi:GetString("TextSortCooking", CookingModule.workingQueueCount, CookingModule.maxQueueCount))

			local queueData, maxCD = CookingModule.GetLongTimeQueue()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeCooking", GetFormatTime(maxCD)))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildPlant then
			self.TextSort:SetActive(true)

			local plantMaxNum = #self.buildingData.plantDataTab
			local plantData, maxCD, workIngPlantNum = self.buildingData:GetBuildingPlantMsg()

			UGUIUtil.SetText(self.TextSort, HomeLandOverviewUIApi:GetString("TextSortPlant", workIngPlantNum, plantMaxNum))

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimePlant", GetFormatTime(maxCD)))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildWork then
			self.TextSort:SetActive(true)

			local hlWorkData = self.buildingData.workData
			local workingNum = hlWorkData:GetWorkingCount()
			local maxNum = hlWorkData:GetUnlockCount()

			UGUIUtil.SetText(self.TextSort, HomeLandOverviewUIApi:GetString("TextSortWork", workingNum, maxNum))

			local maxCD = hlWorkData:GetMaxResidueTime()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeWork", GetFormatTime(maxCD)))
			end
		end
	end

	UGUIUtil.SetText(self.TextTitleState, HomeLandOverviewUIApi:GetString("TextTitleState", isEmptyQueue, self.homelandBuildType))
	self:SetBg(isOpen, isEmptyQueue)

	local cfgHomeLandBuilding = CfgHomeLandBuildingTable[self.homelandBuildType]

	UGUIUtil.SetText(self.TextName, HomeLandOverviewUIApi:GetString("TextName", isOpen, cfgHomeLandBuilding.Name))
	AssetUtil.LoadImage(self, HomeLandChooseCastleApi:GetString("ImgBtnFunctionPath", self.homelandBuildType), self.ImgIcon:GetComponent("Image"))
	self.Btn_GetReward:SetActive(isShowBtnGetReward)
	self.Btn_Look:SetActive(isShowBtnGift)
end

function HomeLandOverviewRenderCell:GetCurrentNum(productionPOD)
	local num = 0

	for i, v in pairs(productionPOD.output) do
		num = num + v
	end

	return num
end

function HomeLandOverviewRenderCell:UpdateTime()
	if self.buildingData then
		if self.homelandBuildType == Constant.HomelandBuildType.BuildGold then
			local productionPOD = self.buildingData.buildingPOD.productionData
			local num = self:GetCurrentNum(productionPOD)
			local per = num / productionPOD.storageLimit

			self.ImgProgress:GetComponent("Image").fillAmount = per

			UGUIUtil.SetText(self.TextSort, HomeLandAlchemyUIApi:GetString("TextMax", num, productionPOD.storageLimit))

			local speed = self.buildingData.buildingPOD.productionData.oneProduceTime / CfgHomeLandProductionTable[36100001].ProduceItemNum[1]
			local nowTime = PlayerModule.GetServerTime()
			local endTime = self.buildingData.buildingPOD.productionData.nextProduceTime
			local passTime = speed * num + (self.buildingData.buildingPOD.productionData.oneProduceTime - (endTime - nowTime))
			local totalTime = speed * productionPOD.storageLimit
			local cd = totalTime - passTime

			if cd > 0 then
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeGold", GetFormatTime(cd)))
			else
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeGoldMax"))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildManufacture then
			local queueData, maxCD = HomeLandManufactureMould.GetLongTimeQueue()

			if maxCD > 0 then
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeManufacture", GetFormatTime(maxCD)))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildCooking then
			local queueData, maxCD = CookingModule.GetLongTimeQueue()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeCooking", GetFormatTime(maxCD)))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildPlant then
			local plantData, maxCD, workIngPlantNum = self.buildingData:GetBuildingPlantMsg()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimePlant", GetFormatTime(maxCD)))
			end
		elseif self.homelandBuildType == Constant.HomelandBuildType.BuildWork then
			local maxCD = self.buildingData.workData:GetMaxResidueTime()

			if maxCD > 0 then
				self.TextTime:SetActive(true)
				UGUIUtil.SetText(self.TextTime, HomeLandOverviewUIApi:GetString("TextTimeWork", GetFormatTime(maxCD)))
			end
		end
	end
end

function HomeLandOverviewRenderCell:SetBg(isOpen, isEmptyQueue)
	self.Bg_Gift:SetActive(false)
	self.Bg_Lock:SetActive(false)
	self.Bg_Free:SetActive(false)
	self.Bg_Working:SetActive(false)

	if not isOpen then
		self.Bg_Lock:SetActive(true)
	elseif self.homelandBuildType == Constant.HomelandBuildType.BuildBackGift then
		self.Bg_Gift:SetActive(true)
	else
		self.Bg_Free:SetActive(isEmptyQueue)
		self.Bg_Working:SetActive(not isEmptyQueue)
	end
end

function HomeLandOverviewRenderCell:OnBtnReward()
	if self.homelandBuildType == Constant.HomelandBuildType.BuildPlant then
		HomeLandLuaModule.HarvestLand(Constant.HomelandBuildType.BuildPlant, -1)
	elseif self.homelandBuildType == Constant.HomelandBuildType.BuildGold then
		HomeLandLuaModule.HarvestBuilding(Constant.HomelandBuildType.BuildGold)
	elseif self.homelandBuildType == Constant.HomelandBuildType.BuildManufacture then
		HomeLandManufactureMould.RewardMake(Constant.HomelandBuildType.BuildManufacture, -1)
	elseif self.homelandBuildType == Constant.HomelandBuildType.BuildCooking then
		HomeLandLuaModule.RewardCook(Constant.HomelandBuildType.BuildCooking, -1)
	elseif self.homelandBuildType == Constant.HomelandBuildType.BuildWork then
		HLWorkModule.ReqGetReward(Constant.HomelandBuildType.BuildWork, -1)
	end
end

function HomeLandOverviewRenderCell:OnBtnLook()
	UIModule.Open(Constant.UIControllerName.HomeLandGirlRewardUI, Constant.UILayer.UI)
end

function HomeLandOverviewRenderCell:Dispose()
	self.timer:Stop()

	self.timer = nil

	self:RemoveListener()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.GameObject.Destroy(self.goView)

	self.goView = nil
end

return HomeLandOverviewRenderCell
