-- chunkname: @modules/logic/equip/view/decompose/EquipDecomposeView.lua

module("modules.logic.equip.view.decompose.EquipDecomposeView", package.seeall)

local EquipDecomposeView = class("EquipDecomposeView", BaseView)

function EquipDecomposeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	self._btnlvrank = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_equipsort/#btn_lvrank")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_equipsort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	self._txtnum = gohelper.findChildText(self.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/go_clear/#btn_clear")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "right_container/frame/#simage_equipicon")
	self._txtequipname = gohelper.findChildText(self.viewGO, "right_container/#txt_equipname")
	self._txtcount = gohelper.findChildText(self.viewGO, "right_container/#txt_count")
	self._btndecompose = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_decompose")
	self._goempty = gohelper.findChild(self.viewGO, "left_container/#go_empty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipDecomposeView:addEvents()
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnlvrank:AddClickListener(self._btnlvrankOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btndecompose:AddClickListener(self._btndecomposeOnClick, self)
end

function EquipDecomposeView:removeEvents()
	self._btnrarerank:RemoveClickListener()
	self._btnlvrank:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnfastadd:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btndecompose:RemoveClickListener()
end

EquipDecomposeView.Color = {
	Select = "#DF6931",
	Normal = "#717070"
}

function EquipDecomposeView:_btnrarerankOnClick()
	EquipDecomposeListModel.instance:changeRareStatus()
end

function EquipDecomposeView:_btnlvrankOnClick()
	EquipDecomposeListModel.instance:changeLevelSortStatus()
end

function EquipDecomposeView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.EquipFilterView, {
		isNotShowObtain = true,
		viewName = self.viewName
	})
end

function EquipDecomposeView:_btnfastaddOnClick()
	EquipDecomposeListModel.instance:fastAddEquip()
end

function EquipDecomposeView:_btnclearOnClick()
	EquipDecomposeListModel.instance:clearSelectEquip()
end

EquipDecomposeView.DecomposeAnimKey = "DecomposeAnimKey"

function EquipDecomposeView:_btndecomposeOnClick()
	local count = EquipDecomposeListModel.instance:getSelectCount()

	if count < 1 then
		return
	end

	self.scrollRect.velocity = Vector2.zero

	UIBlockMgr.instance:startBlock(EquipDecomposeView.DecomposeAnimKey)
	EquipController.instance:dispatchEvent(EquipEvent.OnEquipBeforeDecompose)
	TaskDispatcher.runDelay(self._sendDecomposeRequest, self, EquipEnum.DecomposeAnimDuration)
end

function EquipDecomposeView:_sendDecomposeRequest()
	UIBlockMgr.instance:endBlock(EquipDecomposeView.DecomposeAnimKey)

	local count = EquipDecomposeListModel.instance:getSelectCount()

	if count < 1 then
		return
	end

	EquipRpc.instance:sendEquipDecomposeRequest()
end

function EquipDecomposeView:onClickDecomposeEquip()
	EquipController.instance:openEquipView({
		equipId = EquipConfig.instance.equipDecomposeEquipId
	})
end

function EquipDecomposeView:_editableInitView()
	self.multipleChar = luaLang("multiple")
	self._txtcount.text = string.format("%s0", self.multipleChar)
	self.preCount = 0
	self.scrollRect = gohelper.findChild(self.viewGO, "left_container/#go_scrollcontainer/#scroll_equip"):GetComponent(typeof(UnityEngine.UI.ScrollRect))
	self.txtCountAnimator = gohelper.findChildComponent(self.viewGO, "right_container/vx_count/ani", gohelper.Type_Animator)

	self._simagebg:LoadImage(ResUrl.getEquipBg("full/equip_decompose_fullbg.png"))

	self.goclear = gohelper.findChild(self.viewGO, "left_container/go_clear")
	self.goDecomposeBtn = self._btndecompose.gameObject
	self.rareBtnItem = self:createBtnItem(self._btnrarerank.gameObject)
	self.lvBtnItem = self:createBtnItem(self._btnlvrank.gameObject)
	self.rareBtnItem.tag = EquipDecomposeListModel.SortTag.Rare
	self.lvBtnItem.tag = EquipDecomposeListModel.SortTag.Level

	gohelper.setActive(self._goempty, false)
	self:initFilterDrop()
	gohelper.addUIClickAudio(self._btndecompose.gameObject, AudioEnum.HeroGroupUI.Play_UI_Action_Mainstart)

	self.decomposeEquipClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "right_container/frame/#simage_equipicon")

	self.decomposeEquipClick:AddClickListener(self.onClickDecomposeEquip, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipTypeHasChange, self.onEquipTypeHasChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipDecomposeSelectEquipChange, self.onEquipDecomposeSelectEquipChange, self)
	self.addEventCb(self, EquipController.instance, EquipEvent.OnEquipDecomposeSortStatusChange, self.onEquipDecomposeSortStatusChange, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenView, self)
