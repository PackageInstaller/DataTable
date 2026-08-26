-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaRecordItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordItem", package.seeall)

local AiZiLaRecordItem = class("AiZiLaRecordItem", ListScrollCellExtend)

function AiZiLaRecordItem:onInitView()
	self._txtEventTitle = gohelper.findChildText(self.viewGO, "Title/#txt_EventTitle")
	self._txtTitleEn = gohelper.findChildText(self.viewGO, "Title/#txt_EventTitle/#txt_TitleEn")
	self._goredPoint = gohelper.findChild(self.viewGO, "Title/#go_redPoint")
	self._txtEventDesc = gohelper.findChildText(self.viewGO, "#txt_EventDesc")
	self._goOption = gohelper.findChild(self.viewGO, "#go_Option")
	self._txtOptionTitle = gohelper.findChildText(self.viewGO, "#go_Option/#txt_OptionTitle")
	self._txtOptionDesc = gohelper.findChildText(self.viewGO, "#go_Option/#txt_OptionDesc")
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLocked = gohelper.findChildText(self.viewGO, "#go_Locked/#txt_Locked")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaRecordItem:addEvents()
	return
end

function AiZiLaRecordItem:removeEvents()
	return
end

function AiZiLaRecordItem:_editableInitView()
	return
end

function AiZiLaRecordItem:_editableAddEvents()
	return
end

function AiZiLaRecordItem:_editableRemoveEvents()
	return
end

function AiZiLaRecordItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function AiZiLaRecordItem:onSelect(isSelect)
	return
end

function AiZiLaRecordItem:onDestroyView()
	return
end

function AiZiLaRecordItem:refreshUI()
	local groupMO = self._mo

	if not groupMO then
		return
	end

	local eventMO = groupMO:getFinishedEventMO()
	local isUnLock = not not eventMO

	gohelper.setActive(self._goOption, isUnLock)
	gohelper.setActive(self._txtEventDesc, isUnLock)
	gohelper.setActive(self._goLocked, not isUnLock)

	if isUnLock then
		self:_refreshUnLockUI(eventMO)
	else
		self._txtEventTitle.text = luaLang("v1a5_aizila_unknown_question_mark")
		self._txtLocked.text = groupMO.lockDesc
	end
end

function AiZiLaRecordItem:_refreshUnLockUI(eventMO)
	local eventCfg = eventMO.config

	self._txtEventTitle.text = GameUtil.setFirstStrSize(eventCfg.name, 60)
	self._txtEventDesc.text = eventCfg.desc

	local optionCfg = eventMO:getSelectOptionCfg()

	self._txtOptionTitle.text = optionCfg.name
	self._txtOptionDesc.text = optionCfg.optionDesc
end

return AiZiLaRecordItem
