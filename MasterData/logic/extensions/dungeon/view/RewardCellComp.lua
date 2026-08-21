-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dungeon/view/RewardCellComp.lua

module("logic.extensions.dungeon.view.RewardCellComp", package.seeall)

local M = class("RewardCellComp", CellBaseComponent)
local noShowItemTypeList = {
	GameEnum.ItemTypeEnum.EchoItemType,
	GameEnum.ItemTypeEnum.HeroType,
	GameEnum.ItemTypeEnum.HeroItemType,
	GameEnum.ItemTypeEnum.HeroSkin,
	GameEnum.ItemTypeEnum.ProtomerItemType,
	GameEnum.ItemTypeEnum.DisplayCard,
	GameEnum.ItemTypeEnum.Portrait,
	GameEnum.ItemTypeEnum.DiceItem
}

function M:ctor(cell)
	M.super.ctor(self, cell)
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._itemGo = registry:findUIElement("rewards_detail_item_2141037416")
	self._selectObj = registry:findUIElement("backpack_item_-2022575790")
	self._imgQuality = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._imgIcon = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._imgHeroIcon = registry:findUIElement("backpack_item_-723704209", UIComponentType.Image)
	self._noneGo = registry:findUIElement("backpack_item_1035325593")
	self._countTxt = registry:findUIElement("backpack_item_977509436", UIComponentType.Text)
	self._countGo = registry:findUIElement("backpack_item_-2077706482")
	self._btnSelect = OnceLongPressTrigger.Get(registry:findUIElement("rewards_detail_item_1370605741"))

	self._btnSelect:AddClickListener(self._clickSelect, self)

	self._rewardCanGotGo = registry:findUIElement("backpack_item_2142689521")
	self._level = registry:findUIElement("backpack_item_108093803")
	self._levelText = goutil.findChildTextComponent(self._level, "txtNum")
	self._nameText = registry:findUIElement("backpack_item_241486979", UIComponentType.Text)
	self._nameGo = registry:findUIElement("backpack_item_1238128537")

	local oldNameGo = registry:findUIElement("backpack_item_372005575")

	goutil.setActive(oldNameGo, false)

	self._isFackD6 = false
end

function M:_clickSelect()
	if self._itemCode == 0 then
		return
	end

	if self._clickCallBackFunc then
		local ifContinue = self._clickCallBackFunc(self._clickCallBackObj)

		if not ifContinue then
			return
		end
	end

	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_generic_select, nil, nil, nil)

	local count = ItemModel.instance:getItemCountByItemId(self._itemCode)
	local itemData = ItemUtil.createItemData({
		itemId = self._itemCode
	})

	itemData:setCount(count)

	local isPassEvent = true
	local data = ToolTipsUtil.createItemTipsData(itemData, self._itemGo, isPassEvent)

	if ItemUtil.isCharacterById(self._itemCode) then
		CharacterUtil.openCharacterPreviewView(self._itemCode)
	elseif itemData:getType() == GameEnum.ItemTypeEnum.DiceItem and self._isFackD6 then
		itemData:addFackAttr(EquipEnum.FackAttrType.ShowType)
		GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, self._itemGo, nil, true, true, false, false)
	else
		GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, self._itemGo, nil, true, true, false, false)
	end
end

function M:updateData(rewardData)
	self._itemCode = rewardData.code
	self._count = rewardData.count
	self._name = rewardData.name
	self._rewardStatus = rewardData.rewardStatus

	if rewardData.clickCallBack then
		self._clickCallBackFunc = rewardData.clickCallBack
		self._clickCallBackObj = rewardData.clickCallBackObj
	end

	if self._itemCode == 0 then
		goutil.setActive(self._imgQuality.gameObject, false)
		goutil.setActive(self._imgIcon.gameObject, false)
		goutil.setActive(self._imgHeroIcon.gameObject, false)
		goutil.setActive(self._countGo, false)
		goutil.setActive(self._noneGo, true)

		return
	end

	goutil.setActive(self._rewardCanGotGo, self._rewardStatus == CommEnum.RewardEnum.CanGot)
	goutil.setActive(self._imgQuality.gameObject, true)
	goutil.setActive(self._countGo, self._count)
	goutil.setActive(self._countTxt.gameObject, self._count)
	goutil.setActive(self._noneGo, false)

	local itemCo = BackpackConfig.instance:getItemInfoByItemId(self._itemCode)

	self._nameText.text = self._name

	goutil.setActive(self._nameGo, not string.nilorempty(self._name))

	self._countTxt.text = self._count and self._count or ""

	if not itemCo then
		printWarn("找不到物品配置", self._itemCode)

		return
	end

	if table.indexof(noShowItemTypeList, itemCo.type) then
		goutil.setActive(self._countGo, false)
		goutil.setActive(self._countTxt.gameObject, false)
	end

	local quality = GameEnum.QualityEnum.A
	local icon = "1001001"

	if itemCo.type == GameEnum.ItemTypeEnum.PrefabItem then
		local itemData = ItemUtil.createItemData({
			count = 0,
			itemId = self._itemCode
		})

		quality = itemData:getQuality()
		icon = itemData:getIcon()
	else
		quality = itemCo.quality
		icon = ItemUtil.getItemCoIcon(itemCo)
	end

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, CommEnum.Quality2ItemBg[quality])

	local iconImg = itemCo.type == GameEnum.ItemTypeEnum.HeroType and self._imgHeroIcon or self._imgIcon

	goutil.setActive(self._imgIcon.gameObject, itemCo.type ~= GameEnum.ItemTypeEnum.HeroType)
	goutil.setActive(self._imgHeroIcon.gameObject, itemCo.type == GameEnum.ItemTypeEnum.HeroType)
	IconLoader.setSpriteByItemType(iconImg, itemCo.type, icon, nil, nil, itemCo.subType)
end

function M:showName(isShow)
	goutil.setActive(self._nameGo, isShow)

	if isShow then
		self._nameText.text = self._name
	end
end

function M:setIsFackD6(isFack)
	self._isFackD6 = isFack
end

return M
