-- chunkname: @modules/logic/fight/view/FightEditorStateViewContainer.lua

module("modules.logic.fight.view.FightEditorStateViewContainer", package.seeall)

local FightEditorStateViewContainer = class("FightEditorStateViewContainer", BaseViewContainer)

function FightEditorStateViewContainer:buildViews()
	return {
		FightEditorStateView.New()
	}
end

return FightEditorStateViewContainer
