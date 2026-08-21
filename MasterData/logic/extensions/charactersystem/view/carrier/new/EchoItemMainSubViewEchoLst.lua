-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/new/EchoItemMainSubViewEchoLst.lua

module("logic.extensions.charactersystem.view.carrier.new.EchoItemMainSubViewEchoLst", package.seeall)

local M = class("EchoItemMainSubViewEchoLst")

M.SubViewType = EchoItemMainViewNew.SubViewType

function M:ctor(compContainer)
	self.mainGO = compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self.mainGO)
end

function M:getMainGo()
	return self.mainGO
end

function M:getRegistry()
	return self._registry
end

function M:Awake()
	self:buildUI()
	self:bindEvents()
end

function M:OnDestroy()
	self:unbindEvents()
	self:destroyUI()
end

function M:buildUI()
	local registry = self:getRegistry()

	self._rectTrLeftContent = registry:findUIElement("echo_view_copy_1495753063", UIComponentType.RectTransform)

	goutil.setActive(self._rectTrLeftContent.gameObject, true)

	self._goEchoLstBg = registry:findUIElement("echo_view_copy_1826432800")
	self._goEchoLstEmpty = registry:findUIElement("echo_view_copy_-422436778")
	self._btnEchoLstEmptyJump = UIComponentType.ButtonAdapter(registry:findUIElement("15&empty_unit_-1492724947"))
	self._btnLstMask = UIComponentType.ButtonAdapter(registry:findUIElement("echo_view_copy_1839703911"))
	self._scrollEcho = registry:findUIElement("echo_view_copy_719214829", UIComponentType.ScrollRect)
	self._rectTrscrollEcho = registry:findUIElement("echo_view_copy_719214829", UIComponentType.RectTransform)
	self._loopGridViewEcho = LoopGridViewHelper.New(self._scrollEcho.gameObject)

	self._loopGridViewEcho:InitGridView(0, self._onEchoCellUpdate, self)
end

function M:destroyUI()
	self._isEnter = false
	self._handler = nil

	self._loopGridViewEcho:Dispose()

	self._loopGridViewEcho = nil
end

function M:bindEvents()
	self._btnLstMask:AddClickListener(self._onClickLstMask, self)
	self._btnEchoLstEmptyJump:AddClickListener(self._onClickEchoLstEmptyJump, self)
end

function M:unbindEvents()
	self._btnLstMask:RemoveClickListener()
	self._btnEchoLstEmptyJump:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)

	self._lastPageTyp = nil
	self._isEnter = true
end

function M:onExit()
	self._isEnter = false

	self:setEvent(false)
	self:_playItemOpenAni(false)
	self._loopGridViewEcho:ClearCells()

	self._lastPageTyp = nil
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_SET_BREAK_COST_LST_SHOW, self._handleEchoSetBreakCostLstShow, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
		GlobalDispatcher:addEventListener(EventType.ECHO_ITEM_FILTER_CHANGE, self._handleEchoItemFilterChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_INFO_REFRESH, self._handleEchoItemInfoRefresh, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_SET_BREAK_COST_LST_SHOW, self._handleEchoSetBreakCostLstShow, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_COST_FOR_BREAK_SELECT, self._handleEchoCostForBreakSelect, self)
		GlobalDispatcher:removeEventListener(EventType.ECHO_ITEM_FILTER_CHANGE, self._handleEchoItemFilterChange, self)
	end
end

function M:_handleEchoItemInfoRefresh(e, isUpgrade)
	if not self._isEnter then
		return
	end

	if isUpgrade then
		self:setVisible(false, isUpgrade)
	else
		self:refreshEchoScroll(false, false)
	end
end

function M:_handleEchoSetBreakCostLstShow(e, show)
	if not self._isEnter then
		return
	end

	if show == nil then
		show = not self:getVisible()
	end

	if show then
		if self:getPageTyp() == M.SubViewType.Break then
			self:setVisible(true)
			EchoItemMainController.instance:updateAvailableEchoItem()

			self._echoLst = EchoItemMainController.instance:getAvailableEchoItem():getMoList()

			self:refreshEchoScroll(true, true)
		end
	else
		self:setVisible(false)
	end
