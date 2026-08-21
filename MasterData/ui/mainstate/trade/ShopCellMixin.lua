-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\ShopCellMixin.lua

local ResColor = require("ClientData/ResColor")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local ResQuailtyResourcesConfig = require("ClientData/ResQuailtyResourcesConfig")
local ShopCellMixin = {}
local ShopCellBaseMixin = require("UI/MainState/Trade/ShopCellBaseMixin")

MixinClass(ShopCellMixin, ShopCellBaseMixin)

function ShopCellMixin:ctorMixin(clickEnabled, checkNeedConvertObject)
	self.checkNeedConvertObject = checkNeedConvertObject

	self:initUI(clickEnabled)

	self.remainLabelColor = ResColor.WHITE
end

function ShopCellMixin:initUI(clickEnabled)
	self:initBaseUI(clickEnabled)

	self.btnSelf = UIControls.Button(self, "")
	self.panelContent = UIControls.Panel(self, "ContentPanel")
	self.imgIcon = UIControls.Image(self, "ContentPanel/Icon")
	self.itemBgPanel = UIControls.Panel(self, "ContentPanel/IconBadge")
	self.imgIconBG = UIControls.Image(self, "ContentPanel/IconBadge/Bg")
	self.imgIcon2 = UIControls.Image(self, "ContentPanel/IconBadge/Icon")
	self.panelFragIcon = UIControls.Panel(self, "ContentPanel/IconShatter")
	self.imgFragIcon = UIControls.Image(self, "ContentPanel/IconShatter/Mask/Icon")
	self.txtName = UIControls.Label(self, "ContentPanel/TextName")
	self.txtNum = UIControls.ShortNumLabel(self, "ContentPanel/BgNum/TextNum")
	self.imgNumBg = UIControls.Image(self, "ContentPanel/BgNum")
	self.imgQuality = UIControls.Image(self, "ContentPanel/ImgQuality")

	if UIControls.checkControlFunc(self, "ContentPanel/ImgQualityPet") then
		self.imgQualityPet = UIControls.Image(self, "ContentPanel/ImgQualityPet")
	end

	self.txtLimit = UIControls.Label(self, "ContentPanel/TextLimit")
	self.panelMoney = UIControls.Panel(self, "ContentPanel/PricePanel")
	self.imgMoney = UIControls.Image(self, "ContentPanel/PricePanel/IconCurrency")
	self.txtMoney = UIControls.ShortNumLabel(self, "ContentPanel/PricePanel/TextPrice")
	self.panelMoneyDiscount = UIControls.Panel(self, "ContentPanel/DiscountPanel")
	self.txtMoneyDc = UIControls.ShortNumLabel(self, "ContentPanel/DiscountPanel/TextPrice")
	self.txtRateDc = UIControls.Label(self, "ContentPanel/DiscountPanel/ImgDiscount/TextDiscount")
	self.imgCommand = UIControls.Image(self, "ContentPanel/IconSp")
	self.panelEquip = UIControls.Panel(self, "ContentPanel/EquipPanel")
	self.imgEquipSuit = UIControls.Image(self, "ContentPanel/EquipPanel/IconSuit")
	self.txtEquipStar = UIControls.Label(self, "ContentPanel/EquipPanel/StarPanel/Text")
	self.imgEquipStep = UIControls.Image(self, "ContentPanel/EquipPanel/StarPanel/Icon")
	self.panelStar = UIControls.Panel(self, "ContentPanel/EquipPanel/StarPanel")
	self.equipBgHero = UIControls.Panel(self, "ContentPanel/EquipPanel/BgHero")
	self.equipImgHero = UIControls.Image(self, "ContentPanel/EquipPanel/BgHero/IconHero")
	self.panelFrag = UIControls.Panel(self, "ContentPanel/ShatterPanel")
	self.imgFragStar = UIControls.Image(self, "ContentPanel/ShatterPanel/ImgStar")
	self.imgFragLimit = UIControls.Image(self, "ContentPanel/ShatterPanel/ImgLimit")
	self.imgArtifactCareer = UIControls.Image(self, "ContentPanel/IconCareer")

	self.btnSelf:setEnable(clickEnabled)
	self.txtLimit:setJumpDisplayMode(UIControls.Label.JumpDisplayMode.TIME)
	self.txtLimit:setJumpPostfixByMode(UIControls.Label.JumpAttachType.DAY_POSTFIX, Lang.get(30548))

	if UIControls.checkControlFunc(self, "ContentPanel/BackpackNumPanel/NumText") then
		self.panelNum = UIControls.Panel(self, "ContentPanel/BackpackNumPanel")
		self.textHasNum = UIControls.Label(self, "ContentPanel/BackpackNumPanel/NumText")
	end

	if UIControls.checkControlFunc(self, "ContentPanel/TimePanel") then
		self.panelTimeLimit = UIControls.Panel(self, "ContentPanel/TimePanel")
		self.textTimeLimit = UIControls.Label(self, "ContentPanel/TimePanel/TimeText")
	end

	if UIControls.checkControlFunc(self, "ContentPanel/IconChange") then
		self.animContentPanel = UIControls.UIAni(self, "ContentPanel")
		self.mask = UIControls.Panel(self, "ContentPanel/Mask")
		self.iconChange = UIControls.Panel(self, "ContentPanel/IconChange")
		self.changeImgIcon = UIControls.Image(self, "ContentPanel/Mask/Icon")
		self.changeImgQuality = UIControls.Image(self, "ContentPanel/Mask/ImgQuality")
		self.changeTextNum = UIControls.ShortNumLabel(self, "ContentPanel/Mask/TextNum")
	end

	if UIControls.checkControlFunc(self, "ContentPanel/ImgHad") then
		self.imgHadSkin = UIControls.Image(self, "ContentPanel/ImgHad")
	end

	if UIControls.checkControlFunc(self, "ContentPanel/TextGemLv") then
		self.txtPetGemLv = UIControls.Label(self, "ContentPanel/TextGemLv")
	end
