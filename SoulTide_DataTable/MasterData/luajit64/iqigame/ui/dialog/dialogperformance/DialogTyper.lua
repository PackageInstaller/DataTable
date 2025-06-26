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

function m:Start(textGo, content, beforeContents)
	self:Clear()

	self.TextComponent = textGo:GetComponent("Text")
	self.Content = content
	self.BeforeContents = beforeContents
	self.Started = true

	local this = self

	xpcall(function()
		local utf8CharLength = string.getUTF8Length(this.Content)

		this.HtmlNodes = {}

		local isHtmlStyleChar = false
		local htmlStyleIndex = 0
		local htmlNodeStr = ""

		this.Chars = {}

		for i = 1, utf8CharLength do
			local char = string.subUTF8(this.Content, i, 1)

			if char == "<" then
				if htmlStyleIndex == 0 then
					htmlStyleIndex = this:GenerateHtmlStyleIndex()
				end

				isHtmlStyleChar = true
			end

			if isHtmlStyleChar then
				htmlNodeStr = htmlNodeStr .. char
			else
				table.insert(this.Chars, {
					value = char,
					htmlStyleIndex = htmlStyleIndex
				})

				this.UTF8CharLength = this.UTF8CharLength + 1
			end

			if char == ">" then
				if string.find(htmlNodeStr, "/") == nil then
					local htmlNode = {}

					htmlNode[1] = htmlNodeStr
					this.HtmlNodes[htmlStyleIndex] = htmlNode
				else
					this.HtmlNodes[htmlStyleIndex][2] = htmlNodeStr
					htmlStyleIndex = 0
				end

				isHtmlStyleChar = false
				htmlNodeStr = ""
			end
		end
	end, function(msg)
		logError("DialogTyper 解析富文本错误: " .. tostring(msg) .. "\n原富文本：" .. this.Content)
	end)
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
