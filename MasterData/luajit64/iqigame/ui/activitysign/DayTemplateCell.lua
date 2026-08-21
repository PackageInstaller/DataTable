-- chunkname: @IQIGame\\UI\\ActivitySign\\DayTemplateCell.lua

local DayTemplateCell = {
	iconPool = {}
}

function DayTemplateCell.New(view)
	local obj = Clone(DayTemplateCell)

	obj:Init(view)

	return obj
end

function DayTemplateCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.tfDay = self.goDay:GetComponent("Text")

	for i = 1, 3 do
		self.iconPool[i] = self.goIconRoot.transform:Find("Image_0" .. i):GetComponent("Image")
	end

	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickBtnSelfDelegate()
		self:OnClickBtnSelf()
	end
end

function DayTemplateCell:Refresh(cfgSignInData, curMonth, curDay, day, onClickBtnSelfDelegate)
	self:SetActive(true)

	self.cfgSignInData = cfgSignInData
	self.curMonth = curMonth
	self.curDay = curDay
	self.day = day
	self.onClickBtnSelfDelegateOther = onClickBtnSelfDelegate

	self:RefreshMisc()
	self:OnAddListener()
end

function DayTemplateCell:OnHide()
	self:OnRemoveListener()
end

function DayTemplateCell:Destroy()
	self:OnHide()
	self:OnDestroy()
	UnityEngine.Object.Destroy(self.View)
end

function DayTemplateCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DayTemplateCell:OnAddListener()
	self:OnRemoveListener()
	self.btnSelf.onClick:AddListener(self.onClickBtnSelfDelegate)
end

function DayTemplateCell:OnRemoveListener()
	self.btnSelf.onClick:RemoveListener(self.onClickBtnSelfDelegate)
end

function DayTemplateCell:OnClickBtnSelf()
	if self.onClickBtnSelfDelegateOther ~= nil then
		self.onClickBtnSelfDelegateOther()
	end
end

function DayTemplateCell:SetActive(vs)
	self.View:SetActive(vs)
end

function DayTemplateCell:SetSignSelectActive(vs)
	self.goSignCurDay:SetActive(vs)
end

function DayTemplateCell:RefreshMisc()
	self:SetSignSelectActive(self.curDay == self.day)

	self.tfDay.text = ActivitySignUIApi:GetString("dayTxt", self.day)

	local existBirthday = false

	for i, v in ipairs(SoulModule.GetSortedSoulDataList()) do
		local cfgData = v:GetCfgSoul()
		local m, d = SignInModule.GetMonthDay(cfgData.BirthDay)

		if tonumber(m) == self.curMonth and tonumber(d) == self.day then
			existBirthday = true

			break
		end
	end

	local paths = {}

	if existBirthday then
		paths[#paths + 1] = UIGlobalApi.GetImagePath(ActivitySignUIApi:GetString("detailCellBirthIcon"))
	end

	for i, v in ipairs(self.cfgSignInData.EventIcon) do
		if v ~= "" and v ~= nil then
			paths[#paths + 1] = UIGlobalApi.GetImagePath(v)
		end
	end

	for i, v in ipairs(self.iconPool) do
		v.gameObject:SetActive(i <= #paths)
	end

	for i, v in ipairs(paths) do
		if i <= #self.iconPool then
			AssetUtil.LoadImage(self, v, self.iconPool[i])
		end
	end

	self.goSignSignIned:SetActive(SignInModule.CheckIsSign(self.day))

	local iconItem = self.goItemRoot.transform:Find("Image_Icon"):GetComponent("Image")
	local tfItemNum = self.goItemRoot.transform:Find("Empty/Text_01"):GetComponent("Text")
	local bgItem = self.goItemRoot.transform:Find("Image_Quality"):GetComponent("Image")
	local cfgItemData = CfgItemTable[self.cfgSignInData.Reward[1]]

	AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), iconItem)
	AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(ActivitySignUIApi:GetString("itemBg", cfgItemData.Quality)), bgItem)

	tfItemNum.text = ActivitySignUIApi:GetString("itemNum", self.cfgSignInData.Reward[2])
end

return DayTemplateCell
