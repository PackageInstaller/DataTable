-- chunkname: @IQIGame\\UI\\Common\\EquipCell.lua

EquipCell = {
	forShow = false,
	enableClick = true,
	starPool = {}
}

function EquipCell.New(go, interactive)
	local o = Clone(EquipCell)

	o:Initialize(go, interactive)

	return o
end

function EquipCell:Initialize(go, interactive)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go
	self.imgIcon = self.goIcon:GetComponent("Image")
	self.grayGroupComp = self.goRoot:GetComponent("GrayComponent")
	self.btnSelf = self.goBtnSelf:GetComponent("Button")

	function self.onClickDefaultDelegate()
		self:OnClickSelf()
	end

	function self.onEquipLockOverDelegate(id, lock)
		self:OnEquipLockOver(id, lock)
	end

	function self.onEquipUpSuccessDelegate(id)
		self:OnEquipUpSuccess(id)
	end

	function self.onEquipBreakSuccessDelegate(id)
		self:OnEquipBreakSuccess(id)
	end

	for i = 1, 5 do
		self.starPool[i] = self.goStar.transform:Find("Mould_0" .. i).gameObject
	end

	self.goSignClip.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goSignClip")
	self.goWearTag1.transform:Find("Text_01"):GetComponent("Text").text = EquipUIApi:GetString("goDescCurWore")

	if interactive == nil then
		interactive = true
	end

	self.enableClick = interactive

	self:AddListeners()
end

function EquipCell:Refresh(itemData, belongUI, forShow)
	self.itemData = itemData
	self.belongUI = belongUI
	self.forShow = forShow

	self:RefreshMisc()
end

function EquipCell:RefreshByCID(itemCid, belongUI, forShow)
	local itemData = ItemData.CreateByCIDAndNumber(itemCid, 1)

	self:Refresh(itemData, belongUI, forShow)
end

function EquipCell:OnDestroy()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end

function EquipCell:RefreshMisc()
	self.goIcon:SetActive(self.itemData ~= nil)
	self.goStar:SetActive(self.itemData ~= nil)

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

function EquipCell:RefreshOnEmptyData()
	self.goSignNormal:SetActive(false)
	self.goSignSpecial:SetActive(false)
	self.goLock:SetActive(false)
	self.goClassType:SetActive(false)

	if self.goStarUpgradingIcon ~= nil then
		self.goStarUpgradingIcon:SetActive(false)
	end
end

function EquipCell:RefreshOnExistData()
	local cfgData = self.itemData:GetCfg()
	local equipShowInfo, isUsingSkin = EquipModule.GetEquipShowInfo(cfgData.Id)

	self.goSignNormal:SetActive(not isUsingSkin)
	self.goSignSpecial:SetActive(isUsingSkin)
	self.goClassType:SetActive(true)
	self:RefreshLv()

	if self.useSmallIcon == nil then
		if string.find(self.goView.name, "Small") then
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

	self:RefreshStar(self.itemData.equipData.star)
	self.goLock:SetActive(self.itemData.equipData.lock)

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

	AssetUtil.LoadImage(self, EquipUIApi:GetString("goCellFrame", isUsingSkin, cfgData.Quality), imgFrame)
	AssetUtil.LoadImage(self, EquipUIApi:GetString("goCellBg", cfgData.Quality), imgBg)
	AssetUtil.LoadImage(self, EquipUIApi:GetString("goCellMoon", isUsingSkin, cfgData.Quality), imgMoon)
	AssetUtil.LoadImage(self, MiscApi:GetString("equipClassIcon", cfgData.SubType), self.goClassType:GetComponent("Image"))
	self:RefreshStarUpgradingIcon()
end

function EquipCell:RefreshStar(num)
	for i, v in ipairs(self.starPool) do
		v:SetActive(i <= num)
	end
end

function EquipCell:RefreshLv()
	if self.itemData.equipData == nil then
		logError("ItemData[cid:" .. self.itemData.cid .. "]的equipData为空或不是蕴灵")

		return
	end

	local tfLvText = EquipUIApi:GetString("goEquipLv", self.itemData.equipData.lv)
	local tfLv = self.goSignSpecial.transform:Find("Text_Lv"):GetComponent("Text")

	tfLv.text = tfLvText
	tfLv = self.goSignNormal.transform:Find("Text_Lv"):GetComponent("Text")
	tfLv.text = tfLvText
end

function EquipCell:SetCheckVisible(vs)
	self.goCheck:SetActive(vs)
end

function EquipCell:SetWearTag1Visible(vs)
	self.goWearTag1:SetActive(vs)
end

function EquipCell:SetLockMaskVisible(vs)
	if self.goSignLockMask ~= nil then
		self.goSignLockMask:SetActive(vs)
	end
end

function EquipCell:SetNewTagVisible(vs)
	self.goNewTag:SetActive(vs)
end

function EquipCell:SetGray(vs)
	self.goSignClip:SetActive(vs)
	self.grayGroupComp:SetGray(vs)
end

function EquipCell:SetActive(vs)
	self.goView:SetActive(vs)
end

function EquipCell:AddListeners()
	self:RemoveListeners()
	self.btnSelf.onClick:AddListener(self.onClickDefaultDelegate)
	EventDispatcher.AddEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.AddEventListener(EventID.EquipUpSuccess, self.onEquipUpSuccessDelegate)
	EventDispatcher.AddEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
end

function EquipCell:RemoveListeners()
	self.btnSelf.onClick:RemoveListener(self.onClickDefaultDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipLockOver, self.onEquipLockOverDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipUpSuccess, self.onEquipUpSuccessDelegate)
	EventDispatcher.RemoveEventListener(EventID.EquipBreakSuccess, self.onEquipBreakSuccessDelegate)
end

function EquipCell:OnClickSelf()
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

function EquipCell:OnEquipLockOver(id, lock)
	if self.itemData == nil then
		return
	end

	if self.itemData.id == id then
		self.goLock:SetActive(lock)
	end
end

function EquipCell:OnEquipUpSuccess(id)
	if self.itemData == nil then
		return
	end

	if self.itemData.id == id then
		self:RefreshLv()
		self:RefreshStarUpgradingIcon()
	end
end

function EquipCell:OnEquipBreakSuccess(id)
	if self.itemData == nil then
		return
	end

	if self.itemData.id == id then
		self:RefreshStar(self.itemData.equipData.star)
		self:RefreshStarUpgradingIcon()
	end
end

function EquipCell:RefreshStarUpgradingIcon()
	if self.goStarUpgradingIcon == nil then
		return
	end

	local itemData = self.itemData
	local cfgItemData = itemData:GetCfg()
	local maxStar = cfgItemData.StarLimit or 0
	local upgrading = (itemData.equipData.lv > 1 or itemData.equipData.star > 1) and maxStar > itemData.equipData.star
	local cfgQuality = EquipModule.GetCfgQualityByStar(cfgItemData.Id, itemData.equipData.star)

	if cfgQuality == nil then
		logError(string.format("当前装备对应的升星配置不存在。Item cid: %s, star: %s", cfgItemData.Id, itemData.equipData.star))

		return
	end

	local costItemNum = 0
	local allEquips = WarehouseModule.GetItemsByType(Constant.ItemType.Equip)

	for i = 1, #allEquips do
		local lEquipData = allEquips[i]

		if lEquipData.equipData.star == 1 and lEquipData.id ~= itemData.id and lEquipData.cid == itemData.cid then
			costItemNum = costItemNum + 1
		end
	end

	self.goStarUpgradingIcon:SetActive(upgrading and costItemNum >= cfgQuality.CostPainting)
end
