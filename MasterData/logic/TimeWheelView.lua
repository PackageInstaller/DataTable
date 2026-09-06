-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timewheel/view/TimeWheelView.lua

module("logic.extensions.timewheel.view.TimeWheelView", package.seeall)

local TimeWheelView = class("TimeWheelView", ViewComponent)

function TimeWheelView:ctor()
	TimeWheelView.super.ctor(self)
end

function TimeWheelView:buildUI()
	TimeWheelView.super.buildUI(self)

	local effectlinjian1_1 = self:getGo("bg/time/linjian1_1")

	GoUtil.SetSortingOrder(effectlinjian1_1, 199)

	self._closeButton = self:getBtn("btnClose")
	self._btnHelp = self:getBtn("btnHelp")
	self._btnWhiteList = self:getBtn("btnWhiteList")
	self._tabSpriteChanges = {}
	self._tabBtns = {}
	self._tabPages = {}

	for i = 1, 4 do
		self._tabSpriteChanges[i] = self:getGo("tab/tab" .. i):GetComponent("UIChangeGroup")
		self._tabBtns[i] = self:getBtn("tab/tab" .. i)
		self._tabPages[i] = self:getGo("page" .. i)
	end

	self._eightSelectGo = self:getGo("selectedArea/eightSelect")
	self._oneSelectGo = self:getGo("selectedArea/oneSelect")
	self._txtTip = self:getGo("bgTip/txtTip"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("selectedArea/oneSelect/img/txtDesc"):GetComponent(goutil.Type_UIText)
	self._diamondGo = self:getGo("diamond")
	self._costNum = self:getGo("diamond/costNum"):GetComponent(goutil.Type_UIText)
	self._btnTujianDecompose = self:getBtn("page1/btnTujianDecompose")
	self._imgTuJianSelect = self:getGo("page1/btnTujianDecompose/imgSelect")
	self._btnDpChuDai = self:getGo("page1/btnDpChuDai")
	self._btnDpHuanShou = self:getGo("page1/btnDpHuanShou")
	self._btnDpChaoNeng = self:getGo("page1/btnDpChaoNeng")
	self._imgDpChaoNengSelect = self:getGo("page1/btnDpChaoNeng/imgSelect")
	self._imgDpChuDaiSelect = self:getGo("page1/btnDpChuDai/imgSelect")
	self._imgDpHuanShouSelect = self:getGo("page1/btnDpHuanShou/imgSelect")
	self._tableview = self:getGo("bottom/petList"):GetComponent("UITableview")
	self._tableCell = self:getGo("bottom/petList/item")

	self._tableCell:SetActive(false)

	self._itemCell = self:getGo("selectedArea/item")

	goutil.setActive(self._itemCell, false)

	self._contentEightSelect = goutil.findChild(self._eightSelectGo, "viewport/content")
	self._itemSelectGos = {}

	for i = 1, TimeWheelStateModel.MaxDecomposeNum do
		local go = goutil.cloneAndSetParent(self._itemCell, self._contentEightSelect.transform, "item" .. i)

		goutil.setActive(go, true)

		local itemSelect = {}

		itemSelect._node = goutil.findChild(go, "node")
		itemSelect._btn = Framework.ButtonAdapter.GetFrom(go, "btn")
		self._itemSelectGos[i] = itemSelect
	end

	self._oneSelectNode = self:getGo("selectedArea/oneSelect/nodeParent/node")
	self._oneSelectBtn = self:getBtn("selectedArea/oneSelect/btn")
	self._tableviewPreview = self:getGo("selectedArea/itemList"):GetComponent("UITableview")
	self._tableCellPreview = self:getGo("selectedArea/itemList/item")

	self._tableCellPreview:SetActive(false)

	self._btnOneChoose = self:getBtn("page1/btnOneChoose")
	self._btnDecompose = self:getBtn("page1/btnDecompose")
	self._btnReset = self:getBtn("page2/btnReset")
	self._btnRevert = self:getBtn("page3/btnRevert")
	self._uiCustomInputTip = UICustomInput.Get(self:getGo("bgTip/btnTip"))
	self._tip = self:getGo("tip")
	self._txtTipContent = self:getGo("tip/Text"):GetComponent(goutil.Type_UIText)
	self._btnFilter = self:getBtn("bottom/btnFilter")
	self._shizhen = self:getGo("bg/time/shizhen"):GetComponent(goutil.Type_RectTransform)
	self._fenzhen = self:getGo("bg/time/fenzhen"):GetComponent(goutil.Type_RectTransform)
	self._effectParent = self:getGo("effect")
	self._mask = self:getGo("mask")
	self._selectBg = self:getGo("selectedArea/eightSelect/bg")
	self._selectBg2 = self:getGo("selectedArea/oneSelect/bg")
	self._selectTxtDesc = self:getGo("selectedArea/oneSelect/img")
	self._targetPos = self:getGo("selectedArea/targetPos")
	self._eightScroll = self:getScrollRect("selectedArea/eightSelect")
	self._eightContent = self:getGo("selectedArea/eightSelect/")
	self._noPetTip = self:getGo("bottom/noPetTip")
	self._txtNoPetTip = self:getGo("bottom/noPetTip/Text"):GetComponent(goutil.Type_UIText)
	self._tabRedPoint = self:getGo("tab/tab1/redPoint")
	self._btnRedPoint = self:getGo("page1/btnDecompose/redPoint")
	self._btnStore_add = self:getBtn("page1/btnStore")
	self._tabRedPoint4 = self:getGo("tab/tab4/redPoint")
	self._spriteMask = self:getGo("bg/time/linjian1_1/fx_ui_chilun_mask_sjzl/mask"):GetComponent("SpriteMask")

	local canvas = UGUIToolHelper.FindCanvas(self.mainGO)

	self._spriteMask.isCustomRangeActive = true
	self._spriteMask.frontSortingOrder = canvas.sortingOrder + 1
	self._spriteMask.backSortingOrder = canvas.sortingOrder
	self._goldBarCon = self:getGo("goldBarCon")
	self._txtResetCount = self:getTxt("page2/resetCount/txtCount")
	self._txtResetGo = self:getGo("page2/btnReset/txtReset")
	self._txtCd = self:getTxt("page2/btnReset/txtCd")
	self._bottomGo = self:getGo("bottom")
	self._bgTipGo = self:getGo("bgTip")
	self._btnSelect = self:getBtn("page4/btnSelect")
	self._btnSure = self:getBtn("page4/btnSure")
	self._btnOneChooseOverflow = self:getBtn("page4/btnOneChoose")
	self._btnStore = self:getBtn("page4/btnStore")
	self._overflowIcon = self:getGo("page4/item")
	self._overflowEffectParent = self:getGo("page4/effect")
	self._btnTujianOverflow = self:getBtn("page4/btnTujianOverflow")
	self._imgTuJianSelect4 = self:getGo("page4/btnTujianOverflow/imgSelect")
	self._timeBg1 = self:getGo("bg/time")
	self._timeBg2 = self:getGo("bg/time2")
end

function TimeWheelView:destroyUI()
	TimeWheelView.super.destroyUI(self)
end

function TimeWheelView:bindEvents()
	TimeWheelView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnHelp:AddClickListener(self._onClickHelp, self)
	self._btnWhiteList:AddClickListener(self._onClickWhiteList, self)
	self._btnOneChoose:AddClickListener(self._onClickOneChoose, self)
	self._btnDecompose:AddClickListener(self._onClickDecompose, self)
	self._btnTujianDecompose:AddClickListener(self._onClickTujianDecompose, self)
	self._btnTujianOverflow:AddClickListener(self._onClickTujianOverflow, self)
	self._btnReset:AddClickListener(self._onClickReset, self)
	self._btnRevert:AddClickListener(self._onClickRevert, self)
	self._uiCustomInputTip:AddListener(self._onClickTip, self)
	self._btnFilter:AddClickListener(self._onClickFilter, self)
	self._btnSelect:AddClickListener(self._onClickSelect, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
	self._btnOneChooseOverflow:AddClickListener(self._onClickOneChoose, self)
	self._btnStore:AddClickListener(self._onClickStore, self)
	self._btnStore_add:AddClickListener(self._onClickStore, self)
	GameUtil.addClickHandler(self._btnDpChuDai, GameUtil.handler(self._onClickAutoDecompose, self, GameEnum.PetRare.N))
	GameUtil.addClickHandler(self._btnDpHuanShou, GameUtil.handler(self._onClickAutoDecompose, self, GameEnum.PetRare.R))
	GameUtil.addClickHandler(self._btnDpChaoNeng, GameUtil.handler(self._onClickAutoDecompose, self, GameEnum.PetRare.SR))

	for i = 1, 4 do
		self._tabBtns[i]:AddClickListener(self["_onClickTab" .. i], self)
	end

	for i = 1, TimeWheelStateModel.MaxDecomposeNum do
		local function func()
			local index = i
			local petId = TimeWheelStateModel.instance:isPetSelectedExist(index)

			if petId then
				TimeWheelStateModel.instance:removePet(petId)
				self._tableview:Refresh()
				self:_refreshSelectedArea()
			end
		end

		self._itemSelectGos[i]._btn:AddClickListener(func)
	end

	local function oneSelectFunc()
		local isExist = TimeWheelStateModel.instance:isExistSelectedPets()

		if isExist then
			TimeWheelStateModel.instance:clearSelectedPet()
			self._tableview:Refresh()
			self:_refreshSelectedArea()
		end
	end

	self._oneSelectBtn:AddClickListener(oneSelectFunc)
end

function TimeWheelView:unbindEvents()
	TimeWheelView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnHelp:RemoveClickListener()
	self._btnWhiteList:RemoveClickListener()
	self._btnOneChoose:RemoveClickListener()
	self._btnDecompose:RemoveClickListener()
	self._btnTujianDecompose:RemoveClickListener()
	self._btnTujianOverflow:RemoveClickListener()
	self._btnReset:RemoveClickListener()
	self._btnRevert:RemoveClickListener()
	self._uiCustomInputTip:RemoveListener()
	self._btnFilter:RemoveClickListener()
	self._btnSelect:RemoveClickListener()
	self._btnSure:RemoveClickListener()
	self._btnOneChooseOverflow:RemoveClickListener()
	self._btnStore:RemoveClickListener()
	self._btnStore_add:RemoveClickListener()

	for i = 1, 4 do
		self._tabBtns[i]:RemoveClickListener()
	end

	for i = 1, TimeWheelStateModel.MaxDecomposeNum do
		self._itemSelectGos[i]._btn:RemoveClickListener()
	end

	self._oneSelectBtn:RemoveClickListener()
end

function TimeWheelView:onEnter()
	TimeWheelView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelGetDecomposeWhenLottery, self._setAutoDecomposeState, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelSetDecomposeWhenLottery, self._setAutoDecomposeState, self)
	GlobalDispatcher:addListener(GlobalNotify.RefreshSelectedArea, self._refreshSelectedArea, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelDecompose, self._onDecomposeRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelReset, self._onResetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelRevert, self._onRevertRes, self)
	GlobalDispatcher:addListener(GlobalNotify.CancelPetSelected, self._onCancelPetSelected, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelResetCount, self._onTimeWheelResetCount, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_DecomposeOverFlowPetRes, self._onDecomposeOverFlowPetRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_DecomposeOverFlowItemRes, self._onDecomposeOverFlowItemRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PM_DecomposeOverFlowPetBatchRes, self._onDecomposeOverFlowPetBatchRes, self)
	GlobalDispatcher:addListener(GlobalNotify.TimeWheelViewRefreshPetlist, self._onRefreshPetList, self)
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)
	self._tableviewPreview:RegisterCallback(self._numInViewPreview, self._cellSizePreview, self._cellAtIndexPreview, self)

	local initTab = self:getFirstParam()

	self:_startAnim()
	self:_setMask(false)
	TimeWheelStateModel.instance:init()

	if initTab then
		initTab = checknumber(initTab)

		if initTab == 1 then
			self:_onClickTab1()
		elseif initTab == 2 then
			self:_onClickTab2()
		else
			self:_onClickTab3()
		end
	else
		self:_onClickTab2()
	end

	self:_refreshRedPoint()
	self:_createFilterList()

	local objList = {
		{
			showAdd = true,
			id = GameEnum.GoldType.PixieDust
		},
		{
			showAdd = true,
			id = GameEnum.GoldType.Diamond
		},
		{
			showAdd = false,
			id = GameEnum.GoldType.TimeWheelOverflow
		}
	}

	MainUIController.instance:showGlodBar(self._goldBarCon, self._viewPresentor, objList)
	TimeWheelAgent.instance:sendPM_TimeWheelGetResetStrengthenInfoReq()
	settimer(1, self._updateCdTxt, self)
	self:_resetOverflow()
	self:_playOverflowBgEffect()
	self:_updateOverflowRedPoint()
	self:_updateTujianDecomposeState()
	self:_updateTujianOverflowState()
