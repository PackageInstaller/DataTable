-- chunkname: @modules/logic/survival/util/SurvivalMapHelper.lua

module("modules.logic.survival.util.SurvivalMapHelper", package.seeall)

local SurvivalMapHelper = class("SurvivalMapHelper")

function SurvivalMapHelper:ctor()
	self.flow = nil
	self._allEntity = {}
	self._steps = nil
end

function SurvivalMapHelper:cacheSteps(steps)
	self._steps = self._steps or {}

	for _, step in ipairs(steps) do
		local stepMo = SurvivalMapStepMo.New()

		stepMo:init(step)

		if not SurvivalEnum.StepTypeToName[step.type] then
			local stepName = ""
			local cls = _G[string.format("Survival%sWork", stepName)]

			if cls then
				table.insert(self._steps, cls.New(stepMo))
			end
		end
	end
end

function SurvivalMapHelper:addPushToFlow(msgName, msg)
	self._steps = self._steps or {}

	local workCls = _G[string.format("%sWork", msgName)] or SurvivalMsgPushWork
	local work = workCls.New(msgName, msg)

	table.insert(self._steps, work)
end

function SurvivalMapHelper:tryStartFlow(recvProtoName)
	if not self._steps or #self._steps <= 0 then
		return
	end

	local isNewFlow = false

	if not self.flow then
		self.flow = FlowSequence.New()
		isNewFlow = true
	end

	if recvProtoName == "EnterSurvivalReply" then
		self.flow:addWork(SurvivalWaitSceneFinishWork.New())
	end

	local params = {}

	params.beforeFlow = FlowParallel.New()
	params.afterFlow = FlowSequence.New()
	params.moveIdSet = {}

	self.flow:addWork(params.beforeFlow)

	for index, v in ipairs(self._steps) do
		local stepMo = v._stepMo

		if stepMo then
			logNormal("step:" .. stepMo.type)

			local runOrder = v:getRunOrder(params, self.flow, index, self._steps)

			if runOrder == SurvivalEnum.StepRunOrder.Before then
				params.beforeFlow:addWork(v)
			elseif runOrder == SurvivalEnum.StepRunOrder.After then
				params.afterFlow:addWork(v)
			end

			if stepMo.type == SurvivalEnum.StepType.MapTickAfter then
				self.flow:addWork(params.afterFlow)

				params.beforeFlow = FlowParallel.New()
				params.afterFlow = FlowSequence.New()

				self.flow:addWork(params.beforeFlow)

				params.moveIdSet = {}
				params.haveHeroMove = false
			end
		else
			params.afterFlow:addWork(v)
		end
	end

	self.flow:addWork(params.afterFlow)

	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	if weekMo and weekMo.inSurvival then
		self.flow:addWork(SurvivalContinueMoveWork.New())
	end

	if isNewFlow then
		self.flow:registerDoneListener(self.flowDone, self)
		self.flow:start({
			beginDt = ServerTime.now()
		})
	end

	self._steps = nil
end

function SurvivalMapHelper:flowDone()
	local isExitMap = false

	if self.flow and self.flow.context.fastExecute then
		SurvivalController.instance:exitMap()

		isExitMap = true
	end

	self.flow = nil
	self.serverFlow = nil
	self._steps = nil

	if not isExitMap then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.onFlowEnd)
	end
end

function SurvivalMapHelper:isInFlow()
	return (self.flow == nil or nil) and self._steps and #self._steps > 0
end

function SurvivalMapHelper:fastDoFlow()
	if not self.flow then
		self._steps = nil

		return
	end

	if not self:tryRemoveFlow() then
		self.flow.context.fastExecute = true
	end
end

function SurvivalMapHelper:tryRemoveFlow()
	if not self.flow then
		return
	end

	if ServerTime.now() - self.flow.context.beginDt > 5 then
		local curWorks = self:getCurRunningWorks(self.flow)
		local workNames = {}

		for i, v in ipairs(curWorks) do
			table.insert(workNames, v.__cname)
		end

		local pauseKeys = {}

		if PopupController.instance:isPause() then
			for k in pairs(PopupController.instance._pauseDict) do
				table.insert(pauseKeys, tostring(k))
			end
		end

		logError("可能卡主了，清掉数据吧!runningwork:" .. table.concat(workNames, ",") .. " pauseKey:" .. table.concat(pauseKeys, ","))

		self._steps = nil

		self.flow:onDestroyInternal()

		self.flow = nil

		return true
	end
