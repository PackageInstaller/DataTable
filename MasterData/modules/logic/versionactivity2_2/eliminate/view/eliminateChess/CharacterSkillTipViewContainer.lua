-- chunkname: @modules/logic/versionactivity2_2/eliminate/view/eliminateChess/CharacterSkillTipViewContainer.lua

module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.CharacterSkillTipViewContainer", package.seeall)

local CharacterSkillTipViewContainer = class("CharacterSkillTipViewContainer", BaseViewContainer)

function CharacterSkillTipViewContainer:buildViews()
	local views = {}

	table.insert(views, CharacterSkillTipView.New())

	return views
end

return CharacterSkillTipViewContainer
