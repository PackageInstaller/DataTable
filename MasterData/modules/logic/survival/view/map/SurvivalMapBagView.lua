-- chunkname: @modules/logic/survival/view/map/SurvivalMapBagView.lua

module("modules.logic.survival.view.map.SurvivalMapBagView", package.seeall)

local SurvivalMapBagView = class("SurvivalMapBagView", BaseView)

function SurvivalMapBagView:onInitView()
	self._anim = gohelper.findChildAnim(self.viewGO, "")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._goscroll = gohelper.findChild(self.viewGO, "root/Right/scroll_collection")
	self._toggleBagBg = gohelper.findChild(self.viewGO, "root/toggleGroup/toggleBag/Background")
	self._toggleBagLabel = gohelper.findChildTextMesh(self.viewGO, "root/toggleGroup/toggleBag/Label")
	self._toggleNpcBg = gohelper.findChild(self.viewGO, "root/toggleGroup/toggleNPC/Background")
	self._toggleNpcLabel = gohelper.findChildTextMesh(self.viewGO, "root/toggleGroup/toggleNPC/Label")
	self._goinfoview = gohelper.findChild(self.viewGO, "root/#go_infoview")
	self._goheavy = gohelper.findChild(self.viewGO, "root/Right/#go_heavy")
	self._gosort = gohelper.findChild(self.viewGO, "root/Right/#go_sort")

	for i = 1, 3 do
		self["_txtcurrency" .. i] = gohelper.findChildTextMesh(self.viewGO, "root/#go_tag/tag" .. i .. "/#txt_tag" .. i)
		self["_btnCurrency" .. i] = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_tag/tag" .. i)
	end
end

function SurvivalMapBagView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self.viewContainer:registerCallback(ViewEvent.ToSwitchTab, self.onTabChange, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBag, self)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBag, self)

	for i = 1, 3 do
		self["_btnCurrency" .. i]:AddClickListener(self._openCurrencyTips, self, {
			id = i,
			btn = self["_btnCurrency" .. i]
		})
	end
end

function SurvivalMapBagView:removeEvents()
	self._btnClose:RemoveClickListener()
	self.viewContainer:unregisterCallback(ViewEvent.ToSwitchTab, self.onTabChange, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, self._refreshBag, self)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, self._refreshBag, self)

	for i = 1, 3 do
		self["_btnCurrency" .. i]:RemoveClickListener()
	end
end

function SurvivalMapBagView:onTabChange(_, toggleId)
	if self._curShowBag then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open_1)
	end

	toggleId = toggleId - 1

	if self._curShowBag == toggleId then
		return
	end

	self._curShowBag = toggleId

	local isBag = self._curShowBag == 1

	gohelper.setActive(self._toggleBagBg, isBag)
	gohelper.setActive(self._toggleNpcBg, not isBag)
	SLFramework.UGUI.GuiHelper.SetColor(self._toggleBagLabel, isBag and "#F5F1EB" or "#AEAEAE")
	SLFramework.UGUI.GuiHelper.SetColor(self._toggleNpcLabel, isBag and "#AEAEAE" or "#F5F1EB")
	gohelper.setActive(self._gosort, self._curShowBag == 1)
	self:_refreshBag()
end

function SurvivalMapBagView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_bag_open)
	MonoHelper.addNoUpdateLuaComOnceToGo(self._goheavy, SurvivalWeightPart, self:getBag())

	local sortComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gosort, SurvivalSortAndFilterPart)
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

	filterOptions[1] = {
		desc = luaLang("survival_filter_material"),
		type = SurvivalEnum.ItemFilterType.Material
	}
	filterOptions[2] = {
		desc = luaLang("survival_filter_equip"),
		type = SurvivalEnum.ItemFilterType.Equip
	}
	filterOptions[3] = {
		desc = luaLang("survival_filter_consume"),
		type = SurvivalEnum.ItemFilterType.Consume
	}
	self._curSort = sortOptions[1]
	self._isDec = true
	self._filterList = {}

	sortComp:setOptions(sortOptions, filterOptions, self._curSort, self._isDec)
	sortComp:setOptionChangeCallback(self._onSortChange, self)

	local infoViewRes = self.viewContainer._viewSetting.otherRes.infoView
	local infoGo = self:getResInst(infoViewRes, self._goinfoview)

	self._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(infoGo, SurvivalBagInfoPart)

	self._infoPanel:setIsShowEmpty(true)

	local itemRes = self.viewContainer._viewSetting.otherRes.itemRes

	self._item = self:getResInst(itemRes, self.viewGO)

	gohelper.setActive(self._item, false)

	self._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(self._goscroll, SurvivalSimpleListPart)

	self._simpleList:setCellUpdateCallBack(self._createItem, self, SurvivalBagItem, self._item)
