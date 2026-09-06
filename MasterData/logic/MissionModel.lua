-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mission/model/MissionModel.lua

module(..., package.seeall)

local MissionModel = class("MissionModel", BaseModel)

function MissionModel:ctor()
	MissionModel.super.ctor(self)
	self:onReset()
end

function MissionModel:onInit()
	self:onReset()
end

function MissionModel:onReset()
	self._enterBattleConditionId = 0
	self._leftSpeed = 0
	self._rightSpeed = 0
	self._leftPower = 0
	self._rightPower = 0
	self._enemyPetPoses = {}
	self._isPlayEnterAnim = true
	self._commonRuleTxt = nil
	self._perfectRuleTxt = nil
	self._ruleParam = nil
	self._maxPetNum = 5
	self._fixedPosDic = nil
	self._fixedPosList = nil
	self._formCondition = nil
end

function MissionModel:setMaxPetNum(num)
	self._maxPetNum = num <= 9 and num or 5
end

function MissionModel:getMaxPetNum()
	return self._maxPetNum
end

function MissionModel:setLeftSpeed(speed)
	self._leftSpeed = speed
end

function MissionModel:setRightSpeed(speed)
	self._rightSpeed = type(speed) == "number" and speed or 0
end

function MissionModel:getRightSpeed()
	return self._rightSpeed or 0
end

function MissionModel:isLeftFirst()
	return self._leftSpeed >= self._rightSpeed
end

function MissionModel:setLeftPower(power)
	self._leftPower = power
end

function MissionModel:getLeftPower()
	return self._leftPower
end

function MissionModel:setRightPower(power)
	self._rightPower = type(power) == "number" and power or 0
end

function MissionModel:getRightPower()
	return self._rightPower or 0
end

function MissionModel:notEnoughPower(mul)
	mul = mul or 0.9

	return self._leftPower < self._rightPower * mul
end

function MissionModel:setBattleConditionId(id)
	self._enterBattleConditionId = checknumber(id)
end

function MissionModel:getBattleConditionId()
	return self._enterBattleConditionId
end

function MissionModel:setPetPoses(petPoses)
	self._enemyPetPoses = petPoses
end

function MissionModel:getEnemyPetPoses()
	return self._enemyPetPoses
end

function MissionModel:setIsPlayEnterAnim(isPlay)
	self._isPlayEnterAnim = isPlay
end

function MissionModel:getIsPlayEnterAnim()
	self._isPlayEnterAnim = true

	return self._isPlayEnterAnim
end

function MissionModel:setEnemyFormations(formations)
	self._enemyFormation = formations

	self:setForceResetOneKey(true)
end

function MissionModel:getEnemyFormations()
	return self._enemyFormation
end

function MissionModel:getForceResetOneKey()
	return checkbool(self._resetOneKey)
end

function MissionModel:setForceResetOneKey(boo)
	self._resetOneKey = boo
end

function MissionModel:setRuleDesc(commonRuleTxt, perfectRuleTxt)
	self._commonRuleTxt = commonRuleTxt
	self._perfectRuleTxt = perfectRuleTxt
end

function MissionModel:getRuleDesc()
	if self._commonRuleTxt then
		if not self._commonRuleTxt then
			local commonRule = ""

			if self._perfectRuleTxt then
				if not self._perfectRuleTxt then
					local perfectRuleTxt = ""

					return commonRule, perfectRuleTxt
				end
			end
		end
	end
end

function MissionModel:setRuleParam(param)
	self._ruleParam = param
end

function MissionModel:getRuleParam()
	return self._ruleParam
end

function MissionModel:setFixedPos(poses)
	if poses then
		self._fixedPosList = poses
		self._fixedPosDic = {}

		for i, v in ipairs(poses) do
			self._fixedPosDic[v] = true
		end
	else
		self._fixedPosList = nil
		self._fixedPosDic = nil
	end
end

function MissionModel:isFixedPos(posIndex)
	if self._fixedPosDic then
		return self._fixedPosDic[posIndex]
	else
		return false
	end
end

function MissionModel:getFixedPos()
	return self._fixedPosDic
end

function MissionModel:setFormCondition(formCondition)
	self._formCondition = formCondition
end

function MissionModel:getFormCondition()
	return (self._formCondition or nil) and (self._formCondition or 0)
end

MissionModel.instance = MissionModel.New()

return MissionModel