end

function TimeWheelView:onExit()
	TimeWheelView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelGetDecomposeWhenLottery, self._setAutoDecomposeState, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelSetDecomposeWhenLottery, self._setAutoDecomposeState, self)
	GlobalDispatcher:removeListener(GlobalNotify.RefreshSelectedArea, self._refreshSelectedArea, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelDecompose, self._onDecomposeRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelReset, self._onResetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelRevert, self._onRevertRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.CancelPetSelected, self._onCancelPetSelected, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelResetCount, self._onTimeWheelResetCount, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_DecomposeOverFlowPetRes, self._onDecomposeOverFlowPetRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_DecomposeOverFlowItemRes, self._onDecomposeOverFlowItemRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_DecomposeOverFlowPetBatchRes, self._onDecomposeOverFlowPetBatchRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.TimeWheelViewRefreshPetlist, self._onRefreshPetList, self)
	TimeWheelStateModel.instance:reset()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
	self._tableviewPreview:Travel(self._clearTableviewPreview, self)

	self._curViewDatasPreview = {}

	self._tableviewPreview:UnRegisterAllCallbacks()
	self:_endAnim()
	self:_removeSelectEffect()
	self:_removeBaokaiEffect()
	self:_removeOverflowBgEffect()
	self:_removeOverflowBoomEffect()
	self:_setMask(false)
	self:_stopNodePosAnim()
	removetimer(self._updateCdTxt, self)
	self:_resetOverflow()
end

function TimeWheelView:_onClickClose()
	self:close()
end

