-- chunkname: @modules/logic/playercard/view/NewPlayerCardView_210015.lua

module("modules.logic.playercard.view.NewPlayerCardView_210015", package.seeall)

local NewPlayerCardView_210015 = class("NewPlayerCardView_210015", NewPlayerCardView)

function NewPlayerCardView_210015:_editableInitView()
	NewPlayerCardView_210015.super._editableInitView(self)

	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/box/#btn_click")
end

function NewPlayerCardView_210015:addEvents()
	NewPlayerCardView_210015.super.addEvents(self)
	self._btnclick:AddClickListener(self._btnClickOnClick, self)
end

function NewPlayerCardView_210015:removeEvents()
	NewPlayerCardView_210015.super.removeEvents(self)
	self._btnclick:RemoveClickListener()
end

function NewPlayerCardView_210015:_btnClickOnClick()
	self._animator.enabled = true

	self._animator:Play("click", 0, 0)
	AudioMgr.instance:trigger(AudioEnum3_7.PlayCard.play_ui_lvquanji_caidan)
end

return NewPlayerCardView_210015
