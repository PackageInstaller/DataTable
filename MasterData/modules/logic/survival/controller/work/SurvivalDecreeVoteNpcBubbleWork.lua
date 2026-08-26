-- chunkname: @modules/logic/survival/controller/work/SurvivalDecreeVoteNpcBubbleWork.lua

module("modules.logic.survival.controller.work.SurvivalDecreeVoteNpcBubbleWork", package.seeall)

local SurvivalDecreeVoteNpcBubbleWork = class("SurvivalDecreeVoteNpcBubbleWork", BaseWork)

function SurvivalDecreeVoteNpcBubbleWork:ctor(param)
	self:initParam(param)
end

function SurvivalDecreeVoteNpcBubbleWork:initParam(param)
	self.bubbleList = param.bubbleList or {}
	self.startCallback = param.startCallback
	self.startCallbackObj = param.startCallbackObj
end

function SurvivalDecreeVoteNpcBubbleWork:onStart()
	if self.startCallback then
		self.startCallback(self.startCallbackObj)
	end

	if self.bubbleList then
		local groupedBubbles = {}
		local tempList = tabletool.copy(self.bubbleList)

		while #tempList > 0 do
			local groupSize = math.random(3, math.min(5, #tempList))
			local group = {}

			for i = 1, groupSize do
				if #tempList > 0 then
					local randomIndex = math.random(1, #tempList)

					table.insert(group, tempList[randomIndex])
					table.remove(tempList, randomIndex)
				end
			end

			table.insert(groupedBubbles, group)
		end

		self.groupedBubbles = groupedBubbles
		self._animIndex = 0

		TaskDispatcher.runRepeat(self._playItemOpenAnim, self, 0.06, #self.groupedBubbles)
	else
		self:onPlayFinish()
	end
end

function SurvivalDecreeVoteNpcBubbleWork:_playItemOpenAnim()
	self._animIndex = self._animIndex + 1

	local bubbles = self.groupedBubbles[self._animIndex]

	if bubbles then
		for _, bubble in ipairs(bubbles) do
			gohelper.setActive(bubble.go, true)
		end
	end

	if self._animIndex >= #self.groupedBubbles then
		TaskDispatcher.cancelTask(self._playItemOpenAnim, self)
		self:onPlayFinish()
	end
end

function SurvivalDecreeVoteNpcBubbleWork:onPlayFinish()
	self:onDone(true)
end

function SurvivalDecreeVoteNpcBubbleWork:clearWork()
	TaskDispatcher.cancelTask(self._playItemOpenAnim, self)
end

return SurvivalDecreeVoteNpcBubbleWork