function TimeWheelView:_onClickHelp()
	UIStateManager.instance:push(ViewName.RulesView, "wheelOfTime_rule")
end

function TimeWheelView:_onClickWhiteList()
	UIStateManager.instance:push(ViewName.TimeWheelWhiteListView)
end

function TimeWheelView:_onClickTab1()
	self:_changeTab(1)
end

function TimeWheelView:_onClickTab2()
	self:_changeTab(2)
end

function TimeWheelView:_onClickTab3()
	self:_changeTab(3)
end

function TimeWheelView:_onClickTab4()
	self:_changeTab(4)
	self:_closeOverflowRedPoint()
end

function TimeWheelView:_changeTab(index)
	local curState = TimeWheelStateModel.instance:getCurState()

	if curState == index then
		return
	end

	self:_clearSelectedArea(curState)
	TimeWheelStateModel.instance:setCurState(index)
	self:_resetPetShow()
	self:_resetOverflow()

	for i = 1, 4 do
		self._tabSpriteChanges[i]:SetState(i == index and 1 or 0)
		self._tabPages[i]:SetActive(i == index)
	end

	local isShowEight = index == TimeWheelStateModel.EnumType.Decompose or index == TimeWheelStateModel.EnumType.Overflow

	self._eightSelectGo:SetActive(isShowEight)
	self._oneSelectGo:SetActive(not isShowEight)
	self._tableviewPreview.gameObject:SetActive(true)
	self:_setRewardListPos(index)
	self._diamondGo:SetActive(not isShowEight)
	self:_setDiamondGoPos(index)

	self._costNum.text = TimeWheelStateModel.instance:getCostDiamondPrice()

	self:_setTxtTip()

	self._txtDesc.text = TimeWheelStateModel.instance:getTxtDesc()
	self._txtTipContent.text = TimeWheelStateModel.instance:getTxtTipContent()

	self._tip:SetActive(false)

	if index == TimeWheelStateModel.EnumType.Decompose then
		if TimeWheelModel.instance:isHaveRecieveFirst() then
			self:_setAutoDecomposeState()
		else
			TimeWheelAgent.instance:sendPM_TimeWheelGetDecomposeWhenLotteryReq()
		end
	end

	self._bottomGo:SetActive(true)
	self:_setBg(index)
	goutil.setActive(self._btnFilter.gameObject, true)
end

function TimeWheelView:_setTxtTip()
	if TimeWheelStateModel.instance:getCurState() == TimeWheelStateModel.EnumType.Overflow and self._curSelectId ~= nil then
		if self._isCurSelectPet then
			local bagPetMo = BagModel.instance:getPet(self._curSelectId)

			self._txtTip.text = bagPetMo and bagPetMo:checkHasDestroyStarGodPlus() and lang("timewheel_tip1") or lang("timewheel_tip2")
		else
			self._txtTip.text = lang("timewheel_tip2")
		end
	else
		self._txtTip.text = TimeWheelStateModel.instance:getSelectedTip()
	end
end

function TimeWheelView:_setBg(index)
	if index == TimeWheelStateModel.EnumType.Overflow then
		self._timeBg1:SetActive(false)
		self._timeBg2:SetActive(true)
	else
		self._timeBg1:SetActive(true)
		self._timeBg2:SetActive(false)
	end
end

function TimeWheelView:_adjustEightRectContent()
	local contentGo = self._eightScroll.scrollRect.content
	local laoutComponent = contentGo:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	local size = laoutComponent.cellSize
	local space = laoutComponent.spacing
	local count = laoutComponent.constraintCount
	local cellNum = #TimeWheelStateModel.instance:getSelectedPets()
	local rectSizeWidth = GameUtil.getWidth(contentGo)
	local rectSizeHeight = (size.y + space.y) * math.ceil(cellNum / count)

	GameUtil.setWidth(contentGo, rectSizeWidth)
	GameUtil.setHeight(contentGo, rectSizeHeight)

	self._eightScroll.scrollRect.verticalNormalizedPosition = 0
end

function TimeWheelView:_setRewardListPos(tabIndex)
	if tabIndex == TimeWheelStateModel.EnumType.Decompose or tabIndex == TimeWheelStateModel.EnumType.Overflow then
		self._tableviewPreview.transform.localPosition = Vector3.New(-148, -150, 0)
		self._tableviewPreview:GetComponent("RectTransform").sizeDelta = Vector2.New(300, 114)
	else
		self._tableviewPreview:GetComponent("RectTransform").sizeDelta = Vector2.New(432, 114)
		self._tableviewPreview.transform.localPosition = Vector3.New(-220, -24, 0)
	end
end

function TimeWheelView:_setAutoDecomposeState()
	self._autoDecomposeMap = TimeWheelModel.instance:getAutoDecomposeMap()

	GameUtil.SetActive(self._imgDpChuDaiSelect, self._autoDecomposeMap[GameEnum.PetRare.N])
	GameUtil.SetActive(self._imgDpHuanShouSelect, self._autoDecomposeMap[GameEnum.PetRare.R])
	GameUtil.SetActive(self._imgDpChaoNengSelect, self._autoDecomposeMap[GameEnum.PetRare.SR])
end

function TimeWheelView:_onClickOneChoose()
	TimeWheelStateModel.instance:oneSelectAllPet()
	self:_refreshSelectedArea()
	self._tableview:ReloadData()
end

function TimeWheelView:_onClickAutoDecompose(petRare)
	self._autoDecomposeMap[petRare] = not self._autoDecomposeMap[petRare]

	TimeWheelModel.instance:setAutoDecomposeMap(self._autoDecomposeMap)
	TimeWheelController.instance:sendPM_TimeWheelSetDecomposeWhenLotteryReq(petRare, self._autoDecomposeMap[petRare])
end

function TimeWheelView:_onClickDecompose()
	if not TimeWheelStateModel.instance:isExistSelectedPets() then
		FloatWordMgr.instance:show(TimeWheelStateModel.instance:getNoSelectTip())

		return
	end

	local isExistNotN, txtStr = TimeWheelStateModel.instance:getDecomposeTipTxt()

	if isExistNotN then
		TipsFacade.instance:openPopupWindow(lang("tip"), txtStr, function()
			local petIds = TimeWheelStateModel.instance:getSelectedPets()

			TimeWheelAgent.instance:sendPM_TimeWheelDecomposeReq(petIds)
		end, nil, lang("confirm"), "取消")
	else
		local petIds = TimeWheelStateModel.instance:getSelectedPets()

		for k, petId in pairs(petIds) do
			BagPetsController.instance:setPetIsTop(petId, false)
		end

		TimeWheelAgent.instance:sendPM_TimeWheelDecomposeReq(petIds)
	end
end

function TimeWheelView:_onClickReset()
	if not TimeWheelStateModel.instance:isExistSelectedPets() then
		FloatWordMgr.instance:show(TimeWheelStateModel.instance:getNoSelectTip())

		return
	end

	if TimeWheelModel.instance:getLeftResetCount() <= 0 then
		FloatWordMgr.instance:show("今日已经没有重置次数了哦")

		return
	end

	if TimeWheelModel.instance:isCdAvailable() and ServerTime.now() - TimeWheelModel.instance:getEndTimestampOnResetCD() <= 0 then
		FloatWordMgr.instance:show("您进行精灵重置太频繁了，请稍候再来")

		return
	end

	local num = TimeWheelStateModel.instance:getCostDiamondPrice()
	local text = string.format("确定消耗%s钻石对精灵进行重置么？", num)

	TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
		local isEnough = TimeWheelStateModel.instance:isDiamondEnough()

		if not isEnough then
			FloatWordMgr.instance:show("钻石不足")

			return
		end

		local petIds = TimeWheelStateModel.instance:getSelectedPets()

		TimeWheelAgent.instance:sendPM_TimeWheelResetReq(petIds[1])
	end, nil, lang("confirm"), "取消")
