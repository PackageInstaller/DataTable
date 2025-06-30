-- chunkname: @IQIGame\\UI\\Dialog\\DialogTextPerformance.lua

local m = {}
local TyperComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogTyper")

function m.New()
	local obj = Clone(m)

	obj.PerformanceComponents = {}
	obj.Typer = TyperComponent.New()

	table.insert(obj.PerformanceComponents, obj.Typer)

	return obj
end

function m:SetTypeInterval(value)
	self.Typer:SetTypeInterval(value)
end

function m:Update(elapseSeconds, realElapseSeconds)
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Update(elapseSeconds, realElapseSeconds)
	end
end

function m:Perform(textComponent, content, beforeContents)
	self.Typer:Start(textComponent, content, beforeContents)
end

function m:StopAll()
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Stop()
	end
end

function m:ResetGameObject(textComponent)
	textComponent.text = ""
end

function m:IsTypeFinished()
	return not self.Typer.Started
end

return m
