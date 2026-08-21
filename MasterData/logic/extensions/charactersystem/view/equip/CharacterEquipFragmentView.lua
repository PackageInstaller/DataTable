-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/CharacterEquipFragmentView.lua

module("logic.extensions.charactersystem.view.equip.CharacterEquipFragmentView", package.seeall)

local M = class("CharacterEquipFragmentView", CharacterMainSystemSubViewBase)

function M:ctor()
	M.super.ctor(self)

	self._goSuitDescList = {}
end

function M:getPageIndex()
	return CommEnum.CharacterSystemTab.Equip
end

function M:buildUI()
	M.super.buildUI(self)

	local imageGo = self._registry:getGo("equip_main_panel_1501905091")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, CharacterEquipSuitModelComponent)

	local propertyListGo = self._registry:getGo("equip_main_panel_1282724208")

	self._propertyItemList = {}

	for index = 1, EquipEnum.MaxAttrCount do
		local propertyItemGo = goutil.findChild(propertyListGo, "propertyItem" .. index)

		table.insert(self._propertyItemList, propertyItemGo)
	end

	local equipItemListGo = self._registry:getGo("equip_main_panel_copy_2002156876")

	self._equipItemList = {}

	for index = 1, EquipEnum.MaxPartType do
		local itemGo = goutil.findChild(equipItemListGo, "item" .. index)
		local item = Astral.LuaComponentContainer.Add(itemGo, CharacterEquipFragmentViewEquipItem)

		item:addClickHandle(self._onClickChangeEquip, self)
		table.insert(self._equipItemList, item)
	end

	self._suitListGo = self._registry:getGo("equip_main_panel_1358588858")

	self._suitListGo:SetActive(false)

	self._goSuitDesc = self._registry:getGo("equip_main_panel_copy_798176931")

	goutil.setActive(self._goSuitDesc, false)

	self._txtSuitName = self._registry:getText("equip_main_panel_copy_489910798")
	self._txtSuitNum = self._registry:getText("equip_main_panel_copy_625756366")
	self._txtEmptyGo = self._registry:getGo("equip_main_panel_-1311851756")
	self._imgEmptyGo = self._registry:getGo("equip_main_panel_-681477342")

	local suitAniGo = self._registry:getGo("equip_main_panel_1358588858")

	self._btnSuitDesc = Astral.ButtonAdapter.Get(suitAniGo)
	self._suitAni = suitAniGo:GetComponent(ComponentType.Animation)
	self._btnAttrTips = self._registry:getBtn("0&com_btn_2_-31477526")
	self._btnChange = self._registry:getBtn("1&btn_middle_-31477526")
	self._redGo = goutil.findChild(self._btnChange.gameObject, "redPointRoot/red_point")
	self._btnPresets = self._registry:getBtn("6&btn_presets_600318579")

	self:_regLockStats(GameEnum.SystemEnum.HeroPreset, self._btnPresets.gameObject, nil, nil)
end

function M:destroyUI()
	M.super.destroyUI(self)
end

function M:bindEvents()
	self._btnAttrTips:AddClickListener(self._onClickAttrTips, self)
	self._btnChange:AddClickListener(self._onClickChangeEquip, self)
	self._btnSuitDesc:AddClickListener(self._onClickSuitDesc, self)
	self._btnPresets:AddClickListener(self._onClickPreinstall, self)
	GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	GlobalDispatcher:addEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
	GlobalDispatcher:addEventListener(EventType.CHARACTER_PREINSTALLS_CHANGE, self._handlerHeroPreinstallChange, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._handlerEquipChange, self)
end

function M:unbindEvents()
	self._btnAttrTips:RemoveClickListener()
	self._btnChange:RemoveClickListener()
	self._btnSuitDesc:RemoveClickListener()
	self._btnPresets:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	GlobalDispatcher:removeEventListener(EventType.CHARACTER_MAIN_SYSTEM_SWITCH, self._refreshByHeroChange, self)
	GlobalDispatcher:removeEventListener(EventType.CHARACTER_PREINSTALLS_CHANGE, self._handlerHeroPreinstallChange, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._handlerEquipChange, self)
end

function M:onEnter()
	M.super.onEnter(self)

	self._tipsShowed = false

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	self._equipModelComponent:onEnter()
	self:_setRedPoint()
	self:_refreshAll()
	self:_handleOnSystemOpen()
end

function M:onExit()
	self._equipModelComponent:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
end

function M:_regLockStats(key, root, objNormal, objLock)
	if not self._lockStatsGroup then
		self._lockStatsGroup = {}
	end

	local data = {}

	data.root = root.gameObject
	data.normal = objNormal and objNormal.gameObject or nil
	data.lock = objLock and objLock.gameObject or nil
	self._lockStatsGroup[key] = self._lockStatsGroup[key] or {}

	table.insert(self._lockStatsGroup[key], data)
end

