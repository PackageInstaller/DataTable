-- chunkname: @IQIGame\\UI\\Dup\\StageCell.lua

local m = {
	lockStatus = true
}

function m.New(go, mainUIController)
	local o = Clone(m)

	o:Initialize(go, mainUIController)

	return o
end

function m:Initialize(go, mainUIController)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.MainUIController = mainUIController

	function self.DelegateOnClick()
		self:OnClick(true)
	end

	self:AddListener()
end

function m:OnDestroy()
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:AddListener()
	self.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListener()
	self.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function m:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function m:_OnClick()
	return
end

function m:Refresh(data, isRefreshTag)
	self.gameObject:SetActive(true)

	self.data = data

	if self.MainUIController.newUnlockId == self.data.Id then
		self:OnClick(false)
	else
		self:SetSelect(false)
	end

	UGUIUtil.SetText(self.titleText, data.Name)
	UGUIUtil.SetText(self.normalText, self.data.Name)

	if isRefreshTag and self.tag then
		local dupPos = self.MainUIController.dupPod
		local isShowTag = false

		if dupPos and dupPos.passStatus and dupPos.passStatus[self.data.Id] then
			isShowTag = dupPos.passStatus[self.data.Id].Status == 1
		end

		LuaUtility.SetGameObjectShow(self.tag, isShowTag)
	end

	self:CheckLock()
end

function m:CheckLock()
	if ConditionModule.CheckMultipleAllIsPass(ConditionModule.CheckMultiple(self.data.UnlockConditionId)) then
		self.Lock.gameObject:SetActive(false)

		self.lockStatus = false

		if not self.MainUIController.selectedTag then
			self.MainUIController.selectedTag = self
		end
	else
		self.Lock.gameObject:SetActive(true)

		self.lockStatus = true

		for k, v in pairs(self.data.UnlockConditionId) do
			if not ConditionModule.Check(v) then
				UGUIUtil.SetText(self.lockCondition, ConditionModule.GetDesc(v))

				break
			end
		end
	end
end

function m:OnClick(notice)
	if self.lockStatus and notice then
		NoticeModule.ShowNotice(19001)
	else
		if self.MainUIController.selectedTag then
			self.MainUIController.selectedTag:SetSelect(false)
		end

		self.MainUIController.newUnlockId = self.data.Id
		self.MainUIController.selectedTag = self

		self.MainUIController:SetTagState()
		self:SetSelect(true)
		self.MainUIController:RefreshInfo(self.data)
	end
end

function m:SetSelect(isSelect)
	self.goOn.gameObject:SetActive(isSelect)
	self.normalText.gameObject:SetActive(not isSelect)
end

return m
