-- chunkname: @modules/logic/store/view/DecorateStoreView.lua

module("modules.logic.store.view.DecorateStoreView", package.seeall)

local DecorateStoreView = class("DecorateStoreView", BaseView)

function DecorateStoreView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "Bg")
	self._gotypebg = gohelper.findChild(self.viewGO, "Bg/typebg")
	self._gotypebg1 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg1")
	self._simagetypebg1 = gohelper.findChildSingleImage(self.viewGO, "Bg/typebg/#go_typebg1/#simage_icon")
	self._gotypebg2 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg2")
	self._gotypebg3 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg3")
	self._gotypebg5 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg5")
	self._gotypebg6 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg6")
	self._gotypebg7 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg7")
	self._gotypebg8 = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg8")
	self._simagetypebg7 = gohelper.findChildSingleImage(self.viewGO, "Bg/typebg/#go_typebg7/#simage_icon")
	self._gozs = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg2/zs")
	self._goskincontainer = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer")
	self._simageskin = gohelper.findChildSingleImage(self.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#simage_skin")
	self._simagel2d = gohelper.findChildSingleImage(self.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#simage_l2d")
	self._gobigspine = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer/#go_spine")
	self._gospinecontainer = gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg2/characterSpine/#go_skincontainer/#go_spinecontainer")
	self._goview1 = gohelper.findChild(self.viewGO, "UI/#go_view1")
	self._goContent1 = gohelper.findChild(self.viewGO, "UI/#go_view1/Viewport/#go_Content1")
	self._btnunfold = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_view1/#btn_unfold")
	self._goview2 = gohelper.findChild(self.viewGO, "UI/#go_view2")
	self._goContent2 = gohelper.findChild(self.viewGO, "UI/#go_view2/Viewport/#go_Content2")
	self._btnfold = gohelper.findChildButtonWithAudio(self.viewGO, "UI/#go_view2/#btn_fold")
	self._gocommon = gohelper.findChild(self.viewGO, "UI/common")
	self._gohideclick = gohelper.findChild(self.viewGO, "UI/common/#btn_hide/#go_hideclick")
	self._goowned = gohelper.findChild(self.viewGO, "UI/common/#go_owned")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/layout/#btn_hide")
	self._btnswitch = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/layout/#btn_switch")
	self._txtswitch = gohelper.findChildText(self.viewGO, "UI/common/layout/#btn_switch/#txt_switch")
	self._godynamiccontainer = gohelper.findChild(self.viewGO, "UI/common/layout/smalldynamiccontainer")
	self._gosmallspine = gohelper.findChild(self.viewGO, "UI/common/layout/smalldynamiccontainer/#go_smallspine")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/#btn_buy")
	self._godiscount = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/#go_discount2/#txt_discount")
	self._gosingle = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/cost/#go_single")
	self._imagesingleicon = gohelper.findChildImage(self.viewGO, "UI/common/#btn_buy/cost/#go_single/icon/simage_material")
	self._txtcurprice = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_single/txt_materialNum")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_single/#txt_original_price")
	self._godouble = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice")
	self._imagedoubleicon1 = gohelper.findChildImage(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	self._txtcurprice1 = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	self._txtoriginalprice1 = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	self._imagedoubleicon2 = gohelper.findChildImage(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/simage_material")
	self._txtcurprice2 = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	self._txtoriginalprice2 = gohelper.findChildText(self.viewGO, "UI/common/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	self._gofree = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/cost/#go_free")
	self._gocostclick = gohelper.findChild(self.viewGO, "UI/common/#btn_buy/#go_costclick")
	self._txtdec = gohelper.findChildText(self.viewGO, "UI/common/#txt_dec")
	self._txttitle = gohelper.findChildText(self.viewGO, "UI/common/title/#txt_title")
	self._godiscounttip = gohelper.findChild(self.viewGO, "UI/common/#go_discountTips")
	self._txtdiscounttip = gohelper.findChildText(self.viewGO, "UI/common/#go_discountTips/#txt_discountTips")
	self._goscene = gohelper.findChild(self.viewGO, "UI/common/#go_scene")
	self._btnframe = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/#go_scene/go_frame")
	self._txtframename = gohelper.findChildText(self.viewGO, "UI/common/#go_scene/go_frame/namebg/txt_name")
	self._goframereceive = gohelper.findChild(self.viewGO, "UI/common/#go_scene/go_frame/go_receive")
	self._btnbackground = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/#go_scene/go_background")
	self._txtbackgroundname = gohelper.findChildText(self.viewGO, "UI/common/#go_scene/go_background/namebg/txt_name")
	self._gobackgroundreceive = gohelper.findChild(self.viewGO, "UI/common/#go_scene/go_background/go_receive")
	self._gotype = gohelper.findChild(self.viewGO, "UI/type")
	self._gotype2 = gohelper.findChild(self.viewGO, "UI/type/type2")
	self._txtrolename = gohelper.findChildText(self.viewGO, "UI/type/type2/#txt_rolename")
	self._simagesignature = gohelper.findChildSingleImage(self.viewGO, "UI/type/type2/#simage_signature")
	self._gotype4 = gohelper.findChild(self.viewGO, "UI/type/type4")
	self._gotype5 = gohelper.findChild(self.viewGO, "UI/type/type5")
	self._gostorecategoryitem = gohelper.findChild(self.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem")
	self._goline = gohelper.findChild(self.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_line")
	self._gotabreddot1 = gohelper.findChild(self.viewGO, "UI/scroll_category/viewport/categorycontent/#go_storecategoryitem/#go_tabreddot1")
	self._gotype6 = gohelper.findChild(self.viewGO, "UI/type/type6")
	self.goTitleDesc = gohelper.findChild(self.viewGO, "UI/common/title/#txt_title/dec")
	self.btnCheck = gohelper.findChildButtonWithAudio(self.viewGO, "UI/common/title/#txt_title/#btn_check")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateStoreView:addEvents()
	self._btnunfold:AddClickListener(self._btnunfoldOnClick, self)
	self._btnfold:AddClickListener(self._btnfoldOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnswitch:AddClickListener(self._btnswitchOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.btnCheck:AddClickListener(self.btnCheckOnClick, self)
	self._btnframe:AddClickListener(self.btnframeOnClick, self)
	self._btnbackground:AddClickListener(self.btnbackgroundOnClick, self)
end

function DecorateStoreView:removeEvents()
	self._btnunfold:RemoveClickListener()
	self._btnfold:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnswitch:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self.btnCheck:RemoveClickListener()
	self._btnframe:RemoveClickListener()
	self._btnbackground:RemoveClickListener()
end

function DecorateStoreView:btnbackgroundOnClick()
	local sceneCo = self:_getSceneGoodsSwitchCO(self._v3a4PackageGoodsIds[2])
	local sceneSkinId = sceneCo.id

	ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
		isPreview = true,
		noInfoEffect = true,
		sceneSkinId = sceneSkinId
	})
end

function DecorateStoreView:btnframeOnClick()
	local UICo = self:_getUIGoodsSwitchCO(self._v3a4PackageGoodsIds[3])
	local uiSkinId = UICo.id

	MainUISwitchController.instance:openMainUISwitchInfoView(uiSkinId, true, true, true, true)
end

function DecorateStoreView:btnCheckOnClick()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local goodItemCos = string.splitToNumber(goodMo.config.product, "#")

	ViewMgr.instance:openView(ViewName.DecorateSkinListView, {
		itemId = goodItemCos[2]
	})
end

function DecorateStoreView:_btnunfoldOnClick()
	self._viewAnim.enabled = true

	self._viewAnim:Play("goview2", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.UnFold)
	self:_refreshGood(true)
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function DecorateStoreView:_btnfoldOnClick()
	self._viewAnim.enabled = true

	self._viewAnim:Play("goview1", 0, 0)
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)
	self:_refreshGood()
	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function DecorateStoreView:_btnhideOnClick()
	self:_hideUIShowDefaultView(false)
end

function DecorateStoreView:_hideUIShowDefaultView(isAutoClose)
	self._isDefaultShowViewAutoClose = isAutoClose == true

	self._viewAnim:Play("hide", 0, 0)
	StoreController.instance:dispatchEvent(StoreEvent.PlayHideStoreAnim)
	UIBlockMgr.instance:startBlock("decoratehide")
	TaskDispatcher.runDelay(self._startDefaultShowView, self, 0.34)
	self:_checkMainUIScale(true)
end

function DecorateStoreView:_startDefaultShowView()
	UIBlockMgr.instance:endBlock("decoratehide")

	self._viewAnim.enabled = false

	local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)

	if curItemType == DecorateStoreEnum.DecorateItemType.MainScene then
		local data = {}

		data.sceneId = self._sceneId
		data.callback = self._showHideCallback
		data.callbackObj = self

		ViewMgr.instance:openView(ViewName.MainSceneStoreShowView, data)
	else
		local data = {}

		data.bg = gohelper.findChild(self.viewGO.transform.parent.gameObject, "bg")
		data.contentBg = self._gotypebg
		data.callback = self._showHideCallback
		data.callbackObj = self
		data.viewCls = self._viewCls

		if self._isDefaultShowViewAutoClose == true then
			data.viewShowTime = DecorateStoreEnum.DefaultViewShowTime
		end

		ViewMgr.instance:openView(ViewName.DecorateStoreDefaultShowView, data)
	end
end

function DecorateStoreView:_showHideCallback(data)
	self._viewAnim.enabled = true

	self._viewAnim:Play("show", 0, 0)

	local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)

	if curItemType == DecorateStoreEnum.DecorateItemType.MainScene then
		-- block empty
	else
		data.bg.transform:SetParent(self.viewGO.transform.parent, false)
		gohelper.setAsFirstSibling(data.bg)
		data.contentBg.transform:SetParent(self._gobg.transform, false)
		gohelper.setAsFirstSibling(data.contentBg)
	end

	StoreController.instance:dispatchEvent(StoreEvent.PlayShowStoreAnim)
	self:_checkMainUIScale(false)
end

function DecorateStoreView:_btnswitchOnClick()
	self._showLive2d = not self._showLive2d

	self:_refreshBigSkin()
end

function DecorateStoreView:_btnbuyOnClick()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)

	StoreController.instance:openDecorateStoreGoodsView(goodMo)
end

function DecorateStoreView:_editableInitView()
	self._goodItems = {}
	self._categoryItemContainer = {}
	self._viewAnim = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._btnhide.gameObject, true)
	DecorateStoreModel.instance:initDecorateReadState()

	self._v3a4PackageGoodsIds = DecorateStoreModel.instance:getV3a4PackageStoreGoodsIds()
