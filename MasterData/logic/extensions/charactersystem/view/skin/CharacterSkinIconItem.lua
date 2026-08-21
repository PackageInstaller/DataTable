-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/skin/CharacterSkinIconItem.lua

module("logic.extensions.charactersystem.view.skin.CharacterSkinIconItem", package.seeall)

local M = class("CharacterSkinIconItem")
local ColorWhite = "#FFFFFFFF"
local ColorGray = "#FFFFFF33"

function M:ctor(simpleLuaComponentContainer)
	self._luaContainer = simpleLuaComponentContainer
	self._go = self._luaContainer.gameObject
end

function M:Awake()
	self:_resetFields()
	self:_buildUI()
	self:_setUIEvent(true)
end

function M:_resetFields()
	self._handle = nil
	self._heroSkinData = nil
end

function M:updateData(data)
	self._heroSkinData = data

	self:_updateItem()
end

function M:OnDestroy()
	self:_setUIEvent(false)

	self._luaContainer = nil
	self._go = nil

	self:_resetFields()
end

function M:_buildUI()
	local registry = ViewElementsRegistry.New(self._go)

	self._imgSkin = registry:findUIElement("backpack_item_-723704209", UIComponentType.Image)
	self._imgQuality = registry:findUIElement("rewards_detail_item_868117965", UIComponentType.Image)
	self._btnItem = registry:findUIElement("rewards_detail_item_1370605741", UIComponentType.ButtonAdapter)
	self._imgItemSkin = registry:findUIElement("rewards_detail_item_-2041880288", UIComponentType.Image)
	self._goHead = goutil.findChild(self._go, "headScale")
	self._goSelect = registry:findUIElement("backpack_item_506657149")
	self._goWearing = goutil.findChild(self._go, "stateWearing")
	self._goLock = goutil.findChild(self._go, "imgLock")
end

function M:_setUIEvent(isOn)
	if isOn then
		self._btnItem:AddClickListener(self._onClickItem, self)
	else
		self._btnItem:RemoveClickListener()
	end
end

function M:_updateItem()
	local isDefaultSkin = self._heroSkinData:getIsDefault()
	local isUnlock = self._heroSkinData:getIsUnlock()

	goutil.setActive(self._goWearing, self._heroSkinData:getIsWear())
	goutil.setActive(self._goHead, false)
	goutil.setActive(self._imgItemSkin.gameObject, true)
	goutil.setActive(self._goLock, not isUnlock)

	if isDefaultSkin then
		local defaultSkinIcon = ConstConfig.instance:getStrValueByKey(ConstConfigKeyEnum.HeroDefaultSkinIcon)

		IconLoader.setSprite(self._imgItemSkin, IconType.ItemIcon, defaultSkinIcon, self._loadIconCallBack, self)
	else
		IconLoader.setSprite(self._imgItemSkin, IconType.ItemIcon, self._heroSkinData:getIcon(), self._loadIconCallBack, self)
	end

	IconLoader.setSprite(self._imgQuality, IconType.Skinlib, GameUrl.getItemQualityUrl(self._heroSkinData:getQuality()))

	if isUnlock then
		self._imgItemSkin.material = nil
		self._imgItemSkin.color = parsecolor(ColorWhite)
	else
		local grayMat = CommonPreloader.instance:getMaterialsCommAsset(CommonResPath.UIGray)

		self._imgItemSkin.material = grayMat
		self._imgItemSkin.color = parsecolor(ColorGray)
	end
end

function M:_loadIconCallBack()
	self._imgItemSkin.color = self._heroSkinData:getIsUnlock() and parsecolor(ColorWhite) or parsecolor(ColorGray)
end

function M:_onClickItem()
	self._handle:onClickSkinItem(self._heroSkinData)
end

function M:setHandler(handle)
	self._handle = handle
end

function M:setSelect(isSelected)
	goutil.setActive(self._goSelect, isSelected)
end

return M
