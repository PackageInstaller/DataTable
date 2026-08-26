-- chunkname: @modules/logic/scene/shelter/comp/bubble/SurvivalBubbleParam.lua

module("modules.logic.scene.shelter.comp.bubble.SurvivalBubbleParam", package.seeall)

local SurvivalBubbleParam = pureTable("SurvivalBubbleParam")

function SurvivalBubbleParam:ctor()
	self.content = nil
	self.duration = -1
end

return SurvivalBubbleParam
