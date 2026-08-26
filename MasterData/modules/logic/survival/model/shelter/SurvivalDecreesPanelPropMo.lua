-- chunkname: @modules/logic/survival/model/shelter/SurvivalDecreesPanelPropMo.lua

module("modules.logic.survival.model.shelter.SurvivalDecreesPanelPropMo", package.seeall)

local SurvivalDecreesPanelPropMo = pureTable("SurvivalDecreesPanelPropMo")

function SurvivalDecreesPanelPropMo:init(data)
	self.decreesId = data.decreesId
	self.selectNum = data.selectNum
end

return SurvivalDecreesPanelPropMo
