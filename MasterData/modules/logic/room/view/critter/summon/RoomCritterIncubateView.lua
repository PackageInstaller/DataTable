-- chunkname: @modules/logic/room/view/critter/summon/RoomCritterIncubateView.lua

module("modules.logic.room.view.critter.summon.RoomCritterIncubateView", package.seeall)

local RoomCritterIncubateView = class("RoomCritterIncubateView", BaseView)

function RoomCritterIncubateView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "root")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "root/top/#simage_title")
	self._gocritter = gohelper.findChild(self.viewGO, "root/right/#go_critter")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "root/right/#go_critter/#simage_rightbg")
	self._goEmpty = gohelper.findChild(self.viewGO, "root/right/#go_critter/#go_empty")
	self._scrollcritter = gohelper.findChildScrollRect(self.viewGO, "root/right/#go_critter/#scroll_critter")
	self._gocritterItem = gohelper.findChild(self.viewGO, "root/right/#go_critter/#scroll_critter/viewport/content/#go_critterItem")
	self._btnsort = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_critter/sort/#drop_sort/#btn_sort")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/#go_critter/sort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "root/right/#go_critter/sort/#btn_filter/#go_filter")
	self._gocritter1 = gohelper.findChild(self.viewGO, "root/middle/#go_critter1")
	self._btnclickarea1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/middle/#go_critter1/#btn_clickarea1")
	self._gocritter2 = gohelper.findChild(self.viewGO, "root/middle/#go_critter2")
	self._btnclickarea2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/middle/#go_critter2/#btn_clickarea2")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_summon")
	self._simagecurrency = gohelper.findChildSingleImage(self.viewGO, "root/bottom/#btn_summon/currency/#simage_currency")
	self._txtcurrency = gohelper.findChildText(self.viewGO, "root/bottom/#btn_summon/currency/#txt_currency")
	self._btnoverview = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_overview")
	self._imageselect = gohelper.findChildImage(self.viewGO, "root/bottom/#image_select")
	self._txtselect = gohelper.findChildText(self.viewGO, "root/bottom/#image_select/#txt_select")
	self._imagetips1 = gohelper.findChildImage(self.viewGO, "root/bottom/#image_tips1")
	self._txttips1 = gohelper.findChildText(self.viewGO, "root/bottom/#image_tips1/#txt_tips1")
	self._imagetips2 = gohelper.findChildImage(self.viewGO, "root/bottom/#image_tips2")
	self._txttips2 = gohelper.findChildText(self.viewGO, "root/bottom/#image_tips2/#txt_tips2")
	self._goBackBtns = gohelper.findChild(self.viewGO, "root/#go_BackBtns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterIncubateView:addEvents()
	self._btnsort:AddClickListener(self._btnsortOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btnoverview:AddClickListener(self._btnoverviewOnClick, self)
end

function RoomCritterIncubateView:removeEvents()
	self._btnsort:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnclickarea1:RemoveClickListener()
	self._btnclickarea2:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btnoverview:RemoveClickListener()
end

function RoomCritterIncubateView:_btnsortOnClick()
	self._curSortWay = not self._curSortWay

	CritterIncubateModel.instance:setSortWay(self._curSortWay)
	self:_setSortWay()
end

function RoomCritterIncubateView:_btnfilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomCritterIncubateView:_btnsummonOnClick()
	local toast, name = CritterIncubateModel.instance:notSummonToast()

	if string.nilorempty(toast) then
		CritterIncubateController.instance:onIncubateCritter()
	else
		GameFacade.showToast(toast, name)
	end
end

function RoomCritterIncubateView:_btnoverviewOnClick()
	CritterIncubateController.instance:openRoomCritterDetailView()
end

function RoomCritterIncubateView:_addEvents()
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, self._onSelectParentCritter, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, self._onRemoveParentCritter, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onRefreshBtn, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onCloseGetCritter, self._onCloseGetCritter, self)
	self.addEventCb(self, CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, self._showPreview, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
end

function RoomCritterIncubateView:_removeEvents()
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onSelectParentCritter, self._onSelectParentCritter, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onRemoveParentCritter, self._onRemoveParentCritter, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onRefreshBtn, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onStartSummon, self._onStartSummon, self)
	self.removeEventCb(self, CritterSummonController.instance, CritterSummonEvent.onIncubateCritterPreviewReply, self._showPreview, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)

	if self._parentCritterItem then
		for _, item in pairs(self._parentCritterItem) do
			item.btn:RemoveClickListener()
		end
	end

	if self._dropSort then
		self._dropSort:RemoveOnValueChanged()
	end
end

function RoomCritterIncubateView:_onSelectParentCritter(index, uid)
	self:_refreshParentCritter(index, uid)
end

function RoomCritterIncubateView:_onRemoveParentCritter(index, uid)
	self:_refreshParentCritter(index, uid)
end

function RoomCritterIncubateView:_onStartSummon(param)
	local buildingUid = self.viewContainer:getContainerViewBuilding()

	CritterController.instance:dispatchEvent(CritterEvent.CritterBuildingHideView)
	CritterSummonController.instance:openSummonView(buildingUid, param)

	if self.root then
		gohelper.setActive(self.root, false)
	end
end

function RoomCritterIncubateView:_showPreview()
	local count, total = CritterIncubateModel.instance:getSelectParentCritterCount()
	local isCanPreview = total <= count

	if isCanPreview then
		local childMos = CritterIncubateModel.instance:getChildMOList()
		local isAdditionAttr
		local catalogueList = {}

		for _, mo in ipairs(childMos) do
			local additionAttr = mo:getAdditionAttr()

			isAdditionAttr = isAdditionAttr or next(additionAttr) ~= nil
		end

		for index = 1, total do
			local critterUId = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(index)

			if critterUId then
				local mo = CritterModel.instance:getCritterMOByUid(critterUId)

				if mo:getIsHighQuality() and not LuaUtil.tableContains(catalogueList, mo:getCatalogueName()) then
					table.insert(catalogueList, mo:getCatalogueName())
				end
			end

			gohelper.setActive(self._btnoverview.gameObject, true)
			gohelper.setActive(self._imageselect.gameObject, false)
			ZProj.UGUIHelper.SetGrayscale(self._btnsummon.gameObject, false)
		end

		self:_refreshTip(isAdditionAttr, catalogueList)
	end
end

function RoomCritterIncubateView:_hidePreview()
	gohelper.setActive(self._btnoverview.gameObject, false)
	gohelper.setActive(self._imageselect.gameObject, true)
	ZProj.UGUIHelper.SetGrayscale(self._btnsummon.gameObject, true)

	for _, item in ipairs(self._tipItem) do
		gohelper.setActive(item.go, false)
	end
end

function RoomCritterIncubateView:onCritterFilterTypeChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self:refreshCritterList()
end

function RoomCritterIncubateView:refreshCritterList()
	local critterCount = CritterIncubateListModel.instance:setMoList(self.filterMO)

	gohelper.setActive(self._goEmpty.gameObject, critterCount <= 0)
	gohelper.setActive(self._scrollcritter.gameObject, critterCount > 0)
	self:refreshFilterBtn()
end

function RoomCritterIncubateView:refreshFilterBtn()
	local isFiltering = self.filterMO:isFiltering()

	gohelper.setActive(self._gonotfilter, not isFiltering)
	gohelper.setActive(self._gofilter, isFiltering)
end

function RoomCritterIncubateView:_onCloseGetCritter()
	if self.root then
		gohelper.setActive(self.root, true)
	end
end

function RoomCritterIncubateView:_editableInitView()
	self._dropSort = gohelper.findChildDropdown(self.viewGO, "root/right/#go_critter/sort/#drop_sort")
	self._goSortWay = gohelper.findChild(self.viewGO, "root/right/#go_critter/sort/#drop_sort/arrow")
	self._canvasGroup = self.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._tipItem = self:getUserDataTb_()
	self._tipItem = {
		{
			go = self._imagetips1.gameObject,
			txt = self._txttips1
		},
		{
			go = self._imagetips2.gameObject,
			txt = self._txttips2
		}
	}
end

function RoomCritterIncubateView:onUpdateParam()
	return
end

function RoomCritterIncubateView:onOpen()
	self:_addEvents()

	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	self:_refreshParentCritter()
	self:_initSortFilter()
end

function RoomCritterIncubateView:onClose()
	self:_removeEvents()
end

function RoomCritterIncubateView:onDestroyView()
	self._simagecurrency:UnLoadImage()
end

function RoomCritterIncubateView:_onRefreshBtn()
	local toast = CritterIncubateModel.instance:notSummonToast()
	local isCan = string.nilorempty(toast)

	ZProj.UGUIHelper.SetGrayscale(self._btnsummon.gameObject, not isCan)

	local cost_icon, str = CritterIncubateModel.instance:getPoolCurrency()

	if string.nilorempty(cost_icon) then
		return
	end

	self._simagecurrency:LoadImage(cost_icon)

	self._txtcurrency.text = str or ""
end

function RoomCritterIncubateView:_refreshParentCritter(index, uid)
	local _, total = CritterIncubateModel.instance:getSelectParentCritterCount()
	local count = 0

	if index then
		local item = self:_getParentCritterItem(index)

		if item then
			self:_playParentCritterEffect(index)
		end
	end

	for index = 1, total do
		local critterUId = CritterIncubateModel.instance:getSelectParentCritterUIdByIndex(index)
		local item = self:_getParentCritterItem(index)

		if item then
			if critterUId then
				local mo = CritterModel.instance:getCritterMOByUid(critterUId)

				item._critterIcon = item._critterIcon or IconMgr.instance:getCommonCritterIcon(item.icon)

				item._critterIcon:onUpdateMO(mo)
				item._critterIcon:hideMood()
				item._critterIcon:setCustomClick(self._onClickParentCritter, self, mo)
				gohelper.setActive(item._critterIcon.viewGO.gameObject, true)

				local additionAttr = mo:getAdditionAttr()

				item._critterIcon:showUpTip(next(additionAttr) ~= nil)

				count = count + 1
			elseif item._critterIcon then
				gohelper.setActive(item._critterIcon.viewGO.gameObject, false)
			end
		end
	end

	self:_onRefreshBtn()

	if total <= count then
		CritterIncubateController.instance:onIncubateCritterPreview()
	else
		self:_hidePreview()

		self._txtselect.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_critter_incubate_select_count"), count, total)
	end
end

function RoomCritterIncubateView:_refreshTip(isAdditionAttr, catalogueList)
	local count = 1

	if isAdditionAttr then
		local item = self._tipItem[count]

		item.txt.text = luaLang("room_critter_incubate_tip_1")

		gohelper.setActive(item.go, true)

		count = count + 1
	end

	if LuaUtil.tableNotEmpty(catalogueList) then
		local item = self._tipItem[count]
		local _count = #catalogueList

		if _count == 1 then
			local lang = luaLang("room_critter_incubate_tip_2")

			item.txt.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, catalogueList[1])
		elseif _count == 2 then
			local lang = luaLang("room_critter_incubate_tip_3")

			item.txt.text = GameUtil.getSubPlaceholderLuaLangTwoParam(lang, catalogueList[1], catalogueList[2])
		end

		gohelper.setActive(item.go, true)

		count = count + 1
	end

	for i, item in ipairs(self._tipItem) do
		gohelper.setActive(item.go, i < count)
	end
