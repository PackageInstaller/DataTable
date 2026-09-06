-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lotusbattle/model/LotusbattleFmtMo.lua

module("logic.extensions.lotusbattle.model.LotusbattleFmtMo", package.seeall)

local LotusbattleFmtMo = class("LotusbattleFmtMo", ICustomFmtMo)

function LotusbattleFmtMo:initData(activityId)
	self._activityId = activityId
end

function LotusbattleFmtMo:updateData()
	self.isShowBtnSave = false
	self.isShowBtnFormation = false
	self.isShowBtnContractPet = true
	self.isShowBtnBuffForm = false
	self.isStartButtonAvailable = false
	self.isShowOneKey = false
	self.isShowClean = false

	local info = LotusbattleModel.instance:getMatchPlayerInfo()

	if info then
		self.topTitleStr = info.opHeadInfo.userName or "未知"
	end

	self.ruleDescStr = ""

	self:setNeedUpPetCount(0)
	self:initPetList()
	self:refreshMyFmts()
end

function LotusbattleFmtMo:sendFightMsg()
	return
end

function LotusbattleFmtMo:onClickCloseBtn(handler)
	local tip = "是否退出游戏？"

	local function quit()
		LotusBattleFieldAgent.instance:sendPM_LBFLeaveGameReq(self._activityId)
		LotusbattleFmtMo.super.onClickCloseBtn(self, handler)
	end

	TipsFacade.instance:openTipWindow("提示", tip, quit)
end

function LotusbattleFmtMo:initFightHandler()
	return
end

function LotusbattleFmtMo:initPetList()
	self:clearAllPetList()

	local pets = LotusbattleModel.instance:getBagPets()

	for k, mo in pairs(pets) do
		self:addPetToList(mo)
	end
end

function LotusbattleFmtMo:_makePetMoAsFal(creepsId)
	local fPowerPet = FightingPowerPetMo.New()
	local petCo = LotusbattleConfig.instance:getCreepsCfg(creepsId)

	fPowerPet:fromChallengeCreepCo(petCo)

	return (fPowerPet:toBaseBagPetMo())
end

function LotusbattleFmtMo:onFilterPetShow(petMo)
	return not petMo.isSupportedPet
end

function LotusbattleFmtMo:getMonsterConfigList()
	local creepsCfgs = {}
	local form = LotusbattleModel.instance:getOpSimpleform()

	if form then
		for i, creepsId in ipairs(form.pos) do
			if creepsId > 0 then
				local cfg = LotusbattleConfig.instance:getCreepsCfg(creepsId)

				cfg.posId = i

				table.insert(creepsCfgs, cfg)
			end
		end
	end

	return creepsCfgs
end

function LotusbattleFmtMo:getFmtInfoConfig()
	return LotusbattleModel.instance:getOpFormExtParams()
end

function LotusbattleFmtMo:getExtendViewName()
	return ViewName.LotusbattlemissionextView
end

function LotusbattleFmtMo:refreshMyFmts()
	local fmtMo = self:getFormationMoByTeamId(0)
	local posIdList = {}

	for posId, petId in ipairs(fmtMo:GetPositions()) do
		if petId > 0 then
			table.insert(posIdList, posId)
		end
	end

	MissionModel.instance:setFixedPos(posIdList)
end

function LotusbattleFmtMo:setNeedUpPetCount(count, lastCount)
	self.needUpPetCount = count
	self._lastCount = lastCount or 0

	MissionModel.instance:setMaxPetNum(self.needUpPetCount)
end

function LotusbattleFmtMo:_updateFmt()
	GlobalDispatcher:dispatch(GlobalNotify.ForceChangeCurFormTab)
end

function LotusbattleFmtMo:onFmoSetDown()
	GlobalDispatcher:dispatch(GlobalNotify.NotifyCpAndBuffUpdateInFalFmt)
end

function LotusbattleFmtMo:getFormationMoByTeamId(teamId)
	if teamId == 0 then
		return self:getCurFormation()
	end
end

function LotusbattleFmtMo:updateLeftFormationMo(simpleForm)
	self:getCurFormation():SetData(simpleForm)
	self:refreshMyFmts()
end

function LotusbattleFmtMo:_updateRightFormationMo(simpleForm)
	return
end

function LotusbattleFmtMo:checkPetIsForbit(petMo, baseCheck)
	if baseCheck then
		return false
	end

	if self:_getInTeam(petMo) or self:_getHasUp(petMo) then
		return false
	end

	return not LotusbattleController.instance:getCanSetFormationFlag()
end

function LotusbattleFmtMo:_getHasUp(data)
	if data then
		local formation = self:getCurFormation()

		for _, petId in ipairs(formation:GetPositions()) do
			if petId > 0 then
				local pet = self:getPetMoById(petId)

				if pet and pet.raceId == data.raceId then
					return true
				end
			end
		end
	end

	return false
end

function LotusbattleFmtMo:_getInTeam(data)
	local var_22_0 = data ~= nil and self:getCurFormation():HasPet(data.petId) or false
	local inTeam = true

	goto label_22_0

	::label_22_0::

	return inTeam
end

function LotusbattleFmtMo:showForbitPetAlert(petMo)
	if self:checkPetIsForbit(petMo) then
		FloatWordMgr.instance:show("当前无法布阵，请等待")
	end
end

function LotusbattleFmtMo:getFinalFmoList(posList, petPool, needPets)
	if self.needUpPetCount > 5 then
		posList, petPool = CustomFmtController.instance:extraPetAtFormation(self.needUpPetCount, needPets, petPool, posList, self:getCurFormation())
	elseif self.needUpPetCount < 5 then
		local count = table.nums(petPool) - self.needUpPetCount

		for i = 1, 9 do
			if count > 0 and petPool[i] then
				petPool[i] = nil
				count = count - 1
			end
		end
	end

	return posList, petPool
end

function LotusbattleFmtMo:getFailedTips()
	return (langPara("本阶段最多上阵%d只精灵哦！", MissionModel.instance:getMaxPetNum() - self._lastCount))
end

return LotusbattleFmtMo
