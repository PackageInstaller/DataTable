-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTabView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTabView", package.seeall)

local Rouge2_BackpackTabView = class("Rouge2_BackpackTabView", BaseView)

function Rouge2_BackpackTabView:onInitView()
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Container")
	self._goTabItem = gohelper.findChild(self.viewGO, "TabList/#go_TabItem")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._golefttop2 = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gocoincontainer = gohelper.findChild(self.viewGO, "#go_coincontainer")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackTabView:addEvents()
	return
end

function Rouge2_BackpackTabView:removeEvents()
	return
end

function Rouge2_BackpackTabView:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
end

function Rouge2_BackpackTabView:onUpdateParam()
	return
end

function Rouge2_BackpackTabView:onOpen()
	self:initTabItemList()
end

function Rouge2_BackpackTabView:initTabItemList()
	self._tabTypeList = {}

	for _, backpackType in pairs(Rouge2_Enum.BagTabType) do
		table.insert(self._tabTypeList, backpackType)
	end

	table.sort(self._tabTypeList, function(aType, bType)
		return aType < bType
	end)

	self._backpackItemTab = self:getUserDataTb_()

	for _, tabType in ipairs(self._tabTypeList) do
		local goTabItem = gohelper.cloneInPlace(self._goTabItem, "type_" .. tabType)
		local tabItem = MonoHelper.addNoUpdateLuaComOnceToGo(goTabItem, Rouge2_BackpackTabItem, self)

		tabItem:onUpdateMO(tabType)
		table.insert(self._backpackItemTab, tabItem)
	end

	gohelper.setActive(self._goTabItem, false)
end

function Rouge2_BackpackTabView:onClose()
	return
end

function Rouge2_BackpackTabView:onDestroyView()
	return
end

return Rouge2_BackpackTabView
