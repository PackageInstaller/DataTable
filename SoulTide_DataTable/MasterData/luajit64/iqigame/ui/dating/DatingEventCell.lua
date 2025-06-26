-- chunkname: @IQIGame\\UI\\Dating\\DatingEventCell.lua

DatingEventCell = {
	isSelect = false
}

function DatingEventCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		ui.__SUB_UI_MAP_MailMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MailMouldCell
	local areaBtnRender

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		areaBtnRender = DatingEventCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = areaBtnRender
	else
		areaBtnRender = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return areaBtnRender
end

function DatingEventCell:__New(itemCellView)
	local itemCell = Clone(DatingEventCell)

	itemCell:Init(itemCellView)

	return itemCell
end

function DatingEventCell:Init(view)
	self.goView = view

	LuaCodeInterface.BindOutlet(self.goView, self)
	UGUIUtil.SetText(self.B_BtnDatingTitle, DatingUIApi:GetString("B_BtnDatingTitle"))
	UGUIUtil.SetText(self.B_BtnReviewTitle, DatingUIApi:GetString("B_BtnReviewTitle"))
	UGUIUtil.SetText(self.B_Lock_Text1, DatingUIApi:GetString("B_Lock_Text1"))

	self.btnDating = self.B_BtnDating:GetComponent("Button")
	self.btnDatingReview = self.B_BtnReview:GetComponent("Button")
	self.btnRewardBox = self.B_RewardBox:GetComponent("Button")
	self.btnSelf = self.goView:GetComponent("Button")

	function self.delegateClickBtnDating()
		self:OnClickBtnDating()
	end

	function self.delegateClickBtnDatingReview()
		self:OnClickBtnDatingReview()
	end

	function self.delegateClickBtnReward()
		self:OnClickBtnReward()
	end

	function self.delegateBtnSelf()
		self:OnClickBtnSelf()
	end

	self:AddListener()
end

function DatingEventCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MailMouldCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_MailMouldCell = nil
end

function DatingEventCell:AddListener()
	self.btnDating.onClick:AddListener(self.delegateClickBtnDating)
	self.btnDatingReview.onClick:AddListener(self.delegateClickBtnDatingReview)
	self.btnRewardBox.onClick:AddListener(self.delegateClickBtnReward)
	self.btnSelf.onClick:AddListener(self.delegateBtnSelf)
end

function DatingEventCell:RemoveListener()
	self.btnDating.onClick:RemoveListener(self.delegateClickBtnDating)
	self.btnDatingReview.onClick:RemoveListener(self.delegateClickBtnDatingReview)
	self.btnRewardBox.onClick:RemoveListener(self.delegateClickBtnReward)
	self.btnSelf.onClick:RemoveListener(self.delegateBtnSelf)
end

