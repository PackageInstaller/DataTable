-- chunkname: @modules/logic/lifecircle/view/LifeCirclePickChoiceContainer.lua

module("modules.logic.lifecircle.view.LifeCirclePickChoiceContainer", package.seeall)

local LifeCirclePickChoiceContainer = class("LifeCirclePickChoiceContainer", BaseViewContainer)

function LifeCirclePickChoiceContainer:buildViews()
	return {
		LifeCirclePickChoice.New()
	}
end

return LifeCirclePickChoiceContainer
