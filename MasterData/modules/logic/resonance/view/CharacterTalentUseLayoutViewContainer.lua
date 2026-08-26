-- chunkname: @modules/logic/resonance/view/CharacterTalentUseLayoutViewContainer.lua

module("modules.logic.resonance.view.CharacterTalentUseLayoutViewContainer", package.seeall)

local CharacterTalentUseLayoutViewContainer = class("CharacterTalentUseLayoutViewContainer", BaseViewContainer)

function CharacterTalentUseLayoutViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterTalentUseLayoutView.New())

	return views
end

return CharacterTalentUseLayoutViewContainer
