-- chunkname: @IQIGame\\UI\\Dialog\\DialogScreenPerformance.lua

local m = {
	TYPE_SHAKE = 1,
	TYPE_EFFECT = 2
}
local PerformanceData = require("IQIGame.UI.Dialog.DialogPerformance.DialogPerformanceData")
local ShakeComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogShake")
local EffectComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogEffect")

function m.New()
	local obj = Clone(m)

	obj.PerformanceComponents = {}

	return obj
end

function m:AddPerformComponent(componentClass)
	local component = componentClass.New()

	table.insert(self.PerformanceComponents, component)

	return component
end

function m:SetInitParam(position)
	self.InitAnchoredPosition = position
end

function m:Update(elapseSeconds, realElapseSeconds)
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Update(elapseSeconds, realElapseSeconds)
	end

	for i = #self.PerformanceComponents, 1, -1 do
		if not self.PerformanceComponents[i].Started then
			table.remove(self.PerformanceComponents, i)
		end
	end
end

function m:Perform(gameObject, screenPerformanceCids, dialogUI)
	for i = 1, #screenPerformanceCids do
		local screenPerformanceCid = screenPerformanceCids[i]

		if screenPerformanceCid ~= nil and screenPerformanceCid ~= 0 then
			self:SinglePerform(PerformanceData.New(gameObject, CfgScreenPerformanceTable[screenPerformanceCid]), dialogUI)
		end
	end
end

function m:StopAll()
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Stop()
	end
end

function m:ResetGameObject(gameObject)
	gameObject.transform.anchoredPosition3D = self.InitAnchoredPosition
end

function m:SinglePerform(performanceData, dialogUI)
	local type = performanceData.Type
	local strParams = performanceData.CfgData.PerformanceParameter
	local rawParams = {}

	for i = 1, #strParams do
		rawParams[i] = tonumber(strParams[i])
	end

	if type == m.TYPE_SHAKE then
		self:AddPerformComponent(ShakeComponent):Start(performanceData, rawParams)
	elseif type == m.TYPE_EFFECT then
		local params = {}

		params[1] = rawParams[1]
		params[2] = rawParams[2]
		params[3] = rawParams[3]

		local addSortingOrder = rawParams[4]

		if addSortingOrder == nil then
			addSortingOrder = 0
		end

		params[4] = dialogUI.View:GetComponent("Canvas").sortingOrder + addSortingOrder

		self:AddPerformComponent(EffectComponent):Start(performanceData, params)
	end
end

return m
