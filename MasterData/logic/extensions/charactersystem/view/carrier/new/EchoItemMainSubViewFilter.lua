-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainSubViewFilter.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainSubViewFilter", package.seeall)

local M = class("EchoItemMainSubViewFilter")

M.CareerFilterType = {
	[0] = 0,
	GameEnum.CareerEnum.Sentinel,
	GameEnum.CareerEnum.Assault,
	GameEnum.CareerEnum.Sniper,
	GameEnum.CareerEnum.Super,
	GameEnum.CareerEnum.Heavy,
	GameEnum.CareerEnum.Cure
}
M.CareerFilterName = {
	[0] = CommEnum.Career2Name[0],
	CommEnum.Career2Name[M.CareerFilterType[1]],
	CommEnum.Career2Name[M.CareerFilterType[2]],
	CommEnum.Career2Name[M.CareerFilterType[3]],
	CommEnum.Career2Name[M.CareerFilterType[4]],
	CommEnum.Career2Name[M.CareerFilterType[5]],
	CommEnum.Career2Name[M.CareerFilterType[6]]
}
M.FilterTyp = {
	CommEnum.HeroSortFieldType.Quality,
	CommEnum.HeroSortFieldType.Level
}

function M:_sortTyp2Name(sortType)
	sortType = sortType or 0

	return lang(CommEnum.SortType2LangKey[sortType])
end

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	goutil.setActive(registry:findUIElement("14&common_filter_1742265756"), false)

	self._goFilterRoot = registry:findUIElement("14&common_filter_-55329758")
	self._btnCareerFilter = UIComponentType.ButtonAdapter(registry:findUIElement("14&common_filter_1257874372"))
	self._txtBtnCareerFilter = registry:findUIElement("14&common_filter_1277082477", UIComponentType.Text)
	self._goMarkCareerUp = registry:findUIElement("14&common_filter_47580719")
	self._goMarkCareerDown = registry:findUIElement("14&common_filter_-1610409428")
	self._goCareerFilterPanel = registry:findUIElement("14&common_filter_1899392441")
	self._careerFilterCell = {}

	local _content = goutil.findChildComponent(self._goCareerFilterPanel, "Content", UIComponentType.RectTransform)

	while _content.childCount < #M.CareerFilterType + 1 do
		goutil.cloneAndSetParent(_content:GetChild(0).gameObject, _content)
	end

	for i = 0, _content.childCount - 1 do
		local go = _content:GetChild(i).gameObject
		local show = i <= #M.CareerFilterType

		if show then
			local typ = M.CareerFilterType[i]

			self._careerFilterCell[typ] = self:_buildCareerFilterCell(go, i, typ)
		end

		goutil.setActive(go, show)
	end

	self._btnFilter = UIComponentType.ButtonAdapter(registry:findUIElement("14&common_filter_-1115847681"))
	self._txtBtnFilter = registry:findUIElement("14&common_filter_-250765097", UIComponentType.Text)
	self._goUpBtnFilter = registry:findUIElement("14&common_filter_198063371")
	self._goDownBtnFilter = registry:findUIElement("14&common_filter_75483329")
	self._goFilterPanel = registry:findUIElement("14&common_filter_121414158")
	self._filterCell = {}

	local _content = goutil.findChildComponent(self._goFilterPanel, "Content", UIComponentType.RectTransform)

	while _content.childCount < #M.FilterTyp do
		goutil.cloneAndSetParent(_content:GetChild(0).gameObject, _content)
	end

	for i = 0, _content.childCount - 1 do
		local go = _content:GetChild(i).gameObject
		local show = i < #M.FilterTyp

		if show then
			local typ = M.FilterTyp[i + 1]

			self._filterCell[typ] = self:_buildFilterCell(go, typ)
		end

		goutil.setActive(go, show)
	end

	self._btnFilterMask = UIComponentType.ButtonAdapter(registry:findUIElement("14&common_filter_-2087941579"))

	goutil.setActive(self._btnFilterMask.gameObject, false)
	goutil.setActive(self._goCareerFilterPanel, false)
	goutil.setActive(self._goFilterPanel, false)
	goutil.setActive(self._goMarkCareerUp, not self._goCareerFilterPanel.activeSelf)
	goutil.setActive(self._goMarkCareerDown, self._goCareerFilterPanel.activeSelf)
