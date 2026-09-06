-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xingjiang/view/XjMissionView.lua

module("logic.extensions.xingjiang.view.XjMissionView", package.seeall)

local XjMissionView = class("XjMissionView", MissionView)

function XjMissionView:ctor()
	XjMissionView.super.ctor(self)
end

function XjMissionView:onEnter()
	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._teamId = params[3]
	self._creepsMasterId = params[4]
	self._curformCond = XingJiangConfig.instance:getTeamCfg(self._creepsMasterId).formCondition

	self:onEnterInherit()
	self:procMid()
	FastFormation.instance:setCurFormFunc(function()
		return self:_getCurFormation()
	end)
end

function XjMissionView:procMid()
	local titleStr = "精灵挑战"
	local levelStr = self._stageId
	local ruleDesc = "击败所有对方精灵"

	self:_setDescStr(titleStr, levelStr, ruleDesc)
	self:_initFormCondition(self._curformCond)
end

function XjMissionView:_enterBattle()
	UIJumper.instance:saveCurStack(self._viewPresentor.viewName)

	local simpleForm
	local fmo = self:_getCurFormation()

	simpleForm = fmo:createFormPb()
	simpleForm.formId = 0

	XingJiangController.instance:sendChallengeReq(self._activityId, self._stageId, self._teamId, simpleForm)
end

function XjMissionView:_isShowBtnEvaluate()
	return false
end

function XjMissionView:_isFormationValidatorMatchOnStart()
	if self._curformCond then
		return (FormationValidatorController.instance:isFormationValidatorMatchOnStart(self._curformCond, self:_getCurFormation()))
	end

	return true
end

function XjMissionView:_onFormationChangeFinish()
	XjMissionView.super._onFormationChangeFinish(self)

	if self._curformCond then
		self:_setValidatorDesc(self._curformCond)
	end
end

function XjMissionView:_maxPetNum()
	return 9
end

function XjMissionView:_onClickOneKey()
	SurveyController.instance:reportBehavior(SurveyBehaviorID.ClickAutoFormationButton)
	FastFormation.instance:setFormation(MissionModel.instance:getForceResetOneKey(), nil, function(posList, petPool)
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

function XjMissionView:_getCurFormation()
	return (XingJiangModel.instance:GetCurFormation())
end

return XjMissionView
