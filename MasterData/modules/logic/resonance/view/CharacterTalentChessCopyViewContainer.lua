-- chunkname: @modules/logic/resonance/view/CharacterTalentChessCopyViewContainer.lua

module("modules.logic.resonance.view.CharacterTalentChessCopyViewContainer", package.seeall)

local CharacterTalentChessCopyViewContainer = class("CharacterTalentChessCopyViewContainer", BaseViewContainer)

function CharacterTalentChessCopyViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterTalentChessCopyView.New())

	return views
end

return CharacterTalentChessCopyViewContainer