end

function M:_handleEchoCostForBreakSelect(e, echoItemDataList)
	if not self._isEnter then
		return
	end

	self:refreshEchoScroll(false, false)
end

function M:_handleEchoItemFilterChange(e, echoLst)
	if not self._isEnter then
		return
	end

	if self:getPageTyp() == M.SubViewType.Change then
		self:setVisible(true)

		self._echoLst = echoLst or {}

		self:refreshEchoScroll(true, true)
	end
end

function M:_onClickLstMask()
	self:setVisible(false)
end

function M:_onClickEchoLstEmptyJump()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, 10803004)
end

function M:setHandler(handler)
	self._handler = handler
end

function M:onPageTypChange(typ, echoLst)
	local isChange = self._lastPageTyp and self._lastPageTyp ~= typ or true

	self._lastPageTyp = self._curPageTyp
	self._curPageTyp = typ

	if isChange then
		local needShow = typ == M.SubViewType.Change

		self:setVisible(needShow)
	end

	self._echoLst = echoLst

	self:_playItemOpenAni(false)
	self:refreshEchoScroll(true, true)
end

function M:getPageTyp()
	return self._curPageTyp
end

function M:setVisible(visible, byUpgrading)
	self._LstVisible = visible

	local x = visible and 0 or -1000

	Astral.GeometryUtil.SetAnchorPosX(self._rectTrLeftContent, x)

	if self:getPageTyp() == M.SubViewType.Change then
		goutil.setActive(self._btnLstMask.gameObject, false)
	else
		goutil.setActive(self._btnLstMask.gameObject, visible)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_ECHO_BREAK_ITEM_LST_SHOW, visible, byUpgrading)
end

function M:getVisible()
	return self._LstVisible
end

function M:getIsSelectedEchoItem(echoItemData)
	local isSelected = false

	if self:getPageTyp() == M.SubViewType.Change then
		local selectedEcho = EchoItemMainController.instance:getSelectedEchoItem()

		if selectedEcho and echoItemData then
			isSelected = selectedEcho:getUuid() == echoItemData:getUuid()
		end
	elseif self:getPageTyp() == M.SubViewType.Break then
		isSelected = EchoItemMainController.instance:getIsItemSelectedForBreak(echoItemData)
	end

	return isSelected
end

function M:getCurHeroId()
	local heroId
	local viewPageMo = HeroDepotModel.instance:getViewPageMo()
	local heroData = viewPageMo and viewPageMo.hero or false

	if heroData then
		heroId = heroData:getId()
	end

	return heroId
end

function M:isRecommendEcho(echoItemId)
	return EchoItemMainController.instance:getIsRecommendEcho(self:getCurHeroId(), echoItemId)
end

function M:refreshEchoScroll(resetPos, playOpenAni)
	local height = self._curPageTyp == M.SubViewType.Break and 606 or 544

	goutil.setHeight(self._rectTrscrollEcho, height)

	local count = self._echoLst and #self._echoLst or 0

	self._needPlayItemCellOpenAni = playOpenAni
	self._needPlayItemAniMaxIndex = self._curPageTyp == M.SubViewType.Break and 18 or 15
	self._itemShowerCache = {}

	self._loopGridViewEcho:SetListItemCount(count, resetPos)
	self._loopGridViewEcho:RefreshAllShownItem()

	if resetPos then
		self._loopGridViewEcho:MoveToItemIndex(0)
	end

	goutil.setActive(self._goEchoLstEmpty, count == 0)
	goutil.setActive(self._goEchoLstBg, self._curPageTyp == M.SubViewType.Break)
	self:_playItemOpenAni(playOpenAni)
end

