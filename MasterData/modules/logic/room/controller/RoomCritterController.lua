-- chunkname: @modules/logic/room/controller/RoomCritterController.lua

module("modules.logic.room.controller.RoomCritterController", package.seeall)

local RoomCritterController = class("RoomCritterController", BaseController)

function RoomCritterController:onInit()
	self:clear()
end

function RoomCritterController:reInit()
	self:clear()
end

function RoomCritterController:clear()
	if self._isInitAddEvent then
		self._isInitAddEvent = false

		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainStarted, self._onTrainEventStarted, self)
		CritterController.instance:unregisterCallback(CritterEvent.CritterTrainFinished, self._onTrainEventFinished, self)
		CritterController.instance:unregisterCallback(CritterEvent.TrainFinishTrainCritterReply, self._startCheckTrainTask, self)
		CritterController.instance:unregisterCallback(CritterEvent.TrainCancelTrainReply, self._startCheckTrainTask, self)
		CritterController.instance:unregisterCallback(CritterEvent.TrainStartTrainCritterReply, self._startCheckTrainTask, self)
	end

	self._isHasCheckeTrainTask = false
	self._isPlayTrainEventStory = false

	TaskDispatcher.cancelTask(self._onRunCheckTrainTask, self)
end

function RoomCritterController:addConstEvents()
	return
end

function RoomCritterController:init()
	if not self._isInitAddEvent then
		self._isInitAddEvent = true

		CritterController.instance:registerCallback(CritterEvent.CritterTrainStarted, self._onTrainEventStarted, self)
		CritterController.instance:registerCallback(CritterEvent.CritterTrainFinished, self._onTrainEventFinished, self)
		CritterController.instance:registerCallback(CritterEvent.TrainFinishTrainCritterReply, self._startCheckTrainTask, self)
		CritterController.instance:registerCallback(CritterEvent.TrainCancelTrainReply, self._startCheckTrainTask, self)
		CritterController.instance:registerCallback(CritterEvent.TrainStartTrainCritterReply, self._startCheckTrainTask, self)
	end

	self._isPlayTrainEventStory = false
end

function RoomCritterController:_onTrainEventStarted()
	local scene = RoomCameraController.instance:getRoomScene()

	if scene and ViewMgr.instance:isOpen(ViewName.RoomCritterTrainStoryView) then
		gohelper.setActive(scene.go.characterRoot, false)
		gohelper.setActive(scene.go.critterRoot, false)

		self._isPlayTrainEventStory = true
	end
end

function RoomCritterController:_onTrainEventFinished()
	local scene = RoomCameraController.instance:getRoomScene()

	if scene then
		gohelper.setActive(scene.go.characterRoot, true)
		gohelper.setActive(scene.go.critterRoot, true)
	end

	self._isPlayTrainEventStory = false

	RoomCharacterController.instance:dispatchEvent(RoomEvent.PauseCharacterMove)
end

function RoomCritterController:getPlayingInteractionParam()
	return self._interactionParam
end

function RoomCritterController:setInteractionParam(heroId)
	self._interactionParam = heroId and heroId ~= 0 and {
		heroId = heroId
	} or nil
end

function RoomCritterController:isPlayTrainEventStory()
	return self._isPlayTrainEventStory
end

function RoomCritterController:initMapTrainCritter()
	local critterMOList = CritterModel.instance:getCultivatingCritters()
	local pposCfgList = RoomConfig.instance:getBlockPlacePositionCfgList()
	local posList = {}
	local pre = 0.001

	for _, cfg in ipairs(pposCfgList) do
		table.insert(posList, Vector3(cfg.x * pre, cfg.y * pre, cfg.z * pre))
	end

	RoomHelper.randomArray(posList)

	local count = #posList

	for i, critterMO in ipairs(critterMOList) do
		local index = (i - 1) % count + 1
		local currentPosition = posList[index]

		self:_addMapTrainCritter(critterMO, currentPosition)
	end
end

function RoomCritterController:_startCheckTrainTask()
	if not self._isHasCheckeTrainTask then
		self._isHasCheckeTrainTask = true

		TaskDispatcher.runDelay(self._onRunCheckTrainTask, self, 0.1)
	end
end

