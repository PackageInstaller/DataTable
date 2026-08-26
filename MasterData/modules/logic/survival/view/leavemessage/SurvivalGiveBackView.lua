-- chunkname: @modules/logic/survival/view/leavemessage/SurvivalGiveBackView.lua

module("modules.logic.survival.view.leavemessage.SurvivalGiveBackView", package.seeall)

local SurvivalGiveBackView = class("SurvivalGiveBackView", BaseView)

function SurvivalGiveBackView:onInitView()
	self.btnConfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Confirm")
	self.btn_close = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self.items = gohelper.findChild(self.viewGO, "#scroll_items")
	self.SurvivalGiveBackItem = gohelper.findChild(self.items, "Viewport/itemsContent/SurvivalGiveBackItem")
	self.go_survivalmapbaginfoview = gohelper.findChild(self.viewGO, "go_survivalmapbaginfoview")

	local param = SimpleListParam.New()

	param.cellClass = SurvivalGiveBackItem
	self.itemScroll = GameFacade.createSimpleListComp(self.items, param, self.SurvivalGiveBackItem, self.viewContainer)

	self.itemScroll:setOnClickItem(self.onClickItem, self)

	self.infoPanel = GameFacade.createLuaComp("survivalmapbaginfoview", self.go_survivalmapbaginfoview, SurvivalBagInfoPart, nil, self.viewContainer)

	self.infoPanel:updateMo()
end

function SurvivalGiveBackView:addEvents()
	self.addClickCb(self, self.btnConfirm, self.onClickBtnConfirm, self)
	self.addClickCb(self, self.btn_close, self.closeThis, self)
end

function SurvivalGiveBackView:onOpen()
	self.items = self.viewParam.items

	self.itemScroll:setData(self.items)
end

function SurvivalGiveBackView:onClose()
	return
end

function SurvivalGiveBackView:onDestroyView()
	return
end

function SurvivalGiveBackView:onClickModalMask()
	self:closeThis()
end

function SurvivalGiveBackView:onClickBtnConfirm()
	SurvivalWeekRpc.instance:sendSurvivalLossReturnRewardRequest()
	self:closeThis()
end

function SurvivalGiveBackView:onClickItem(survivalGiveBackItem)
	self.infoPanel:setCloseShow(true)
	self.infoPanel:updateMo(survivalGiveBackItem.survivalBagItemMo)
end

return SurvivalGiveBackView
