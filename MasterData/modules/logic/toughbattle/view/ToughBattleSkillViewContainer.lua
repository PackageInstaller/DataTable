-- chunkname: @modules/logic/toughbattle/view/ToughBattleSkillViewContainer.lua

module("modules.logic.toughbattle.view.ToughBattleSkillViewContainer", package.seeall)

local ToughBattleSkillViewContainer = class("ToughBattleSkillViewContainer", BaseViewContainer)

function ToughBattleSkillViewContainer:buildViews()
	return {
		ToughBattleSkillView.New()
	}
end

return ToughBattleSkillViewContainer
