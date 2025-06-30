-- chunkname: @IQIGame\\UI\\Bag\\ItemCell.lua

ItemCell = {
	Interactive = true,
	ForShow = true,
	HideTipsSource = false
}

function ItemCell.PackageOrReuseView(ui, cellGo, interactive, forShow, hideTipsSource)
	if ui == nil or cellGo == nil then
		return nil
	end

	if ui.__SUB_UI_MAP_ItemCell == nil then
		ui.__SUB_UI_MAP_ItemCell = {}
	end

	local subUIMap = ui.__SUB_UI_MAP_ItemCell
	local itemCell

	if subUIMap[cellGo:GetInstanceID()] == nil then
		itemCell = ItemCell:__New(cellGo, interactive, forShow, hideTipsSource)
		subUIMap[cellGo:GetInstanceID()] = itemCell
	else
		itemCell = subUIMap[cellGo:GetInstanceID()]
	end

	return itemCell
end

function ItemCell.DisposeIn(ui)
	if ui.__SUB_UI_MAP_ItemCell == nil then
		return
	end

	for i, itemCell in pairs(ui.__SUB_UI_MAP_ItemCell) do
		itemCell:Dispose()
	end

	ui.__SUB_UI_MAP_ItemCell = nil
end

function ItemCell:Dispose()
	AssetUtil.UnloadAsset(self)
	self.ViewGo:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClick)
	LuaCodeInterface.ClearOutlet(self.ViewGo, self.View)

	self.ViewGo = nil
	self.View = nil
	self.ClickHandler = nil
end

function ItemCell.New(viewGo, interactive, forShow, hideTipsSource)
	return ItemCell:__New(viewGo, interactive, forShow, hideTipsSource)
end

function ItemCell:__New(viewGo, interactive, forShow, hideTipsSource)
	local o = Clone(self)

	o.View = {}
	o.ViewGo = viewGo

	LuaCodeInterface.BindOutlet(viewGo, o.View)

	function o.ClickHandler()
		o:OnClick()
	end

	o.DefaultClickHandler = o.ClickHandler

	function o.DelegateOnClick()
		o.ClickHandler()
	end

	if interactive ~= nil then
		o.Interactive = interactive
	end

	if forShow ~= nil then
		o.ForShow = forShow
	end

	if hideTipsSource ~= nil then
		o.HideTipsSource = hideTipsSource
	end

	if o.Interactive and o.ViewGo:GetComponent("Button") ~= nil then
		o.ViewGo:GetComponent("Button").onClick:AddListener(o.DelegateOnClick)
	end

	o:SetMouseEnabled(o.Interactive)
	UGUIUtil.SetTextInChildren(o.View.WearTag2, CommonSlotUIApi:GetString("WearTag2Txt"))

	return o
end

function ItemCell:SetMouseEnabled(value)
	local button = self.ViewGo:GetComponent("Button")

	if button then
		button.enabled = value
	end

	local image, childTrans

	for i = 0, self.ViewGo.transform.childCount - 1 do
		childTrans = self.ViewGo.transform:GetChild(i)
		image = childTrans:GetComponent("Image")

		if image ~= nil then
			image.raycastTarget = value
		end
	end
end

function ItemCell:SetClickHandler(handler, owner)
	function self.ClickHandler()
		if handler ~= nil then
			handler(owner, self)
		end
	end
end

function ItemCell:ResetClickHandler()
	self.ClickHandler = self.DefaultClickHandler
end

function ItemCell:OnClick()
	ItemModule.OpenTip(self)
end

function ItemCell:SetItem(itemCfgOrData, num, soulPrefabOrDollPOD, isNotPrefab)
	self.ItemCfgOrData = itemCfgOrData
	isNotPrefab = isNotPrefab or false

	if itemCfgOrData == nil then
		self:Clear()
	else
		self:Update(itemCfgOrData, num, soulPrefabOrDollPOD, isNotPrefab)
	end
end

function ItemCell:SetItemByCID(itemCid, num)
	if itemCid == 0 then
		self:Clear()

		return
	end

	self:SetItem(CfgItemTable[itemCid], num)
end

