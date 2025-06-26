-- chunkname: @IQIGame\\UI\\Setting\\SettingLoginBgCell.lua

local SettingLoginBgCell = {
	isSelected = false
}

function SettingLoginBgCell.PackageOrReuseView(ui, mouldPrefab)
	if ui == nil or mouldPrefab == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		ui.__SUB_UI_MAP_MailMouldCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_MailMouldCell
	local loginBgCell

	if subUIMap[mouldPrefab:GetInstanceID()] == nil then
		loginBgCell = SettingLoginBgCell:__New(mouldPrefab)
		subUIMap[mouldPrefab:GetInstanceID()] = loginBgCell
	else
		loginBgCell = subUIMap[mouldPrefab:GetInstanceID()]
	end

	return loginBgCell
end

function SettingLoginBgCell:__New(itemCellView)
	local itemCell = Clone(self)

	itemCell.tabComponent = {}
	itemCell.goView = itemCellView

	LuaCodeInterface.BindOutlet(itemCell.goView, itemCell.tabComponent)

	return itemCell
end

function SettingLoginBgCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_MailMouldCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_MailMouldCell) do
		itemCell:OnDestroy()

		itemCell.tabComponent = nil
		itemCell.goView = nil
	end

	ui.__SUB_UI_MAP_MailMouldCell = nil
end

function SettingLoginBgCell:SetItem(loginBgData)
	self.loginBgData = loginBgData

	if self.loginBgData == nil then
		self:Clear()
	else
		self:Update()
	end
end

function SettingLoginBgCell:Update()
	if self.loginBgData ~= nil then
		local iconPath = UIGlobalApi.ImagePath .. self.loginBgData.cfgInfo.Url

		AssetUtil.LoadImage(self, iconPath, self.tabComponent.Image:GetComponent("Image"))
		self.tabComponent.Lock:SetActive(not self.loginBgData.isLock)

		self.tabComponent.TextCondition:GetComponent("Text").text = self.loginBgData.cfgInfo.LockDescribtion

		local uName = PlayerPrefsUtil.GetString("", Constant.PlayerPrefsConst.UserName)
		local useID = PlayerPrefsUtil.GetString(uName, Constant.PlayerPrefsConst.UserLoginBG)

		self.tabComponent.Tag:SetActive(useID == tostring(self.loginBgData.cfgID))
		self:SetSelected(false)
	end
end

function SettingLoginBgCell:SetSelected(top)
	self.isSelected = top

	self.tabComponent.Choose:SetActive(self.isSelected)
end

function SettingLoginBgCell:Clear()
	self.goView:SetActive(false)
end

function SettingLoginBgCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self.tabComponent)

	self.goView = nil
	self.tabComponent = nil
end

return SettingLoginBgCell
