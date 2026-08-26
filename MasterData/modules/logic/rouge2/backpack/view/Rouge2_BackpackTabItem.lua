-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTabItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTabItem", package.seeall)

local Rouge2_BackpackTabItem = class("Rouge2_BackpackTabItem", LuaCompBase)

function Rouge2_BackpackTabItem:ctor(view)
	self._view = view
	self._container = view and view.viewContainer
end

function Rouge2_BackpackTabItem:init(go)
	self.go = go
	self._goUnSelected = gohelper.findChild(self.go, "#go_UnSelected")
	self._txtTabName = gohelper.findChildText(self.go, "#go_UnSelected/#txt_TabName")
	self._imageIcon = gohelper.findChildImage(self.go, "#go_UnSelected/image_Icon")
	self._goSelected = gohelper.findChild(self.go, "#go_Selected")
	self._txtTabName2 = gohelper.findChildText(self.go, "#go_Selected/#txt_TabName")
	self._txtTabNameEn2 = gohelper.findChildText(self.go, "#go_Selected/#txt_TabNameEn")
	self._imageIcon2 = gohelper.findChildImage(self.go, "#go_Selected/image_Icon")
	self._goReddot = gohelper.findChild(self.go, "#go_Reddot")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "#btn_Click", AudioEnum.Rouge2.ClickBagTab)
	self._isSelected = false
end

function Rouge2_BackpackTabItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, self._container, ViewEvent.ToSwitchTab, self._toSwitchTab, self)
end

function Rouge2_BackpackTabItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackTabItem:_btnClickOnClick()
	self._container:switchTab(self._type)
end

function Rouge2_BackpackTabItem:onUpdateMO(backpackType)
	self._type = backpackType

	if Rouge2_Enum.BagTabType2Reddot[backpackType] then
		RedDotController.instance:addRedDot(self._goReddot, Rouge2_Enum.BagTabType2Reddot[backpackType])
	end

	self._isSelected = self._container:getCurSelectType() == self._type

	self:refreshUI()
end

function Rouge2_BackpackTabItem:refreshUI()
	gohelper.setActive(self._goSelected, self._isSelected)
	gohelper.setActive(self._goUnSelected, not self._isSelected)

	local tabName, tabNameEn = self:_getTabName()

	self._txtTabName.text = tabName
	self._txtTabName2.text = tabName
	self._txtTabNameEn2.text = tabNameEn
end

function Rouge2_BackpackTabItem:_getTabName()
	local langId = Rouge2_Enum.BagTabTypeNameLangId[self._type]
	local tabName = luaLang(langId)
	local tabNameEn = Rouge2_Enum.BagTabTypeNameEn[self._type]

	return tabName, tabNameEn
end

function Rouge2_BackpackTabItem:_toSwitchTab(tabContainerId, tabId)
	if tabContainerId ~= Rouge2_Enum.BackpackTabContainerId then
		return
	end

	self._isSelected = tabId == self._type

	self:refreshUI()
end

function Rouge2_BackpackTabItem:onDestroy()
	return
end

return Rouge2_BackpackTabItem