function ItemCell:SetNum(num, hideNum1)
	if hideNum1 and num == 1 then
		self.View.ItemNumText:GetComponent("Text").text = ""

		return
	end

	self.View.ItemNumText:GetComponent("Text").text = CommonSlotUIApi:GetString("ItemNumText", num)
end

function ItemCell:SetCustomNum(ownCount, needCount, ignoreCost)
	self.View.ItemNumText:GetComponent("Text").text = CommonSlotUIApi:GetString("ItemNumText2", ownCount, needCount, ignoreCost)
end

function ItemCell:SetBottomCheckVisible(vs)
	self.View.CheckBottom:SetActive(vs)
end

function ItemCell:SetTopCheckVisible(vs)
	self.View.CheckTop:SetActive(vs)
end

function ItemCell:SetTagSelectedTagVisible(vs, txt)
	self.View.SelectedTag2:SetActive(vs)

	if vs then
		if txt ~= nil then
			self.View.SelectedTag2.transform:Find("Text_01"):GetComponent("Text").text = txt
		else
			self.View.SelectedTag2.transform:Find("Text_01"):GetComponent("Text").text = CommonSlotUIApi:GetString("SelectedTag2Txt")
		end
	end
end

function ItemCell:SetEquipLock(vs)
	self.View.LockTag:SetActive(vs)
end

function ItemCell:SetGray(vs)
	self.View.goImgGray:SetActive(vs)
end

function ItemCell:Clear()
	self.ViewGo:SetActive(false)
end

function ItemCell:Update(itemCfgOrData, num, soulPrefabOrDollPOD, isNotPrefab)
	local cfgItemData
	local isServerData = itemCfgOrData.classType == "ItemData"

	if isServerData then
		cfgItemData = itemCfgOrData:GetCfg()
	else
		cfgItemData = itemCfgOrData
	end

	local equipShowInfo, isUsingSkin

	if cfgItemData.Type == Constant.ItemType.Equip then
		equipShowInfo, isUsingSkin = EquipModule.GetEquipShowInfo(cfgItemData.Id)
	end

	self.ViewGo:SetActive(true)
	self:RefreshAboutEquip(itemCfgOrData, cfgItemData, isUsingSkin)
	self:RefreshAboutNum(itemCfgOrData, num)
	self:RefreshStar(itemCfgOrData, cfgItemData)
	self:SetBottomCheckVisible(false)
	self:SetTopCheckVisible(false)
	self:SetTagSelectedTagVisible(false)
	self.View.FragmentImg:SetActive(cfgItemData.IsFragment)
	self.View.NewTag:SetActive(false)

	if cfgItemData.Type == Constant.ItemType.Equip or cfgItemData.Type == Constant.ItemType.EvilErosionEquip then
		self.View.goEquipQuality:SetActive(true)
		self:LoadImage(EquipUIApi:GetString("qualityIconPath", cfgItemData.Quality), self.View.goEquipQuality)
	elseif cfgItemData.Type == Constant.ItemType.JewelryEquip then
		self.View.goEquipQuality:SetActive(true)

		local Quality = 1

		if itemCfgOrData.jewelryData then
			local cfgData = itemCfgOrData.jewelryData:GetJewelryQualityData()

			Quality = cfgData.Quality
		end

		self:LoadImage(EquipUIApi:GetString("qualityIconPath", Quality), self.View.goEquipQuality)
	else
		self.View.goEquipQuality:SetActive(false)
	end

	self.View.LockTag:SetActive(itemCfgOrData.equipData ~= nil and itemCfgOrData.equipData.lock)

	if cfgItemData.Type == Constant.ItemType.JewelryEquip then
		local Quality = 1

		if itemCfgOrData.jewelryData then
			local cfgData = itemCfgOrData.jewelryData:GetJewelryQualityData()

			Quality = cfgData.Quality
		end

		self:LoadImage(CommonSlotUIApi:GetString("QualityFramePath", Quality, isUsingSkin), self.View.QualityBorderImg)
		self:LoadImage(CommonSlotUIApi:GetString("QualityBackgroundPath", Quality), self.View.QualityImg)
	else
		self:LoadImage(CommonSlotUIApi:GetString("QualityFramePath", cfgItemData.Quality, isUsingSkin), self.View.QualityBorderImg)
		self:LoadImage(CommonSlotUIApi:GetString("QualityBackgroundPath", cfgItemData.Quality), self.View.QualityImg)
	end

	if cfgItemData.Icon ~= "" and cfgItemData.Icon ~= nil then
		local iconPath = cfgItemData.Icon

		if cfgItemData.Type == Constant.ItemType.Equip then
			iconPath = equipShowInfo.Icon
		end

		self:LoadImage(UIGlobalApi.GetIconPath(iconPath), self.View.Icon)
	else
		self.View.Icon:GetComponent("Image").sprite = nil
	end

	self:UpdateEquipStatus(soulPrefabOrDollPOD, isNotPrefab)
