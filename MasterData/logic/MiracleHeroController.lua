-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miraclehero/controller/MiracleHeroController.lua

module("logic.extensions.miraclehero.controller.MiracleHeroController", package.seeall)

local MiracleHeroController = class("MiracleHeroController", BaseController)

function MiracleHeroController:ctor()
	return
end

function MiracleHeroController:onReset()
	return
end

function MiracleHeroController:sendPM_MiracleHeroInfoReq(activityId)
	MiracleHeroAgent.instance:sendPM_MiracleHeroInfoReq(activityId)
end

function MiracleHeroController:handlePM_MiracleHeroInfoRes(msg)
	MiracleHeroModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroGetInfoRes)
end

function MiracleHeroController:sendPM_MiracleHeroRankInfoReq(activityId)
	MiracleHeroAgent.instance:sendPM_MiracleHeroRankInfoReq(activityId)
end

function MiracleHeroController:handlePM_MiracleHeroRankInfoRes(msg)
	MiracleHeroModel.instance:onGetRankInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroGetRankInfoRes)
end

function MiracleHeroController:sendPM_MiracleHeroUpgradePositionReq(activityId, posId)
	MiracleHeroAgent.instance:sendPM_MiracleHeroUpgradePositionReq(activityId, posId)
end

function MiracleHeroController:handlePM_MiracleHeroUpgradePositionRes(msg)
	MiracleHeroModel.instance:onUpgradePosition(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroUpgradePositionRes)
end

function MiracleHeroController:sendPM_MiracleHeroGetFormationReq(activityId)
	MiracleHeroAgent.instance:sendPM_MiracleHeroGetFormationReq(activityId)
end

function MiracleHeroController:handlePM_MiracleHeroGetFormationRes(msg)
	MiracleHeroModel.instance:onGetFormation(msg)
end

function MiracleHeroController:sendPM_MiracleHeroSetFormationReq(activityId, raceIds, assistId)
	local formPb = MiracleHeroExtension_pb.MiracleHeroFormation()

	for i = 1, 5 do
		local petId = checknumber(raceIds[i])

		formPb.raceIds:append(petId)
	end

	formPb.assistId = checknumber(assistId)

	MiracleHeroAgent.instance:sendPM_MiracleHeroSetFormationReq(activityId, formPb)
end

function MiracleHeroController:handlePM_MiracleHeroSetFormationRes(msg)
	MiracleHeroModel.instance:onSetFormation(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroSetFormationRes)
end

function MiracleHeroController:sendPM_MiracleHeroChallengeReq(activityId, challengeId, stageId, raceIds, assistId, battleViewName)
	local formPb = MiracleHeroExtension_pb.MiracleHeroFormation()

	for i = 1, 5 do
		local petId = checknumber(raceIds[i])

		formPb.raceIds:append(petId)
	end

	formPb.assistId = checknumber(assistId)
	self._tempBattleViewName = battleViewName

	MiracleHeroAgent.instance:sendPM_MiracleHeroChallengeReq(activityId, challengeId, stageId, formPb)
end

function MiracleHeroController:handlePM_MiracleHeroChallengeRes(msg)
	MiracleHeroModel.instance:onChallenge(msg)
end

function MiracleHeroController:handlePM_NotifyMiracleHeroChallengeEndRes(msg)
	MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
	MiracleHeroModel.instance:onNotifyChallengeEnd(msg)
end

function MiracleHeroController:handlePM_NotifyMiracleHeroBattleReadyStart(msg)
	MiracleHeroBattleModel.instance:setReadyBattleStartInfo(msg)

	if self._tempBattleViewName then
		UIStateManager.instance:push(self._tempBattleViewName, msg.activityId, msg.challengeId, msg.stageId)

		self._tempBattleViewName = nil
	else
		UIStateManager.instance:push(ViewName.MiracleHeroBattleView, msg.activityId, msg.challengeId, msg.stageId)
	end
end

function MiracleHeroController:sendPM_MiracleHeroBattleStartReq(activityId)
	local actionId = MiracleHeroBattleModel.instance:getActionId()
	local clientKey = MiracleHeroBattleModel.instance:setRandomClientKey()
	local teamViews = {}
	local myTeamView = self:createTeamView(activityId, MiracleHeroTeamType.MyTeam)
	local enemyTeamView = self:createTeamView(activityId, MiracleHeroTeamType.EnemyTeam)

	table.insert(teamViews, myTeamView)
	table.insert(teamViews, enemyTeamView)

	local firstTeamId = MiracleHeroUnitMgr.instance:getFirstTeamType() - 1

	MiracleHeroAgent.instance:sendPM_MiracleHeroBattleStartReq(actionId + 1, clientKey, teamViews, firstTeamId)
end

