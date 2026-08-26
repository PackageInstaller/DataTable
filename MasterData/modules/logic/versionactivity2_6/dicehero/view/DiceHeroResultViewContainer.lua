-- chunkname: @modules/logic/versionactivity2_6/dicehero/view/DiceHeroResultViewContainer.lua

module("modules.logic.versionactivity2_6.dicehero.view.DiceHeroResultViewContainer", package.seeall)

local DiceHeroResultViewContainer = class("DiceHeroResultViewContainer", BaseViewContainer)

function DiceHeroResultViewContainer:buildViews()
	return {
		DiceHeroResultView.New()
	}
end

return DiceHeroResultViewContainer