end

function SurvivalMapHelper:getCurRunningWorks(flow)
	local works = {}
	local workList = flow:getWorkList()

	if not workList or flow.status ~= WorkStatus.Running then
		return works
	end

	for i, work in ipairs(workList) do
		if work.status == WorkStatus.Running then
			if isTypeOf(work, BaseFlow) then
				tabletool.addValues(works, self:getCurRunningWorks(work))
			else
				table.insert(works, work)
			end
		end
	end

	return works
end

function SurvivalMapHelper:tryShowEventView(pos)
	SurvivalMapModel.instance:setMoveToTarget(nil)

	local sceneMo = SurvivalMapModel.instance:getSceneMo()

	pos = pos or sceneMo.player.pos

	local allUnitMo = sceneMo:getUnitByPos(pos, true)

	if allUnitMo[1] then
		for _, v in ipairs(allUnitMo) do
			if v.unitType == SurvivalEnum.UnitType.Treasure then
				SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", v.id)
				SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.TriggerEvent, tostring(v.id))

				return
			end
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			pos = pos,
			allUnitMo = allUnitMo
		})
		SurvivalStatHelper.instance:statSurvivalMapUnit("TriggerEvent", allUnitMo[1].id)
	end
end

function SurvivalMapHelper:tryShowServerPanel(panel, source)
	local isMessagePanel = source and source == 1999

	if not panel or panel.type == SurvivalEnum.PanelType.None and not isMessagePanel then
		return
	end

	SurvivalMapModel.instance:setMoveToTarget(nil)

	local type = panel.type

	if type == SurvivalEnum.PanelType.Search then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapSearchView
		})

		local itemConvertInfosList = SurvivalMapModel.instance.itemConvertInfosList

		ViewMgr.instance:openView(ViewName.SurvivalMapSearchView, {
			itemMos = panel:getSearchItems(),
			isFirst = panel.isFirstSearch,
			itemConvertInfosList = itemConvertInfosList
		})
	elseif type == SurvivalEnum.PanelType.TreeEvent then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()
		local unitMo = sceneMo and sceneMo.unitsById[panel.unitId]

		if not unitMo then
			SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(panel.uid)
			logError(string.format("没有面板对应的事件ID，强制关闭掉,treeId:%s,unitId:%s,dialogueId:%s", panel.treeId, panel.unitId, panel.dialogueId))

			return
		end

		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalMapEventView
		})
		ViewMgr.instance:openView(ViewName.SurvivalMapEventView, {
			panel = panel
		})
	elseif type == SurvivalEnum.PanelType.DropSelect then
		local delayShowPanel = self:isInShelterScene()

		if delayShowPanel then
			if ViewMgr.instance:isOpen(ViewName.SurvivalDropSelectView) then
				delayShowPanel = false

				logError("已有掉落界面弹出了！")
			end

			if PopupController.instance:havePopupView(ViewName.SurvivalDropSelectView) then
				delayShowPanel = false

				logError("已有掉落界面弹出了！！")
			end
		end

		if self:isInShelterScene() then
			if delayShowPanel then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalDropSelectView, {
					panel = panel
				})
			end
		else
			ViewMgr.instance:closeAllPopupViews({
				ViewName.SurvivalDropSelectView
			})
			ViewMgr.instance:openView(ViewName.SurvivalDropSelectView, {
				panel = panel
			})
		end
	elseif type == SurvivalEnum.PanelType.Store then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalShopView
		})
		ViewMgr.instance:openView(ViewName.SurvivalShopView)
	elseif type == SurvivalEnum.PanelType.Decrees then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalDecreeSelectView
		})
		ViewMgr.instance:openView(ViewName.SurvivalDecreeSelectView, {
			panel = panel
		})
	elseif type == SurvivalEnum.PanelType.None and isMessagePanel then
		ViewMgr.instance:closeAllPopupViews({
			ViewName.SurvivalLeaveMsgView
		})

		local survivalLeaveMsgViewParam = SurvivalMapModel.instance.survivalLeaveMsgViewParam

		ViewMgr.instance:openView(ViewName.SurvivalLeaveMsgView, survivalLeaveMsgViewParam)
	end
end