end

function ItemCell:UpdateEquipStatus(soulPrefabOrDollPOD, isNotPrefab)
	if self.ItemCfgOrData == nil then
		return
	end

	local isMyEquip = false
	local isWearingInSystemExceptFormation = false
	local equipHostPrefabId
	local isOnOtherPrefabInOneTeam = false

	if soulPrefabOrDollPOD ~= nil then
		local equipMap = self:GetSoulEquipMap(soulPrefabOrDollPOD, isNotPrefab)

		for i, itemDataOnPrefab in pairs(equipMap) do
			if self.ItemCfgOrData.id == itemDataOnPrefab.id then
				isMyEquip = true

				break
			end
		end

		if isNotPrefab then
			isOnOtherPrefabInOneTeam, equipHostPrefabId = MazeDataModule.CheckEquipIsOnDoll(self.ItemCfgOrData, soulPrefabOrDollPOD.id)
		else
			isOnOtherPrefabInOneTeam, equipHostPrefabId = FormationModule.CheckEquipIsOnBySamplePrefab(self.ItemCfgOrData, soulPrefabOrDollPOD.id, soulPrefabOrDollPOD.id)
		end
	elseif self.ItemCfgOrData ~= nil and self.ItemCfgOrData.equipData ~= nil then
		isWearingInSystemExceptFormation = self.ItemCfgOrData.equipData.isWore
	end

	UGUIUtil.SetTextInChildren(self.View.WearTag1, CommonSlotUIApi:GetString("WearTag1Txt", soulPrefabOrDollPOD ~= nil))
	self.View.WearTag1:SetActive(isMyEquip or isWearingInSystemExceptFormation)

	local showWearTag2 = soulPrefabOrDollPOD ~= nil and isOnOtherPrefabInOneTeam

	self.View.WearTag2:SetActive(showWearTag2)

	if showWearTag2 then
		local soulData

		if isNotPrefab then
			local dollPOD = MazeDataModule.GetDollPODByID(equipHostPrefabId)

			soulData = MazeDataModule.GetSoulData(dollPOD.soulCid)
		else
			local equipHostPrefabData = SoulPrefabModule.GetPrefab(equipHostPrefabId)
			local soulCid = equipHostPrefabData.soulCid

			soulData = SoulModule.GetSoulData(soulCid)
		end

		self:LoadImage(UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes2D().HeadIcon), self.View.WearTag2.transform:Find("Image_Head").gameObject, false)
	end
end

function ItemCell:GetSoulEquipMap(soulPrefabOrDollPOD, isNotPrefab)
	if isNotPrefab then
		return MazeDataModule.GetWearingEquipMap(soulPrefabOrDollPOD.soulCid)
	end

	return soulPrefabOrDollPOD.equipItemDatum
end

function ItemCell:LoadImage(path, imageGo, hideBeforeLoaded)
	if hideBeforeLoaded == nil then
		hideBeforeLoaded = true
	end

	AssetUtil.LoadImage(self, path, imageGo:GetComponent("Image"), self.OnSuccess, nil, nil, hideBeforeLoaded)
end