end

function ShopCellMixin:setQualityAtlsPath(shopCellImgAtlsPath)
	self.shopCellImgAtlsPath = shopCellImgAtlsPath
end

function ShopCellMixin:checkFurnitrueUI(...)
	if not self.panelFurniture and UIControls.checkControlFunc(self, "ContentPanel/FurniturePanel") then
		self.panelFurniture = UIControls.Panel(self, "ContentPanel/FurniturePanel")
		self.panelKg = UIControls.Panel(self, "ContentPanel/FurniturePanel/BgKg")
		self.panelComfort = UIControls.Panel(self, "ContentPanel/FurniturePanel/BgComfortable")
		self.txtKg = UIControls.Label(self, "ContentPanel/FurniturePanel/BgKg/TextNum")
		self.txtComfort = UIControls.Label(self, "ContentPanel/FurniturePanel/BgComfortable/TextNum")
		self.imgAttrFlag = UIControls.Image(self, "ContentPanel/FurniturePanel/IconAttr")
	end
end

function ShopCellMixin:setData(shopItem, shopDiscountRate)
	if shopItem == nil then
		self:setVisible(false)

		return
	end

	self.item = shopItem

	self:checkBasePanel(shopItem)
	self:updateState(shopItem)
	self:updateNameAndCount(shopItem)
	self:updateIcon(shopItem)
	self:updateItem(shopItem)
	self:updateLimitAndQuality(shopItem)
	self:updateMoney(shopItem)
	self:_setData()
	self:RefreshConvertObject()
	self:setVisible(true)
end

function ShopCellMixin:_setData()
	return
end

function ShopCellMixin:updateState(shopItem)
	if shopItem.updateState then
		shopItem:updateState()
	end
end

function ShopCellMixin:updateMoney(shopItem)
	local data = shopItem.data
	local moneyInfo = data.use[1]
	local moneyPath = ClientUtils.getMoneyIcon(moneyInfo.ID)

	if moneyPath then
		self.imgMoney:setImage(moneyPath[1], moneyPath[2])
	else
		local itemPath = BaseObject.getItemIconPath(moneyInfo.ID)

		if itemPath then
			self.imgMoney:setImage(itemPath[1], itemPath[2])
		end
	end

	local hasDiscount = moneyInfo.rate ~= nil

	self.showDiscount = hasDiscount and not shopItem:isSoldOut() and shopItem.sellStyle == nil

	self.panelMoneyDiscount:setVisible(self.showDiscount)

	if self.showDiscount then
		local discountV = moneyInfo.rate or 10

		if Const.SHOP_DISCOUNT_MODE == 1 then
			discountV = 100 - discountV * 10
		end

		local a, b = math.modf(discountV)
		local strFormat = "%s"

		if b > 0 then
			strFormat = "%.1f"
		end

		self.txtRateDc:setText(string.format(strFormat, discountV))
	end

	if hasDiscount then
		self.txtMoney:setNum(moneyInfo.discount)

		self.discountShowStr = moneyInfo.original or moneyInfo.discount

		self.txtMoneyDc:setNum(self.discountShowStr)
		self.txtMoney:setFontColor(ResColor.GREY)
	else
		self.txtMoney:setNum(moneyInfo.discount)
	end

	if self.textHasNum then
		local hasNum = shopItem:getItemHasNum()

		if hasNum then
			self.panelNum:setVisible(true)
			self.textHasNum:setText(hasNum)
			self.imgFragStar:setVisible(false)
		else
			self.panelNum:setVisible(false)
		end
	end

	if self.panelTimeLimit then
		local timeLimit = shopItem:getDisappearTime()

		if timeLimit and timeLimit > 0 then
			self.panelTimeLimit:setVisible(true)
			ClientTimerManager.AddSecondFormatTickUI(self.textTimeLimit, timeLimit, false, Lang.get(48674), nil, nil, 1)
		else
			local relateActTime = shopItem:getRelateActEndTime()

			if relateActTime and relateActTime > 0 then
				self.panelTimeLimit:setVisible(true)
				ClientTimerManager.AddSecondFormatTickUI(self.textTimeLimit, relateActTime, false, Lang.get(48674), nil, nil, 1)
			else
				self.panelTimeLimit:setVisible(false)
				ClientTimerManager.RemoveSecondTickUI(self.textTimeLimit)
			end
		end
	end
