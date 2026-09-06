-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/data/GodStatuesWarMo.lua

module("logic.extensions.godstatueswar.data.GodStatuesWarMo", package.seeall)

local GodStatuesWarMo = class("GodStatuesWarMo")

function GodStatuesWarMo:ctor(seasonId)
	self._seasonId = seasonId
	self._registered = false
	self._myFamilyStep = 0
	self._formInfoListOfMy = {}
	self._simplePillarInfoCtrl = GswSimplePillarInfoCtrl.New(self._seasonId)
	self._completePillarInfoCtrl = GswCompletePillarInfoCtrl.New()
	self._pillarMapMo = GswPillarMapMo.New()
	self._nestResultMsg = nil
	self._tierReportInfoMoList = {}
	self._rankViewResMsg = nil
	self._fightDivinePillarResMsg = nil
	self._spaceGroupInfoMsg = nil
end

function GodStatuesWarMo:getSeasonId()
	return self._seasonId
end

function GodStatuesWarMo:deepcopy()
	return TableUtil.deepcopy(self)
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetRegistrationRes(msg)
	self._registered = msg.registered

	self._pillarMapMo:setTodayDivinePillarFightTime(msg.todayDivinePillarFightTime or 0)
	self._pillarMapMo:setNestLeftFightTime(msg.nestLeftFightTime or 0)

	self._myFamilyStep = msg.step or 0
	self._canParticipateCode = msg.canParticipateCode
end

function GodStatuesWarMo:handlePM_NewFamilyBattleRegisteringRes(msg)
	self._registered = true
	self._myFamilyStep = 1
	self._canParticipateCode = 0
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetFormRes(msg)
	table.clear(self._formInfoListOfMy)

	for _, v in ipairs(msg.forms) do
		self._formInfoListOfMy[v.id] = v
	end
end

function GodStatuesWarMo:handlePM_NewFamilyBattleSetFormRes(msg)
	table.clear(self._formInfoListOfMy)

	for _, v in ipairs(msg.forms) do
		self._formInfoListOfMy[v.id] = v
	end
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetDivinePillarFormRes(msg)
	self._simplePillarInfoCtrl:updateData(msg.defenceFormList)
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetFormDetailRes(msg)
	return
end

function GodStatuesWarMo:handlePM_NewFamilyBattleAdjustRes(msg)
	return
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetDivinePillarMapRes(msg)
	self._pillarMapMo:initData(msg)
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetDivinePillarInfoRes(msg)
	self._completePillarInfoCtrl:updateData(msg)
end

function GodStatuesWarMo:handlePM_NewFamilyBattleFightDivinePillarRes(msg)
	self._pillarMapMo:setTodayDivinePillarFightTime(msg.todayDivinePillarFightTime)
	self._pillarMapMo:setFamilyEnergy(msg.familyEnergy)

	self._fightDivinePillarResMsg = msg
end

function GodStatuesWarMo:handlePM_NewFamilyBattleReportRes(msg)
	table.clear(self._tierReportInfoMoList)

	for _, v in ipairs(msg.reportList) do
		local mo = GswTierReportInfoMo.New()

		mo:initData(v)
		table.insert(self._tierReportInfoMoList, mo)
	end
end

function GodStatuesWarMo:handlePM_NewFamilyBattleVideoRes(msg)
	return
end

function GodStatuesWarMo:handlePM_NewFamilyBattleChallengeNestRes(msg)
	return
end

function GodStatuesWarMo:handlePM_NewFamilyBattleSetFlagRes(msg)
	self._pillarMapMo:setAttackFlagFamilyId(msg.attackFlagFamilyId)
	self._pillarMapMo:setNoAttackFlagFamilyId(msg.noAttackFlagFamilyId)
end

function GodStatuesWarMo:handlePM_NewFamilyBattleRankViewRes(msg)
	self._rankViewResMsg = msg
end

function GodStatuesWarMo:handlePM_NewFamilyBattleGetSpaceGroupInfoRes(msg)
	self._spaceGroupInfoMsg = msg
end

function GodStatuesWarMo:handlePM_NewFamilyBattleChallengeNestResult(msg)
	self._nestResultMsg = msg

	self._pillarMapMo:setNestLeftFightTime(msg.nestLeftFightTime)
end

function GodStatuesWarMo:isRegistered()
	return self._registered
end

function GodStatuesWarMo:getMyFamilyStep()
	return self._myFamilyStep
end

function GodStatuesWarMo:getCanParticipateCode()
	return self._canParticipateCode
end

function GodStatuesWarMo:getFormInfoListOfMy()
	return self._formInfoListOfMy
end

function GodStatuesWarMo:getFormInfoOfMy(id)
	return self._formInfoListOfMy[id]
end

function GodStatuesWarMo:getSpInfoCtrl()
	return self._simplePillarInfoCtrl
end

function GodStatuesWarMo:getCpInfoCtrl()
	return self._completePillarInfoCtrl
end

function GodStatuesWarMo:getPillarMapMo()
	return self._pillarMapMo
end

function GodStatuesWarMo:getNestResultMsg()
	return self._nestResultMsg
end

function GodStatuesWarMo:getTierReportInfoMoList()
	return self._tierReportInfoMoList
end

function GodStatuesWarMo:getRankViewResMsg()
	return self._rankViewResMsg
end

function GodStatuesWarMo:getSpaceGroupInfoMsg()
	return self._spaceGroupInfoMsg
end

function GodStatuesWarMo:getFightDivinePillarResMsg()
	return self._fightDivinePillarResMsg
end

return GodStatuesWarMo