end

function EquipDecomposeView:createBtnItem(go)
	local btnItem = self:getUserDataTb_()

	btnItem.go = go
	btnItem.goSelect = gohelper.findChild(btnItem.go, "select")
	btnItem.txtGraphic = gohelper.findChildComponent(btnItem.go, "normal/txt", gohelper.Type_Graphic)
	btnItem.arrowGraphic = gohelper.findChildComponent(btnItem.go, "normal/txt/arrow", gohelper.Type_Graphic)
	btnItem.arrowTr = gohelper.findChildComponent(btnItem.go, "normal/txt/arrow", gohelper.Type_Transform)

	return btnItem
end

function EquipDecomposeView:initFilterDrop()
	self.dropFilter = gohelper.findChildDropdown(self.viewGO, "left_container/#go_cost/#drop_filter")
	self._goDrop = self.dropFilter.gameObject
	self.dropArrowTr = gohelper.findChildComponent(self._goDrop, "Arrow", gohelper.Type_Transform)
	self.dropClick = gohelper.getClick(self._goDrop)
	self.dropExtend = DropDownExtend.Get(self._goDrop)

	self.dropExtend:init(self.onDropShow, self.onDropHide, self)

	self.filterRareList = {}

	for i = EquipEnum.EquipDecomposeMinRare, EquipEnum.EquipDecomposeMaxRare do
		table.insert(self.filterRareList, i)
	end

	local dropStrList = {}

	for _, value in ipairs(self.filterRareList) do
		if value == 0 then
			table.insert(dropStrList, luaLang("equip_filter_all"))
		else
			table.insert(dropStrList, string.format(luaLang("equip_filter_str"), value + 1))
		end
	end

	self.dropFilter:ClearOptions()
	self.dropFilter:AddOptions(dropStrList)
	self.dropFilter:AddOnValueChanged(self.onDropValueChanged, self)
	self.dropClick:AddClickListener(function()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)
	end, self)
	EquipDecomposeListModel.instance:setFilterRare(self.filterRareList[1])

	self.initDropDone = true
end

function EquipDecomposeView:onDropValueChanged(index)
	if not self.initDropDone then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	EquipDecomposeListModel.instance:setFilterRare(self.filterRareList[index + 1])
end

function EquipDecomposeView:onDropHide()
	transformhelper.setLocalScale(self.dropArrowTr, 1, 1, 1)
end

function EquipDecomposeView:onDropShow()
	transformhelper.setLocalScale(self.dropArrowTr, 1, -1, 1)
end

function EquipDecomposeView:onOpen()
	self.decomposeEquipConfig = EquipConfig.instance:getEquipCo(EquipConfig.instance.equipDecomposeEquipId)
	self.decomposeEquipUnitCount = EquipConfig.instance.equipDecomposeEquipUnitCount
	self.filterMo = EquipFilterModel.instance:generateFilterMo(self.viewName)

	EquipDecomposeListModel.instance:initEquipData()
	self:refreshUI()
	TaskDispatcher.runDelay(self.firstRefreshEquip, self, EquipEnum.EquipEnterAnimWaitTime)
end

function EquipDecomposeView:firstRefreshEquip()
	self.viewContainer._views[2]._animationStartTime = Time.time

	self:refreshCenterGroupUI()
end

function EquipDecomposeView:refreshUI()
	self:refreshLeft()
	self:refreshRight()
end

function EquipDecomposeView:refreshLeft()
	self:refreshTopGroupUI()
	self:refreshBottomGroup()
end

function EquipDecomposeView:refreshRight()
	self:refreshDecomposeEquip()
	self:refreshCount()
	self:refreshDecomposeBtn()
end

function EquipDecomposeView:refreshTopGroupUI()
	self:refreshBtnItem(self.rareBtnItem)
	self:refreshBtnItem(self.lvBtnItem)
	self:refreshFilterBtn()
end

function EquipDecomposeView:refreshCenterGroupUI()
	EquipDecomposeListModel.instance:refreshEquip()
	gohelper.setActive(self._goempty, EquipDecomposeListModel.instance:isEmpty())
end