function MiracleHeroController:createTeamView(activityId, teamType)
	local teamMo = MiracleHeroUnitMgr.instance:getTeamMo(teamType)
	local teamView = MiracleHeroExtension_pb.PM_MiracleTeamView()

	teamView.teamId = teamType - 1

	for i, v in pairs(teamMo.pos) do
		local characterView = MiracleHeroExtension_pb.PM_MiracleCharacterView()
		local petMo = MiracleHeroUnitMgr.instance:getPet(v)

		characterView.id = petMo.id
		characterView.raceId = petMo.configId
		characterView.posId = i
		characterView.lv = petMo.level
		characterView.maxHp = petMo:getMaxHp()

		local petCfg = MiracleHeroConfig.instance:getPetCfg(activityId, petMo.configId)

		characterView.normalSkillId = petCfg.normalSkillId
		characterView.ultimateSkillId = petCfg.ultSkillId

		local view = teamView.characters:add()

		view:ParseFromString(characterView:SerializeToString())
	end

	if teamType == MiracleHeroTeamType.MyTeam then
		teamView.assistId = teamMo.supportPet
	end

	return teamView
end

function MiracleHeroController:handlePM_MiracleHeroBattleStartRes(msg)
	MiracleHeroBattleModel.instance:handleBattleStart(msg)
	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroBattleStartRes)
end

