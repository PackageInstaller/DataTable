-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/PlayMusicRecordMo.lua

module("logic.extensions.playmusic.view.PlayMusicRecordMo", package.seeall)

local PlayMusicRecordMo = class("PlayMusicRecordMo")

function PlayMusicRecordMo:ctor()
	return
end

function PlayMusicRecordMo:reset(gamePlanId)
	self._gamePlanId = gamePlanId
	self._planData = PlayMusicConfig.instance:getPmPlanData(self._gamePlanId)
	self._curGameTime = 0
	self._curComboNum = -1
	self._maxComboNum = 0
	self._curTotalScore = 0
end

function PlayMusicRecordMo:clear()
	self._gamePlanId = nil
	self._planData = nil
end

function PlayMusicRecordMo:destroy()
	return
end

function PlayMusicRecordMo:getCurGameTime()
	return self._curGameTime
end

function PlayMusicRecordMo:getCurTotalScore()
	return self._curTotalScore
end

function PlayMusicRecordMo:getCurTotalProgress()
	if self._planData.completeScore == 0 then
		return 0
	else
		return self._curTotalScore / self._planData.completeScore
	end
end

function PlayMusicRecordMo:getCurComboNum()
	return self._curComboNum
end

function PlayMusicRecordMo:getMaxComboNum()
	return self._maxComboNum
end

function PlayMusicRecordMo:addDeltaGameTime(deltaTime)
	self._curGameTime = self._curGameTime + deltaTime
end

function PlayMusicRecordMo:recordHit(symbolId, hitTimeRatio)
	local hitScore = 0
	local hitData = PlayMusicConfig.instance:getPmHitDataByIdAndRatio(symbolId, hitTimeRatio)

	if hitData and hitData.hitScore then
		hitScore = hitScore + hitData.hitScore
	end

	if hitData and hitData.isCanCombo then
		self._curComboNum = self._curComboNum + 1

		local comboData = PlayMusicConfig.instance:getPmComboDataByIdAndCount(self._gamePlanId, self._curComboNum)

		hitScore = hitScore + comboData.exFixedScore
	else
		self._curComboNum = -1
	end

	self._maxComboNum = Mathf.Max(self._maxComboNum, self._curComboNum)
	self._curTotalScore = Mathf.Clamp(self._curTotalScore + hitScore, 0, self._planData.completeScore)
end

function PlayMusicRecordMo:isEnoughCompleteScore()
	return self._curTotalScore >= self._planData.completeScore
end

return PlayMusicRecordMo
