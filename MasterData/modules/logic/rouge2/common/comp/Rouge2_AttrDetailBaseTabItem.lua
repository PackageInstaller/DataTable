-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttrDetailBaseTabItem.lua

local Rouge2_AttrDetailBaseTabItem = class("Rouge2_AttrDetailBaseTabItem", LuaCompBase)

function Rouge2_AttrDetailBaseTabItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
	self._goSelect = gohelper.findChild(self.go, "go_Root/go_Select")
	self._goUnselect = gohelper.findChild(self.go, "go_Root/go_Unselect")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "go_Root/btn_Click")

	self:onSelect(false)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectAttrTab, self._onSelectAttrTab, self)
end

function Rouge2_AttrDetailBaseTabItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_AttrDetailBaseTabItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_AttrDetailBaseTabItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectAttrTab, self._groupIndex, self._index)
end

function Rouge2_AttrDetailBaseTabItem:onUpdateMO(careerId, groupIndex, index, parentView, params)
	self._groupIndex = groupIndex
	self._index = index
	self._careerId = careerId
	self._parentView = parentView
	self._params = params

	self:refreshUI()
	self:onSelect(false)
end

function Rouge2_AttrDetailBaseTabItem:refreshUI()
	return
end

function Rouge2_AttrDetailBaseTabItem:onSelect(isSelect)
	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
	gohelper.setActive(self._goUnselect, not isSelect)
end

function Rouge2_AttrDetailBaseTabItem:_onSelectAttrTab(groupIndex, index)
	local isSelect = self._groupIndex == groupIndex and self._index == index

	self:onSelect(isSelect)
end

return Rouge2_AttrDetailBaseTabItem
