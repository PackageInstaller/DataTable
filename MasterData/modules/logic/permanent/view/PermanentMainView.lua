-- chunkname: @modules/logic/permanent/view/PermanentMainView.lua

module("modules.logic.permanent.view.PermanentMainView", package.seeall)

local PermanentMainView = class("PermanentMainView", BaseView)

function PermanentMainView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "BG/#simage_FullBG")
	self._gotank = gohelper.findChild(self.viewGO, "#go_tank")
	self._gocurrency = gohelper.findChild(self.viewGO, "#go_topright/currencyview")
	self._txtcurrency = gohelper.findChildText(self._gocurrency, "#go_container/#go_currency/#btn_currency/#txt_num")
	self._btncurrency = gohelper.findChildButtonWithAudio(self._gocurrency, "#go_container/#go_currency/#btn_currency")
	self._imagecurrency = gohelper.findChildImage(self._gocurrency, "#go_container/#go_currency/#btn_currency/#image")
	self._animCurrency = self._gocurrency:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PermanentMainView:addEvents()
	self._btncurrency:AddClickListener(self._btncurrencyOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
end

function PermanentMainView:removeEvents()
	self._btncurrency:RemoveClickListener()
end

function PermanentMainView:_btncurrencyOnClick()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, self.currencyId, false)
end

function PermanentMainView:_editableInitView()
	local tankGO = self:getResInst(RoleStoryTank.prefabPath, self._gotank)

	self.roleStoryTank = RoleStoryTank.New(tankGO)
	self.currencyId = CurrencyEnum.CurrencyType.RoleStory

	self:buildScroll()
	PermanentModel.instance:undateActivityInfo()
end

function PermanentMainView:onOpen()
	PermanentActivityListModel.instance:refreshList()

	if self._scrollView and self.viewGO.activeInHierarchy then
		self._scrollView.playOpen = true

		self._scrollView:onOpen()
		TaskDispatcher.runDelay(self._delaySet, self, 0.1)
	end

	self._animCurrency:Play("currencyview_in")
	self:refreshCurrency()
	self.roleStoryTank:onOpen()
end

function PermanentMainView:_delaySet()
	self._scrollView.playOpen = false
end

function PermanentMainView:onClose()
	self._animCurrency:Play("currencyview_out")

	if self._scrollView then
		self._scrollView:onCloseFinish()
	end

	TaskDispatcher.cancelTask(self._delaySet, self)
end

function PermanentMainView:onDestroyView()
	if self._scrollView then
		self._scrollView:removeEventsInternal()
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	self._scrollView = nil

	if self.roleStoryTank then
		self.roleStoryTank:onDestroy()

		self.roleStoryTank = nil
	end
end

function PermanentMainView:buildScroll()
	if self._scrollView then
		return
	end

	local scrollParam = ListScrollParam.New()

	scrollParam.scrollGOPath = "#scroll_view"
	scrollParam.prefabType = ScrollEnum.ScrollPrefabFromRes
	scrollParam.prefabUrl = "ui/viewres/dungeon/reappear/reappearitem.prefab"
	scrollParam.cellClass = PermanentMainItem
	scrollParam.scrollDir = ScrollEnum.ScrollDirH
	scrollParam.lineCount = 1
	scrollParam.cellWidth = 692
	scrollParam.cellHeight = 420
	scrollParam.cellSpaceH = 23
	scrollParam.cellSpaceV = 0
	scrollParam.startSpace = 50
	scrollParam.endSpace = 0
	scrollParam.sortMode = ScrollEnum.ScrollSortUp
	self._scrollView = LuaListScrollView.New(PermanentActivityListModel.instance, scrollParam)

	self._scrollView:__onInit()

	self._scrollView.viewGO = self.viewGO
	self._scrollView.viewName = self.viewName
	self._scrollView.viewContainer = self

	self._scrollView:onInitViewInternal()
	self._scrollView:addEventsInternal()
end

function PermanentMainView:_onCurrencyChange(changeIds)
	local id = self.currencyId

	if not id or not changeIds[id] then
		return
	end

	self:refreshCurrency()
end

function PermanentMainView:refreshCurrency()
	local currencyID = self.currencyId
	local currencyMO = CurrencyModel.instance:getCurrency(currencyID)
	local currencyCO = CurrencyConfig.instance:getCurrencyCo(currencyID)

	if currencyMO then
		if not currencyMO.quantity then
			local quantity = 0

			self._txtcurrency.text = string.format("%s/%s", GameUtil.numberDisplay(quantity), GameUtil.numberDisplay(currencyCO.maxLimit))

			local currencyname = currencyCO.icon

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecurrency, currencyname .. "_1")
		end
	end
end

function PermanentMainView:_onFullViewClose()
	if self.viewGO.activeInHierarchy then
		PermanentModel.instance:undateActivityInfo()
	end
end

return PermanentMainView
