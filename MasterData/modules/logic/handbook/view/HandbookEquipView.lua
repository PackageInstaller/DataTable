-- chunkname: @modules/logic/handbook/view/HandbookEquipView.lua

module("modules.logic.handbook.view.HandbookEquipView", package.seeall)

local HandbookEquipView = class("HandbookEquipView", BaseView)

function HandbookEquipView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goequip1 = gohelper.findChild(self.viewGO, "equipContain/#go_equip1")
	self._goequip2 = gohelper.findChild(self.viewGO, "equipContain/#go_equip2")
	self._goequip3 = gohelper.findChild(self.viewGO, "equipContain/#go_equip3")
	self._goequip4 = gohelper.findChild(self.viewGO, "equipContain/#go_equip4")
	self._goleftpage = gohelper.findChild(self.viewGO, "#btn_leftpage")
	self._goleftarrow = gohelper.findChild(self.viewGO, "#btn_leftpage/#go_leftarrow")
	self._gorightpage = gohelper.findChild(self.viewGO, "#btn_rightpage")
	self._gorightarrow = gohelper.findChild(self.viewGO, "#btn_rightpage/#go_rightarrow")
	self._gorarerank = gohelper.findChild(self.viewGO, "sortbtn/#btn_rarerank")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "sortbtn/#btn_filter")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandbookEquipView:addEvents()
	self._btnfilter:AddClickListener(self.onClickBtnFilter, self)
end

function HandbookEquipView:removeEvents()
	self._btnfilter:RemoveClickListener()
end

HandbookEquipView.everyPageShowCount = 4
HandbookEquipView.DragAbsPositionX = 50
HandbookEquipView.AnimatorBlockName = "HandbookEquipViewAnimator"

function HandbookEquipView:onClickBtnFilter()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		viewName = self.viewName
	})
end

function HandbookEquipView:leftPageOnClick()
	if self.currentPage <= 1 then
		return
	end

	UIBlockMgr.instance:startBlock(HandbookEquipView.AnimatorBlockName)
	self.animatorPlayer:Play("rightout", function(self)
		self:refreshPage(self.currentPage - 1)
		self.animatorPlayer:Play("rightin")
		UIBlockMgr.instance:endBlock(HandbookEquipView.AnimatorBlockName)
	end, self)
end

function HandbookEquipView:rightPageOnClick()
	if self.currentPage >= self.maxPage then
		return
	end

	UIBlockMgr.instance:startBlock(HandbookEquipView.AnimatorBlockName)
	self.animatorPlayer:Play("leftout", function(self)
		self:refreshPage(self.currentPage + 1)
		self.animatorPlayer:Play("leftin")
		UIBlockMgr.instance:endBlock(HandbookEquipView.AnimatorBlockName)
	end, self)
end

function HandbookEquipView:rareRankOnClick()
	self.rareRankAscending = not self.rareRankAscending

	self:refreshSort()
	self:refreshUI()
end

function HandbookEquipView:onEquipItemClick(index)
	local equipCo = self.equipList[(self.currentPage - 1) * HandbookEquipView.everyPageShowCount + index]

	EquipController.instance:openEquipView({
		fromHandBook = true,
		equipId = equipCo.id
	})
end

function HandbookEquipView:customAddEvent()
	self._leftPageClick = gohelper.findChildClickWithAudio(self._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	self._rightPageClick = gohelper.findChildClickWithAudio(self._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	self._leftPageClick:AddClickListener(self.leftPageOnClick, self)
	self._rightPageClick:AddClickListener(self.rightPageOnClick, self)

	self._rareRankClick = gohelper.getClickWithAudio(self._gorarerank, AudioEnum.UI.play_ui_hero_card_click)

	self._rareRankClick:AddClickListener(self.rareRankOnClick, self)

	self._drag = SLFramework.UGUI.UIDragListener.Get(self.viewGO)

	self._drag:AddDragBeginListener(self.onDragBeginHandle, self)
	self._drag:AddDragEndListener(self.onDragEndHandle, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onFilterValueChange, self)
end

function HandbookEquipView:_editableInitView()
	self.simageList = self:getUserDataTb_()
	self.txtNameList = self:getUserDataTb_()
	self.txtNameEnList = self:getUserDataTb_()
	self.goRareList = self:getUserDataTb_()
	self.goEquipList = self:getUserDataTb_()
	self.equipClickList = self:getUserDataTb_()

	self:addItem(self._goequip1, 1)
	self:addItem(self._goequip2, 2)
	self:addItem(self._goequip3, 3)
	self:addItem(self._goequip4, 4)

	self.goRareRankIcon1 = gohelper.findChild(self.viewGO, "sortbtn/#btn_rarerank/txt/go_icon1")
	self.goRareRankIcon2 = gohelper.findChild(self.viewGO, "sortbtn/#btn_rarerank/txt/go_icon2")
	self.goNotFilter = gohelper.findChild(self.viewGO, "sortbtn/#btn_filter/#go_notfilter")
	self.goFilter = gohelper.findChild(self.viewGO, "sortbtn/#btn_filter/#go_filter")
	self.currentPage = 0
	self.maxPage = 0
	self.equipList = nil
	self.startDragPosX = 0
	self.rareRankAscending = false

	self:customAddEvent()
	self._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))

	self.animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
end

function HandbookEquipView:onCareerClick(careerMo)
	if self.career == careerMo.career then
		return
	end

	self.career = careerMo.career

	self:refreshUI()
end

