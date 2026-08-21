-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/CharacterEquipFragmentViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.CharacterEquipFragmentViewNew", package.seeall)

local M = class("CharacterEquipFragmentViewNew", CharacterMainSystemSubViewBase)

function M:ctor()
	M.super.ctor(self)
end

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.Equip
end

function M:buildUI()
	M.super.buildUI(self)

	local mainGO = self._registry:getMainGO()
	local imageGo = self:getGo("equip_main_panel_1501905091")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, CharacterEquipSuitModelComponent)

	local propertyListGo = self:getGo("equip_main_panel_1282724208")

	self._propertyItemList = {}

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = goutil.findChild(propertyListGo, "propertyItem" .. index)

		table.insert(self._propertyItemList, propertyItemGo)
	end

	self._suitListGo = self:getGo("equip_main_panel_1358588858")

	self._suitListGo:SetActive(false)

	self._txtSuitDesc = goutil.findChild(self._suitListGo, "txtSuitDesc")

	goutil.setActive(self._txtSuitDesc, false)

	self._btnSuitDesc = self:getBtn("equip_main_panel_-1580467450")
	self._txtSuitTitle = goutil.findChildTextComponent(self._suitListGo, "txtSuitTitle")
	self._txtEmptyGo = self:getGo("equip_main_panel_-1311851756")
	self._imgEmptyGo = self:getGo("equip_main_panel_-681477342")

	local suitAniGo = self:getGo("equip_main_panel_1358588858")

	self._suitAni = suitAniGo:GetComponent(ComponentType.Animation)
	self._btnAttrTips = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "rightContent/btnDetail"))
	self._btnChange = UIComponentType.ButtonAdapter(goutil.findChild(mainGO, "rightContent/btnChange"))
	self._redGo = goutil.findChild(self._btnChange.gameObject, "redPointRoot/red_point")
	self._isOtherPlayer = false
end

function M:destroyUI()
	M.super.destroyUI(self)
	self:_clearDescSuitAttr()
	removetimer(self.playSuitEffect, self)
end

function M:bindEvents()
	self._btnAttrTips:AddClickListener(self._onClickAttrTips, self)
	self._btnChange:AddClickListener(self._onClickChangeEquip, self)
	self._btnSuitDesc:AddClickListener(self._onClickSuitDesc, self)
	GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
end

function M:unbindEvents()
	self._btnAttrTips:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnSuitDesc:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
end

function M:onEnter()
	M.super.onEnter(self)

	self._tipsShowed = false

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	self._equipModelComponent:onEnter()
	self:_setRedPoint()
	self:_refreshAll()
end

function M:onExit()
	self._equipModelComponent:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
end

function M:_refreshAll(isPlayEquipAni)
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false

	local filterCfg = EquipController.instance:getEchoFilterCfg()

	filterCfg:setCareerFilterType(self._heroData:getCareer())

	local equipHeroData = self._heroData:getHeroEquipData()
	local heroTags = HeroDepotModel.instance:getCurViewPageHeroTags(false)
	local isEmpty = not equipHeroData:isAnlyPartHasEquip()

	self:setEmpty(isEmpty)

	local attrList = equipHeroData:getAllEquipAttr()

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = self._propertyItemList[index]

		if attrList[index] then
			propertyItemGo:SetActive(true)

			goutil.findChildTextComponent(propertyItemGo, "txtStatic").text = attrList[index].name
			goutil.findChildTextComponent(propertyItemGo, "txtNum").text = attrList[index].num
		else
			propertyItemGo:SetActive(false)
		end
	end

	local suitId = equipHeroData:getAvailableSuitId()

	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)

		self._txtSuitTitle.text = suitData:getName()

		self:_clearDescSuitAttr()

		local suitDescList = suitData:getSuit3DescList(heroTags)

		for _, descAttr in ipairs(suitDescList) do
			local itemGo = goutil.clone(self._txtSuitDesc)

			itemGo:SetActive(true)

			local txtSuitAttribute = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

			if txtSuitAttribute then
				txtSuitAttribute.text = descAttr
			end

			local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(itemGo, "click"))

			btnClick:AddClickListener(function()
				self:_onClickSuitDescDyn(itemGo)
			end, self)
			goutil.addChildToParent(itemGo, self._suitListGo)
		end

		self:openSuitAni()
		self._suitListGo:SetActive(true)
		self._txtEmptyGo:SetActive(false)
	else
		self._suitListGo:SetActive(false)
		self._txtEmptyGo:SetActive(true)
	end

	self:refreshEquipModel(suitId)
	equipHeroData:checkForRedPoint()
