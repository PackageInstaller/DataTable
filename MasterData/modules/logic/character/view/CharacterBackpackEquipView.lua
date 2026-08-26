-- chunkname: @modules/logic/character/view/CharacterBackpackEquipView.lua

module("modules.logic.character.view.CharacterBackpackEquipView", package.seeall)

local CharacterBackpackEquipView = class("CharacterBackpackEquipView", BaseView)

function CharacterBackpackEquipView:onInitView()
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "#scroll_equip")
	self._goequipsort = gohelper.findChild(self.viewGO, "#go_equipsort")
	self._btnequiplv = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipsort/bg/#btn_equiplv")
	self._btnequiprare = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipsort/bg/#btn_equiprare")
	self._btnequiptime = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipsort/bg/#btn_equiptime")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "#go_equipsort/#btn_filter")
	self._txtequipbackpacknum = gohelper.findChildText(self.viewGO, "go_num/#txt_equipbackpacknum")
	self._btncompose = gohelper.findChildButtonWithAudio(self.viewGO, "compose/#btn_compose")
	self._simageheart = gohelper.findChildSingleImage(self.viewGO, "#simage_heart")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterBackpackEquipView:addEvents()
	self._btnequiplv:AddClickListener(self._btnequiplvOnClick, self)
	self._btnequiprare:AddClickListener(self._btnequiprareOnClick, self)
	self._btnequiptime:AddClickListener(self._btnequiptimeOnClick, self)
	self._btncompose:AddClickListener(self._btncomposeOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
end

function CharacterBackpackEquipView:removeEvents()
	self._btnequiplv:RemoveClickListener()
	self._btnequiprare:RemoveClickListener()
	self._btnequiptime:RemoveClickListener()
	self._btncompose:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
end

function CharacterBackpackEquipView:_editableInitView()
	self._ani = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.addUIClickAudio(self._btnequiplv.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnequiprare.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btnequiptime.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	gohelper.addUIClickAudio(self._btncompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Open)
	self._simageheart:LoadImage(ResUrl.getCharacterIcon("bg_beijingwenli_xinzang"))

	self._equipLvBtns = self:getUserDataTb_()
	self._equipLvArrow = self:getUserDataTb_()
	self._equipQualityBtns = self:getUserDataTb_()
	self._equipQualityArrow = self:getUserDataTb_()

	for i = 1, 2 do
		self._equipLvBtns[i] = gohelper.findChild(self._btnequiplv.gameObject, "btn" .. tostring(i))
		self._equipLvArrow[i] = gohelper.findChild(self._equipLvBtns[i], "txt/arrow").transform
		self._equipQualityBtns[i] = gohelper.findChild(self._btnequiprare.gameObject, "btn" .. tostring(i))
		self._equipQualityArrow[i] = gohelper.findChild(self._equipQualityBtns[i], "txt/arrow").transform
	end

	gohelper.setActive(self._equipLvArrow[1].gameObject, false)
	gohelper.setActive(self._equipQualityArrow[1].gameObject, false)

	self.goNotFilter = gohelper.findChild(self.viewGO, "#go_equipsort/#btn_filter/#go_notfilter")
	self.goFilter = gohelper.findChild(self.viewGO, "#go_equipsort/#btn_filter/#go_filter")

	self.addEventCb(self, EquipController.instance, EquipEvent.onUpdateEquip, self.refreshEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.onDeleteEquip, self.refreshEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onEquipTypeHasChange, self)
end

function CharacterBackpackEquipView:_btncomposeOnClick()
	EquipController.instance:openEquipDecomposeView()
end

function CharacterBackpackEquipView:_btnequiplvOnClick()
	CharacterBackpackEquipListModel.instance:sortByLevel()
	self:_refreshEquipBtnIcon()
end

function CharacterBackpackEquipView:_btnequiprareOnClick()
	CharacterBackpackEquipListModel.instance:sortByQuality()
	self:_refreshEquipBtnIcon()
end

function CharacterBackpackEquipView:_btnequiptimeOnClick()
	CharacterBackpackEquipListModel.instance:sortByTime()
	self:_refreshEquipBtnIcon()
end

function CharacterBackpackEquipView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = self.viewName
	})
end

function CharacterBackpackEquipView:onUpdateParam()
	return
end

function CharacterBackpackEquipView:onOpen()
	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)

	self.viewContainer:setCurrentSelectCategoryId(ItemEnum.CategoryType.Equip)

	self._ani.enabled = #self.tabContainer._tabAbLoaders < 2
	self._scrollequip.verticalNormalizedPosition = 1

	self:refreshEquip()
	self:_refreshEquipBtnIcon()
end

function CharacterBackpackEquipView:_refreshEquipBtnIcon()
	local tag = CharacterBackpackEquipListModel.instance:getBtnTag()

	gohelper.setActive(self._equipLvBtns[1], tag ~= 1)
	gohelper.setActive(self._equipLvBtns[2], tag == 1)
	gohelper.setActive(self._equipQualityBtns[1], tag ~= 2)
	gohelper.setActive(self._equipQualityBtns[2], tag == 2)

	local levelState, qualityState, timeState = CharacterBackpackEquipListModel.instance:getRankState()

	transformhelper.setLocalScale(self._equipLvArrow[2], 1, levelState, 1)
	transformhelper.setLocalScale(self._equipQualityArrow[2], 1, qualityState, 1)
end

function CharacterBackpackEquipView:refreshEquip()
	local equipMoList = EquipModel.instance:getEquips()
	local newList = {}

	for _, equipMo in ipairs(equipMoList) do
		if equipMo.config and self.filterMo:checkIsIncludeTag(equipMo.config) then
			table.insert(newList, equipMo)
		end
	end

	CharacterBackpackEquipListModel.instance:setEquipListNew(newList)
	self:_showEquipBackpackNum()
	self:refreshFilterBtn()
end

function CharacterBackpackEquipView:onEquipTypeHasChange(viewName)
	if self.viewName ~= viewName then
		return
	end

	self._scrollequip.verticalNormalizedPosition = 1

	self:refreshEquip()
end

function CharacterBackpackEquipView:_showEquipBackpackNum()
	local count = CharacterBackpackEquipListModel.instance:getCount()

	self._txtequipbackpacknum.text = string.format("%s ：%s/%s", luaLang("equip"), count, EquipConfig.instance:getEquipBackpackMaxCount())
end

function CharacterBackpackEquipView:refreshFilterBtn()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self.goNotFilter, not isFiltering)
	gohelper.setActive(self.goFilter, isFiltering)
end

function CharacterBackpackEquipView:onClose()
	return
end

function CharacterBackpackEquipView:onDestroyView()
	EquipFilterModel.instance:clear(self.viewName)
	CharacterBackpackEquipListModel.instance:clearEquipList()
	self._simageheart:UnLoadImage()
end

return CharacterBackpackEquipView
