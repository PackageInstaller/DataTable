-- chunkname: @modules/logic/settings/view/SettingsRoleVoiceViewLangBtn.lua

module("modules.logic.settings.view.SettingsRoleVoiceViewLangBtn", package.seeall)

local SettingsRoleVoiceViewLangBtn = class("SettingsRoleVoiceViewLangBtn", RougeSimpleItemBase)

function SettingsRoleVoiceViewLangBtn:onInitView()
	self._btnCN = gohelper.findChildButtonWithAudio(self.viewGO, "click")
	self._goCNUnSelected = gohelper.findChild(self.viewGO, "unselected")
	self._info1 = gohelper.findChildText(self.viewGO, "unselected/info1")
	self._goCNSelected = gohelper.findChild(self.viewGO, "selected")
	self._info2 = gohelper.findChildText(self.viewGO, "selected/info2")
	self._goCNSelectPoint = gohelper.findChild(self.viewGO, "selected/point")

	SettingsRoleVoiceViewLangBtn.super.onInitView(self)
end

function SettingsRoleVoiceViewLangBtn:addEvents()
	self._btnCN:AddClickListener(self._btnCNOnClick, self)
end

function SettingsRoleVoiceViewLangBtn:removeEvents()
	self._btnCN:RemoveClickListener()
end

function SettingsRoleVoiceViewLangBtn:_editableInitView()
	SettingsRoleVoiceViewLangBtn.super._editableInitView(self)
end

function SettingsRoleVoiceViewLangBtn:refreshSelected(langId)
	self:setSelected(langId == self:_langId())
end

function SettingsRoleVoiceViewLangBtn:_curSelectLang()
	return self:parent()._curSelectLang or 0
end

function SettingsRoleVoiceViewLangBtn:_useCurLang()
	self:parent():setcurSelectLang(self:_langId())
end

function SettingsRoleVoiceViewLangBtn:refreshLangOptionDownloadState()
	self:parent():_refreshLangOptionDownloadState(self:_langId(), self._goCNUnSelected)
end

function SettingsRoleVoiceViewLangBtn:_lang()
	return self._mo.lang
end

function SettingsRoleVoiceViewLangBtn:_langId()
	return self._mo.langId
end

function SettingsRoleVoiceViewLangBtn:getLangId()
	return self._mo.langId
end

function SettingsRoleVoiceViewLangBtn:_isValid()
	return self._mo.available
end

function SettingsRoleVoiceViewLangBtn:setData(mo)
	self._mo = mo

	local str = luaLang(self:_lang())

	self._info1.text = str
	self._info2.text = str

	self:refreshLangOptionDownloadState()
end

function SettingsRoleVoiceViewLangBtn:_btnCNOnClick()
	if self:isSelected() then
		return
	end

	if not self:_isValid() then
		GameFacade.showToast(ToastEnum.CharVoiceLangLost)

		return
	end

	self:_useCurLang()
	self:parent():afterSelectedNewLang()
end

function SettingsRoleVoiceViewLangBtn:onSelect(isSelect)
	self:_setSelectedActive(isSelect)

	self._staticData.isSelected = isSelect
end

function SettingsRoleVoiceViewLangBtn:_setSelectedActive(isActive)
	gohelper.setActive(self._goCNUnSelected, not isActive)
	gohelper.setActive(self._goCNSelected, isActive)
end

function SettingsRoleVoiceViewLangBtn:_setActive_goCNSelectPoint(isActive)
	gohelper.setActive(self._goCNSelectPoint, isActive)
end

function SettingsRoleVoiceViewLangBtn:refreshLangOptionSelectState(langId, active)
	self:_setActive_goCNSelectPoint(langId == self:_langId() and active)
end

function SettingsRoleVoiceViewLangBtn:refreshLangMode(langId, active)
	gohelper.setActive(self.viewGO, active)

	if active then
		self:_setSelectedActive(langId == self:_langId())
	end
end

function SettingsRoleVoiceViewLangBtn:onDestroyView()
	SettingsRoleVoiceViewLangBtn.super.onDestroyView(self)
end

return SettingsRoleVoiceViewLangBtn