end

function DecorateStoreView:_onCloseView(viewName)
	if (viewName == ViewName.MainSceneStoreShowView or viewName == ViewName.MainSceneSwitchInfoView) and self._weatherSwitchControlComp then
		MainSceneSwitchCameraController.instance:showScene(self._sceneId, self._showSceneFinished, self)
	elseif viewName == ViewName.MainUISwitchInfoBlurMaskView and self._weatherSwitchControlComp then
		local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)

		if curItemType == DecorateStoreEnum.DecorateItemType.SceneUIPackage then
			self:_updateDecorateSceneUIPackage()
		elseif curItemType == DecorateStoreEnum.DecorateItemType.MainUISkin then
			self:_updateDecorateMainUISkin()
		end
	end
end

function DecorateStoreView:_addEvents()
	self.addEventCb(self, StoreController.instance, StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._onGoodsChanged, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onGoodsChanged, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.DecorateStoreSkinSelectItemClick, self.onDecorateSkinSelectItem, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.GainSkin, self._refreshGood, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshGood, self)
end

function DecorateStoreView:_removeEvents()
	self.removeEventCb(self, StoreController.instance, StoreEvent.DecorateGoodItemClick, self._onGoodItemClick, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.GoodsModelChanged, self._onGoodsChanged, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self._onGoodsChanged, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.DecorateStoreSkinSelectItemClick, self.onDecorateSkinSelectItem, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.GainSkin, self._refreshGood, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshGood, self)
