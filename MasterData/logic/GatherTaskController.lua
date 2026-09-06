-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/gathertask/controller/GatherTaskController.lua

module("logic.extensions.gathertask.controller.GatherTaskController", package.seeall)

local GatherTaskController = class("GatherTaskController", BaseController)

function GatherTaskController:ctor()
	GatherTaskController.super.ctor(self)
end

function GatherTaskController:onInit()
	GlobalDispatcher:addListener("gathertask_find_npc", self.moveToNpc, self)
	GlobalDispatcher:addListener(GlobalNotify.SelectNPC, self._onSelectNpc, self)
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyResetData, self)
	self:onReset()
end

function GatherTaskController:onReset()
	self.isInited = false
	self.currGatherNpcId = -1
	self.tempPirzeId = nil
	self.tempMaterialId = nil
end

function GatherTaskController:getActivityId()
	return 100001
end

function GatherTaskController:_onSelectNpc(_npcId)
	if not _npcId then
		return
	end

	if _npcId == self.currGatherNpcId then
		local num = #self.materialList

		if num > 0 then
			local randIdx = math.random(1, num)
			local id = self.materialList[randIdx]

			self:sendGetMaterial(id)
		end
	end
end

function GatherTaskController:_dailyResetData()
	self.isInited = false

	self:getInfo()
end

function GatherTaskController:getInfo()
	local cfg = ActivityDefineController.instance:getActivityCfgByType(GameEnum.ActivityType.GatherTask)

	if cfg ~= nil then
		if self.isInited == false then
			local activityId = self:getActivityId()

			ChristmasGatherAgent.instance:sendPM_ChristmasGatherGetInfoReq(activityId)
		else
			GlobalDispatcher:dispatch(GlobalNotify.GatherTask_INFO)
		end
	end
end

function GatherTaskController:onGetInfo(msg)
	forcePrint("=====RoleDataRequestor:_loadGatherTaskInfo===back")

	self.isInited = true

	GatherTaskModel.instance:onGetInfo(msg)
	self:createRandNpc()
	GlobalDispatcher:dispatch(GlobalNotify.GatherTask_INFO)
end

function GatherTaskController:sendGetPrize(prizeId)
	self.tempPirzeId = prizeId

	local activityId = self:getActivityId()

	ChristmasGatherAgent.instance:sendPM_ChristmasGatherGainProgressPrizeReq(activityId, prizeId)
end

function GatherTaskController:onGetPrize(msg)
	if checknumber(self.tempPirzeId) > 0 then
		GatherTaskModel.instance:addPrizeId(checknumber(self.tempPirzeId))
	end

	self.tempPirzeId = nil

	GlobalDispatcher:dispatch(GlobalNotify.GatherTask_INFO)
end

function GatherTaskController:sendGetMaterial(materialId)
	self.tempMaterialId = materialId

	local activityId = self:getActivityId()

	ChristmasGatherAgent.instance:sendPM_ChristmasGatherGainMaterialReq(activityId, materialId)
end

function GatherTaskController:onGetMaterial(msg)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GATHER_TASK_NPC, false)

	local changeSetId = msg.changeSetId
	local items = MaterialController.instance:getItemsByChangeSetId(changeSetId)

	if items then
		local matId = checknumber(self.tempMaterialId)

		if matId > 0 then
			local activityId = self:getActivityId()
			local actCfg = GatherTaskConfig.instance:getActivityCfgById(activityId)
			local materialPlanId = actCfg.materialPlanId
			local matCfg = GatherTaskConfig.instance:getMaterialCfgById(materialPlanId, matId)
			local item = matCfg.item
			local matType, id, num = MaterialMgr.getMatParams(item)
			local mo = MaterialModel.instance:UpdateMaterial(matType, id, 1)

			table.insert(items, mo)

			self.tempMaterialId = nil

			GatherTaskModel.instance:addMaterial(matId)
			self:createRandNpc()
			GlobalDispatcher:dispatch(GlobalNotify.GatherTask_INFO)
		end
	end

	AnimationPlayer.play("storyconfig/animations/ui_yilishaibai_jiemian.txt", function()
		UIStateManager.instance:push(ViewName.GathertaskView)

		if items then
			MaterialController.instance:showChangeSetItemMo(items, changeSetId)
		end
	end, function()
		PetCvController.instance:_playPetCvByIndex(10127, 1, false, null)
	end)
end

function GatherTaskController:checkHasNpcAndSetRedpoint()
	if self.currGatherNpcId > 0 then
		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GATHER_TASK_NPC, true)
	end
end

function GatherTaskController:moveToNpc()
	if self.currGatherNpcId > 0 then
		UIStateManager.instance:clear(true)

		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:stopAllActions(true)
			mainPlayer:gotoNpcCrossSceneWithFullScenePath(self.currGatherNpcId)
		end
	end
end

function GatherTaskController:createRandNpc()
	self:createNowMaterialList()

	if self.currGatherNpcId > 0 then
		SceneNpcsMgr.instance:removeNpc(self.currGatherNpcId)
	end

	local num = #self.materialList

	if num > 0 then
		local activityId = self:getActivityId()
		local actCfg = GatherTaskConfig.instance:getActivityCfgById(activityId)
		local materialPlanId = actCfg.materialPlanId
		local npcList = GatherTaskConfig.instance:getNpcCfgList(materialPlanId)

		if npcList then
			for i = 1, 10 do
				local randIdx = math.random(1, #npcList)
				local npcCfg = npcList[randIdx]

				if npcCfg and checknumber(npcCfg.npcId) ~= self.currGatherNpcId then
					self.currGatherNpcId = checknumber(npcCfg.npcId)

					break
				end
			end

			if self.currGatherNpcId > 0 then
				SceneNpcsMgr.instance:createNpc(self.currGatherNpcId)
			end
		end
	else
		self.currGatherNpcId = -1

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_GATHER_TASK_NPC, false)
	end
end

function GatherTaskController:createNowMaterialList()
	local activityId = self:getActivityId()
	local startTimestamp, endTimestamp = ActivityDefineController.instance:getStartTimeAndEndTime(GameEnum.ActivityType.GatherTask, activityId)
	local dayTimestamp = 86400
	local nowTime = ServerTime.now()
	local actCfg = GatherTaskConfig.instance:getActivityCfgById(activityId)
	local materialPlanId = actCfg.materialPlanId

	self.materialList = {}

	local matList = GatherTaskConfig.instance:getMaterialCfgList(materialPlanId)

	for i, v in ipairs(matList) do
		local offsetDay = checknumber(v.openDay) - 1
		local startTime = startTimestamp + dayTimestamp * offsetDay

		if startTime <= nowTime and nowTime < endTimestamp then
			local matId = v.id
			local count = v.maxCount
			local cur = GatherTaskModel.instance:getMatNum(matId)

			if cur < count then
				table.insert(self.materialList, matId)
			end
		end
	end
end

GatherTaskController.instance = GatherTaskController.New()

return GatherTaskController