function ItemCell:RefreshAboutEquip(itemCfgOrData, cfgItemData, isUsingSkin)
	self.View.goEquipLv:SetActive(false)
	self.View.goEquipLvSpecial:SetActive(false)
	self.View.goEquipClass.transform.parent.gameObject:SetActive(false)

	if itemCfgOrData.Type == Constant.ItemType.Equip then
		self.View.goEquipClass.transform.parent.gameObject:SetActive(true)
		self:LoadImage(MiscApi:GetString("equipClassIcon", cfgItemData.SubType), self.View.goEquipClass)

		if itemCfgOrData.equipData ~= nil and itemCfgOrData.equipData.lv ~= 1 then
			if isUsingSkin then
				self.View.goEquipLvSpecial:SetActive(true)

				self.View.goEquipLvSpecial:GetComponent("Text").text = CommonSlotUIApi:GetString("goEquipLv", itemCfgOrData.equipData.lv, isUsingSkin)
			else
				self.View.goEquipLv:SetActive(true)

				self.View.goEquipLv:GetComponent("Text").text = CommonSlotUIApi:GetString("goEquipLv", itemCfgOrData.equipData.lv, isUsingSkin)
			end
		end
	end
end

function ItemCell:RefreshAboutNum(itemCfgOrData, num)
	local itemNum

	if num ~= nil then
		itemNum = num
	elseif itemCfgOrData.num ~= nil then
		itemNum = itemCfgOrData.num
	else
		itemNum = 1
	end

	if itemNum ~= 1 then
		self.View.ItemNumText:GetComponent("Text").text = CommonSlotUIApi:GetString("ItemNumText", itemNum)
	else
		self.View.ItemNumText:GetComponent("Text").text = ""
	end

	self:SetGray(itemNum == 0)
end

function ItemCell:RefreshStar(itemCfgOrData, cfgItemData)
	if cfgItemData.Type == Constant.ItemType.Jewelry then
		self:ShowWearJewelryStart(5, cfgItemData.Star, cfgItemData.Id, false)
	elseif cfgItemData.Type == Constant.ItemType.JewelryEquip then
		local showStar = 1

		if itemCfgOrData.jewelryData then
			showStar = itemCfgOrData.jewelryData.newJewelryEquipmentVoPOD.star
		end

		self:ShowWearJewelryStart(5, showStar, cfgItemData.Id, true)
	else
		self.View.goStar:SetActive(itemCfgOrData.equipData ~= nil)

		if itemCfgOrData.equipData ~= nil then
			local starComp = self.View.goStar:GetComponent("SimpleStarComponent")

			starComp:UpdateView(itemCfgOrData:GetCfg().StarLimit, itemCfgOrData.equipData.star)
		end
	end
end

function ItemCell:ShowWearJewelryTag(soulCid, top)
	self.View.WearJewelryTag:SetActive(top)

	if top and soulCid then
		local soulData = SoulModule.GetSoulData(soulCid)

		self:LoadImage(UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes2D().HeadIcon), self.View.WearJewelryTag.transform:Find("Image_Head").gameObject, false)
	end
end

function ItemCell:ShowWearJewelryStart(maxStar, star, itemCid, isShow)
	self.View.goStar:SetActive(itemCid ~= 46100 and isShow)

	local starComp = self.View.goStar:GetComponent("SimpleStarComponent")

	starComp:UpdateView(maxStar, star)
end

function ItemCell:ShowWearJewelryQuality(Quality)
	if Quality then
		self.View.goEquipQuality:SetActive(true)
		self:LoadImage(EquipUIApi:GetString("qualityIconPath", Quality), self.View.goEquipQuality)
		self:LoadImage(CommonSlotUIApi:GetString("QualityFramePath", Quality, false), self.View.QualityBorderImg)
		self:LoadImage(CommonSlotUIApi:GetString("QualityBackgroundPath", Quality), self.View.QualityImg)
	end
end

function ItemCell:ShowWearTag2(soulCid, top)
	self.View.WearTag2:SetActive(top)

	if top and soulCid > 0 then
		local soulData = SoulModule.GetSoulData(soulCid)

		self:LoadImage(UIGlobalApi.GetImagePath(soulData:GetCfgSoulRes2D().HeadIcon), self.View.WearTag2.transform:Find("Image_Head").gameObject, false)
	end
end

function ItemCell:ShowWearTag1(str, top)
	self.View.WearTag1:SetActive(top)

	if top and str then
		UGUIUtil.SetTextInChildren(self.View.WearTag1, str)
	end
end

function ItemCell:ShowLV(lv, top)
	self.View.goEquipLv:SetActive(top)

	if top then
		UGUIUtil.SetText(self.View.goEquipLv, lv)
	end
end