function M:_onEchoCellUpdate(curIndex, row, column)
	curIndex = curIndex + 1

	local class = EchoItemSelectItemCellNew
	local item = self._loopGridViewEcho:NewListViewItem("backpack_item (1)")
	local data = self._echoLst[curIndex]
	local isSelected = self:getIsSelectedEchoItem(data)
	local shower = Astral.SimpleLuaComponentContainer.Add(item.gameObject, class)

	shower:updateData(data)
	shower:onSelect(isSelected, self:getPageTyp())

	local sign = self:isRecommendEcho(data:getId()) and CommEnum.BackPackItemSignTyp.RecommendSign or nil

	shower:setSign(sign)
	shower:setDealSelectFunc(self._onCellDealSelect, self)

	if self._needPlayItemCellOpenAni and curIndex <= self._needPlayItemAniMaxIndex then
		self._itemShowerCache[curIndex] = shower

		shower:getComponent("animation"):setAlpha(0)
	else
		shower:getComponent("animation"):setAlpha(1)
	end

	local presetComponent = shower:getComponent("preset")

	if presetComponent then
		if self._curPageTyp == M.SubViewType.Break then
			local isPreset = CharacterPreinstallController.instance:getItemList(data:getUuid())

			presetComponent:setVisible(isPreset)
		else
			presetComponent:setVisible(false)
		end
	end

	return item
end

function M:_playItemOpenAni(play)
	for _, tweener in ipairs(self._cacheTweenLst or {}) do
		if tweener then
			tweener:Kill(false)
		end
	end

	self._cacheTweenLst = {}

	if play then
		local maxDelay = 0.1

		self._scrollEcho.enabled = false

		for index, shower in ipairs(self._itemShowerCache or {}) do
			local delay = index * 0.05

			delay = delay > 1 and 1 or delay
			maxDelay = maxDelay < delay and delay or maxDelay

			local tweenDelay = DoTweenUtil.DelayedCall(delay, function()
				shower:getComponent("animation"):setAlpha(1)
				shower:getComponent("animation"):playOpenAni()
			end)

			table.insert(self._cacheTweenLst, tweenDelay)
		end

		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false

		table.insert(self._cacheTweenLst, DoTweenUtil.DelayedCall(maxDelay, function()
			self._scrollEcho.enabled = true
		end))
	else
		for index, shower in ipairs(self._itemShowerCache or {}) do
			shower:getComponent("animation"):setAlpha(1)
		end

		self._cacheTweenLst = nil
		self._itemShowerCache = nil
		self._needPlayItemCellOpenAni = false
		self._scrollEcho.enabled = true
	end
end

function M:_onCellDealSelect(echoItemData)
	if self:getPageTyp() == M.SubViewType.Change then
		EchoItemMainController.instance:setSelectedEchoItem(echoItemData)
		self:refreshEchoScroll(false, false)

		if Astral.OSDef.isEditor then
			printWarn(string.format("选择残响[%s],career[%s],玩家career[%s]", echoItemData:getId(), echoItemData:getCareer(), EchoItemController.instance:getCurHeroCareer()))
		end
	else
		local curEcho = EchoItemMainController.instance:getSelectedEchoItem()

		if curEcho:getIsMaxLevel() then
			ToolTipsMgr.showCharacterTopToast(lang("tip_max_not_break_through"), CommEnum.CharacterTopToastIcon.Fail, 1)

			return
		end

		local isSelected = EchoItemMainController.instance:getIsItemSelectedForBreak(echoItemData)

		if isSelected then
			EchoItemMainController.instance:setCostEchoItemForBreak(echoItemData, false)

			return
		else
			if echoItemData:getIsLock() then
				ToolTipsMgr.showCharacterTopToast(lang("tip_echo_has_lock"), CommEnum.CharacterTopToastIcon.Fail, 1)

				return
			end

			if echoItemData:getHeroId() > 0 then
				ToolTipsMgr.showCharacterTopToast(lang("tip_echo_has_carry"), CommEnum.CharacterTopToastIcon.Fail, 1)

				return
			end

			local needCount = curEcho:getUpgradeNeedCount()
			local selectedCount = EchoItemMainController.instance:getCostEchoItemForBreakSelectedCount()

			if needCount <= selectedCount then
				ToolTipsMgr.showCharacterTopToast(lang("tip_echo_break_cost_num_enough"), CommEnum.CharacterTopToastIcon.Info, 1)

				return
			end

			EchoItemMainController.instance:setCostEchoItemForBreak(echoItemData, true)
		end
	end
end

return M
