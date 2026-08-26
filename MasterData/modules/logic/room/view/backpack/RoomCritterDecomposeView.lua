-- chunkname: @modules/logic/room/view/backpack/RoomCritterDecomposeView.lua

module("modules.logic.room.view.backpack.RoomCritterDecomposeView", package.seeall)

local RoomCritterDecomposeView = class("RoomCritterDecomposeView", BaseView)
local DecomposeAnimKey = "DecomposeAnimKey"
local CritterEnterAnimWaitTime = 0.2
local DecomposeTxtAnimDuration = 0.5
local DecomposeAnimDuration = 0.9

function RoomCritterDecomposeView:onInitView()
	self._btncirtterRare = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_critterSort/#btn_cirtterRare")
	self._dropmaturefilter = gohelper.findChildDropdown(self.viewGO, "left_container/#go_critterSort/#drop_mature")
	self._transmatureDroparrow = gohelper.findChild(self.viewGO, "left_container/#go_critterSort/#drop_mature/#go_arrow").transform
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_critterSort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "left_container/#go_critterSort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "left_container/#go_critterSort/#btn_filter/#go_filter")
	self._dropRareFilter = gohelper.findChildDropdown(self.viewGO, "left_container/#go_cost/#drop_filter")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	self._txtselectNum = gohelper.findChildText(self.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	self._goempty = gohelper.findChild(self.viewGO, "left_container/#go_empty")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/go_clear/#btn_clear")
	self._simageresultItemIcon = gohelper.findChildSingleImage(self.viewGO, "right_container/frame/#simage_resultIcon")
	self._txtresultItemName = gohelper.findChildText(self.viewGO, "right_container/#txt_resultName")
	self._txtResultCount = gohelper.findChildText(self.viewGO, "right_container/#txt_count")
	self._btndecompose = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_decompose")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomCritterDecomposeView:addEvents()
	self._btncirtterRare:AddClickListener(self._btncirtterRareOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btndecompose:AddClickListener(self._btndecomposeOnClick, self)
	self._dropmaturefilter:AddOnValueChanged(self.onMatureDropValueChange, self)
	self._dropRareFilter:AddOnValueChanged(self.onRareDropValueChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, self.onCritterDecomposeSelectChange, self)
	self.addEventCb(self, CritterController.instance, CritterEvent.CritterChangeSort, self.onCritterSortChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenView, self)
end

function RoomCritterDecomposeView:removeEvents()
	self._btncirtterRare:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnfastadd:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btndecompose:RemoveClickListener()
	self._dropmaturefilter:RemoveOnValueChanged()
	self._dropRareFilter:RemoveOnValueChanged()
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeFilterType, self.onCritterFilterTypeChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterDecomposeChangeSelect, self.onCritterDecomposeSelectChange, self)
	self.removeEventCb(self, CritterController.instance, CritterEvent.CritterChangeSort, self.onCritterSortChange, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenView, self)
end

function RoomCritterDecomposeView:_btncirtterRareOnClick()
	local isRareAscend = RoomCritterDecomposeListModel.instance:getIsSortByRareAscend()

	RoomCritterDecomposeListModel.instance:setIsSortByRareAscend(not isRareAscend)
end

function RoomCritterDecomposeView:_btnfilterOnClick()
	local filterTypeList = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(filterTypeList, self.viewName)
end

function RoomCritterDecomposeView:_btnfastaddOnClick()
	RoomCritterDecomposeListModel.instance:fastAddCritter()
end

function RoomCritterDecomposeView:_btnclearOnClick()
	RoomCritterDecomposeListModel.instance:clearSelectedCritter()
end

function RoomCritterDecomposeView:_btndecomposeOnClick()
	local count = RoomCritterDecomposeListModel.instance:getSelectCount()

	if count <= 0 then
		return
	end

	local isLimitPass = RoomCritterDecomposeListModel.instance:checkDecomposeCountLimit()

	if not isLimitPass then
		GameFacade.showToast(ToastEnum.CritterDecomposeLimitCount)

		return
	end

	self.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(DecomposeAnimKey)
	CritterController.instance:dispatchEvent(CritterEvent.BeforeDecomposeCritter)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan)
	TaskDispatcher.runDelay(self._sendCritterDecomposeRequest, self, DecomposeAnimDuration)
end

function RoomCritterDecomposeView:_sendCritterDecomposeRequest()
	UIBlockMgr.instance:endBlock(DecomposeAnimKey)

	local count = RoomCritterDecomposeListModel.instance:getSelectCount()

	if count <= 0 then
		return
	end

	local uidList = RoomCritterDecomposeListModel.instance:getSelectUIds()

	CritterRpc.instance:sendBanishCritterRequest(uidList)
end

function RoomCritterDecomposeView:onMatureDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(self._transmatureDroparrow, 1, 1, 1)
end

