-- chunkname: @IQIGame\\Net\\NetAmusementParkResponse.lua

function net_amusementPark.getAmusementParkInfoResult(code, amusementParkInfoPOD)
	AmusementParkModule.GetAmusementParkInfoResult(amusementParkInfoPOD)
end

function net_amusementPark.getAmusementParkInfoTemporarilyResult(code, unitList)
	AmusementParkModule.GetAmusementParkInfoTemporarilyResult(unitList)
end

function net_amusementPark.buildResult(code, id)
	AmusementParkModule.BuildResult(id)
end

function net_amusementPark.changeLayoutResult(code, amusementParkAttPOD)
	AmusementParkModule.ChangeLayoutResult(amusementParkAttPOD)
end

function net_amusementPark.confirmChangesResult(code, amusementParkAttPOD, unitList)
	AmusementParkModule.ConfirmChangesResult(amusementParkAttPOD, unitList)
end

function net_amusementPark.parkLevelUpResult(code, id)
	AmusementParkModule.ParkLevelUpResult(id)
end

function net_amusementPark.randomActionFigureResult_delegate(code, amusementParkVoRolePODs)
	NetCommController.Responded()

	if code ~= 0 then
		if code == 55008 then
			NoticeModule.ShowNotice(21066302)

			return
		end

		NoticeModule.ShowServerError(code)

		return
	end

	net_amusementPark.randomActionFigureResult(code, amusementParkVoRolePODs)
end

function net_amusementPark.randomActionFigureResult(code, amusementParkVoRolePODs)
	AmusementParkModule.RandomActionFigureResult(amusementParkVoRolePODs)
end

function net_amusementPark.recruitResult(code, amusementParkVoRoles, amusementParkVoRolesHave)
	AmusementParkModule.RecruitResult(amusementParkVoRoles, amusementParkVoRolesHave)
end

function net_amusementPark.roleLevelUpResult(code, amusementParkVoRolePOD)
	AmusementParkModule.RoleLevelUpResult(amusementParkVoRolePOD)
end

function net_amusementPark.roleDeployResult(code, amusementParkLandPOD)
	AmusementParkModule.RoleDeployResult(amusementParkLandPOD)
end

function net_amusementPark.roleUnDeployResult(code, amusementParkLandPOD)
	AmusementParkModule.RoleUnDeployResult(amusementParkLandPOD)
end

function net_amusementPark.openDialogResult(code, dialogCid)
	AmusementParkModule.OpenDialogResult(dialogCid)
end

function net_amusementPark.selectDialogResult(code, nextDialogCid)
	AmusementParkModule.SelectDialogResult(nextDialogCid)
end

function net_amusementPark.receiveIncomeResult(code, items)
	AmusementParkModule.ReceiveIncomeResult(items)
end

function net_amusementPark.combatTrainingResult(code)
	AmusementParkModule.CombatTrainingResult()
end

function net_amusementPark.bossTrainingResult(code)
	AmusementParkModule.BossTrainingResult()
end

function net_amusementPark.readBurstResult(code)
	AmusementParkModule.ReadBurstResult()
end

function net_amusementPark.dollMachineInfoResult(code, level, score)
	AmusementParkDollMachineGameModule.DollMachineInfoResult(level, score)
end

function net_amusementPark.dollMachineResult(code, level, score)
	AmusementParkDollMachineGameModule.DollMachineResult(level, score)
end

function net_amusementPark.pixelBirdInfoResult(code, level, score)
	AmusementParkBirdGameModule.PixelBirdInfoResult(level, score)
end

function net_amusementPark.pixelBirdResult(code, level, score)
	AmusementParkBirdGameModule.PixelBirdResult(level, score)
end

function net_amusementPark.getLittleGameInfoResult(code, info)
	AmusementParkModule.GetLittleGameInfoResult(info)
end

function net_amusementPark.answerInfoResult(code, score)
	AmusementParkAnswerGameModule.AnswerInfoResult(score)
end

function net_amusementPark.answerResult(code, score, items)
	AmusementParkAnswerGameModule.AnswerResult(score, items)
end

function net_amusementPark.stackingInfoResult(code, maxLv, score)
	AmusementParkPuzzleGameModule.StackingInfoResult(maxLv, score)
end

function net_amusementPark.stackingResult(code, maxLv, score)
	AmusementParkPuzzleGameModule.StackingResult(maxLv, score)
end

function net_amusementPark.oneStrokeInfoResult(code, score)
	AmusementParkOneConnectGameModule.OneStrokeInfoResult(score)
end

function net_amusementPark.oneStrokeResult(code, score)
	AmusementParkOneConnectGameModule.OneStrokeResult(score)
end

function net_amusementPark.notifyAmusementParkInfo(amusementParkLandPODs, post)
	AmusementParkModule.NotifyAmusementParkInfo(amusementParkLandPODs, post)
end

function net_amusementPark.notifyAmusementParkInfoPOD(amusementParkAttPOD)
	AmusementParkModule.NotifyAmusementParkInfoPOD(amusementParkAttPOD)
end

function net_amusementPark.notifyEventIsFinish(eventId)
	AmusementParkModule.NotifyEventIsFinish(eventId)
end

function net_amusementPark.notifyReceiveIncome(num)
	AmusementParkModule.NotifyReceiveIncome(num)
end

function net_amusementPark.notifyEmergency(list)
	AmusementParkModule.NotifyEmergency(list)
end

function net_amusementPark.notifyBossTraining(win, cid, dmgRecords)
	AmusementParkModule.NotifyBossTraining(win, cid, dmgRecords)
end

function net_amusementPark.notifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
	AmusementParkModule.NotifyCombatTrainingBossEnd(win, cid, dmgRecords, items, monster)
end

function net_amusementPark.notifyItemGMAdd(items)
	AmusementParkModule.NotifyItemGMAdd(items)
end