end

function ShopCellMixin:updateNameAndCount(shopItem)
	local sellStyle = shopItem.sellStyle
	local sellStylePath = shopItem.sellStylePath

	if sellStyle and sellStylePath then
		self.imgCommand:setImage("Atlas/" .. sellStylePath, sellStyle)
		self.imgCommand:setVisible(true)
	else
		self.imgCommand:setVisible(false)
	end

	local isSoldOut = shopItem:isSoldOut()
	local isLocked = shopItem:isLocked()
	local isRelateLimited = shopItem.isRelateLimited

	self.panelContent:setObjGray(isSoldOut or isLocked or isRelateLimited)

	local object = shopItem.object

	self.txtName:setText(object.name)
	self.imgNumBg:setVisible(shopItem.buyNum > 1)

	if shopItem.buyNum > 1 then
		self.txtNum:setNum(shopItem.buyNum, "x")
	else
		self.txtNum:setText("")
	end
end

function ShopCellMixin:updateItem(shopItem)
	local object = shopItem.object
	local isEquip = object:isEquip()
	local isFrag = object:isFragmentItem()
	local isArtifact = object:isArtifact()
	local isFurniture = object:isFurniture()
	local isSkin = object:isSkin()
	local isPetGem = object:isPetGem()

	if self.imgHadSkin then
		self.imgHadSkin:setVisible(false)
	end

	self.panelEquip:setVisible(isEquip)
	self.panelFrag:setVisible(isFrag)
	self.imgArtifactCareer:setVisible(isArtifact)

	if isFurniture then
		self:checkFurnitrueUI()
	end

	if self.panelFurniture then
		self.panelFurniture:setVisible(isFurniture)
	end

	if isEquip then
		local showObject = object

		if shopItem.data and shopItem.data.preview_id then
			showObject = BaseObject.GetObject(shopItem.data.preview_id, object.num)
		end

		local suitPath = showObject:getSuitPath()

		if suitPath then
			self.imgEquipSuit:setVisible(true)
			self.imgEquipSuit:setImage(suitPath[1], suitPath[2])
		else
			self.imgEquipSuit:setVisible(false)
		end

		if showObject:isDefineHeroEquip() then
			local fakeHero = BaseObject.GetObject(showObject.resDefineEffctData[1].hero_id)
			local iconPath = fakeHero:getQIconPath()

			self.equipBgHero:setVisible(true)
			self.panelStar:setVisible(false)

			if iconPath then
				self.equipImgHero:setImage(iconPath[1], iconPath[2])
			end
		else
			self.panelStar:setVisible(true)
			self.equipBgHero:setVisible(false)

			local stepPath = showObject:getEquipStepPath()

			if stepPath then
				self.imgEquipStep:setVisible(true)
				self.imgEquipStep:setImage(stepPath[1], stepPath[2])
			else
				self.imgEquipStep:setVisible(false)
			end
		end
	elseif isFrag then
		local starPath = object:getFragHeroStarPath()
		local isLimitFrag = shopItem:isLimitFrag()

		if starPath then
			self.imgFragStar:setImage(starPath[1], starPath[2])
		end

		self.imgFragStar:setVisible(starPath ~= nil)
		self.imgFragLimit:setVisible(isLimitFrag)

		if isLimitFrag then
			local imgName = "TxtLimited"
			local imgPath = "StoreAtlas/StoreAtlas"

			if shopItem.data.relate_img then
				imgName = shopItem.data.relate_img
				imgPath = shopItem.data.relate_img_path
			end

			self.imgFragLimit:setImage("Atlas/" .. imgPath, imgName)
		end
	elseif isArtifact then
		local careerPath = object:getCareerIconPath()

		if careerPath then
			self.imgArtifactCareer:setImage(careerPath[1], careerPath[2])
		end
	elseif isFurniture and self.panelFurniture then
		local info = RearHouseCommon.getFurnitureInfo(object.id)

		if info then
			local isWeightType = RearHouseCommon.isWeightType(info.type_id)

			if isWeightType then
				self.panelKg:setVisible(true)
				self.txtKg:setText(info.weight or 0)
			else
				self.panelKg:setVisible(false)
			end

			self.txtComfort:setText(info.comfortable or 0)
			self.imgAttrFlag:setVisible(RearHouseCommon.isAttrFurniture(object.id))
		end
	elseif isSkin and self.imgHadSkin then
		self.imgHadSkin:setVisible(object:isGet())
	elseif isPetGem and self.txtPetGemLv then
		self.txtPetGemLv:setVisible(true)

		if Const.REVIEW_VERSION then
			self.txtPetGemLv:setText(Lang.get(1203) .. object.level)
		else
			self.txtPetGemLv:setText("Lv." .. object.level)
		end
	elseif self.imgHadSkin and shopItem:checkHasLimit() then
		self.imgHadSkin:setVisible(true)
	end
