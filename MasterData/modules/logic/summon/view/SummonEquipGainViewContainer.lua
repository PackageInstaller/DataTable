-- chunkname: @modules/logic/summon/view/SummonEquipGainViewContainer.lua

module("modules.logic.summon.view.SummonEquipGainViewContainer", package.seeall)

local SummonEquipGainViewContainer = class("SummonEquipGainViewContainer", BaseViewContainer)

function SummonEquipGainViewContainer:buildViews()
	return {
		EquipGetView.New(),
		SummonEquipGainView.New()
	}
end

return SummonEquipGainViewContainer