function SurvivalMapHelper:getBlockRes(path)
	local scene = self:getScene()

	if not scene then
		return
	end

	return scene.preloader:getRes(path)
end

function SurvivalMapHelper:getSpBlockRes(group, prefabName)
	local scene = self:getScene()

	if not scene then
		return
	end

	return scene.preloader:getBlockRes(group, prefabName)
end

function SurvivalMapHelper:getScene()
	local curScene = GameSceneMgr.instance:getCurScene()

	if not curScene or curScene.__cname ~= "SurvivalScene" and curScene.__cname ~= "SurvivalShelterScene" and curScene.__cname ~= "SurvivalSummaryAct" and curScene.__cname ~= "SurvivalCollectionRoomScene" then
		return
	end

	return curScene
end

function SurvivalMapHelper:getSceneCameraComp()
	local scene = self:getScene()

	return scene and scene.camera
end

function SurvivalMapHelper:getSceneFogComp()
	local scene = self:getScene()

	return scene and scene.fog
end

function SurvivalMapHelper:getSurvivalBubbleComp()
	local scene = self:getScene()

	return scene and scene.bubble
end

function SurvivalMapHelper:updateCloudShow(...)
	local scene = self:getScene()
	local cloud = scene and scene.cloud

	if cloud then
		cloud:updateCloudShow(...)
	end
end

function SurvivalMapHelper:setDistance(distance)
	local camera = self:getSceneCameraComp()

	if camera then
		camera:setDistance(distance)
	end
end

function SurvivalMapHelper:setFocusPos(x, y, z)
	local camera = self:getSceneCameraComp()

	if camera then
		camera:setFocus(x, y, z)
	end
end

function SurvivalMapHelper:setCameraYaw(yaw)
	local camera = self:getSceneCameraComp()

	if camera then
		camera:setRotate(yaw)
	end
end

function SurvivalMapHelper:setRotate(yawAngle, pitchAngle)
	local camera = self:getSceneCameraComp()

	if camera then
		camera:setRotate(yawAngle, pitchAngle)
	end
end

function SurvivalMapHelper:applyDirectly()
	local camera = self:getSceneCameraComp()

	if camera then
		camera:applyDirectly()
	end
end

function SurvivalMapHelper:addEntity(id, entity)
	self._allEntity[id] = entity
end

function SurvivalMapHelper:removeEntity(id)
	self._allEntity[id] = nil
end

function SurvivalMapHelper:getEntity(id)
	return self._allEntity[id]
end

function SurvivalMapHelper:getShopById(shopId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local shopMo

	if weekInfo.inSurvival then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if not sceneMo then
			return
		end

		if sceneMo.panel and sceneMo.panel.type == SurvivalEnum.PanelType.Store then
			shopMo = sceneMo.panel.shop
		end
	else
		local shopType = SurvivalConfig.instance:getShopType(shopId)

		shopMo = shopType == SurvivalEnum.ShopType.PreExplore and weekInfo.preExploreShop or weekInfo:getBuildShop(shopId)
	end

	return shopMo
end

function SurvivalMapHelper:getShopPanel()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	if weekInfo.inSurvival then
		local sceneMo = SurvivalMapModel.instance:getSceneMo()

		if not sceneMo then
			return
		end

		if sceneMo.panel and sceneMo.panel.type == SurvivalEnum.PanelType.Store then
			return sceneMo.panel.shop, sceneMo.panel.uid
		end
	else
		local buildingInfo = weekInfo:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Shop)

		return buildingInfo and buildingInfo.shop
	end
end

function SurvivalMapHelper:getBagMo()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	if weekInfo.inSurvival then
		return weekInfo:getBag(SurvivalEnum.ItemSource.Map)
	else
		return weekInfo:getBag(SurvivalEnum.ItemSource.Shelter)
	end
end

function SurvivalMapHelper:isInSurvivalScene()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return self:isSurvivalScene(curSceneType)
end

function SurvivalMapHelper:isSurvivalScene(scene)
	return scene == SceneType.Survival or scene == SceneType.SurvivalShelter or scene == SceneType.SurvivalSummaryAct or scene == SceneType.SurvivalCollectionRoom
end

function SurvivalMapHelper:isInMapScene()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return curSceneType == SceneType.Survival
end

