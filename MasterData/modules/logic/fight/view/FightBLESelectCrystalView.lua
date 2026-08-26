-- chunkname: @modules/logic/fight/view/FightBLESelectCrystalView.lua

module("modules.logic.fight.view.FightBLESelectCrystalView", package.seeall)

local FightBLESelectCrystalView = class("FightBLESelectCrystalView", BaseView)

function FightBLESelectCrystalView:onInitView()
	self.simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self.simageDescBg = gohelper.findChildSingleImage(self.viewGO, "vx/#simage_Dec")
	self.simageLightBg = gohelper.findChildSingleImage(self.viewGO, "#go_Light")
	self.goLight = self.simageLightBg.gameObject
	self.middleItem = gohelper.findChild(self.viewGO, "Middle/#go_CrystalItem")
	self.go4PosContainer = gohelper.findChild(self.viewGO, "Middle/#go_4Slots")
	self.go3PosContainer = gohelper.findChild(self.viewGO, "Middle/#go_3Slots")
	self.go2PosContainer = gohelper.findChild(self.viewGO, "Middle/#go_2Slots")
	self.txtSelectCountTip = gohelper.findChildText(self.viewGO, "Middle/Tips/txt_Tips")
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_Confirm")
	self.btnDisableConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "Middle/#btn_ConfirmDisable")
	self.canSelectCrystalItem1 = gohelper.findChild(self.viewGO, "Left/CrystalItem1/#go_CrystalItem")
	self.canSelectCrystalItem2 = gohelper.findChild(self.viewGO, "Left/CrystalItem2/#go_CrystalItem")
	self.canSelectCrystalItem3 = gohelper.findChild(self.viewGO, "Left/CrystalItem3/#go_CrystalItem")
	self.leftCrystalClick1 = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Left/CrystalItem1/clickarea")
	self.leftCrystalClick2 = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Left/CrystalItem2/clickarea")
	self.leftCrystalClick3 = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Left/CrystalItem3/clickarea")
	self.canSelectCrystalItem1Pos1 = gohelper.findChild(self.viewGO, "Left/CrystalItem1/#go_1Slot")
	self.canSelectCrystalItem1Pos2 = gohelper.findChild(self.viewGO, "Left/CrystalItem1/#go_2Slots")
	self.canSelectCrystalItem1Pos3 = gohelper.findChild(self.viewGO, "Left/CrystalItem1/#go_3Slots")
	self.canSelectCrystalItem2Pos1 = gohelper.findChild(self.viewGO, "Left/CrystalItem2/#go_1Slot")
	self.canSelectCrystalItem2Pos2 = gohelper.findChild(self.viewGO, "Left/CrystalItem2/#go_2Slots")
	self.canSelectCrystalItem2Pos3 = gohelper.findChild(self.viewGO, "Left/CrystalItem2/#go_3Slots")
	self.canSelectCrystalItem3Pos1 = gohelper.findChild(self.viewGO, "Left/CrystalItem3/#go_1Slot")
	self.canSelectCrystalItem3Pos2 = gohelper.findChild(self.viewGO, "Left/CrystalItem3/#go_2Slots")
	self.canSelectCrystalItem3Pos3 = gohelper.findChild(self.viewGO, "Left/CrystalItem3/#go_3Slots")
	self.goDescEmpty = gohelper.findChild(self.viewGO, "Right/#go_Empty")
	self.goDescContainer = gohelper.findChild(self.viewGO, "Right/#scroll_List")
	self.goDescItem = gohelper.findChild(self.goDescContainer, "Viewport/Content/#go_Item")
	self.flyContainer = gohelper.findChild(self.viewGO, "#go_flyItemContent")
	self.flyContainerRect = self.flyContainer:GetComponent(gohelper.Type_RectTransform)
	self.goFly = gohelper.findChild(self.flyContainer, "fly_item")
	self.goFlyScript = gohelper.findChild(self.flyContainer, "#fly")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FightBLESelectCrystalView:addEvents()
	self.btnConfirm:AddClickListener(self.onClickBtnConfirm, self)
	self.btnDisableConfirm:AddClickListener(self.onClickBtnDisableConfirm, self)
