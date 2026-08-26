-- chunkname: @modules/logic/sodache/view/inside/SodacheTakeView.lua

module("modules.logic.sodache.view.inside.SodacheTakeView", package.seeall)

local SodacheTakeView = class("SodacheTakeView", BaseView)
local DropIndex = {
	Supplies = 1,
	All = 0,
	Offering = 2
}

function SodacheTakeView:onInitView()
	self._btnSelect = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_Sort/#btn_select")
	self._gobatchselect = gohelper.findChild(self.viewGO, "left_container/#go_Sort/#btn_select/#go_selected")
	self._dropdown = gohelper.findChildDropdown(self.viewGO, "left_container/#go_Sort/#drop_mature")
	self._goleftempty = gohelper.findChild(self.viewGO, "left_container/#go_empty")
	self._goleftscroll = gohelper.findChild(self.viewGO, "left_container/#scroll_card")
	self._gorightempty = gohelper.findChild(self.viewGO, "right_container/empty")
	self._gorightscroll = gohelper.findChild(self.viewGO, "right_container/#scroll_card")
	self._txtcosttype = gohelper.findChildTextMesh(self.viewGO, "right_container/cost/titletxt")
	self._txtnum = gohelper.findChildTextMesh(self.viewGO, "right_container/cost/#txt_num")
	self._gosuccess = gohelper.findChild(self.viewGO, "right_container/cost/bg/go_success")
	self._gofail = gohelper.findChild(self.viewGO, "right_container/cost/bg/go_fail")
	self._btnquick = gohelper.findChildButtonWithAudio(self.viewGO, "btnlayout/#btn_quick")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "btnlayout/#btn_confirm")
	self._goeffect = gohelper.findChild(self.viewGO, "btnlayout/#go_preview/bg/vx_add")
	self._txtpreview = gohelper.findChildTextMesh(self.viewGO, "btnlayout/#go_preview/#txt_preview")
	self._gosortBg = gohelper.findChild(self.viewGO, "left_container/#go_Sort/#drop_mature/sortBg")
end

function SodacheTakeView:addEvents()
	self._btnSelect:AddClickListener(self._onBatchSelect, self)
	self._btnquick:AddClickListener(self.onQuickHandle, self)
	self._btnconfirm:AddClickListener(self.onConfirmHandle, self)
	self._dropdown:AddOnValueChanged(self.onDropValueChange, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnClickGoodsItem, self._refreshItems, self)
end

function SodacheTakeView:removeEvents()
	self._btnSelect:RemoveClickListener()
	self._btnquick:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
	self._dropdown:RemoveOnValueChanged()
	SodacheController.instance:unregisterCallback(SodacheEvent.OnClickGoodsItem, self._refreshItems, self)
end

function SodacheTakeView:onOpen()
	self.selectMo = SodacheSettleCardSelectMo.New()
	self.selectMo.isBatch = true

	gohelper.setActive(self._gobatchselect, self.selectMo.isBatch)
	self:initScrollView()
	self:initDropDown()

	local insideMo = SodacheModel.instance:getInsideMo()

	if insideMo.prop.escapeCardCountLimit > 0 then
		self._txtcosttype.text = luaLang("sodache_takeview_cardcount")

		self.selectMo:setCardCountOrCost(false, insideMo.prop.escapeCardCountLimit)
	else
		self._txtcosttype.text = luaLang("sodache_takeview_costcount")

		local winCost = SodacheUtil.getAttr(SodacheEnum.AttrId.WinCost) + SodacheUtil.getAttr(SodacheEnum.AttrId.WinCostEx)
		local failCost = SodacheUtil.getAttr(SodacheEnum.AttrId.FailCost) + SodacheUtil.getAttr(SodacheEnum.AttrId.FailCostEx)
		local costTotal = winCost

		if not insideMo.prop.win then
			costTotal = math.min(winCost, failCost)
		end

		costTotal = math.max(costTotal, 0)

		self.selectMo:setCardCountOrCost(true, costTotal)
	end

	gohelper.setActive(self._gosuccess, insideMo.prop.win)
	gohelper.setActive(self._gofail, not insideMo.prop.win)

	local items1 = SodacheUtil.getItemsByCardType(SodacheEnum.CardType.Offering, SodacheEnum.BagType.Inside)
	local items2 = SodacheUtil.getItemsByCardType(SodacheEnum.CardType.Supplies, SodacheEnum.BagType.Inside)

	for i, v in ipairs(items1) do
		if v.itemCo.takeOut == 1 then
			self.selectMo:addInitItem(v.configId, v.count)
		end
	end

	for i, v in ipairs(items2) do
		if v.itemCo.takeOut == 1 then
			self.selectMo:addInitItem(v.configId, v.count)
		end
	end

	self:onDropValueChange(0)
	self:_refreshRightItems()
end

function SodacheTakeView:_refreshItems()
	self:_refreshLeftItems()
	self:_refreshRightItems()
end

