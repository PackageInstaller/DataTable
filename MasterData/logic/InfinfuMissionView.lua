-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/infinitefuture/view/InfinfuMissionView.lua

module("logic.extensions.infinitefuture.view.InfinfuMissionView", package.seeall)

local InfinfuMissionView = class("InfinfuMissionView", MissionView)

function InfinfuMissionView:ctor()
	InfinfuMissionView.super.ctor(self)
end

function InfinfuMissionView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._teamId = params[3]
	self._creepsMasterId = params[4]
	self._isCleanForm = params[5]

	InfinitefutureModel.instance:onResetPetList(self._activityId, self._isCleanForm)
	InfinitefutureModel.instance:GetAllPetList(self._activityId)

	self._curformCond = InfinitefutureConfig.instance:getTeamCfg(self._creepsMasterId).formCondition
	self.actcfg = InfinitefutureConfig.instance:getPlanCfg(self._activityId)

	self:onEnterInherit()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
	FastFormation.instance:setGetCurPetList(function()
		return InfinitefutureModel.instance:GetAllPetList(self._activityId)
	end)
end

function InfinfuMissionView:procMid()
	local titleStr = self.actcfg.checkpointsName
	local levelStr = self._stageId
	local ruleDesc = "击败所有对方精灵"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_initFormCondition(self._curformCond)
end

function InfinfuMissionView:_isVretaModel()
	local curForm = self:_getCurFormation()
	local curPetPos = curForm:GetPositions()
	local helperPetList = InfinitefutureModel.instance:getHelperPet(self._activityId)
	local isPass = false

	isPass = self._activityId ~= InfinitefutureModel.instance.viretaActIds[3]

	for k, v in pairs(curPetPos) do
		for i, pet in pairs(helperPetList) do
			if pet.petId == v then
				isPass = true
			end
		end
	end

	return isPass
end

function InfinfuMissionView:_startNow()
	local isPass = self:_isVretaModel()

	if not isPass then
		TipsFacade.instance:openTipWindow(lang("tip"), "必须上阵援助精灵哦~", function()
			self:_setMaskBlock(false)
		end, "确定")
		self:_setMaskBlock(false)

		return
	else
		self:_startBattle()
	end
end

function InfinfuMissionView:_startBattle()
	GlobalDispatcher:removeListener(GlobalNotify.FormationRefresh, self._startNow, self)
	self:_setMaskBlock(true)
	self:_setBattleResultTxtTitle()

	local curForm = self:_getCurFormation()

	InfinitefutureController.instance:sendChallengeReq(self._activityId, self._stageId, self._teamId, curForm)
	InfinitefutureModel.instance:setSpecialFormation(self._activityId, curForm)
	UIJumper.instance:saveCurStack()
	UIJumper.instance:removeTopState(self._viewPresentor.viewName)
end

function InfinfuMissionView:_isShowBtnEvaluate()
	return false
end

function InfinfuMissionView:_isFormationValidatorMatchOnStart()
	if self._curformCond then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._curformCond, self:_getCurFormation()))
	end

	return true
end

function InfinfuMissionView:_onFormationChangeFinish()
	InfinfuMissionView.super._onFormationChangeFinish(self)

	if self._curformCond then
		self:_setValidatorDesc(self._curformCond)
	end
end

function InfinfuMissionView:_maxPetNum()
	return self.actcfg.fullMonster and 9 or 5
end

function InfinfuMissionView:notFilterPet(petMo)
	local lock = InfinitefutureModel.instance:isBeLock(petMo.raceId)

	return not lock
end

function InfinfuMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), GameUtil.handler(self.notFilterPet, self), function(posList, petPool)
		if self:_maxPetNum() == 9 then
			local needPets = FastFormation.instance.needPets
			local count = 9 - table.nums(petPool)
			local tem = {}

			for i, petMo in ipairs(needPets) do
				local isHas = false

				for k, v in pairs(petPool) do
					if v == petMo then
						isHas = true

						break
					end
				end

				if isHas == false then
					table.insert(tem, petMo)

					count = count - 1

					if count <= 0 then
						break
					end
				end
			end

			for i = 1, 9 do
				if table.indexof(posList, i) == false then
					table.insert(posList, i)
				end

				if petPool[i] == nil and #tem > 0 then
					petPool[i] = table.remove(tem, 1)
				end
			end
		end

		return posList, petPool
	end)
	MissionModel.instance:setForceResetOneKey(false)
end

function InfinfuMissionView:_getCurFormation()
	return InfinitefutureModel.instance:GetCurFormation(self._activityId)
end

return InfinfuMissionView
