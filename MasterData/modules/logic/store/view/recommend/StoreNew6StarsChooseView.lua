-- chunkname: @modules/logic/store/view/recommend/StoreNew6StarsChooseView.lua

module("modules.logic.store.view.recommend.StoreNew6StarsChooseView", package.seeall)

local StoreNew6StarsChooseView = class("StoreNew6StarsChooseView", StoreRecommendBaseSubView)

function StoreNew6StarsChooseView:ctor(...)
	StoreNew6StarsChooseView.super.ctor(self, ...)

	self.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.New6StarsChoose)
end

function StoreNew6StarsChooseView:onInitView()
	self._txtduration = gohelper.findChildText(self.viewGO, "recommend/txt_tips/#txt_duration")
	self._imageAttr1 = gohelper.findChildImage(self.viewGO, "recommend/Name1/#image_Attr")
	self._txtName1 = gohelper.findChildText(self.viewGO, "recommend/Name1/#txt_Name")
	self._imageAttr2 = gohelper.findChildImage(self.viewGO, "recommend/Name2/#image_Attr")
	self._txtName2 = gohelper.findChildText(self.viewGO, "recommend/Name2/#txt_Name")
	self._imageAttr3 = gohelper.findChildImage(self.viewGO, "recommend/Name3/#image_Attr")
	self._txtName3 = gohelper.findChildText(self.viewGO, "recommend/Name3/#txt_Name")
	self._txtChar = gohelper.findChildText(self.viewGO, "recommend/image_Char/#txt_Char")
	self._txtProp = gohelper.findChildText(self.viewGO, "recommend/image_Prop/#txt_Prop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreNew6StarsChooseView:addEvents()
	return
end

function StoreNew6StarsChooseView:removeEvents()
	if self._clickBuy then
		self._clickBuy:RemoveClickListener()
	end
end

function StoreNew6StarsChooseView:_btnbuyOnClick()
	local var_5_0 = StatEnum.EventName.ClickRecommendPage
	local var_5_1 = {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store
	}

	var_5_1[StatEnum.EventProperties.RecommendPageId] = tostring((self.config or nil) and (self.config.id or ""))

	if self.config then
		var_5_1[StatEnum.EventProperties.RecommendPageName] = self.config.name or self.__cname
	end

	var_5_1[StatEnum.EventProperties.RecommendPageRank] = self:getTabIndex()

	StatController.instance:track(var_5_0, var_5_1)

	local jumpParams = string.splitToNumber(self.config.systemJumpCode, "#")

	if jumpParams[2] then
		local goodId = jumpParams[2]
		local packageMo = StoreModel.instance:getGoodsMO(goodId)

		StoreController.instance:openPackageStoreGoodsView(packageMo)
	else
		GameFacade.jumpByAdditionParam(self.config.systemJumpCode)
	end
end

function StoreNew6StarsChooseView:_editableInitView()
	StoreNew6StarsChooseView.super._editableInitView(self)

	local goBuyClick = gohelper.findChild(self.viewGO, "recommend/Buy")

	self._clickBuy = SLFramework.UGUI.UIClickListener.Get(goBuyClick)

	self._clickBuy:AddClickListener(self._btnbuyOnClick, self)
end

function StoreNew6StarsChooseView:onOpen()
	StoreNew6StarsChooseView.super.onOpen(self)
	self.addEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
	self:refreshUI()
end

function StoreNew6StarsChooseView:onClose()
	self.removeEventCb(self, StoreController.instance, StoreEvent.UpdatePackageStore, self.refreshUI, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshUI, self)
end

function StoreNew6StarsChooseView:refreshUI()
	self._txtduration.text = StoreController.instance:getRecommendStoreTime(self.config)
end

return StoreNew6StarsChooseView
