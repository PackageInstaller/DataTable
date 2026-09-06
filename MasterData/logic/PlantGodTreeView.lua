-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plantgodtree/view/PlantGodTreeView.lua

module("logic.extensions.plantgodtree.view.PlantGodTreeView", package.seeall)

local PlantGodTreeView = class("PlantGodTreeView", ViewComponent)
local tree_num = 5

function PlantGodTreeView:ctor()
	PlantGodTreeView.super.ctor(self)

	self._pointEnterMapWeed = {}
	self._pointExitMapWeed = {}
	self._pointEnterMapFertilize = {}
	self._pointExitMapFertilize = {}
	self._pointEnterMapWater = {}
	self._pointExitMapWater = {}
end

function PlantGodTreeView:unbindEvents()
	PlantGodTreeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnCollectSeed)
	GameUtil.rmClickHandler(self._btnEndlessDark)
	self:_unbindTreeClickHandler()
	self:_clearDragHandler()
end

function PlantGodTreeView:bindEvents()
	PlantGodTreeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnCollectSeed, self._onClickBtnColectSeed, self)
	GameUtil.addClickHandler(self._btnEndlessDark, self._onClickBtnEndlessDark, self)

	self._dragTypeMap = {}

	self:_addDragHandler(PlantGodTreeController.dragType.CutWeed, self._cutWeed)
	self:_addDragHandler(PlantGodTreeController.dragType.WaterTree, self._waterTree)
	self:_addDragHandler(PlantGodTreeController.dragType.FertilizeTree, self._fertilizeTree)
	self:_bindTreeHandler()
end

function PlantGodTreeView:buildUI()
	PlantGodTreeView.super.buildUI(self)

	self._btnTip = self:getGo("leftTop/btnTip")
	self._btnClose = self:getGo("leftTop/btnClose")
	self._txtTime = self:getTxt("time/txt")
	self._goldBar = self:getGo("goldBar")
	self._btnCollectSeed = self:getGo("btnCollectSeed")
	self._btnEndlessDark = self:getGo("btnEndlessDark")
	self._imgDrag = self:getGo("imgDrag")
	self._imgDragChangeComp = self:getGo("imgDrag"):GetComponent("UIImageSpriteChange")
	self._cutWeed = self:getGo("cutWeed")
	self._fertilizeTree = self:getGo("fertilizeTree")
	self._waterTree = self:getGo("waterTree")
	self._treeGoList = {}

	for i = 1, tree_num do
		local tree = self:getGo("plant/tree" .. i)

		table.insert(self._treeGoList, tree)
	end
end

function PlantGodTreeView:onExit()
	PlantGodTreeView.super.onExit(self)
	removetimer(self._ticking, self)

	for idx, treeGo in ipairs(self._treeGoList) do
		self:_clearTree(treeGo)
	end
end