function DatingEventCell:UpdateView(datingEvent, index)
	self.datingEvent = datingEvent
	self.index = index

	self.BigNode:SetActive(self.isSelect)
	self.SmallNode:SetActive(not self.isSelect)

	if self.datingEvent then
		local str = ""
		local needDownDatingId = self.datingEvent.NeedDownDatingId

		if needDownDatingId ~= "" and needDownDatingId ~= nil and needDownDatingId > 0 then
			str = CfgDatingEventsTable[needDownDatingId].Name
		end

		local top = DatingModule.IsDatingEventOpen(datingEvent)

		if not top then
			UGUIUtil.SetText(self.B_Lock_Text2, str)
			UGUIUtil.SetText(self.B_Lock_Text3, DatingUIApi:GetString("TextCondition", self.datingEvent.UnlockLevel))
			UGUIUtil.SetText(self.S_TextLock, DatingUIApi:GetString("TextCondition", self.datingEvent.UnlockLevel))
		end

		UGUIUtil.SetText(self.B_LockTitle, DatingUIApi:GetString("TextDatingSpend"))
		UGUIUtil.SetText(self.B_DatingSpentTitle, DatingUIApi:GetString("TextDatingSpend"))

		local isShowSpent = false

		self.eventState = DatingModule.GetEventSate(datingEvent)

		self.B_Lock:SetActive(not top)
		self.B_ReviewNode:SetActive(false)
		self.B_DatingNode:SetActive(false)
		self.B_LockNode:SetActive(false)
		self.B_RewardBox:SetActive(false)
		self.B_SpentGrid:SetActive(false)

		if self.eventState == 1 then
			self.B_LockNode:SetActive(true)
			self.B_SpentGrid:SetActive(true)

			isShowSpent = true
		elseif self.eventState == 2 then
			self.B_DatingNode:SetActive(true)
			self.B_RewardBox:SetActive(true)
			self.B_SpentGrid:SetActive(true)

			isShowSpent = true
		elseif self.eventState == 3 then
			self.B_ReviewNode:SetActive(true)
			self.B_RewardBox:SetActive(true)
		end

		local iconPath = UIGlobalApi.GetImagePath(self.datingEvent.ImageBg)

		AssetUtil.LoadImage(self, iconPath, self.B_Img:GetComponent("Image"))
		UGUIUtil.SetText(self.B_TextName, self.datingEvent.Name)
		UGUIUtil.SetText(self.B_TextDes, self.datingEvent.Describe)

		self.isGet = self.eventState == 3

		self.B_RewardBoxOpen:SetActive(self.isGet)
		self.B_RewardBoxClose:SetActive(not self.isGet)

		if isShowSpent then
			self.isAmple = true

			local parentTransform = self.B_SpentGrid.transform

			for i = 0, parentTransform.childCount - 1 do
				local obj = parentTransform:GetChild(0).gameObject

				UnityEngine.GameObject.DestroyImmediate(obj)
			end

			for i = 1, #self.datingEvent.Cost, 2 do
				local needItemID = self.datingEvent.Cost[i]
				local needNum = self.datingEvent.Cost[i + 1]
				local haveNum = WarehouseModule.GetItemNumByCfgID(needItemID)
				local itemData = CfgItemTable[needItemID]
				local spendObj = UnityEngine.Object.Instantiate(self.SpentMould)

				spendObj.transform:SetParent(parentTransform.transform, false)
				spendObj:SetActive(true)

				local obj = spendObj.transform:Find("Slot"):GetChild(0).gameObject
				local itemCell = ItemCell.PackageOrReuseView(self, obj)

				itemCell:SetItem(itemData)
				UGUIUtil.SetText(spendObj.transform:Find("Text_1").gameObject, DatingUIApi:GetString("TextSpend", haveNum, needNum))

				if self.isAmple then
					self.isAmple = needNum <= haveNum
				end
			end
		end

		self.B_RedPoint:SetActive(self.isAmple and self.eventState == 2)
		UGUIUtil.SetText(self.S_TextName, self.datingEvent.Name)

		local iconPath = UIGlobalApi.GetImagePath(self.datingEvent.ImageBg)

		AssetUtil.LoadImage(self, iconPath, self.S_Img:GetComponent("Image"))

		local showOath = datingEvent.UnlockLevel > 40

		self.S_BgTitle1:SetActive(false)
		self.S_BgTitle2:SetActive(false)
		self.S_BgTitle3:SetActive(false)
		self.S_Tag:SetActive(false)
		self.S_TagOath:SetActive(false)
		self.S_Lock:SetActive(not top)

		if self.eventState == 1 then
			self.S_BgTitle1:SetActive(true)
		elseif self.eventState == 2 then
			self.S_BgTitle2:SetActive(not showOath)
			self.S_BgTitle3:SetActive(showOath)
		elseif self.eventState == 3 then
			self.S_BgTitle2:SetActive(not showOath)
			self.S_BgTitle3:SetActive(showOath)
			self.S_Tag:SetActive(not showOath)
			self.S_TagOath:SetActive(showOath)
		end
	end
end

function DatingEventCell:SetSelect(isSelect)
	self.isSelect = isSelect

	if self.BigNode then
		self.BigNode:SetActive(self.isSelect)
	end

	if self.SmallNode then
		self.SmallNode:SetActive(not self.isSelect)
	end
end

function DatingEventCell:OnClickBtnSelf()
	if self.clickCallBack then
		self.clickCallBack(self)
	end
end

function DatingEventCell:OnClickBtnDating()
	if self.eventState == 1 then
		NoticeModule.ShowNoticeByType(1, DatingUIApi:GetString("TextUnlock"))

		return
	end

	if not self.isAmple then
		NoticeModule.ShowNoticeByType(1, DatingUIApi:GetString("TextError1"))

		return
	end

	local soulData = SoulModule.GetSoulData(self.datingEvent.SoulId)
	local state = SoulModule.GetMoodState(self.datingEvent.SoulId, soulData.mood)

	if state == 1 then
		local actionId = 0

		for i, v in pairsCfg(CfgSoulActionGroupTable) do
			if v.SoulId == soulData.soulCid and v.Type == 1611 then
				actionId = v.MoodActionID[1][1]
			end
		end

		if actionId > 0 then
			GameEntry.LuaEvent:Fire(nil, L2DJumpToStateEventArgs():Fill(Constant.L2D_CustomStateName.Dating, actionId))
		end

		return
	end

	DatingModule.Dating(self.datingEvent.SoulId, self.datingEvent.Id)
end

function DatingEventCell:OnClickBtnDatingReview()
	if self.eventState == 1 then
		NoticeModule.ShowNoticeByType(1, DatingUIApi:GetString("TextUnlock"))

		return
	end

	DatingModule.Dating(self.datingEvent.SoulId, self.datingEvent.Id)
end

function DatingEventCell:OnClickBtnReward()
	local rewards = {}
	local collectReward = self.datingEvent.Reward

	for i = 1, #collectReward, 2 do
		rewards[#rewards + 1] = {
			id = collectReward[i],
			num = collectReward[i + 1]
		}
	end

	local state = 3

	if self.isGet then
		state = 1
	end

	UIModule.Open(Constant.UIControllerName.CheckRewardUI, Constant.UILayer.Mid, {
		Rewards = rewards,
		State = state
	})
end

function DatingEventCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()

	self.clickCallBack = nil

	LuaCodeInterface.ClearOutlet(self.goView, self)
	UnityEngine.Object.Destroy(self.goView)

	self.goView = nil
end

return DatingEventCell