end

function DecorateStoreView:_onGoodItemClick()
	self._showLive2d = false

	local isFold = DecorateStoreModel.instance:getCurViewType()

	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	if isFold == DecorateStoreEnum.DecorateViewType.UnFold then
		local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
		local index = DecorateStoreModel.instance:getDecorateGoodIndex(self._selectSecondTabId, goodId)
		local count = #DecorateStoreModel.instance:getDecorateGoodList(self._selectSecondTabId)
		local x, y = transformhelper.getLocalPos(self._goContent1.transform)

		transformhelper.setLocalPos(self._goContent1.transform, (index > 4 or nil) and (count - index >= 4 and 55 - 360 * (index - 4) or -360 * (index - 4)), y, 0)
		self:_startGoodIn()

		return
	end

	self._viewAnim:Play("out", 0, 0)
	UIBlockMgr.instance:startBlock("decorateswitch")
	TaskDispatcher.runDelay(self._startGoodIn, self, 0.17)
end

function DecorateStoreView:_startGoodIn()
	UIBlockMgr.instance:endBlock("decorateswitch")
	self._viewAnim:Play("in", 0, 0)
	self:_refreshGood(true)
end

function DecorateStoreView:_onGoodsChanged()
	local newGoods = DecorateStoreModel.instance:getDecorateGoodList(StoreEnum.StoreId.NewDecorateStore)
	local hasNo = #newGoods <= 0

	if hasNo then
		return
	end

	self:_onRefreshRedDot()
	self:_refreshGood()
end

function DecorateStoreView:onOpen()
	Activity186Model.instance:checkReadTask(Activity186Enum.ReadTaskId.Task4)

	self._opened = true

	self:_addEvents()
	DecorateStoreModel.instance:setCurViewType(DecorateStoreEnum.DecorateViewType.Fold)

	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId, true, true)
end

function DecorateStoreView:onUpdateParam()
	self._selectFirstTabId = self.viewContainer:getSelectFirstTabId()

	local jumpTabId = self.viewContainer:getJumpTabId()

	self:_refreshTabs(jumpTabId)
end

function DecorateStoreView:_refreshTabs(selectTabId, openUpdate, scrollToRadDot)
	local preSelectSecondTabId = self._selectSecondTabId

	self._selectSecondTabId = 0

	if not StoreModel.instance:isTabOpen(selectTabId) then
		selectTabId = self.viewContainer:getSelectFirstTabId()
	end

	local _

	_, self._selectSecondTabId, _ = StoreModel.instance:jumpTabIdToSelectTabId(selectTabId)

	local secondConfig = StoreConfig.instance:getTabConfig(self._selectSecondTabId)
	local firstConfig = StoreConfig.instance:getTabConfig(self.viewContainer:getSelectFirstTabId())

	if secondConfig and not string.nilorempty(secondConfig.showCost) then
		self.viewContainer:setCurrencyType(secondConfig.showCost)
	elseif firstConfig and not string.nilorempty(firstConfig.showCost) then
		self.viewContainer:setCurrencyType(firstConfig.showCost)
	else
		self.viewContainer:setCurrencyType(nil)
	end

	if not openUpdate and preSelectSecondTabId == self._selectSecondTabId then
		return
	end

	self:_refreshAllSecondTabs()
	StoreController.instance:readTab(selectTabId)
	self:_onRefreshRedDot()

	self._resetScrollPos = true

	if self._opened then
		preSelectSecondTabId = nil
		self._opened = false
	end

	if preSelectSecondTabId and self._goodItems[preSelectSecondTabId] then
		self._viewAnim:Play("out", 0, 0)

		for _, v in pairs(self._goodItems[preSelectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold]) do
			v:playOut()
		end

		UIBlockMgr.instance:startBlock("decorateswitch")
		TaskDispatcher.runDelay(self._switchTabRefresh, self, 0.17)
	else
		self._viewAnim:Play("in", 0, 0)
		self:_refreshGood()
	end
end

function DecorateStoreView:_switchTabRefresh()
	UIBlockMgr.instance:endBlock("decorateswitch")

	local x, y = transformhelper.getLocalPos(self._goContent1.transform)

	transformhelper.setLocalPos(self._goContent1.transform, 0, y, 0)
	self._viewAnim:Play("in", 0, 0)
	self:_refreshGood()
end

