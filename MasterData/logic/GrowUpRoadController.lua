-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/growup/controller/GrowUpRoadController.lua

module("logic.extensions.growup.controller.GrowUpRoadController", package.seeall)

local GrowUpRoadController = class("GrowUpRoadController", BaseController)

GrowUpRoadController.PM_PetGrowthPathGetInfoRes = "GrowUpRoadController.PM_PetGrowthPathGetInfoRes"
GrowUpRoadController.PM_PetGrowthPathGainPetRes = "GrowUpRoadController.PM_PetGrowthPathGainPetRes"
GrowUpRoadController.PM_PetGrowthPathGetTaskInfosRes = "GrowUpRoadController.PM_PetGrowthPathGetTaskInfosRes"
GrowUpRoadController.PM_PetGrowthPathGainTaskPrizeRes = "GrowUpRoadController.PM_PetGrowthPathGainTaskPrizeRes"
GrowUpRoadController.PM_PetGrowthPathStrengthenRes = "GrowUpRoadController.PM_PetGrowthPathStrengthenRes"

function GrowUpRoadController:getPetInfo(raceId)
	local allPets = BagModel.instance:getPetsByRaceId(raceId)

	if #allPets > 0 then
		for _, p in ipairs(allPets) do
			if self:isMaxPet(p) then
				return p
			end
		end

		return allPets[1]
	end

	local petCo = clone(CharacterConfig.instance:getPetCo(raceId))
	local shamPet = GrowUpRoadConfig.instance:getShamPetById(raceId)

	petCo.petId = -1
	petCo.sham = shamPet or {}

	local strength = GrowUpRoadModel.instance:getCurStrengthenType() or 0

	petCo.level = strength < 1 and 1 or 100
	petCo.starLv = strength < 2 and 1 or 50
	petCo.equipLv = strength < 3 and 0 or 5
	petCo.potential = strength < 4 and 1 or 5
	petCo.awakeLevel = strength < 5 and 1 or 6

	function petCo.getFightingPower()
		return shamPet.power[strength + 1]
	end

	return petCo
end

function GrowUpRoadController:handlePM_PetGrowthPathGetInfoRes(msg)
	GrowUpRoadModel.instance:setHasGainPet(msg.activityId, msg.hasGainPet)
	GlobalDispatcher:dispatch(GrowUpRoadController.PM_PetGrowthPathGetInfoRes)
end

function GrowUpRoadController:handlePM_PetGrowthPathGainPetRes(msg)
	GlobalDispatcher:dispatch(GrowUpRoadController.PM_PetGrowthPathGainPetRes, msg.activityId)
end

function GrowUpRoadController:handlePM_PetGrowthPathGetTaskInfosRes(msg)
	local activityCfg = GrowUpRoadConfig.instance:getActivityByActivityId(msg.activityId)

	MaterialModel.instance:UpdateMaterial(MatType.Item_Fake, activityCfg.scoreId, msg.totalScore)
	GrowUpRoadModel.instance:setCurId(msg.curId)
	GrowUpRoadModel.instance:setTaskInfo(msg.taskInfos)
	GlobalDispatcher:dispatch(GrowUpRoadController.PM_PetGrowthPathGetTaskInfosRes)
end

function GrowUpRoadController:handlePM_PetGrowthPathGainTaskPrizeRes(msg)
	GrowUpRoadModel.instance:gainTaskPrizeById(msg.taskId)

	local activityCfg = GrowUpRoadConfig.instance:getActivityByActivityId(msg.activityId)
	local taskCfg = GrowUpRoadConfig.instance:getTaskByPlanId(activityCfg.taskPlanId)

	MaterialModel.instance:AddMaterial(MatType.Item_Fake, activityCfg.scoreId, taskCfg[msg.taskId].score)
	GlobalDispatcher:dispatch(GrowUpRoadController.PM_PetGrowthPathGainTaskPrizeRes)
end

function GrowUpRoadController:handlePM_PetGrowthPathStrengthenRes(msg)
	GrowUpRoadModel.instance:setCurId(GrowUpRoadModel.instance:getCurStrengthenType() + 1)

	local activityCfg = GrowUpRoadConfig.instance:getActivityByActivityId(msg.activityId)
	local cfg = GrowUpRoadConfig.instance:getStrengthById(activityCfg.strengthenPlanId)

	MaterialModel.instance:AddMaterial(MatType.Item_Fake, activityCfg.scoreId, -1 * cfg[GrowUpRoadModel.instance:getCurStrengthenType()].needScore)
	GlobalDispatcher:dispatch(GrowUpRoadController.PM_PetGrowthPathStrengthenRes)
end

