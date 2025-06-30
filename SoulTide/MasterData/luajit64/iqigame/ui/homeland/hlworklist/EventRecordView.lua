-- chunkname: @IQIGame\\UI\\HomeLand\\HLWorkList\\EventRecordView.lua

local EventRecordView = {
	cellPool = {},
	itemCellPool = {}
}

function EventRecordView.New(view)
	local obj = Clone(EventRecordView)

	obj:Init(view)

	return obj
end

function EventRecordView:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)
	self.goDescCell:SetActive(false)

	self.scrollRect = self.goScrollRect:GetComponent("ScrollRect")

	for i = 1, 3 do
		local go = self.goCellParent.transform:Find("Mould_" .. i):GetChild(0).gameObject

		self.itemCellPool[i] = ItemCell.PackageOrReuseView(self, go, true, true)
	end

	self.tfFinishDesc = self.goFinishDesc:GetComponent("Text")
	self.tfWorkName = self.goWorkName:GetComponent("Text")
	self.tfWorkDesc = self.goWorkDesc:GetComponent("Text")
	self.btnClose = self.goBtnClose:GetComponent("Button")
	self.btnDelete = self.goBtnDelete:GetComponent("Button")

	function self.onClickBtnCloseDelegate()
		self:OnClickBtnClose()
	end

	function self.onClickBtnDeleteDelegate()
		self:OnClickBtnDelete()
	end

	self:OnAddListeners()

	self.goBtnDelete.transform:Find("Text"):GetComponent("Text").text = HomeLandWorkListUIApi:GetString("eventViewBtnDeleteTxt")
	self.goEventTitle:GetComponent("Text").text = HomeLandWorkRoomUIApi:GetString("title2")
	self.goRewardTitle:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("eventViewRewardTitle")
	self.goRewardTitle2:GetComponent("Text").text = HomeLandWorkListUIApi:GetString("eventViewRewardTitle2")
end

function EventRecordView:Open(cfgAffairData, eventDataList, rewardDataList, isPerfect, affairId)
	self.cfgAffairData = cfgAffairData
	self.eventDataList = eventDataList
	self.rewardDataList = rewardDataList
	self.isPerfect = isPerfect
	self.affairId = affairId

	self.View:SetActive(true)
	self.goWorkRecordBlock:SetActive(false)
	self:RefreshMisc()
	self:RefreshEventBlock()
	self:RefreshRewardBlock()
end

function EventRecordView:Close()
	self.View:SetActive(false)
	self.goWorkRecordBlock:SetActive(true)
end

function EventRecordView:OnHide()
	return
end

function EventRecordView:OnDestroy()
	self:OnRemoveListeners()

	for i, v in pairs(self.itemCellPool) do
		v:Dispose()
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function EventRecordView:OnAddListeners()
	self:OnRemoveListeners()
	self.btnClose.onClick:AddListener(self.onClickBtnCloseDelegate)
	self.btnDelete.onClick:AddListener(self.onClickBtnDeleteDelegate)
end

function EventRecordView:OnRemoveListeners()
	self.btnClose.onClick:RemoveListener(self.onClickBtnCloseDelegate)
	self.btnDelete.onClick:RemoveListener(self.onClickBtnDeleteDelegate)
end

function EventRecordView:OnClickBtnClose()
	self:Close()
end

function EventRecordView:OnClickBtnDelete()
	self:OnClickBtnClose()
	HLWorkModule.DeleteRecord(self.affairId)
end

function EventRecordView:RefreshMisc()
	self.tfFinishDesc.text = HomeLandWorkListUIApi:GetString("eventViewFinishDesc", self.isPerfect)
	self.tfWorkName.text = HomeLandWorkRoomUIApi:GetString("workName", self.cfgAffairData.WorkName)
	self.tfWorkDesc.text = HomeLandWorkRoomUIApi:GetString("workDesc", self.cfgAffairData.WorkWord)

	self.goRewardTitle2:SetActive(self.isPerfect)
	self.goFinishDescEffect:SetActive(self.isPerfect)
end

function EventRecordView:RefreshRewardBlock()
	self.goRewardBlock:SetActive(#self.rewardDataList > 0)

	if #self.rewardDataList > 0 then
		local rewardList = self.rewardDataList

		table.sort(rewardList, function(a, b)
			return a[1] < b[1]
		end)

		for i, v in ipairs(self.itemCellPool) do
			v.ViewGo.transform.parent.gameObject:SetActive(i <= #rewardList)
		end

		for i, v in ipairs(rewardList) do
			local id = v[1]
			local count = v[2]

			self.itemCellPool[i]:SetItemByCID(id, count)
		end
	end
end

function EventRecordView:RefreshEventBlock()
	self.scrollRect.content.transform.anchoredPosition = Vector2.New(0, 0)

	for i, v in ipairs(self.cellPool) do
		v:SetActive(i <= #self.eventDataList)
	end

	for i, v in ipairs(self.eventDataList) do
		self:AddEventDesc(i, v)
	end
end

function EventRecordView:AddEventDesc(index, data)
	local cell = self:GetDescCell(index)
	local tfTime = cell.transform:Find("Text_01"):GetComponent("Text")
	local tfDes = cell.transform:Find("Text_02"):GetComponent("Text")
	local cfgEventData = CfgHomeLandWorkEventListTable[data[1]]

	tfTime.text = HomeLandWorkRoomUIApi:GetString("eventTime", getTimeText(data[2]))
	tfDes.text = HomeLandWorkRoomUIApi:GetString("eventDesc", CfgSoulTable[data[3]].Name, cfgEventData.EventDes, cfgEventData.EffectDes)
end

function EventRecordView:GetDescCell(index)
	local go = self.cellPool[index]

	if go == nil then
		go = UnityEngine.Object.Instantiate(self.goDescCell)

		go.transform:SetParent(self.goDescCell.transform.parent, false)

		self.cellPool[index] = go
	end

	go:SetActive(true)

	return go
end

return EventRecordView
