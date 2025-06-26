-- chunkname: @IQIGame\\Scene\\StateMachine\\StateMachine.lua

local m = {
	UpdateInterval = 0.05,
	RecordedTime = 0,
	UpdateElapsedTime = 0,
	Triggers = {}
}

function m.New(controller, cid)
	local obj = Clone(m)

	obj:Init(controller.gameObject, cid)

	return obj
end

function m:BaseInit(gameObject, cid)
	self.gameObject = gameObject
	self.SkeletonAnimation = gameObject:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))

	local cfgStateMachineData = CfgStateMachineTable[cid]

	self.ScriptName = cfgStateMachineData.ScriptName

	local scriptExist = GameEntry.VisualScript:HasVisualScript(self.ScriptName)

	if scriptExist then
		self:__InitAfterLoaded()
	else
		GameEntry.VisualScript:LoadVisualScript(self.ScriptName, "Assets/11_Tables/Vs/" .. cfgStateMachineData.AssetName .. ".xml")
	end
end

function m:__InitAfterLoaded()
	self.script = GameEntry.VisualScript:GetVisualScript(self.ScriptName)

	self:RegisterAllNodeAction()
	self:RegisterAllNodeCondition()
	self:RegisterAllActionCondition()

	self.script.Enable = true

	self.script:Restart()
end

function m:BaseRegisterAllNodeAction()
	self.script:RegistActionFunc("setAnimation", self:GetActionFunc(self.ActionSetAnimation))
	self.script:RegistActionFunc("setVisible", self:GetActionFunc(self.ActionSetVisible))
	self.script:RegistActionFunc("playEffect", self:GetActionFunc(self.ActionPlayEffect))
	self.script:RegistActionFunc("recordTime", self:GetActionFunc(self.ActionRecordTime))
	self.script:RegistActionFunc("getRandomNumber", self:GetActionFunc(self.ActionGetRandomNumber))
end

function m:BaseRegisterAllNodeCondition()
	self.script:RegistConditionFunc("isAnimationEnd", self:GetCOrACFunc(self.ConditionIsAnimationEnd))
	self.script:RegistConditionFunc("isCurAnimationEnd", self:GetCOrACFunc(self.ConditionIsCurAnimationEnd))
	self.script:RegistConditionFunc("isTimeElapsed", self:GetCOrACFunc(self.ConditionIsTimeElapsed))
	self.script:RegistConditionFunc("nodeTimeCompareTo", self:GetCOrACFunc(self.ConditionNodeTimeCompareTo))
	self.script:RegistConditionFunc("trigger", self:GetCOrACFunc(self.ConditionTrigger))
end

function m:BaseRegisterAllActionCondition()
	self.script:RegistActionConditionFunc("compareWithScriptVariable", self:GetCOrACFunc(self.AcCompareWithScriptVariable))
	self.script:RegistActionConditionFunc("scriptVariableScope", self:GetCOrACFunc(self.AcScriptVariableScope))
end

function m:GetActionFunc(func)
	return function(param)
		func(self, param)
	end
end

function m:GetCOrACFunc(func)
	return function(param)
		return func(self, param)
	end
end

function m:ActionSetAnimation(param)
	local animationName = param:GetParamAsString(2)
	local loop = param:getParamAsBoolean(3)

	self:PlayAnimation(animationName, loop)
end

function m:PlayAnimation(animationName, loop)
	self:BasePlayAnimation(animationName, loop)
end

function m:BasePlayAnimation(animationName, loop)
	if self.CurrentAnimationName == animationName then
		return
	end

	if self.SkeletonAnimation ~= nil then
		if self.SkeletonAnimation.state ~= nil then
			local animData = self.SkeletonAnimation.state.Data.SkeletonData:FindAnimation(animationName)

			if animData ~= nil then
				self.SkeletonAnimation.state:ClearTrack(0)
				self.SkeletonAnimation.skeleton:SetToSetupPose()
				self.SkeletonAnimation.state:SetAnimation(0, animationName, loop)

				self.CurrentAnimationName = animationName
			end
		else
			logError("State machine play animation error, state is null. Animation name: " .. animationName .. " gameObject: " .. self.gameObject.name)
		end
	end
end

