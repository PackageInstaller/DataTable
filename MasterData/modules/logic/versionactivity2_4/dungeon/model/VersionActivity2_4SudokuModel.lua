-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4SudokuModel.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuModel", package.seeall)

local VersionActivity2_4SudokuModel = class("VersionActivity2_4SudokuModel", BaseModel)
local sudokuConfigPath = "modules.configs.sudoku.lua_sudoku_%s"

function VersionActivity2_4SudokuModel:onInit()
	self._operateCmdList = {}
end

function VersionActivity2_4SudokuModel:reInit()
	self:init()
end

function VersionActivity2_4SudokuModel:init()
	self._curSelectItemIdx = 0
end

function VersionActivity2_4SudokuModel:selectItem(idx)
	self._curSelectItemIdx = idx
end

function VersionActivity2_4SudokuModel:getSelectedItem()
	return self._curSelectItemIdx
end

function VersionActivity2_4SudokuModel:selectKeyboardItem(idx)
	self._curSelectKeyboardIdx = idx
end

function VersionActivity2_4SudokuModel:getSelectedKeyboardItem()
	return self._curSelectKeyboardIdx
end

function VersionActivity2_4SudokuModel:pushCmd(cmd)
	self._operateCmdList[#self._operateCmdList + 1] = cmd
end

function VersionActivity2_4SudokuModel:popCmd()
	if #self._operateCmdList == 0 then
		return nil
	end

	self._operateCmdList[#self._operateCmdList] = nil

	return self._operateCmdList[#self._operateCmdList]
end

function VersionActivity2_4SudokuModel:clearCmd()
	self._operateCmdList = {}
end

function VersionActivity2_4SudokuModel:getSudokuCfg(id)
	return (addGlobalModule(string.format(sudokuConfigPath, id), string.format("lua_chessgame_group_", id)))
end

VersionActivity2_4SudokuModel.instance = VersionActivity2_4SudokuModel.New()

return VersionActivity2_4SudokuModel