end

function M:destroyUI()
	self._handler = nil
	self._tempDataLst = nil
	self._curPageTyp = nil

	for _, cell in pairs(self._filterCell or {}) do
		cell.btnClick:RemoveClickListener()
	end

	self._filterCell = nil

	for _, cell in pairs(self._careerFilterCell or {}) do
		cell.btnClick:RemoveClickListener()
	end

	self._careerFilterCell = nil
end

function M:bindEvents()
	self._btnCareerFilter:AddClickListener(self._onClickCareerFilter, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnFilterMask:AddClickListener(self._onClickFilterMask, self)
end

function M:unbindEvents()
	self._btnCareerFilter:RemoveClickListener()
	self._btnFilter:RemoveClickListener()
	self._btnFilterMask:RemoveClickListener()
end

function M:onEnter()
	self:resetFilter()

	self._curPageTyp = nil
end

function M:onExit()
	self:resetFilter()

	self._curPageTyp = nil
end

function M:setHandler(handler)
	self._handler = handler
end

function M:onPageTypChange(typ)
	local lastPageType = self._curPageTyp

	self._curPageTyp = typ

	local needShow = typ == EchoItemMainViewNew.SubViewType.Change

	self:setVisible(needShow)

	if not lastPageType then
		self:resetFilter()
	end
end

function M:setVisible(visible)
	goutil.setActive(self._goFilterRoot, visible)

	if not visible then
		goutil.setActive(self._btnFilterMask.gameObject, false)
		goutil.setActive(self._goCareerFilterPanel, false)
		goutil.setActive(self._goFilterPanel, false)
	end
end

function M:_onClickFilterMask()
	goutil.setActive(self._btnFilterMask.gameObject, false)
	goutil.setActive(self._goCareerFilterPanel, false)
	goutil.setActive(self._goFilterPanel, false)
	goutil.setActive(self._goMarkCareerUp, not self._goCareerFilterPanel.activeSelf)
	goutil.setActive(self._goMarkCareerDown, self._goCareerFilterPanel.activeSelf)
end

function M:_onClickFilter()
	local show = not self._goFilterPanel.activeSelf

	goutil.setActive(self._btnFilterMask.gameObject, show)
	goutil.setActive(self._goCareerFilterPanel, false)
	goutil.setActive(self._goFilterPanel, show)
	goutil.setActive(self._goMarkCareerUp, not self._goCareerFilterPanel.activeSelf)
	goutil.setActive(self._goMarkCareerDown, self._goCareerFilterPanel.activeSelf)
end

function M:_onClickCareerFilter()
	local show = not self._goCareerFilterPanel.activeSelf

	goutil.setActive(self._btnFilterMask.gameObject, show)
	goutil.setActive(self._goCareerFilterPanel, show)
	goutil.setActive(self._goFilterPanel, false)
	goutil.setActive(self._goMarkCareerUp, not self._goCareerFilterPanel.activeSelf)
	goutil.setActive(self._goMarkCareerDown, self._goCareerFilterPanel.activeSelf)
end

function M:_buildCareerFilterCell(go, index, filterTyp)
	local cell = {}

	cell.go = go
	cell.index = index
	cell.filterTyp = filterTyp
	cell.isSelect = false
	cell.isUpSort = false
	cell.goSelect = goutil.findChild(go, "select").gameObject
	cell.txtName = goutil.findChildTextComponent(go, "Label (1)")
	cell.txtName.text = M.CareerFilterName[index]
	cell.btnClick = UIComponentType.ButtonAdapter(go)

	cell.btnClick:AddClickListener(function()
		self:_onCareerFilterItemClick(cell.filterTyp, cell.index)
	end, self)

	function cell.onSelectFilter(theFilterTyp, upSort)
		local isSelect = cell.filterTyp == theFilterTyp

		goutil.setActive(cell.goSelect, isSelect)

		cell.isSelect = isSelect
	end

	return cell
end

function M:_onCareerFilterItemClick(filterTyp, index)
	local career = filterTyp

	if enableLog then
		printWarn("drop :", index, career, M.CareerFilterName[index])
	end

	for _, cell in pairs(self._careerFilterCell or {}) do
		cell.onSelectFilter(filterTyp)
	end

	local _career, _filterTyp, _filterUpSort = self:getFilterType()

	_career = filterTyp

	self:setFilterType(_career, _filterTyp, _filterUpSort)
	goutil.setActive(self._goCareerFilterPanel, false)
	goutil.setActive(self._goMarkCareerUp, not self._goCareerFilterPanel.activeSelf)
	goutil.setActive(self._goMarkCareerDown, self._goCareerFilterPanel.activeSelf)
end

function M:_buildFilterCell(go, filterTyp)
	local cell = {}

	cell.go = go
	cell.filterTyp = filterTyp
	cell.isSelect = false
	cell.isUpSort = false
	cell.goUpSort = goutil.findChild(go, "up").gameObject
	cell.goDownSort = goutil.findChild(go, "down").gameObject
	cell.goSelect = goutil.findChild(go, "select").gameObject
	cell.txtName = goutil.findChildTextComponent(go, "Label")
	cell.txtName.text = self:_sortTyp2Name(filterTyp)
	cell.btnClick = UIComponentType.ButtonAdapter(go)

	cell.btnClick:AddClickListener(function()
		self:_onFilterItemClick(cell.filterTyp)
	end, self)

	function cell.onSelectFilter(theFilterTyp, upSort)
		local isSelect = cell.filterTyp == theFilterTyp

		goutil.setActive(cell.goSelect, isSelect)

		if isSelect and cell.isSelect == isSelect then
			cell.isUpSort = not cell.isUpSort
		end

		if upSort ~= nil then
			cell.isUpSort = upSort
		end

		goutil.setActive(cell.goUpSort, cell.isUpSort)
		goutil.setActive(cell.goDownSort, not cell.isUpSort)

		cell.isSelect = isSelect
	end

	return cell
end

function M:_onFilterItemClick(filterTyp)
	for _, cell in pairs(self._filterCell or {}) do
		cell.onSelectFilter(filterTyp)
	end

	local isUpSort = self._filterCell[filterTyp].isUpSort

	if enableLog then
		printWarn("click filter:", filterTyp, self:_sortTyp2Name(filterTyp), isUpSort)
	end

	local _career, _filterTyp, _filterUpSort = self:getFilterType()

	self:setFilterType(_career, filterTyp, isUpSort)
end

function M:getCurHeroCareer()
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		return heroData:getCareer()
	end

	return 0
end

function M:resetFilter()
	self._filterRecord = {}
	self._filterRecord.career = self:getCurHeroCareer()
	self._filterRecord.filter = M.FilterTyp[1]
	self._filterRecord.filterUpSort = false
	self._tempDataLst = {}

	for _, cell in pairs(self._filterCell or {}) do
		cell.onSelectFilter(self._filterRecord.filter, self._filterRecord.filterUpSort)
	end

	for _, cell in pairs(self._careerFilterCell or {}) do
		cell.onSelectFilter(self._filterRecord.career)
	end

	self._txtBtnFilter.text = self:_sortTyp2Name(self._filterRecord.filter)

	local _careerIndex = self._filterRecord.career == 0 and 0 or table.indexof(M.CareerFilterType, self._filterRecord.career)

	self._txtBtnCareerFilter.text = M.CareerFilterName[_careerIndex]

	goutil.setActive(self._goUpBtnFilter, self._filterRecord.filterUpSort)
	goutil.setActive(self._goDownBtnFilter, not self._filterRecord.filterUpSort)
end

function M:setFilterType(career, filter, filterUpSort)
	self._filterRecord.career = career or self:getCurHeroCareer()
	self._filterRecord.filter = filter or M.FilterTyp[1]
	self._filterRecord.filterUpSort = false

	if filterUpSort ~= nil then
		self._filterRecord.filterUpSort = filterUpSort
	end

	self._txtBtnFilter.text = self:_sortTyp2Name(self._filterRecord.filter)

	local _careerIndex = self._filterRecord.career == 0 and 0 or table.indexof(M.CareerFilterType, self._filterRecord.career)

	self._txtBtnCareerFilter.text = M.CareerFilterName[_careerIndex]

	goutil.setActive(self._goUpBtnFilter, self._filterRecord.filterUpSort)
	goutil.setActive(self._goDownBtnFilter, not self._filterRecord.filterUpSort)
	self:_applyFilter()
	GlobalDispatcher:dispatchEvent(EventType.ECHO_ITEM_FILTER_CHANGE, self._tempDataLst)
end

function M:getFilterType()
	local record = self._filterRecord

	return record.career, record.filter, record.filterUpSort
end

function M:getFilterEchoItemData()
	self:_applyFilter()

	return self._tempDataLst
end

function M:_applyFilter()
	self._tempDataLst = {}
	self._unInTagsDataLst = {}

	local tagIds = HeroDepotModel.instance:getCurViewPageHeroTags()
	local echoItemMoList = ItemModel.instance:getItemsByType(GameEnum.ItemTypeEnum.EchoItemType)
	local _career, _filterTyp, _filterUpSort = self:getFilterType()

	M._filterTyp = _filterTyp
	M._filterUpSort = _filterUpSort

	local heroId = HeroDepotModel.instance:getCurViewPageHeroId()
	local curEquipEcho

	for i, echoItemMo in ipairs(echoItemMoList) do
		if _career == 0 or _career == echoItemMo:getCareer() or echoItemMo:getCareer() == 0 then
			if echoItemMo:getHeroId() == heroId then
				curEquipEcho = echoItemMo
			elseif echoItemMo:isDescTagContainTargetTag(tagIds) then
				table.insert(self._tempDataLst, echoItemMo)
			else
				table.insert(self._unInTagsDataLst, echoItemMo)
			end
		end
	end

	table.sort(self._tempDataLst, M._echoSortFunc)
	table.sort(self._unInTagsDataLst, M._echoSortFunc)

	if curEquipEcho then
		table.insert(self._tempDataLst, 1, curEquipEcho)
	end

	table.insertto(self._tempDataLst, self._unInTagsDataLst, 0)
end

function M._echoSortFunc(itemA, itemB)
	if M._filterTyp == CommEnum.HeroSortFieldType.Level then
		return M._echoSortByLevel(itemA, itemB)
	elseif M._filterTyp == CommEnum.HeroSortFieldType.Quality then
		return M._echoSortByQuality(itemA, itemB)
	end

	return ItemUtil.commonSortFunc(itemA, itemB)
end

function M._echoSortByLevel(itemA, itemB)
	local valA = itemA:getLevel() or 1
	local valB = itemB:getLevel() or 1

	if valA == valB then
		return M._echoSortByQuality(itemA, itemB)
	elseif M._filterUpSort then
		return valA < valB
	else
		return valB < valA
	end
end

function M._echoSortByQuality(itemA, itemB)
	local valA = itemA:getQuality() or 1
	local valB = itemB:getQuality() or 1

	if valA == valB then
		return M._echoSortById(itemA, itemB)
	elseif M._filterUpSort then
		return valA < valB
	else
		return valB < valA
	end
end

function M._echoSortById(itemA, itemB)
	local valA = itemA:getItemId() or 0
	local valB = itemB:getItemId() or 0

	if valA == valB then
		return ItemUtil.commonSortFunc(itemA, itemB)
	elseif M._filterUpSort then
		return valA < valB
	else
		return valB < valA
	end
end

return M
