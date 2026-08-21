-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveEchoCutlinePreviewItemView.lua

module("logic.extensions.retrieve.view.RetrieveEchoCutlinePreviewItemView", package.seeall)

local M = class("RetrieveEchoCutlinePreviewItemView")
local ButtonAdapter = Astral.ButtonAdapter

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go)
end

function M:Awake()
	self._txtName = self._viewElementsRegistry:findUIElement("retrieve_echo_preview_item_1008636234", UIComponentType.Text)
	self._itemCellGo = self._viewElementsRegistry:findUIElement("0&rewards_detail_item_2141037416")

	goutil.setActive(self._itemCellGo, true)

	self._itemSource = Astral.LuaComponentContainer.Add(self._itemCellGo, ItemCell)

	self._itemSource:Awake()
	self._itemSource:getComponent("num"):setVisible(false)
	self._itemSource:setShowSelectedEffect(false)
	self._itemSource:setShowTipsPassEvent(false)

	self._upGo = self._viewElementsRegistry:findUIElement("retrieve_echo_preview_item_687596252")
	self._wishGo = self._viewElementsRegistry:findUIElement("retrieve_echo_preview_item_-936967837")

	goutil.setActive(self._wishGo, false)
	goutil.setActive(self._txtName.gameObject, true)
end

function M:onEnter()
	return
end

function M:onExit()
	return
end

function M:_updateView(data, curType, lotteryData)
	self._type = curType
	self._data = data

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(data.itemCode)

	if itemCo then
		self._txtName.text = itemCo.name
	end

	goutil.setActive(self._upGo, LotteryUtil.isProbabilityUp(data))

	local itemData = ItemUtil.createItemData({
		count = 0,
		itemId = tonumber(data.itemCode)
	})

	self._itemSource:updateData(itemData)
	goutil.setActive(self._wishGo, lotteryData and data.itemCode == lotteryData:getPicked())
end

function M:showPreviewView()
	goutil.setActive(self._upGo, false)
	goutil.setActive(self._txtName.gameObject, false)
end

function M:OnDestroy()
	self._viewElementsRegistry:cleanRegistry()

	self._viewElementsRegistry = nil
end

return M
