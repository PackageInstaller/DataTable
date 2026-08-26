-- chunkname: @modules/logic/rouge2/common/comp/Rouge2_AttrDetailAttrTabGroupItem.lua

module("modules.logic.rouge2.common.comp.Rouge2_AttrDetailAttrTabGroupItem", package.seeall)

local Rouge2_AttrDetailAttrTabGroupItem = class("Rouge2_AttrDetailAttrTabGroupItem", Rouge2_AttrDetailTabGroupBaseItem)

function Rouge2_AttrDetailAttrTabGroupItem:refreshTabItemList()
	self._goAttrTabItem = gohelper.findChild(self._parentView.viewGO, "#go_Root/#scroll_Tab/Viewport/Content/#go_AttrTabItem")
	self._subTabItemList = self._attrInfoList

	gohelper.CreateObjList(self, self._refreshAttrTabItem, self._attrInfoList, self._goSubList, self._goAttrTabItem, Rouge2_AttrDetailAttrTabItem)
end

function Rouge2_AttrDetailAttrTabGroupItem:_refreshAttrTabItem(attrTabItem, attrInfo, index)
	attrTabItem:onUpdateMO(self._careerId, self._groupType, index, self._parentView, attrInfo)
end

return Rouge2_AttrDetailAttrTabGroupItem
