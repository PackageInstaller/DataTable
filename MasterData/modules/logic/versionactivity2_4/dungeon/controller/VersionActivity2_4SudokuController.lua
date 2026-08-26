-- chunkname: @modules/logic/versionactivity2_4/dungeon/controller/VersionActivity2_4SudokuController.lua

module("modules.logic.versionactivity2_4.dungeon.controller.VersionActivity2_4SudokuController", package.seeall)

local VersionActivity2_4SudokuController = class("VersionActivity2_4SudokuController", BaseController)

function VersionActivity2_4SudokuController:onInit()
	return
end

function VersionActivity2_4SudokuController:reInit()
	return
end

function VersionActivity2_4SudokuController:openSudokuView()
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	VersionActivity2_4SudokuModel.instance:clearCmd()
	ViewMgr.instance:openView(ViewName.VersionActivity2_4SudokuView)
	self:initStatData()
end

function VersionActivity2_4SudokuController:excuteNewCmd(cmd)
	VersionActivity2_4SudokuModel.instance:pushCmd(cmd)
	self:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, cmd)
end

function VersionActivity2_4SudokuController:excuteLastCmd()
	local cmd = VersionActivity2_4SudokuModel.instance:popCmd()

	if cmd then
		cmd:undo()
		self:dispatchEvent(VersionActivity2_4DungeonEvent.DoSudokuCmd, cmd)
		self:addUndoCount()
	else
		self:resetGame()
	end
end

function VersionActivity2_4SudokuController:resetGame()
	VersionActivity2_4SudokuModel.instance:selectItem(nil)
	VersionActivity2_4SudokuModel.instance:selectKeyboardItem(nil)
	self:dispatchEvent(VersionActivity2_4DungeonEvent.SudokuReset)
	self:setStatResult("reset")
	self:sendStat()
	self:initStatData()
end

function VersionActivity2_4SudokuController:initStatData()
	self._statMo = VersionActivity2_4SudokuMo.New()
end

function VersionActivity2_4SudokuController:setStatResult(result)
	self._statMo:setResult(result)
end

function VersionActivity2_4SudokuController:addUndoCount()
	self._statMo:addUndoCount()
end

function VersionActivity2_4SudokuController:addErrorCount()
	self._statMo:addErrorCount()
end

function VersionActivity2_4SudokuController:sendStat()
	self._statMo:sendStatData()
end

VersionActivity2_4SudokuController.instance = VersionActivity2_4SudokuController.New()

return VersionActivity2_4SudokuController
