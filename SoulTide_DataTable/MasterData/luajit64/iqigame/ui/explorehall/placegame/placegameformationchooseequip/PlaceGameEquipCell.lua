-- chunkname: @IQIGame\\UI\\ExploreHall\\PlaceGame\\PlaceGameFormationChooseEquip\\PlaceGameEquipCell.lua

local m = {
	forShow = false,
	enableClick = true
}

function m.New(view, interactive)
	local obj = Clone(m)

	obj:Init(view, interactive)

	return obj
end

function m:Init(view, interactive)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	self.imgIcon = self.goIcon:GetComponent("Image")
	self.grayGroupComp = self.goRoot:GetComponent("GrayComponent")

	function self.onClickDefaultDelegate()
		self:OnClickSelf()
	end

	function self.onEquipLockOverDelegate(id, lock)
		self:OnEquipLockOver(id, lock)
	end

	self.goSignClip.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goSignClip")
	self.goWearTag1.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goDescCurWore")

	if interactive == nil then
		interactive = true
	end

	self.enableClick = interactive

	self:AddListener()
end

function m:AddListener()
	self.goBtnSelf:GetComponent("Button").onClick:AddListener(self.onClickDefaultDelegate)
	EventDispatcher.AddEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
end

function m:RemoveListener()
	self.goBtnSelf:GetComponent("Button").onClick:RemoveListener(self.onClickDefaultDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
end

function m:Refresh(itemData, belongUI, forShow)
	self.itemData = itemData
	self.belongUI = belongUI
	self.forShow = forShow

	self:RefreshMisc()
end

function m:RefreshMisc()
	self.goIcon:SetActive(self.itemData ~= nil)

	if self.itemData == nil then
		self:RefreshOnEmptyData()
	else
		self:RefreshOnExistData()
	end

	self:SetCheckVisible(false)
	self:SetWearTag1Visible(false)
	self:SetLockMaskVisible(false)
	self:SetNewTagVisible(false)
	self:SetGray(false)
end

function m:RefreshOnEmptyData()
	self.goSignNormal:SetActive(false)
	self.goSignSpecial:SetActive(false)
	self.goLock:SetActive(false)
	self.goClassType:SetActive(false)

	if self.goStarUpgradingIcon ~= nil then
		self.goStarUpgradingIcon:SetActive(false)
	end
end

function m:RefreshOnExistData()
	local cfgData = self.itemData:GetCfg()
	local equipShowInfo = {}

	equipShowInfo.Name = cfgData.Name
	equipShowInfo.Desc = cfgData.Describe
	equipShowInfo.HiddenStory = cfgData.HiddenStory
	equipShowInfo.Icon = cfgData.Icon
	equipShowInfo.Drawing = cfgData.Drawing
	equipShowInfo.DrawingSmallSize = cfgData.DrawingSmallSize

	local isUsingSkin = false

	self.goSignNormal:SetActive(not isUsingSkin)
	self.goSignSpecial:SetActive(isUsingSkin)
	self.goClassType:SetActive(true)
	self:RefreshLv()

	if self.useSmallIcon == nil then
		if string.find(self.View.name, "Small") then
			self.useSmallIcon = true
		else
			self.useSmallIcon = false
		end
	end

	local path = UIGlobalApi.GetImagePath(equipShowInfo.Drawing)

	if self.useSmallIcon then
		path = UIGlobalApi.GetImagePath(equipShowInfo.DrawingSmallSize)
	end

	if self.belongUI == nil then
		AssetUtil.LoadImage(self, path, self.imgIcon)
	else
		local asset = self.belongUI.UIController:GetPreloadedAsset(path)

		self.imgIcon.sprite = LuaCodeInterface.ToSprite(asset)
	end

	self.goLock:SetActive(self.itemData.placeGameEquipData.placeGameEquipPOD.lock)

	local imgFrame, imgBg, imgMoon

	if isUsingSkin then
		imgFrame = self.goSignSpecial.transform:Find("Frame"):GetComponent("Image")
		imgBg = self.goSignSpecial.transform:Find("Image_Quality"):GetComponent("Image")
		imgMoon = self.goSignSpecial.transform:Find("Image_QualityMoon"):GetComponent("Image")
	else
		imgFrame = self.goSignNormal.transform:Find("Frame"):GetComponent("Image")
		imgBg = self.goSignNormal.transform:Find("Image_Quality"):GetComponent("Image")
		imgMoon = self.goSignNormal.transform:Find("Image_QualityMoon"):GetComponent("Image")
	end

	AssetUtil.LoadImage(self, PlaceGameFormationChooseEquipUIApi:GetString("goCellFrame", isUsingSkin, cfgData.Quality), imgFrame)
	AssetUtil.LoadImage(self, PlaceGameFormationChooseEquipUIApi:GetString("goCellBg", cfgData.Quality), imgBg)
	AssetUtil.LoadImage(self, PlaceGameFormationChooseEquipUIApi:GetString("goCellMoon", isUsingSkin, cfgData.Quality), imgMoon)
	AssetUtil.LoadImage(self, PlaceGameFormationChooseEquipUIApi:GetString("EquipClassIcon", cfgData.SubType), self.goClassType:GetComponent("Image"))
	self:RefreshStarUpgradingIcon()
end

function m:RefreshLv()
	if self.itemData.placeGameEquipData == nil then
		logError("ItemData[cid:" .. self.itemData.cid .. "]的placeGameEquipData为空或不是放置活动蕴灵")

		return
	end

	local tfLvText = EquipUIApi:GetString("goEquipLv", self.itemData.placeGameEquipData.placeGameEquipPOD.level)
	local tfLv = self.goSignSpecial.transform:Find("Text_Lv"):GetComponent("Text")

	tfLv.text = tfLvText
	tfLv = self.goSignNormal.transform:Find("Text_Lv"):GetComponent("Text")
	tfLv.text = tfLvText
end

function m:SetCheckVisible(vs)
	self.goCheck:SetActive(vs)
end

function m:SetWearTag1Visible(vs)
	self.goWearTag1:SetActive(vs)
end

function m:SetLockMaskVisible(vs)
	if self.goSignLockMask ~= nil then
		self.goSignLockMask:SetActive(vs)
	end
end

function m:SetNewTagVisible(vs)
	self.goNewTag:SetActive(vs)
end

function m:SetGray(vs)
	self.goSignClip:SetActive(vs)
	self.grayGroupComp:SetGray(vs)
end

function m:SetActive(vs)
	self.View:SetActive(vs)
end

function m:OnClickSelf()
	if self.itemData == nil then
		return
	end

	if self.enableClick == false then
		return
	end

	if self.onClickDelegate ~= nil then
		self:onClickDelegate(self)
	elseif self.itemData ~= nil then
		UIModule.Open(Constant.UIControllerName.EquipUI, Constant.UILayer.UI, {
			data = {
				self.itemData
			},
			forShow = self.forShow
		})
	end
end

function m:OnEquipLockOver(id, lock)
	if self.itemData == nil then
		return
	end

	if self.itemData.id == id then
		self.goLock:SetActive(lock)
	end
end

function m:RefreshStarUpgradingIcon()
	if self.goStarUpgradingIcon == nil then
		return
	end

	self.goStarUpgradingIcon:SetActive(false)
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
	LuaCodeInterface.ClearOutlet(self.View, self)
	UnityEngine.Object.Destroy(self.View)

	self.View = nil
end

return m
