-- chunkname: @modules/logic/store/view/summonprop/SummonGiftPropBaseView.lua

module("modules.logic.store.view.summonprop.SummonGiftPropBaseView", package.seeall)

local SummonGiftPropBaseView = class("SummonGiftPropBaseView", BaseView)

function SummonGiftPropBaseView:onInitView()
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "root/info/#scroll_desc")
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/info/#scroll_desc/Viewport/Content/#txt_desc")
	self._scrollgift = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_gift")
	self._gogiftitem = gohelper.findChild(self.viewGO, "root/#scroll_gift/Viewport/Content/#go_giftitem")
	self._gohas = gohelper.findChild(self.viewGO, "root/#scroll_gift/Viewport/Content/#go_giftitem/#go_has")
	self._goempty = gohelper.findChild(self.viewGO, "root/#scroll_gift/Viewport/Content/#go_giftitem/#go_empty")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self._btnemptyTop = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyTop")
	self._btnemptyBottom = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyBottom")
	self._btnemptyLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyLeft")
	self._btnemptyRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyRight")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonGiftPropBaseView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self._btnemptyTop:AddClickListener(self._btnemptyTopOnClick, self)
	self._btnemptyBottom:AddClickListener(self._btnemptyBottomOnClick, self)
	self._btnemptyLeft:AddClickListener(self._btnemptyLeftOnClick, self)
	self._btnemptyRight:AddClickListener(self._btnemptyRightOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshGift, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshGift, self)
end

function SummonGiftPropBaseView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._btnemptyTop:RemoveClickListener()
	self._btnemptyBottom:RemoveClickListener()
	self._btnemptyLeft:RemoveClickListener()
	self._btnemptyRight:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self.refreshGift, self)
	self.removeEventCb(self, StoreController.instance, StoreEvent.StoreInfoChanged, self.refreshGift, self)
end

function SummonGiftPropBaseView:_btnCloseOnClick()
	self:closeThis()
end

function SummonGiftPropBaseView:_btnemptyTopOnClick()
	self:closeThis()
end

function SummonGiftPropBaseView:_btnemptyBottomOnClick()
	self:closeThis()
end

function SummonGiftPropBaseView:_btnemptyLeftOnClick()
	self:closeThis()
end

function SummonGiftPropBaseView:_btnemptyRightOnClick()
	self:closeThis()
end

function SummonGiftPropBaseView:_editableInitView()
	return
end

function SummonGiftPropBaseView:onUpdateParam()
	return
end

function SummonGiftPropBaseView:onOpen()
	if not self.viewParam then
		if self.viewParam == nil or self.viewParam.poolId == nil then
			logError("没有卡池礼包数据")

			return
		end

		self.poolId = self.viewParam.poolId

		self:refreshInfo()
		self:refreshGift()
	end
end

function SummonGiftPropBaseView:refreshInfo()
	return
end

function SummonGiftPropBaseView:refreshGift()
	local goodsMoList = StoreModel.instance:getSummonPoolPackageValidList(self.poolId)

	if not goodsMoList or next(goodsMoList) == nil then
		self:closeThis()

		return
	end

	local moList = {}
	local count = 0

	for _, goodsMo in ipairs(goodsMoList) do
		local mo = {}

		mo.goodsMo = goodsMo
		count = count + 1

		table.insert(moList, mo)

		if count >= StoreEnum.SummonPoolPackageMinCount then
			break
		end
	end

	if count < StoreEnum.SummonPoolPackageMinCount then
		for i = count + 1, StoreEnum.SummonPoolPackageMinCount do
			local mo = {}

			table.insert(moList, mo)
		end
	end

	gohelper.CreateObjList(self, self.onItemShow, moList, nil, self._gogiftitem, SummonGiftPropGoodsItem)
end

function SummonGiftPropBaseView:onItemShow(item, data, index)
	item:setView(self)
	item:onUpdateMO(data)
end

function SummonGiftPropBaseView:onClose()
	StoreController.instance:clearMarkedPackageGoodsRedDot()
end

function SummonGiftPropBaseView:onDestroyView()
	return
end

return SummonGiftPropBaseView
