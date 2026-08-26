-- chunkname: @modules/logic/summon/view/luckybag/SummonLuckyBagChoiceContainer.lua

module("modules.logic.summon.view.luckybag.SummonLuckyBagChoiceContainer", package.seeall)

local SummonLuckyBagChoiceContainer = class("SummonLuckyBagChoiceContainer", BaseViewContainer)

function SummonLuckyBagChoiceContainer:buildViews()
	return {
		SummonLuckyBagChoice.New()
	}
end

return SummonLuckyBagChoiceContainer