end

function FightBLESelectCrystalView:removeEvents()
	self.btnConfirm:RemoveClickListener()
	self.btnDisableConfirm:RemoveClickListener()
end

function FightBLESelectCrystalView:onClickBtnConfirm()
	local selectCount = self:getLogicSelectedCount()

	if selectCount < self.totalSelectCount then
		return
	end

	local blue, purple, green = self:getPerCrystalCount()
	local selectCrystal = tostring(FightHelper.buildCrystalNum(blue, purple, green))

	FightRpc.instance:sendUseClothSkillRequest(0, self.BLEUid, selectCrystal, FightEnum.ClothSkillType.SelectCrystal)
end

function FightBLESelectCrystalView:getPerCrystalCount()
	local blue = 0
	local purple = 0
	local green = 0

	for _, crystal in ipairs(self.selectedCrystalList) do
		if crystal == FightEnum.CrystalEnum.Blue then
			blue = blue + 1
		elseif crystal == FightEnum.CrystalEnum.Purple then
			purple = purple + 1
		elseif crystal == FightEnum.CrystalEnum.Green then
			green = green + 1
		end
	end

	return blue, purple, green
end

function FightBLESelectCrystalView:onClickBtnDisableConfirm()
	return
end

function FightBLESelectCrystalView:onClickLeftCrystal(crystal)
	local totalCount = self:getLogicSelectedCount()

	if totalCount >= self.totalSelectCount then
		return
	end

	local existSelectCount = self.crystalSelectedCountDict[crystal]

	if existSelectCount >= self.oneSelectCount then
		return
	end

	local crystalItemList = self.leftCrystalItemDict[crystal]

	if not crystalItemList then
		return
	end

	existSelectCount = existSelectCount + 1

	local item = crystalItemList[existSelectCount]

	if not item then
		return
	end

	local index = self:getNextEmptyCrystalPos()
	local targetItem = self.middleCrystalItemList[index]

	if not targetItem then
		return
	end

	item.animator:Play("close", 0, 0)

	local flyItem = self.flyMgr:getFlyItem()

	flyItem.crystal = crystal
	flyItem.startIndex = existSelectCount
	flyItem.targetIndex = index

	self.flyMgr:flyItem(flyItem, item.flyAnchorPos, targetItem.flyAnchorPos, self.onFlyDoneCallback, self.onFlyEventCallback, self)

	self.crystalSelectedCountDict[crystal] = existSelectCount
	self.selectedCrystalList[index] = crystal

	AudioMgr.instance:trigger(320002)
end

function FightBLESelectCrystalView:onFlyDoneCallback(flyItem)
	self:refreshSelectedTxt()
	self:refreshBtnActive()
	self:refreshLightVx()
end

local eventName = "refreshUI"

function FightBLESelectCrystalView:onFlyEventCallback(flyItem, event)
	if event == eventName then
		local crystal = flyItem.crystal
		local leftCrystalIndex = flyItem.startIndex
		local middleIndex = flyItem.targetIndex
		local leftItemList = self.leftCrystalItemDict[crystal]
		local leftItem = leftItemList and leftItemList[leftCrystalIndex]

		if leftItem then
			gohelper.setActive(leftItem.goCrystal, false)
		end

		local middleItem = self.middleCrystalItemList[middleIndex]

		if middleItem then
			UISpriteSetMgr.instance:setFightSprite(middleItem.imageCrystal, self.crystalImageNameDict[crystal])
			middleItem.animator:Play("open", 0, 0)
			AudioMgr.instance:trigger(self.middleCrystalAudioDict[crystal])
		end

		self:refreshDescContainerActive()

		for _, descItem in ipairs(self.descItemList) do
			if descItem.crystal == crystal then
				self:refreshOneDescItem(descItem)
				descItem.animator:Play("switch", 0, 0)
			end
		end
	end
