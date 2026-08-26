-- chunkname: @modules/logic/summon/view/SummonPoolHistoryTypeItem.lua

module("modules.logic.summon.view.SummonPoolHistoryTypeItem", package.seeall)

local SummonPoolHistoryTypeItem = class("SummonPoolHistoryTypeItem", ListScrollCellExtend)

function SummonPoolHistoryTypeItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function SummonPoolHistoryTypeItem:addEvents()
	return
end

function SummonPoolHistoryTypeItem:removeEvents()
	return
end

function SummonPoolHistoryTypeItem:_editableInitView()
	self._gounselect = gohelper.findChild(self.viewGO, "go_unselect")
	self._txtunname = gohelper.findChildText(self.viewGO, "go_unselect/txt_name")
	self._goselect = gohelper.findChild(self.viewGO, "go_select")
	self._txtname = gohelper.findChildText(self.viewGO, "go_select/txt_name")
	self._btnitem = gohelper.findChildButtonWithAudio(self.viewGO, "btn_item")
end

function SummonPoolHistoryTypeItem:_editableAddEvents()
	self._btnitem:AddClickListener(self._onClick, self)
end

function SummonPoolHistoryTypeItem:_editableRemoveEvents()
	self._btnitem:RemoveClickListener()
end

function SummonPoolHistoryTypeItem:_onClick()
	if self._isSelect then
		return
	end

	SummonPoolHistoryTypeListModel.instance:setSelectId(self._mo.id)
	SummonController.instance:dispatchEvent(SummonEvent.onSummonPoolHistorySelect, self._mo.id)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Pool_History_Type_Switch)
end

function SummonPoolHistoryTypeItem:onUpdateMO(mo)
	self._mo = mo
	self._txtunname.text = mo.config.name
	self._txtname.text = mo.config.name
end

function SummonPoolHistoryTypeItem:onSelect(isSelect)
	self._isSelect = isSelect

	self._gounselect:SetActive(not self._isSelect)
	self._goselect:SetActive(self._isSelect)
end

function SummonPoolHistoryTypeItem:onDestroyView()
	return
end

return SummonPoolHistoryTypeItem
