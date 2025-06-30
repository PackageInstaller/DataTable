-- chunkname: @IQIGame\\UI\\ActivitySign\\DayDetailCell.lua

local DayDetailCell = {
	birthdayItemPool = {},
	titleItemPool = {},
	rewardItemPool = {}
}

function DayDetailCell.New(view)
	local obj = Clone(DayDetailCell)

	obj:Init(view)

	return obj
end

function DayDetailCell:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.birthdayItemPool[1] = self.goItemBirthday
	self.titleItemPool[1] = self.goItemTitle
	self.rewardItemPool[1] = self.goItemReward
	self.tfTitle1 = self.goTitle1:GetComponent("Text")
	self.tfTitle2 = self.goTitle2:GetComponent("Text")
end

function DayDetailCell:OnDestroy()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

function DayDetailCell:RefreshBirthday(cfgSoulDatum)
	self:RefreshByType(1)
	table.sort(cfgSoulDatum, function(a, b)
		return a.Id < b.Id
	end)

	for i, v in ipairs(cfgSoulDatum) do
		local go = self.birthdayItemPool[i]

		if go == nil then
			go = UnityEngine.Object.Instantiate(self.goItemBirthday)

			go.transform:SetParent(self.goItemBirthday.transform.parent, false)

			self.birthdayItemPool[i] = go
		end

		go:SetActive(true)

		local tfSoulName = go.transform:Find("Text_Name"):GetComponent("Text")
		local imgSoulHead = go.transform:Find("Image_Icon/Icon"):GetComponent("Image")

		tfSoulName.text = ActivitySignUIApi:GetString("detailCellSoulName", v.Name)

		AssetUtil.LoadImage(self, UIGlobalApi.GetImagePath(CfgHomeLandRoleTable[v.Id].HeadIcon), imgSoulHead)
	end
end

function DayDetailCell:RefreshFestival(cfgSignInDatum)
	self:RefreshByType(2)

	for i, v in ipairs(cfgSignInDatum) do
		local go = self.titleItemPool[i]

		if go == nil then
			go = UnityEngine.Object.Instantiate(self.goItemTitle)

			go.transform:SetParent(self.goItemTitle.transform.parent, false)

			self.titleItemPool[i] = go
		end

		go:SetActive(true)

		local tfName = go.transform:Find("Text_Name"):GetComponent("Text")
		local name = v.HolidayName

		if name == nil or name == "" then
			name = v.FestivalName
		end

		tfName.text = ActivitySignUIApi:GetString("detailCellFestivalName", name)
	end
end

function DayDetailCell:RefreshActivity(cfgSignInDatum)
	self:RefreshByType(4)

	local names = {}

	for i, v in ipairs(cfgSignInDatum) do
		for m, n in ipairs(v.EventName) do
			if n ~= nil and n ~= "" then
				names[#names + 1] = n
			end
		end
	end

	for i, v in ipairs(names) do
		local go = self.titleItemPool[i]

		if go == nil then
			go = UnityEngine.Object.Instantiate(self.goItemTitle)

			go.transform:SetParent(self.goItemTitle.transform.parent, false)

			self.titleItemPool[i] = go
		end

		go:SetActive(true)

		local tfName = go.transform:Find("Text_Name"):GetComponent("Text")

		tfName.text = ActivitySignUIApi:GetString("detailCellActivityName", v)
	end
end

function DayDetailCell:RefreshReward(rewardDatum)
	self:RefreshByType(3)

	for i, v in ipairs(rewardDatum) do
		local cfgItemData = CfgItemTable[v.id]
		local count = v.count
		local go = self.rewardItemPool[i]

		if go == nil then
			go = UnityEngine.Object.Instantiate(self.goItemReward)

			go.transform:SetParent(self.goItemReward.transform.parent, false)

			self.rewardItemPool[i] = go
		end

		go:SetActive(true)

		local tfName = go.transform:Find("Text_Name"):GetComponent("Text")
		local imgIcon = go.transform:Find("Image_Resource/Img_Icon"):GetComponent("Image")
		local tfNum = go.transform:Find("Image_Resource/Text_Num"):GetComponent("Text")

		tfName.text = ActivitySignUIApi:GetString("detailCellRewardName", cfgItemData.Name)
		tfNum.text = ActivitySignUIApi:GetString("detailCellRewardNum", count)

		AssetUtil.LoadImage(self, UIGlobalApi.GetIconPath(cfgItemData.Icon), imgIcon)
	end
end

function DayDetailCell:RefreshByType(type)
	self.tfTitle1.text = ActivitySignUIApi:GetString("detailCellTitle1", type)
	self.tfTitle2.text = ActivitySignUIApi:GetString("detailCellTitle2", type)

	self.goSignFestival:SetActive(type == 2)
	self.goSignBirthday:SetActive(type == 1)
	self.goSignReward:SetActive(type == 3)
	self.goSignActivity:SetActive(type == 4)
	self.goTitleFestival:SetActive(type == 2)
	self.goTitleBirthday:SetActive(type == 1)
	self.goTitleReward:SetActive(type == 3)
	self.goTitleActivity:SetActive(type == 4)

	for i, v in pairs(self.birthdayItemPool) do
		v:SetActive(false)
	end

	for i, v in pairs(self.titleItemPool) do
		v:SetActive(false)
	end

	for i, v in pairs(self.rewardItemPool) do
		v:SetActive(false)
	end
end

function DayDetailCell:SetActive(vs)
	self.View:SetActive(vs)
end

return DayDetailCell
