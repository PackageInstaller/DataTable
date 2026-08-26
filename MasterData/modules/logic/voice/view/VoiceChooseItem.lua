-- chunkname: @modules/logic/voice/view/VoiceChooseItem.lua

module("modules.logic.voice.view.VoiceChooseItem", package.seeall)

local VoiceChooseItem = class("VoiceChooseItem", ListScrollCell)

function VoiceChooseItem:init(go)
	self._goSelect = gohelper.findChild(go, "#go_selected")
	self._txtTitle = gohelper.findChildText(go, "#txt_title")
	self._txtDec = gohelper.findChildText(go, "#txt_dec")
	self._click = gohelper.getClick(go)
end

function VoiceChooseItem:addEventListeners()
	self._click:AddClickListener(self._onClickThis, self)
end

function VoiceChooseItem:removeEventListeners()
	self._click:RemoveClickListener()
end

function VoiceChooseItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._goSelect, self._mo.choose)

	local langKey = "langtype_" .. self._mo.lang

	self._txtTitle.text = luaLang(langKey)
	self._txtDec.text = SettingsConfig.instance:getVoiceTips(self._mo.lang)
end

function VoiceChooseItem:_onClickThis()
	VoiceChooseModel.instance:choose(self._mo.lang)
end

return VoiceChooseItem
