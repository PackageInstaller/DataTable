-- chunkname: @modules/logic/character/view/CharacterTalentModifyNameViewContainer.lua

module("modules.logic.character.view.CharacterTalentModifyNameViewContainer", package.seeall)

local CharacterTalentModifyNameViewContainer = class("CharacterTalentModifyNameViewContainer", BaseViewContainer)

function CharacterTalentModifyNameViewContainer:buildViews()
	return {
		CharacterTalentModifyNameView.New()
	}
end

function CharacterTalentModifyNameViewContainer:onContainerClickModalMask()
	self:closeThis()
end

function CharacterTalentModifyNameViewContainer:playOpenTransition()
	self:onPlayOpenTransitionFinish()
end

return CharacterTalentModifyNameViewContainer