end

function FightBLESelectCrystalView:onClickMiddleCrystalItem(index)
	if self.flyMgr:hasFlyingItem() then
		return
	end

	local crystal = self.selectedCrystalList[index]

	crystal = crystal or FightEnum.CrystalEnum.None

	if crystal == FightEnum.CrystalEnum.None then
		return
	end

	local crystalSelectedCount = self.crystalSelectedCountDict[crystal]
	local leftItemList = self.leftCrystalItemDict[crystal]
	local leftItem = leftItemList and leftItemList[crystalSelectedCount]

	if leftItem then
		gohelper.setActive(leftItem.goCrystal, true)
		leftItem.animator:Play("open", 0, 0)
	end

	local targetItem = self.middleCrystalItemList[index]

	if targetItem then
		targetItem.animator:Play("close", 0, 0)
		AudioMgr.instance:trigger(320006)
	end

	self.selectedCrystalList[index] = FightEnum.CrystalEnum.None
	crystalSelectedCount = crystalSelectedCount - 1
	self.crystalSelectedCountDict[crystal] = crystalSelectedCount

	if crystalSelectedCount < 1 then
		self:refreshDesc()
	else
		for _, descItem in ipairs(self.descItemList) do
			if descItem.crystal == crystal then
				self:refreshOneDescItem(descItem)
				descItem.animator:Play("switch", 0, 0)
			end
		end
	end

	self:refreshSelectedTxt()
	self:refreshBtnActive()
	self:refreshLightVx()
end

function FightBLESelectCrystalView:refreshLightVx()
	local selectFull = self:getSelectedCount() >= self.totalSelectCount

	gohelper.setActive(self.goLight, selectFull)

	if selectFull then
		AudioMgr.instance:trigger(320007)
	end
end

function FightBLESelectCrystalView:initLeftCrystalClick()
	self.crystalClickDict = {
		[FightEnum.CrystalEnum.Blue] = self.leftCrystalClick1,
		[FightEnum.CrystalEnum.Purple] = self.leftCrystalClick2,
		[FightEnum.CrystalEnum.Green] = self.leftCrystalClick3
	}

	for crystal, click in pairs(self.crystalClickDict) do
		click:AddClickListener(self.onClickLeftCrystal, self, crystal)
	end
end

function FightBLESelectCrystalView.blockEsc()
	return
end

