-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/EquipChangeView.lua

module("logic.extensions.charactersystem.view.equip.EquipChangeView", package.seeall)

local M = class("EquipChangeView", ViewComponent)
local yAniName = {
	"01",
	"02",
	"03"
}

function M:buildUI()
	local goRoleCombat = goutil.findChild(self.mainGO, "secrecyIndex").gameObject

	self._roleCombatCell = Astral.SimpleLuaComponentContainer.Add(goRoleCombat, RoleCombatCell)
	self._compareMask = goutil.findChild(self.mainGO, "imgContrastMask")

	local imageGo = self:getGo("equip_properties_overview_view_605920258")

	self._equipModelComponent = Astral.LuaComponentContainer.Add(imageGo, ChangeEquipSuitModelComponent)

	local equipDetailGo = self:getGo("12&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailComp = Astral.LuaComponentContainer.Add(equipDetailGo, EquipChangeDetailInfoComponent)

	self._equipDetailComp:buildUI()

	local selfEquipDetailGo = self:getGo("13&backpack_equip_detail_tips_copy_154087081")

	self._equipDetailCompSelf = Astral.LuaComponentContainer.Add(selfEquipDetailGo, EquipDetailInfoComponent)

	self._equipDetailCompSelf:buildUI()
	self._equipDetailCompSelf:setSuitColor("64ddcb", "858585")

	local equipScrollGo = self:getGo("equip_properties_overview_view_copy_-2042845628")

	self._scrollRect = equipScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._equipScrollRect = equipScrollGo:GetComponent(UIComponentType.ScrollRect)
	self._equipScrollList = LoopGridViewHelper.New(equipScrollGo)

	self._equipScrollList:InitGridView(0, self._onEquipCellUpdate, self)

	self._equipEmptyGo = self:getGo("equip_properties_overview_view_copy_-714355258")
	self._btnEmptyClick = Astral.ButtonAdapter.Get(goutil.findChild(self._equipEmptyGo, "empty_unit/btnGain"))

	local tabList = self:getGo("equip_properties_overview_view_copy_-216132886")

	self._tabBarList = {}
	self._redGo = {}
	self._tabBarGroup = goutil.addComponentOnce(tabList, UIComponentType.SpaceXToggleGroup)

	local toggleComp = false

	for i = 1, 3 do
		toggleComp = goutil.findChild(tabList, "btn" .. i):GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._tabBarList, toggleComp)

		local redPointGo = goutil.findChild(tabList, "redPoint" .. i)

		table.insert(self._redGo, redPointGo)
		goutil.setActive(redPointGo, false)
	end

	self._goFilterSelected = self:getGo("equip_properties_overview_view_-717317413")
	self._txtFilterName = self:getText("equip_properties_overview_view_718414106")
	self._goSelectDiceList = self:getGo("equip_properties_overview_view_1904833208")
	self._goDiceItem = goutil.findChild(self._goSelectDiceList, "diceItem")

	goutil.setActive(self._goDiceItem, false)

	self._btnCompare = self:getBtn("equip_properties_overview_view_copy_1529284885")
	self._btnPresets = self:getBtn("21&btn_presets_600318579")
	self._btnHideCompare = self:getBtn("equip_properties_overview_view_copy_460618587")
	self._goEquipted = self:getGo("equip_properties_overview_view_copy_2082996933")

	goutil.setActive(self._goEquipted, false)
	goutil.setActive(self._btnCompare.gameObject, false)
	goutil.setActive(self._btnHideCompare.gameObject, false)

	self._btnListGo = goutil.findChild(self.mainGO, "btnList")
	self._guiAnimation = goutil.addComponentOnce(self.mainGO, typeof(Astral.GUITimelineAniLua))
	self._suitTitleName = lang("tip_equip_suit_change")
	self._needPlayItemAniMaxIndex = 15

	self:_regLockStats(GameEnum.SystemEnum.HeroPreset, self._btnPresets.gameObject, nil, nil)
end

function M:bindEvents()
	self._btnCompare:AddClickListener(self._onClickCompareBtn, self)
	self._btnHideCompare:AddClickListener(self._onClickHideCompareBtn, self)
	self._btnPresets:AddClickListener(self._onClickPreinstall, self)
	self._equipDetailComp:bindEvents()
	self._equipDetailCompSelf:bindEvents()
	self._btnEmptyClick:AddClickListener(self._onClickEmpty, self)

	for index, toggleComp in ipairs(self._tabBarList) do
		toggleComp:AddListener(function(_, isOn)
			if isOn then
				self:_dealToggleClick(index)
			end
		end, nil)
	end
end