function DecorateStoreView:_refreshAllSecondTabs()
	local secondTabConfigs = StoreModel.instance:getSecondTabs(self._selectFirstTabId, true, true)

	if secondTabConfigs and #secondTabConfigs > 0 then
		for i = 1, #secondTabConfigs do
			self:_refreshSecondTabs(i, secondTabConfigs[i])

			local secondTabsGoods = DecorateStoreModel.instance:getDecorateGoodList(secondTabConfigs[i].id)

			gohelper.setActive(self._categoryItemContainer[i].go, #secondTabsGoods > 0)
		end

		for i = #secondTabConfigs + 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end
	else
		for i = 1, #self._categoryItemContainer do
			gohelper.setActive(self._categoryItemContainer[i].go, false)
		end
	end
end

function DecorateStoreView:_refreshSecondTabs(index, secondTabConfig)
	local categoryItemTable = self._categoryItemContainer[index]

	categoryItemTable = categoryItemTable or self:initCategoryItemTable(index)
	categoryItemTable.tabId = secondTabConfig.id
	categoryItemTable.txt_itemcn1.text = secondTabConfig.name
	categoryItemTable.txt_itemcn2.text = secondTabConfig.name
	categoryItemTable.txt_itemen1.text = secondTabConfig.nameEn
	categoryItemTable.txt_itemen2.text = secondTabConfig.nameEn

	local select = self._selectSecondTabId == secondTabConfig.id

	gohelper.setActive(categoryItemTable.go_unselected, not select)
	gohelper.setActive(categoryItemTable.go_selected, select)
end

function DecorateStoreView:initCategoryItemTable(index)
	local categoryItemTable = self:getUserDataTb_()

	categoryItemTable.go = gohelper.cloneInPlace(self._gostorecategoryitem, "item" .. index)
	categoryItemTable.go_unselected = gohelper.findChild(categoryItemTable.go, "go_unselected")
	categoryItemTable.go_selected = gohelper.findChild(categoryItemTable.go, "go_selected")
	categoryItemTable.go_line = gohelper.findChild(categoryItemTable.go, "go_line")
	categoryItemTable.go_reddot = gohelper.findChild(categoryItemTable.go, "#go_tabreddot1")
	categoryItemTable.txt_itemcn1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemcn1")
	categoryItemTable.txt_itemen1 = gohelper.findChildText(categoryItemTable.go, "go_unselected/txt_itemen1")
	categoryItemTable.txt_itemcn2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemcn2")
	categoryItemTable.txt_itemen2 = gohelper.findChildText(categoryItemTable.go, "go_selected/txt_itemen2")
	categoryItemTable.go_childcategory = gohelper.findChild(categoryItemTable.go, "go_childcategory")
	categoryItemTable.go_childItem = gohelper.findChild(categoryItemTable.go, "go_childcategory/go_childitem")
	categoryItemTable.childItemContainer = {}
	categoryItemTable.btnGO = gohelper.findChild(categoryItemTable.go, "clickArea")
	categoryItemTable.btn = gohelper.getClickWithAudio(categoryItemTable.go, AudioEnum.UI.play_ui_bank_open)
	categoryItemTable.tabId = 0

	categoryItemTable.btn:AddClickListener(function(categoryItemTable)
		local jumpTab = categoryItemTable.tabId

		self:_refreshTabs(jumpTab)
		StoreController.instance:onSwitchTab(jumpTab)
	end, categoryItemTable)
	table.insert(self._categoryItemContainer, categoryItemTable)
	gohelper.setActive(categoryItemTable.go_childItem, false)

	return categoryItemTable
end

function DecorateStoreView:_onRefreshRedDot()
	for _, v in pairs(self._categoryItemContainer) do
		local showReddot = StoreModel.instance:isTabSecondRedDotShow(v.tabId)

		gohelper.setActive(v.go_reddot, showReddot)
	end
end

function DecorateStoreView:_refreshGood(isUnfold)
	self:_refreshGoodDetail()
	self:_refreshGoodItems(isUnfold)
	self:_checkHideUI()
end

function DecorateStoreView:_checkHideUI()
	local versionStr = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateVersionShowList), "")
	local versionList = string.split(versionStr, "#")
	local versionId = CommandStationConfig.instance:getCurVersionId()
	local contain = LuaUtil.tableContains(versionList, tostring(versionId))

	if contain then
		return
	end

	table.insert(versionList, tostring(versionId))

	local resultStr = table.concat(versionList, "#")

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateVersionShowList), resultStr)

	local goods = DecorateStoreModel.instance:getDecorateGoodList(self._selectSecondTabId)

	if not goods or #goods < 1 then
		return
	end

	local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)
	local isHideType = DecorateStoreModel.instance:isAutoHideUIType(curItemType)

	if not isHideType then
		return
	end

	self:_hideUIShowDefaultView(true)
end

function DecorateStoreView:_refreshGoodItems(isUnfold)
	local goods = DecorateStoreModel.instance:getDecorateGoodList(self._selectSecondTabId)

	if not self._goodItems[self._selectSecondTabId] then
		self._goodItems[self._selectSecondTabId] = {}
		self._goodItems[self._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold] = {}
		self._goodItems[self._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold] = {}
	end

	for _, goods in pairs(self._goodItems) do
		for _, items in pairs(goods) do
			for _, item in pairs(items) do
				item:hide()
			end
		end
	end

	for index, v in ipairs(goods) do
		local foldGoods = self._goodItems[self._selectSecondTabId][DecorateStoreEnum.DecorateViewType.Fold]

		if not foldGoods[v.goodsId] then
			local path = self.viewContainer:getSetting().otherRes[6]
			local childGO = self:getResInst(path, self._goContent1, "good_" .. tostring(v.goodsId))

			foldGoods[v.goodsId] = DecorateGoodsItem.New()

			foldGoods[v.goodsId]:init(childGO, v)
		else
			foldGoods[v.goodsId]:reset(v)
		end

		foldGoods[v.goodsId]:setFold(true)
		foldGoods[v.goodsId]:playIn(index, isUnfold)
		gohelper.setSibling(foldGoods[v.goodsId].go, index)

		local unfoldGoods = self._goodItems[self._selectSecondTabId][DecorateStoreEnum.DecorateViewType.UnFold]

		if not unfoldGoods[v.goodsId] then
			local path = self.viewContainer:getSetting().otherRes[6]
			local childGO = self:getResInst(path, self._goContent2, "good_" .. tostring(v.goodsId))

			unfoldGoods[v.goodsId] = DecorateGoodsItem.New()

			unfoldGoods[v.goodsId]:init(childGO, v)
		else
			unfoldGoods[v.goodsId]:reset(v)
		end

		unfoldGoods[v.goodsId]:setFold(false)
		unfoldGoods[v.goodsId]:playIn(index, isUnfold)
		gohelper.setSibling(unfoldGoods[v.goodsId].go, index)
	end
end

