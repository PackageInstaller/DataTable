-- chunkname: @modules/logic/necrologiststory/view/comp/NecrologistStoryTextComp.lua

module("modules.logic.necrologiststory.view.comp.NecrologistStoryTextComp", package.seeall)

local NecrologistStoryTextComp = class("NecrologistStoryTextComp", LuaCompBase)
local AnimClassMap = {
	[NecrologistStoryEnum.DialogTextAnimType.Typewriter] = NecrologistStoryTextAnimTypewriter,
	[NecrologistStoryEnum.DialogTextAnimType.Word] = NecrologistStoryTextAnimWord
}

function NecrologistStoryTextComp:ctor(params)
	self.wordItemRes = params.wordRes
end

function NecrologistStoryTextComp:init(go)
	self.txtGO = go
	self.transform = go.transform
	self.textComponent = gohelper.findChildTextMesh(go, "")
end

function NecrologistStoryTextComp:setAnimType(animType)
	if self.animType == animType and self._anim then
		return
	end

	self.animType = animType

	if self._anim then
		self._anim:onDestroy()

		self._anim = nil
	end

	local cls = AnimClassMap[animType]

	if cls then
		self._anim = cls.New(self)
	end
end

function NecrologistStoryTextComp:setTextNormal(text, finishCallback, callbackObj)
	if not self._anim then
		self.metaText = text
		self.textComponent.text = text

		if finishCallback then
			finishCallback(callbackObj)
		end

		return
	end

	self._anim:setTextDirect(text, finishCallback, callbackObj)
end

function NecrologistStoryTextComp:setTextWithAnim(text, frameCallback, finishCallback, callbackObj)
	if not self._anim then
		return
	end

	self._anim:play(text, frameCallback, finishCallback, callbackObj)
end

function NecrologistStoryTextComp:isDone()
	return self._anim and self._anim:isDone() or false
end

function NecrologistStoryTextComp:getTextStr()
	return self._anim and self._anim:getTextStr() or ""
end

function NecrologistStoryTextComp:clearTextTimer()
	if self._anim then
		self._anim:stop()
	end
end

function NecrologistStoryTextComp:onTextFinish()
	if self._anim then
		self._anim:onTextFinish()
	end
end

function NecrologistStoryTextComp:isCanSkip()
	if not self._anim then
		return true
	end

	return self._anim:isCanSkip()
end

function NecrologistStoryTextComp:onDestroy()
	if self._anim then
		self._anim:onDestroy()

		self._anim = nil
	end
end

return NecrologistStoryTextComp
