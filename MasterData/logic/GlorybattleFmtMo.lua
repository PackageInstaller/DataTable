-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/glorybattle/model/GlorybattleFmtMo.lua

module("logic.extensions.glorybattle.model.GlorybattleFmtMo", package.seeall)

local GlorybattleFmtMo = class("GlorybattleFmtMo", BaseCustomFmtMo)

function GlorybattleFmtMo:initParams(activityId)
	self._activityId = activityId
	self.isOnlyUpdateExistPet = true
	self._masterData = nil
	self._creepsCfgs = nil
	self._fixedPosList = {}
	self._proxyPool = {}
	self._stepType = GlorybattleController.Step.One
	self._lastStepType = GlorybattleController.Step.None

	local opponent = GlorybattleModel.instance:getOpponent(activityId)
	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local userId = checknumber(opponent.headInfo.userId)

	if userId == 0 then
		return
	end

	self._isSystemEnemy = userId < 0
	self.isShowPetBag = false
	self.isShowOneKey = false
	self.isShowClean = false
	self.isShowBtnFormationUse = false
	self.isShowBtnCutePet = false
	self.isShowBtnBuffForm = false
	self.isShowBtnContractPet = false

	self:clearAllPetList()
	self:getCurFormation():ResetPosition()

	if self._formationMoOfEnemy then
		self._formationMoOfEnemy:ResetPosition()
	end

	if self._stepType == GlorybattleController.Step.Three then
		self:_initEnemyData()
	end
end

function GlorybattleFmtMo:updateData()
	local opponent = GlorybattleModel.instance:getOpponent(self._activityId)

	if not opponent or not opponent.headInfo then
		return
	end

	self.topTitleStr = opponent.headInfo.userName
	self.validatorDescStr = ""
	self.ruleDescStr = ""
end

function GlorybattleFmtMo:initPetList()
	self:clearAllPetList()

	local info = GlorybattleModel.instance:getInfo(self._activityId)
	local creepsInfos = info.challengeInfo.creepsInfos

	if creepsInfos then
		for i, v in ipairs(creepsInfos) do
			local petMo = GlorybattleModel.instance:getPetMo(self._activityId, v.creepsId)

			self:addPetToList(self:_changePetMo(petMo))
		end
	end

	local petCardInfos = info.challengeInfo.petCardInfos

	if petCardInfos then
		for i, v in ipairs(petCardInfos) do
			local petMo = GlorybattleModel.instance:getPetCardPetMo(self._activityId, v.petCardId)

			self:addPetToList(self:_changePetMo(petMo))
		end
	end
end

function GlorybattleFmtMo:initFightHandler()
	local function handler()
		GlorybattleController.instance:sendPM_GloryBattleFightReq(self._activityId, self:getCurFormation(), true)
	end

	self:setFightHandler(handler, nil)
end

function GlorybattleFmtMo:getMonsterConfigList()
	return self._creepsCfgs
end

function GlorybattleFmtMo:getFmtInfoConfig()
	return self._masterData
end

function GlorybattleFmtMo:getExtendViewName()
	return ViewName.GlorybattleextView
end

function GlorybattleFmtMo:initFormationMo()
	GlorybattleFmtMo.super.initFormationMo(self)

	self._formationMoOfEnemy = FormationMO.New(GameUtil.handler(self._getPetMoByIdOfEnemy, self))
end

function GlorybattleFmtMo:_getPetMoByIdOfEnemy(petId)
	if petId == 0 then
		return
	end

	return GlorybattleModel.instance:getOpponentPetMo(self._activityId, petId)
end

function GlorybattleFmtMo:getTeamAndFormation(creepCfg)
	if self._isSystemEnemy then
		return GlorybattleFmtMo.super.getTeamAndFormation(self, creepCfg)
	else
		return self:_getTeamAndFormationOfPlayer(creepCfg)
	end
end

function GlorybattleFmtMo:_getTeamAndFormationOfPlayer(creepCfg)
	if not self._creepsCfgs then
		return {}, {}
	end

	local fmtMo = self._formationMoOfEnemy
	local teams, formations, speed = fmtMo:getTeamAndFormation()
	local resultFormations = {}

	for posId, bagPetMo in pairs(formations) do
		resultFormations[posId] = bagPetMo
	end

	return teams, resultFormations
end

function GlorybattleFmtMo:updateCellTop(cell, petMo)
	local luaCls = GlorybattleTopCell
	local url = GlorybattleTopCell.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		self._proxyPool[cell] = proxy

		proxy.binder:checkAndShowIcon(self._activityId, petMo.petId)
	end
end

function GlorybattleFmtMo:clearCellTop(cell)
	GlorybattleFmtMo.super.clearCellTop(self, cell)

	local proxy = self._proxyPool[cell]

	if proxy then
		proxy.binder:onExit()
	end

	self._proxyPool[cell] = nil
end

