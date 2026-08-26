-- chunkname: @modules/logic/versionactivity3_3/arcade/view/handbook/ArcadeHandBookTabItem.lua

module("modules.logic.versionactivity3_3.arcade.view.handbook.ArcadeHandBookTabItem", package.seeall)

local ArcadeHandBookTabItem = class("ArcadeHandBookTabItem", ListScrollCellExtend)

function ArcadeHandBookTabItem:onInitView()
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._goreddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btntab = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tab", AudioEnum3_3.Arcade.play_ui_yuanzheng_click)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeHandBookTabItem:addEvents()
	self._btntab:AddClickListener(self._btntabOnClick, self)
end

function ArcadeHandBookTabItem:removeEvents()
	self._btntab:RemoveClickListener()
end

function ArcadeHandBookTabItem:_btntabOnClick()
	local tab, Id = ArcadeHandBookModel.instance:getShowTypeId()

	if tab == self.type then
		return
	end

	ArcadeHandBookModel.instance:curTab(self.type, 1)
	ArcadeController.instance:dispatchEvent(ArcadeEvent.OnCutHandBookTab, self.type)
end

function ArcadeHandBookTabItem:_editableInitView()
	return
end

function ArcadeHandBookTabItem:_editableAddEvents()
	return
end

function ArcadeHandBookTabItem:_editableRemoveEvents()
	return
end

function ArcadeHandBookTabItem:onUpdateMO(mo)
	self.type = mo

	self:refreshReddot()
end

function ArcadeHandBookTabItem:refreshReddot()
	local hasReddot = ArcadeHandBookModel.instance:hasReddotByType(self.type)

	gohelper.setActive(self._goreddot, hasReddot)
end

function ArcadeHandBookTabItem:onSelect(isSelect)
	gohelper.setActive(self._goselect, isSelect)

	if isSelect then
		gohelper.setActive(self._goreddot, false)
	end
end

function ArcadeHandBookTabItem:onDestroyView()
	return
end

return ArcadeHandBookTabItem
