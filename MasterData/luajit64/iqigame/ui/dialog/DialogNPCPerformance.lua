-- chunkname: @IQIGame\\UI\\Dialog\\DialogNPCPerformance.lua

local m = {
	TYPE_FADE = 3,
	TYPE_DARKEN = 5,
	TYPE_MOVE = 1,
	TYPE_CUSTOM_MOVE = 9,
	TYPE_EFFECT = 7,
	TYPE_SCALE = 2,
	TYPE_ROTATE = 4,
	TYPE_MOVE_AROUND = 6
}
local PerformanceData = require("IQIGame.UI.Dialog.DialogPerformance.DialogPerformanceData")
local MoveComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogMove")
local ScaleComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogScale")
local FadeComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogFade")
local MoveAroundComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogMoveAround")
local EffectComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogEffect")
local DarkenComponent = require("IQIGame.UI.Dialog.DialogPerformance.DialogDarken")

function m.New()
	local obj = Clone(m)

	obj.PerformanceComponents = {}

	return obj
end

function m:AddPerformComponent(componentClass, userData)
	local component = componentClass.New(userData)

	table.insert(self.PerformanceComponents, component)

	return component
end

function m:SetNpcPositions(positions)
	self.NpcAnchoredPositions = positions
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

function m:Perform(npcPortrait, npcPerformanceIDs, dialogUI)
	for i = 1, #npcPerformanceIDs do
		self:PerformSingleNpc(npcPortrait, npcPerformanceIDs[i], dialogUI)
	end
end

function m:PerformSingleNpc(npcPortrait, npcPerformanceID, dialogUI)
	if npcPortrait.NpcCid == 0 then
		return
	end

	if npcPerformanceID == 0 or npcPerformanceID == nil then
		logError("npc表现配置错误，performance id = " .. tostring(npcPerformanceID))

		return
	end

	local gameObject = npcPortrait.PointGO
	local performanceData = PerformanceData.New(gameObject, CfgPlayerPerformanceTable[npcPerformanceID])
	local type = performanceData.Type
	local strParams = performanceData.CfgData.PerformanceParameter
	local rawParams = {}

	for i = 1, #strParams do
		if type ~= m.TYPE_DARKEN then
			rawParams[i] = tonumber(strParams[i])
		else
			rawParams[i] = strParams[i]
		end
	end

	local params = {}

	if type == m.TYPE_MOVE then
		params[1] = self.NpcAnchoredPositions[rawParams[1]]
		params[2] = gameObject.transform.anchoredPosition3D
		params[3] = rawParams[2]

		self:AddPerformComponent(MoveComponent):Start(performanceData, params)
	elseif type == m.TYPE_SCALE then
		params[1] = Vector3(rawParams[1], rawParams[1], 1)
		params[2] = Vector3(rawParams[2], rawParams[2], 1)
		params[3] = rawParams[3]

		if rawParams[4] ~= nil and rawParams[5] ~= nil and rawParams[6] ~= nil and rawParams[7] ~= nil then
			params[4] = Vector3(rawParams[4], rawParams[5], 0)
			params[5] = Vector3(rawParams[6], rawParams[7], 0)
		end

		self:AddPerformComponent(ScaleComponent):Start(performanceData, params)
	elseif type == m.TYPE_ROTATE then
		gameObject.transform.rotation = Quaternion.Euler(rawParams[1], rawParams[2], rawParams[3])
	elseif type == m.TYPE_DARKEN then
		params[1] = rawParams[1]

		self:AddPerformComponent(DarkenComponent, {
			npcPortrait = npcPortrait
		}):Start(performanceData, params)
	elseif type == m.TYPE_FADE then
		params[1] = rawParams[1]
		params[2] = rawParams[2]
		params[3] = rawParams[3]

		self:AddPerformComponent(FadeComponent, {
			type = Constant.DialogPerformance.TYPE_NPC,
			npcPortrait = npcPortrait
		}):Start(performanceData, params)
	elseif type == m.TYPE_MOVE_AROUND then
		params[1] = rawParams[1]
		params[2] = rawParams[2]
		params[3] = rawParams[3]
		params[4] = rawParams[4]

		self:AddPerformComponent(MoveAroundComponent):Start(performanceData, params)
	elseif type == m.TYPE_EFFECT then
		params[1] = rawParams[1]
		params[2] = rawParams[2]
		params[3] = rawParams[3]

		local relativeOrder = rawParams[4]

		if relativeOrder == nil then
			relativeOrder = 0
		end

		params[4] = dialogUI.View:GetComponent("Canvas").sortingOrder + relativeOrder

		self:AddPerformComponent(EffectComponent):Start(performanceData, params)
	elseif type == m.TYPE_CUSTOM_MOVE then
		params[1] = gameObject.transform.anchoredPosition3D + Vector3(rawParams[1], rawParams[2], 0)
		params[2] = gameObject.transform.anchoredPosition3D + Vector3(rawParams[3], rawParams[4], 0)
		params[3] = rawParams[5]

		self:AddPerformComponent(MoveComponent):Start(performanceData, params)
	end
end

function m:StopAll()
	for i = 1, #self.PerformanceComponents do
		self.PerformanceComponents[i]:Stop()
	end

	self.PerformanceComponents = {}
end

function m:ResetGameObject(gameObject, index)
	gameObject.transform.anchoredPosition3D = self.NpcAnchoredPositions[index]
	gameObject.transform.localScale = Vector3.one
	gameObject.transform.rotation = Quaternion.identity
end

return m