function MiracleHeroController:sendPM_MiracleHeroSyncBattleReq(activityId, roundIndex, isWin)
	self._tempWin = isWin

	local actionId = MiracleHeroBattleModel.instance:getActionId() + 1
	local encryptedKey = 0
	local clientKey = MiracleHeroBattleModel.instance:getClientKey()
	local serverKey = GenEncryptedKeyUtil.dxor(MiracleHeroBattleModel.instance:getServerKey(), clientKey)

	encryptedKey = actionId % 2 == 0 and encryptedKey + (actionId + serverKey) * 5381 or encryptedKey + (actionId + clientKey) * 31

	local roundMoList = MiracleHeroRoundMgr.instance:getBigRoundList(roundIndex)
	local oneCircle = MiracleHeroExtension_pb.PM_MiracleHeroOneCircleResult()
	local myOneCircle = MiracleHeroExtension_pb.PM_MiracleHeroOneCircleOneSideResult()
	local enemyCircle = MiracleHeroExtension_pb.PM_MiracleHeroOneCircleOneSideResult()
	local hasMyCircle = false
	local hasEnemyCircle = false

	for i, roundMo in ipairs(roundMoList) do
		local addOneCircle

		if roundMo.teamId == MiracleHeroTeamType.MyTeam then
			addOneCircle = myOneCircle
			hasMyCircle = true
		else
			addOneCircle = enemyCircle
			hasEnemyCircle = true
		end

		if roundMo.skillMo.isSupportSkill then
			local result = MiracleHeroExtension_pb.PM_MiracleHereOneRoundAssistResult()

			result.curRound = roundIndex
			result.skillId = roundMo.skillMo.configId

			for petId, reportMo in pairs(roundMo.skillMo.reportMos) do
				local targetResult = MiracleHeroExtension_pb.PM_MiracleHeroOneTargetCharacterResult()
				local petMo = MiracleHeroUnitMgr.instance:getPet(petId)

				targetResult.target.targetTeamId = petMo.teamId - 1
				targetResult.target.targetCharacterId = petId
				targetResult.isCritical = reportMo.isCritical
				targetResult.targetNumResult.afterRoundHp = reportMo.afterRoundHp

				local buffIndex = 1

				for j, info in ipairs(reportMo.effectHpBuffIds) do
					local buffInfo = MiracleHeroExtension_pb.PM_MiracleHeroBuffPower()

					buffInfo.sequenceId = buffIndex
					buffInfo.buffId = info.buffId
					buffInfo.changeHp = info.changeHp
					buffInfo.afterChangeHp = info.afterChangeHp
					buffInfo.changeMaxHp = info.changeMaxHp
					buffInfo.afterChangeMaxHp = info.afterChangeMaxHp

					local changeBuff = targetResult.targetNumResult.beforeBuffHps:add()

					changeBuff:ParseFromString(buffInfo:SerializeToString())
				end

				local targetResultAdd = result.targetCharacterResults:add()

				targetResultAdd:ParseFromString(targetResult:SerializeToString())
			end

			local assistResult = addOneCircle.assistResults:add()

			assistResult:ParseFromString(result:SerializeToString())
		else
			local result = MiracleHeroExtension_pb.PM_MiracleHeroOneRoundCharacterResult()

			result.curRound = roundIndex
			result.skillId = roundMo.skillMo.configId

			local casterPetMo = MiracleHeroUnitMgr.instance:getPet(roundMo.skillMo.targetA)

			result.caster.targetTeamId = casterPetMo.teamId - 1
			result.caster.targetCharacterId = roundMo.skillMo.targetA
			result.skillCurBatterCount = roundMo.skillMo.skillCurBatterCount
			result.elementNum = roundMo.skillMo.energy

			for petId, reportMo in pairs(roundMo.skillMo.reportMos) do
				local targetResult = MiracleHeroExtension_pb.PM_MiracleHeroOneTargetCharacterResult()
				local petMo = MiracleHeroUnitMgr.instance:getPet(petId)

				targetResult.target.targetTeamId = petMo.teamId - 1
				targetResult.target.targetCharacterId = petId
				targetResult.isCritical = reportMo.isCritical

				if reportMo.createDamage then
					targetResult.targetNumResult.attackHps = checknumber(reportMo.attackHps)
				end

				targetResult.targetNumResult.afterRoundHp = reportMo.afterRoundHp

				local buffIndex = 1

				for j, info in pairs(reportMo.effectHpBuffIds) do
					local buffInfo = MiracleHeroExtension_pb.PM_MiracleHeroBuffPower()

					buffInfo.sequenceId = buffIndex
					buffInfo.buffId = info.buffId
					buffInfo.changeHp = info.changeHp
					buffInfo.afterChangeHp = info.afterChangeHp
					buffInfo.changeMaxHp = info.changeMaxHp
					buffInfo.afterChangeMaxHp = info.afterChangeMaxHp

					local changeBuff = targetResult.targetNumResult.beforeBuffHps:add()

					changeBuff:ParseFromString(buffInfo:SerializeToString())
				end

				local targetResultAdd = result.targetCharacterResults:add()

				targetResultAdd:ParseFromString(targetResult:SerializeToString())
			end

			local characterResults = addOneCircle.characterResults:add()

			characterResults:ParseFromString(result:SerializeToString())
		end

		roundIndex = roundIndex + 1
	end

	local afterOneCircleResult = MiracleHeroExtension_pb.PM_MiracleHeroAfterOneCircleResult()
	local endRoundReportMos = MiracleHeroRoundMgr.instance:getEndRoundReportMos(roundIndex)

	for petId, reportMo in pairs(endRoundReportMos) do
		local targetResult = MiracleHeroExtension_pb.PM_MiracleHeroOneTargetCharacterResult()
		local petMo = MiracleHeroUnitMgr.instance:getPet(petId)

		targetResult.target.targetTeamId = petMo.teamId - 1
		targetResult.target.targetCharacterId = petId
		targetResult.isCritical = reportMo.isCritical

		if reportMo.createDamage then
			targetResult.targetNumResult.attackHps = checknumber(reportMo.attackHps)
		end

		targetResult.targetNumResult.afterRoundHp = petMo.curHp

		local buffIndex = 1

		for j, info in pairs(reportMo.effectHpBuffIds) do
			local buffInfo = MiracleHeroExtension_pb.PM_MiracleHeroBuffPower()

			buffInfo.sequenceId = buffIndex
			buffInfo.buffId = info.buffId
			buffInfo.changeHp = info.changeHp
			buffInfo.afterChangeHp = info.afterChangeHp
			buffInfo.changeMaxHp = info.changeMaxHp
			buffInfo.afterChangeMaxHp = info.afterChangeMaxHp

			local changeBuff = targetResult.targetNumResult.beforeBuffHps:add()

			changeBuff:ParseFromString(buffInfo:SerializeToString())
		end

		local targetResultAdd = afterOneCircleResult.targetCharacterResults:add()

		targetResultAdd:ParseFromString(targetResult:SerializeToString())
	end

	local afterOneCircle = oneCircle.afterOneCircleResults:add()

	afterOneCircle:ParseFromString(afterOneCircleResult:SerializeToString())

	if hasMyCircle == true then
		oneCircle.myOneCircle:ParseFromString(myOneCircle:SerializeToString())
	end

	if hasEnemyCircle == true then
		oneCircle.enemyCircle:ParseFromString(enemyCircle:SerializeToString())
	end

	MiracleHeroAgent.instance:sendPM_MiracleHeroSyncBattleReq(actionId, encryptedKey, isWin, oneCircle)
end

function MiracleHeroController:handlePM_MiracleHeroSyncBattleRes(msg)
	MiracleHeroBattleModel.instance:addActionId()

	if MiracleHeroBattleModel.instance:getActionId() ~= msg.actionId then
		FloatWordMgr.instance:show(lang("数据对不上"))
	end

	GlobalDispatcher:dispatch(GlobalNotify.MiracleHeroSyncBattleRes, msg, self._tempWin)
end

MiracleHeroController.instance = MiracleHeroController.New()

return MiracleHeroController