function SodacheTakeView:initScrollView()
	self._simpleListLeft = MonoHelper.addNoUpdateLuaComOnceToGo(self._goleftscroll, SurvivalSimpleListPart)

	self._simpleListLeft:setCellCls(SodacheSettleUnselectCardItem)
	self._simpleListLeft:setCellParam(self.selectMo)

	self._simpleListRight = MonoHelper.addNoUpdateLuaComOnceToGo(self._gorightscroll, SurvivalSimpleListPart)

	self._simpleListRight:setCellCls(SodacheSettleSelectCardItem)
	self._simpleListRight:setCellParam(self.selectMo)
end

function SodacheTakeView:initDropDown()
	self.dropExtend = DropDownExtend.Get(self._dropdown.gameObject)

	self.dropExtend:init(self.onDropShow, self.onDropHide, self)

	local filterName = {
		luaLang("sodache_all"),
		luaLang("sodache_cardtype_1"),
		luaLang("sodache_cardtype_5")
	}

	self._dropdown:ClearOptions()
	self._dropdown:AddOptions(filterName)

	self.initDropDone = true
end

function SodacheTakeView:_onBatchSelect()
	self.selectMo.isBatch = not self.selectMo.isBatch

	gohelper.setActive(self._gobatchselect, self.selectMo.isBatch)
end

function SodacheTakeView:onConfirmHandle()
	if #self.selectMo.selectItems == 0 and #self.selectMo.unSelectItems > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.SodacheMessageId373005, MsgBoxEnum.BoxType.Yes_No, self._realConfirm, nil, nil, self)
	else
		self:_realConfirm()
	end
end

function SodacheTakeView:_realConfirm()
	local items = {}

	for i, v in ipairs(self.selectMo.selectItems) do
		table.insert(items, {
			itemId = v.serverMo.configId,
			count = v.serverMo.count
		})
	end

	SodacheInsideRpc.instance:sendSodacheInsideSubmitMaterialSettle(items, self.onRecvMsg, self)
end

function SodacheTakeView:onDropShow()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_click)

	local dropIndex = self._dropdown:GetValue()
	local list = gohelper.findChild(self._dropdown.gameObject, "Dropdown List")

	if list then
		local content = gohelper.findChild(list, "tempViewport/tempContent")

		if content then
			local item = content.transform:GetChild(dropIndex + 1)

			if item then
				local bg = gohelper.findChild(item.gameObject, "bg")

				if bg then
					gohelper.setActive(bg, true)
				end
			end
		end
	end
end

function SodacheTakeView:onDropHide()
	return
end

function SodacheTakeView:onDropValueChange(index)
	if not self.initDropDone then
		return
	end

	if self._dropIndex == index then
		return
	end

	self._dropIndex = index

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_set_volume_button)
	self:_refreshLeftItems()
	ZProj.UGUIHelper.SetGrayscale(self._gosortBg, index == DropIndex.All)
end

function SodacheTakeView:_refreshLeftItems()
	local itemList = {}

	if self._dropIndex == DropIndex.All then
		itemList = self.selectMo.unSelectItems
	elseif self._dropIndex == DropIndex.Supplies then
		for i, v in ipairs(self.selectMo.unSelectItems) do
			if v.serverMo.itemCo.type == SodacheEnum.CardType.Supplies then
				table.insert(itemList, v)
			end
		end
	elseif self._dropIndex == DropIndex.Offering then
		for i, v in ipairs(self.selectMo.unSelectItems) do
			if v.serverMo.itemCo.type == SodacheEnum.CardType.Offering then
				table.insert(itemList, v)
			end
		end
	end

	local len = #itemList

	gohelper.setActive(self._goleftempty, len == 0)
	gohelper.setActive(self._goleftscroll, len > 0)

	if len > 0 then
		self._simpleListLeft:setList(itemList)
	end
end

function SodacheTakeView:_refreshRightItems()
	local len = #self.selectMo.selectItems

	if len > 0 then
		self._simpleListRight:setList(self.selectMo.selectItems)
	end

	gohelper.setActive(self._gorightscroll, len > 0)
	gohelper.setActive(self._gorightempty, len == 0)

	self._txtnum.text = self.selectMo.isUseCost and string.format("%d/%d", self.selectMo.selectCost, self.selectMo.selectTotalCost) or string.format("%d/%d", self.selectMo.selectCount, self.selectMo.selectTotalCount)

	local totalCoin = 0

	for i, v in ipairs(self.selectMo.selectItems) do
		totalCoin = totalCoin + v.serverMo.count * v.serverMo.itemCo.price
	end

	if self._totalCoin and totalCoin > self._totalCoin then
		gohelper.setActive(self._goeffect, false)
		gohelper.setActive(self._goeffect, true)
	end

	self._totalCoin = totalCoin
	self._txtpreview.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("sodache_takeview_preview"), totalCoin)
end

function SodacheTakeView:onQuickHandle()
	self.selectMo:fastSelectItems()
	self:_refreshItems()
end

function SodacheTakeView:onRecvMsg(cmd, resultCode, msg)
	if resultCode == 0 then
		TaskDispatcher.runDelay(self.closeThis, self, 0)
	end
end

function SodacheTakeView:onDestroyView()
	if self.dropExtend then
		self.dropExtend:dispose()

		self.dropExtend = nil
	end
end

return SodacheTakeView
