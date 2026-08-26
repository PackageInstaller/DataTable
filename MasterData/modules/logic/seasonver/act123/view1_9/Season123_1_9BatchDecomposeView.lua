-- chunkname: @modules/logic/seasonver/act123/view1_9/Season123_1_9BatchDecomposeView.lua

module("modules.logic.seasonver.act123.view1_9.Season123_1_9BatchDecomposeView", package.seeall)

local Season123_1_9BatchDecomposeView = class("Season123_1_9BatchDecomposeView", BaseView)

function Season123_1_9BatchDecomposeView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goequipsort = gohelper.findChild(self.viewGO, "left_container/#go_equipsort")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_equipsort/#btn_rarerank")
	self._gorareRankSelect = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankSelect")
	self._gorareRankNormal = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_rarerank/#go_rareRankNormal")
	self._btnfilter = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_equipsort/#btn_filter")
	self._gonotfilter = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_filter/#go_notfilter")
	self._gofilter = gohelper.findChild(self.viewGO, "left_container/#go_equipsort/#btn_filter/#go_filter")
	self._gocost = gohelper.findChild(self.viewGO, "left_container/#go_cost")
	self._btnfastadd = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_cost/fast/#btn_fastadd")
	self._txtnum = gohelper.findChildText(self.viewGO, "left_container/#go_cost/txt_selected/#txt_num")
	self._txtmaxNum = gohelper.findChildText(self.viewGO, "left_container/#go_cost/txt_selected/#txt_num/#txt_maxNum")
	self._goscrollcontainer = gohelper.findChild(self.viewGO, "left_container/#go_scrollcontainer")
	self._scrollequip = gohelper.findChildScrollRect(self.viewGO, "left_container/#go_scrollcontainer/#scroll_equip")
	self._goempty = gohelper.findChild(self.viewGO, "left_container/#go_empty")
	self._goclear = gohelper.findChild(self.viewGO, "left_container/#go_clear")
	self._btnclear = gohelper.findChildButtonWithAudio(self.viewGO, "left_container/#go_clear/#btn_clear")
	self._gocoinItem = gohelper.findChild(self.viewGO, "right_container/#go_coinItem")
	self._txtcoinName = gohelper.findChildText(self.viewGO, "right_container/#txt_coinName")
	self._txtcount = gohelper.findChildText(self.viewGO, "right_container/#txt_count")
	self._btndecompose = gohelper.findChildButtonWithAudio(self.viewGO, "right_container/#btn_decompose")
	self._golefttopbtns = gohelper.findChild(self.viewGO, "#go_lefttopbtns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._countAnim = gohelper.findChild(self.viewGO, "right_container/vx_count/ani"):GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_9BatchDecomposeView:addEvents()
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnfilter:AddClickListener(self._btnfilterOnClick, self)
	self._btnfastadd:AddClickListener(self._btnfastaddOnClick, self)
	self._btnclear:AddClickListener(self._btnclearOnClick, self)
	self._btndecompose:AddClickListener(self._btndecomposeOnClick, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, self.resetDataUI, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, self.onDecomposeItemClick, self)
	self.addEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
end

function Season123_1_9BatchDecomposeView:removeEvents()
	self._btnrarerank:RemoveClickListener()
	self._btnfilter:RemoveClickListener()
	self._btnfastadd:RemoveClickListener()
	self._btnclear:RemoveClickListener()
	self._btndecompose:RemoveClickListener()
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnResetBatchDecomposeView, self.resetDataUI, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnDecomposeItemSelect, self.onDecomposeItemClick, self)
	self.removeEventCb(self, Season123EquipBookController.instance, Season123Event.OnItemChange, self.refreshUI, self)
end

Season123_1_9BatchDecomposeView.maxOverCount = 4

function Season123_1_9BatchDecomposeView:_btnrarerankOnClick()
	self.isRareAscend = not self.isRareAscend

	Season123DecomposeModel.instance:setRareAscendState(self.isRareAscend)
	transformhelper.setLocalScale(self.rareArrowTrans, 1, self.isRareAscend and 1 or -1, 1)
	Season123DecomposeModel.instance:sortDecomposeItemListByRare()
end

function Season123_1_9BatchDecomposeView:_btnfilterOnClick()
	ViewMgr.instance:openView(ViewName.Season123_1_9DecomposeFilterView)
end

function Season123_1_9BatchDecomposeView:_btnfastaddOnClick()
	Season123DecomposeModel.instance:selectOverPartItem()

	local selectCount = Season123DecomposeModel.instance.curSelectItemCount

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
	self:refreshUI()

	if selectCount == 0 then
		GameFacade.showToast(ToastEnum.SeasonNotConformCardTip)

		return
	end