function SurvivalMapHelper:isInShelterScene()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return curSceneType == SceneType.SurvivalShelter
end

function SurvivalMapHelper:isInCollectionRoom()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return curSceneType == SceneType.SurvivalCollectionRoom
end

function SurvivalMapHelper:isUseShelterAmbient()
	local curSceneType = GameSceneMgr.instance:getCurSceneType()

	return curSceneType == SceneType.SurvivalShelter or curSceneType == SceneType.SurvivalSummaryAct or curSceneType == SceneType.SurvivalCollectionRoom
end

function SurvivalMapHelper:clearSteps()
	self._steps = nil
end

function SurvivalMapHelper:clear()
	if self.flow then
		self.flow:onDestroyInternal()

		self.flow = nil
	end

	ViewMgr.instance:closeAllPopupViews()

	self._steps = nil
	self.serverFlow = nil
	self._allEntity = {}

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if weekInfo then
		weekInfo.oldRoleAttrDic = nil
	end
end

function SurvivalMapHelper:gotoBuilding(buildingId, hexPoint, followerPlayer)
	local scene = self:getScene()

	if not scene then
		return
	end

	local building = scene.unit:getBuildEntity(buildingId)

	if not building then
		return
	end

	local pointList = building.buildingCo.pointRangeList
	local player = scene.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	player:moveToByPosList(pointList, self.interactiveBuilding, self, buildingId, followerPlayer)
end