end

function RoomCritterIncubateView:_onClickParentCritter(mo)
	local uid = mo.uid

	CritterIncubateModel.instance:removeSelectParentCritter(uid)
end

function RoomCritterIncubateView:_getParentCritterItem(index)
	self._parentCritterItem = self._parentCritterItem or self:getUserDataTb_()

	local item = self._parentCritterItem[index]

	if not item then
		item = {}

		local go = self["_gocritter" .. index]
		local btn = self["_btnclickarea" .. index]

		item.go = go
		item.icon = gohelper.findChild(go, "go_crittericon")
		item.btn = btn

		if item.btn then
			gohelper.setActive(item.btn.gameObject, false)
		end

		item.effect = gohelper.findChild(go, "#add_effect"):GetComponent(typeof(UnityEngine.Animation))

		table.insert(self._parentCritterItem, item)
	end

	return item
end

function RoomCritterIncubateView:_playParentCritterEffect(index)
	local item = self:_getParentCritterItem(index)

	if item then
		item.effect:Stop()
		gohelper.setActive(item.effect.gameObject, true)
		item.effect:Play()
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_niudan_put)
	end
end

function RoomCritterIncubateView:_initSortFilter()
	local options = {}

	for _, co in ipairs(lua_critter_attribute.configList) do
		table.insert(options, co.name)
	end

	self._curSelectOpetion = CritterIncubateModel.instance:getSortType()
	self._curSortWay = CritterIncubateModel.instance:getSortWay()

	self._dropSort:ClearOptions()
	self._dropSort:AddOptions(options)
	self._dropSort:AddOnValueChanged(self.onDropValueChanged, self)
	self._dropSort:SetValue(self._curSelectOpetion - 1)
	self:_setSortWay()
	self:refreshCritterList()
end

function RoomCritterIncubateView:onDropValueChanged(index)
	CritterIncubateModel.instance:setSortType(index + 1)
	CritterIncubateListModel.instance:sortMoList(self.filterMO)
end

function RoomCritterIncubateView:_setSortWay()
	local sortWay = CritterIncubateModel.instance:getSortWay()

	transformhelper.setLocalRotation(self._goSortWay.transform, 0, 0, sortWay and 180 or 0)
	CritterIncubateListModel.instance:sortMoList(self.filterMO)
end

return RoomCritterIncubateView
