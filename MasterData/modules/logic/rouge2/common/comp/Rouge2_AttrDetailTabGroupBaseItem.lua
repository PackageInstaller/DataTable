-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttrDetailTabGroupBaseItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttrDetailTabGroupBaseItem", package.seeall)

local Rouge2_AttrDetailTabGroupBaseItem = class("Rouge2_AttrDetailTabGroupBaseItem", LuaCompBase)

function Rouge2_AttrDetailTabGroupBaseItem.Get(go, type)
	local cls = Rouge2_Enum.AttrDetailTabGroupCls[type]

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, cls)
end

function Rouge2_AttrDetailTabGroupBaseItem:ctor(type)
	self._type = type
end

function Rouge2_AttrDetailTabGroupBaseItem:init(go)
	self.go = go
	self._goSelect = gohelper.findChild(self.go, "go_Root/go_Select")
	self._txtSelectName = gohelper.findChildText(self.go, "go_Root/go_Select/txt_Name")
	self._goUnselect = gohelper.findChild(self.go, "go_Root/go_Unselect")
	self._txtUnselectName = gohelper.findChildText(self.go, "go_Root/go_Unselect/txt_Name")
	self._goArrowDown = gohelper.findChild(self.go, "go_Root/go_ArrowList/go_Arrow_Down")
	self._goArrowUp = gohelper.findChild(self.go, "go_Root/go_ArrowList/go_Arrow_Up")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "go_Root/btn_Click")
	self._goSubList = gohelper.findChild(self.go, "go_SubList")
	self._subTabItemList = {}

	gohelper.setActive(self.go, true)
	self:updateFold(true)
	self:onSelect(false)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttrDetailTabGroupBaseItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_AttrDetailTabGroupBaseItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_AttrDetailTabGroupBaseItem:_btnClickOnClick()
	local isFold = self._isFold

	self:updateFold(not isFold)

	if isFold and not self._isSelect then
		self._parentView:playSwitchAnim(self._dispatchEvent2SwitchTab, self)
	end
end

function Rouge2_AttrDetailTabGroupBaseItem:_dispatchEvent2SwitchTab()
	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectAttrTab, self._groupType, 1)
end

function Rouge2_AttrDetailTabGroupBaseItem:_onSelectAttrTab(groupIndex, subIndex)
	self:onSelect(groupIndex == self._groupType)
end

function Rouge2_AttrDetailTabGroupBaseItem:onUpdateMO(careerId, attrInfoList, groupType, parentView)
	self._careerId = careerId
	self._attrInfoList = attrInfoList
	self._groupType = groupType
	self._parentView = parentView

	self:refreshUI()
end

function Rouge2_AttrDetailTabGroupBaseItem:refreshUI()
	if self._groupType then
		local title = luaLang(Rouge2_Enum.AttrDetailTabGroupLangId[self._groupType])

		self._txtSelectName.text = self._groupType or ""
		self._txtUnselectName.text = self._groupType or ""

		self:refreshTabItemList()
		self:refreshArrow()
	end
end

function Rouge2_AttrDetailTabGroupBaseItem:refreshTabItemList()
	return
end

function Rouge2_AttrDetailTabGroupBaseItem:refreshArrow()
	if self._subTabItemList then
		if not #self._subTabItemList then
			local subTabItemNum = 0

			self._hasSubTabItem = subTabItemNum > 0

			gohelper.setActive(self._goArrowDown, self._hasSubTabItem and not self._isFold)
			gohelper.setActive(self._goArrowUp, self._hasSubTabItem and self._isFold)
		end
	end
end

function Rouge2_AttrDetailTabGroupBaseItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnselect, not isSelect)

	if isSelect then
		self:updateFold(false)
	end
end

function Rouge2_AttrDetailTabGroupBaseItem:updateFold(isFold)
	if not self._hasSubTabItem then
		isFold = true
	end

	self._isFold = isFold

	gohelper.setActive(self._goSubList, not isFold)
	self:refreshArrow()
end

return Rouge2_AttrDetailTabGroupBaseItem
