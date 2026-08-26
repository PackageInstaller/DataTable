-- chunkname: @modules/logic/explore/controller/ExploreController.lua

module("modules.logic.explore.controller.ExploreController", package.seeall)

local ExploreController = class("ExploreController", BaseController)

function ExploreController:onInit()
	ResDispose.open()
end

function ExploreController:onInitFinish()
	return
end

function ExploreController:addConstEvents()
	TaskController.instance:registerCallback(TaskEvent.UpdateTaskList, self._onUpdateTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnDeleteTask, self._onDeleteTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.SetTaskList, self._onSetTaskList, self)
	TaskController.instance:registerCallback(TaskEvent.OnFinishTask, self._onFinishTask, self)
	self.registerCallback(self, ExploreEvent.OpenGuideDialogueView, self._openGuideDialogue, self)
end

function ExploreController:_onUpdateTaskList(msg)
	local hasChange = false

	for _, info in ipairs(msg.taskInfo) do
		if info.type == TaskEnum.TaskType.Explore then
			hasChange = true

			break
		end
	end

	if hasChange then
		ExploreSimpleModel.instance:checkTaskRed()
		ExploreController.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function ExploreController:_onSetTaskList()
	ExploreSimpleModel.instance:checkTaskRed()
	ExploreController.instance:dispatchEvent(ExploreEvent.TaskUpdate)
end

function ExploreController:_onDeleteTaskList(msg)
	local hasChange = false

	for _, id in ipairs(msg.taskIds) do
		local mo = TaskModel.instance:getTaskById(id)

		if mo and mo.type == TaskEnum.TaskType.Explore then
			hasChange = true

			break
		end
	end

	if hasChange then
		ExploreSimpleModel.instance:checkTaskRed()
		ExploreController.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function ExploreController:_onFinishTask(id)
	local mo = TaskModel.instance:getTaskById(id)

	if mo and mo.type == TaskEnum.TaskType.Explore then
		ExploreSimpleModel.instance:checkTaskRed()
		ExploreController.instance:dispatchEvent(ExploreEvent.TaskUpdate)
	end
end

function ExploreController:registerMapComp(type, comp)
	self._comps = self._comps or {}
	self._comps[type] = comp
end

function ExploreController:unRegisterMapComp(type)
	if not self._comps then
		return
	end

	self._comps[type] = nil
end

function ExploreController:getMapComp(type)
	if not self._comps then
		return
	end

	return self._comps[type]
end

function ExploreController:getMap()
	return self:getMapComp(ExploreEnum.MapCompType.Map)
end

function ExploreController:getMapLight()
	return self:getMapComp(ExploreEnum.MapCompType.Light)
end

function ExploreController:getMapWhirl()
	return self:getMapComp(ExploreEnum.MapCompType.Whirl)
end

function ExploreController:getMapPipe()
	return self:getMapComp(ExploreEnum.MapCompType.Pipe)
end

function ExploreController:enterExploreScene(mapId)
	if mapId then
		ExploreRpc.instance:sendChangeMapRequest(mapId)
	else
		ExploreModel.instance.isFirstEnterMap = ExploreEnum.EnterMode.Battle

		ExploreRpc.instance:sendGetExploreInfoRequest()
	end
end

function ExploreController:enterExploreMap(mapId)
	self:dispatchEvent(ExploreEvent.EnterExplore, mapId)

	ExploreModel.instance.mapId = mapId

	ExploreConfig.instance:loadExploreConfig(ExploreModel.instance.mapId)

	local sceneId = ExploreConfig.instance:getSceneId(mapId)

	GameSceneMgr.instance:startScene(SceneType.Explore, sceneId, SceneConfig.instance:getSceneLevelCOs(sceneId)[1].id, true, true)
end

function ExploreController:enterExploreFight(mapId, unitId, battleId)
	DungeonFightController.instance:enterFight(DungeonEnum.ExploreChapterId, ExploreModel.instance:getNowMapEpisodeId(), battleId)
end

function ExploreController:addItem(dataList)
	local data = dataList[1]
	local type, id, num = data.materilType, data.materilId, data.quantity

	if type == MaterialEnum.MaterialType.Explore then
		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
			id = id
		})
	else
		local co = {}
		local uid

		for _, v in ipairs(dataList) do
			local o = MaterialDataMO.New()

			if v.materilType == MaterialEnum.MaterialType.PowerPotion then
				local latestPowerCo = ItemPowerModel.instance:getLatestPowerChange()

				for _, power in pairs(latestPowerCo) do
					if tonumber(power.itemid) == tonumber(v.materilId) then
						uid = power.uid
					end
				end
			end

			o:initValue(v.materilType, v.materilId, v.quantity, uid)
			table.insert(co, o)
		end

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, co)
	end
end

function ExploreController:updateUnit(exploreInteractNO)
	local unitMO = ExploreMapModel.instance:getUnitMO(exploreInteractNO.id)
	local data = {
		exploreInteractNO.id,
		exploreInteractNO.type
	}

	data[ExploreUnitMoFieldEnum.nodePos] = {
		exploreInteractNO.posx,
		exploreInteractNO.posy
	}
	data[ExploreUnitMoFieldEnum.unitDir] = exploreInteractNO.dir

	if unitMO == nil then
		unitMO = ExploreMapModel.instance:createUnitMO(data)
	else
		unitMO:init(data)
	end

	ExploreController.instance:addUnit(unitMO)
end

function ExploreController:addUnit(unitMO)
	self:getMap():enterUnit(unitMO)
end

function ExploreController:removeUnit(id)
	self:getMap():removeUnit(id)
end

function ExploreController:exit()
	if not self:getMap() then
		return
	end

	DungeonModel.instance:setAdvPlayJumpType(DungeonEnum.AdvPlayType.Explore)

	DungeonModel.instance.curSendEpisodeId = ExploreConfig.instance:getEpisodeId(ExploreModel.instance:getMapId())

	MainController.instance:enterMainScene()
end

function ExploreController:_openGuideDialogue(paramStr)
	local paramArrs = string.splitToNumber(paramStr, "_")
	local guideId = paramArrs[1]
	local stepId = paramArrs[2]
	local stepCfg = GuideConfig.instance:getStepCO(guideId, stepId)
	local nextStepCfg = GuideConfig.instance:getStepCO(guideId, stepId + 1)
	local param = {}

	param.guideKey = paramStr
	param.tipsTalker = stepCfg.tipsTalker
	param.tipsContent = stepCfg.tipsContent

	if nextStepCfg and not string.nilorempty(nextStepCfg.tipsContent) and not string.nilorempty(nextStepCfg.tipsTalker) then
		param.noClose = true
	end

	param.closeCallBack = ExploreController._onCloseGuideDialogueViewByGuide

	ViewMgr.instance:openView(ViewName.ExploreGuideDialogueView, param)
end

function ExploreController._onCloseGuideDialogueViewByGuide(guideIdStepIdStr)
	ExploreController.instance:dispatchEvent(ExploreEvent.CloseGuideDialogueView, guideIdStepIdStr)
end

ExploreController.instance = ExploreController.New()

return ExploreController