end

function Season123_1_9BatchDecomposeView:_btnclearOnClick()
	Season123EquipBookController.instance:clearItemSelectState()
	self:resetDataUI()
end

function Season123_1_9BatchDecomposeView:_btndecomposeOnClick()
	local selectItemCount = Season123DecomposeModel.instance.curSelectItemCount

	if selectItemCount == 0 then
		return
	end

	local curSelectItemDict = Season123DecomposeModel.instance.curSelectItemDict
	local isItemUsedByHero = Season123DecomposeModel.instance:isDecomposeItemUsedByHero(curSelectItemDict)

	if isItemUsedByHero then
		GameFacade.showMessageBox(MessageBoxIdDefine.SeasonComposeMatIsEquiped, MsgBoxEnum.BoxType.Yes_No, self.showDecomposeTip, nil, nil, self)
	else
		self:showDecomposeTip()
	end
end

function Season123_1_9BatchDecomposeView:showDecomposeTip()
	local selectItemTab = Season123DecomposeModel.instance.curSelectItemDict
	local selectCount = GameUtil.getTabLen(selectItemTab)
	local coinConfig = CurrencyConfig.instance:getCurrencyCo(self.coinId)
	local totalCount = 0

	for id, itemMO in pairs(selectItemTab) do
		local config = Season123Config.instance:getSeasonEquipCo(itemMO.itemId)

		totalCount = totalCount + config.decomposeGet
	end

	local selectCountStr = string.format("<color=#AB5220>%s</color>", selectCount)
	local getCoinStr = string.format("<color=#AB5220>%s%s</color>", totalCount, coinConfig.name)

	GameFacade.showMessageBox(MessageBoxIdDefine.Season123DecomposeTip, MsgBoxEnum.BoxType.Yes_No, self.decomposeYesCallBack, nil, nil, self, nil, nil, selectCountStr, getCoinStr)
end

function Season123_1_9BatchDecomposeView:decomposeYesCallBack()
	local selectDecomposeList = Season123DecomposeModel.instance.curSelectItemDict

	self.selectlist = {}

	for id, itemMO in pairs(selectDecomposeList) do
		table.insert(self.selectlist, itemMO.uid)
	end

	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnBatchDecomposeEffectPlay)
	UIBlockMgr.instance:startBlock("playBatchDecomposeEffect")
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_molu_button_display)
	TaskDispatcher.runDelay(self.sendDecomposeRequest, self, 1)
end

function Season123_1_9BatchDecomposeView:sendDecomposeRequest()
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")
	Activity123Rpc.instance:sendDecomposeAct123EquipRequest(self.actId, self.selectlist)
end

function Season123_1_9BatchDecomposeView:_dropFilterOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function Season123_1_9BatchDecomposeView:_editableInitView()
	self.rareArrowTrans = gohelper.findChild(self._gorareRankNormal, "txt/arrow"):GetComponent(gohelper.Type_Transform)
	self.isRareAscend = false

	Season123DecomposeModel.instance:setRareAscendState(self.isRareAscend)
	transformhelper.setLocalScale(self.rareArrowTrans, 1, self.isRareAscend and 1 or -1, 1)
	self:initDropFilter()
end

function Season123_1_9BatchDecomposeView:onOpen()
	self.actId = self.viewParam.actId
	self.coinId = Season123Config.instance:getEquipItemCoin(self.actId, Activity123Enum.Const.EquipItemCoin)

	self:refreshUI()
end

function Season123_1_9BatchDecomposeView:initDropFilter()
	self._dropFilter = gohelper.findChildDropdown(self.viewGO, "left_container/#go_cost/#drop_filter")
	self._txtLabel = gohelper.findChildText(self._dropFilter.gameObject, "Label")
	self._imageArrow = gohelper.findChildImage(self._dropFilter.gameObject, "Arrow")
	self._arrowTrans = self._imageArrow:GetComponent(gohelper.Type_Transform)

	self._dropFilter:AddOnValueChanged(self.dropFilterValueChanged, self)

	self._clickDropFilter = gohelper.getClick(self._dropFilter.gameObject)

	self._clickDropFilter:AddClickListener(self._dropFilterOnClick, self)

	self.dropFilterItemTab = {}
	self.dropFilterLabelList = {}

	local allLabel = luaLang("common_all")

	self.dropFilterItemTab[0] = allLabel

	table.insert(self.dropFilterLabelList, allLabel)

	for i = 1, Season123_1_9BatchDecomposeView.maxOverCount do
		table.insert(self.dropFilterLabelList, string.format(luaLang("Season123DecomposeOverPart"), i))

		self.dropFilterItemTab[i] = string.format(luaLang("Season123DecomposeOverPart"), i)
	end

	self._dropFilter:ClearOptions()
	self._dropFilter:AddOptions(self.dropFilterLabelList)
	self._dropFilter:SetValue(1)

	self.dropShowHide = DropDownExtend.Get(self._dropFilter.gameObject)

	self.dropShowHide:init(self.onDropListShow, self.onDropListHide, self)
