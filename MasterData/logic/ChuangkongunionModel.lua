-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chuangkongunion/model/ChuangkongunionModel.lua

module("logic.extensions.chuangkongunion.view.ChuangkongunionModel", package.seeall)

local ChuangkongunionModel = class("ChuangkongunionModel", BaseModel)

function ChuangkongunionModel:ctor()
	return
end

function ChuangkongunionModel:onInit()
	self:onReset()
end

function ChuangkongunionModel:onReset()
	self._activityId = 0
	self._taskInfos = {}
	self._finishedTask = 0
	self._formation = {}
	self._breachforminfos = {}
end

function ChuangkongunionModel:setSupport(support)
	self._supportPlan = support
end

function ChuangkongunionModel:getAllHelpPets()
	local helpPets = {}
	local supportCfg = ChuangkongunionConfig.instance:getBreachFormPetById(self._supportPlan) or {}

	for _, v in pairs(supportCfg) do
		local pet = LightKingModel.instance:_createPet(v)

		table.insert(helpPets, pet)
	end

	return helpPets
end

function ChuangkongunionModel:getPetMo(petId)
	local supportCfg = ChuangkongunionConfig.instance:getBreachFormPetById(self._supportPlan) or {}
	local creepCfg

	for _, v in pairs(supportCfg) do
		if v.creepsId == petId then
			creepCfg = v

			break
		end
	end

	return LightKingModel.instance:_createPet(creepCfg)
end

function ChuangkongunionModel:initFormation(teamId)
	self._formation = self._formation or {}
	self._formation[teamId] = self._formation[teamId] or FormationMO.New(GameUtil.handler(self.getPetMo, self))
end

function ChuangkongunionModel:getFormation(teamId)
	return self._formation and self._formation[teamId]
end

function ChuangkongunionModel:getActId()
	return self._activityId
end

function ChuangkongunionModel:setActId(actId)
	self._activityId = actId
end

function ChuangkongunionModel:onCKUGetTrialInfoRes(msg)
	self._breachforminfos = GameUtil.pbToTable(msg.breachFormInfos)
end

function ChuangkongunionModel:onCKUTrialEndRes(msg)
	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == msg.taskId and msg.isWin and v.passedStage < msg.stage then
			v.passedStage = msg.stage
		end
	end
end

function ChuangkongunionModel:isFinishTrial(taskId, stage)
	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == taskId and stage <= v.passedStage then
			return true
		end
	end

	return false
end

function ChuangkongunionModel:isCurTrial(taskId, stage)
	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == taskId and v.passedStage + 1 == stage then
			return true
		end
	end

	return false
end

function ChuangkongunionModel:curTrialStage(taskId)
	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == taskId then
			return v.passedStage
		end
	end

	return 0
end

function ChuangkongunionModel:isOpenTrial(taskId)
	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == taskId then
			return v.isOpen
		end
	end

	return false
end

function ChuangkongunionModel:isFinishPreTrial(taskId)
	local preTask = ChuangkongunionConfig.instance:getBreachFormCfg(self:getActId())
	local cfg = preTask[taskId]
	local preTaskCfg = cfg.preBreachFormTask

	if preTaskCfg == nil or #preTaskCfg ~= 2 then
		return true
	end

	for i, v in ipairs(self._breachforminfos) do
		if v.taskId == preTaskCfg[1] then
			return v.passedStage >= preTaskCfg[2]
		end
	end

	return false
end

function ChuangkongunionModel:onCKUGetDailyTaskInfoRes(msg)
	self._activityId = msg.activityId
	self._taskInfos = GameUtil.pbToTable(msg.taskInfos)
	self._finishedTask = msg.finishedTask
end

function ChuangkongunionModel:onCKUDailyTaskEndRes(msg)
	self._activityId = msg.activityId

	for i, v in ipairs(self._taskInfos) do
		if v.taskId == msg.taskId then
			v.canSweep = msg.sweep
			v.taskFinish = msg.taskFinish

			if msg:HasField("damage") then
				if v.everMaxDamage then
					if v.everMaxDamage < msg.damage then
						v.everMaxDamage = msg.damage
					end
				else
					v.everMaxDamage = msg.damage
				end
			end

			if msg.taskFinish then
				self._finishedTask = self._finishedTask + 1
			end

			break
		end
	end
end

function ChuangkongunionModel:getTeamId(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return (v.contents or nil) and (v.contents[1] or 0)
		end
	end

	return 0
end

function ChuangkongunionModel:getEverMaxDamage(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.everMaxDamage
		end
	end

	return 0
end

function ChuangkongunionModel:getQuestionIdList(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.contents
		end
	end

	return {}
end

function ChuangkongunionModel:isFinishTask(taskId)
	return taskId <= self._finishedTask
end

function ChuangkongunionModel:isOpenTask(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.isOpen
		end
	end

	return false
end

function ChuangkongunionModel:isCanDoTask(taskId)
	return self._finishedTask + 1 == taskId
end

function ChuangkongunionModel:hasAnyTaskCanDo()
	local taskNum = #ChuangkongunionConfig.instance:getTaskCfg(self:getActId())

	return taskNum > self._finishedTask
end

function ChuangkongunionModel:canSweepTask(taskId)
	for i, v in ipairs(self._taskInfos) do
		if v.taskId == taskId then
			return v.canSweep
		end
	end

	return false
end

ChuangkongunionModel.instance = ChuangkongunionModel.New()

return ChuangkongunionModel
