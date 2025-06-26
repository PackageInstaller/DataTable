-- chunkname: @IQIGame\\UI\\HomeLandManufacture\\HomeLandManufactureView.lua

local HomeLandManufactureView = {}

function HomeLandManufactureView.__New(ui, parent)
	local o = Clone(HomeLandManufactureView)

	o:InitView(ui, parent)

	return o
end

function HomeLandManufactureView:InitView(ui, parent)
	self.goView = ui

	self.goView:SetActive(false)

	self.parent = parent

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.TextBtnCleanCD, HomeLandManufactureUIApi:GetString("TextBtnCleanCD"))

	self.btnCleanCD = self.BtnCleanCD:GetComponent("Button")
	self.btnGetReward = self.BtnGetReward:GetComponent("Button")
	self.btnManufacture = self.BtnManufacture:GetComponent("Button")

	function self.delegateBtnGetReward()
		self:OnBtnGetReward()
	end

	function self.delegateBtnCleanCD()
		self:OnBtnCleanCD()
	end

	function self.delegateCompleteMake()
		self:OnCompleteMake()
	end

	function self.delegateCancelMake()
		self:OnCancelMake()
	end

	function self.delegateBtnManufacture()
		self:OnBtnManufacture()
	end

	self.timerCD = Timer.New(function()
		self:ShowMakingCD()
	end, 1, -1)
end

function HomeLandManufactureView:AddEventListener()
	self.btnGetReward.onClick:AddListener(self.delegateBtnGetReward)
	self.btnCleanCD.onClick:AddListener(self.delegateBtnCleanCD)
	self.btnManufacture.onClick:AddListener(self.delegateBtnManufacture)
end

function HomeLandManufactureView:RemoveEventListener()
	self.btnGetReward.onClick:RemoveListener(self.delegateBtnGetReward)
	self.btnCleanCD.onClick:RemoveListener(self.delegateBtnCleanCD)
	self.btnManufacture.onClick:RemoveListener(self.delegateBtnManufacture)
end

function HomeLandManufactureView:UpdateView(data, buildingCid)
	self.timerCD:Stop()

	self.makeQueueData = data
	self.buildingCid = buildingCid

	self.Null:SetActive(false)
	self.Making:SetActive(false)
	self.Finish:SetActive(false)
	self.Bg:SetActive(true)

	if self.makeQueueData then
		if self.makeQueueData.status == 0 then
			self.FinishSort:SetActive(false)
			self.Null:SetActive(true)
			self.Bg:SetActive(false)
			self:ShowNull()
		elseif self.makeQueueData.status == 1 then
			self.Making:SetActive(true)
			self:ShowMaking()
		elseif self.makeQueueData.status == 2 then
			self.Finish:SetActive(true)
			self.FinishSort:SetActive(true)

			local cfgManufactureItem = CfgHomeLandManufactureItemTable[self.makeQueueData.cid]
			local cfgItem = CfgItemTable[cfgManufactureItem.GetItem]
			local itemCell = ItemCell.PackageOrReuseView(self, self.FinishSort.transform:GetChild(0).gameObject)

			itemCell:SetItem(cfgItem)
			UGUIUtil.SetText(self.TextBtnGetReward, HomeLandManufactureUIApi:GetString("TextBtnGetReward"))
		end
	end
end

function HomeLandManufactureView:ShowNull()
	return
end

function HomeLandManufactureView:ShowMaking()
	self.timerCD:Stop()
	self.FinishSort:SetActive(true)

	local cfgManufactureItem = CfgHomeLandManufactureItemTable[self.makeQueueData.cid]
	local cfgItem = CfgItemTable[cfgManufactureItem.GetItem]
	local itemCell = ItemCell.PackageOrReuseView(self, self.FinishSort.transform:GetChild(0).gameObject)

	itemCell:SetItem(cfgItem)
	self.BtnCleanCD:SetActive(false)

	if self.makeQueueData.status == 0 then
		UGUIUtil.SetText(self.TextMakingCD, GetFormatTime(cfgManufactureItem.ShowNeedTime))
	elseif self.makeQueueData.status == 1 then
		self.BtnCleanCD:SetActive(true)
		self:ShowMakingCD()

		local cd = self.makeQueueData.finishTime - PlayerModule.GetServerTime()

		if cd > 0 then
			self.timerCD:Start()
		end
	end
end

function HomeLandManufactureView:ShowMakingCD()
	local cd = self.makeQueueData.finishTime - PlayerModule.GetServerTime()

	if cd >= 0 then
		UGUIUtil.SetText(self.TextMakingCD, GetFormatTime(cd))
	end
end

function HomeLandManufactureView:OnBtnGetReward()
	HomeLandManufactureMould.RewardMake(self.buildingCid, self.makeQueueData.id)
end

function HomeLandManufactureView:OnCancelMake()
	HomeLandManufactureMould.CancelMake(self.buildingCid, self.makeQueueData.id)
end

function HomeLandManufactureView:OnBtnCleanCD()
	local cd = self.makeQueueData.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[2]
		local spend = math.ceil(cd / value)
		local itemName = ""

		if self.makeQueueData.cid ~= nil and self.makeQueueData.cid ~= "" then
			local cfgManufactureItem = CfgHomeLandManufactureItemTable[self.makeQueueData.cid]

			itemName = CfgItemTable[cfgManufactureItem.GetItem].Name
		end

		NoticeModule.ShowNoticeBuyConfirm(21042006, self.delegateCompleteMake, nil, self, {
			2
		}, {
			spend
		}, itemName)
	end
end

function HomeLandManufactureView:OnCompleteMake()
	local cd = self.makeQueueData.finishTime - PlayerModule.GetServerTime()

	if cd > 0 then
		local value = CfgDiscreteDataTable[6520009].Data[2]
		local spend = math.ceil(cd / value)
		local isItemEnough = spend <= WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE)

		if not isItemEnough then
			NoticeModule.MoneyDeficitTip(1, spend - WarehouseModule.GetItemNumByCfgID(Constant.ItemID.TREASURE))

			return
		end

		HomeLandManufactureMould.CompleteMake(self.buildingCid, self.makeQueueData.id, cd + 1)
	end
end

function HomeLandManufactureView:OnBtnManufacture()
	self.parent:OnBtnManufacture()
end

function HomeLandManufactureView:OnOpen()
	self:AddEventListener()
	self.goView:SetActive(true)
end

function HomeLandManufactureView:OnClose()
	self:RemoveEventListener()
	self.goView:SetActive(false)
end

function HomeLandManufactureView:OnDestroy()
	if self.timerCD then
		self.timerCD:Stop()
	end

	self.timerCD = nil

	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

return HomeLandManufactureView
