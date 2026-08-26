-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4SudokuCmd.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuCmd", package.seeall)

local VersionActivity2_4SudokuCmd = class("VersionActivity2_4SudokuCmd")

function VersionActivity2_4SudokuCmd:ctor(idx, oriNum, newNum)
	self._idx = idx
	self._oriNum = oriNum
	self._newNum = newNum
	self._undo = false
end

function VersionActivity2_4SudokuCmd:getIdx()
	return self._idx
end

function VersionActivity2_4SudokuCmd:getOriNum()
	return self._oriNum
end

function VersionActivity2_4SudokuCmd:getNewNum()
	return self._newNum
end

function VersionActivity2_4SudokuCmd:isUndo()
	return self._undo
end

function VersionActivity2_4SudokuCmd:undo()
	self._oriNum = self._newNum
	self._newNum = self._oriNum
	self._undo = true
end

return VersionActivity2_4SudokuCmd