function PlantGodTreeView:onEnter()
	PlantGodTreeView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_PlantGodTreeGetInfoRes, self._onGetInfoRes, self)
	self.addGEvent(self, GlobalNotify.PM_PlantGodTreePushStepRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PlantGodTreeDoEventRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_PlantGodTreeGainPrizeRes, self._onUpdate, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 556001
	end

	self._actCfg = PlantGodTreeConfig.instance:getActCfg(self._activityId)
	self._eventCfgs = PlantGodTreeConfig.instance:getEventCfg(self._activityId)
	self._txtTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	self._grassMap = {}
	self._curCropType = 0
	self._waterEventCfg = self._eventCfgs[1]
	self._grassEventCfg = self._eventCfgs[2]

	if self._waterEventCfg then
		self._maxWaterNum = self._waterEventCfg.dailyLimit or 3
	end

	if self._grassEventCfg then
		self._maxGrassNum = self._grassEventCfg.dailyLimit or 3
	end

	if self._waterEventCfg then
		self._intervalWater = self._waterEventCfg.interval or 60
	end

	if self._grassEventCfg then
		self._intervalGrass = self._grassEventCfg.interval or 60
	end

	self._curTouchingTreeId = 0
	self._curTouchingId = 0
	self._curTouchingDragId = 0
	self._dragingType = 0
	self._enterTime = ServerTime.nowMs()
	self._lastUpdateTime = self._enterTime

	PlantGodTreeController.instance:sendPM_PlantGodTreeGetInfoReq(self._activityId)
	settimer(1, self._ticking, self, true)
end

function PlantGodTreeView:_ticking()
	self._lastUpdateTime = self._lastUpdateTime + 1000

	if self._eventMap then
		for treeId, eventMap in pairs(self._eventMap) do
			if eventMap then
				for eventId, eventInfo in pairs(eventMap) do
					local needFinishTimes = eventInfo.needFinishTimes
					local todayFinishTimes = eventInfo.todayFinishTimes
					local lastEffectMillis = eventInfo.lastEffectMillis
					local lastEffectTime = lastEffectMillis or 0
					local isTimeNeedAdd = false
					local canStillAddNum = false

					if eventId == PlantGodTreeController.eventType.Grass then
						isTimeNeedAdd = self._lastUpdateTime >= lastEffectTime + self._intervalGrass * 1000
						canStillAddNum = needFinishTimes + todayFinishTimes < self._maxGrassNum
					else
						isTimeNeedAdd = self._lastUpdateTime >= lastEffectTime + self._intervalWater * 1000
						canStillAddNum = needFinishTimes + todayFinishTimes < self._maxWaterNum
					end

					local canAddEvent = isTimeNeedAdd and canStillAddNum

					if canAddEvent then
						PlantGodTreeController.instance:addEventMapData(self._activityId, treeId, eventId, lastEffectTime + self._intervalGrass * 1000)
						self:_onUpdate()
					end
				end
			end
		end
	end
end

function PlantGodTreeView:_onUpdate()
	self._info = PlantGodTreeModel.instance:getInfo(self._activityId)
	self._treeInfoMap = PlantGodTreeModel.instance:getTreeInfoMap(self._activityId)
	self._eventMap = PlantGodTreeModel.instance:getEventInfoMap(self._activityId)

	for idx, treeGo in ipairs(self._treeGoList) do
		local treeInfo = self._treeInfoMap[idx]

		if treeInfo then
			self:_updateTree(treeInfo, treeGo)
		end
	end

	self:_updateGoldBar()
end

function PlantGodTreeView:_updateGoldBar()
	local list = {}
	local tab = {
		showAdd = true,
		id = self._actCfg.seedItem
	}

	table.insert(list, tab)
	MainUIController.instance:showGlodBar(self._goldBar, self._viewPresentor, list)
end

function PlantGodTreeView:_updateTree(treeInfo, go)
	local imgPlant = goutil.findChild(go, "imgPlant")
	local imgPlantChangeComp = goutil.findChild(go, "imgPlant"):GetComponent("UIImageSpriteChange")
	local btnGodTree = goutil.findChild(go, "btnGodTree")
	local plant = goutil.findChild(go, "plant")
	local water = goutil.findChild(go, "water")
	local rewardWater = goutil.findChild(go, "rewardWater")
	local rewardWaterItem = goutil.findChild(go, "rewardWater/item")
	local btnRewardWater = goutil.findChild(go, "rewardWater/btnRewardWater")
	local weedGrass = goutil.findChild(go, "weedGrass")
	local grassList = {}

	for i = 1, self._maxGrassNum do
		local imgWeed = goutil.findChild(go, "weedGrass/imgWeed" .. i)

		table.insert(grassList, imgWeed)
	end

	local rewardWeed = goutil.findChild(go, "rewardWeed")
	local rewardWeedItem = goutil.findChild(go, "rewardWeed/item")
	local btnRewardWeed = goutil.findChild(go, "rewardWeed/btnRewardWeed")
	local fertilize = goutil.findChild(go, "fertilize")
	local imgFertilize = goutil.findChild(go, "fertilize/imgFertilize")
	local txtProgress = goutil.findChildTextComponent(go, "plant/txtProgress")
	local bgChange = goutil.findChild(go, "bg"):GetComponent(ComponentType.UIImageSpriteChange)
	local isStepOne = treeInfo.step == 1
	local isStepTree = treeInfo.step == 3
	local canFertilize = false
	local nextStepWaterCount = self._actCfg.nextStepWaterCount
	local canBeGodTree = nextStepWaterCount <= treeInfo.wateringCount

	bgChange:SetState(isStepOne and 0 or 1)

	if isStepOne then
		local needSeedItem = self._actCfg.seedItem
		local matType, matId, matNum = MaterialMgr.getMatParams(needSeedItem)
		local treeCfg = PlantGodTreeConfig.instance:getTreeCfgById(self._activityId, treeInfo.treeId)
		local needSeedNum = treeCfg.needSeedItemCount
		local curHasSeedNum = MaterialModel.instance:getMaterialsNumber(matType, matId)

		canFertilize = needSeedNum <= curHasSeedNum
		txtProgress.text = string.format("%d/%d", curHasSeedNum, needSeedNum)

		GameUtil.SetActive(rewardWeed, false)
		GameUtil.SetActive(weedGrass, false)
		GameUtil.SetActive(water, false)
		GameUtil.SetActive(rewardWater, false)
	else
		local eventMap = self._eventMap[treeInfo.treeId]

		for eventId, eventInfo in pairs(eventMap) do
			local curNeedFinishNum = eventInfo.needFinishTimes
			local curLeftShowNum = curNeedFinishNum
			local prizeStr = self._eventCfgs[eventId].prize

			if eventId == PlantGodTreeController.eventType.Grass then
				for i = 1, self._maxGrassNum do
					local hasCuted = false

					if self._grassMap[treeInfo.treeId] then
						hasCuted = self._grassMap[treeInfo.treeId][i]
					end

					GameUtil.SetActive(grassList[i], false)

					if not hasCuted and curLeftShowNum > 0 then
						curLeftShowNum = curLeftShowNum - 1

						GameUtil.SetActive(grassList[i], true)
					end
				end

				local proxy = MaterialMgr.setCellByCfg(prizeStr, rewardWeedItem)

				proxy.binder:setBgActive(false)
				GameUtil.SetActive(rewardWeed, eventInfo.prizeCount > 0)
				GameUtil.SetActive(weedGrass, curNeedFinishNum > 0)
			else
				local proxy = MaterialMgr.setCellByCfg(prizeStr, rewardWaterItem)

				proxy.binder:setBgActive(false)
				GameUtil.SetActive(water, curNeedFinishNum > 0)
				GameUtil.SetActive(rewardWater, eventInfo.prizeCount > 0)
			end
		end
	end

	imgPlantChangeComp:SetState(treeInfo.step - 1)
	GameUtil.SetActive(fertilize, canFertilize and isStepOne)
	GameUtil.SetActive(plant, not canFertilize and isStepOne)
	GameUtil.SetActive(btnGodTree, not isStepTree and canBeGodTree)
	GameUtil.addClickHandler(btnRewardWater, function()
		PlantGodTreeController.instance:sendPM_PlantGodTreeGainPrizeReq(self._activityId, treeInfo.treeId)
	end, self)
	GameUtil.addClickHandler(btnRewardWeed, function()
		PlantGodTreeController.instance:sendPM_PlantGodTreeGainPrizeReq(self._activityId, treeInfo.treeId)
	end, self)
end

function PlantGodTreeView:_clearTree(go)
	local rewardWeedItem = goutil.findChild(go, "rewardWeed/item")
	local rewardWaterItem = goutil.findChild(go, "rewardWater/item")

	MaterialMgr.resetAll(rewardWeedItem)
	MaterialMgr.resetAll(rewardWaterItem)
end

function PlantGodTreeView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function PlantGodTreeView:_onClickBtnColectSeed()
	local jumpStr = self._actCfg.jumpTo[1]

	GotoMgr.gotoByString(jumpStr)
end

function PlantGodTreeView:_onClickBtnEndlessDark()
	local jumpStr = self._actCfg.jumpTo[2]

	GotoMgr.gotoByString(jumpStr)
end

function PlantGodTreeView:_addDragHandler(dragType, go)
	local dragHandler = {}

	dragHandler.beginDragHandler = BeginDragHandler.Get(go):AddLuaHandler(function(go, edata)
		self:_OnDragBegin(dragType, edata, go)
	end)
	dragHandler.moveDragHandler = DragHandler.Get(go):AddLuaHandler(function(go, edata)
		self:_OnDrag(dragType, edata, go)
	end)
	dragHandler.endDragHandler = EndDragHandler.Get(go):AddLuaHandler(function(go, edata)
		self:_OnDragEnd(dragType, edata, go)
	end)
	self._dragTypeMap[dragType] = dragHandler
end

function PlantGodTreeView:_clearDragHandler()
	local go

	for type, dragHandler in pairs(self._dragTypeMap) do
		go = type == PlantGodTreeController.dragType.CutWeed and self._cutWeed or type == PlantGodTreeController.dragType.WaterTree and self._waterTree or self._fertilizeTree

		BeginDragHandler.Get(go.gameObject):RemoveLuaHandler(dragHandler.beginDragHandler)
		DragHandler.Get(go.gameObject):RemoveLuaHandler(dragHandler.moveDragHandler)
		EndDragHandler.Get(go.gameObject):RemoveLuaHandler(dragHandler.endDragHandler)
	end
end

function PlantGodTreeView:_OnDragBegin(dragType, edata, go)
	self._isDraging = true
	self._dragingType = dragType

	self._imgDragChangeComp:SetState(dragType - 1)
	GameUtil.SetActive(self._imgDrag, true)

	self._imgDrag.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function PlantGodTreeView:_OnDrag(dragType, edata, go)
	self._imgDrag.transform.position = uGuiUtil.GetTouchWorldPosition()
end

function PlantGodTreeView:_OnDragEnd(dragType, edata, go)
	GameUtil.SetActive(self._imgDrag, false)

	if self._dragingType == dragType then
		if self._dragingType == PlantGodTreeController.dragType.CutWeed and self._curTouchingDragId == self._dragingType then
			local isOtherDay = self:_isOtherDay()

			if isOtherDay then
				FloatWordMgr.instance:show("进入第二天，已重新刷新神树状态")
				PlantGodTreeController.instance:sendPM_PlantGodTreeGetInfoReq(self._activityId)

				return
			end

			PlantGodTreeController.instance:sendPM_PlantGodTreeDoEventReq(self._activityId, self._firstCutTreeId, PlantGodTreeController.eventType.Grass, self._cutWeedNum)
			FloatWordMgr.instance:show("除草成功，奖励掉落！")

			self._grassMap[self._firstCutTreeId] = self._grassMap[self._firstCutTreeId] or {}
			self._grassMap[self._firstCutTreeId][self._dragingType] = self._dragingType
		elseif self._dragingType == PlantGodTreeController.dragType.WaterTree and self._curTouchingDragId == self._dragingType then
			local isOtherDay = self:_isOtherDay()

			if isOtherDay then
				FloatWordMgr.instance:show("进入第二天，已重新刷新神树状态")
				PlantGodTreeController.instance:sendPM_PlantGodTreeGetInfoReq(self._activityId)

				return
			end

			local eventMap = self._eventMap[self._curTouchingTreeId]
			local eventInfo = eventMap[PlantGodTreeController.eventType.Water]

			if eventInfo then
				if not eventInfo.needFinishTimes then
					local needWaterNum = 0

					if needWaterNum > 0 then
						PlantGodTreeController.instance:sendPM_PlantGodTreeDoEventReq(self._activityId, self._curTouchingTreeId, PlantGodTreeController.eventType.Water, 1)
						FloatWordMgr.instance:show("浇水成功，奖励掉落！")
					end
				end
			end
		elseif self._dragingType == PlantGodTreeController.dragType.FertilizeTree and self._curTouchingDragId == self._dragingType then
			PlantGodTreeController.instance:sendPM_PlantGodTreePushStepReq(self._activityId, self._curTouchingTreeId)
		end
	end

	self._isDraging = false
	self._dragingType = 0
	self._firstCutTreeId = 0
	self._cutWeedNum = 0
	self._curTouchingDragId = 0
	self._curTouchingTreeId = 0
end

function PlantGodTreeView:_bindTreeHandler()
	for i, treeGo in ipairs(self._treeGoList) do
		local imgPlant = goutil.findChild(treeGo, "imgPlant")
		local btnGodTree = goutil.findChild(treeGo, "btnGodTree")
		local imgFertilize = goutil.findChild(treeGo, "fertilize")

		for j = 1, 2 do
			local imgWeed = goutil.findChild(treeGo, "weedGrass/imgWeed" .. j)

			self._pointEnterMapWeed[i] = self._pointEnterMapWeed[i] or {}
			self._pointEnterMapWeed[i][j] = PointerEnterHandler.Get(imgWeed):AddLuaHandler(function(_go, eventData)
				self:_onPointEnter(i, j, PlantGodTreeController.dragType.CutWeed, imgWeed)
			end)
			self._pointExitMapWeed[i] = self._pointExitMapWeed[i] or {}
			self._pointExitMapWeed[i][j] = PointerExitHandler.Get(imgWeed):AddLuaHandler(function(_go, eventData)
				self:_onPointExit()
			end)
		end

		self._pointEnterMapWater[i] = PointerEnterHandler.Get(imgPlant):AddLuaHandler(function(_go, eventData)
			self:_onPointEnter(i, 0, PlantGodTreeController.dragType.WaterTree, imgPlant)
		end)
		self._pointEnterMapFertilize[i] = PointerEnterHandler.Get(imgFertilize):AddLuaHandler(function(_go, eventData)
			self:_onPointEnter(i, 0, PlantGodTreeController.dragType.FertilizeTree, imgFertilize)
		end)
		self._pointExitMapWater[i] = PointerExitHandler.Get(imgPlant):AddLuaHandler(function(_go, eventData)
			self:_onPointExit()
		end)

		GameUtil.addClickHandler(btnGodTree, function()
			PlantGodTreeController.instance:sendPM_PlantGodTreePushStepReq(self._activityId, i)
		end, self)

		self._pointExitMapFertilize[i] = PointerExitHandler.Get(imgFertilize):AddLuaHandler(function(_go, eventData)
			self:_onPointExit()
		end)
	end
end

function PlantGodTreeView:_unbindTreeClickHandler()
	for i, treeGo in ipairs(self._treeGoList) do
		local imgPlant = goutil.findChild(treeGo, "imgPlant")
		local btnGodTree = goutil.findChild(treeGo, "btnGodTree")
		local imgFertilize = goutil.findChild(treeGo, "fertilize")

		for j = 1, 3 do
			local imgWeed = goutil.findChild(treeGo, "weedGrass/imgWeed" .. j)
			local handler = self._pointEnterMapWeed[i][j]

			if imgWeed and handler then
				PointerEnterHandler.Get(imgWeed):RemoveLuaHandler(handler)
			end

			local handler = self._pointExitMapWeed[i][j]

			if imgWeed and handler then
				PointerExitHandler.Get(imgWeed):RemoveLuaHandler(handler)
			end

			self._pointEnterMapWeed[i][j] = nil
			self._pointExitMapWeed[i][j] = nil
		end

		local enterHanler = self._pointEnterMapWater[i]
		local exitHanler = self._pointExitMapWater[i]
		local enterHanlerFertilize = self._pointEnterMapFertilize[i]
		local exitHanlerFertilize = self._pointExitMapFertilize[i]

		if imgPlant then
			if enterHanler then
				PointerEnterHandler.Get(imgPlant):RemoveLuaHandler(enterHanler)
			end

			if exitHanler then
				PointerExitHandler.Get(imgPlant):RemoveLuaHandler(exitHanler)
			end
		end

		if imgFertilize then
			if enterHanlerFertilize then
				PointerEnterHandler.Get(imgFertilize):RemoveLuaHandler(enterHanlerFertilize)
			end

			if exitHanlerFertilize then
				PointerExitHandler.Get(imgFertilize):RemoveLuaHandler(exitHanlerFertilize)
			end
		end

		self._pointEnterMapWater[i] = nil
		self._pointExitMapWater[i] = nil
		self._pointEnterMapFertilize[i] = nil
		self._pointExitMapFertilize[i] = nil
	end
end

function PlantGodTreeView:_onPointEnter(treeId, touchingId, dragType, go)
	self._curTouchingTreeId = treeId
	self._curTouchingId = touchingId
	self._curTouchingDragId = dragType

	local isCutSameTree = checknumber(self._firstCutTreeId) == 0 or self._firstCutTreeId == treeId

	if isCutSameTree and self._dragingType == dragType and dragType == PlantGodTreeController.dragType.CutWeed and self._isDraging then
		self._cutWeedNum = self._cutWeedNum or 0

		if self._cutWeedNum == 0 then
			self._firstCutTreeId = treeId
		end

		self._cutWeedNum = self._cutWeedNum + 1

		GameUtil.SetActive(go, false)
	end
end

function PlantGodTreeView:_onPointExit()
	self._curTouchingTreeId = 0
	self._curTouchingId = 0
	self._curTouchingDragId = 0
end

function PlantGodTreeView:_isOtherDay()
	local curTime = ServerTime.now()
	local enterTimeStamp = math.floor(self._enterTime / 1000)
	local day = GameUtil.getDaysByTimestamp(enterTimeStamp, curTime)

	return day > 1
end

function PlantGodTreeView:_onGetInfoRes()
	local isOtherDay = self:_isOtherDay()

	if isOtherDay then
		self._enterTime = ServerTime.nowMs()
		self._grassMap = {}
	end

	self:_onUpdate()
end

return PlantGodTreeView