end

function SurvivalMapBagView:_onSortChange(sortData, isDec, filterList)
	self._curSort = sortData
	self._isDec = isDec
	self._filterList = filterList

	self:_refreshBag()
end

function SurvivalMapBagView:_refreshBag()
	local itemMos = {}
	local preSelectUid

	for _, itemMo in ipairs(self:getBag().items) do
		if self._curShowBag == 1 then
			if not itemMo:isNPC() and SurvivalBagSortHelper.filterItemMo(self._filterList, itemMo) then
				table.insert(itemMos, itemMo)

				if self._preSelectUid == itemMo.uid then
					preSelectUid = itemMo.uid
				end
			end
		elseif itemMo:isNPC() then
			table.insert(itemMos, itemMo)

			if self._preSelectUid == itemMo.uid then
				preSelectUid = itemMo.uid
			end
		end
	end

	if self._curShowBag == 1 then
		SurvivalBagSortHelper.sortItems(itemMos, self._curSort.type, self._isDec)
	else
		SurvivalBagSortHelper.sortItems(itemMos, SurvivalEnum.ItemSortType.NPC, true)
	end

	if not preSelectUid and itemMos[1] then
		preSelectUid = itemMos[1].uid
	end

	SurvivalHelper.instance:makeArrFull(itemMos, SurvivalBagItemMo.Empty, 4, 5)

	self._preSelectUid = preSelectUid

	self._simpleList:setList(itemMos)
	self:_refreshInfo()

	for i = 1, 3 do
		self["_txtcurrency" .. i].text = self:getBag():getCurrencyNum(i)
	end
end

function SurvivalMapBagView:_createItem(obj, data, index)
	obj:updateMo(data)
	obj:setClickCallback(self._onItemClick, self)

	if data.uid == self._preSelectUid and self._preSelectUid then
		obj:setIsSelect(true)
	end
end

function SurvivalMapBagView:_onItemClick(item)
	if item._mo:isEmpty() then
		return
	end

	self._preSelectUid = item._mo.uid

	for comp in pairs(self._simpleList:getAllComps()) do
		comp:setIsSelect(self._preSelectUid and comp._mo.uid == self._preSelectUid)
	end

	self._anim.enabled = true

	self._anim:Play("switch", 0, 0)
	self:_refreshInfo()
end

function SurvivalMapBagView:_refreshInfo()
	if self._preSelectUid then
		local itemMo = self:getBag().itemsByUid[self._preSelectUid]

		self._infoPanel:updateMo(self._preSelectUid)

		if self._preSelectUid then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_details)
		end
	end
end

function SurvivalMapBagView:getBag()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	return weekInfo:getBag(SurvivalEnum.ItemSource.Map)
end

function SurvivalMapBagView:onClickModalMask()
	self:closeThis()
end

function SurvivalMapBagView:_openCurrencyTips(param)
	local trans = param.btn.transform
	local scale = trans.lossyScale
	local pos = trans.position
	local width = recthelper.getWidth(trans)
	local height = recthelper.getHeight(trans)

	pos.x = pos.x + width / 2 * scale.x
	pos.y = pos.y - height / 2 * scale.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BL",
		id = param.id,
		pos = pos
	})
end

function SurvivalMapBagView:onClose()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_close)
	TaskDispatcher.cancelTask(self._refreshInfo, self)
end

return SurvivalMapBagView
