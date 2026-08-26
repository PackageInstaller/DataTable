-- chunkname: @modules/logic/character/view/CharacterTalentStyleNavigateButtonsView.lua

module("modules.logic.character.view.CharacterTalentStyleNavigateButtonsView", package.seeall)

local CharacterTalentStyleNavigateButtonsView = class("CharacterTalentStyleNavigateButtonsView", NavigateButtonsView)

function CharacterTalentStyleNavigateButtonsView:_editableInitView()
	CharacterTalentStyleNavigateButtonsView.super._editableInitView(self)

	self._btnstat = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_stat")
end

function CharacterTalentStyleNavigateButtonsView:addEvents()
	CharacterTalentStyleNavigateButtonsView.super.addEvents(self)
	self._btnstat:AddClickListener(self._btnstatOnClick, self)
end

function CharacterTalentStyleNavigateButtonsView:removeEvents()
	CharacterTalentStyleNavigateButtonsView.super.removeEvents(self)
	self._btnstat:RemoveClickListener()
end

function CharacterTalentStyleNavigateButtonsView:_btnstatOnClick()
	if self._overrideStatFunc then
		self._overrideStatFunc(self._overrideStatObj)
	end
end

function CharacterTalentStyleNavigateButtonsView:setOverrideStat(overrideStatFunc, overrideStatObj)
	self._overrideStatFunc = overrideStatFunc
	self._overrideStatObj = overrideStatObj
end

function CharacterTalentStyleNavigateButtonsView:showStatBtn(isShow)
	if self._btnstat then
		gohelper.setActive(self._btnstat.gameObject, isShow)
	end
end

return CharacterTalentStyleNavigateButtonsView
