-- chunkname: @IQIGame\\UI\\Dialog\\DialogPerformance\\DialogPerformanceUtil.lua

local DialogDarken = require("IQIGame.UI.Dialog.DialogPerformance.DialogDarken")
local DialogEffect = require("IQIGame.UI.Dialog.DialogPerformance.DialogEffect")
local DialogFade = require("IQIGame.UI.Dialog.DialogPerformance.DialogFade")
local DialogMove = require("IQIGame.UI.Dialog.DialogPerformance.DialogMove")
local DialogMoveAround = require("IQIGame.UI.Dialog.DialogPerformance.DialogMoveAround")
local DialogRoll = require("IQIGame.UI.Dialog.DialogPerformance.DialogRoll")
local DialogScale = require("IQIGame.UI.Dialog.DialogPerformance.DialogScale")
local DialogShake = require("IQIGame.UI.Dialog.DialogPerformance.DialogShake")
local DialogTyper = require("IQIGame.UI.Dialog.DialogPerformance.DialogTyper")
local m = {
	PerformanceUnits = {}
}

function m.Init()
	table.insert(m.PerformanceUnits, DialogDarken)
	table.insert(m.PerformanceUnits, DialogEffect)
	table.insert(m.PerformanceUnits, DialogFade)
	table.insert(m.PerformanceUnits, DialogMove)
	table.insert(m.PerformanceUnits, DialogMoveAround)
	table.insert(m.PerformanceUnits, DialogRoll)
	table.insert(m.PerformanceUnits, DialogScale)
	table.insert(m.PerformanceUnits, DialogShake)
	table.insert(m.PerformanceUnits, DialogTyper)
end

function m.Reset(obj)
	for i = 1, #m.PerformanceUnits do
		local type = m.PerformanceUnits[i]

		if type.ResetHost ~= nil then
			type.ResetHost(obj)
		end
	end
end

m.Init()

return m
