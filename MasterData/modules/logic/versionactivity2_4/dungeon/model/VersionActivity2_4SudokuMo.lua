-- chunkname: @modules/logic/versionactivity2_4/dungeon/model/VersionActivity2_4SudokuMo.lua

module("modules.logic.versionactivity2_4.dungeon.model.VersionActivity2_4SudokuMo", package.seeall)

local VersionActivity2_4SudokuMo = pureTable("VersionActivity2_4SudokuMo")
local resultStatUse = {
	["break"] = "中断",
	done = "成功",
	reset = "重新开始"
}

function VersionActivity2_4SudokuMo:ctor()
	self.beginTime = Time.realtimeSinceStartup
	self.undoNum = 0
	self.erroNum = 0
end

function VersionActivity2_4SudokuMo:setResult(result)
	self.result = result
end

function VersionActivity2_4SudokuMo:addUndoCount()
	self.undoNum = self.undoNum + 1
end

function VersionActivity2_4SudokuMo:addErrorCount()
	self.erroNum = self.erroNum + 1
end

function VersionActivity2_4SudokuMo:sendStatData()
	StatController.instance:track(StatEnum.EventName.SudokuResult, {
		[StatEnum.EventProperties.UseTime] = Time.realtimeSinceStartup - self.beginTime,
		[StatEnum.EventProperties.Result] = resultStatUse[self.result],
		[StatEnum.EventProperties.SudokuBackNum] = self.undoNum,
		[StatEnum.EventProperties.SudokuErrorNum] = self.erroNum
	})
end

return VersionActivity2_4SudokuMo
