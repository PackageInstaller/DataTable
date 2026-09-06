-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/model/PeakTournamentBattleCustomFmtMo.lua

module("logic.extensions.peaktournament.model.PeakTournamentBattleCustomFmtMo", package.seeall)

local PeakTournamentBattleCustomFmtMo = class("PeakTournamentBattleCustomFmtMo", PeakTournamentBaseCustomFmtMo)

function PeakTournamentBattleCustomFmtMo:updateCfg(activityId)
	PeakTournamentBattleCustomFmtMo.super.updateCfg(self, activityId)

	local opInfo = PeakTournamentModel.instance:getOpPlayerInfoAsQua()
	local headInfo = opInfo and opInfo.headInfo

	if headInfo then
		self.topTitleStr = headInfo.userName or ""
	end

	self:_updateEnemyFmt()
end

function PeakTournamentBattleCustomFmtMo:initFightHandler()
	local function handler()
		if self:checkStartFight() then
			GlobalDispatcher:addListener(GlobalNotify.PeakTournamentSetFormRes, self._handlePeakTournamentSetFormRes, self)
			self:saveMyFmts()
		end
	end

	self:setFightHandler(handler, nil)
end

function PeakTournamentBattleCustomFmtMo:_handlePeakTournamentSetFormRes()
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentSetFormRes, self._handlePeakTournamentSetFormRes, self)
	PeakTournamentController.instance:sendPM_PeakTournamentQualifierFightReq(self._activityId)
end

function PeakTournamentBattleCustomFmtMo:_updateEnemyFmt()
	self._petMapAsRight = {}

	for formId = 1, 3 do
		local opForm = PeakTournamentModel.instance:getOpFormAsQua(formId)

		if opForm then
			local matchPlayerView = opForm.view
			local simpleForm = matchPlayerView.curForm
			local petSimpleView = matchPlayerView.petSimpleView

			for _, v in ipairs(petSimpleView) do
				local petMo = BagPetMo.New()

				petMo:initBaseView(v)

				petMo.isMyPackPet = false
				self._petMapAsRight[v.petId] = petMo
			end

			self._formationMoOfEnemyList[formId]:SetData(simpleForm)
		end
	end
end

function PeakTournamentBattleCustomFmtMo:initFormationMo()
	PeakTournamentBattleCustomFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._formationMoOfEnemyList = {}

	for formId = 1, 3 do
		self._formationMoOfEnemyList[formId] = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
	end
end

function PeakTournamentBattleCustomFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function PeakTournamentBattleCustomFmtMo:getMonsterConfigList()
	return {}
end

function PeakTournamentBattleCustomFmtMo:getFmtInfoConfig()
	local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemyList[self.curTabIndex])

	return simpleForm.extParams
end

function PeakTournamentBattleCustomFmtMo:getTeamAndFormation(creepCfg)
	return self:_getTeamAndFormationOfPlayer(creepCfg)
end

function PeakTournamentBattleCustomFmtMo:_getTeamAndFormationOfPlayer(creepCfg)
	local fmtMo = self._formationMoOfEnemyList[self.curTabIndex]
	local teams, formations, speed = fmtMo:getTeamAndFormation()

	ArraySort.sortOn(teams, "position")

	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		local fightingPowerMo = bagPetMo:toFightingPowerPetMo()

		fightingPowerMo.petId = bagPetMo:getPetId()
		resultFormations[posId] = fightingPowerMo
	end

	return teams, resultFormations
end

function PeakTournamentBattleCustomFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function PeakTournamentBattleCustomFmtMo:checkStartFight()
	return true
end

function PeakTournamentBattleCustomFmtMo:onClickCloseBtn(handler)
	if self:checkFormationLimitAndPopWin() then
		return
	end

	self:saveMyFmts()
	PeakTournamentBattleCustomFmtMo.super.onClickCloseBtn(self, handler)
end

function PeakTournamentBattleCustomFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	return self:checkFormationLimitAndPopWin()
end

function PeakTournamentBattleCustomFmtMo:checkFormationLimitAndPopWin()
	local isLimit = not PeakTournamentController.instance:isAllFmtNotEmptyByFmtMos(self.formationMoList)

	if isLimit then
		local tip = langPara("存在空阵，无法正常参与巅峰赛，请保证每个阵容至少有1个精灵上阵后继续")

		TipsFacade.instance:openTipWindowNoX("提示", tip, function()
			return
		end)
	end

	return isLimit
end

function PeakTournamentBattleCustomFmtMo:sendSaveMsg(fromBtnSave)
	self:saveMyFmts()
end

function PeakTournamentBattleCustomFmtMo:checkIsCanJumpOut()
	return not self:checkFormationLimitAndPopWin()
end

return PeakTournamentBattleCustomFmtMo
