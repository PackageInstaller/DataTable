-- chunkname: @modules/logic/main/view/MainSwitchCategoryItem.lua

module("modules.logic.main.view.MainSwitchCategoryItem", package.seeall)

local MainSwitchCategoryItem = class("MainSwitchCategoryItem", ListScrollCellExtend)

function MainSwitchCategoryItem:onInitView()
	self._txtitemcn1 = gohelper.findChildText(self.viewGO, "bg1/#txt_itemcn1")
	self._goreddot1 = gohelper.findChild(self.viewGO, "bg1/#txt_itemcn1/#go_reddot1")
	self._txtitemen1 = gohelper.findChildText(self.viewGO, "bg1/#txt_itemen1")
	self._txtitemcn2 = gohelper.findChildText(self.viewGO, "bg2/#txt_itemcn2")
	self._goreddot2 = gohelper.findChild(self.viewGO, "bg2/#txt_itemcn2/#go_reddot2")
	self._txtitemen2 = gohelper.findChildText(self.viewGO, "bg2/#txt_itemen2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainSwitchCategoryItem:addEvents()
	return
end

function MainSwitchCategoryItem:removeEvents()
	return
end

function MainSwitchCategoryItem:_editableInitView()
	self._btnCategory = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self._btnCategory:AddClickListener(self._onItemClick, self)

	self._bgs = self:getUserDataTb_()

	for i = 1, 2 do
		self._bgs[i] = gohelper.findChild(self.viewGO, "bg" .. tostring(i))
	end

	gohelper.setActive(self._bgs[2], false)
end

function MainSwitchCategoryItem:_editableAddEvents()
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
end

function MainSwitchCategoryItem:_editableRemoveEvents()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, self._refreshReddot, self)
end

function MainSwitchCategoryItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshStatus()
end

function MainSwitchCategoryItem:refreshStatus()
	local target = self:_isSelected()

	gohelper.setActive(self._bgs[1], not target)
	gohelper.setActive(self._bgs[2], target)
	self:_refreshReddot()
end

function MainSwitchCategoryItem:_refreshReddot()
	local showReddot = false

	if self._mo.id == MainEnum.SwitchType.Scene then
		showReddot = RedDotModel.instance:isDotShow(RedDotEnum.DotNode.MainSceneSwitch, 0)

		if showReddot and self:_isSelected() then
			MainSceneSwitchController.closeReddot()

			showReddot = false
		end
	end

	gohelper.setActive(self._goreddot1, showReddot)
end

function MainSwitchCategoryItem:_isSelected()
	return self._mo.id == MainSwitchCategoryListModel.instance:getCategoryId()
end

function MainSwitchCategoryItem:onSelect(isSelect)
	return
end

function MainSwitchCategoryItem:_onItemClick()
	if self:_isSelected() then
		return
	end

	MainSwitchCategoryListModel.instance:setCategoryId(self._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchCategoryClick, self._mo.id)
end

function MainSwitchCategoryItem:onDestroyView()
	if self._btnCategory then
		self._btnCategory:RemoveClickListener()
	end
end

return MainSwitchCategoryItem