function RoomCritterController:_onRunCheckTrainTask()
	self._isHasCheckeTrainTask = false

	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return
	end

	self:initMapTrainCritter()

	local critterMOList = CritterModel.instance:getCultivatingCritters()
	local critterUidDict = {}
	local heroIdDict = {}
	local spCharacterMOList

	for i, critterMO in ipairs(critterMOList) do
		local heroId = critterMO.trainInfo.heroId
		local critterUid = critterMO.uid

		critterUidDict[critterUid] = true
		heroIdDict[heroId] = true

		local characterEnitty = scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

		if characterEnitty == nil then
			local roomCharacterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

			if roomCharacterMO then
				characterEnitty = scene.charactermgr:spawnRoomCharacter(roomCharacterMO)
				spCharacterMOList = spCharacterMOList or {}

				table.insert(spCharacterMOList, roomCharacterMO)
			end
		end

		local critterEntity = scene.crittermgr:getCritterEntity(critterUid, SceneTag.RoomCharacter)

		if critterEntity == nil then
			local roomCritterMO = RoomCritterModel.instance:getCritterMOById(critterUid)

			if roomCritterMO then
				critterEntity = scene.crittermgr:spawnRoomCritter(roomCritterMO)
			end
		end

		if critterEntity then
			critterEntity.critterfollower:delaySetFollow()
		end
	end

	local roomCritterMOList = {}

	tabletool.addValues(roomCritterMOList, RoomCritterModel.instance:getTrainCritterMOList())

	for i, roomCritterMO in ipairs(roomCritterMOList) do
		if not critterUidDict[roomCritterMO.uid] then
			local critterEntity = scene.crittermgr:getCritterEntity(roomCritterMO.uid, SceneTag.RoomCharacter)

			if critterEntity then
				scene.crittermgr:destroyCritter(critterEntity)
			end

			RoomCritterModel.instance:removeTrainCritterMO(roomCritterMO)
		end
	end

	local characterMOList = {}

	tabletool.addValues(characterMOList, RoomCharacterModel.instance:getList())

	for i, characterMO in ipairs(characterMOList) do
		local heroId = characterMO.id

		if characterMO:isTrainSourceState() and not heroIdDict[heroId] then
			local characterEnitty = scene.charactermgr:getCharacterEntity(heroId, SceneTag.RoomCharacter)

			if characterEnitty then
				scene.charactermgr:destroyCharacter(characterEnitty)
			end

			RoomCharacterModel.instance:deleteCharacterMO(heroId)
		end
	end

	if spCharacterMOList and #spCharacterMOList > 0 then
		RoomCharacterController.instance:tryRandomByCharacterList(spCharacterMOList)
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.SceneTrainChangeSpine)
end

function RoomCritterController:_addMapTrainCritter(critterMO, position)
	local heroId = critterMO.trainInfo.heroId
	local critterUid = critterMO.uid
	local roomCritterMO = RoomCritterModel.instance:getCritterMOById(critterUid)

	if roomCritterMO == nil then
		roomCritterMO = RoomCritterMO.New()

		local info = {
			uid = critterUid,
			critterId = critterMO.defineId,
			skinId = critterMO:getSkinId(),
			currentPosition = position
		}

		roomCritterMO:init(info)
		RoomCritterModel.instance:addAtLast(roomCritterMO)
	end

	roomCritterMO.characterId = heroId
	roomCritterMO.heroId = heroId

	local characterMO = RoomCharacterModel.instance:getCharacterMOById(heroId)

	if characterMO == nil then
		local skinId = 0
		local heroMO = HeroModel.instance:getByHeroId(heroId)

		if heroMO then
			skinId = heroMO.skin
		else
			local heroCo = HeroConfig.instance:getHeroCO(heroId)

			if heroCo then
				skinId = heroCo.skinId
			end
		end

		characterMO = RoomCharacterMO.New()

		local info = RoomInfoHelper.generateTrainCharacterInfo(heroId, position, skinId)

		characterMO:init(info)
		RoomCharacterModel.instance:addAtLast(characterMO)
	end

	characterMO.trainCritterUid = critterUid
end

function RoomCritterController:showTrainSceneHero(trainHeroMO, buildingUid, slitId)
	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return
	end

	if not trainHeroMO then
		scene.charactermgr:spawnTempCharacterByMO(nil)

		return
	end

	local buildingEntity = scene.buildingmgr:getBuildingEntity(buildingUid)
	local px = 0
	local py = 0
	local pz = 0

	if buildingEntity then
		local goPos1 = buildingEntity:getCritterPoint(slitId)

		if goPos1 then
			px, py, pz = transformhelper.getPos(goPos1.transform)
		end
	end

	local roomCharacterMO = RoomCharacterModel.instance:getTrainTempMO()

	if roomCharacterMO and roomCharacterMO.heroId ~= trainHeroMO.heroId then
		local info = RoomInfoHelper.generateTempCharacterInfo(trainHeroMO.heroId, Vector3(px, py, pz), trainHeroMO.skinId)

		roomCharacterMO:init(info)

		roomCharacterMO.id = "train_" .. trainHeroMO.heroId
	end

	local characterEntity = scene.charactermgr:spawnTempCharacterByMO(roomCharacterMO)

	characterEntity:setLocalPos(px, py, pz)
