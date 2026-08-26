-- chunkname: @modules/logic/necrologiststory/view/textanim/NecrologistStoryTextAnimWord.lua

module("modules.logic.necrologiststory.view.textanim.NecrologistStoryTextAnimWord", package.seeall)

local NecrologistStoryTextAnimWord = class("NecrologistStoryTextAnimWord", NecrologistStoryTextAnimBase)

function NecrologistStoryTextAnimWord:ctor(comp)
	NecrologistStoryTextAnimWord.super.ctor(self, comp)

	self.wordItemRes = comp.wordItemRes
	self._wordItems = {}
end

function NecrologistStoryTextAnimWord:_onPlay()
	self:setText(self.metaText)
	ZProj.UGUIHelper.RebuildLayout(self.transform.parent)

	self.charList = NecrologistStoryHelper.getUCharArr(self.metaText)
	self._wrapList = NecrologistStoryHelper.getEachCharWithTags(self.charList)

	self.textComponent:ForceMeshUpdate()

	self.textInfo = self.textComponent.textInfo
	self.charIndex = 1
	self.charCount = self.textInfo.characterCount
	self.characterInfo = self.textInfo.characterInfo
	self.showWordCount = 0
	self.textComponent.alpha = 0

	local tickInterval = self:getTickInterval()

	TaskDispatcher.runRepeat(self._tick, self, tickInterval)
end

function NecrologistStoryTextAnimWord:stop()
	TaskDispatcher.cancelTask(self._tick, self)
end

function NecrologistStoryTextAnimWord:_tick()
	if self:isDone() then
		self:onTextFinish()

		return
	end

	local data = self:_getShowData()

	if data then
		self:_showSingleWord(data)
		self:doFrameCallback()
	else
		self:_tick()
	end
end

function NecrologistStoryTextAnimWord:_getShowData()
	if self:isDone() then
		return
	end

	local data
	local index = self.charIndex
	local charInfo = self.characterInfo[index - 1]

	if charInfo.isVisible then
		data = {}

		local info = self._wrapList[index]

		data.text = info and info.wrapped

		local lineInfo = self.textInfo.lineInfo[charInfo.lineNumber]

		data.posX = (charInfo.origin + charInfo.xAdvance) * 0.5
		data.posY = (lineInfo.ascender + lineInfo.descender) * 0.5
	end

	self.charIndex = self.charIndex + 1

	return data
end

function NecrologistStoryTextAnimWord:_showSingleWord(data)
	if not data or not data.text then
		return
	end

	local item = self:_getWordItem(self.showWordCount)

	item.txt.text = data.text

	recthelper.setAnchor(item.transform, data.posX, data.posY)

	self.showWordCount = self.showWordCount + 1

	item.anim:Play("open", 0, 0)
end

function NecrologistStoryTextAnimWord:_getWordItem(index)
	local item = self._wordItems[index]

	if not item then
		item = {
			go = gohelper.clone(self.wordItemRes, self.txtGO)
		}
		item.transform = item.go.transform
		item.anim = gohelper.findChildAnim(item.go, "")
		item.txt = gohelper.findChildTextMesh(item.go, "txt")
		self._wordItems[index] = item
	end

	return item
end

function NecrologistStoryTextAnimWord:isCanSkip()
	return false
end

function NecrologistStoryTextAnimWord:onDestroy()
	NecrologistStoryTextAnimWord.super.onDestroy(self)

	self._wordItems = nil
end

return NecrologistStoryTextAnimWord
