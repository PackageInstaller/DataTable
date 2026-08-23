local var_0_0 = g.core.config.game_eliminate_point_info
local var_0_1 = g.core.config.game_eliminate_point_info.getLength()
local WaitGameData = class("WaitGameData", require("app.core.model.BaseData"))

function WaitGameData:ctor()
	self:initData()
end

function WaitGameData:initData()
	self._maxCombo = 0
	self._totalEliScore = 0
	self._totalComboScore = 0
	self._comboScoreArr = {}
	self._downLoadAwards = false

	self:_initComboScoreArr()
end

function WaitGameData:onS2CNewDownloadAward(arg_3_1)
	self._downLoadAwards = true
end

function WaitGameData:onS2CRedPoint(arg_4_1)
	if arg_4_1.award_time and arg_4_1.award_time > 0 then
		self._downLoadAwards = true
	end
end

function WaitGameData:isGetNewDownLoadAward()
	return self._downLoadAwards
end

function WaitGameData:getSilentDownLoadTag()
	if config.UPGRADE_SILENT_ENABLED then
		if (g.core.common.Storage:load("upgrade_silent_info_" .. g.core.utils.Tools.getSilentObbVersion() .. ".json", false) or {}).isAllFinished then
			return true
		else
			return false
		end
	end

	return false
end

function WaitGameData:_initComboScoreArr()
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in var_0_0.ipairs() do
		var_7_0[iter_7_1.id] = iter_7_1.point
	end

	self._comboScoreArr = var_7_0
end

function WaitGameData:getComboScore(arg_8_1)
	arg_8_1 = math.min(var_0_1, arg_8_1)

	return self._comboScoreArr[arg_8_1]
end

function WaitGameData:refreshCombo(arg_9_1)
	local var_9_0 = self:getComboScore(arg_9_1)

	if arg_9_1 == 1 then
		self._totalEliScore = self._totalEliScore + var_9_0
	else
		self._totalComboScore = self._totalComboScore + var_9_0
	end

	self._maxCombo = math.max(self._maxCombo, arg_9_1)
end

function WaitGameData:clearDataOnStartGame()
	self._totalEliScore = 0
	self._totalComboScore = 0
	self._maxCombo = 0
end

function WaitGameData:getTotalScore()
	return self._totalEliScore + self._totalComboScore
end

function WaitGameData:getMaxComboNum()
	return self._maxCombo
end

return WaitGameData