end

function RoomCritterController:showTrainSceneCritter(critterMO, buildingUid, slitId)
	local scene = RoomCameraController.instance:getRoomScene()

	if not scene then
		return
	end

	if not critterMO then
		scene.crittermgr:spawnTempCritterByMO(nil)

		return
	end

	local roomCritterMO = RoomCritterModel.instance:getTempCritterMO()
	local skinId = critterMO:getSkinId()

	if roomCritterMO.skinId ~= skinId then
		local init = {
			uid = "train_" .. skinId,
			critterId = critterMO:getDefineId(),
			skinId = skinId
		}

		roomCritterMO:init(init)
	end

	local critterEntity = scene.crittermgr:spawnTempCritterByMO(roomCritterMO)
	local buildingEntity = scene.buildingmgr:getBuildingEntity(buildingUid)

	if buildingEntity then
		local goPos1 = buildingEntity:getCritterPoint(slitId)

		if goPos1 then
			local x, y, z = transformhelper.getPos(goPos1.transform)

			critterEntity:setLocalPos(x, y, z)
		end
	end
end

function RoomCritterController:openTrainAccelerateView(critterUid)
	ViewMgr.instance:openView(ViewName.RoomTrainAccelerateView, {
		critterUid = critterUid
	})
end

function RoomCritterController:openTrainReporView(critterUid, heroId, finishCount)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainReportView, {
		critterUid = critterUid,
		heroId = heroId,
		tranNum = finishCount,
		finishCount = finishCount
	})
end

function RoomCritterController:openTrainEventView(critterUid)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainEventView, {
		critterUid = critterUid
	})
end

function RoomCritterController:openRenameView(critterUid)
	local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)

	if critterMO then
		ViewMgr.instance:openView(ViewName.RoomCritterRenameView, {
			critterMO = critterMO
		})
	end
end

function RoomCritterController:openExchangeView(data)
	ViewMgr.instance:openView(ViewName.RoomCritterExchangeView, data)
end

function RoomCritterController:sendCritterRename(critterUid, critterName)
	CritterRpc.instance:sendCritterRenameRequest(critterUid, critterName, self._onCritterRenameReply, self)
end

function RoomCritterController:_onCritterRenameReply(cmd, resultCode, msg)
	if resultCode == 0 then
		GameFacade.showToast(ToastEnum.RoomCritterRenameSuccess)
		ViewMgr.instance:closeView(ViewName.RoomCritterRenameView)
	end
end

function RoomCritterController:sendFinishTrainCritter(critterUid)
	if not self._lastSendFinishTrainCritterTime or self._lastSendFinishTrainCritterTime + 3 < Time.time then
		self._lastSendFinishTrainCritterTime = Time.time

		CritterRpc.instance:sendFinishTrainCritterRequest(critterUid, self._onFinishTrainCritterReply, self)
	end
end

function RoomCritterController:_onFinishTrainCritterReply(cmd, resultCode, msg)
	self._lastSendFinishTrainCritterTime = nil

	if resultCode == 0 then
		RoomCritterController.instance:openTrainReporView(msg.uid, msg.heroId, msg.totalFinishCount)
	end
end

function RoomCritterController:sendFastForwardTrain(critterUid, itemId, itemCoun)
	CritterRpc.instance:sendFastForwardTrainRequest(critterUid, itemId, itemCoun, self._onFastForwardTrainReply, self)
end

function RoomCritterController:_onFastForwardTrainReply(cmd, resultCode, msg)
	return
end

