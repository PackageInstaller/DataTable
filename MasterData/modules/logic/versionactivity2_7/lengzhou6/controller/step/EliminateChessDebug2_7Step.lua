-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/controller/step/EliminateChessDebug2_7Step.lua

module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessDebug2_7Step", package.seeall)

local EliminateChessDebug2_7Step = class("EliminateChessDebug2_7Step", EliminateChessStepBase)

function EliminateChessDebug2_7Step:onStart()
	if not isDebugBuild then
		self:onDone(true)

		return
	end

	local chess = LengZhou6EliminateChessItemController.instance:getChess()
	local chessMo = LocalEliminateChessModel.instance:getAllCell()
	local chessStr = "\n"

	for j = #chess, 1, -1 do
		local printStr = ""

		for i = 1, #chess[j] do
			local value = 0
			local id = -1

			if chess[i][j] ~= nil then
				local cell = chess[i][j]:getData()

				if cell ~= nil then
					local status = cell:getStatus()

					for k = 1, #status do
						value = value + status[k]
					end

					id = cell.id
				end
			end

			printStr = printStr .. id .. "[" .. value .. "]" .. " "
		end

		chessStr = chessStr .. printStr .. "\n"
	end

	local chessMOStr = "\n"

	for j = #chessMo, 1, -1 do
		local printStr = ""

		for i = 1, #chessMo[j] do
			local cell = chessMo[i][j]
			local status = cell:getStatus()
			local value = 0

			for k = 1, #status do
				value = value + status[k]
			end

			printStr = printStr .. cell.id .. "[" .. value .. "]" .. " "
		end

		chessMOStr = chessMOStr .. printStr .. "\n"
	end

	logNormal("chessStr = " .. chessStr)
	logNormal("chessMOStr = " .. chessMOStr)
	self:onDone(true)
end

return EliminateChessDebug2_7Step