function DecorateStoreView:_refreshGoodDetail()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local disCount = DecorateStoreModel.instance:getGoodDiscount(goodId)
	local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(goodId)
	local hasItem = DecorateStoreModel.instance:isDecorateGoodItemHas(goodId)
	local hasDiscount = disCount > 0 and disCount < 100 and offsetSecond > 0 and not hasItem

	gohelper.setActive(self._godiscounttip, hasDiscount)

	if hasDiscount then
		local limitTime = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txtdiscounttip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("decoratestore_discount_limittime"), {
			limitTime
		})
	end

	DecorateStoreModel.instance:setGoodRead(goodId)

	local curViewType = DecorateStoreModel.instance:getCurViewType()
	local isFold = curViewType == DecorateStoreEnum.DecorateViewType.Fold

	gohelper.setActive(self._goview1, isFold)
	gohelper.setActive(self._goview2, not isFold)
	gohelper.setActive(self._gocommon, isFold)
	gohelper.setActive(self._gotypebg3, false)
	self:_hideMainUI()

	local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)

	if curItemType ~= DecorateStoreEnum.DecorateItemType.Default and curItemType ~= DecorateStoreEnum.DecorateItemType.Icon then
		self:_hideDecorateDefault()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.SkinGift then
		self:_hideDecorateSkinGift()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.MainScene then
		self:_hideMainScene()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.Skin or not self._showLive2d then
		self:_hideDecorateSkin()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.SelfCard then
		self:_hideDecorateSelfCard()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.BuildingVideo then
		self:_hideDecorateBuildingVideo()
	end

	if curItemType ~= DecorateStoreEnum.DecorateItemType.DecorateBundle then
		self:_hideDecorateBundle()
	end

	if curItemType == DecorateStoreEnum.DecorateItemType.Default or curItemType == DecorateStoreEnum.DecorateItemType.Icon then
		self:_updateDecorateDefault()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.Skin then
		self:_updateDecorateSkin()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.MainScene then
		self:_updateDecorateMainScene()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.SelfCard then
		self:_updateDecorateSelfCard()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.BuildingVideo then
		self:_updateDecorateBuildingVideo()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.SkinGift then
		self:_updateDecorateSkinGift()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.SceneUIPackage then
		self:_updateDecorateSceneUIPackage()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.MainUISkin then
		self:_updateDecorateMainUISkin()
	elseif curItemType == DecorateStoreEnum.DecorateItemType.DecorateBundle then
		self:_updateDecorateBundle()
	end

	local btnCheckShow = curItemType == DecorateStoreEnum.DecorateItemType.SkinGift

	gohelper.setActive(self.btnCheck, btnCheckShow)
	gohelper.setActive(self.goTitleDesc, not btnCheckShow)
	self:_refreshCommonDetail()
	gohelper.setActive(self._goscene, curItemType == DecorateStoreEnum.DecorateItemType.SceneUIPackage)
end

function DecorateStoreView:_refreshCommonDetail()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	self._txtdec.text = decorateConfig.typeName
	self._txttitle.text = GameUtil.setFirstStrSize(goodMo.config.name, 100)

	local hasItem = DecorateStoreModel.instance:isDecorateGoodItemHas(goodId)

	if hasItem then
		gohelper.setActive(self._goowned, true)
		gohelper.setActive(self._btnbuy.gameObject, false)

		return
	end

	if goodMo.config.maxBuyCount > 0 and goodMo.buyCount >= goodMo.config.maxBuyCount then
		gohelper.setActive(self._goowned, true)
		gohelper.setActive(self._btnbuy.gameObject, false)

		return
	end

	gohelper.setActive(self._goowned, false)
	gohelper.setActive(self._btnbuy.gameObject, true)

	if decorateConfig.offTag > 0 then
		if not decorateConfig.offTag then
			local discount = 100
			local hasDiscount1 = discount > 0 and discount < 100

			if hasDiscount1 then
				self._txtdiscount.text = string.format("-%s%%", discount)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(goodId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(goodId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local hasDiscount = discount2 > 0 and discount2 < 100

			if hasDiscount then
				self._txtdiscount2.text = string.format("-%s%%", discount2)
			end

			gohelper.setActive(self._godiscount, hasDiscount1)
			gohelper.setActive(self._godiscount2, hasDiscount)

			if not goodMo.config.cost or goodMo.config.cost == "" then
				gohelper.setActive(self._gosingle, false)
				gohelper.setActive(self._godouble, false)
				gohelper.setActive(self._gofree, true)

				return
			end

			gohelper.setActive(self._gofree, false)

			local costs = string.splitToNumber(goodMo.config.cost, "#")

			if goodMo.config.cost2 ~= "" then
				gohelper.setActive(self._gosingle, false)
				gohelper.setActive(self._godouble, true)

				local priceCost1 = 0.01 * discount2 * costs[3]

				self._txtcurprice1.text = priceCost1

				if decorateConfig.originalCost1 > 0 and decorateConfig.originalCost1 ~= priceCost1 then
					gohelper.setActive(self._txtoriginalprice1.gameObject, true)

					self._txtoriginalprice1.text = decorateConfig.originalCost1
				else
					gohelper.setActive(self._txtoriginalprice1.gameObject, false)
				end

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagedoubleicon1, costCo.icon .. "_1", true)

				local cost2s = string.splitToNumber(goodMo.config.cost2, "#")
				local priceCost2 = 0.01 * discount2 * cost2s[3]

				self._txtcurprice2.text = priceCost2

				if decorateConfig.originalCost2 > 0 and decorateConfig.originalCost2 ~= priceCost2 then
					gohelper.setActive(self._txtoriginalprice2.gameObject, true)

					self._txtoriginalprice2.text = decorateConfig.originalCost2
				else
					gohelper.setActive(self._txtoriginalprice2.gameObject, false)
				end

				local cost2Co, _ = ItemModel.instance:getItemConfigAndIcon(cost2s[1], cost2s[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagedoubleicon2, cost2Co.icon .. "_1", true)
			else
				gohelper.setActive(self._gosingle, true)
				gohelper.setActive(self._godouble, false)

				self._txtcurprice.text = 0.01 * discount2 * costs[3]

				if decorateConfig.originalCost1 > 0 then
					gohelper.setActive(self._txtoriginalprice.gameObject, true)

					self._txtoriginalprice.text = decorateConfig.originalCost1
				else
					gohelper.setActive(self._txtoriginalprice.gameObject, false)
				end

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagesingleicon, costCo.icon .. "_1", true)
			end
		end
	end
end

function DecorateStoreView:_hideDecorateDefault()
	gohelper.setActive(self._gotypebg1, false)
	gohelper.setActive(self._gotypebg7, false)
end

function DecorateStoreView:_updateDecorateDefault()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if self:_checkEffectBigImg(decorateConfig) then
		self._simagetypebg7:LoadImage(ResUrl.getDecorateStoreImg(decorateConfig.biglmg))
		gohelper.setActive(self._gotypebg1, false)
		gohelper.setActive(self._gotypebg7, true)

		return
	end

	gohelper.setActive(self._gotypebg7, false)
	gohelper.setActive(self._gotypebg1, true)
	self._simagetypebg1:LoadImage(ResUrl.getDecorateStoreImg(decorateConfig.biglmg), self._onType1ImageLoaded, self)
end

function DecorateStoreView:_onType1ImageLoaded()
	self._simagetypebg1.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function DecorateStoreView:_checkEffectBigImg(decorateConfig)
	if not decorateConfig then
		local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)

		decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	end

	return decorateConfig and decorateConfig.effectbiglmg == 1
