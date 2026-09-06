-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magiccontest/model/MagicContestFmtMo.lua

module("logic.extensions.magiccontest.model.MagicContestFmtMo", package.seeall)

local MagicContestFmtMo = class("MagicContestFmtMo", BaseCustomFmtMo)

function MagicContestFmtMo:updateCfg(activityId, msg)
	self._msg = msg
	self._activityId = msg.activityId
	self._batType = msg.type
	self._subMo = MagicContestController.instance:getSubMo(self._activityId)
	self._fMo = self._fMo or FightingPowerPetMo.New()
	self._isNeedLockFmtPet = #self._msg.raceIdAndLeftHp > 0
	self._fmtRaceIds = {}

	if self._isNeedLockFmtPet then
		for _, v in ipairs(self._msg.raceIdAndLeftHp) do
			self._fmtRaceIds[v.left] = v.right
		end
	end

	self._banRaceIds = {}

	for _, v in ipairs(self._msg.myBanRaceIds) do
		self._banRaceIds[v] = true
	end

	self._raceHps = {}

	for _, v in ipairs(self._msg.raceIdAndLeftHp) do
		self._raceHps[v.left] = v.right
	end

	self.isShowBtnFormationUse = false
	self.isShowBtnCutePet = false
	self.isOnlyUpdateExistPet = true
	self.isNeedOpenCustomFmtFeatureView = true

	if self._batType == MagicContestEnum.BatType_Nor then
		self.useMaxFightPower = true
	elseif self._batType == MagicContestEnum.BatType_Ext then
		self.useMaxFightPower = false
	end

	self:initPetList()
	self:_updateEnemyFmt()
end

function MagicContestFmtMo:getActivityId()
	return self._activityId
end

function MagicContestFmtMo:getBatType()
	return self._batType
end

function MagicContestFmtMo:initFightHandler()
	self:setFightHandler(function()
		local buffNum = self._subMo:getCurSelectBuffCount(self._batType)
		local maxNum = self._subMo:getMaxBuffCount()

		if maxNum > 0 and buffNum <= 0 then
			FloatWordMgr.instance:show("请选择buff")
			GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)

			return
		end

		local function okFunc()
			UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

			local simpleForm = self:getCurSimpleForm()

			MagicContestController.instance:sendPM_MagicContestChallengeReq(self._activityId, self._batType, simpleForm)
		end

		local matchPlayerId = checknumber(self._msg.matchPlayerId)
		local isPlayer = matchPlayerId > 0

		if isPlayer and self._subMo:getTodayWinCount(self._batType) == 0 then
			local tipsContent = "是否确认进入挑战，挑战胜利后该上阵队伍将不可更改"

			local function cencelFunc()
				GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, -1)
			end

			TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
		else
			okFunc()
		end
	end, nil)
end

function MagicContestFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("您正在进行战斗，不可退出")

	return false
end

function MagicContestFmtMo:_updateEnemyFmt()
	local matchPlayerView = self._msg.matchPlayerView
	local simpleForm = matchPlayerView.curForm
	local petSimpleView = matchPlayerView.petSimpleView

	self._masterData = simpleForm.extParams
	self._petMapAsRight = {}

	for _, v in ipairs(petSimpleView) do
		local petMo = BagPetMo.New()

		petMo:initBaseView(v)

		petMo.isMyPackPet = false
		self._petMapAsRight[v.petId] = petMo
	end

	self._formationMoOfEnemy:SetData(simpleForm)
end

function MagicContestFmtMo:getMonsterConfigList()
	return {}
end

function MagicContestFmtMo:getFmtInfoConfig()
	local simpleForm = CustomFmtController.instance:createFormPb(self._formationMoOfEnemy)

	return simpleForm.extParams
end

function MagicContestFmtMo:initFormationMo()
	MagicContestFmtMo.super.initFormationMo(self)

	self._petMapAsRight = {}
	self._formationMoOfEnemy = FormationMO.New(GameUtil.handler(self.getPetMoByIdOfEnemy, self))
end

function MagicContestFmtMo:getPetMoByIdOfEnemy(petId)
	return self._petMapAsRight[petId]
end

function MagicContestFmtMo:getTeamAndFormation(creepCfg)
	return self:_getTeamAndFormationOfPlayer(creepCfg)
end

function MagicContestFmtMo:_getTeamAndFormationOfPlayer(creepCfg)
	local fmtMo = self._formationMoOfEnemy
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

function MagicContestFmtMo:getExtParams()
	return self:getFmtInfoConfig()
end

function MagicContestFmtMo:getExtendViewName()
	return ViewName.MagicContestFmtExtisonView
end

function MagicContestFmtMo:updateCellTop(cell, petMo)
	if self:_isPetBan(petMo) or self:_isPetNotFmt(petMo) then
		self:clearCellTop(cell)

		return
	end

	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local hpRatio = 0

		if self:_isPetBan(petMo) then
			hpRatio = 0
		else
			local raceId = petMo:getDefineId()

			if not self._raceHps[raceId] then
				hpRatio = self._raceHps[raceId] / 10000
			end
		end

		proxy.binder:onUpdateHp(hpRatio)
	end
end

function MagicContestFmtMo:checkPetIsForbit(petMo)
	return self:_isPetNotFmt(petMo) or self:_isPetBan(petMo) or self:_isPetHpZero(petMo)
end

function MagicContestFmtMo:showForbitPetAlert(petMo)
	if self:_isPetNotFmt(petMo) then
		FloatWordMgr.instance:show("精灵已锁定")
	elseif self:_isPetBan(petMo) then
		FloatWordMgr.instance:show("精灵已禁止")
	elseif self:_isPetHpZero(petMo) then
		FloatWordMgr.instance:show("精灵已阵亡")
	end
end

function MagicContestFmtMo:isPosValidatorMatchOnSelect(pos, petId, isShowTip)
	if MagicContestFmtMo.super.isPosValidatorMatchOnSelect(self, pos, petId, isShowTip) then
		local petMo = self:getPetMoById(petId)

		return not self:_isPetNotFmt(petMo) and not self:_isPetBan(petMo) and not self:_isPetHpZero(petMo)
	else
		return false
	end
end

function MagicContestFmtMo:_isPetBan(petMo)
	local result = false

	if petMo then
		local raceId = petMo:getDefineId()

		result = self._banRaceIds[raceId] or false
	end

	return result
end

function MagicContestFmtMo:_isPetHpZero(petMo)
	local result = false

	if petMo then
		local raceId = petMo:getDefineId()

		if not self._raceHps[raceId] then
			result = self._raceHps[raceId] and self._raceHps[raceId] <= 0 or false
		end
	end

	return result
end

function MagicContestFmtMo:_isPetNotFmt(petMo)
	local result = false

	if self._isNeedLockFmtPet and petMo then
		local raceId = petMo:getDefineId()

		result = self._fmtRaceIds[raceId] == nil
	end

	return result
end

return MagicContestFmtMo
