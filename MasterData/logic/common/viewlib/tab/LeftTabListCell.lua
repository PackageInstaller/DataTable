-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/viewlib/tab/LeftTabListCell.lua

module("logic.common.viewlib.tab.LeftTabListCell", package.seeall)

local M = class("LeftTabListCell")

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._go = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._go)
	self._mo = nil
end

function M:Awake()
	self.toggleTab = self._go:GetComponent(UIComponentType.SpaceXToggle)
	self.go_red_point = self._registry:findUIElement("0&red_point_-1414002736")
	self.img_imgIcon = self._registry:findUIElement("left_tab_list_item_1298387400", UIComponentType.Image)
	self.text_txtTitle = self._registry:findUIElement("left_tab_list_item_-1686091243", UIComponentType.Text)
	self.go_left_tab_list_item = self._registry:findUIElement("left_tab_list_item_-51389005")
	self.go_iconGo = self._registry:findUIElement("left_tab_list_item_1943519541")
	self.img_selectImgIcon = self._registry:findUIElement("left_tab_list_item_1522314410", UIComponentType.Image)
	self.go_selectIconGo = self._registry:findUIElement("left_tab_list_item_-1042043222")
	self.text_selelctTitle = self._registry:findUIElement("left_tab_list_item_278459844", UIComponentType.Text)
end

function M:updateData(tabMo)
	if not tabMo then
		return
	end

	self._mo = tabMo

	self:_updateName(tabMo)
	self:_updateIcon(tabMo)
	self:_updateRedDot(tabMo)
end

function M:_updateName(tabMo)
	self.text_txtTitle.text = tabMo:getTabName()
	self.text_selelctTitle.text = tabMo:getTabName()
end

function M:_updateIcon(tabMo)
	local iconType = tabMo:getIconType()
	local tabIcon = tabMo:getTabIcon()

	goutil.setActive(self.go_iconGo, iconType and not string.nilorempty(tabIcon))
	goutil.setActive(self.go_selectIconGo, iconType and not string.nilorempty(tabIcon))

	if not iconType or string.nilorempty(tabIcon) then
		return
	end

	IconLoader.setSprite(self.img_imgIcon, iconType, tabIcon)
	IconLoader.setSprite(self.img_selectImgIcon, iconType, tabIcon)
end

function M:_updateRedDot(tabMo)
	local redDotKeyList = tabMo:getRedDotKeyList()

	if not redDotKeyList then
		return
	end

	RedDotModel.instance:createDotView({
		dotNode = self.go_red_point,
		keyList = redDotKeyList,
		parentKeyList = tabMo:getRedDotParentKeyList()
	})
end

function M:getToggleTab()
	return self.toggleTab
end

function M:spawn()
	self:_setVisible(true)
end

function M:recycle()
	self.toggleTab:RemoveListener()
	self:_setVisible(false)
end

function M:_setVisible(value)
	goutil.setActive(self._go, value)
end

function M:isVisible()
	return self._go and self._go.activeSelf
end

function M:OnDestroy()
	self._compContainer = nil
	self._go = nil
	self._registry = nil
	self._mo = nil
end

return M