end

function DecorateStoreView:onDecorateSkinSelectItem(skinId, isAuto)
	self:refreshSkinPreview(skinId)

	if self.skinListComp then
		self.skinListComp:autoShowNextSkin(isAuto)
	end
end

function DecorateStoreView:_hideDecorateSkinGift()
	gohelper.setActive(self._gotype2, false)
	gohelper.setActive(self._btnswitch.gameObject, false)
	gohelper.setActive(self._godynamiccontainer, false)
	gohelper.setActive(self._gotypebg2, false)
	gohelper.setActive(self._gotype6, false)

	if self.skinListComp then
		self.skinListComp:onClose()
	end
end

function DecorateStoreView:_updateDecorateSkinGift()
	gohelper.setActive(self._btnswitch.gameObject, true)
	gohelper.setActive(self._godynamiccontainer, true)
	gohelper.setActive(self._gotypebg2, true)
	gohelper.setActive(self._gotype6, true)

	self.skinListComp = self.skinListComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._gotype6, DecorateStoreSkinListComp)

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local goodItemCos = string.splitToNumber(goodMo.config.product, "#")
	local list = DecorateSkinSelectListModel.instance:getSkinList(goodItemCos[2])

	self.skinListComp:setSkinList(list)

	local selectMo = self.skinListComp:getSelect()

	if selectMo then
		self:refreshSkinPreview(selectMo.id)
	end
end

function DecorateStoreView:_hideDecorateSkin()
	gohelper.setActive(self._gotype2, false)
	gohelper.setActive(self._btnswitch.gameObject, false)
	gohelper.setActive(self._godynamiccontainer, false)
	gohelper.setActive(self._gotypebg2, false)
	gohelper.setActive(self._gotype2, false)
end

function DecorateStoreView:_updateDecorateSkin()
	gohelper.setActive(self._btnswitch.gameObject, true)
	gohelper.setActive(self._godynamiccontainer, true)
	gohelper.setActive(self._gotypebg2, true)
	gohelper.setActive(self._gotype2, true)

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local goodItemCos = string.splitToNumber(goodMo.config.product, "#")

	self:refreshSkinPreview(goodItemCos[2])
end

function DecorateStoreView:refreshSkinPreview(skinId)
	self._skinCo = SkinConfig.instance:getSkinCo(skinId)

	local heroCo = lua_character.configDict[self._skinCo.characterId]

	self._txtrolename.text = heroCo.name

	self._simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))
	self:_refreshSmallSpine()
	self:_refreshBigSkin()
end

function DecorateStoreView:_refreshBigSkin()
	if not string.nilorempty(self._skinCo.live2dbg) then
		gohelper.setActive(self._simagel2d.gameObject, self._showLive2d)
		gohelper.setActive(self._gozs, self._showLive2d)
		self._simagel2d:LoadImage(ResUrl.getCharacterSkinLive2dBg(self._skinCo.live2dbg))
	else
		gohelper.setActive(self._simagel2d.gameObject, false)
		gohelper.setActive(self._gozs, false)
	end

	if self._showLive2d then
		if self._uiSpine then
			TaskDispatcher.cancelTask(self._playSpineVoice, self)
			self._uiSpine:onDestroy()
			self._uiSpine:stopVoice()

			self._uiSpine = nil
		end

		gohelper.setActive(self._gobigspine, true)

		self._uiSpine = GuiModelAgent.Create(self._gobigspine, true)

		self._uiSpine:setResPath(self._skinCo, self._onUISpineLoaded, self)

		local isLive2d = not string.nilorempty(self._skinCo.live2d)

		if isLive2d then
			self._uiSpine:setLive2dCameraLoadedCallback(self._live2DCameraLoaded, self)
		end

		self._txtswitch.text = luaLang("storeskinpreviewview_btnswitch")
	else
		gohelper.setActive(self._gobigspine, false)
		gohelper.setActive(self._simageskin.gameObject, true)
		self._simageskin:LoadImage(ResUrl.getHeadIconImg(self._skinCo.id), self._loadedImage, self)

		self._txtswitch.text = "L2D"
	end
end

function DecorateStoreView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)

	local offsetStr = self._skinCo.skinViewImgOffset

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simageskin.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simageskin.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	else
		recthelper.setAnchor(self._simageskin.transform, -150, -150)
		transformhelper.setLocalScale(self._simageskin.transform, 0.6, 0.6, 0.6)
	end

	if self._adjust then
		return
	end

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	local decorateOffsets = string.splitToNumber(decorateCo.decorateskinOffset, "#")

	recthelper.setAnchor(self._goskincontainer.transform, decorateOffsets[1] or 0, decorateOffsets[2] or 0)
	transformhelper.setLocalScale(self._goskincontainer.transform, decorateOffsets[3] or 1, decorateOffsets[3] or 1, decorateOffsets[3] or 1)