function RoomCritterController:startTrain(eventId, critterUid, heroId)
	local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(eventId)

	if not eventCfg then
		return
	end

	local costList = string.splitToNumber(eventCfg.cost, "#")
	local itemType = costList and costList[1]
	local itemId = costList and costList[2]
	local itemCount = costList and costList[3]

	if itemCount and itemCount > 0 and itemCount > ItemModel.instance:getItemQuantity(itemType, itemId) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainItemInsufficiency, MsgBoxEnum.BoxType.Yes_No, self._onYesOpenTradeView, nil, nil, self, nil, nil)

		return
	end

	if eventCfg.type == CritterEnum.EventType.Special then
		local config = RoomConfig.instance:getCharacterInteractionConfig(eventCfg.roomDialogId)

		if config then
			RoomCharacterController.instance:startDialogTrainCritter(config, critterUid, heroId)
		else
			CritterController.instance:finishTrainSpecialEventByUid(critterUid)
		end
	elseif eventCfg.type == CritterEnum.EventType.ActiveTime then
		RoomTrainCritterModel.instance:clearSelectOptionInfos()

		local critterMO = CritterModel.instance:getCritterMOByUid(critterUid)
		local eventInfo = critterMO.trainInfo:getEvents(eventId)

		RoomTrainCritterModel.instance:setOptionsSelectTotalCount(eventInfo.remainCount)

		local storyPlayed = RoomTrainCritterModel.instance:isEventTrainStoryPlayed(heroId)

		if not storyPlayed then
			self:_startEnterTrainWithStory(eventId, heroId, critterUid, eventCfg)
		else
			self:_directEnterTrain(eventId, heroId, critterUid, eventCfg)
		end
	end

	return true
end

function RoomCritterController:_onYesOpenTradeView()
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function RoomCritterController:_startEnterTrainWithStory(eventId, heroId, critterUid, eventCfg)
	self._trainData = {}
	self._trainData.eventId = eventId
	self._trainData.heroId = heroId
	self._trainData.critterUid = critterUid
	self._trainData.skipStory = false

	local storyId = RoomTrainCritterModel.instance:getCritterTrainStory(heroId, eventCfg.initStoryId)
	local param = {}

	param.hideStartAndEndDark = true
	param.hideBtn = true

	StoryController.instance:playStory(storyId, param)
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, self._onStoryStart, self)
end

function RoomCritterController:_onStoryStart()
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, self._onStoryStart, self)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(true)

	local viewSetting = ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView)

	viewSetting.viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, self._trainData)
end

function RoomCritterController:_directEnterTrain(eventId, heroId, critterUid, eventCfg)
	self._trainData = {}
	self._trainData.eventId = eventId
	self._trainData.heroId = heroId
	self._trainData.critterUid = critterUid
	self._trainData.skipStory = true

	local viewSetting = ViewMgr.instance:getSetting(ViewName.RoomCritterTrainStoryView)

	viewSetting.viewType = ViewType.Normal

	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, self._trainData)
end

function RoomCritterController:startAttributeResult(eventId, critterUid, heroId, attributeId)
	self._trainData = {}
	self._trainData.eventId = eventId
	self._trainData.heroId = heroId
	self._trainData.critterUid = critterUid

	local heroPreferenceCo = CritterConfig.instance:getCritterHeroPreferenceCfg(heroId)
	local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(eventId)
	local storyId = RoomTrainCritterModel.instance:getCritterTrainStory(heroId, eventCfg.normalStoryId)
	local param = {}

	param.hideStartAndEndDark = true
	param.hideBtn = true

	StoryController.instance:playStory((heroPreferenceCo.effectAttribute == attributeId or nil) and RoomTrainCritterModel.instance:getCritterTrainStory(heroId, eventCfg.skilledStoryId), param)
	StoryController.instance:registerCallback(StoryEvent.StartFirstStep, self._onStoryAttributeStart, self)
end

function RoomCritterController:_onStoryAttributeStart()
	StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, self._onStoryAttributeStart, self)
	StoryController.instance:dispatchEvent(StoryEvent.HideTopBtns, true)
	StoryModel.instance:setNeedWaitStoryFinish(false)
	ViewMgr.instance:openView(ViewName.RoomCritterTrainStoryView, self._trainData)
end

function RoomCritterController:endTrain(eventId)
	local eventCfg = CritterConfig.instance:getCritterTrainEventCfg(eventId)

	if not eventCfg then
		return
	end

	if eventCfg.type == CritterEnum.EventType.Special then
		-- block empty
	elseif eventCfg.type == CritterEnum.EventType.ActiveTime then
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, self._onStoryStart, self)
		StoryController.instance:unregisterCallback(StoryEvent.StartFirstStep, self._onStoryAttributeStart, self)
	end
end

RoomCritterController.instance = RoomCritterController.New()

return RoomCritterController