function M:unbindEvents()
	self._btnCompare:RemoveClickListener()
	self._btnHideCompare:RemoveClickListener()
	self._btnPresets:RemoveClickListener()
	self._equipDetailComp:unbindEvents()
	self._equipDetailCompSelf:unbindEvents()
	self._btnEmptyClick:RemoveClickListener()

	for _, toggleComp in ipairs(self._tabBarList) do
		toggleComp:RemoveListener()
	end
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.EQUIP_SELECT_CELL, self._handleEquipSelect, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_MODEL_DRAG_PART, self._onDragPartChanged, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._handleClickSortItem, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_WEARED_SUCCESS, self._onEquipWear, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_TAKE_OFF_SUCCESS, self._onEquipWear, self)
		GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
		GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
		GlobalDispatcher:addEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	else
		GlobalDispatcher:removeEventListener(EventType.EQUIP_SELECT_CELL, self._handleEquipSelect, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_MODEL_DRAG_PART, self._onDragPartChanged, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_FILTER_CLICK_EVENT, self._handleEquipFilter, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARING_SORT_ITEM_CLICK, self._handleClickSortItem, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_WEARED_SUCCESS, self._onEquipWear, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_TAKE_OFF_SUCCESS, self._onEquipWear, self)
		GlobalDispatcher:removeEventListener(EventType.EQUIP_INFO_REFRESH, self._onEquipInfoChanged, self)
		GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self._onEquipInfoChanged, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SYSTEM_OPEN, self._handleOnSystemOpen, self)
	end
end

function M:onEnter()
	self:_setEvent(true)

	self._sortMo = self._viewPresentor:getSortMo()

	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	self:setRetPoint()

	self._heroData = EquipController.instance:getOperateHero()

	self._equipModelComponent:onEnter()

	local index = EquipController.instance:getEquipSelectIndex()

	if self._tabBarList[index].IsOn then
		self:_dealToggleClick(index)
	else
		self._tabBarList[index].IsOn = true
	end

	self._equipModelComponent:setHeroData(self._heroData)
	self:_refreshSuit()
	self:_refreshATKInfo()
	self:_refEquipPartRedPoint()
	self:_handleOnSystemOpen()
end

function M:onExit()
	self:_setEvent(false)
	self._equipModelComponent:onExit()
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	self._lastIndex = nil

	self:_filterReset()
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

function M:_filterReset()
	self._filterEquipDices = nil
	self._filterEquipSuitData = nil
	self._curSuitId = CommEnum.CommonAll

	EquipController.instance:setEquipFilterCfgSuit(self._curSuitId)
	EquipController.instance:setEquipFilterCfgDices({})
end

