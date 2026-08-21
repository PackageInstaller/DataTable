-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/cellcomponent/ItemCellComponet.lua

module("logic.extensions.backpack.cellcomponent.ItemCellComponet", package.seeall)

local ButtonAdapter = Astral.ButtonAdapter
local M = class("ItemCellComponet", CellBaseComponent)

function M:ctor(cell)
	M.super.ctor(self, cell)

	self._qualityFrame = nil
	self._iconImg = nil
	self._btnClick = nil
	self._isNameTextActive = nil
	self._redPointType = CommEnum.RedPointIconType.weak
end

function M:onInit()
	local registry = self._cell:getViewElementsRegistry()

	self._qualityFrame = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._iconImg = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._imgHeroIcon = registry:findUIElement("backpack_item_-723704209", UIComponentType.Image)
	self._goSelect1 = registry:findUIElement("backpack_item_-2022575790")
	self._goSelect2 = registry:findUIElement("backpack_item_506657149")
	self._clickGO = registry:findUIElement("rewards_detail_item_1370605741")
	self._btnClick = ButtonAdapter.Get(self._clickGO)

	self._btnClick:AddClickListener(self._clickSelf, self)

	self._longPressTrigger = OnceLongPressTrigger.Get(self._clickGO)

	self._longPressTrigger:AddLongPressListener(self._onOnceLongPressSelf, self)

	self._clickEffectGo = registry:findUIElement("backpack_item_-402278925")
	self._clickEffect = self._clickEffectGo:GetComponent(ComponentType.Animation)
	self._redPoint1 = registry:findUIElement("2&new_sigh_291166182")
	self._redPoint2 = registry:findUIElement("1&red_point_-1414002736")

	goutil.setActive(self._clickEffectGo, true)
end

function M:_clickSelf()
	if self._clickCallback then
		self._clickCallback(self._clickHandler, self._cell)
	else
		self._cell:dealSelect()
	end
end

function M:_onOnceLongPressSelf(isOn, x, y)
	if self._onceLongPressCallback then
		self._onceLongPressCallback(self._onceLongPressHandler, self._cell)
	end
end

function M:updateData(data)
	if not data then
		return
	end

	local itemInfo = data:getItemInfo()

	self:setIconSprite(data)
	IconLoader.setSprite(self._qualityFrame, IconType.Skinlib, GameUrl.getItemQualityUrl(data:getQuality()))

	local go = self._cell:getCompContainer().gameObject

	if go and data.getItemId then
		go.name = data:getItemId()
	end
end

function M:setIconSprite(data)
	local icon = data:getIcon()
	local itemTypeEnum = data:getType()
	local subTypeEnum = data:getSubType()
	local isHero = itemTypeEnum == GameEnum.ItemTypeEnum.HeroType

	goutil.setActive(self._imgHeroIcon.gameObject, isHero)
	goutil.setActive(self._iconImg.gameObject, not isHero)

	if string.nilorempty(icon) then
		return
	end

	local img = isHero and self._imgHeroIcon or self._iconImg

	IconLoader.setSpriteByItemType(img, itemTypeEnum, icon, nil, nil, subTypeEnum)
end

function M:setIconImgActive(isActive)
	self._iconImg.gameObject:SetActive(isActive)
end

function M:setQualityImgActive(isActive)
	self._qualityFrame.gameObject:SetActive(isActive)
end

function M:getItemSelect()
	return self._goSelect1.activeSelf or self._goSelect2.activeSelf
end

function M:setItemSelect(isSelect)
	goutil.setActive(self._goSelect1, false)
	goutil.setActive(self._goSelect2, isSelect)
end

function M:setClickListener(callback, handler)
	self._clickCallback = callback
	self._clickHandler = handler
end

function M:setOnceLongPressListener(callback, handler)
	self._onceLongPressCallback = callback
	self._onceLongPressHandler = handler
end

function M:btnListener(bind)
	if bind then
		self._btnClick:AddClickListener(self._clickSelf, self)
		self._longPressTrigger:AddLongPressListener(self._onOnceLongPressSelf, self)
	else
		self._btnClick:RemoveClickListener()
		self._longPressTrigger:RemoveLongPressListener()
	end
end

function M:adjustClickArea()
	return
end

function M:setClickHeight(v)
	goutil.setHeight(self._clickGO.transform, v)
end

function M:playClickEffect()
	self._clickEffect:Play("backpack_item_whiteopen")
end

function M:onDestroy()
	M.super.onDestroy(self)
	self._btnClick:RemoveClickListener()

	self._clickCallback = nil
	self._clickHandler = nil

	if self._longPressTrigger then
		self._longPressTrigger:RemoveLongPressListener()
	end

	self._longPressTrigger = nil
	self._onceLongPressCallback = nil
	self._onceLongPressHandler = nil
end

function M:setRedPointType(RedPointIconType)
	self._redPointType = RedPointIconType
end

function M:hideRed()
	goutil.setActive(self._redPoint1, false)
	goutil.setActive(self._redPoint2, false)
end

function M:getRedPoint()
	if self._redPointType == CommEnum.RedPointIconType.New then
		goutil.setActive(self._redPoint2, false)

		return self._redPoint1
	else
		goutil.setActive(self._redPoint1, false)

		local trs = self._redPoint2.transform
		local childRed1 = trs:Find("type1").gameObject
		local childRed2 = trs:Find("type3").gameObject

		goutil.setActive(trs:Find("type2").gameObject, false)

		if self._redPointType == CommEnum.RedPointIconType.Strong then
			goutil.setActive(childRed2, true)
			goutil.setActive(childRed1, false)
		else
			goutil.setActive(childRed1, true)
			goutil.setActive(childRed2, false)
		end

		return self._redPoint2
	end
end

return M
