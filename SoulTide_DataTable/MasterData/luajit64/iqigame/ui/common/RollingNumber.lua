-- chunkname: @IQIGame\\UI\\Common\\RollingNumber.lua

local m = {
	Rolling = false,
	Value = -1,
	IsAutoHide = false,
	ImageHeight = 0,
	NumStrings = {}
}

function m.New(numNodes, isAutoHide, isRight)
	local obj = Clone(m)

	obj:Init(numNodes, isAutoHide, isRight)

	return obj
end

function m:Init(numNodes, isAutoHide, isRight)
	self.IsAutoHide = isAutoHide ~= nil and isAutoHide
	self.IsRight = self.IsAutoHide and isRight ~= nil and isRight
	self.NumImages = {}

	for i = 1, #numNodes do
		self.NumImages[i] = {}

		local imageNode = numNodes[i]

		self.NumImages[i][1] = imageNode.transform:Find("Text_1"):GetComponent("Text")
		self.NumImages[i][2] = imageNode.transform:Find("Text_2"):GetComponent("Text")
	end

	self.ImageHeight = self.NumImages[1][1].transform.sizeDelta.y

	self:SetNumber(0)
end

function m:SetNumber(value)
	self:RollTo(value)
	self:StopRolling()
end

function m:RollTo(value)
	if self.Value == value then
		return
	end

	self.Value = value

	if self.Rolling then
		self:StopRolling()
	end

	local valueStr = tostring(value)
	local valueLength = string.len(valueStr)

	if not self.IsAutoHide then
		local imageComponentLen = #self.NumImages
		local differenceValue = imageComponentLen - valueLength

		if differenceValue < 0 then
			differenceValue = 0
		end

		for i = 1, differenceValue do
			valueStr = "0" .. valueStr
		end

		valueLength = imageComponentLen
	end

	local hasValueChanged = false

	self.TargetNumStrings = {}

	for i = 1, #self.NumImages do
		local textComponent = self.NumImages[i][2]
		local numStr = "0"

		if i <= valueLength then
			local valueStrIndex = self.IsRight and valueLength - i + 1 or i

			numStr = string.sub(valueStr, valueStrIndex, valueStrIndex)
		end

		self.TargetNumStrings[i] = numStr

		if numStr ~= self.NumStrings[i] then
			textComponent.text = numStr
			hasValueChanged = true
		end

		textComponent.transform.parent.gameObject:SetActive(not self.IsAutoHide or i <= valueLength)
	end

	self.Rolling = hasValueChanged
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.Rolling then
		local isComplete = false

		for i = 1, #self.NumImages do
			local image1 = self.NumImages[i][1]
			local image2 = self.NumImages[i][2]

			if self.TargetNumStrings[i] ~= self.NumStrings[i] then
				local position1 = image1.transform.anchoredPosition
				local position2 = image2.transform.anchoredPosition

				position1.y = position1.y + elapseSeconds * self.ImageHeight * 2
				position2.y = position2.y + elapseSeconds * self.ImageHeight * 2
				image1.transform.anchoredPosition = position1
				image2.transform.anchoredPosition = position2
			end

			if image2.transform.anchoredPosition.y >= 0 then
				isComplete = true
			end
		end

		if isComplete then
			self:StopRolling()
		end
	end
end

function m:StopRolling()
	for i = 1, #self.NumImages do
		if self.TargetNumStrings[i] ~= self.NumStrings[i] then
			local image1 = self.NumImages[i][1]
			local image2 = self.NumImages[i][2]

			image1.transform.anchoredPosition = Vector2(0, self.ImageHeight * -1)
			image2.transform.anchoredPosition = Vector2(0, 0)
			self.NumImages[i][1] = image2
			self.NumImages[i][2] = image1
			self.NumStrings[i] = self.TargetNumStrings[i]
		end
	end

	self.Rolling = false
end

function m:Dispose()
	self.NumImages = nil
end

return m
