-- chunkname: @modules/logic/gm/view/GM_CharacterDataVoiceView.lua

module("modules.logic.gm.view.GM_CharacterDataVoiceView", package.seeall)

local GM_CharacterDataVoiceView = class("GM_CharacterDataVoiceView", BaseView)

function GM_CharacterDataVoiceView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_CharacterDataVoiceView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_CharacterDataVoiceView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_CharacterDataVoiceView:onOpen()
	self:_refreshItem1()
end

function GM_CharacterDataVoiceView:onDestroyView()
	return
end

GM_CharacterDataVoiceView.s_ShowAllTabId = false

function GM_CharacterDataVoiceView:_refreshItem1()
	self._item1Toggle.isOn = GM_CharacterDataVoiceView.s_ShowAllTabId
end

function GM_CharacterDataVoiceView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_CharacterDataVoiceView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterDataVoiceView_ShowAllTabIdUpdate, isOn)
end

return GM_CharacterDataVoiceView
