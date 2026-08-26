-- chunkname: @modules/logic/bossrush/view/FightActionBarPopViewContainer.lua

module("modules.logic.bossrush.view.FightActionBarPopViewContainer", package.seeall)

local FightActionBarPopViewContainer = class("FightActionBarPopViewContainer", BaseViewContainer)

function FightActionBarPopViewContainer:buildViews()
	return {
		FightActionBarPopView.New()
	}
end

return FightActionBarPopViewContainer