end

function TimeWheelView:_onClickRevert()
	if not TimeWheelStateModel.instance:isExistSelectedPets() then
		FloatWordMgr.instance:show(TimeWheelStateModel.instance:getNoSelectTip())

		return
	end

	local num = TimeWheelStateModel.instance:getCostDiamondPrice()
	local text = string.format("确定消耗%s钻石对精灵进行倒退么？", num)

	TipsFacade.instance:openPopupWindow(lang("tip"), text, function()
		local isEnough = TimeWheelStateModel.instance:isDiamondEnough()

		if not isEnough then
			FloatWordMgr.instance:show("钻石不足")

			return
		end

		local petIds = TimeWheelStateModel.instance:getSelectedPets()

		TimeWheelAgent.instance:sendPM_TimeWheelRevertReq(petIds[1])
	end, nil, "确定", "取消")
end

function TimeWheelView:_onClickTip(hover)
	if hover then
		if not self._tip.activeSelf then
			self._tip:SetActive(true)
		else
			self._tip:SetActive(false)
		end
	elseif self._tip.activeSelf then
		self._tip:SetActive(false)
	end
end

function TimeWheelView:_numInView()
	return #self._curViewDatas
end

function TimeWheelView:_cellSize(view, idx)
	return 100, 100
end

function TimeWheelView:_cellAtIndex(view, index)
	local data = self._curViewDatas[index + 1]
	local curState = TimeWheelStateModel.instance:getCurState()
	local tag = 0

	if curState == TimeWheelStateModel.EnumType.Overflow then
		tag = 1
	end

	local cell = self._tableview:DequeueCellByTag(tag)

	cell = cell or tag == 0 and view:AddChild(self._tableCell, 0) or view:AddChild(self._tableCell, 1)

	if tag == 0 then
		local component = GameUtil.AddLuaOnce(cell.gameObject, TimeWheelPetItem)

		component:init(data)
	else
		local component = GameUtil.AddLuaOnce(cell.gameObject, TimeWheelOverflowItem)

		component:init(data)
	end

	return cell
end

function TimeWheelView:_clearTableview(cell)
	local component = GameUtil.GetLua(cell.gameObject, TimeWheelPetItem)

	if component then
		component:reset()
	end

	local component = GameUtil.GetLua(cell.gameObject, TimeWheelOverflowItem)

	if component then
		component:reset()
	end
end

function TimeWheelView:_onCancelPetSelected(petId)
	for i, v in ipairs(self._curViewDatas) do
		if v:getPetId() == petId then
			self._tableview:UpdateCellAtIndex(i - 1)

			break
		end
	end
end

function TimeWheelView:_refreshSelectedArea()
	local curState = TimeWheelStateModel.instance:getCurState()

	self:_clearSelectedArea(curState)

	if curState == 1 then
		self:_refreshEightArea()
	elseif curState == 2 then
		self:_refreshOneArea()
	elseif curState == 3 then
		self:_refreshOneArea()
	elseif curState == TimeWheelStateModel.EnumType.Overflow then
		self:_refreshEightArea()
	end

	local isExist = TimeWheelStateModel.instance:isExistSelectedPets()

	if isExist then
		self:_playSelectEffect()
		self._selectBg:SetActive(true)
		self._selectBg2:SetActive(true)
		self._selectTxtDesc:SetActive(curState ~= 1)
	else
		self._selectTxtDesc:SetActive(false)
	end

	self:_stopNodePosAnim()
	self:_adjustEightRectContent()
end

function TimeWheelView:_clearSelectedArea(curState)
	if curState == 1 then
		self:_clearEightArea()
		self:_setBtnDecomposeInteractable()
	elseif curState == 2 then
		self:_clearOneArea()
		self:_setBtnResetInteractable()
	elseif curState == 3 then
		self:_clearOneArea()
		self:_setBtnRevertInteractable()
	elseif curState == TimeWheelStateModel.EnumType.Overflow then
		self:_clearEightArea()
		self:_setBtnSureInteractable()
	else
		self:_clearEightArea()
		self:_clearOneArea()
	end

	self:_clearPreviewList()
	self:_stopSelectEffect()
	self._selectBg:SetActive(false)
	self._selectBg2:SetActive(false)
	self._selectTxtDesc:SetActive(false)
end

function TimeWheelView:_refreshEightArea()
	local curState = TimeWheelStateModel.instance:getCurState()
	local petIds = TimeWheelStateModel.instance:getSelectedPets()

	for i, petId in ipairs(petIds) do
		if self._itemSelectGos[i] and self._itemSelectGos[i]._node then
			if curState == TimeWheelStateModel.EnumType.Overflow then
				local item = petId

				if item.matType == TimeWheelStateModel.Pet then
					local proxy = MaterialMgr.setCellByGId(MatType.Pet, item.id, self._itemSelectGos[i]._node)

					if proxy then
						local petMo = BagPetsController.instance:getPet(item.id)

						proxy.binder:showStarByCustom(petMo:getAwakenLv())
					end
				else
					MaterialMgr.setCell(MatType.Item, item.id, self._itemSelectGos[i]._node)
				end
			else
				MaterialMgr.setCellByGId(MatType.Pet, petId, self._itemSelectGos[i]._node)
			end
		end
	end

	self._curViewDatasPreview = {}

	if curState == TimeWheelStateModel.EnumType.Overflow then
		self:_refreshPreviewListOverflow(petIds)
	else
		self:_refreshPreviewList(petIds)
	end

	self._tableviewPreview:ReloadData()
end

function TimeWheelView:_refreshOneArea()
	local petIds = TimeWheelStateModel.instance:getSelectedPets()

	if #petIds > 0 then
		MaterialMgr.setCellByGId(MatType.Pet, petIds[1], self._oneSelectNode)

		self._curViewDatasPreview = {}

		self:_refreshPreviewList({
			petIds[1]
		})
		self._tableviewPreview:ReloadData()
	end
end

function TimeWheelView:_clearEightArea()
	for k, v in pairs(self._itemSelectGos) do
		MaterialMgr.resetAll(v._node)
	end
end

function TimeWheelView:_clearOneArea()
	MaterialMgr.resetAll(self._oneSelectNode)
end

function TimeWheelView:_setBtnDecomposeInteractable()
	self._btnDecompose.btn.interactable = TimeWheelStateModel.instance:isExistSelectedPets()
end

function TimeWheelView:_setBtnResetInteractable()
	if TimeWheelStateModel.instance:getCurState() == TimeWheelStateModel.EnumType.Reset then
		local isCdAvailable = TimeWheelModel.instance:isCdAvailable()
		local isExistSelect = TimeWheelStateModel.instance:isExistSelectedPets()

		self._btnReset.btn.interactable = isExistSelect and not isCdAvailable
	end
