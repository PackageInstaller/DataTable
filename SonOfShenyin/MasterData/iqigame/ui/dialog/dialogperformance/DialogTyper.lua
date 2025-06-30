-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogTyper.lua

local m = {
	CurrentContent = "",
	SingleLetterElapsedTime = 0,
	Started = false,
	HtmlStyleIndex = 0,
	TypeInterval = 0.05,
	UTF8CharLength = 0,
	LastHtmlStyleIndex = 0,
	CharPointer = 1
}

function m.New()
	return Clone(m)
end

function m:SetTypeInterval(value)
	self.TypeInterval = value
end

function m:Start(textComponent, content, beforeContents)
	self:Clear()

	self.TextComponent = textComponent
	self.Content = content
	self.BeforeContents = beforeContents
	self.Started = true

	local utf8CharLength = string.getUTF8Length(content)

	self.HtmlNodes = {}

	local isHtmlStyleChar = false
	local htmlStyleIndex = 0
	local htmlNodeStr = ""

	self.Chars = {}

	for i = 1, utf8CharLength do
		local char = string.subUTF8(content, i, 1)

		if char == "<" then
			if htmlStyleIndex == 0 then
				htmlStyleIndex = self:GenerateHtmlStyleIndex()
			end

			isHtmlStyleChar = true
		end

		if isHtmlStyleChar then
			htmlNodeStr = htmlNodeStr .. char
		else
			table.insert(self.Chars, {
				value = char,
				htmlStyleIndex = htmlStyleIndex
			})

			self.UTF8CharLength = self.UTF8CharLength + 1
		end

		if char == ">" then
			if string.find(htmlNodeStr, "/") == nil then
				local htmlNode = {}

				htmlNode[1] = htmlNodeStr
				self.HtmlNodes[htmlStyleIndex] = htmlNode
			else
				self.HtmlNodes[htmlStyleIndex][2] = htmlNodeStr
				htmlStyleIndex = 0
			end

			isHtmlStyleChar = false
			htmlNodeStr = ""
		end
	end
end

function m:GenerateHtmlStyleIndex()
	self.HtmlStyleIndex = self.HtmlStyleIndex + 1

	return self.HtmlStyleIndex
end

function m:Stop()
	if self.Started then
		self:TypeComplete()
	end
end

function m:Update(elapseSeconds, realElapseSeconds)
	if not self.Started then
		return
	end

	self.SingleLetterElapsedTime = self.SingleLetterElapsedTime + elapseSeconds

	if self.SingleLetterElapsedTime > self.TypeInterval then
		self.SingleLetterElapsedTime = 0

		if self.CharPointer >= self.UTF8CharLength then
			self:TypeComplete()

			return
		end

		local charData = self.Chars[self.CharPointer]

		if self.LastHtmlStyleIndex ~= charData.htmlStyleIndex then
			if self.LastHtmlStyleIndex ~= 0 then
				self.CurrentContent = self.CurrentContent .. self.HtmlNodes[self.LastHtmlStyleIndex][2]
			end

			if charData.htmlStyleIndex ~= 0 then
				self.CurrentContent = self.CurrentContent .. self.HtmlNodes[charData.htmlStyleIndex][1] .. charData.value
			else
				self.CurrentContent = self.CurrentContent .. charData.value
			end
		else
			self.CurrentContent = self.CurrentContent .. charData.value
		end

		self.LastHtmlStyleIndex = charData.htmlStyleIndex
		self.TextComponent.text = self:GetFullText(self.CurrentContent .. (charData.htmlStyleIndex ~= 0 and self.HtmlNodes[charData.htmlStyleIndex][2] or ""))
		self.CharPointer = self.CharPointer + 1
	end
end

function m:TypeComplete()
	self.TextComponent.text = self:GetFullText(self.Content)

	self:Clear()
end

function m:GetFullText(text)
	if self.BeforeContents == nil then
		return text
	end

	local fullText = ""

	for i = 1, #self.BeforeContents do
		fullText = fullText .. self.BeforeContents[i]
	end

	return fullText .. text
end

function m:Clear()
	self.TextComponent = nil
	self.Content = nil
	self.Chars = nil
	self.UTF8CharLength = 0
	self.CurrentContent = ""
	self.CharPointer = 1
	self.SingleLetterElapsedTime = 0
	self.Started = false
	self.HtmlStyleIndex = 0
	self.HtmlNodes = nil
	self.LastHtmlStyleIndex = 0
end

return m