end

function DecorateStoreView:_live2DCameraLoaded()
	gohelper.setAsFirstSibling(self._simagel2d.gameObject)
end

function DecorateStoreView:_onUISpineLoaded()
	gohelper.setActive(self._simageskin.gameObject, false)
	ZProj.UGUIHelper.SetImageSize(self._simageskin.gameObject)
	self._uiSpine:setAllLayer(UnityLayer.SceneEffect)

	local offsetStr = self._skinCo.skinViewLive2dOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self._skinCo.characterViewOffset
	end

	local offsets = SkinConfig.instance:getSkinOffset(offsetStr)

	recthelper.setAnchor(self._gobigspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gobigspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))

	if self._adjust then
		return
	end

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	local decorateOffsets = string.splitToNumber(decorateCo.decorateskinl2dOffset, "#")

	recthelper.setAnchor(self._goskincontainer.transform, decorateOffsets[1] or 0, decorateOffsets[2] or 0)
	transformhelper.setLocalScale(self._goskincontainer.transform, decorateOffsets[3] or 1, decorateOffsets[3] or 1, decorateOffsets[3] or 1)
end

function DecorateStoreView:_refreshSmallSpine()
	self._smallSpine = self._smallSpine or GuiSpine.Create(self._gosmallspine, false)

	self._smallSpine:stopVoice()
	self._smallSpine:setResPath(ResUrl.getSpineUIPrefab(self._skinCo.spine), nil, nil, true)

	local offsets = SkinConfig.instance:getSkinOffset(self._skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gosmallspine.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gosmallspine.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function DecorateStoreView:_hideMainScene()
	if not self._needShowMainScene then
		return
	end

	self._needShowMainScene = false

	MainSceneSwitchCameraController.instance:hideScene()
	WeatherController.instance:onSceneShow()
	gohelper.setActive(self._gotype5, false)
	gohelper.setActive(self._rawImage, false)
	gohelper.setActive(self._gotypebg3, false)
end

function DecorateStoreView:_updateDecorateMainScene()
	self._sceneId = self:_getMainSceneId()

	if not self._sceneId then
		logError("DecorateStoreView:_updateDecorateMainScene sceneId is nil")

		return
	end

	gohelper.setActive(self._gotypebg3, false)

	self._needShowMainScene = true

	gohelper.setActive(self._rawImage, false)
	WeatherController.instance:onSceneHide()
	MainSceneSwitchCameraController.instance:showScene(self._sceneId, self._showSceneFinished, self)
end

function DecorateStoreView:_getMainSceneId()
	local goodsId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodsConfig = goodsId and lua_store_goods.configDict[goodsId]
	local product = goodsConfig and goodsConfig.product

	if not product then
		return nil
	end

	for i, v in ipairs(lua_scene_switch.configList) do
		if string.find(product, v.itemId) then
			return v.id
		end
	end

	return nil
end

function DecorateStoreView:_showSceneFinished(rt)
	gohelper.setActive(self._gotype5, true)

	if not self._weatherSwitchControlComp then
		self._weatherSwitchControlComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gotype5, WeatherSwitchControlComp)
		self._rawImage = gohelper.onceAddComponent(gohelper.findChild(self.viewGO, "Bg/typebg/#go_typebg3/mainscenebg"), gohelper.Type_RawImage)
	end

	gohelper.setActive(self._rawImage, true)
	gohelper.setActive(self._gotypebg3, true)
	MainSceneSwitchInfoDisplayView.adjustRt(self._rawImage, rt)
	self._weatherSwitchControlComp:updateScene(self._sceneId, MainSceneSwitchCameraDisplayController.instance)
end

function DecorateStoreView:_hideDecorateSelfCard()
	gohelper.setActive(self._gotypebg5, false)

	if self._viewGo then
		gohelper.destroy(self._viewGo)

		self._viewGo = nil
	end

	if self._viewCls then
		self._viewCls:onCloseInternal()

		self._viewCls = nil
	end

	if self._cardLoader then
		self._cardLoader:dispose()

		self._cardLoader = nil
	end
end

function DecorateStoreView:_updateDecorateSelfCard()
	self:_hideDecorateSelfCard()

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local goodItemCos = string.splitToNumber(goodMo.config.product, "#")
	local pathname = string.format("playercardview_%s", goodItemCos[2])

	self._cardPath = string.format("ui/viewres/player/playercard/%s.prefab", pathname)
	self._cardLoader = MultiAbLoader.New()

	self._cardLoader:addPath(self._cardPath)
	self._cardLoader:startLoad(self._onCardLoadFinish, self)
end

function DecorateStoreView:_onCardLoadFinish()
	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local goodMo = StoreModel.instance:getGoodsMO(goodId)
	local goodItemCos = string.splitToNumber(goodMo.config.product, "#")

	gohelper.setActive(self._gotypebg5, true)

	local assetItem = self._cardLoader:getAssetItem(self._cardPath)
	local viewPrefab = assetItem:GetResource(self._cardPath)

	self._viewGo = self._viewGo or gohelper.clone(viewPrefab, self._gotypebg5)
	self._viewCls = self._viewCls or MonoHelper.addNoUpdateLuaComOnceToGo(self._viewGo, StorePlayerCardView)
	self._viewCls.viewParam = {
		userId = PlayerModel.instance:getPlayinfo().userId
	}
	self._viewCls.viewContainer = self.viewContainer

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)
	local skinId = decorateConfig.showskinId

	self._viewCls:onOpen(skinId, goodItemCos[2])
	self._viewCls:backBottomView()
end

function DecorateStoreView:_hideDecorateBuildingVideo()
	gohelper.setActive(self._gotypebg6, false)

	if self._videoPlayer then
		self._videoPlayer:clear()

		self._videoPlayer = nil
	end
end