end

function M:_clearDescSuitAttr()
	local trs = self._suitListGo.transform
	local count = trs.childCount

	for i = count, 1, -1 do
		local child = trs:GetChild(i - 1).gameObject

		if child.name == "txtSuitDesc(Clone)" then
			local btnClick = UIComponentType.ButtonAdapter(goutil.findChild(child, "click"))

			btnClick:RemoveClickListener()
			UnityEngine.GameObject.Destroy(child.gameObject)
		end
	end
end

function M:setEmpty(isEmpty)
	goutil.setActive(self._imgEmptyGo, true)

	if not self._emptyGoGet then
		self._emptyImg1 = goutil.findChild(self._imgEmptyGo, "img1")
		self._emptyImg2 = goutil.findChild(self._imgEmptyGo, "img2")
		self._emptyImg3 = goutil.findChild(self._imgEmptyGo, "img3")
		self._modelGo1 = goutil.findChild(self._imgEmptyGo, "Image (4)")
		self._modelGo2 = goutil.findChild(self._imgEmptyGo, "txt1")
	end

	goutil.setActive(self._emptyImg1, isEmpty)
	goutil.setActive(self._emptyImg2, isEmpty)
	goutil.setActive(self._emptyImg3, isEmpty)
	goutil.setActive(self._modelGo1, false)
	goutil.setActive(self._modelGo2, false)
end

function M:refreshEquipModel(suitId)
	local isBackFromChangeView, isHeroSuitChanged = EquipController.instance:getIsHeroSuitChanged(suitId)

	if isBackFromChangeView then
		self._equipModelComponent:beforeMergeAni()
		self._equipModelComponent:setEquipAniName("merge", "idle1")
	else
		self._equipModelComponent:enableAutoRotation(true)
		self._equipModelComponent:setEquipAniName("idle1", "idle1")
	end

	if isHeroSuitChanged then
		settimer(1, self.playSuitEffect, self, false)
	end

	self._equipModelComponent:setHeroData(self._heroData)
end

function M:playSuitEffect()
	return
end

function M:setIsOtherPlayer(isOther)
	self._isOtherPlayer = isOther
end

function M:_onClickChangeEquip()
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqigenghuan, nil, nil, nil)

	local index = 1
	local part = EquipEnum.PartTypeList[index]

	if not part or not self._heroData then
		return
	end

	EquipController.instance:setOperateHero(self._heroData)
	EquipController.instance:setEquipFilterCfgPartType(part)
	ViewMgr.instance:open(ViewName.ChangeEquipNew)
end

function M:_setRedPoint()
	local keyList = {}

	for index = 1, EquipEnum.MaxPartType do
		local key = string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, index)

		table.insert(keyList, key)
	end

	RedDotModel.instance:createDotView({
		dotNode = self._redGo,
		keyList = keyList
	})
end

function M:_onClickAttrTips()
	local equipHero = self._heroData:getHeroEquipData()
	local equipNum = equipHero:getEquipNum()

	if equipNum < 1 then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_empty"), CommEnum.CharacterTopToastIcon.Fail, 1)
	else
		ViewMgr.instance:open(ViewName.EquipHeroDetailTips, self._heroData:getHeroEquipData())
	end
end

function M:_onClickSuitDesc()
	self:_onClickSuitDescDyn(self._btnSuitDesc.gameObject)
end

function M:_onClickSuitDescDyn(bindGo)
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false
	local equipHeroData = heroData:getHeroEquipData()
	local suitId = equipHeroData:getAvailableSuitId()

	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)
		local suit3 = suitData:getSuit3()

		if suit3 and suit3 > 0 then
			local skillEnhanceMO = SkillEnhanceMO.New(suit3)
			local isPassEvent = true

			ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
		end
	end
end

function M:_refreshByHeroChange()
	self:_refreshAll(false)
end

function M:_refreshTips()
	return
end

function M:openSuitAni()
	self._suitAni:Stop()
	self._suitAni:Play("suit_jihuo")
end

function M:closeSuitAni()
	return
end

return M
