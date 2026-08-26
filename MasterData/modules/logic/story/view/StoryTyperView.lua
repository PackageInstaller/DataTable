-- chunkname: @modules/logic/story/view/StoryTyperView.lua

module("modules.logic.story.view.StoryTyperView", package.seeall)

local StoryTyperView = class("StoryTyperView", BaseView)

function StoryTyperView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._gotyper1 = gohelper.findChild(self.viewGO, "#go_typer1")
	self._gologo = gohelper.findChild(self.viewGO, "#go_typer1/#go_logo")
	self._txttyper1 = gohelper.findChildText(self.viewGO, "#go_typer1/#txt_typer1")
	self._gotyper2 = gohelper.findChild(self.viewGO, "#go_typer2")
	self._txttyper2 = gohelper.findChildText(self.viewGO, "#go_typer2/#txt_typer2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryTyperView:addEvents()
	return
end

function StoryTyperView:removeEvents()
	return
end

local LetterInterval = 0.05
local LetterRandom = 0.2
local WordInterval = 0.3
local WordRandom = 0.1
local SentenceInterval = 0.8
local SentenceRandom = 0

function StoryTyperView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
	self._singleBg = gohelper.getSingleImage(self._gobg)

	self._singleBg:LoadImage(ResUrl.getStoryBg("typerbg.png"))
end

function StoryTyperView:onOpen()
	self._type = self.viewParam.type

	if self._type == 1 then
		if not self._txttyper1.text then
			local content = self._txttyper2.text

			content = self.viewParam.content and self.viewParam.content or content
			self._txttyper1.text = ""
			self._txttyper2.text = ""

			if self._type == 1 then
				local typerStartAnim = "start1"
				local text = self._txttyper1
				local typerEndAnim = "end1"
				local callback = self._type1End

				self:_playTyper(typerStartAnim, typerEndAnim, text, content, callback)
			elseif self._type == 2 then
				local typerStartAnim = "start2"
				local text = self._txttyper2
				local typerEndAnim = "end2"
				local callback = self._type2End

				self:_playTyper(typerStartAnim, typerEndAnim, text, content, callback)
			end
		end
	end
end

function StoryTyperView:_playTyper(typerStartAnim, typerEndAnim, text, content, callback)
	self._typerStartAnim = typerStartAnim
	self._typerEndAnim = typerEndAnim
	self._text = text
	self._content = content
	self._callback = callback

	if not string.nilorempty(self._typerStartAnim) then
		self._animatorPlayer:Play(self._typerStartAnim, self._delayStart, self)
	else
		self:_delayStart()
	end
end

function StoryTyperView:_delayStart()
	self._delayList = {}

	local len = string.len(self._content)

	for i = 1, len do
		local char = string.sub(self._content, i, i)

		if char == "\n" then
			local delay = SentenceInterval + math.random() * SentenceRandom

			table.insert(self._delayList, delay)
		elseif char == " " then
			local delay = WordInterval + math.random() * WordRandom

			table.insert(self._delayList, delay)
		else
			local delay = LetterInterval + math.random() * LetterRandom

			table.insert(self._delayList, delay)
		end
	end

	self._LetterIndex = 0

	self:_printLetter()
end

function StoryTyperView:_printLetter()
	self._LetterIndex = self._LetterIndex + 1
	self._text.text = string.sub(self._content, 1, self._LetterIndex)

	if self._LetterIndex < string.len(self._content) then
		local delay = self._delayList[self._LetterIndex]

		if delay > 0 then
			TaskDispatcher.runDelay(self._printLetter, self, delay)
		else
			self:_printLetter()
		end
	elseif not string.nilorempty(self._typerEndAnim) then
		self._animatorPlayer:Play(self._typerEndAnim, self._delayEnd, self)
	else
		self:_delayEnd()
	end
end

function StoryTyperView:_delayEnd()
	if self._callback then
		self:_callback()
	else
		self:closeThis()
	end
end

function StoryTyperView:_type1End()
	self:closeThis()
end

function StoryTyperView:_type2End()
	self:closeThis()
end

function StoryTyperView:onClose()
	TaskDispatcher.cancelTask(self._printLetter, self)
end

function StoryTyperView:onDestroyView()
	self._singleBg:UnLoadImage()
end

return StoryTyperView
