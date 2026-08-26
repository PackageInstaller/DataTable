-- chunkname: @modules/logic/character/view/CharacterTipViewContainer.lua

module("modules.logic.character.view.CharacterTipViewContainer", package.seeall)

local CharacterTipViewContainer = class("CharacterTipViewContainer", BaseViewContainer)

function CharacterTipViewContainer:buildViews()
	return {
		CharacterTipView.New()
	}
end

function CharacterTipViewContainer:onContainerClickModalMask()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
	self:closeThis()
end

return CharacterTipViewContainer