function FightBLESelectCrystalView:_editableInitView()
	NavigateMgr.instance:addEscape(self.viewName, self.blockEsc)
	self:loadBgImage()

	self.goConfirm = self.btnConfirm.gameObject
	self.goDisableConfirm = self.btnDisableConfirm.gameObject

	gohelper.setActive(self.middleItem, false)
	gohelper.setActive(self.canSelectCrystalItem1, false)
	gohelper.setActive(self.canSelectCrystalItem2, false)
	gohelper.setActive(self.canSelectCrystalItem3, false)
	gohelper.setActive(self.goDescItem, false)
	gohelper.setActive(self.flyContainer, true)
	gohelper.setActive(self.goFly, false)
	gohelper.setActive(self.goFlyScript, false)

	self.maxCount2GoContainerDict = {
		[2] = self:getPosGoList(self.go2PosContainer, 2),
		[3] = self:getPosGoList(self.go3PosContainer, 3),
		[4] = self:getPosGoList(self.go4PosContainer, 4)
	}
	self.crystal1PosListDict = {
		self:getPosGoList(self.canSelectCrystalItem1Pos1, 1),
		self:getPosGoList(self.canSelectCrystalItem1Pos2, 2),
		(self:getPosGoList(self.canSelectCrystalItem1Pos3, 3))
	}
	self.crystal2PosListDict = {
		self:getPosGoList(self.canSelectCrystalItem2Pos1, 1),
		self:getPosGoList(self.canSelectCrystalItem2Pos2, 2),
		(self:getPosGoList(self.canSelectCrystalItem2Pos3, 3))
	}
	self.crystal3PosListDict = {
		self:getPosGoList(self.canSelectCrystalItem3Pos1, 1),
		self:getPosGoList(self.canSelectCrystalItem3Pos2, 2),
		(self:getPosGoList(self.canSelectCrystalItem3Pos3, 3))
	}

	local blueEnum, purpleEnum, greenEnum = FightEnum.CrystalEnum.Blue, FightEnum.CrystalEnum.Purple, FightEnum.CrystalEnum.Green

	self.crystalPosContainerDict = {
		[blueEnum] = self.crystal1PosListDict,
		[purpleEnum] = self.crystal2PosListDict,
		[greenEnum] = self.crystal3PosListDict
	}
	self.crystalSelectItemDict = {
		[blueEnum] = self.canSelectCrystalItem1,
		[purpleEnum] = self.canSelectCrystalItem2,
		[greenEnum] = self.canSelectCrystalItem3
	}
	self.crystalSelectItemDict = {
		[blueEnum] = self.canSelectCrystalItem1,
		[purpleEnum] = self.canSelectCrystalItem2,
		[greenEnum] = self.canSelectCrystalItem3
	}
	self.crystalSelectedCountDict = {
		[blueEnum] = 0,
		[greenEnum] = 0,
		[purpleEnum] = 0
	}
	self.middleCrystalAudioDict = {
		[purpleEnum] = 320003,
		[greenEnum] = 320004,
		[blueEnum] = 320005
	}

	self:initConfig()

	self.leftCrystalItemDict = {}
	self.middleCrystalItemList = {}
	self.selectedCrystalList = {}

	self:initLeftCrystalClick()
	self:initDescItemList()
	self:initFlyMgr()
	self.addEventCb(self, FightController.instance, FightEvent.StartPlayClothSkill, self.closeThis, self, LuaEventSystem.High)
	self.addEventCb(self, FightController.instance, FightEvent.RespUseClothSkillFail, self.closeThis, self, LuaEventSystem.High)
end

function FightBLESelectCrystalView:initFlyMgr()
	self.flyMgr = FightBLESelectCrystalFlyMgr.New()

	self.flyMgr:initView(self.goFly, self.goFlyScript)
end

function FightBLESelectCrystalView:initConfig()
	local enumList = {
		FightEnum.CrystalEnum.Blue,
		FightEnum.CrystalEnum.Purple,
		FightEnum.CrystalEnum.Green
	}

	self.crystalImageNameDict = {}
	self.crystalBgImageNameDict = {}
	self.crystalTextColorDict = {}
	self.crystalNameDict = {}

	for _, enum in ipairs(enumList) do
		local crystalCo = FightHeroSpEffectConfig.instance:getBLECrystalCo(enum)

		self.crystalImageNameDict[enum] = crystalCo.icon
		self.crystalBgImageNameDict[enum] = crystalCo.iconBg
		self.crystalTextColorDict[enum] = "#" .. crystalCo.nameColor
		self.crystalNameDict[enum] = crystalCo.name
	end
end

function FightBLESelectCrystalView:initDescItemList()
	self.descItemList = {}

	table.insert(self.descItemList, self:createDescItem(FightEnum.CrystalEnum.Blue))
	table.insert(self.descItemList, self:createDescItem(FightEnum.CrystalEnum.Green))
	table.insert(self.descItemList, self:createDescItem(FightEnum.CrystalEnum.Purple))
end

function FightBLESelectCrystalView:createDescItem(crystal)
	local descItem = self:getUserDataTb_()

	descItem.go = gohelper.cloneInPlace(self.goDescItem)
	descItem.txtDesc = gohelper.findChildText(descItem.go, "#txt_Descr")
	descItem.txtCrystal = gohelper.findChildText(descItem.go, "#txt_Crystal")
	descItem.txtTag = gohelper.findChildText(descItem.go, "#txt_Crystal/Tag/image_TagBG/#txt_Type")
	descItem.goImageLine = gohelper.findChild(descItem.go, "#txt_Descr/image_Line")
	descItem.goImageCrystal = gohelper.findChild(descItem.go, "#txt_Crystal/crystal_list/#image_Crystal")
	descItem.animator = descItem.go:GetComponent(gohelper.Type_Animator)

	UISpriteSetMgr.instance:setFightSprite(descItem.goImageCrystal:GetComponent(gohelper.Type_Image), self.crystalImageNameDict[crystal])
	SLFramework.UGUI.GuiHelper.SetColor(descItem.txtCrystal, self.crystalTextColorDict[crystal])

	descItem.imageList = {
		descItem.goImageCrystal
	}
	descItem.crystal = crystal

	return descItem
