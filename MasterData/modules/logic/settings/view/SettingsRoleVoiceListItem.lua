-- chunkname: @modules/logic/settings/view/SettingsRoleVoiceListItem.lua

module("modules.logic.settings.view.SettingsRoleVoiceListItem", package.seeall)

local SettingsRoleVoiceListItem = class("SettingsRoleVoiceListItem", ListScrollCell)

SettingsRoleVoiceListItem.PressColor = GameUtil.parseColor("#C8C8C8")

function SettingsRoleVoiceListItem:init(go)
	self._heroGO = go
	self._heroItem = MonoHelper.addNoUpdateLuaComOnceToGo(self._heroGO, CommonHeroItem)

	self._heroItem:hideFavor(true)
	self._heroItem:addClickListener(self._onItemClick, self)
	self:_initObj()
end

function SettingsRoleVoiceListItem:_initObj()
	self._animator = self._heroGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._selectframe, false)
end

function SettingsRoleVoiceListItem:addEventListeners()
	return
end

function SettingsRoleVoiceListItem:removeEventListeners()
	return
end

function SettingsRoleVoiceListItem:onUpdateMO(mo)
	self._mo = mo

	self._heroItem:onUpdateMO(mo)
	self._heroItem:setNewShow(false)
	self._heroItem:setRankObjActive(false)
	self._heroItem:setLevelContentShow(false)
	self._heroItem:setExSkillActive(false)

	local heroId = mo.heroId
	local langId, langStr = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(heroId)
	local text = luaLang(LangSettings.shortcutTab[langId])

	self._heroItem:setCenterTxt(text)
	self._heroItem:setStyle_CharacterBackpack()
end

function SettingsRoleVoiceListItem:_onrefreshItem()
	return
end

function SettingsRoleVoiceListItem:_onItemClick()
	local newState = not self._isSelect

	self._view:selectCell(self._index, newState)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	SettingsRoleVoiceController.instance:dispatchEvent(SettingsEvent.OnSetVoiceRoleSelected, self._mo, newState)
end

function SettingsRoleVoiceListItem:onSelect(select)
	local isBatchMode = self._view.viewContainer:isBatchEditMode()

	if isBatchMode then
		self._isSelect = select

		self._heroItem:setSelect(select)
	else
		self._isSelect = select

		self._heroItem:setSelect(select)
	end
end

function SettingsRoleVoiceListItem:onDestroy()
	if self._heroItem then
		self._heroItem:onDestroy()

		self._heroItem = nil
	end
end

function SettingsRoleVoiceListItem:getAnimator()
	return self._animator
end

return SettingsRoleVoiceListItem