function M:_handleOnSystemOpen()
	for key, group in pairs(self._lockStatsGroup or {}) do
		for _, data in ipairs(group) do
			local showOnLock = SystemOpenFacade.instance:isShowOnLock(key)
			local isOpen = SystemOpenFacade.instance:isOpen(key)

			goutil.setActive(data.root, isOpen or showOnLock and not isOpen)

			if data.lock then
				goutil.setActive(data.lock, not isOpen)
			end

			if data.normal then
				goutil.setActive(data.normal, isOpen)
			end
		end
	end
end

function M:_refreshAll()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()

	self._heroData = viewPageMo and viewPageMo.hero or false

	local filterCfg = EquipController.instance:getEchoFilterCfg()

	filterCfg:setCareerFilterType(self._heroData:getCareer())

	local equipHeroData = self._heroData:getHeroEquipData()
	local isEmpty = not equipHeroData:isAnlyPartHasEquip()

	self:setEmpty(isEmpty)

	local equipList = equipHeroData:getEquipList()

	for i = 1, #self._equipItemList do
		self._equipItemList[i]:setItemData(equipList[i], i)
	end

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

	self:_refreshSuitInfo(suitId)
	self:_refreshEquipModel(suitId)
	equipHeroData:checkForRedPoint()
end

function M:_refreshSuitInfo(suitId)
	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)

		self._txtSuitName.text = suitData:getName()

		goutil.setActive(self._txtSuitNum.gameObject, true)

		local heroTags = HeroDepotModel.instance:getCurViewPageHeroTags(false)
		local suitDescList = suitData:getSuit3DescList(heroTags)

		for i = 1, #suitDescList do
			if not self._goSuitDescList[i] then
				local itemGo = goutil.clone(self._goSuitDesc)

				goutil.addChildToParent(itemGo, self._suitListGo)

				local TMPText = goutil.addComponentOnce(itemGo, UIComponentType.TMPText)

				self._goSuitDescList[i] = {
					go = itemGo,
					textComp = TMPText
				}
			end

			goutil.setActive(self._goSuitDescList[i].go, true)

			self._goSuitDescList[i].textComp.text = suitDescList[i]
		end

		for i = #suitDescList + 1, #self._goSuitDescList do
			goutil.setActive(self._goSuitDescList[i].go, false)
		end

		self._suitListGo:SetActive(true)
		self._txtEmptyGo:SetActive(false)
	else
		self._suitListGo:SetActive(false)
		self._txtEmptyGo:SetActive(true)
	end
end

function M:setEmpty(isEmpty)
	goutil.setActive(self._imgEmptyGo, true)

	if not self._emptyGoGet then
		self._emptyImg1 = goutil.findChild(self._imgEmptyGo, "img1")
		self._emptyImg2 = goutil.findChild(self._imgEmptyGo, "img2")
		self._emptyImg3 = goutil.findChild(self._imgEmptyGo, "img3")
		self._modelGo2 = goutil.findChild(self._imgEmptyGo, "txt1")
	end

	goutil.setActive(self._emptyImg1, isEmpty)
	goutil.setActive(self._emptyImg2, isEmpty)
	goutil.setActive(self._emptyImg3, isEmpty)
	goutil.setActive(self._modelGo2, false)
end

function M:_refreshEquipModel(suitId)
	local isBackFromChangeView, isHeroSuitChanged = EquipController.instance:getIsHeroSuitChanged(suitId)

	if isBackFromChangeView then
		self._equipModelComponent:beforeMergeAni()
		self._equipModelComponent:setEquipAniName("merge", "idle1")
	else
		self._equipModelComponent:enableAutoRotation(true)
		self._equipModelComponent:setEquipAniName("idle1", "idle1")
	end

	self._equipModelComponent:setHeroData(self._heroData)
end

function M:_onClickChangeEquip(index)
	CriwareAudioFacade.instance:playOnceSEbyId(CriwareAudioEnum.ui_shoumiren_jiaoshiqigenghuan, nil, nil, nil)

	index = index or 1

	local part = EquipEnum.PartTypeList[index]

	if not part or not self._heroData then
		return
	end

	EquipController.instance:setOperateHero(self._heroData)
	EquipController.instance:setEquipFilterCfgPartType(part)
	ViewMgr.instance:open(ViewName.ChangeEquip)
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
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false
	local equipHeroData = heroData:getHeroEquipData()
	local suitId = equipHeroData:getAvailableSuitId()

	if suitId then
		local suitData = EquipSuitModel.instance:getSuitDataById(suitId)
		local suit3 = suitData:getSuitEffect()

		if suit3 and suit3 > 0 then
			local skillEnhanceMO = SkillEnhanceMO.New(suit3)
			local bindGo = self._btnSuitDesc.gameObject
			local isPassEvent = true

			ToolTipsMgr.showSkillBuffTagSideTips(skillEnhanceMO, bindGo, isPassEvent)
		end
	end
end

function M:_onClickPreinstall()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, self._heroData:getId(), 2)
end

function M:_refreshByHeroChange()
	self:_refreshAll(false)
end

function M:_handlerEquipChange()
	self:_refreshAll()
end

function M:_handlerHeroPreinstallChange()
	self:_refreshAll()
end

function M:openSuitAni()
	self._suitAni:Stop()
	self._suitAni:Play("suit_jihuo")
end

function M:closeSuitAni()
	return
end

return M