function M:_refreshEquipList(autoSelect, isPlayAni, isNotRefreshMoList)
	if isNotRefreshMoList ~= true then
		local sortFun = BackpackUtil.getEquipSortFun(self._sortMo)

		self._equipMoList = EquipController.instance:getFilterEquipMoList(sortFun, autoSelect)
	end

	self._equipScrollList:SetListItemCount(#self._equipMoList)
	self:_refreshEquipListShownItems(isPlayAni, isNotRefreshMoList)
	self:_refreshEmpty()

	if autoSelect then
		self:_refreshCurSelectMo()
	end
end

function M:_refreshEmpty()
	self._isEmpty = #self._equipMoList == 0

	goutil.setActive(self._equipEmptyGo, self._isEmpty)
	goutil.setActive(self._btnListGo, not self._isEmpty)
	self._equipDetailComp:setEmpty(self._isEmpty)
	GlobalDispatcher:dispatchEvent(EventType.EQUIP_REFREH_FILTER_EMPTY, self._isEmpty)
end

function M:_refreshCurSelectMo()
	if self._isEmpty then
		return
	end

	local equipMo = EquipController.instance:getSelectedEquipMo()

	self._equipDetailComp:setHeroAndPart(self._heroData, EquipEnum.PartTypeList[self._lastIndex])
	self._equipDetailComp:setEquipData(equipMo)

	if self._curPartWeared then
		if self._curPartWeared:getUuid() == equipMo:getUuid() then
			goutil.setActive(self._goEquipted, true)
			goutil.setActive(self._btnCompare.gameObject, false)
			goutil.setActive(self._btnHideCompare.gameObject, false)

			if self._equipDetailCompSelf:isVisible() then
				self._equipDetailCompSelf:setVisible(false)
				goutil.setActive(self._compareMask, false)
			end
		else
			local isComparing = self._equipDetailCompSelf:isVisible()

			goutil.setActive(self._goEquipted, false)
			goutil.setActive(self._btnCompare.gameObject, not isComparing)
			goutil.setActive(self._btnHideCompare.gameObject, isComparing)
		end
	else
		goutil.setActive(self._goEquipted, false)
		goutil.setActive(self._btnCompare.gameObject, false)
		goutil.setActive(self._btnHideCompare.gameObject, false)
	end
end

function M:_refreshWearedEquip()
	local heroEquips = self._heroData:getHeroEquipData()

	self._curPartWeared = heroEquips:getEquipByPart(EquipEnum.PartTypeList[self._lastIndex])

	self._equipDetailCompSelf:setEquipData(self._curPartWeared)
	self._equipDetailCompSelf:setVisible(false)
	goutil.setActive(self._compareMask, false)
end

function M:_refreshSuit()
	self._curSuitId = self._filterSuitId and self._filterSuitId or CommEnum.CommonAll
	self._filterEquipDices = self._filterEquipDices or {}

	local lenght = TableUtil.getLen(self._filterEquipDices)

	goutil.setActive(self._goFilterView, false)

	local show = false

	if self._filterEquipSuitData or lenght > 0 then
		show = true
	end

	goutil.setActive(self._goFilterSelected, show)

	if show then
		self._txtFilterName.text = self._filterEquipSuitData and self._filterEquipSuitData:getName() or ""

		if lenght > 0 and self._filterEquipSuitData then
			self._txtFilterName.text = self._txtFilterName.text .. ","
		end

		RectTransformUtils.ForceRebuildLayoutImmediate(self._txtFilterName.gameObject.transform)
		self:_updataSelectDiceItems()
	end
end

function M:_updataSelectDiceItems()
	if not self._filterDiceItems then
		self._filterDiceItems = {}
	end

	local i = 1

	for k, v in pairs(self._filterEquipDices) do
		if i > 9 then
			break
		end

		if not self._filterDiceItems[i] then
			local go = goutil.clone(self._goDiceItem)

			goutil.addChildToParent(go, self._goSelectDiceList)

			local item = Astral.LuaComponentContainer.Add(go, EquipDiceIconSimplifyItem)

			self._filterDiceItems[i] = item
		end

		self._filterDiceItems[i]:updateIcon(v)
		self._filterDiceItems[i]:setActive(true)

		i = i + 1
	end

	for j = i, #self._filterDiceItems do
		self._filterDiceItems[j]:setActive(false)
	end
end

function M:destroyUI()
	self._equipModelComponent:onDestroy()
end

function M:ajustSuitListHight()
	local height = RectTransformUtils.GetHeight(self._suitItemTrans)

	RectTransformUtils.SetHeight(self._suitTrans, height + 30)
end

function M:_onClickCompareBtn()
	goutil.setActive(self._btnCompare.gameObject, false)
	goutil.setActive(self._btnHideCompare.gameObject, true)
	goutil.setActive(self._compareMask, true)
	self._equipDetailCompSelf:setVisible(true)
	self._equipDetailCompSelf:checkSuitAni()
end

function M:_onClickHideCompareBtn()
	goutil.setActive(self._btnCompare.gameObject, true)
	goutil.setActive(self._btnHideCompare.gameObject, false)
	goutil.setActive(self._compareMask, false)
	self._equipDetailCompSelf:setVisible(false)
end

function M:_onClickPreinstall()
	if not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.HeroPreset, true) then
		return
	end

	ViewMgr.instance:open(ViewName.CharacterPreinstallView, self._heroData:getId(), 2)
end

function M:_dealToggleClick(index)
	if self._lastIndex and self._lastIndex == index then
		return
	end

	if self._lastIndex then
		self:playGuiAni("open" .. yAniName[self._lastIndex] .. "-" .. yAniName[index])
	end

	self._lastIndex = index

	EquipController.instance:setEquipFilterCfgPartType(EquipEnum.PartTypeList[index])
	self:_onPartChanged()
end

function M:_handleClickSortItem(e, BackpackItemSortData)
	self._sortMo = BackpackItemSortData
	self._equipMoList = EquipController.instance:getFilterEquipMoList(BackpackUtil.getEquipSortFun(self._sortMo), false)

	self:_refreshEquipListShownItems(true)
end

function M:_handleEquipFilter(e, equipSuitData, dices)
	self._filterSuitId = equipSuitData and equipSuitData:getId() or CommEnum.CommonAll
	self._filterEquipSuitData = equipSuitData
	self._filterEquipDices = dices or {}

	EquipController.instance:setEquipFilterCfgSuit(self._filterSuitId)
	EquipController.instance:setEquipFilterCfgDices(self._filterEquipDices)
	self:_refreshSuit()

	self._scrollRect.verticalNormalizedPosition = 1

	self:_refreshEquipList(true, true)
end

