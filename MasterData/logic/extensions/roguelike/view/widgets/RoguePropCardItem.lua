-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/widgets/RoguePropCardItem.lua

module("logic.extensions.roguelike.view.widgets.RoguePropCardItem", package.seeall)

local M = class("RoguePropCardItem")

function M:ctor(compContainer)
	self._go = compContainer.gameObject
	self._viewElementsRegistry = ViewElementsRegistry.New(self._go.gameObject)
end

function M:Awake()
	self:onInit()
end

function M:setActive(isActive)
	goutil.setActive(self._go, isActive)
end

function M:onInit()
	local registry = self._viewElementsRegistry

	self._txtName = registry:findUIElement("vending_props_item_1839502272", UIComponentType.Text)
	self._txtContent = registry:findUIElement("vending_props_item_copy_1570206834", UIComponentType.TextMeshProUGUI)
	self._txtCost = registry:findUIElement("vending_props_item_50601994", UIComponentType.Text)
	self._costIcon1 = registry:findUIElement("vending_props_item_-1303357203", UIComponentType.Image)
	self._goSellOut = registry:findUIElement("vending_props_item_copy_2076481020")
	self._goSellOut2 = registry:findUIElement("vending_props_item_copy_1170804385")
	self._goNormal = registry:findUIElement("vending_props_item_copy_430316602")
	self._btnClick = UIComponentType.ButtonAdapter(registry:findUIElement("vending_props_item_copy_1679538622"))
	self._imgQuality = goutil.findChildImageComponent(self._go, "cell/backpack_item/imgQuality")
	self._imgIcon = goutil.findChildImageComponent(self._go, "cell/backpack_item/imgIcon")
	self._goItem = goutil.findChild(self._go, "cell/backpack_item")

	self._btnClick:AddClickListener(self._onClick, self)
end

function M:_onClick()
	if self._callback then
		self._callback()
	end
end

function M:updateData(data)
	self._callback = data.callback
	self._txtName.text = data.co.name
	self._txtCost.text = data.price
	self._txtContent.text = StringUtil.replaceAllGraphicTmpText(data.co.descirption)
	self._co = data.co

	local propCo = RoguelikeConfig.instance:getPropById(data.co.id)

	if propCo then
		IconLoader.setSprite(self._imgIcon, IconType.ItemIcon, propCo.art)
		IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(propCo.rarity + 1))
	end

	goutil.setActive(self._goSellOut, data.isTaken)
	goutil.setActive(self._goSellOut2, data.isTaken)
	goutil.setActive(self._goNormal, not data.isTaken)

	local costIcon = RoguelikeConst.costIcon

	goutil.setActive(self._goItem, true)
	self:setActive(true)
end

function M:OnDestroy()
	self._btnClick:RemoveClickListener()

	self._btnClick = nil
end

return M