function DecorateStoreView:_hideDecorateBundle()
	gohelper.setActive(self._gotypebg8, false)
end

function DecorateStoreView:_updateDecorateBuildingVideo()
	gohelper.setActive(self._gotypebg6, true)

	if not self._videoPlayer then
		local parentGO = gohelper.findChild(self._gotypebg6, "#go_video")

		self._videoPlayer = VideoPlayerMgr.instance:createGoAndVideoPlayer(parentGO)
	end

	local goodId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)
	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	self._videoPlayer:play(decorateConfig.video, true, nil, nil)
end

function DecorateStoreView:onClose()
	UIBlockMgr.instance:endBlock("decorateswitch")
	UIBlockMgr.instance:endBlock("decoratehide")
	TaskDispatcher.cancelTask(self._switchTabRefresh, self)
	TaskDispatcher.cancelTask(self._startDefaultShowView, self)
	TaskDispatcher.cancelTask(self._startGoodIn, self)

	if self.skinListComp then
		self.skinListComp:onClose()
	end

	self:_removeEvents()
	self:_hideMainScene()
end

function DecorateStoreView:_getSceneGoodsSwitchCO(goodsId)
	local goodsConfig = goodsId and lua_store_goods.configDict[goodsId]
	local product = goodsConfig and goodsConfig.product

	if not product then
		return nil
	end

	for i, v in ipairs(lua_scene_switch.configList) do
		if string.find(product, v.itemId) then
			return v
		end
	end

	return lua_scene_switch.configDict[5]
end

function DecorateStoreView:_getUIGoodsSwitchCO(goodsId)
	local goodsConfig = goodsId and lua_store_goods.configDict[goodsId]
	local product = goodsConfig and goodsConfig.product

	if not product then
		return nil
	end

	for i, v in ipairs(lua_scene_ui.configList) do
		if string.find(product, v.itemId) then
			return v
		end
	end

	return lua_scene_ui.configDict[2]
end

function DecorateStoreView:_updateDecorateSceneUIPackage()
	local sceneCo = self:_getSceneGoodsSwitchCO(self._v3a4PackageGoodsIds[2])
	local UICo = self:_getUIGoodsSwitchCO(self._v3a4PackageGoodsIds[3])

	self._UIId = UICo.id
	self._sceneId = sceneCo.id

	local sceneItemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, sceneCo.itemId)
	local UIItemCo = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.Item, UICo.itemId)

	if sceneItemCo then
		self._txtbackgroundname.text = sceneItemCo.name or ""
	end

	if UIItemCo then
		self._txtframename.text = UIItemCo.name or ""
	end

	local sceneCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, sceneCo.itemId)
	local uiCount = ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, UICo.itemId)

	gohelper.setActive(self._gobackgroundreceive, sceneCount and sceneCount > 0)
	gohelper.setActive(self._goframereceive, uiCount and uiCount > 0)
	self:_showDecorateSceneUISkin()
end

function DecorateStoreView:_updateDecorateMainUISkin()
	local UICo = self:_getUIGoodsSwitchCO(self._v3a4PackageGoodsIds[3])

	self._UIId = UICo.id
	self._sceneId = MainSceneSwitchModel.instance:getCurSceneId()

	self:_showDecorateSceneUISkin()
end

function DecorateStoreView:_showDecorateSceneUISkin()
	if not self._sceneId then
		logError("DecorateStoreView:_updateDecorateMainScene sceneId is nil")

		return
	end

	gohelper.setActive(self._gotypebg3, false)

	self._needShowMainScene = true

	gohelper.setActive(self._rawImage, false)
	WeatherController.instance:onSceneHide()
	MainSceneSwitchCameraController.instance:showScene(self._sceneId, self._showSceneFinished, self)

	if self._mainUIView then
		self:_showMainUI()
	else
		self._gomainView = gohelper.findChild(self._gotypebg, "go_mainview")
		self._mainUIView = MonoHelper.addNoUpdateLuaComOnceToGo(self._gomainView, DecorateMainUIView)
		self._mainUIView.viewContainer = self.viewContainer
		self._mainUIView.viewName = self.viewName

		self:_showMainUI()
	end
end

function DecorateStoreView:_updateDecorateBundle()
	local goodsId = DecorateStoreModel.instance:getCurGood(self._selectSecondTabId)

	gohelper.setActive(self._gotypebg8, true)

	local bundleComp = DecorateStoreBundleComp.Get(self._gotypebg8)

	bundleComp:onUpdateMO(goodsId)
end

function DecorateStoreView:_checkMainUIScale(isHide)
	if not self._mainUIView then
		return
	end

	local curItemType = DecorateStoreModel.getItemType(self._selectSecondTabId)

	if curItemType == DecorateStoreEnum.DecorateItemType.SceneUIPackage or curItemType == DecorateStoreEnum.DecorateItemType.MainUISkin then
		self._mainUIView:refreshOffest(isHide)
	end
end

function DecorateStoreView:_showMainUI()
	gohelper.setActive(self._gomainView, true)
	self._mainUIView:showMainUI(self._UIId, 0.65, true)
end

function DecorateStoreView:_hideMainUI()
	gohelper.setActive(self._gomainView, false)

	if self._mainUIView then
		self._mainUIView:hideMainUI()
	end
end

function DecorateStoreView:onDestroyView()
	MainSceneSwitchCameraController.instance:clear()

	if self._goodItems then
		for _, goods in pairs(self._goodItems) do
			for _, items in pairs(goods) do
				for _, item in pairs(items) do
					item:destroy()
				end
			end
		end

		self._goodItems = nil
	end

	if self._categoryItemContainer and #self._categoryItemContainer > 0 then
		for i = 1, #self._categoryItemContainer do
			self._categoryItemContainer[i].btn:RemoveClickListener()
		end

		self._categoryItemContainer = nil
	end

	if self._mainUILoader then
		self._mainUILoader:dispose()

		self._mainUILoader = nil
	end
end

return DecorateStoreView