end

function Season123_1_9BatchDecomposeView:refreshUI()
	local coinConfig = CurrencyConfig.instance:getCurrencyCo(self.coinId)

	self._txtcoinName.text = coinConfig.name

	self:initCoinItem()

	self._txtcount.text = luaLang("multiple") .. self:getDecomposeCoin()

	local selectItemCount = Season123DecomposeModel.instance.curSelectItemCount

	ZProj.UGUIHelper.SetGrayscale(self._btndecompose.gameObject, selectItemCount == 0)

	self._txtmaxNum = string.format("/%s", Activity123Enum.maxDecomposeCount)
	self._txtnum.text = selectItemCount >= Activity123Enum.maxDecomposeCount and string.format("<color=#ff7933>%s</color>", selectItemCount) or selectItemCount

	gohelper.setActive(self._goclear, selectItemCount > 0)

	local hasSelectFilterItem = Season123DecomposeModel.instance:hasSelectFilterItem()

	gohelper.setActive(self._gofilter, hasSelectFilterItem)
	gohelper.setActive(self._gonotfilter, not hasSelectFilterItem)
	gohelper.setActive(self._goempty, Season123DecomposeModel.instance:getCount() == 0)
end

function Season123_1_9BatchDecomposeView:initCoinItem()
	if not self.cointItem then
		self.coinItem = IconMgr.instance:getCommonPropItemIcon(self._gocoinItem)

		self.coinItem:setMOValue(MaterialEnum.MaterialType.Currency, self.coinId, 1, nil, true)
		self.coinItem:isShowEquipAndItemCount(false)
		self.coinItem:setShowCountFlag(false)
		self.coinItem:hideEquipLvAndBreak(true)
		self.coinItem:setHideLvAndBreakFlag(true)
	end
end

function Season123_1_9BatchDecomposeView:onDecomposeItemClick()
	self._countAnim:Play("vx_count", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Season123.play_ui_checkpoint_light_up)
	self:refreshUI()
end

function Season123_1_9BatchDecomposeView:resetDataUI()
	self._txtcount.text = luaLang("multiple") .. 0
	self._txtnum.text = 0

	ZProj.UGUIHelper.SetGrayscale(self._btndecompose.gameObject, true)
	gohelper.setActive(self._goclear, false)
end

function Season123_1_9BatchDecomposeView:getDecomposeCoin()
	local curSelectItems = Season123DecomposeModel.instance.curSelectItemDict
	local totalCoin = 0

	for itemUid, itemMO in pairs(curSelectItems) do
		local config = Season123Config.instance:getSeasonEquipCo(itemMO.itemId)

		if config ~= nil then
			totalCoin = totalCoin + config.decomposeGet
		end
	end

	return totalCoin
end

function Season123_1_9BatchDecomposeView:dropFilterValueChanged(index)
	Season123DecomposeModel.instance:setCurOverPartSelectIndex(index)
end

function Season123_1_9BatchDecomposeView:onDropListShow()
	transformhelper.setLocalScale(self._arrowTrans, 1, -1, 1)
end

function Season123_1_9BatchDecomposeView:onDropListHide()
	transformhelper.setLocalScale(self._arrowTrans, 1, 1, 1)
end

function Season123_1_9BatchDecomposeView:onClose()
	Season123DecomposeModel.instance._itemStartAnimTime = nil
end

function Season123_1_9BatchDecomposeView:onDestroyView()
	Season123DecomposeModel.instance:clear()
	UIBlockMgr.instance:endBlock("playBatchDecomposeEffect")

	if self._dropFilter then
		self._dropFilter:RemoveOnValueChanged()

		self._dropFilter = nil
	end

	if self._clickDropFilter then
		self._clickDropFilter:RemoveClickListener()

		self._clickDropFilter = nil
	end
end

return Season123_1_9BatchDecomposeView