function M:_onClickEmpty()
	local jumpId = 12000001

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onEquipInfoChanged(e)
	self:_refreshEquipList(false, false, true)
	self:_refreshCurSelectMo()
	self:_refreshATKInfo()

	if self._equipDetailCompSelf:isVisible() then
		local heroEquips = self._heroData:getHeroEquipData()

		self._curPartWeared = heroEquips:getEquipByPart(EquipEnum.PartTypeList[self._lastIndex])

		self._equipDetailCompSelf:setEquipData(self._curPartWeared)
	end
end

function M:_onDragPartChanged(e, isLeft)
	local oldPart = self._lastIndex

	if isLeft then
		if oldPart > 1 then
			oldPart = oldPart - 1
		else
			oldPart = 3
		end
	elseif oldPart < 3 then
		oldPart = oldPart + 1
	else
		oldPart = 1
	end

	self._tabBarGroup:TryActiveChildOn(self._tabBarList[oldPart], true)
end

function M:_onPartChanged()
	local lastSelectedEquipMo = EquipController.instance:getLastSelectedEquipMo()
	local isAutoSelect = true

	if lastSelectedEquipMo then
		EquipController.instance:setSelectedEquipMo(lastSelectedEquipMo)
		EquipController.instance:setLastSelectedEquipMo(nil)

		isAutoSelect = false
	end

	self._scrollRect.verticalNormalizedPosition = 1

	self:_refreshEquipList(isAutoSelect, true)
	self:_refreshWearedEquip()
	self:_refreshCurSelectMo()
	self._equipModelComponent:setCurOperatePos(self._lastIndex)
end

function M:_onEquipWear(e)
	self:_refreshEquipList(false, false, true)
	self:_refreshWearedEquip()
	self:_refreshCurSelectMo()
	self._equipModelComponent:refreshView()
	self._equipDetailComp:checkSuitAniOnWear()
	self:_refreshATKInfo()
	self:_refEquipPartRedPoint()

	local suitId = self._heroData:getHeroEquipData():getAvailableSuitId()

	if suitId then
		ToolTipsMgr.showCharacterTopToast(lang("tip_equip_suit_active"), CommEnum.CharacterTopToastIcon.Succ, 1)
	end
end

function M:_handleEquipSelect()
	self:_refreshEquipListShownItems()
	self:_refreshCurSelectMo()
	self._equipModelComponent:refreshOperatePos()
end

function M:_onEquipCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local item = self._equipScrollList:NewListViewItem("backpack_item")
	local view = Astral.LuaComponentContainer.Add(item.gameObject, CharacterEquipItemCell)
	local mo = self._equipMoList[curIndex]

	view:updateData(mo)
	view:refreshEquipDetailRed()

	local selectedMo = EquipController.instance:getSelectedEquipMo()
	local isSelected = selectedMo and mo:getUuid() == selectedMo:getUuid()

	view:onSelect(isSelected)

	if self._needPlayItemCellOpenAni and curIndex <= self._needPlayItemAniMaxIndex then
		self._itemShowerCache[curIndex] = view

		view:getComponent("animation"):setAlpha(0)
	else
		view:getComponent("animation"):setAlpha(1)
	end

	return item
end

function M:playGuiAni(name)
	self._guiAnimation:StopTimelineAni()

	if not string.nilorempty(name) then
		self._guiAnimation:PlayAniByName(name)
	end
end

function M:setRetPoint()
	for index = 1, EquipEnum.MaxPartType do
		RedDotModel.instance:createDotView({
			dotNode = self._redGo[index],
			keyList = {
				string.format("%s_%s", RedDotType.ERedDotKey.EQUIPMENT, index)
			}
		})
	end
end

function M:_refEquipPartRedPoint()
	if self._heroData then
		local heroEquips = self._heroData:getHeroEquipData()

		if heroEquips then
			heroEquips:checkForRedPoint()
		end
	end
end

function M:_refreshATKInfo()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	self._roleCombatCell:updateHeroData(heroData)
end

function M:_refreshEquipListShownItems(playAni, isNotSetEquipFirst)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._needPlayItemCellOpenAni = playAni
	self._itemShowerCache = {}
	self._cacheTweenLst = {}

	if isNotSetEquipFirst ~= true then
		EquipController.instance:setCurEquipFirst(self._equipMoList, self._lastIndex)
	end

	self._equipScrollList:RefreshAllShownItem()

	if playAni then
		local maxDelay = 0.1

		self._equipScrollRect.enabled = false

		for index, shower in ipairs(self._itemShowerCache or {}) do
			local delay = index * 0.05

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				shower:getComponent("animation"):setAlpha(1)
				shower:getComponent("animation"):playOpenAni()
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end

		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._equipScrollRect.enabled = true
		end))
	else
		for index, shower in ipairs(self._itemShowerCache or {}) do
			shower:getComponent("animation"):setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false
		self._equipScrollRect.enabled = true
	end
end

return M
