-- chunkname: @modules/logic/necrologiststory/view/textanim/NecrologistStoryTextAnimBase.lua

module("modules.logic.necrologiststory.view.textanim.NecrologistStoryTextAnimBase", package.seeall)

local NecrologistStoryTextAnimBase = class("NecrologistStoryTextAnimBase")

function NecrologistStoryTextAnimBase:ctor(comp)
	self.comp = comp
	self.txtGO = comp.txtGO
	self.transform = comp.transform
	self.textComponent = comp.textComponent
end

function NecrologistStoryTextAnimBase:getTickInterval()
	return self.tickInterval or 0.03333333333333333
end

function NecrologistStoryTextAnimBase:play(text, frameCallback, finishCallback, callbackObj)
	self:stop()

	self.metaText = text
	self.frameCallback = frameCallback
	self.finishCallback = finishCallback
	self.callbackObj = callbackObj
	self.charIndex = 1
	self.charCount = 0

	self:_onPlay()
end

function NecrologistStoryTextAnimBase:_onPlay()
	return
end

function NecrologistStoryTextAnimBase:stop()
	return
end

function NecrologistStoryTextAnimBase:isDone()
	return self.charIndex and self.charCount and self.charIndex > self.charCount
end

function NecrologistStoryTextAnimBase:setText(text)
	self.curText = text
	self.textComponent.text = text
end

function NecrologistStoryTextAnimBase:getTextStr()
	return self.curText
end

function NecrologistStoryTextAnimBase:onTextFinish()
	self:stop()

	self.charCount = self.charCount or 0
	self.charIndex = self.charCount + 1

	self:setText(self.metaText)
	self:doFinishCallback()
end

function NecrologistStoryTextAnimBase:doFinishCallback()
	if self.finishCallback then
		self.finishCallback(self.callbackObj)
	end
end

function NecrologistStoryTextAnimBase:doFrameCallback()
	if self.frameCallback then
		self.frameCallback(self.callbackObj)
	end
end

function NecrologistStoryTextAnimBase:onDestroy()
	self:stop()
end

function NecrologistStoryTextAnimBase:setTextDirect(text, finishCallback, callbackObj)
	self:stop()

	self.metaText = text

	self:setText(text)

	self.charIndex = 1
	self.charCount = 0

	if finishCallback then
		finishCallback(callbackObj)
	end
end

function NecrologistStoryTextAnimBase:isCanSkip()
	return true
end

return NecrologistStoryTextAnimBase
