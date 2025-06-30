-- chunkname: @IQIGame\\UI\\Common\\CenterText.lua

local m = {}

function m.New(textGo, canvasGo)
	local obj = Clone(m)

	obj:Init(textGo, canvasGo)

	return obj
end

function m:Init(textGo, canvasGo)
	self.TextGo = textGo
	self.TextGenerator = IQIGame.Onigao.Game.PreBindSettingTextGenerator(self.TextGo:GetComponent("Text"))
	self.CanvasReferenceResolution = canvasGo:GetComponent("CanvasScaler").referenceResolution
end

function m:Center(text, maxWidth)
	if maxWidth == nil then
		maxWidth = self.CanvasReferenceResolution.x
	end

	local textWidth = self.TextGenerator:GetPreferredWidth(text)

	textWidth = math.min(textWidth, maxWidth)

	local sizeDelta = self.TextGo.transform.sizeDelta

	sizeDelta.x = textWidth
	self.TextGo.transform.sizeDelta = sizeDelta
end

function m:Dispose()
	self.TextGo = nil
	self.TextGenerator = nil
	self.CanvasReferenceResolution = nil
end

return m