end

function FightBLESelectCrystalView:getPosGoList(goContainer, count)
	local goList = self:getUserDataTb_()

	for i = 1, count do
		local go = gohelper.findChild(goContainer, "Slot" .. i)

		table.insert(goList, go)
	end

	return goList
end

function FightBLESelectCrystalView:getLogicSelectedCount()
	local count = 0

	for _, crystal in ipairs(self.selectedCrystalList) do
		if crystal ~= FightEnum.CrystalEnum.None then
			count = count + 1
		end
	end

	return count
end

function FightBLESelectCrystalView:getSelectedCount()
	local logicSelectCount = self:getLogicSelectedCount()

	return logicSelectCount - self.flyMgr:getFlyingCount()
end

function FightBLESelectCrystalView:getNextEmptyCrystalPos()
	for index, crystal in ipairs(self.selectedCrystalList) do
		if crystal == FightEnum.CrystalEnum.None then
			return index
		end
	end

	logError("selected crystal full!")

	return 1
end

function FightBLESelectCrystalView:onOpen()
	AudioMgr.instance:trigger(320001)

	self.totalSelectCount = self.viewParam.totalSelectCount
	self.oneSelectCount = self.viewParam.oneSelectCount
	self.BLEUid = self.viewParam.BLEUid

	for i = 1, self.totalSelectCount do
		self.selectedCrystalList[i] = FightEnum.CrystalEnum.None
	end

	self:refreshMiddleCrystalContainerActive()
	self:initMiddleCrystal()
	self:refreshMiddleCrystal()
	self:refreshLeftCrystalContainerActive()
	self:initLeftCrystal()
	self:refreshLeftCrystal()
	self:refreshSelectedTxt()
	self:refreshBtnActive()
	self:refreshDesc()
	self:refreshLightVx()
end

function FightBLESelectCrystalView:refreshDesc()
	self:refreshDescContainerActive()

	for _, descItem in ipairs(self.descItemList) do
		self:refreshOneDescItem(descItem)
	end
end

function FightBLESelectCrystalView:refreshDescContainerActive()
	local selectCount = self:getLogicSelectedCount()

	if selectCount < 1 then
		gohelper.setActive(self.goDescEmpty, true)
		gohelper.setActive(self.goDescContainer, false)

		return
	end

	gohelper.setActive(self.goDescEmpty, false)
	gohelper.setActive(self.goDescContainer, true)
end

function FightBLESelectCrystalView:refreshOneDescItem(descItem)
	local crystal = descItem.crystal
	local selectCount = self.crystalSelectedCountDict[descItem.crystal]

	selectCount = selectCount or 0

	local hasSelected = selectCount >= 1

	gohelper.setActive(descItem.go, hasSelected)

	if hasSelected then
		local desc, tag = FightHeroSpEffectConfig.instance:getBLECrystalDescAndTag(crystal, selectCount)

		descItem.txtDesc.text = desc
		descItem.txtTag.text = tag
		descItem.txtCrystal.text = string.format("%s×%s", self.crystalNameDict[crystal], selectCount)

		for i = 1, selectCount do
			local goImage = descItem.imageList[i]

			if not goImage then
				goImage = gohelper.cloneInPlace(descItem.goImageCrystal)

				table.insert(descItem.imageList, goImage)
			end

			gohelper.setActive(goImage, true)
		end

		for i = selectCount + 1, #descItem.imageList do
			gohelper.setActive(descItem.imageList[i], false)
		end
	end