function GrowUpRoadController:isMaxPet(petInfo)
	if petInfo and petInfo.starGodPlusSlots then
		local raceId = petInfo.raceId
		local levelFlag = petInfo.curLv == CharacterConfig.instance:GetMaxLevel(raceId)
		local starFlag = true

		for i, starGod in ipairs(petInfo.starGodPlusSlots) do
			local cfg = StargodplusConfig.instance:getSlotCfg(i)
			local planCfg = StargodplusConfig.instance:getSlotLvPlan(cfg.slotLvPlan)
			local Lv = StargodplusModel.instance:getSlotLv(i, starGod.exp)

			starFlag = starFlag and Lv == StargodplusModel.instance:getSlotLv(i, planCfg[#planCfg].exp)
		end

		local Passive = BagPetsController.instance:getPetSkillMaxLevel(petInfo.raceId, GameEnum.SkillRaceType.Passive)
		local Normal = BagPetsController.instance:getPetSkillMaxLevel(petInfo.raceId, GameEnum.SkillRaceType.Normal)
		local Ult = BagPetsController.instance:getPetSkillMaxLevel(petInfo.raceId, GameEnum.SkillRaceType.Ult)
		local potentialFlag = Normal <= petInfo.normalSkillLv and Ult <= petInfo.ultimateSkillLv and Passive <= petInfo.passiveSkillLv

		return levelFlag and starFlag and potentialFlag and petInfo.awakeLevel == CharacterConfig.instance:getMaxAwaken(raceId)
	end

	return false
end

function GrowUpRoadController:getActivityById(id)
	local activity, result = GrowUpRoadConfig.instance:getActivityById(id), {}

	for k, v in pairs(activity) do
		table.insert(result, v)
	end

	table.sort(result, function(a, b)
		return a.activityId < b.activityId
	end)

	return result
end

function GrowUpRoadController:getTaskContentByPlanId(planId)
	local taskCfg = clone(GrowUpRoadConfig.instance:getTaskByPlanId(planId))
	local taskTypeContent, result = {}, {}

	for i, v in ipairs(taskCfg) do
		local taskInfo = GrowUpRoadModel.instance:getTaskInfoById(v.id)

		if taskInfo.curProcess < v.maxProgress then
			v.state = 2

			if taskTypeContent[v.type] == nil or taskTypeContent[v.type].state == 3 then
				taskTypeContent[v.type] = v
			end
		elseif taskInfo.hasGainPrize then
			v.state = 3
			taskTypeContent[v.type] = v
		else
			v.state = 1

			if taskTypeContent[v.type] == nil or taskTypeContent[v.type].state == 3 then
				taskTypeContent[v.type] = v
			end
		end
	end

	for k, v in pairs(taskTypeContent) do
		table.insert(result, v)
	end

	result = ArraySort.sortOn(result, {
		"state",
		"id"
	})

	return result
end

function GrowUpRoadController:openGrowRoadTask(activity, layout)
	if type(activity) == "table" then
		UIStateManager.instance:push(ViewName.HeartGrowUpTaskView, activity, layout)
	else
		UIStateManager.instance:push(ViewName.HeartGrowUpTaskView, GrowUpRoadConfig.instance:getActivityByActivityId(activity), layout)
	end
end

function GrowUpRoadController:getHasGainPet(activityId, callback)
	self._returnGainPetResultActivityId = activityId
	self._returnGainPetResultCallback = callback

	GlobalDispatcher:addListener(GrowUpRoadController.PM_PetGrowthPathGetInfoRes, self._returnGainPetResult, self)
	PetGrowthPathAgent.instance:sendPM_PetGrowthPathGetInfoReq(activityId)
end

function GrowUpRoadController:_returnGainPetResult()
	GlobalDispatcher:removeListener(GrowUpRoadController.PM_PetGrowthPathGetInfoRes, self._returnGainPetResult, self)
	self._returnGainPetResultCallback(GrowUpRoadModel.instance:getHasGainPet(self._returnGainPetResultActivityId))
end

function GrowUpRoadController:isNotGotoByTaskType(taskType)
	if not EscortModel.instance:IsPickupEscort() then
		return false
	end

	taskType = checknumber(taskType)

	if taskType == 2 or taskType == 3 or taskType == 5 or taskType == 6 or taskType == 8 or taskType == 9 or taskType == 18 or taskType == 22 or taskType == 25 or taskType == 27 or taskType == 28 or taskType == 30 or taskType == 35 or taskType == 41 or taskType == 47 or taskType == 49 or taskType == 84 or taskType == 85 then
		return true
	end

	return false
end

GrowUpRoadController.instance = GrowUpRoadController.New()

return GrowUpRoadController
