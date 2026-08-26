-- chunkname: @modules/logic/gift/view/GiftMultipleChoiceView.lua

module("modules.logic.gift.view.GiftMultipleChoiceView", package.seeall)

local GiftMultipleChoiceView = class("GiftMultipleChoiceView", BaseView)

function GiftMultipleChoiceView:onInitView()
	self._scrollitem = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_item")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txtquantity = gohelper.findChildText(self.viewGO, "root/quantity/#txt_quantity")
	self._simagebg1 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg1")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "root/bg/#simage_bg2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function GiftMultipleChoiceView:addEvents()
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self._btnclose:AddClickListener(self._btncloseClick, self)
end

function GiftMultipleChoiceView:removeEvents()
	self._btnok:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function GiftMultipleChoiceView:_btnokOnClick()
	local index = GiftModel.instance:getMultipleChoiceIndex()

	if index == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		self:closeThis()

		local data = {}
		local o = {}

		o.materialId = self.viewParam.param.id
		o.quantity = self.viewParam.quantity

		table.insert(data, o)
		ItemRpc.instance:sendUseItemRequest(data, index - 1)
	end
end

function GiftMultipleChoiceView:_btncloseClick()
	self:closeThis()
end

function GiftMultipleChoiceView:_editableInitView()
	self._contentGrid = gohelper.findChild(self.viewGO, "root/#scroll_item/itemcontent"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))

	self._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function GiftMultipleChoiceView:onOpen()
	self:_setPropItems()

	self._txtquantity.text = self.viewParam.quantity
end

function GiftMultipleChoiceView:onClose()
	GiftModel.instance:reset()
end

function GiftMultipleChoiceView:onClickModalMask()
	self:closeThis()
end

function GiftMultipleChoiceView:_setPropItems()
	local co = {}
	local gifts = string.split(ItemModel.instance:getItemConfig(self.viewParam.param.type, self.viewParam.param.id).effect, "|")

	self._contentGrid.enabled = #gifts < 6

	for k, v in ipairs(gifts) do
		local o = MaterialDataMO.New()
		local gift = string.split(v, "#")

		o.index = k
		o.materilType = tonumber(gift[1])
		o.materilId = tonumber(gift[2])
		o.quantity = self.viewParam.quantity * tonumber(gift[3])

		if GiftModel.instance:isGiftNeed(o.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(o.index)
		end

		table.insert(co, o)
	end

	GiftMultipleChoiceListModel.instance:setPropList(co)
end

function GiftMultipleChoiceView:onDestroyView()
	self._simagebg1:UnLoadImage()
	self._simagebg2:UnLoadImage()
end

return GiftMultipleChoiceView
