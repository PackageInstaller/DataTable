-- chunkname: @modules/logic/fight/view/FightCardMixIntroduceViewContainer.lua

module("modules.logic.fight.view.FightCardMixIntroduceViewContainer", package.seeall)

local FightCardMixIntroduceViewContainer = class("FightCardMixIntroduceViewContainer", BaseViewContainer)

function FightCardMixIntroduceViewContainer:buildViews()
	return {
		FightCardMixIntroduceView.New()
	}
end

return FightCardMixIntroduceViewContainer