function HandbookEquipView:addItem(goItem, index)
	local simage = gohelper.findChildSingleImage(goItem, "simage_equipicon")
	local txtname = gohelper.findChildText(goItem, "txt_name")
	local txtnameEn = gohelper.findChildText(goItem, "txt_name/txt_nameEn")
	local rareList = self:getUserDataTb_()

	for i = 3, 6 do
		local rareGo = gohelper.findChild(goItem, "txt_name/rare/rare" .. i)

		table.insert(rareList, rareGo)
	end

	table.insert(self.simageList, simage)
	table.insert(self.txtNameList, txtname)
	table.insert(self.txtNameEnList, txtnameEn)
	table.insert(self.goRareList, rareList)
	table.insert(self.goEquipList, goItem)

	local click = gohelper.getClick(goItem)

	click:AddClickListener(self.onEquipItemClick, self, index)
	table.insert(self.equipClickList, click)
end

function HandbookEquipView:onFilterValueChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	self:refreshEquipData()
	self:refreshSort()
	self:refreshUI()
end

function HandbookEquipView:onOpen()
	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)

	self:refreshEquipData()
	self:refreshSort()
	self:refreshUI()
end

function HandbookEquipView:refreshEquipData()
	self.equipList = self:getEquips()
	self.maxPage = self:getMaxPageNum()
end

function HandbookEquipView:refreshSort()
	if self.rareRankAscending then
		table.sort(self.equipList, self.rareAscendingSortFunc)
	else
		table.sort(self.equipList, self.rareDescendingSortFunc)
	end
end

function HandbookEquipView:refreshUI()
	self:refreshBtnStatus()
	self:refreshPage(1)
end

function HandbookEquipView:refreshBtnStatus()
	gohelper.setActive(self.goRareRankIcon1, self.rareRankAscending)
	gohelper.setActive(self.goRareRankIcon2, not self.rareRankAscending)
	self:refreshFilterBtnStatus()
end

function HandbookEquipView:refreshFilterBtnStatus()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self.goFilter, isFiltering)
	gohelper.setActive(self.goNotFilter, not isFiltering)
end

function HandbookEquipView:refreshPage(pageNum)
	self.currentPage = pageNum

	local startIndex = (pageNum - 1) * HandbookEquipView.everyPageShowCount

	for i = 1, HandbookEquipView.everyPageShowCount do
		self:handleItem(i, self.equipList[startIndex + i])
	end

	gohelper.setActive(self._goleftarrow, self.currentPage > 1)
	gohelper.setActive(self._gorightarrow, self.currentPage < self.maxPage)
end

function HandbookEquipView.rareAscendingSortFunc(a, b)
	if a.rare ~= b.rare then
		return a.rare < b.rare
	end

	return a.id < b.id
end

function HandbookEquipView.rareDescendingSortFunc(a, b)
	if a.rare ~= b.rare then
		return a.rare > b.rare
	end

	return a.id < b.id
end

function HandbookEquipView:getEquips()
	local equips = {}

	for _, handbookEquipCo in ipairs(lua_handbook_equip.configList) do
		local equipCo = EquipConfig.instance:getEquipCo(handbookEquipCo.equipId)

		if self:checkNeedEquipCo(equipCo) then
			table.insert(equips, equipCo)
		end
	end

	return equips
end

function HandbookEquipView:getMaxPageNum()
	return math.ceil(#self.equipList / HandbookEquipView.everyPageShowCount)
end

function HandbookEquipView:checkNeedEquipCo(equipCo)
	if not equipCo then
		return false
	end

	if not self.filterMo:isFiltering() then
		return true
	end

	if not self.filterMo:checkIsIncludeTag(equipCo) then
		return false
	end

	local obtainType = self.filterMo:getObtainType()

	if obtainType == EquipFilterModel.ObtainEnum.All then
		return true
	end

	if obtainType == EquipFilterModel.ObtainEnum.Get then
		return HandbookModel.instance:haveEquip(equipCo.id)
	else
		return not HandbookModel.instance:haveEquip(equipCo.id)
	end
end

function HandbookEquipView:handleItem(index, equipCo)
	if not equipCo then
		gohelper.setActive(self.goEquipList[index], false)

		return
	end

	gohelper.setActive(self.goEquipList[index], true)
	ZProj.UGUIHelper.SetGrayscale(self.simageList[index].gameObject, not HandbookModel.instance:haveEquip(equipCo.id))
	self.simageList[index]:LoadImage(ResUrl.getHandbookEquipImage(equipCo.icon .. index))

	self.txtNameList[index].text = equipCo.name
	self.txtNameEnList[index].text = equipCo.name_en

	for i = 1, #self.goRareList[index] do
		if equipCo.rare == i + 1 then
			gohelper.setActive(self.goRareList[index][i], true)
		else
			gohelper.setActive(self.goRareList[index][i], false)
		end
	end
end

function HandbookEquipView:onDragBeginHandle(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function HandbookEquipView:onDragEndHandle(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > HandbookEquipView.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if endDragPosX < self.startDragPosX then
			self:rightPageOnClick()
		else
			self:leftPageOnClick()
		end
	end
end

function HandbookEquipView:onClose()
	return
end

function HandbookEquipView:onDestroyView()
	EquipFilterModel.instance:clear(self.viewName)

	for _, click in ipairs(self.equipClickList) do
		click:RemoveClickListener()
	end

	self._leftPageClick:RemoveClickListener()
	self._rightPageClick:RemoveClickListener()
	self._rareRankClick:RemoveClickListener()

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self.equipList = nil

	self._simagebg:UnLoadImage()

	for i = 1, #self.simageList do
		self.simageList[i]:UnLoadImage()
	end
end

return HandbookEquipView
