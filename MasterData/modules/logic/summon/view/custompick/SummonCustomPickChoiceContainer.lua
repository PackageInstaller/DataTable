-- chunkname: @modules/logic/summon/view/custompick/SummonCustomPickChoiceContainer.lua

module("modules.logic.summon.view.custompick.SummonCustomPickChoiceContainer", package.seeall)

local SummonCustomPickChoiceContainer = class("SummonCustomPickChoiceContainer", BaseViewContainer)

function SummonCustomPickChoiceContainer:buildViews()
	return {
		SummonCustomPickChoice.New(),
		SummonCustomPickChoiceList.New()
	}
end

return SummonCustomPickChoiceContainer