function SurvivalMapHelper:interactiveBuilding(buildingId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfo(buildingId)

	if not buildingInfo then
		local mapCo = SurvivalConfig.instance:getShelterMapCo()
		local buildingCo = mapCo:getBuildingById(buildingId)

		if buildingCo:isCollection() then
			ViewMgr.instance:openView(ViewName.SurvivalInfoView, {
				cfg = buildingCo.cfg
			})
		end

		return
	end

	local isShowInfo = buildingInfo.baseCo.unName ~= 1

	if not isShowInfo then
		return
	end

	ViewMgr.instance:closeAllPopupViews()

	if not buildingInfo:isBuild() then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = buildingId
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Decree) then
		ViewMgr.instance:openView(ViewName.SurvivalDecreeView)

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Task) then
		ViewMgr.instance:openView(ViewName.ShelterTaskView)

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Explore) then
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local fight = weekInfo:getMonsterFight()
		local needKillBoss = fight:needKillBoss()

		if needKillBoss then
			local survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()

			if not survivalBubbleComp:isPlayerBubbleShow() then
				local param = SurvivalBubbleParam.New()

				param.content = luaLang("SurvivalBubble_1")
				param.duration = -1
				self.bubbleId = survivalBubbleComp:showPlayerBubble(param)
			end
		else
			SurvivalController.instance:enterSurvival()
		end

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Health) then
		ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
			buildingId = buildingId
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Tent) then
		ViewMgr.instance:openView(ViewName.ShelterTentManagerView, {
			buildingId = buildingId
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Equipment) then
		ViewMgr.instance:openView(ViewName.ShelterCompositeView)

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Npc) then
		ViewMgr.instance:openView(ViewName.ShelterRecruitView)

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Warehouse) then
		ViewMgr.instance:openView(ViewName.ShelterMapBagView)

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Shop) then
		local shopMo = buildingInfo:getShop()

		ViewMgr.instance:openView(ViewName.SurvivalShopView, {
			shopMo = shopMo
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		ViewMgr.instance:openView(ViewName.SurvivalReputationShopView, {
			buildingId = buildingId
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.Tech) then
		ViewMgr.instance:openView(ViewName.SurvivalTechShelterView, {
			buildingId = buildingId
		})

		return
	end

	if buildingInfo:isEqualType(SurvivalEnum.BuildingType.CollectionRoom) then
		if SurvivalMapHelper.instance:isInCollectionRoom() then
			return
		end

		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.SurvivalLoadingView)
		GameSceneMgr.instance:startScene(SceneType.SurvivalCollectionRoom, 280001, 280001, true, true)

		return
	end

	ViewMgr.instance:openView(ViewName.ShelterRestManagerView, {
		buildingId = buildingId
	})
end

function SurvivalMapHelper:gotoUnit(unitType, unitId, hexPoint)
	if unitType == SurvivalEnum.ShelterUnitType.Npc then
		self:gotoNpc(unitId, hexPoint)

		return
	end

	if unitType == SurvivalEnum.ShelterUnitType.Build then
		self:gotoBuilding(unitId, hexPoint)

		return
	end

	if unitType == SurvivalEnum.ShelterUnitType.Monster then
		self:gotoMonster(unitId, hexPoint)

		return
	end
end

function SurvivalMapHelper:gotoNpc(npcId, hexPoint)
	local scene = self:getScene()

	if not scene then
		return
	end

	local npc = scene.unit:getNpcEntity(npcId)

	if not npc then
		return
	end

	local pos = npc.pos
	local player = scene.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	player:moveToByPos(hexPoint or pos, self.interactiveNpc, self, npcId)
end

function SurvivalMapHelper:interactiveNpc(npcId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcInfo = weekInfo:getNpcInfo(npcId)
	local behaviorConfig = self:getShelterNpcPriorityBehavior(npcId)

	if behaviorConfig then
		local itemMo = SurvivalBagItemMo.New()

		itemMo:init({
			count = 1,
			id = npcInfo.id
		})
		ViewMgr.instance:closeAllPopupViews()

		local param = {
			status = npcInfo:getShelterNpcStatus()
		}

		ViewMgr.instance:openView(ViewName.ShelterMapEventView, {
			conditionParam = param,
			title = npcInfo.co.name,
			behaviorConfig = behaviorConfig,
			unitResPath = npcInfo.co.resource,
			itemMo = itemMo
		})
	end
end

function SurvivalMapHelper:getShelterNpcPriorityBehavior(npcId)
	local triggerList = self:getShelterNpcBehaviorList(npcId)

	if #triggerList == 0 then
		return nil
	end

	local maxPriority = triggerList[1].priority
	local candidates = {}

	for _, behavior in ipairs(triggerList) do
		if maxPriority < behavior.priority then
			maxPriority = behavior.priority
			candidates = {
				behavior
			}
		elseif behavior.priority == maxPriority then
			table.insert(candidates, behavior)
		end
	end

	if #candidates == 1 then
		return candidates[1]
	else
		return candidates[math.random(1, #candidates)]
	end
end

function SurvivalMapHelper:getShelterNpcBehaviorList(npcId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local npcInfo = weekInfo:getNpcInfo(npcId)
	local list = string.splitToNumber(npcInfo.co.surBehavior, "#")
	local triggerList = {}
	local param = {
		status = npcInfo:getShelterNpcStatus()
	}

	for _, v in ipairs(list) do
		local behaviorConfig = lua_survival_behavior.configDict[v]

		if behaviorConfig and self:isBehaviorMeetCondition(behaviorConfig.condition, param) then
			table.insert(triggerList, behaviorConfig)
		end
	end

	if #triggerList > 1 then
		table.sort(triggerList, SortUtil.keyUpper("priority"))
	end

	return triggerList
end

function SurvivalMapHelper:gotoMonster(monsterBattleId, hexPoint, followerPlayer)
	local scene = self:getScene()

	if not scene then
		return
	end

	local monster = scene.unit:getMonsterEntity(monsterBattleId)

	if not monster then
		return
	end

	local pos = monster.pos
	local player = scene.unit:getPlayer()

	ViewMgr.instance:closeAllModalViews()
	ViewMgr.instance:closeAllPopupViews()
	player:moveToByPos(hexPoint or pos, self.interactiveMonster, self, monsterBattleId, followerPlayer)
end

function SurvivalMapHelper:interactiveMonster(fightId)
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local fight = weekInfo:getMonsterFight()

	if fight and fight.fightId == fightId and fight:canShowEntity() then
		ViewMgr.instance:closeAllPopupViews()
		ViewMgr.instance:openView(ViewName.SurvivalMonsterEventView, {
			showType = SurvivalEnum.SurvivalMonsterEventViewShowType.Normal
		})
	end
end

function SurvivalMapHelper:isBehaviorMeetCondition(condition, param)
	local condiList = GameUtil.splitString2(condition, false)

	for _, v in ipairs(condiList) do
		if not self:checkSingleCondition(v, param) then
			return false
		end
	end

	return true
end

function SurvivalMapHelper:checkSingleCondition(condition, param)
	if not condition then
		return true
	end

	if condition[1] == "NpcStatus" then
		return tonumber(condition[2]) == param.status
	elseif condition[1] == "unFinishTask" then
		local taskType = tonumber(condition[2])
		local taskId = tonumber(condition[3])
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local taskBox = weekInfo.taskPanel:getTaskBoxMo(taskType)
		local taskMo = taskBox and taskBox:getTaskInfo(taskId)

		return taskMo and taskMo:isUnFinish()
	elseif condition[1] == "unAcceptTask" then
		local taskType = tonumber(condition[2])
		local taskId = tonumber(condition[3])
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local taskBox = weekInfo.taskPanel:getTaskBoxMo(taskType)
		local taskMo = taskBox and taskBox:getTaskInfo(taskId)

		return taskMo == nil
	elseif condition[1] == "finishTask" then
		local taskType = tonumber(condition[2])
		local taskId = tonumber(condition[3])
		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local taskBox = weekInfo.taskPanel:getTaskBoxMo(taskType)
		local taskMo = taskBox and taskBox:getTaskInfo(taskId)

		return taskMo and not taskMo:isUnFinish() or false
	end

	return true
end

function SurvivalMapHelper:getLocalShelterEntityPosAndDir(unitType, unitId)
	local mapId = SurvivalConfig.instance:getCurShelterMapId()
	local pos, dir = SurvivalConfig.instance:getLocalShelterEntityPosAndDir(mapId, unitType, unitId)

	if not pos or not self:isPosValid(pos, true) then
		pos, dir = self:getRandomWalkPosAndDir()

		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local fight = weekInfo:getMonsterFight()
		local toward = fight.fightCo.toward

		if not string.nilorempty(toward) then
			local info = string.splitToNumber(toward, true)

			dir = SurvivalHelper.instance:getDirMustHave(pos, SurvivalHexNode.New(info[1], info[2]))
		end

		SurvivalConfig.instance:saveLocalShelterEntityPosAndDir(mapId, unitType, unitId, pos, dir)
	end

	return pos, dir
end

function SurvivalMapHelper:getRandomWalkPosAndDir()
	local scene = self:getScene()

	if not scene then
		return
	end

	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local walkables = mapCo.walkables
	local unwalkables = {}

	if scene then
		scene.unit:addUsedPos(unwalkables)
	end

	local availablePositions = {}

	for q, v in pairs(walkables) do
		for r, node in pairs(v) do
			if not SurvivalHelper.instance:getValueFromDict(unwalkables, node) then
				table.insert(availablePositions, node)
			end
		end
	end

	if #availablePositions == 0 then
		return nil
	end

	local randomDir = math.random(0, 5)
	local randomIndex = math.random(1, #availablePositions)
	local randomPos = availablePositions[randomIndex]

	return randomPos, randomDir
end

function SurvivalMapHelper:isPosValid(node, isJumpPlayer)
	local scene = self:getScene()
	local unwalkables = {}

	scene.unit:addUsedPos(unwalkables, isJumpPlayer)

	if SurvivalHelper.instance:getValueFromDict(unwalkables, node) then
		return false
	else
		local mapCo = SurvivalConfig.instance:getShelterMapCo()
		local walkables = mapCo.walkables

		for q, v in pairs(walkables) do
			for r, n in pairs(v) do
				if node == n then
					return true
				end
			end
		end
	end

	return false
end

function SurvivalMapHelper:getShelterEntity(unitType, unitId)
	local scene = self:getScene()

	if not scene then
		return
	end

	return scene.unit:getEntity(unitType, unitId)
end

function SurvivalMapHelper:addShelterEntity(unitType, unitId, entity)
	local scene = self:getScene()

	if not scene then
		return
	end

	return scene.unit:addEntity(unitType, unitId, entity)
end

function SurvivalMapHelper:getAllShelterEntity()
	local scene = self:getScene()

	if not scene then
		return
	end

	return scene.unit:getAllEntity()
end

function SurvivalMapHelper:hideUnitVisible(unitType, visible)
	local allEntity = self:getAllShelterEntity()

	for _unityType, entityDict in pairs(allEntity) do
		if _unityType == unitType and entityDict then
			for _, entity in pairs(entityDict) do
				entity:setVisible(visible)
			end
		end
	end
end

function SurvivalMapHelper:refreshPlayerEntity()
	local scene = self:getScene()

	if not scene then
		return
	end

	scene.unit:refreshEntity(SurvivalEnum.ShelterUnitType.Player, 0, true)
end

function SurvivalMapHelper:stopShelterPlayerMove()
	local scene = self:getScene()

	if not scene then
		return
	end

	local player = scene.unit:getPlayer()

	if player then
		player:stopMove()
	end
end

local tempV3 = Vector3()

function SurvivalMapHelper:tweenToHeroPosIfNeed(time)
	time = time or 0

	local sceneMo = SurvivalMapModel.instance:getSceneMo()
	local playerPos = sceneMo.player.pos
	local screenWidth = UnityEngine.Screen.width
	local screenHeight = UnityEngine.Screen.height

	tempV3:Set(screenWidth / 2, screenHeight / 2, 0)

	local screenCenterPosV3 = tempV3
	local screenCenterPos = SurvivalHelper.instance:getScene3DPos(screenCenterPosV3)
	local screenCenterNode = SurvivalHexNode.New(SurvivalHelper.instance:worldPointToHex(screenCenterPos.x, screenCenterPos.y, screenCenterPos.z))

	if SurvivalHelper.instance:getDistance(playerPos, screenCenterNode) > 2 then
		local playerPosV3 = Vector3.New(SurvivalHelper.instance:hexPointToWorldPoint(playerPos.q, playerPos.r))

		SurvivalController.instance:dispatchEvent(SurvivalEvent.TweenCameraFocus, playerPosV3, time)

		return true
	end
end

local playDt

function SurvivalMapHelper:addPointEffect(hexNode, effectName, scale)
	effectName = effectName or SurvivalPointEffectComp.ResPaths.explode

	if (playDt == nil or playDt + 0.5 < UnityEngine.Time.realtimeSinceStartup) and effectName == SurvivalPointEffectComp.ResPaths.explode then
		AudioMgr.instance:trigger(AudioEnum3_1.Survival.ExplodeEffect)

		playDt = UnityEngine.Time.realtimeSinceStartup
	end

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(hexNode.q, hexNode.r)

	tempV3:Set(x, y, z)
	self:getScene().pointEffect:addAutoDisposeEffect(effectName, tempV3, 2, scale)
end

function SurvivalMapHelper:checkRoleLevelUpCache(isJumpCheck)
	local isOpen

	if SurvivalMapHelper.instance:isInShelterScene() then
		local isInTopView = ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMainView, {
			ViewName.SurvivalToastView,
			ViewName.SurvivalCommonTipsView,
			ViewName.GuideView,
			ViewName.GuideView2,
			ViewName.GuideStepEditor
		})

		if isJumpCheck or isInTopView and not self:isInFlow() then
			local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

			if survivalShelterRoleMo.uiShowLevel then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalRoleLevelUpView, {
					oldLevel = survivalShelterRoleMo.uiShowLevel - 1,
					curLevel = survivalShelterRoleMo.uiShowLevel
				})
				survivalShelterRoleMo:clearLevelUpCache()

				isOpen = true
			end
		end
	elseif SurvivalMapHelper.instance:isInMapScene() then
		local isInTopView = ViewHelper.instance:checkViewOnTheTop(ViewName.SurvivalMapMainView, {
			ViewName.SurvivalToastView,
			ViewName.SurvivalCommonTipsView,
			ViewName.GuideView,
			ViewName.GuideView2,
			ViewName.GuideStepEditor
		})

		if isJumpCheck or isInTopView and not self:isInFlow() then
			local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo

			if survivalShelterRoleMo.uiShowLevel then
				PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.SurvivalRoleLevelUpView, {
					oldLevel = survivalShelterRoleMo.uiShowLevel - 1,
					curLevel = survivalShelterRoleMo.uiShowLevel
				})
				survivalShelterRoleMo:clearLevelUpCache()

				isOpen = true
			end

			if survivalShelterRoleMo.isExpCache then
				SurvivalController.instance:dispatchEvent(SurvivalEvent.OnPlayGainExpAnim)
				survivalShelterRoleMo:clearExpCache()
			end
		end
	end

	return isOpen
end

function SurvivalMapHelper:isPetrifactionTar(survivalUnitMo)
	if survivalUnitMo.isBattle then
		return survivalUnitMo:isBattle()
	end
end

SurvivalMapHelper.instance = SurvivalMapHelper.New()

return SurvivalMapHelper