function RoomCritterDecomposeView:onMatureDropValueChange(index)
	if not self.initMatureDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)

	if self.filterMatureTypeList then
		local matureFilterType = RoomCritterDecomposeListModel.instance:getFilterMature()

		if matureFilterType and matureFilterType == self.filterMatureTypeList then
			return
		end

		RoomCritterDecomposeListModel.instance:setFilterMature(self.filterMatureTypeList)
		RoomCritterDecomposeListModel.instance:updateCritterList(self.filterMO)
		self:refreshCritterList()
	end
end

function RoomCritterDecomposeView:onMatureDropHide()
	transformhelper.setLocalScale(self._transmatureDroparrow, 1, -1, 1)
end

function RoomCritterDecomposeView:onRareDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	transformhelper.setLocalScale(self._transRareDropArrow, 1, -1, 1)
end

function RoomCritterDecomposeView:onRareDropValueChange(index)
	if not self.initRareDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	RoomCritterDecomposeListModel.instance:setFilterRare(self.filterRareList[index + 1])
end

function RoomCritterDecomposeView:onRareDropHide()
	transformhelper.setLocalScale(self._transRareDropArrow, 1, 1, 1)
end

function RoomCritterDecomposeView:onCritterFilterTypeChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	RoomCritterDecomposeListModel.instance:updateCritterList(self.filterMO)
	self:refreshCritterList()
	self:refreshFilterBtn()
end

function RoomCritterDecomposeView:onCritterDecomposeSelectChange()
	self:refreshSelectNum()
	self:refreshResultCount()
	self:refreshDecomposeBtn()
end

function RoomCritterDecomposeView:onCritterSortChange()
	RoomCritterDecomposeListModel.instance:sortCritterList()
	self:refreshCritterList()
	self:refreshBtnItem(self.rareBtnItem)
end

function RoomCritterDecomposeView:onOpenView(viewName)
	if viewName ~= ViewName.CommonPropView then
		return
	end

	self:clearPerCount()
	RoomCritterDecomposeListModel.instance:updateCritterList(self.filterMO)
	self:refreshCritterList()
	self:refreshDecomposeBtn()
end

function RoomCritterDecomposeView:_editableInitView()
	self._goRareDrop = self._dropRareFilter.gameObject
	self._transRareDropArrow = gohelper.findChildComponent(self._goRareDrop, "Arrow", gohelper.Type_Transform)
	self.scrollRect = gohelper.findChild(self.viewGO, "left_container/#go_scrollcontainer/#scroll_critter"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self.goclear = gohelper.findChild(self.viewGO, "left_container/go_clear")
	self.txtCountAnimator = gohelper.findChildComponent(self.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)
	self.goDecomposeBtn = self._btndecompose.gameObject
	self.rareBtnItem = self:createSortBtnItem(self._btncirtterRare.gameObject)

	self:initMatureDropFilter()
	self:initRareFilterDrop()

	self.multipleChar = luaLang("multiple")

	self:clearVar()

	self.filterMO = CritterFilterModel.instance:generateFilterMO(self.viewName)

	RoomCritterDecomposeListModel.instance:updateCritterList(self.filterMO)
end

function RoomCritterDecomposeView:createSortBtnItem(btnGO)
	local btnItem = self:getUserDataTb_()

	btnItem.go = btnGO
	btnItem.goNormal = gohelper.findChild(btnItem.go, "normal")
	btnItem.goSelected = gohelper.findChild(btnItem.go, "selected")
	btnItem.arrowTr = gohelper.findChildComponent(btnItem.go, "selected/txt/arrow", gohelper.Type_Transform)

	gohelper.setActive(btnItem.goNormal, false)
	gohelper.setActive(btnItem.goSelected, true)

	return btnItem
end

function RoomCritterDecomposeView:initMatureDropFilter()
	self.dropMatureExtend = DropDownExtend.Get(self._dropmaturefilter.gameObject)

	self.dropMatureExtend:init(self.onMatureDropShow, self.onMatureDropHide, self)

	self.filterMatureTypeList = {
		CritterEnum.MatureFilterType.All,
		CritterEnum.MatureFilterType.Mature,
		CritterEnum.MatureFilterType.NotMature
	}

	local filterName = {}

	for _, filterType in ipairs(self.filterMatureTypeList) do
		local filterTypeNameLangId = CritterEnum.MatureFilterTypeName[filterType]
		local filterTypeName = luaLang(filterTypeNameLangId)

		table.insert(filterName, filterTypeName)
	end

	self._dropmaturefilter:ClearOptions()
	self._dropmaturefilter:AddOptions(filterName)

	self.initMatureDropDone = true
end

function RoomCritterDecomposeView:initRareFilterDrop()
	self.dropRareExtend = DropDownExtend.Get(self._goRareDrop)

	self.dropRareExtend:init(self.onRareDropShow, self.onRareDropHide, self)

	local dropStrList = {}

	self.filterRareList = {}

	for value = CritterEnum.CritterDecomposeMinRare, CritterEnum.CritterDecomposeMaxRare do
		table.insert(self.filterRareList, value)

		local str = GameUtil.getSubPlaceholderLuaLang(luaLang("critter_rare_filter"), {
			value + 1
		})

		table.insert(dropStrList, str)
	end

	self._dropRareFilter:ClearOptions()
	self._dropRareFilter:AddOptions(dropStrList)

	self.initRareDropDone = true
end

function RoomCritterDecomposeView:onUpdateParam()
	return
end

function RoomCritterDecomposeView:onOpen()
	self:setResultIcon()
	self:refresh()
	gohelper.setActive(self._goempty, false)
	TaskDispatcher.runDelay(self.initCritterList, self, CritterEnterAnimWaitTime)
end

function RoomCritterDecomposeView:setResultIcon()
	local resultItemIconPath
	local resultItemName = ""
	local strResult = CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.DecomposeResult)
	local resultList = string.splitToNumber(strResult, "#")

	if resultList then
		local config, icon = ItemModel.instance:getItemConfigAndIcon(resultList[1], resultList[2])

		resultItemName = config.name
		resultItemIconPath = icon
	end

	if not string.nilorempty(resultItemIconPath) then
		self._simageresultItemIcon:LoadImage(resultItemIconPath)
	end

	self._txtresultItemName.text = resultItemName
