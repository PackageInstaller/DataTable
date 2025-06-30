-- chunkname: @IQIGame\\UI\\Bag\\ItemCell.lua

ItemCell = {
	ForShow = true,
	Interactive = true,
	HideTipsSource = false,
	TagEnum = {
		Extra = 2,
		Random = 4,
		FirstPass = 3,
		New = 1,
		None = 0
	}
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

function ItemCell.GetIn(ui, cellGo)
	if ui.__SUB_UI_MAP_ItemCell == nil then
		return nil
	end

	return ui.__SUB_UI_MAP_ItemCell[cellGo:GetInstanceID()]
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
	self:DisposeComponent()
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
	o:InitComponent()

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

function ItemCell:SetItemByCid(cid, num)
	local itemData = ItemData.CreateByCIDAndNumber(cid, num)

	self:SetItem(itemData)

	return itemData
end

function ItemCell:SetItem(itemCfgOrData)
	self.ItemCfgOrData = itemCfgOrData

	if itemCfgOrData == nil then
		self:Clear()
	else
		self:ShowByItemData(itemCfgOrData)
	end
end

function ItemCell:GetItemType()
	if self.ItemCfgOrData == nil then
		return 0
	end

	return self.ItemCfgOrData:GetCfg().ItemTypes
end

function ItemCell:Update(itemCfgOrData, num)
	local cfgItemData = itemCfgOrData:GetCfg()

	if cfgItemData.IsHide == Constant.ItemHideType.All then
		LuaUtility.SetGameObjectShow(self.ViewGo, false)

		return
	end

	LuaUtility.SetGameObjectShow(self.View.ItemParent, false)
	LuaUtility.SetGameObjectShow(self.View.SkillParent, false)
	LuaUtility.SetGameObjectShow(self.View.Tag, false)
	LuaUtility.SetGameObjectShow(self.View.TagHero, false)
	self:LoadImage(UIGlobalApi.GetIconPath(cfgItemData.Icon), self.iconImageComp)
	self:LoadImage(CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, cfgItemData.Quality), self.iconFarmeImageComp)
	self.ViewGo:SetActive(true)
	self:RefreshItemInfo(cfgItemData)

	if cfgItemData.ItemTypes == Constant.ItemType.Skill then
		self:RefreshSkillInfo(itemCfgOrData)
	end
end

function ItemCell:RefreshItemInfo(cfgItemData)
	LuaUtility.SetGameObjectShow(self.View.ItemParent, true)
	LuaUtility.SetGameObjectShow(self.View.Image_SmallIcon, false)
	LuaUtility.SetGameObjectShow(self.View.Image_SmallIconbg, false)

	if self.View.Image_SmallIcon and (cfgItemData.Id == Constant.ItemCid.GOLD or cfgItemData.Id == Constant.ItemCid.TOLL_MONEY or cfgItemData.Id == Constant.ItemCid.NORMAL_MONEY or cfgItemData.Id == Constant.ItemCid.STRENGTH) then
		self:LoadImage(UIGlobalApi.GetIconPath(cfgItemData.SmallIcon), self.smallIconImageComp)
		LuaUtility.SetGameObjectShow(self.View.Image_SmallIcon, true)
		LuaUtility.SetGameObjectShow(self.View.Image_SmallIconbg, true)
	end
end

function ItemCell:RefreshSkillInfo(itemData)
	local cfgItemData = itemData:GetCfg()
	local skillCid = cfgItemData.LikeId

	LuaUtility.SetGameObjectShow(self.View.SkillParent, true)
	UGUIUtil.SetText(self.View.refineText, itemData.skillData.purifyLv)
	self.View.SkillTypeImg.gameObject:SetActive(false)

	local skillElement = CfgSkillDetailTable[skillCid].Element

	LuaUtility.SetGameObjectShow(self.View.SkillElementImg, skillElement ~= 0)

	if skillElement ~= 0 then
		self:LoadImage(CommonSlotUIApi:GetSkillElement(skillElement), self.skillTypeImageComp)
	end

	local maxSthengthenLv = DiySkillModule.GetSkillMaxStrengthenLevel(skillCid)

	self:__RefreshSkillStrengthenShow(maxSthengthenLv, itemData.skillData.strengLv)
	LuaCodeInterface.SetGameObjectShow(self.View.LvCount, true)
	UGUIUtil.SetText(self.View.LvText, UIGlobalApi.GetLevelText(itemData.skillData.lv))
end

function ItemCell:__RefreshSkillStrengthenShow(maxStrengthenLv, curStrengthenLv)
	if self.starComp == nil then
		self.starComp = self.View.SkillBreachStar:GetComponent("SimpleStarComponent")

		local cells = self.starComp.cells
		local count = cells.Count

		for i = 1, count do
			local simpleStarCell = cells[i - 1]

			self.View["simpleStarCell" .. i] = simpleStarCell.lightPart:GetComponent("Image")
		end
	end

	self.starComp:UpdateView(maxStrengthenLv, curStrengthenLv)
end

