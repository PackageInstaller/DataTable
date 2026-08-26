-- chunkname: @modules/logic/summon/view/SummonPoolDetailCategoryItem.lua

module("modules.logic.summon.view.SummonPoolDetailCategoryItem", package.seeall)

local SummonPoolDetailCategoryItem = class("SummonPoolDetailCategoryItem", ListScrollCellExtend)

function SummonPoolDetailCategoryItem:onInitView()
	self._gounselect = gohelper.findChild(self.viewGO, "#go_unselect")
	self._txttitle1 = gohelper.findChildText(self.viewGO, "#go_unselect/#txt_title1")
	self._txttitle1En = gohelper.findChildText(self.viewGO, "#go_unselect/#txt_title1En")
	self._goselect = gohelper.findChild(self.viewGO, "#go_select")
	self._txttitle2 = gohelper.findChildText(self.viewGO, "#go_select/#txt_title2")
	self._txttitle2En = gohelper.findChildText(self.viewGO, "#go_select/#txt_title2En")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolDetailCategoryItem:addEvents()
	return
end

function SummonPoolDetailCategoryItem:removeEvents()
	return
end

function SummonPoolDetailCategoryItem:_editableInitView()
	self._click = gohelper.getClickWithAudio(self.viewGO)
end

function SummonPoolDetailCategoryItem:_editableAddEvents()
	self._click:AddClickListener(self._onClick, self)
end

function SummonPoolDetailCategoryItem:_editableRemoveEvents()
	self._click:RemoveClickListener()
end

function SummonPoolDetailCategoryItem:_onClick()
	if self._isSelect then
		return
	end

	self._view:selectCell(self._index, true)
	self._view.viewContainer:dispatchEvent(ViewEvent.ToSwitchTab, 1, self._mo.resIndex)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolDetailCategoryClick, self._mo.resIndex)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)
end

function SummonPoolDetailCategoryItem:onUpdateMO(mo)
	self._mo = mo
	self._txttitle1.text = mo.cnName
	self._txttitle2.text = mo.cnName
	self._txttitle1En.text = mo.enName
	self._txttitle2En.text = mo.enName
end

function SummonPoolDetailCategoryItem:onSelect(isSelect)
	self._isSelect = isSelect

	self._gounselect:SetActive(not self._isSelect)
	self._goselect:SetActive(self._isSelect)
end

function SummonPoolDetailCategoryItem:onDestroyView()
	return
end

return SummonPoolDetailCategoryItem
