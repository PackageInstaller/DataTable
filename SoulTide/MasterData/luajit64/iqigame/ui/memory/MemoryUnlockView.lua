-- chunkname: @IQIGame\\UI\\Memory\\MemoryUnlockView.lua

local m = {
	isUnlock = false,
	showUnLockState = false,
	content = true
}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.TextBtnGetReward:GetComponent("Text").text = MemoryUIApi:GetString("TextBtnGetReward")
	self.panelTween = self.Panel:GetComponent("TweenPosition")

	function self.delegateClickBtnGetReward()
		self:OnClickBtnGetReward()
	end

	function self.delegateTweenClose()
		self:OnTweenClose()
	end

	function self.delegateOnMemoryActiveMemoryFragmentSuccess(pieceCid)
		self:OnMemoryActiveMemoryFragmentSuccess(pieceCid)
	end

	function self.delegateMsgChangeBtn()
		self:OnMsgChangeBtn()
	end

	self:OnAddListeners()
end

function m:OnAddListeners()
	self.GetRewardBtn:GetComponent("Button").onClick:AddListener(self.delegateClickBtnGetReward)
	self.MsgChangeBtn:GetComponent("Button").onClick:AddListener(self.delegateMsgChangeBtn)
	EventDispatcher.AddEventListener(EventID.MemoryActiveMemoryFragmentSuccessEvent, self.delegateOnMemoryActiveMemoryFragmentSuccess)
end

function m:OnRemoveListeners()
	self.GetRewardBtn:GetComponent("Button").onClick:RemoveListener(self.delegateClickBtnGetReward)
	self.MsgChangeBtn:GetComponent("Button").onClick:RemoveListener(self.delegateMsgChangeBtn)
	EventDispatcher.RemoveEventListener(EventID.MemoryActiveMemoryFragmentSuccessEvent, self.delegateOnMemoryActiveMemoryFragmentSuccess)
end

function m:OnMemoryActiveMemoryFragmentSuccess(pieceCid)
	if self.cfgFragmentData and self.cfgFragmentData.Id == pieceCid then
		self.isUnlock = true

		self:UpdateView()
	end
end

function m:UpdateView()
	self.MsgChangeBtn:SetActive(self.isUnlock)
	self.GetRewardBtn:SetActive(not self.isUnlock)
	self.Reward:SetActive(not self.isUnlock)
	self.ImgIcon:GetComponent("GrayComponent"):SetGray(not self.isUnlock)
	self.Effect:SetActive(self.isUnlock)

	self.TextTitle:GetComponent("Text").text = self.cfgFragmentData.Name

	local dataPath = UIGlobalApi.GetImagePath(self.cfgFragmentData.Icon)

	AssetUtil.LoadImage(self, dataPath, self.ImgIcon:GetComponent("Image"))

	for i = 0, self.ItemContainer.transform.childCount - 1 do
		local obj = self.ItemContainer.transform:GetChild(i).gameObject

		UnityEngine.GameObject.Destroy(obj)
	end

	self.content = true

	for i = 1, #self.cfgFragmentData.Cost, 2 do
		local itemId = self.cfgFragmentData.Cost[i]
		local needNum = self.cfgFragmentData.Cost[i + 1]
		local haveNum = WarehouseModule.GetItemNumByCfgID(itemId)

		if self.content then
			self.content = needNum <= haveNum
		end

		local obj = UnityEngine.Object.Instantiate(self.CommonSlot)

		obj.transform:SetParent(self.ItemContainer.transform, false)
		obj:SetActive(true)

		local itemCell = ItemCell.PackageOrReuseView(self, obj)

		itemCell:SetItem(CfgItemTable[itemId])
		itemCell:SetCustomNum(haveNum, needNum)
	end

	local describe = self.cfgFragmentData.Describe1

	if self.isUnlock then
		describe = self.cfgFragmentData.Describe2
	end

	self.showUnLockState = self.isUnlock
	self.TextDes:GetComponent("Text").text = describe

	local str = ""

	for i = 1, #self.cfgFragmentData.AttributeType do
		local id = self.cfgFragmentData.AttributeType[i]
		local value = self.cfgFragmentData.AttributeNum[i]

		str = str .. AttributeModule.GetAttName(id) .. ": +" .. AttributeModule.GetAttShowValue(id, value) .. " "
	end

	UGUIUtil.SetText(self.TextAdd, str)
	UGUIUtil.SetText(self.MsgChangeBtnLabel, MemoryUIApi:GetString("MsgChangeBtnLabel", self.showUnLockState))
end

function m:OnClickBtnClose()
	self.panelTween.enabled = true

	self.panelTween:PlayReverse()
	self.panelTween:SetOnFinished(self.delegateTweenClose)
end

function m:OnTweenClose()
	self.panelTween:RemoveOnFinished(self.delegateTweenClose)
	self:Close()
end

function m:OnMsgChangeBtn()
	self.showUnLockState = not self.showUnLockState

	if self.cfgFragmentData then
		local describe = self.cfgFragmentData.Describe1

		if self.showUnLockState then
			describe = self.cfgFragmentData.Describe2
		end

		self.TextDes:GetComponent("Text").text = describe

		UGUIUtil.SetText(self.MsgChangeBtnLabel, MemoryUIApi:GetString("MsgChangeBtnLabel", self.showUnLockState))
	end
end

function m:OnClickBtnGetReward()
	if self.content == false then
		NoticeModule.ShowNoticeNoCallback(21041013)

		return
	end

	MemoryModule.RequestActiveMemoryPiece(MemoryModule.currentSoulChapterInfo.cid, self.cfgFragmentData.Id)
end

function m:Open(cfgFragmentData, isUnlock)
	self.View:SetActive(true)

	self.cfgFragmentData = cfgFragmentData
	self.isUnlock = isUnlock

	self:UpdateView()

	self.panelTween.enabled = true

	self.panelTween:PlayForward()
	self.panelTween:SetOnFinished(function()
		self.panelTween.enabled = false
	end)
end

function m:Close()
	self.View:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:OnRemoveListeners()
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