function ItemCell:SetNum(num)
	self:SetItemLvVisable(false)

	local numForShow

	if num ~= nil then
		numForShow = num
	else
		numForShow = WarehouseModule.GetItemNumByCfgID(self.ItemCfgOrData.cid)
	end

	LuaUtility.SetGameObjectShow(self.View.HaveCount, true)
	UGUIUtil.SetText(self.View.HaveCountText, tostring(numForShow))
end

function ItemCell:SetCustomNum(needCount, allCount)
	self:SetItemLvVisable(false)
	LuaUtility.SetGameObjectShow(self.View.CostCount, true)

	allCount = allCount == nil and WarehouseModule.GetItemNumByCfgID(self.ItemCfgOrData.cid) or allCount

	LuaUtility.SetGameObjectShow(self.View.CostCount, true)
	UGUIUtil.SetText(self.View.CostText, CommonSlotUIApi:GetRequireNum(needCount, allCount))

	return needCount <= allCount
end

function ItemCell:SetCostAllNumberShow(costNum, allNum)
	self:SetItemLvVisable(false)
	LuaUtility.SetText(self.View.CostText, costNum .. "/" .. allNum)
	LuaUtility.SetGameObjectShow(self.View.CostCount, true)
end

function ItemCell:SetItemLv(lv)
	self:SetItemLvVisable(false)
	LuaUtility.SetGameObjectShow(self.View.LvCount, true)
	UGUIUtil.SetText(self.View.LvText, "Lv." .. lv)
end

function ItemCell:SetItemAddLvShow(lv)
	self:SetItemLvVisable(false)
	LuaUtility.SetGameObjectShow(self.View.LvCount, true)
	UGUIUtil.SetText(self.View.LvText, "+" .. lv)
end

function ItemCell:SetItemLvVisable(state)
	LuaUtility.SetGameObjectShow(self.View.LvCount, state)
	LuaUtility.SetGameObjectShow(self.View.CostCount, state)
	LuaUtility.SetGameObjectShow(self.View.HaveCount, state)
end

function ItemCell:SetLockVisable(state)
	LuaUtility.SetGameObjectShow(self.View.lockImg, state)
end

function ItemCell:SetQualityFrame(state)
	LuaUtility.SetGameObjectShow(self.View.ItemFrame, state)
	LuaUtility.SetGameObjectShow(self.View.EquipQualityImg, state)
end

function ItemCell:SetBottomImg(state)
	return
end

function ItemCell:SetTag(tag)
	LuaUtility.SetGameObjectShow(self.View.Tag, tag ~= Constant.DropItemTag.None)

	if tag == Constant.DropItemTag.None then
		return
	end

	LuaUtility.SetGameObjectShow(self.View.RandomTag, tag == Constant.DropItemTag.Random)
	LuaUtility.SetGameObjectShow(self.View.FirstPassTag, tag == Constant.DropItemTag.FirstPass)
	LuaUtility.SetGameObjectShow(self.View.ExtraTag, tag == Constant.DropItemTag.Extra)
	LuaUtility.SetGameObjectShow(self.View.NewTag, tag == Constant.DropItemTag.New)
	LuaUtility.SetGameObjectShow(self.View.MultipleTag, tag == Constant.DropItemTag.Multiple)
end

function ItemCell:SetHeroTag(heroCid)
	if heroCid == 0 or heroCid == nil then
		LuaUtility.SetGameObjectShow(self.View.TagHero, false)

		return
	end

	self.View.TagHero:SetActive(true)

	local headPath = SkinModule.GetHeroCurrentSkinImgPath(heroCid, Constant.SkinImageType.DetailsHeadIcon)

	AssetUtil.LoadImage(self, headPath, self.View.HeroHeadImg:GetComponent("Image"))
end

function ItemCell:SetSelectFrame(state)
	LuaUtility.SetGameObjectShow(self.View.EquipSelectImg, state)
end

function ItemCell:Clear()
	self.ViewGo:SetActive(false)
end

function ItemCell:LoadImage(path, imageGo)
	AssetUtil.LoadImage(self, path, imageGo, self.OnSuccess, self.OnFail, {
		type = "image",
		gameObject = imageGo
	}, true)
end

function ItemCell:OnSuccess(assetName, asset, duration, userData)
	if userData.type == "image" then
		-- block empty
	end
end

function ItemCell:OnFail(assetName, status, errorMessage, userData)
	self.ViewGo:SetActive(false)
	warning("load icon failure：" .. assetName)
end

function ItemCell:InitComponent()
	self.iconImageComp = self.View.ItemIcon:GetComponent("Image")
	self.skillTypeImageComp = self.View.SkillElementImg:GetComponent("Image")
	self.iconFarmeImageComp = self.View.ItemFrame:GetComponent("Image")
	self.smallIconImageComp = self.View.Image_SmallIcon:GetComponent("Image")
end

function ItemCell:DisposeComponent()
	self.starComp = nil
	self.iconImageComp = nil
	self.skillTypeImageComp = nil
	self.iconFarmeImageComp = nil
	self.smallIconImageComp = nil
end

