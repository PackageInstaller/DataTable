-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/model/PeakTournamentFormationCustomFmtMo.lua

module("logic.extensions.peaktournament.model.PeakTournamentFormationCustomFmtMo", package.seeall)

local PeakTournamentFormationCustomFmtMo = class("PeakTournamentFormationCustomFmtMo", PeakTournamentBaseCustomFmtMo)

function PeakTournamentFormationCustomFmtMo:onReset()
	PeakTournamentFormationCustomFmtMo.super.onReset(self)
end

function PeakTournamentFormationCustomFmtMo:updateCfg(activityId)
	self._activityId = checknumber(activityId)
	self._lockedRaceIdMap = {}

	local banRaceIds = PeakTournamentModel.instance:getMyDefenseFormBanRaceIds() or {}

	for _, raceId in ipairs(banRaceIds) do
		self._lockedRaceIdMap[raceId] = true
	end
end

function PeakTournamentFormationCustomFmtMo:updateData()
	PeakTournamentFormationCustomFmtMo.super.updateData(self)
end

function PeakTournamentFormationCustomFmtMo:initSaveHandler()
	self.setSaveHandler(self, self._saveMyFmtsInFOmation, self)
end

function PeakTournamentFormationCustomFmtMo:isClickCanCloseInFomation()
	return not self:checkFormationLimitAndPopWin()
end

function PeakTournamentFormationCustomFmtMo:_saveMyFmtsInFOmation()
	if not self:checkFormationLimitAndPopWin() then
		self:saveMyFmts()
	end
end

function PeakTournamentFormationCustomFmtMo:checkFormationLimitAndPopWin()
	local isLimit = not PeakTournamentController.instance:isAllFmtNotEmptyByFmtMos(self.formationMoList)

	if isLimit then
		local tip = langPara("存在空阵，无法正常参与巅峰赛，请保证每个阵容至少有1个精灵上阵后继续")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	end

	return isLimit
end

function PeakTournamentFormationCustomFmtMo:getFormationMos()
	return self.formationMoList
end

function PeakTournamentFormationCustomFmtMo:refreshMyFmts()
	local formInfoList = PeakTournamentModel.instance:getMyDefenseFormInfoList()

	if formInfoList then
		for _, formInfo in ipairs(formInfoList) do
			self.formationMoList[formInfo.formId]:SetData(formInfo.view.curForm)
		end
	end
end

function PeakTournamentFormationCustomFmtMo:getIsDefense()
	return true
end

function PeakTournamentFormationCustomFmtMo:checkIsCanJumpOut()
	return not self:checkFormationLimitAndPopWin()
end

return PeakTournamentFormationCustomFmtMo
