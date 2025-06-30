-- chunkname: @IQIGame\\UI\\Dup\\DupTagCell.lua

local m = {}

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
		self:OnClick()
	end

	self:AddListener()
end

function m:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function m:AddListener()
	self.tabItem.gameObject:GetComponent("Button").onClick:AddListener(self.DelegateOnClick)
end

function m:RemoveListener()
	self.tabItem.gameObject:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
end

function m:Refresh(data, index)
	self.data = data

	UGUIUtil.SetText(self.tabNameText, data.Name)

	if self.MainUIController.selectedTagId and self.MainUIController.selectedTagId == self.data.Id then
		self:SetSelect(true)
	else
		self:SetSelect(false)
	end

	self:CheckCondition()
	LuaUtility.SetGameObjectShow(self.lockState, not self.isUnlock)

	local cfgCondition = CfgUtil.GetCfgConditionDataWithID(self.data.UnlockConditionId[1])

	if not self.isUnlock then
		LuaUtility.SetText(self.ConditionText, cfgCondition.Name)
	end

	LuaUtility.LoadImage(self, data.TitleImg, self.selectTitleImg_on:GetComponent("Image"))
	LuaUtility.LoadImage(self, data.TitleImgClose, self.selectTitleImg_off:GetComponent("Image"))
end

function m:CheckCondition()
	self.isUnlock = true

	for i = 1, #self.data.UnlockConditionId do
		if not ConditionModule.Check(self.data.UnlockConditionId[i]) then
			self.isUnlock = false

			return
		end
	end
end

function m:OnClick()
	if not self.isUnlock then
		NoticeModule.ShowNotice(19001)

		return
	end

	if self.MainUIController.selectedTag then
		self.MainUIController.selectedTag:SetSelect(false)
	end

	self.MainUIController.selectedTag = self
	self.MainUIController.selectedTagId = self.data.Id

	self:SetSelect(true)
	self.MainUIController:RefreshDup(self.data.Id)
end

function m:SetSelect(isSelect)
	if isSelect then
		LuaUtility.SetTextColor(self.tabNameText, 0.6078431372549019, 0.38823529411764707, 0.8588235294117647, 1)
	else
		LuaUtility.SetTextColor(self.tabNameText, 0.6980392156862745, 0.6980392156862745, 0.6980392156862745, 1)
	end

	self.on.gameObject:SetActive(isSelect)
	self.off.gameObject:SetActive(not isSelect)
end

return m
