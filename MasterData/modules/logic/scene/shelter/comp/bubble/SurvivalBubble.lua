-- chunkname: @modules/logic/scene/shelter/comp/bubble/SurvivalBubble.lua

module("modules.logic.scene.shelter.comp.bubble.SurvivalBubble", package.seeall)

local SurvivalBubble = class("SurvivalBubble", UserDataDispose)

function SurvivalBubble:ctor(id, survivalBubbleComp)
	self.id = id
	self.survivalBubbleComp = survivalBubbleComp
end

function SurvivalBubble:setData(survivalBubbleParam, transform)
	self.survivalBubbleParam = survivalBubbleParam
	self.transform = transform
end

function SurvivalBubble:enable()
	if self.survivalBubbleParam.duration > 0 then
		TaskDispatcher.runDelay(self.onFinish, self, self.survivalBubbleParam.duration)
	end
end

function SurvivalBubble:disable()
	TaskDispatcher.cancelTask(self.onFinish, self)
end

function SurvivalBubble:onFinish()
	self.survivalBubbleComp:removeBubble(self.id)
end

return SurvivalBubble
