-- chunkname: @modules/logic/character/view/CharacterTalentTipViewContainer.lua

module("modules.logic.character.view.CharacterTalentTipViewContainer", package.seeall)

local CharacterTalentTipViewContainer = class("CharacterTalentTipViewContainer", BaseViewContainer)

function CharacterTalentTipViewContainer:buildViews()
	return {
		CharacterTalentTipView.New()
	}
end

function CharacterTalentTipViewContainer:buildTabViews(tabContainerId)
	return
end

function CharacterTalentTipViewContainer:onContainerClickModalMask()
	self:closeThis()
end

return CharacterTalentTipViewContainer