function ItemCell:__ResetViewShowToDefault()
	LuaCodeInterface.SetGameObjectShow(self.View.Image_Quality, true)
	LuaCodeInterface.SetGameObjectShow(self.View.Image_Icon, true)
	LuaCodeInterface.SetGameObjectShow(self.View.Image_Frame, true)
	LuaCodeInterface.SetGameObjectShow(self.View.HaveCount, false)
	LuaCodeInterface.SetGameObjectShow(self.View.LvCount, false)
	LuaCodeInterface.SetGameObjectShow(self.View.CostCount, false)
	LuaCodeInterface.SetGameObjectShow(self.View.ItemParent, false)
	LuaCodeInterface.SetGameObjectShow(self.View.SkillParent, false)
	LuaCodeInterface.SetGameObjectShow(self.View.equipPartImg, false)
	LuaCodeInterface.SetGameObjectShow(self.View.TagHero, false)
	LuaCodeInterface.SetGameObjectShow(self.View.EquipSelectImg, false)
	LuaCodeInterface.SetGameObjectShow(self.View.Tag, false)
	LuaCodeInterface.SetGameObjectShow(self.View.imageBlock, false)
	LuaCodeInterface.SetGameObjectShow(self.View.imageHadGot, false)
	LuaCodeInterface.SetGameObjectShow(self.View.lockImg, false)
end

function ItemCell:ShowByItemData(itemData)
	if itemData == nil then
		self:Hide()

		return
	end

	local itemCfg = itemData:GetCfg()

	if itemCfg.IsHide == Constant.ItemHideType.All then
		self:Hide()

		return
	end

	LuaCodeInterface.SetGameObjectShow(self.ViewGo, true)
	self:__ShowNormal(itemCfg)

	if itemCfg.ItemTypes == Constant.ItemType.Currency then
		self:__ShowCurrencyInfo(itemCfg, itemData.num)
	elseif itemCfg.ItemTypes == Constant.ItemType.Skill then
		self:RefreshSkillInfo(itemData)
	elseif itemCfg.ItemTypes == Constant.ItemType.Equip then
		self:__ShowEquipInfo(itemData)
	else
		self:__ShowItemInfo(itemCfg, itemData.num)
	end
end

function ItemCell:__ShowNormal(itemCfg)
	self:__ResetViewShowToDefault()
	self:LoadImage(UIGlobalApi.GetIconPath(itemCfg.Icon), self.iconImageComp)
	self:LoadImage(CommonSlotUIApi:GetItemFrame(Constant.ItemType.Item, itemCfg.Quality), self.iconFarmeImageComp)
end

function ItemCell:__ShowCurrencyInfo(itemCfg, num)
	if itemCfg.Id == Constant.ItemCid.GOLD or itemCfg.Id == Constant.ItemCid.TOLL_MONEY or itemCfg.Id == Constant.ItemCid.NORMAL_MONEY or itemCfg.Id == Constant.ItemCid.STRENGTH then
		self:SetCornerMarkActive(true)
	end

	if self.showMoneyNum then
		self:SetItemNumShow(num)
	end
end

function ItemCell:__ShowItemInfo(itemCfg, num)
	self:SetItemNumShow(num)
end

function ItemCell:__ShowEquipInfo(itemData)
	LuaCodeInterface.SetGameObjectShow(self.View.LvCount, true)
	UGUIUtil.SetText(self.View.LvText, UIGlobalApi.GetLevelText(itemData.equipData.lv))
	LuaCodeInterface.SetGameObjectShow(self.View.equipPartImg, false)
end

function ItemCell:SetCornerMarkActive(active)
	if not active then
		LuaCodeInterface.SetGameObjectShow(self.View.ItemParent, false)

		return
	end

	local itemCfg = self.ItemCfgOrData:GetCfg()

	if itemCfg.SmallIcon == nil then
		LuaUtility.SetGameObjectShow(self.View.ItemParent, false)

		return
	end

	LuaCodeInterface.SetGameObjectShow(self.View.ItemParent, true)
	LuaCodeInterface.SetGameObjectShow(self.View.Image_SmallIcon, true)
	LuaCodeInterface.SetGameObjectShow(self.View.Image_SmallIconbg, true)
	self:LoadImage(UIGlobalApi.GetIconPath(itemCfg.SmallIcon), self.smallIconImageComp)
end

function ItemCell:SetItemNumShow(num, showZero)
	num = num == nil and 0 or num

	if num == 0 and not showZero then
		LuaCodeInterface.SetGameObjectShow(self.View.HaveCount, false)

		return
	end

	LuaCodeInterface.SetGameObjectShow(self.View.HaveCount, true)
	UGUIUtil.SetText(self.View.HaveCountText, num)
end

function ItemCell:SetItemLockState(show)
	LuaUtility.SetGameObjectShow(self.View.imageBlock, show)
end

function ItemCell:SetItemAchieveState(show)
	LuaUtility.SetGameObjectShow(self.View.imageHadGot, show)
end

function ItemCell:Hide()
	LuaCodeInterface.SetGameObjectShow(self.ViewGo, false)
end

function ItemCell:Show()
	LuaCodeInterface.SetGameObjectShow(self.ViewGo, true)
end

function ItemCell:SetGrayState(state)
	self.ViewGo:GetComponent("GrayComponent"):SetGray(state)
end
