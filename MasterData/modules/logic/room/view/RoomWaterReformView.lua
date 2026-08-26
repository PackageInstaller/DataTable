-- chunkname: @modules/logic/room/view/RoomWaterReformView.lua

module("modules.logic.room.view.RoomWaterReformView", package.seeall)

local RoomWaterReformView = class("RoomWaterReformView", BaseView)

function RoomWaterReformView:onInitView()
	self._btnsave = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_save")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_left/#btn_reset")
	self._gotip = gohelper.findChild(self.viewGO, "#go_bottom/#go_tip")
	self._goblockContent = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent")
	self._gowater = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_water")
	self._btnwater = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#go_blockContent/#go_water")
	self._goselectwater = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_water/#go_select")
	self._gounselectwater = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_water/#go_unselect")
	self._goblock = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_block")
	self._btnblock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#go_blockContent/#go_block")
	self._goselectblock = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_block/#go_select")
	self._gounselectblock = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_block/#go_unselect")
	self._goblockMode = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_blockMode")
	self._dropblockselectmode = gohelper.findChildDropdown(self.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#drop_filter")
	self._goclear = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#go_clear")
	self._btnblockclear = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#go_clear/#btn_clear")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._simagecostitem = gohelper.findChildSingleImage(self.viewGO, "#go_topright/container/resource/icon")
	self._txtcostitem = gohelper.findChildText(self.viewGO, "#go_topright/container/resource/txt_quantity")
	self._txtchangenum = gohelper.findChildText(self.viewGO, "#go_topright/container/resource/txt_quantity/txt_change")
	self._btncostclick = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/container/resource/#btn_click")
	self._btninitblockcolor = gohelper.findChildButtonWithAudio(self.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial")
	self._goinitblockcolornum = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial/#go_num")
	self._txtinitblockcolornum = gohelper.findChildTextMesh(self.viewGO, "#go_bottom/#go_blockContent/layout/#btn_initial/#go_num/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomWaterReformView:addEvents()
	self._btnsave:AddClickListener(self._btnsaveOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnblockclear:AddClickListener(self._btnblockClearOnClick, self)
	self._dropblockselectmode:AddOnValueChanged(self.onBlockSelectModeValueChange, self)
	self._btncostclick:AddClickListener(self._onCostItemClick, self)
	self._btnblock:AddClickListener(self._btnModeOnClick, self, RoomEnum.ReformMode.Block)
	self._btnwater:AddClickListener(self._btnModeOnClick, self, RoomEnum.ReformMode.Water)
	self._btninitblockcolor:AddClickListener(self._btninitblockcolorOnClick, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._waterReformShowChanged, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.OnReformChangeSelectedEntity, self._onSelectedChange, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, self._onRoomBlockReform, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onItemChanged, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.addEventCb(self, RoomWaterReformController.instance, RoomEvent.OnChangReformMode, self._onChangeReformMode, self)
end

function RoomWaterReformView:removeEvents()
	self._btnsave:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnblockclear:RemoveClickListener()
	self._dropblockselectmode:RemoveOnValueChanged()
	self._btncostclick:RemoveClickListener()
	self._btnblock:RemoveClickListener()
	self._btnwater:RemoveClickListener()
	self._btninitblockcolor:RemoveClickListener()
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, self._waterReformShowChanged, self)
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.OnReformChangeSelectedEntity, self._onSelectedChange, self)
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.OnRoomBlockReform, self._onRoomBlockReform, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
	self.removeEventCb(self, RoomWaterReformController.instance, RoomEvent.OnChangReformMode, self._onChangeReformMode, self)
end

function RoomWaterReformView:_btnsaveOnClick()
	RoomWaterReformController.instance:saveReform()
end

function RoomWaterReformView:_btnresetOnClick()
	local hasChangeWaterType = RoomWaterReformModel.instance:hasChangedWaterType()
	local hasChangeBlockColor = RoomWaterReformModel.instance:hasChangedBlockColor()

	if hasChangeWaterType or hasChangeBlockColor then
		GameFacade.showMessageBox(MessageBoxIdDefine.WaterReformResetConfirm, MsgBoxEnum.BoxType.Yes_No, self._confirmReset, nil, nil, self)
	else
		GameFacade.showToast(ToastEnum.NoWaterReform)
	end
end

function RoomWaterReformView:_confirmReset()
	RoomWaterReformController.instance:resetReform()
end

function RoomWaterReformView:_btnblockClearOnClick()
	RoomWaterReformController.instance:clearSelectBlock()
end

function RoomWaterReformView:onBlockSelectModeShow()
	transformhelper.setLocalScale(self._transblockDropArrow, 1, -1, 1)
end

function RoomWaterReformView:onBlockSelectModeValueChange(index)
	if not self.initBlockSelectModeDrop then
		return
	end

	if self.blockSelectModeList then
		local selectMode = self.blockSelectModeList[index + 1]

		RoomWaterReformController.instance:changeBlockSelectMode(selectMode)
	end
end

function RoomWaterReformView:onBlockSelectModeHide()
	transformhelper.setLocalScale(self._transblockDropArrow, 1, 1, 1)
end

function RoomWaterReformView:_onCostItemClick()
	MaterialTipController.instance:showMaterialInfo(self._costItemType, self._costItemId)
end

function RoomWaterReformView:_btnModeOnClick(targetMode)
	RoomWaterReformController.instance:changeReformMode(targetMode)
end

function RoomWaterReformView:_btninitblockcolorOnClick()
	RoomWaterReformController.instance:selectBlockColorType(RoomWaterReformModel.InitBlockColor)
end

function RoomWaterReformView:_waterReformShowChanged()
	local isWaterReform = RoomWaterReformModel.instance:isWaterReform()

	if isWaterReform then
		self._animatorPlayer:Play("open")
		self:refreshUI()
	else
		self._animatorPlayer:Play("close", self._showBackBlock, self)
	end
end

function RoomWaterReformView:_showBackBlock()
	self.viewContainer:selectBlockOpTab(RoomEnum.RoomViewBlockOpMode.BackBlock)
end

function RoomWaterReformView:_onSelectedChange()
	self:refreshSelectTip()
	self:refreshDefaultSelect()
end

function RoomWaterReformView:_onRoomBlockReform()
	self:refreshCostItemQuantity()
end

function RoomWaterReformView:_onItemChanged()
	self:refreshCostItemQuantity()
end

function RoomWaterReformView:_onChangeReformMode()
	self:refreshReformMode()
end

function RoomWaterReformView:_editableInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._contentAnimator = self._goblockContent:GetComponent(RoomEnum.ComponentType.Animator)
	self._contentAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(self._goblockContent)
	self._transblockDropArrow = gohelper.findChild(self.viewGO, "#go_bottom/#go_blockContent/#go_blockMode/#drop_filter/Arrow").transform

	self:initBlockSelectModeDropFilter()

	local costItem = UnlockVoucherConfig.instance:getRoomColorConst(UnlockVoucherEnum.ConstId.RoomBlockColorReformCostItem, "#", true)

	self._costItemType = costItem[1]
	self._costItemId = costItem[2]

	local _, icon = ItemModel.instance:getItemConfigAndIcon(self._costItemType, self._costItemId)

	self._simagecostitem:LoadImage(icon)
	gohelper.setActive(self._goinitblockcolornum, false)
end

function RoomWaterReformView:initBlockSelectModeDropFilter()
	self.dropBlockSelectModeExtend = DropDownExtend.Get(self._dropblockselectmode.gameObject)

	self.dropBlockSelectModeExtend:init(self.onBlockSelectModeShow, self.onBlockSelectModeHide, self)

	self.blockSelectModeList = {
		RoomEnum.BlockColorReformSelectMode.Single,
		RoomEnum.BlockColorReformSelectMode.Multiple,
		RoomEnum.BlockColorReformSelectMode.All
	}

	local modeName = {}

	for i, selectMode in ipairs(self.blockSelectModeList) do
		local selectModeNameLangId = RoomEnum.BlockColorReformSelectModeName[selectMode]
		local selectModeName = luaLang(selectModeNameLangId)

		table.insert(modeName, selectModeName)
	end

	self._dropblockselectmode:ClearOptions()
	self._dropblockselectmode:AddOptions(modeName)

	self.initBlockSelectModeDrop = true
end

function RoomWaterReformView:onUpdateParam()
	return
end

function RoomWaterReformView:onOpen()
	self._contentAnimatorPlayer:Play("open")

	local curIndex = 0
	local curSelectMode = RoomWaterReformModel.instance:getBlockColorReformSelectMode()

	for i, selectMode in ipairs(self.blockSelectModeList) do
		if curSelectMode == selectMode then
			curIndex = i - 1

			break
		end
	end

	self._dropblockselectmode:SetValue(curIndex)
	self:refreshUI()
end

function RoomWaterReformView:refreshUI()
	self:refreshReformMode()
	self:refreshDefaultSelect()
	self:refreshSelectTip()
	self:refreshCostItemQuantity()
end

function RoomWaterReformView:refreshReformMode()
	local curReformMode = RoomWaterReformModel.instance:getReformMode()
	local isWaterReform = curReformMode == RoomEnum.ReformMode.Water
	local isBlockReform = curReformMode == RoomEnum.ReformMode.Block

	gohelper.setActive(self._goselectwater, isWaterReform)
	gohelper.setActive(self._gounselectwater, not isWaterReform)
	gohelper.setActive(self._btninitblockcolor, isBlockReform)
	gohelper.setActive(self._goblockMode, isBlockReform)
	gohelper.setActive(self._goselectblock, isBlockReform)
	gohelper.setActive(self._gounselectblock, not isBlockReform)
end

function RoomWaterReformView:refreshDefaultSelect()
	local curReformMode = RoomWaterReformModel.instance:getReformMode()
	local isWaterReform = curReformMode == RoomEnum.ReformMode.Water
	local isBlockReform = curReformMode == RoomEnum.ReformMode.Block

	if isWaterReform then
		local defaultSelectWaterType = RoomWaterReformListModel.instance:getDefaultSelectWaterType()

		RoomWaterReformListModel.instance:setSelectWaterType(defaultSelectWaterType)
	elseif isBlockReform then
		local defaultBlockColor = RoomWaterReformListModel.instance:getDefaultSelectBlockColor()

		RoomWaterReformListModel.instance:setSelectBlockColor(defaultBlockColor)
	end
end

function RoomWaterReformView:refreshSelectTip()
	local hasSelectedReformTarget = false
	local curReformMode = RoomWaterReformModel.instance:getReformMode()

	if curReformMode == RoomEnum.ReformMode.Water then
		hasSelectedReformTarget = RoomWaterReformModel.instance:hasSelectWaterArea()
	elseif curReformMode == RoomEnum.ReformMode.Block then
		hasSelectedReformTarget = RoomWaterReformModel.instance:hasSelectedBlock()
	end

	gohelper.setActive(self._goclear, hasSelectedReformTarget)
	gohelper.setActive(self._gotip, not hasSelectedReformTarget)
end

function RoomWaterReformView:refreshCostItemQuantity()
	self._txtcostitem.text = ItemModel.instance:getItemQuantity(self._costItemType, self._costItemId)

	local changeCount = RoomWaterReformModel.instance:getChangedBlockColorCount(nil, RoomWaterReformModel.InitBlockColor)

	self._txtchangenum.text = string.format("-%s", changeCount)

	gohelper.setActive(self._txtchangenum, changeCount > 0)
end

function RoomWaterReformView:onClose()
	return
end

function RoomWaterReformView:onDestroyView()
	self._simagecostitem:UnLoadImage()

	if self.dropBlockSelectModeExtend then
		self.dropBlockSelectModeExtend:dispose()
	end
end

return RoomWaterReformView