end

function FightBLESelectCrystalView:refreshBtnActive()
	local selectFull = self:getSelectedCount() >= self.totalSelectCount

	gohelper.setActive(self.goConfirm, selectFull)
	gohelper.setActive(self.goDisableConfirm, not selectFull)
end

function FightBLESelectCrystalView:refreshSelectedTxt()
	self.txtSelectCountTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("BLE_select_crystal"), self:getSelectedCount(), self.totalSelectCount)
end

function FightBLESelectCrystalView:refreshLeftCrystal()
	self:refreshOneLeftCrystal(FightEnum.CrystalEnum.Blue)
	self:refreshOneLeftCrystal(FightEnum.CrystalEnum.Green)
	self:refreshOneLeftCrystal(FightEnum.CrystalEnum.Purple)
end

function FightBLESelectCrystalView:refreshOneLeftCrystal(crystal)
	local crystalItemList = self.leftCrystalItemDict[crystal]
	local selectCount = self.crystalSelectedCountDict[crystal]

	for index, item in ipairs(crystalItemList) do
		local selected = index <= selectCount

		gohelper.setActive(item.goCrystal, not selected)
	end
end

function FightBLESelectCrystalView:refreshMiddleCrystal()
	for i = 1, self.totalSelectCount do
		local middleItem = self.middleCrystalItemList[i]
		local selectCrystal = self.selectedCrystalList[i]

		selectCrystal = selectCrystal or FightEnum.CrystalEnum.None

		local isEmpty = selectCrystal == FightEnum.CrystalEnum.None

		if isEmpty then
			middleItem.animator:Play("close", 0, 1)
		else
			UISpriteSetMgr.instance:setFightSprite(middleItem.imageCrystal, self.crystalImageNameDict[selectCrystal])
			middleItem.animator:Play("open", 0, 1)
		end
	end
end

function FightBLESelectCrystalView:initMiddleCrystal()
	local posList = self.maxCount2GoContainerDict[self.totalSelectCount]

	for i = 1, self.totalSelectCount do
		local goItem = gohelper.clone(self.middleItem, posList[i])

		gohelper.setActive(goItem, true)
		table.insert(self.middleCrystalItemList, self:createMiddleItem(goItem, i))
	end
end

function FightBLESelectCrystalView:createMiddleItem(go, index)
	local middleItem = self:getUserDataTb_()

	middleItem.go = go
	middleItem.goEmpty = gohelper.findChild(go, "#go_Empty")
	middleItem.goCrystal = gohelper.findChild(go, "#Crystal_item")
	middleItem.imageCrystal = gohelper.findChildComponent(middleItem.goCrystal, "#image_Crystal", gohelper.Type_Image)
	middleItem.click = gohelper.findChildClickWithDefaultAudio(go, "clickarea")

	middleItem.click:AddClickListener(self.onClickMiddleCrystalItem, self, index)

	middleItem.animator = go:GetComponent(gohelper.Type_Animator)
	middleItem.flyAnchorPos = self:getFlyAnchorPos(go)

	return middleItem
end

function FightBLESelectCrystalView:initLeftCrystal()
	self:initOneCrystalSelectArea(FightEnum.CrystalEnum.Blue)
	self:initOneCrystalSelectArea(FightEnum.CrystalEnum.Purple)
	self:initOneCrystalSelectArea(FightEnum.CrystalEnum.Green)
end

function FightBLESelectCrystalView:initOneCrystalSelectArea(crystalEnum)
	local posList = self.crystalPosContainerDict[crystalEnum][self.oneSelectCount]
	local item = self.crystalSelectItemDict[crystalEnum]
	local itemList = self:getUserDataTb_()

	for i = 1, self.oneSelectCount do
		local goItem = gohelper.clone(item, posList[i])

		gohelper.setActive(goItem, true)
		table.insert(itemList, self:createLeftCrystalItem(goItem, crystalEnum))
	end

	self.leftCrystalItemDict[crystalEnum] = itemList
