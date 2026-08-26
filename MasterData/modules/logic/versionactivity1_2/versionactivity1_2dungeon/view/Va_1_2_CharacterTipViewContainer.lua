-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/view/Va_1_2_CharacterTipViewContainer.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.Va_1_2_CharacterTipViewContainer", package.seeall)

local Va_1_2_CharacterTipViewContainer = class("Va_1_2_CharacterTipViewContainer", CharacterTipViewContainer)

function Va_1_2_CharacterTipViewContainer:buildViews()
	return {
		Va_1_2_CharacterTipView.New()
	}
end

return Va_1_2_CharacterTipViewContainer
