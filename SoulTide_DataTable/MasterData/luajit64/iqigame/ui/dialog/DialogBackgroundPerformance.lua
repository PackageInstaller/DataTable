-- chunkname: @IQIGame\\UI\\Dialog\\DialogBackgroundPerformance.lua

local m = {
	TYPE_FADE = 3,
	TYPE_SCALE = 2,
	TYPE_MOVE = 1,
	TYPE_ROLL = 4
}
local PerformanceData = require("IQIGame.UI.Dialog.DialogPerformance.DialogPerformanceData")
local MoveComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogMove")
local ScaleComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogScale")
local FadeComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogFade")
local RollComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogRoll")

function m.New()
	local obj = Clone(m)

	obj.PerformanceQueue = Queue.New()
	obj.PerformanceComponents = {}
	obj.Move = MoveComponent.New()

	table.insert(obj.PerformanceComponents, obj.Move)

	obj.Scale = ScaleComponent.New()

	table.insert(obj.PerformanceComponents, obj.Scale)

	obj.Fade = FadeComponent.New({
		type = Constant.DialogPerformance.TYPE_Background
	})

	table.insert(obj.PerformanceComponents, obj.Fade)

	obj.Roll = RollComponent.New()

	table.insert(obj.PerformanceComponents, obj.Roll)

	return obj
end

function m:SetInitParam(position)
	self.InitAnchoredPosition = position
end

function m:Update(elapseSeconds, realElapseSeconds)
	self:CheckAndStartOne()

	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Update(elapseSeconds, realElapseSeconds)
	end
end

function m:Perform(gameObject, bgPerformanceCids)
	local queue = self.PerformanceQueue

	for i = 1, #bgPerformanceCids do
		local bgPerformanceCid = bgPerformanceCids[i]

		if bgPerformanceCid ~= nil and bgPerformanceCid ~= 0 then
			queue:Enqueue(PerformanceData.New(gameObject, CfgBackgroundPerformanceTable[bgPerformanceCid]))
		end
	end

	self:CheckAndStartOne()
end

function m:StopAll()
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Stop()
	end

	self.PerformanceQueue:Clear()

	self.CurrentPerformance = nil
end

function m:ResetGameObject(gameObject)
	gameObject.transform.anchoredPosition3D = self.InitAnchoredPosition
	gameObject.transform.localScale = Vector3.one
end

function m:CheckAndStartOne()
	local performanceData

	if self.CurrentPerformance == nil or self.CurrentPerformance.Completed then
		if self.PerformanceQueue.Size > 0 then
			performanceData = self.PerformanceQueue:Dequeue()
		end

		self.CurrentPerformance = performanceData

		if performanceData ~= nil then
			self:SinglePerform(performanceData)
		end
	end
end

function m:SinglePerform(performanceData)
	local type = performanceData.Type
	local strParams = performanceData.CfgData.PerformanceParameter
	local rawParams = {}

	for i = 1, #strParams do
		rawParams[i] = tonumber(strParams[i])
	end

	local params = {}

	if type == m.TYPE_MOVE then
		local transform = performanceData.gameObject.transform

		params[1] = transform.anchoredPosition3D
		params[2] = transform.anchoredPosition3D + Vector3(rawParams[1], rawParams[2], 0)
		params[3] = rawParams[3]

		self.Move:Start(performanceData, params)
	elseif type == m.TYPE_SCALE then
		params[1] = performanceData.gameObject.transform.localScale
		params[2] = Vector3(rawParams[1], rawParams[1], 1)
		params[3] = rawParams[2]

		self.Scale:Start(performanceData, params)
	elseif type == m.TYPE_FADE then
		params[1] = rawParams[1]
		params[2] = rawParams[2]
		params[3] = rawParams[3]

		self.Fade:Start(performanceData, params)
	elseif type == m.TYPE_ROLL then
		params[1] = rawParams[1]
		params[2] = rawParams[2]

		self.Roll:Start(performanceData, params)
	end

	if performanceData.Completed then
		self:CheckAndStartOne()
	end
end

return m