end

function FightBLESelectCrystalView:createLeftCrystalItem(go, crystalEnum)
	local crystalItem = self:getUserDataTb_()

	crystalItem.go = go
	crystalItem.imageCrystalBg = gohelper.findChildImage(go, "#image_SlotBG")
	crystalItem.imageCrystal = gohelper.findChildImage(go, "#Crystal_item/#image_Crystal")
	crystalItem.goCrystal = gohelper.findChild(go, "#Crystal_item")

	UISpriteSetMgr.instance:setFightSprite(crystalItem.imageCrystalBg, self.crystalBgImageNameDict[crystalEnum])
	UISpriteSetMgr.instance:setFightSprite(crystalItem.imageCrystal, self.crystalImageNameDict[crystalEnum])

	crystalItem.animator = go:GetComponent(gohelper.Type_Animator)

	crystalItem.animator:Play("open", 0, 0)

	crystalItem.flyAnchorPos = self:getFlyAnchorPos(go)

	return crystalItem
end

function FightBLESelectCrystalView:getFlyAnchorPos(goObj)
	local screenPos = recthelper.uiPosToScreenPos(goObj.transform)

	return (recthelper.screenPosToAnchorPos(screenPos, self.flyContainerRect))
end

function FightBLESelectCrystalView:refreshLeftCrystalContainerActive()
	gohelper.setActive(self.canSelectCrystalItem1Pos1, self.oneSelectCount == 1)
	gohelper.setActive(self.canSelectCrystalItem1Pos2, self.oneSelectCount == 2)
	gohelper.setActive(self.canSelectCrystalItem1Pos3, self.oneSelectCount == 3)
	gohelper.setActive(self.canSelectCrystalItem2Pos1, self.oneSelectCount == 1)
	gohelper.setActive(self.canSelectCrystalItem2Pos2, self.oneSelectCount == 2)
	gohelper.setActive(self.canSelectCrystalItem2Pos3, self.oneSelectCount == 3)
	gohelper.setActive(self.canSelectCrystalItem3Pos1, self.oneSelectCount == 1)
	gohelper.setActive(self.canSelectCrystalItem3Pos2, self.oneSelectCount == 2)
	gohelper.setActive(self.canSelectCrystalItem3Pos3, self.oneSelectCount == 3)
end

function FightBLESelectCrystalView:refreshMiddleCrystalContainerActive()
	gohelper.setActive(self.go2PosContainer, self.totalSelectCount == 2)
	gohelper.setActive(self.go3PosContainer, self.totalSelectCount == 3)
	gohelper.setActive(self.go4PosContainer, self.totalSelectCount == 4)
end

function FightBLESelectCrystalView:loadBgImage()
	self.simageFullBG:LoadImage("singlebg/fight/beilier/beilier_selectcrystal_fullbg.png")
	self.simageDescBg:LoadImage("singlebg/fight/beilier/beilier_selectcrystal_dec1.png")
	self.simageLightBg:LoadImage("singlebg/fight/beilier/beilier_selectcrystal_dec2.png")
end

function FightBLESelectCrystalView:unLoadBgImage()
	self.simageFullBG:UnLoadImage()
	self.simageDescBg:UnLoadImage()
	self.simageLightBg:UnLoadImage()
end

function FightBLESelectCrystalView:onClose()
	if self.flyMgr then
		self.flyMgr:stopAll()
	end

	AudioMgr.instance:trigger(320008)
end

function FightBLESelectCrystalView:onDestroyView()
	if self.flyMgr then
		self.flyMgr:destroy()

		self.flyMgr = nil
	end

	if self.crystalClickDict then
		for _, click in pairs(self.crystalClickDict) do
			click:RemoveClickListener()
		end
	end

	if self.middleCrystalItemList then
		for _, middleItem in ipairs(self.middleCrystalItemList) do
			middleItem.click:RemoveClickListener()
		end
	end

	self:unLoadBgImage()
end

return FightBLESelectCrystalView