function m:ActionSetVisible(param)
	local value = param:getParamAsBoolean(2)
	local renderers = self.gameObject:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, renderers.Length - 1 do
		renderers[i].enabled = value
	end
end

function m:ActionPlayEffect(param)
	local effectCid = param:GetParamAsInt(2)
	local offsetX = param:GetParamAsFloat(3)
	local offsetY = param:GetParamAsFloat(4)
	local position = self.gameObject.transform.position

	position.x = position.x + offsetX
	position.y = position.y + offsetY

	local renderer = self.gameObject:GetComponentInChildren(typeof(UnityEngine.Renderer))

	GameEntry.Effect:PlayNormalEffect(effectCid, position, 0, 0, 0, renderer.sortingLayerID, renderer.sortingOrder + 1)
end

function m:ActionRecordTime(param)
	self.RecordedTime = UnityEngine.Time.time
end

function m:ActionGetRandomNumber(param)
	local minValue = param:GetParamAsInt(2)
	local maxValue = param:GetParamAsInt(3)
	local variableName = param:GetParamAsString(4)
	local randomValue = math.random(minValue, maxValue)

	self.script:SavaVariable(variableName, randomValue)
end

function m:ConditionIsAnimationEnd(param)
	return self:IsAnimationEnd(param:GetParamAsString(0))
end

function m:ConditionIsCurAnimationEnd(param)
	if self.CurrentAnimationName == nil then
		return true
	end

	return self:IsAnimationEnd(self.CurrentAnimationName)
end

function m:IsAnimationEnd(animationName)
	if self.SkeletonAnimation ~= nil and self.SkeletonAnimation.AnimationName == animationName then
		return self.SkeletonAnimation.state:GetCurrent(0).IsComplete
	end

	return true
end

function m:ConditionIsTimeElapsed(param)
	local value = param:GetParamAsFloat(0)

	return value < UnityEngine.Time.time - self.RecordedTime
end

function m:ConditionNodeTimeCompareTo(param)
	local compareType = param:GetParamAsInt(0)
	local compareValue = param:GetParamAsInt(1)
	local elapsedTime = math.floor((UnityEngine.Time.realtimeSinceStartup - self.script.CurrentNodeEnterTime) * 1000)

	return self:Compare(compareType, compareValue, elapsedTime)
end

function m:ConditionTrigger(param)
	local triggerName = param:GetParamAsString(0)
	local isTriggered = self.Triggers[triggerName] ~= nil

	self.Triggers[triggerName] = nil

	return isTriggered
end

function m:AcCompareWithScriptVariable(param)
	local compareType = tonumber(param[0])
	local sourceVariableName = param[1]
	local sourceVariableValue = self.script:GetVariable(sourceVariableName)
	local compareValue = tonumber(param[2])

	return self:Compare(compareType, compareValue, sourceVariableValue)
end

function m:Compare(type, targetValue, dataValue)
	if type == 0 then
		return dataValue == targetValue
	elseif type == 1 then
		return targetValue < dataValue
	elseif type == 2 then
		return dataValue < targetValue
	elseif type == 3 then
		return targetValue <= dataValue
	elseif type == 4 then
		return dataValue <= targetValue
	end

	return false
end

function m:AcScriptVariableScope(param)
	local sourceVariableValue = self.script:GetVariable(param[0])

	for i = 1, param.Length - 1 do
		if sourceVariableValue == tonumber(param[i]) then
			return true
		end
	end

	return false
end

function m:SetTrigger(name)
	self.Triggers[name] = name
end

function m:Update()
	if self.UpdateElapsedTime >= self.UpdateInterval then
		self.UpdateElapsedTime = 0

		if self.script == nil then
			local scriptExist = GameEntry.VisualScript:HasVisualScript(self.ScriptName)

			if scriptExist then
				self:__InitAfterLoaded()
			end
		else
			self.script:Update()
		end
	end

	self.UpdateElapsedTime = self.UpdateElapsedTime + UnityEngine.Time.deltaTime
end

function m:BaseDispose()
	GameEntry.VisualScript:DestroyVisualScript(self.script)

	self.gameObject = nil
	self.SkeletonAnimation = nil
	self.script = nil
end

StateMachine = m