end

function TimeWheelView:_setBtnRevertInteractable()
	self._btnRevert.btn.interactable = TimeWheelStateModel.instance:isExistSelectedPets()
end

function TimeWheelView:_setBtnSureInteractable()
	self._btnSure.btn.interactable = TimeWheelStateModel.instance:isExistSelectedPets()
end

function TimeWheelView:_resetPetShow()
	TimeWheelStateModel.instance:clearSelectedPet()

	local curState = TimeWheelStateModel.instance:getCurState()

	self:_clearSelectedArea(curState)

	self._curViewDatas = TimeWheelStateModel.instance:getPetList()

	self._tableview:ReloadData()
	self._noPetTip:SetActive(#self._curViewDatas == 0)

	self._txtNoPetTip.text = TimeWheelStateModel.instance:getNoPetTip()

	self:_createFilterList()
end

function TimeWheelView:_onDecomposeRes()
	self:_playEffectAndDelayPopReward(function()
		TimeWheelController.instance:popReward()
		self:_resetPetShow()
		self:_refreshRedPoint()
	end)
end

function TimeWheelView:_onResetRes()
	self:_playEffectAndDelayPopReward(function()
		local changeSetId = TimeWheelModel.instance:getResetChangeSetId()

		ItemGetController.instance:setTitleType(changeSetId, ItemGetController.TITLE_RETURNMAT)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		self:_resetPetShow()
		self:_setTxtResetCount()
		self:_updateBtnResetState()
		self:_updateCdTxt()
	end)
end

function TimeWheelView:_onRevertRes()
	self:_playEffectAndDelayPopReward(function()
		local changeSetId1, changeSetId2 = TimeWheelModel.instance:getRevertChangeSetId()

		ItemGetController.instance:setTitleType(changeSetId1, ItemGetController.TITLE_REVERT)
		ItemGetController.instance:setTitleType(changeSetId2, ItemGetController.TITLE_RETURNMAT)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId1)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId2)
		self:_resetPetShow()
	end)
end

function TimeWheelView:_onDecomposeOverFlowPetRes(isSuccess)
	if isSuccess then
		self:_playOverflowEffectAndDelayPopReward(function()
			local changeSetId1, changeSetId2 = TimeWheelModel.instance:getOverflowPetChangeSetId()

			ItemGetController.instance:setTitleType(changeSetId1, ItemGetController.TITLE_RETURNMAT)
			ItemGetController.instance:setTitleType(changeSetId2, ItemGetController.TITLE_RETURNMAT)
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId1)
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId2)
			self:_resetOverflow()
		end)
	else
		self:_resetOverflow()
	end
end

function TimeWheelView:_onDecomposeOverFlowItemRes()
	self:_playOverflowEffectAndDelayPopReward(function()
		local changeSetId = TimeWheelModel.instance:getOverflowItemChangeSetId()

		ItemGetController.instance:setTitleType(changeSetId, ItemGetController.TITLE_RETURNMAT)
		MaterialFacade.instance:popAndShowChangeSetItems(changeSetId)
		self:_resetOverflow()
		self:_resetPetShow()
	end)
end

function TimeWheelView:_onDecomposeOverFlowPetBatchRes(isSuccess)
	if isSuccess then
		self:_playEffectAndDelayPopReward(function()
			local changeSetId1, changeSetId2 = TimeWheelModel.instance:getOverflowPetChangeSetId()

			ItemGetController.instance:setTitleType(changeSetId1, ItemGetController.TITLE_RETURNMAT)
			ItemGetController.instance:setTitleType(changeSetId2, ItemGetController.TITLE_RETURNMAT)
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId1)
			MaterialFacade.instance:popAndShowChangeSetItems(changeSetId2)
			self:_resetOverflow()
			self:_resetPetShow()
		end)
	else
		self:_resetOverflow()
		self:_resetPetShow()
	end
end

function TimeWheelView:_onClickFilter()
	local pos, sizeDelta = self:_getPosAndSizeDelta(self._btnFilter.gameObject)

	PetFilterMgr.instance:openFilterViewByType(self, PetFilterMgr.TYPE_TIMEWHEEL, pos, sizeDelta, GameUtil.handler(self._updateFilterData, self))
end

function TimeWheelView:_createFilterList()
	local data = PetFilterMgr.instance:getFilterData(PetFilterMgr.TYPE_TIMEWHEEL)

	PetFilterMgr.instance:resetData(data)

	local selectList = TimeWheelStateModel.instance:getSelectRare()
	local clickableList = TimeWheelStateModel.instance:getClickableRare()

	for i = 1, 4 do
		data.rareSelectList[i] = selectList[i]
		data.rareClickAble[i] = clickableList[i]
	end
end

function TimeWheelView:_getPosAndSizeDelta(go)
	local sizeDelta = {
		0,
		0
	}
	local rect = go:GetComponent("RectTransform")

	sizeDelta = {
		rect.sizeDelta.x,
		rect.sizeDelta.y
	}

	local pos = go.gameObject.transform.position
	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()

	pos = uiCamera:WorldToScreenPoint(pos)

	return pos, sizeDelta
end

function TimeWheelView:_onFilter(data)
	if TimeWheelStateModel.instance:getCurState() ~= TimeWheelStateModel.EnumType.Overflow then
		return self:_onPetFilter(data)
	elseif data.matType == TimeWheelStateModel.Pet then
		local bagPetMo = BagModel.instance:getPet(data.id)

		return self:_onPetFilter(bagPetMo)
	else
		local itemCfg = ItemConfig.instance:getAwakenItemExtCfgById(checknumber(data.id))

		if itemCfg then
			local raceId = checknumber(itemCfg.race)
			local petCo = CharacterConfig.instance:getPetCo(raceId)

			if petCo then
				return self:_isMatch(petCo, petCo.rare)
			else
				return false
			end
		end

		return true
	end
end

function TimeWheelView:_onPetFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = false

	isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._SearchText) then
		local str = StringUtil.RelpaceEscapeChar(self._SearchText)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function TimeWheelView:_isMatch(cfg, rare, skinId)
	return (PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_TIMEWHEEL, cfg, rare, skinId))
end

function TimeWheelView:_updateFilterData(starList, jobList, rareList)
	self:_RefreshFilterPetList()
end

