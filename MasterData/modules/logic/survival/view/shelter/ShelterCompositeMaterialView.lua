-- chunkname: @modules/logic/survival/view/shelter/ShelterCompositeMaterialView.lua

module("modules.logic.survival.view.shelter.ShelterCompositeMaterialView", package.seeall)

local ShelterCompositeMaterialView = class("ShelterCompositeMaterialView", BaseView)

function ShelterCompositeMaterialView:onInitView()
	self.goPanel = gohelper.findChild(self.viewGO, "Panel/Left/#go_LeftTips")
	self.selectPanelCanvasGroup = gohelper.onceAddComponent(self.goPanel, typeof(UnityEngine.CanvasGroup))
	self.goScroll = gohelper.findChild(self.viewGO, "Panel/Left/#go_LeftTips/scroll_collection")

	local itemRes = self.viewContainer:getSetting().otherRes.itemRes

	self.goItem = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self.goItem, false)

	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "Panel/Left/#go_LeftTips/#btn_close")
	self.gosort = gohelper.findChild(self.viewGO, "Panel/Left/#go_LeftTips/#go_sort")
	self.goInfoView = gohelper.findChild(self.viewGO, "Panel/Left/#go_LeftTips/#go_infoview")
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.isPanelVisible = false

	gohelper.setActive(self.goPanel, false)
end

function ShelterCompositeMaterialView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnMapBagUpdate, self.onMapBagUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.addClickCb(self, self.btnClose, self.onClickCloseBtn, self)
end

function ShelterCompositeMaterialView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnMapBagUpdate, self.onMapBagUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self:removeClickCb(self.btnClose)
end

function ShelterCompositeMaterialView:onMapBagUpdate()
	self:refreshView()
end

function ShelterCompositeMaterialView:onShelterBagUpdate()
	self:refreshView()
end

function ShelterCompositeMaterialView:onClickCloseBtn()
	self:closeMaterialView()
end

function ShelterCompositeMaterialView:closeMaterialView()
	self.isShow = false

	self:refreshView()
end

function ShelterCompositeMaterialView:showMaterialView(index)
	self.isShow = true
	self.selectIndex = index

	self:refreshView()
end

function ShelterCompositeMaterialView:onItemClick(item)
	if item._mo:isEmpty() then
		return
	end

	self._preSelectUid = item._mo.uid

	self:refreshView()
end

function ShelterCompositeMaterialView:onOpen()
	self.isShow = false
	self._preSelectUid = nil
	self.selectIndex = nil

	self:refreshView()
end

function ShelterCompositeMaterialView:refreshView()
	self:setPanelVisible(self.isShow)

	if not self.isShow then
		return
	end

	self:refreshFilter()
	self:refreshList()
	self:refreshInfo()
end

function ShelterCompositeMaterialView:setPanelVisible(isVisible)
	if self.isPanelVisible == isVisible then
		return
	end

	self.isPanelVisible = isVisible

	gohelper.setActive(self.goPanel, true)

	if isVisible then
		self.animator:Play("panel_in")

		self.selectPanelCanvasGroup.interactable = true
		self.selectPanelCanvasGroup.blocksRaycasts = true
	else
		self.animator:Play("panel_out")

		self.selectPanelCanvasGroup.interactable = false
		self.selectPanelCanvasGroup.blocksRaycasts = false

		gohelper.setActive(self.goInfoView, false)
	end
end

function ShelterCompositeMaterialView:refreshInfo()
	local itemMo = self:getBag():getItemByUid(self._preSelectUid)

	if not itemMo then
		gohelper.setActive(self.goInfoView, false)

		return
	end

	gohelper.setActive(self.goInfoView, true)

	if not self._infoPanel then
		local infoViewRes = self.viewContainer:getSetting().otherRes.infoView
		local infoGo = self.viewContainer:getResInst(infoViewRes, self.goInfoView)

		self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

		local t = {
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Composite,
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Composite
		}

		self._infoPanel:setChangeSource(t)
	end

	self._infoPanel:updateMo(itemMo)
end

function ShelterCompositeMaterialView:refreshList()
	if not self._simpleList then
		self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self.goScroll, SurvivalSimpleListPart)

		self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalBagItem, self.goItem)
	end

	local bag = self:getBag()
	local itemMos = {}
	local preSelectUid

	for _, itemMo in ipairs(bag.items) do
		if itemMo.co.type == SurvivalEnum.ItemType.Equip and not self.viewContainer:isSelectItem(self.selectIndex, itemMo) and SurvivalBagSortHelper.filterEquipMo(self._filterList, itemMo) then
			table.insert(itemMos, itemMo)

			if self._preSelectUid == itemMo.uid then
				preSelectUid = itemMo.uid
			end
		end
	end

	SurvivalBagSortHelper.sortItems(itemMos, self._curSort.type, self._isDec)
	SurvivalHelper.instance:makeArrFull(itemMos, SurvivalBagItemMo.Empty, 5, 4)

	self._preSelectUid = preSelectUid

	self._simpleList:setList(itemMos)
end

function ShelterCompositeMaterialView:_createItem(obj, data, index)
	obj:updateMo(data)
	obj:setClickCallback(self.onItemClick, self)

	if data.uid == self._preSelectUid and self._preSelectUid then
		obj:setIsSelect(true)
	end
end

function ShelterCompositeMaterialView:getBag()
	return SurvivalMapHelper.instance:getBagMo()
end

function ShelterCompositeMaterialView:refreshFilter()
	if self.filterComp then
		return
	end

	self.filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.gosort, SurvivalSortAndFilterPart)

	local sortOptions = {}

	sortOptions[1] = {
		desc = luaLang("survival_sort_time"),
		type = SurvivalEnum.ItemSortType.Time
	}
	sortOptions[2] = {
		desc = luaLang("survival_sort_mass"),
		type = SurvivalEnum.ItemSortType.Mass
	}
	sortOptions[3] = {
		desc = luaLang("survival_sort_worth"),
		type = SurvivalEnum.ItemSortType.Worth
	}
	sortOptions[4] = {
		desc = luaLang("survival_sort_type"),
		type = SurvivalEnum.ItemSortType.Type
	}

	local filterOptions = {}

	for i, co in ipairs(lua_survival_equip_found.configList) do
		table.insert(filterOptions, {
			desc = co.name,
			type = co.id
		})
	end

	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	self.filterComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	self.filterComp:setOptionChangeCallback(self._onSortChange, self)
end

function ShelterCompositeMaterialView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	self:refreshView()
end

function ShelterCompositeMaterialView:onClose()
	return
end

return ShelterCompositeMaterialView
