-- chunkname: @modules/logic/versionactivity1_5/aizila/view/AiZiLaRecordTabItem.lua

module("modules.logic.versionactivity1_5.aizila.view.AiZiLaRecordTabItem", package.seeall)

local AiZiLaRecordTabItem = class("AiZiLaRecordTabItem", ListScrollCellExtend)

function AiZiLaRecordTabItem:onInitView()
	self._goLocked = gohelper.findChild(self.viewGO, "#go_Locked")
	self._txtLockedTitle = gohelper.findChildText(self.viewGO, "#go_Locked/image_Locked/#txt_LockedTitle")
	self._goUnSelected = gohelper.findChild(self.viewGO, "#go_UnSelected")
	self._txtTitle = gohelper.findChildText(self.viewGO, "#go_UnSelected/image_UnSelected/#txt_Title")
	self._goSelected = gohelper.findChild(self.viewGO, "#go_Selected")
	self._txtSelectTitle = gohelper.findChildText(self.viewGO, "#go_Selected/image_Selected/#txt_SelectTitle")
	self._btnTabClick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_TabClick")
	self._goredPoint = gohelper.findChild(self.viewGO, "#go_redPoint")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AiZiLaRecordTabItem:addEvents()
	self._btnTabClick:AddClickListener(self._btnTabClickOnClick, self)
end

function AiZiLaRecordTabItem:removeEvents()
	self._btnTabClick:RemoveClickListener()
end

function AiZiLaRecordTabItem:_btnTabClickOnClick()
	if self._isUnLock and self._mo then
		AiZiLaController.instance:dispatchEvent(AiZiLaEvent.UISelectRecordTabItem, self._mo.id)
	else
		GameFacade.showToast(ToastEnum.V1a5AiZiLaRecordNotOpen)
	end
end

function AiZiLaRecordTabItem:_editableInitView()
	return
end

function AiZiLaRecordTabItem:_editableAddEvents()
	return
end

function AiZiLaRecordTabItem:_editableRemoveEvents()
	return
end

function AiZiLaRecordTabItem:onUpdateMO(mo)
	self._mo = mo

	self:refreshUI()
end

function AiZiLaRecordTabItem:onSelect(isSelect)
	self._isSelect = not not isSelect

	gohelper.setActive(self._goLocked, not self._isUnLock)
	gohelper.setActive(self._goUnSelected, self._isUnLock and not self._isSelect)
	gohelper.setActive(self._goSelected, self._isUnLock and self._isSelect)
end

function AiZiLaRecordTabItem:onDestroyView()
	return
end

function AiZiLaRecordTabItem:refreshUI()
	local recordMO = self._mo

	self._isUnLock = true

	if not recordMO then
		return
	end

	local nameStr = recordMO.config.name

	if not recordMO:isUnLock() then
		nameStr = luaLang("v1a5_aizila_unknown_question_mark")
	end

	self._txtTitle.text = nameStr
	self._txtSelectTitle.text = nameStr

	RedDotController.instance:addRedDot(self._goredPoint, RedDotEnum.DotNode.V1a5AiZiLaRecordNew, recordMO:getRedUid())
	self:onSelect(self._isSelect)
end

return AiZiLaRecordTabItem
