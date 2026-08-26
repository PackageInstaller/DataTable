-- chunkname: @modules/logic/gift/view/OptionalGiftMultipleChoiceView.lua

module("modules.logic.gift.view.OptionalGiftMultipleChoiceView", package.seeall)

local OptionalGiftMultipleChoiceView = class("OptionalGiftMultipleChoiceView", GiftMultipleChoiceView)

function OptionalGiftMultipleChoiceView:_btnokOnClick()
	local index = GiftModel.instance:getMultipleChoiceIndex()

	if index == 0 then
		GameFacade.showToast(ToastEnum.GiftMultipleChoice)
	else
		local id = GiftModel.instance:getMultipleChoiceId()

		self:closeThis()

		local data = {}
		local o = {}

		o.materialId = self.viewParam.param.id
		o.quantity = self.viewParam.quantity

		table.insert(data, o)
		ItemRpc.instance:sendUseItemRequest(data, id)
	end
end

function OptionalGiftMultipleChoiceView:_setPropItems()
	local co = {}

	self.giftIds = GiftMultipleChoiceListModel.instance:getOptionalGiftIdList(self.viewParam.param.id)
	self._contentGrid.enabled = #self.giftIds < 6

	for index, id in ipairs(self.giftIds) do
		local o = MaterialDataMO.New()

		o.index = index
		o.materilType = 1
		o.materilId = id
		o.quantity = self.viewParam.quantity * 1

		if GiftModel.instance:isGiftNeed(o.materilId) then
			GiftModel.instance:setMultipleChoiceIndex(index)
			GiftModel.instance:setMultipleChoiceId(id)
		end

		table.insert(co, o)
	end

	GiftMultipleChoiceListModel.instance:setPropList(co)
end

return OptionalGiftMultipleChoiceView