function EquipDecomposeView:refreshBottomGroup()
	local selectedCount = EquipDecomposeListModel.instance:getSelectCount()

	self._txtnum.text = string.format("<color=#ff7933>%s</color>/%s", selectedCount, EquipEnum.DecomposeMaxCount)

	self:refreshClear()
end

function EquipDecomposeView:refreshBtnItem(btnItem)
	local isSelect = EquipDecomposeListModel.instance:getSortTag() == btnItem.tag
	local isAscend = EquipDecomposeListModel.instance:getSortIsAscend(btnItem.tag)

	gohelper.setActive(btnItem.goSelect, isSelect)
	SLFramework.UGUI.GuiHelper.SetColor(btnItem.txtGraphic, (isSelect or nil) and (EquipDecomposeView.Color.Select or EquipDecomposeView.Color.Normal))
	SLFramework.UGUI.GuiHelper.SetColor(btnItem.arrowGraphic, (isSelect or nil) and (EquipDecomposeView.Color.Select or EquipDecomposeView.Color.Normal))
	transformhelper.setLocalScale(btnItem.arrowTr, 1, isAscend and 1 or -1, 1)
end

function EquipDecomposeView:refreshFilterBtn()
	local isFiltering = self.filterMo:isFiltering()

	gohelper.setActive(self._gonotfilter, not isFiltering)
	gohelper.setActive(self._gofilter, isFiltering)
end

function EquipDecomposeView:refreshClear()
	gohelper.setActive(self.goclear, EquipDecomposeListModel.instance:getDecomposeEquipCount() > 0)
end

function EquipDecomposeView:refreshCount()
	local currentCount = EquipDecomposeListModel.instance:getDecomposeEquipCount() * self.decomposeEquipUnitCount

	if self.preCount == currentCount then
		return
	end

	self.preCount = currentCount

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(self.preCount, currentCount, EquipEnum.DecomposeTxtAnimDuration, self.frameCallback, self.finishCallback, self)

	self.txtCountAnimator:Play("vx_count", 0, 0)
end

function EquipDecomposeView:frameCallback(value)
	self._txtcount.text = string.format("%s%s", self.multipleChar, math.ceil(value))
end

function EquipDecomposeView:finishCallback()
	self.tweenId = nil
end

function EquipDecomposeView:refreshDecomposeEquip()
	self._simageequipicon:LoadImage(ResUrl.getEquipIcon(self.decomposeEquipConfig.icon .. "_equip"))

	self._txtequipname.text = self.decomposeEquipConfig.name
end

function EquipDecomposeView:refreshDecomposeBtn()
	local selectCount = EquipDecomposeListModel.instance:getSelectCount()

	ZProj.UGUIHelper.SetGrayscale(self.goDecomposeBtn, selectCount < 1)
end

function EquipDecomposeView:onEquipTypeHasChange(viewName)
	if viewName ~= self.viewName then
		return
	end

	EquipDecomposeListModel.instance:updateEquipData(self.filterMo)
	self:refreshCenterGroupUI()
	self:refreshFilterBtn()
end

function EquipDecomposeView:onEquipDecomposeSelectEquipChange()
	self:refreshBottomGroup()
	self:refreshCount()
	self:refreshDecomposeBtn()
end

function EquipDecomposeView:onOpenView(viewName)
	if viewName == ViewName.CommonPropView then
		self:onDecomposeSuccess()
	end
end

function EquipDecomposeView:onDecomposeSuccess()
	self.preCount = 0

	EquipDecomposeListModel.instance:updateEquipData(self.filterMo)
	self:refreshCenterGroupUI()
	self:refreshDecomposeBtn()

	self._txtcount.text = string.format("%s0", self.multipleChar)
end

function EquipDecomposeView:onEquipDecomposeSortStatusChange()
	EquipDecomposeListModel.instance:sortEquipList()
	self:refreshCenterGroupUI()
	self:refreshBtnItem(self.rareBtnItem)
	self:refreshBtnItem(self.lvBtnItem)
end

function EquipDecomposeView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)

		self.tweenId = nil
	end
end

function EquipDecomposeView:onClose()
	UIBlockMgr.instance:endBlock(EquipDecomposeView.DecomposeAnimKey)
	TaskDispatcher.cancelTask(self._sendDecomposeRequest, self)
	TaskDispatcher.cancelTask(self.firstRefreshEquip, self)
	self:killTween()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
end

function EquipDecomposeView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageequipicon:UnLoadImage()
	self.dropFilter:RemoveOnValueChanged()
	self.dropClick:RemoveClickListener()
	self.decomposeEquipClick:RemoveClickListener()
end

return EquipDecomposeView