end

function RoomCritterDecomposeView:initCritterList()
	self.viewContainer._views[2]._animationStartTime = Time.time

	self:refreshCritterList()
end

function RoomCritterDecomposeView:refreshCritterList()
	RoomCritterDecomposeListModel.instance:refreshCritterShowList()

	local isEmpty = RoomCritterDecomposeListModel.instance:isEmpty()

	gohelper.setActive(self._goempty, isEmpty)
end

function RoomCritterDecomposeView:refresh()
	self:refreshTop()
	self:refreshSelectNum()
	self:refreshResultCount()
	self:refreshDecomposeBtn()
end

function RoomCritterDecomposeView:refreshTop()
	self:refreshBtnItem(self.rareBtnItem)
	self:refreshFilterBtn()
end

function RoomCritterDecomposeView:refreshBtnItem(btnItem)
	local isRareAscend = RoomCritterDecomposeListModel.instance:getIsSortByRareAscend()
	local scaleY = isRareAscend and 1 or -1

	transformhelper.setLocalScale(btnItem.arrowTr, 1, scaleY, 1)
end

function RoomCritterDecomposeView:refreshFilterBtn()
	local isFiltering = self.filterMO:isFiltering()

	gohelper.setActive(self._gonotfilter, not isFiltering)
	gohelper.setActive(self._gofilter, isFiltering)
end

function RoomCritterDecomposeView:refreshSelectNum()
	local selectedCount = RoomCritterDecomposeListModel.instance:getSelectCount()

	self._txtselectNum.text = string.format("<color=#ff7933>%s</color>/%s", selectedCount, CritterEnum.DecomposeMaxCount)

	gohelper.setActive(self.goclear, selectedCount > 0)
end

function RoomCritterDecomposeView:refreshResultCount()
	local currentCount = RoomCritterDecomposeListModel.instance:getDecomposeCritterCount()

	if self.preCount == currentCount then
		return
	end

	self.preCount = currentCount

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.preCount, currentCount, DecomposeTxtAnimDuration, self.frameCallback, self.finishCallback, self)

	self.txtCountAnimator:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_gplay_uihuan2)
end

function RoomCritterDecomposeView:frameCallback(value)
	self:setTxtResultCount(math.ceil(value))
end

function RoomCritterDecomposeView:setTxtResultCount(count)
	self._txtResultCount.text = string.format("%s%s", self.multipleChar, count)
end

function RoomCritterDecomposeView:finishCallback()
	self.tweenId = nil
end

function RoomCritterDecomposeView:refreshDecomposeBtn()
	local selectCount = RoomCritterDecomposeListModel.instance:getSelectCount()

	ZProj.UGUIHelper.SetGrayscale(self.goDecomposeBtn, selectCount < 1)
end

function RoomCritterDecomposeView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function RoomCritterDecomposeView:clearVar()
	self:clearPerCount()
	self:killTween()
end

function RoomCritterDecomposeView:clearPerCount()
	self.preCount = 0

	self:setTxtResultCount(self.preCount)
end

function RoomCritterDecomposeView:onClose()
	TaskDispatcher.cancelTask(self.initCritterList, self)
	TaskDispatcher.cancelTask(self._sendCritterDecomposeRequest, self)
	UIBlockMgr.instance:endBlock(DecomposeAnimKey)
	self:clearVar()
end

function RoomCritterDecomposeView:onDestroyView()
	self._simageresultItemIcon:UnLoadImage()

	if self.dropMatureExtend then
		self.dropMatureExtend:dispose()
	end

	if self.dropRareExtend then
		self.dropRareExtend:dispose()
	end
end

return RoomCritterDecomposeView