function TimeWheelView:_RefreshFilterPetList()
	self._curViewDatas = {}

	local pets = TimeWheelStateModel.instance:getPetList()

	for k, v in pairs(pets) do
		if self:_onFilter(v) then
			self._curViewDatas[#self._curViewDatas + 1] = v
		end
	end

	self._tableview:ReloadData()
end

function TimeWheelView:_numInViewPreview()
	return #self._curViewDatasPreview
end

function TimeWheelView:_cellSizePreview(view, idx)
	return 100, 100
end

function TimeWheelView:_cellAtIndexPreview(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCellPreview)

	local data = self._curViewDatasPreview[index + 1]
	local component = TimeWheelPreviewItem.AddOnce(cell.gameObject)

	component:init(data)

	return cell
end

function TimeWheelView:_refreshPreviewListOverflow(petAndItemList)
	local baseCount = #petAndItemList

	if baseCount > 0 then
		local unitPrice = checknumber(TimeWheelConfig.instance:getScoreNum(4))
		local matType = MatType.Coin
		local coinId = 23
		local petList = {}

		for i, v in ipairs(petAndItemList) do
			if v.matType == TimeWheelStateModel.Pet then
				local petMo = BagPetsController.instance:getPet(v.id)

				if petMo then
					baseCount = baseCount + petMo:getAwakenLv()
				end

				table.insert(petList, v.id)
			end
		end

		local item = {}

		item.rewardType = 1
		item.rewardStr = MaterialMgr.createSerName(matType, coinId, unitPrice * baseCount)

		table.insert(self._curViewDatasPreview, item)

		if #petList > 0 then
			self:_refreshPreviewList(petList, true)
		end
	end
end

function TimeWheelView:_clearTableviewPreview(cell)
	local component = TimeWheelPreviewItem.AddOnce(cell.gameObject)

	component:reset()
end

function TimeWheelView:_refreshPreviewList(petList, notShowPetHead)
	local curState = TimeWheelStateModel.instance:getCurState()

	self._tempItemList = {}

	local samePetList = {}

	samePetList[GameEnum.PetRare.N] = 0
	samePetList[GameEnum.PetRare.R] = 0
	samePetList[GameEnum.PetRare.SR] = 0
	samePetList[GameEnum.PetRare.SSR] = 0

	for i, v in ipairs(petList) do
		local bagPetMo = BagModel.instance:getPet(v)

		if bagPetMo then
			local raceId = bagPetMo:getDefineId()
			local awakenLv = bagPetMo:getAwakenLv()
			local returnPetNum, returnGoldNum = 0, 0

			if curState == TimeWheelStateModel.EnumType.Revert then
				returnPetNum, returnGoldNum = TimeWheelStateModel.instance:getAwakenReturnNum(awakenLv, raceId)
			elseif curState == TimeWheelStateModel.EnumType.Decompose then
				local cfgPet = CharacterConfig.instance:getPetCo(raceId)

				if cfgPet then
					local initAwakenLv = cfgPet.initAwakenLv
					local initRare = CharacterConfig.instance:getInitRare(raceId)

					if initAwakenLv < awakenLv then
						returnPetNum, returnGoldNum = TimeWheelStateModel.instance:getAwakenReturnNum(awakenLv, raceId)

						if samePetList[initRare] then
							samePetList[initRare] = samePetList[initRare] + returnPetNum + 1
						end
					elseif samePetList[initRare] then
						samePetList[initRare] = samePetList[initRare] + 1
					end
				end
			end

			if not notShowPetHead then
				self:_addPetHead(awakenLv, raceId, returnPetNum)
			end

			self:_addExpItem(bagPetMo:getCurExp())
			self:_addMaterialAndCoin(bagPetMo, returnGoldNum)
		end
	end

	if curState == TimeWheelStateModel.EnumType.Decompose then
		for petRare, petNum in pairs(samePetList) do
			if petNum > 0 then
				local cfg = TimeWheelConfig.instance:getDecomposeParamCfg(petRare == GameEnum.PetRare.N and "rare_N" or petRare == GameEnum.PetRare.R and "rare_R" or petRare == GameEnum.PetRare.SR and "rare_SR" or "rare_SSR")

				if cfg then
					local itemType, id, num = string.match(cfg.paramValue, "(%d+):(%d+):(%d+)")

					itemType = checknumber(itemType)
					id = checknumber(id)
					num = checknumber(num)

					local totalNum = num * petNum
					local itemStr = MaterialMgr.createSerName(itemType, id, totalNum)

					self:_addToTempItemList(itemStr)
				end
			end
		end
	end

	self:_tempItemListToPreviewList()
end

function TimeWheelView:_clearPreviewList()
	self._curViewDatasPreview = self._curViewDatasPreview or {}

	table.clear(self._curViewDatasPreview)
	self._tableviewPreview:ReloadData()
end

function TimeWheelView:_addPetHead(awakenLv, raceId, returnPetNum)
	local curState = TimeWheelStateModel.instance:getCurState()

	if curState == TimeWheelStateModel.EnumType.Decompose then
		return
	end

	local petItem = {}

	petItem.rewardType = 2
	petItem.raceId = raceId

	if curState == TimeWheelStateModel.EnumType.Revert then
		local cfg = CharacterConfig.instance:getPetCo(petItem.raceId)

		petItem.petNum = returnPetNum

		if cfg then
			petItem.awakeLevel = cfg.initAwakenLv or 1
		end
	else
		petItem.petNum = 0
		petItem.awakeLevel = awakenLv
	end

	self._curViewDatasPreview[#self._curViewDatasPreview + 1] = petItem
end

function TimeWheelView:_getItemKey(itemStr)
	local strs = string.split(itemStr, ":")

	return strs[1] .. ":" .. strs[2]
end

function TimeWheelView:_combineSameTypeItem(originStr, newStr)
	local strAs = string.split(originStr, ":")
	local strBs = string.split(newStr, ":")

	if strAs[1] and strBs[1] and strAs[1] == strBs[1] and strAs[2] and strBs[2] and strAs[2] == strBs[2] then
		return string.format("%s:%s:%d", strAs[1], strAs[2], checknumber(strAs[3]) + checknumber(strBs[3]))
	end

	return originStr
end

function TimeWheelView:_addToTempItemList(str)
	local key = self:_getItemKey(str)

	if self._tempItemList[key] then
		self._tempItemList[key].rewardStr = self:_combineSameTypeItem(self._tempItemList[key].rewardStr, str)
	else
		local item = {}

		item.rewardType = 1
		item.rewardStr = str
		self._tempItemList[key] = item
	end
end

function TimeWheelView:_tempItemListToPreviewList()
	for k, v in pairs(self._tempItemList) do
		table.insert(self._curViewDatasPreview, v)
	end

	table.clear(self._tempItemList)
end

function TimeWheelView:_addExpItem(expNum)
	local strLists = {}
	local strs = TimeWheelStateModel.instance:getExpItemStr(expNum, strLists)

	for k, v in pairs(strs) do
		if not string.nilorempty(v) then
			self:_addToTempItemList(v)
		end
	end
end

function TimeWheelView:_addMaterialAndCoin(bagPetMo, returnGoldNum)
	local cfgs = CharacterConfig.instance:getPetTalentCfgByRaceId(bagPetMo:getDefineId())

	if not cfgs or #cfgs == 0 then
		return
	end

	local talentLevel = bagPetMo:getTalentLevel()
	local rewardList = {}
	local coinNum = 0

	for k, v in pairs(cfgs) do
		if talentLevel > v.level then
			coinNum = coinNum + v.upgradeCoinCost

			local materialCost = v.materialCost
			local mats = string.split(materialCost, "#")

			for k1, v1 in pairs(mats) do
				local mat = string.split(v1, ":")

				if #mat >= 3 then
					local key = mat[1] .. ":" .. mat[2]
					local value = checknumber(mat[3])

					rewardList[key] = rewardList[key] and rewardList[key] + value or value
				end
			end
		end
	end

	for k, v in pairs(rewardList) do
		local str = k .. ":" .. v

		self:_addToTempItemList(str)
	end

	local curState = TimeWheelStateModel.instance:getCurState()

	if coinNum > 0 then
		local str = MaterialMgr.createSerName(MatType.Coin, MatType.Coin_Gold, coinNum)

		self:_addToTempItemList(str)
	end

	if returnGoldNum > 0 then
		printInfo("test 消耗精灵之尘", returnGoldNum)

		local str = MaterialMgr.createSerName(MatType.Coin, MatType.Coin_Dust, returnGoldNum)

		self:_addToTempItemList(str)
	end
end

function TimeWheelView:_startAnim()
	local initShizhenZ = 90
	local initFenzhenZ = 45

	self._shizhen.eulerAngles = Vector3.New(0, 0, initShizhenZ)
	self._fenzhen.eulerAngles = Vector3.New(0, 0, initFenzhenZ)
	self._tweenShizhen = self._shizhen:DOLocalRotate(Vector3.New(0, 0, initShizhenZ - 360), 360, DG.Tweening.RotateMode.FastBeyond360):SetLoops(-1):SetEase(DG.Tweening.Ease.Linear)
	self._tweenFenzhen = self._fenzhen:DOLocalRotate(Vector3.New(0, 0, initFenzhenZ - 360), 60, DG.Tweening.RotateMode.FastBeyond360):SetLoops(-1):SetEase(DG.Tweening.Ease.Linear)
end

function TimeWheelView:_endAnim()
	self._tweenShizhen:Kill()
	self._tweenFenzhen:Kill()
end

function TimeWheelView:_playEffectAndDelayPopReward(delayFunc)
	self:_setMask(true)

	local nodeTime = 0.3

	self:_playNodePosAnim(nodeTime)
	TweenUtil.DOTweenNum(0, 1, nodeTime, nil, nil):OnComplete(function()
		self:_playBaokaiEffect()
	end)

	local delayTime = 0.9

	TweenUtil.DOTweenNum(0, 1, delayTime + nodeTime, nil, nil):OnComplete(function()
		delayFunc()
		self:_stopBaokaiEffect()
		self:_setMask(false)
	end)
end

function TimeWheelView:_playOverflowEffectAndDelayPopReward(delayFunc)
	self:_setMask(true)
	self:_playOverflowBoomEffect()
	TweenUtil.DoDelay(1.6, function()
		delayFunc()
		self:_stopOverflowBoomEffect()
		self:_setMask(false)
	end)
end

function TimeWheelView:_setMask(bValue)
	self._mask:SetActive(bValue)
end

function TimeWheelView:_playBaokaiEffect()
	self:_removeBaokaiEffect()

	if self._baokaiEffect then
		if self._baokaiEffect.effGo.activeSelf then
			self._baokaiEffect.effGo:SetActive(false)
		end

		self._baokaiEffect.effGo:SetActive(true)
	else
		local path = "fx_ui_shijianzhilun/fx_ui_baokai_shijianzhilun.prefab"

		self._baokaiEffect = UIEffectManager.instance:playEffect(self, path, self._effectParent.transform, 0, 0, true, false, nil, nil, self)

		self._baokaiEffect:setParent(self._effectParent.transform)
		self._baokaiEffect:setScale(1)
	end
end

function TimeWheelView:_stopBaokaiEffect()
	self:_removeBaokaiEffect()

	if self._baokaiEffect then
		self._baokaiEffect.effGo:SetActive(false)
	end
end

function TimeWheelView:_removeBaokaiEffect()
	if self._baokaiEffect then
		UIEffectManager.instance:stopEffect(self._baokaiEffect)

		self._baokaiEffect = nil
	end
end

function TimeWheelView:_playSelectEffect()
	self:_removeSelectEffect()

	if self._selectEffect then
		self._selectEffect.effGo:SetActive(true)
	else
		local path = "fx_ui_shijianzhilun/fx_ui_chufa_shijianzhilun.prefab"

		self._selectEffect = UIEffectManager.instance:playEffect(self, path, self._effectParent.transform, 0, 0, true, false, nil, nil, self)

		self._selectEffect:setParent(self._effectParent.transform)
		self._selectEffect:setScale(1)
	end
end

function TimeWheelView:_stopSelectEffect()
	self:_removeSelectEffect()

	if self._selectEffect then
		self._selectEffect.effGo:SetActive(false)
	end
end

function TimeWheelView:_removeSelectEffect()
	if self._selectEffect then
		UIEffectManager.instance:stopEffect(self._selectEffect)

		self._selectEffect = nil
	end
end

function TimeWheelView:_playOverflowBgEffect()
	self:_removeOverflowBgEffect()

	local path = "fx_ui_shijiansuoyuan/fx_ui_shijiansuoyuan_liuguang.prefab"
	local uiEffect = UIEffectManager.instance:playEffect(self, path, self._timeBg2.transform, 0, 0, true, false, nil, function(target, eff)
		local trs = eff.effGo.transform
		local count = trs.childCount

		for i = count, 1, -1 do
			local child = trs:GetChild(i - 1)

			GoUtil.SetSortingOrderGreatZero(child.gameObject, 201)
		end
	end)

	uiEffect:setParent(self._timeBg2.transform)
	uiEffect:setScale(1)
	uiEffect:setLocalPos(0, 4.5, 0)

	self._overflowBgEffect = uiEffect
end

function TimeWheelView:_removeOverflowBgEffect()
	if self._overflowBgEffect then
		UIEffectManager.instance:stopEffect(self._overflowBgEffect)

		self._overflowBgEffect = nil
	end
end

function TimeWheelView:_playOverflowBoomEffect()
	self:_removeOverflowBoomEffect()

	if self._overflowBoomEffect then
		self._overflowBoomEffect.effGo:SetActive(true)
	else
		local path = "fx_ui_shijiansuoyuan/fx_ui_shijiansuoyuan_fenjie.prefab"
		local uiEffect = UIEffectManager.instance:playEffect(self, path, self._overflowEffectParent.transform, 0, 0, true, false)

		uiEffect:setParent(self._overflowEffectParent.transform)
		uiEffect:setScale(1)
		uiEffect:setLocalPos(0, 36, 0)

		self._overflowBoomEffect = uiEffect
	end
end

function TimeWheelView:_stopOverflowBoomEffect()
	self:_removeOverflowBoomEffect()

	if self._overflowBoomEffect then
		self._overflowBoomEffect.effGo:SetActive(false)
	end
end

function TimeWheelView:_removeOverflowBoomEffect()
	if self._overflowBoomEffect then
		UIEffectManager.instance:stopEffect(self._overflowBoomEffect)

		self._overflowBoomEffect = nil
	end
end

function TimeWheelView:_playNodePosAnim(time)
	self:_stopNodePosAnim()

	local curState = TimeWheelStateModel.instance:getCurState()
	local endPos = self._targetPos.transform.position

	self._itemSelectTweens = {}

	if curState == TimeWheelStateModel.EnumType.Decompose or curState == TimeWheelStateModel.EnumType.Overflow then
		for k, v in pairs(self._itemSelectGos) do
			v._node.transform.localPosition = Vector3.New(0, 0, 0)

			local tween = v._node.transform:DOMove(endPos, time)

			table.insert(self._itemSelectTweens, tween)
		end
	else
		local tran = self._oneSelectNode.transform

		tran.localPosition = Vector3.New(0, 0, 0)

		local tween = tran:DOMove(endPos, time)

		table.insert(self._itemSelectTweens, tween)
		self._selectTxtDesc:SetActive(false)
	end

	self._tableviewPreview.gameObject:SetActive(false)
end

function TimeWheelView:_stopNodePosAnim()
	for k, v in pairs(self._itemSelectGos) do
		v._node.transform.localPosition = Vector3.New(0, 0, 0)
	end

	local tran = self._oneSelectNode.transform

	tran.localPosition = Vector3.New(0, 0, 0)

	if self._itemSelectTweens then
		for k, v in pairs(self._itemSelectTweens) do
			v:Kill()
		end

		self._itemSelectTweens = nil
	end

	self._tableviewPreview.gameObject:SetActive(true)
end

function TimeWheelView:_refreshRedPoint()
	local isExistPet = TimeWheelStateModel.instance:isExistCanDecomposePet()

	self._tabRedPoint:SetActive(isExistPet)
	self._btnRedPoint:SetActive(isExistPet)
end

function TimeWheelView:_setDiamondGoPos(index)
	if index == TimeWheelStateModel.EnumType.Reset then
		Framework.TransformUtil.SetLocalPos(self._diamondGo.transform, 477.8, -96, 0)
	else
		Framework.TransformUtil.SetLocalPos(self._diamondGo.transform, 477.8, -130, 0)
	end
end

function TimeWheelView:_onTimeWheelResetCount()
	self:_setTxtResetCount()
	self:_updateBtnResetState()
	self:_updateCdTxt()
end

function TimeWheelView:_setTxtResetCount()
	local totalCount = TimeWheelModel.instance:getTotalResetCount()
	local curLeftCount = TimeWheelModel.instance:getLeftResetCount()
	local colorStr = curLeftCount > 0 and "20b376" or "eb4642"

	self._txtResetCount.text = string.format("今日剩余次数：<color=#%s>%d</color>/%d", colorStr, curLeftCount, totalCount)
end

function TimeWheelView:_updateBtnResetState()
	if TimeWheelModel.instance:isCdAvailable() then
		goutil.setActive(self._txtResetGo, false)
		goutil.setActive(self._txtCd.gameObject, true)
	else
		goutil.setActive(self._txtResetGo, true)
		goutil.setActive(self._txtCd.gameObject, false)
	end

	self:_setBtnResetInteractable()
end

function TimeWheelView:_updateCdTxt()
	if self._txtCd.gameObject.activeSelf then
		local internal = TimeWheelController.instance:getTimeInternal()

		if internal > 0 then
			self._txtCd.text = string.format("重置冷却\n%s", GameUtil.FormatTimeSymbol(internal))
		else
			self:_updateBtnResetState()

			self._txtCd.text = "重置冷却\n00:00:00"
		end
	end
end

function TimeWheelView:_onClickSelect()
	local petIdList, itemIdList = TimeWheelController.instance:getPetListAndItemList()

	if #petIdList > 0 or #itemIdList > 0 then
		UIStateManager.instance:push(ViewName.TimeWheelSelectView, petIdList, itemIdList, function(isPet, id)
			self._isCurSelectPet = isPet
			self._curSelectId = id

			self:_showOverflowSelectIcon()
			self:_setTxtTip()
		end)
	else
		FloatWordMgr.instance:show("没有符合条件的精灵或者道具哦~")
	end
end

function TimeWheelView:_onClickSure()
	if not TimeWheelStateModel.instance:isExistSelectedPets() then
		FloatWordMgr.instance:show(TimeWheelStateModel.instance:getNoSelectTip())

		return
	end

	if PasswordLockController.instance:checkNeedOpenVerifyView() then
		return
	end

	local petAndItemList = TimeWheelStateModel.instance:getSelectedPets()
	local petIdList = {}
	local itemDic = {}

	for i, v in ipairs(petAndItemList) do
		if v.matType == TimeWheelStateModel.Pet then
			table.insert(petIdList, v.id)
		elseif v.matType == TimeWheelStateModel.Item then
			itemDic[v.id] = itemDic[v.id] or 0
			itemDic[v.id] = itemDic[v.id] + 1
		end
	end

	local itemList = {}

	for id, num in pairs(itemDic) do
		local element = {}

		element.itemId = id
		element.num = num

		table.insert(itemList, element)
	end

	TimeWheelAgent.instance:sendPM_DecomposeOverFlowPetBatchReq(petIdList, itemList)
end

function TimeWheelView:_onClickStore()
	UIStateManager.instance:push(ViewName.TimeWheelExchangeView)
end

function TimeWheelView:_resetOverflowSelectId()
	self._isCurSelectPet = nil
	self._curSelectId = nil
end

function TimeWheelView:_showOverflowSelectIcon()
	if self._isCurSelectPet ~= nil and self._curSelectId ~= nil then
		local proxy

		if self._isCurSelectPet then
			local bagPetMo = BagModel.instance:getPet(self._curSelectId)

			if bagPetMo then
				proxy = MaterialMgr.setCellByMo(bagPetMo, self._overflowIcon)
			end
		else
			proxy = MaterialMgr.setCell(MatType.Item, self._curSelectId, self._overflowIcon)
		end

		if proxy then
			proxy.binder:setAutoTips(false)
			proxy.binder:setCallBack(function()
				self:_resetOverflow()
			end)
		end

		self._btnSelect.gameObject:SetActive(false)
		self._overflowIcon:SetActive(true)
	else
		self:_resetOverflowSelectIcon()
	end
end

function TimeWheelView:_resetOverflowSelectIcon()
	self._btnSelect.gameObject:SetActive(false)
	self._overflowIcon:SetActive(false)
	MaterialMgr.resetAll(self._overflowIcon)
end

function TimeWheelView:_resetOverflow()
	self:_resetOverflowSelectId()
	self:_resetOverflowSelectIcon()
	self:_setTxtTip()
end

function TimeWheelView:_updateOverflowRedPoint()
	local isShow = TimeWheelController.instance:isShowOverflowRedPoint(true)

	self._tabRedPoint4:SetActive(isShow)
	TimeWheelController.instance:updateRedPoint()
end

function TimeWheelView:_closeOverflowRedPoint()
	self._tabRedPoint4:SetActive(false)
end

function TimeWheelView:_onClickTujianDecompose()
	local isToggle = TimeWheelController.instance:getTujianMaxDecomposeIsToggle()

	TimeWheelController.instance:setTujianMaxDecomposeToggle(not isToggle)
	goutil.setActive(self._imgTuJianSelect, not isToggle)
	self:_resetPetShow()
end

function TimeWheelView:_updateTujianDecomposeState()
	local isToggle = TimeWheelController.instance:getTujianMaxDecomposeIsToggle()

	goutil.setActive(self._imgTuJianSelect, isToggle)
end

function TimeWheelView:_onClickTujianOverflow()
	local isToggle = TimeWheelController.instance:getTujianMaxOverflowIsToggle()

	TimeWheelController.instance:setTujianMaxOverflowToggle(not isToggle)
	goutil.setActive(self._imgTuJianSelect4, not isToggle)
	self:_resetPetShow()
end

function TimeWheelView:_updateTujianOverflowState()
	local isToggle = TimeWheelController.instance:getTujianMaxOverflowIsToggle()

	goutil.setActive(self._imgTuJianSelect4, isToggle)
end

function TimeWheelView:_onRefreshPetList()
	self._tableview:Refresh()
end

return TimeWheelView
