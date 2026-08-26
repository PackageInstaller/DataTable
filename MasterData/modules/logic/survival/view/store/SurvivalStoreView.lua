-- chunkname: @modules/logic/survival/view/store/SurvivalStoreView.lua

module("modules.logic.survival.view.store.SurvivalStoreView", package.seeall)

local SurvivalStoreView = class("SurvivalStoreView", BaseView)

function SurvivalStoreView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollstore = gohelper.findChild(self.viewGO, "mask/#scroll_store")
	self._gostoregoodsitem = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem")
	self._golimit = gohelper.findChild(self.viewGO, "mask/#scroll_store/Viewport/#go_Content/#go_storeItem/#go_storegoodsitem/go_tag/#go_limit")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._gotag = gohelper.findChild(self.viewGO, "Tag2")
	self._gotaglimit = gohelper.findChild(self.viewGO, "Tag2/#go_taglimit")
	self._txtlimit = gohelper.findChildText(self.viewGO, "Tag2/#go_taglimit/#txt_limit")
	self._txtTagName = gohelper.findChildText(self.viewGO, "Tag2/txt_tagName")
	self._gotaskReddot = gohelper.findChild(self.viewGO, "#btn_Task/#go_taskReddot")

	local param = GameFacade.createSimpleListParam(SurvivalStoreItem)

	self.storeList = GameFacade.createSimpleListComp(self._scrollstore, param, nil, self.viewContainer)
end

function SurvivalStoreView:addEvents()
	self.addEventCb(self, SurvivalStoreController.instance, SurvivalEvent.OnSurvivalOutsideShopBuyReply, self.onReceiveSurvivalOutSideClientDataReply, self)
end

function SurvivalStoreView:onReceiveSurvivalOutSideClientDataReply()
	self:refreshStore()
end

function SurvivalStoreView:onOpen()
	self:refreshStore()
end

function SurvivalStoreView:refreshStore()
	local goods = SurvivalStoreModel.instance:getGoodsMos()

	self.storeList:setData({
		{
			goods = goods
		}
	})
end

return SurvivalStoreView