function GlorybattleFmtMo:setNeedUpPetCount(stepType)
	if self._lastStepType == stepType then
		return
	end

	self._lastStepType = stepType

	if stepType == GlorybattleController.Step.One then
		self.needUpPetCount = 3
	elseif stepType == GlorybattleController.Step.Two then
		self.needUpPetCount = self:getCurFormation():isEmpty() and 2 or self:getCurFormation():getCurExistPetNumber() + 2
	elseif stepType == GlorybattleController.Step.Three then
		self.needUpPetCount = self:getCurFormation():getCurExistPetNumber()
	end

	MissionModel.instance:setMaxPetNum(self.needUpPetCount)
end

function GlorybattleFmtMo:onClickCloseBtn(handler)
	FloatWordMgr.instance:show("无法退出战斗")
end

function GlorybattleFmtMo:enterNextStep()
	self._stepType = self._stepType + 1

	if self._stepType == GlorybattleController.Step.Two or self._stepType == GlorybattleController.Step.Three then
		self:_initEnemyData()
		GlorybattleController.instance:sendPM_GloryBattleFightReq(self._activityId, self:getCurFormation())
	end
end

function GlorybattleFmtMo:getStepType()
	return self._stepType
end

function GlorybattleFmtMo:_initEnemyData()
	local num = -1

	if self._stepType == GlorybattleController.Step.Two then
		num = 3
	end

	local opponent = GlorybattleModel.instance:getOpponent(self._activityId)

	if not opponent or not opponent.headInfo then
		return
	end

	if self._isSystemEnemy then
		local creepsMasterId = math.abs(opponent.headInfo.userId)
		local tempCfgs = GlorybattleConfig.instance:getCreepsCfgs(creepsMasterId)

		if num > 0 then
			self._creepsCfgs = {}

			local randomList = {}

			for i = 1, num do
				table.insert(randomList, i)
			end

			for i = 1, num do
				local cnt = #randomList

				if cnt > 0 then
					local n = math.random(1, cnt)
					local idx = randomList[n]

					table.remove(randomList, n)
					table.insert(self._creepsCfgs, tempCfgs[idx])
				end
			end
		else
			self._creepsCfgs = tempCfgs
		end

		self._masterData = GlorybattleConfig.instance:getMasterCfg(creepsMasterId)
	else
		local form = opponent.form

		if form then
			local randomList = {}

			self._creepsCfgs = {}
			self._masterData = form.extParams

			self._formationMoOfEnemy:SetData(form)

			if num > 0 then
				for posId, creepsId in ipairs(form.pos) do
					if creepsId > 0 then
						table.insert(randomList, {
							creepsId = creepsId,
							posId = posId
						})
					end
				end

				for i = 1, num do
					local cnt = #randomList

					if cnt > 0 then
						local n = math.random(1, cnt)
						local d = randomList[n]

						table.remove(randomList, n)

						local petMo = GlorybattleModel.instance:getOpponentPetMo(self._activityId, d.creepsId)

						table.insert(self._creepsCfgs, petMo)
					end
				end

				for i, v in ipairs(randomList) do
					self._formationMoOfEnemy:SetPosition(v.posId, 0)
				end
			else
				for posId, creepsId in ipairs(form.pos) do
					if creepsId > 0 then
						local petMo = GlorybattleModel.instance:getOpponentPetMo(self._activityId, creepsId)

						table.insert(self._creepsCfgs, petMo)
					end
				end
			end
		end
	end
end

function GlorybattleFmtMo:updateFixPos()
	self._fixedPosList = {}

	local positions = self:getCurFormation():GetPositions()

	for i, v in ipairs(positions) do
		if v > 0 then
			table.insert(self._fixedPosList, i)
		end
	end

	MissionModel.instance:setFixedPos(self._fixedPosList)
end

function GlorybattleFmtMo:getFixedPosList()
	return self._fixedPosList
end

function GlorybattleFmtMo:getFailedTips()
	local stepType = self:getStepType()

	if stepType == GlorybattleController.Step.One then
		return "本阶段仅可上阵3只精灵"
	elseif stepType == GlorybattleController.Step.Two then
		return "本阶段仅可上阵2只精灵"
	end
end

function GlorybattleFmtMo:checkPetIsForbit(petMo, baseCheck)
	return baseCheck or (not baseCheck or nil) and self:getStepType() == GlorybattleController.Step.Three
end

function GlorybattleFmtMo:showForbitPetAlert(petMo)
	if self:getStepType() == GlorybattleController.Step.Three then
		FloatWordMgr.instance:show("展示阶段不可操作")
	end
end

function GlorybattleFmtMo:checkBlockClickBtn(buttonName)
	if self:getStepType() == GlorybattleController.Step.Three and buttonName == "ElementSkill" then
		FloatWordMgr.instance:show("展示阶段不可操作")

		return true
	end
end

return GlorybattleFmtMo