end

function ShopCellMixin:updateIcon(shopItem)
	local object = shopItem.object
	local resId = object.id
	local iconPath = object:getIconPath()

	self.panelFragIcon:setVisible(false)
	self.imgIcon:setVisible(false)
	self.itemBgPanel:setVisible(false)

	if iconPath then
		local isFrag = object:isFragmentItem()
		local isArtifact = object:isArtifact()

		if isFrag then
			self.panelFragIcon:setVisible(true)
			self.imgFragIcon:setImage(iconPath[1], iconPath[2])
		elseif isArtifact == true then
			local bgPath = object:getCareerBgIconPath()

			self.itemBgPanel:setVisible(true)
			self.imgIconBG:setImage(bgPath[1], bgPath[2])
			self.imgIcon2:setImage(iconPath[1], iconPath[2])
		else
			self.imgIcon:setVisible(true)
			self.imgIcon:setImage(iconPath[1], iconPath[2])
		end
	end
end

function ShopCellMixin:RefreshConvertObject()
	if self.iconChange then
		local object = self.item.object
		local checkConvertObject = self.checkNeedConvertObject and not self.item:isSoldOut() and BaseObject.checkConvertObject(object)

		self.mask:setVisible(checkConvertObject)
		self.iconChange:setVisible(checkConvertObject)

		if checkConvertObject then
			local convertObj = BaseObject.getConvertObject(object)
			local iconPath = convertObj:getIconPath()

			if iconPath then
				self.changeImgIcon:setImage(iconPath[1], iconPath[2])
			end

			if convertObj.num and convertObj.num > 1 then
				self.changeTextNum:setNum(convertObj.num, "x")
			else
				self.changeTextNum:setText("")
			end

			self.animContentPanel:startAniLoop("LoopChangeStore")
		else
			self.animContentPanel:stopAni("LoopChangeStore")
		end
	end
end

function ShopCellMixin:updateLimitAndQuality(shopItem)
	self:checkLocked(shopItem)

	local isSoldOut = shopItem:isSoldOut()
	local isLocked = shopItem:isLocked()
	local isRelateLimited = shopItem.isRelateLimited
	local itemQuality = Const.ITEM_QUALITY_UNKNOWN
	local hintColor = ResColor.GREYLIGHT

	if isSoldOut or isLocked or isRelateLimited then
		-- block empty
	else
		itemQuality = shopItem.object.quality
		hintColor = self.remainLabelColor
	end

	if itemQuality == 10 then
		itemQuality = 6
	end

	self.txtLimit:setFontColor(hintColor)

	local staticHint, recoverTick = shopItem:getHint()

	if staticHint then
		self.txtLimit:setText(staticHint, false, true)
	else
		self.txtLimit:jumpTo(recoverTick, 0, recoverTick)
	end

	if self.imgQualityPet then
		self.imgQuality:setVisible(false)
		self.imgQualityPet:setVisible(true)

		local qualityPath = UIConst.SHOP_PET_QUALITY_CONFIG[itemQuality]

		if qualityPath then
			self.imgQualityPet:setImage(qualityPath[1], qualityPath[2])
		end
	else
		self.imgQuality:setVisible(true)

		if self.shopCellImgAtlsPath then
			local configId = tonumber(self.shopCellImgAtlsPath)
			local config = ResQuailtyResourcesConfig[configId]

			if config and config[itemQuality] then
				self.imgQuality:setImage(config[itemQuality].atlas_path, config[itemQuality].image_name)
			end
		else
			local qualityPath = UIConst.SHOP_QUALITY_CONFIG[itemQuality]

			if qualityPath then
				self.imgQuality:setImage(qualityPath[1], qualityPath[2])
			end
		end
	end
end

return ShopCellMixin
