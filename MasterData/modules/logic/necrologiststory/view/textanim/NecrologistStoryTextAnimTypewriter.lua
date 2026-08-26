-- chunkname: @modules/logic/necrologiststory/view/textanim/NecrologistStoryTextAnimTypewriter.lua

module("modules.logic.necrologiststory.view.textanim.NecrologistStoryTextAnimTypewriter", package.seeall)

local NecrologistStoryTextAnimTypewriter = class("NecrologistStoryTextAnimTypewriter", NecrologistStoryTextAnimBase)

function NecrologistStoryTextAnimTypewriter:_onPlay()
	self.textComponent.text = self.metaText
	self.textComponent.maxVisibleCharacters = 0
	self.charIndex = 0
	self.charCount = -1

	local tickInterval = self:getTickInterval()

	TaskDispatcher.runRepeat(self._tick, self, tickInterval)
end

function NecrologistStoryTextAnimTypewriter:stop()
	TaskDispatcher.cancelTask(self._tick, self)
end

function NecrologistStoryTextAnimTypewriter:_tick()
	if self.charCount == -1 then
		self.charCount = self.textComponent.textInfo.characterCount
	end

	if self:isDone() then
		self:onTextFinish()

		return
	end

	self.textComponent.maxVisibleCharacters = self.charIndex
	self.charIndex = self.charIndex + 1
end

function NecrologistStoryTextAnimTypewriter:onTextFinish()
	self:stop()

	self.charCount = self.charCount or 0
	self.charIndex = self.charCount + 1
	self.textComponent.maxVisibleCharacters = self.charIndex

	self:setText(self.metaText)
	self:doFinishCallback()
end

return NecrologistStoryTextAnimTypewriter
