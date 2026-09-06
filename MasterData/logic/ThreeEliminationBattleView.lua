-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/threeelimination/view/ThreeEliminationBattleView.lua

module("logic.extensions.threeelimination.view.ThreeEliminationBattleView", package.seeall)

local ThreeEliminationBattleView = class("ThreeEliminationBattleView", ViewComponent)

ThreeEliminationBattleView.TypePos = 1
ThreeEliminationBattleView.TypeStart = 2
ThreeEliminationBattleView.TypeDestination = 3
ThreeEliminationBattleView.TypeEvent = 4
ThreeEliminationBattleView.EventNone = 0
ThreeEliminationBattleView.EventBattle = 1
ThreeEliminationBattleView.EventTreasure = 2
ThreeEliminationBattleView.GearSpeed = {
	1,
	0.4,
	0.2
}
ThreeEliminationBattleView.QualityScale = {
	0.6,
	0.7,
	0.8,
	0.9,
	1
}

function ThreeEliminationBattleView:ctor()
	ThreeEliminationBattleView.super.ctor(self)

	self._linesCount = 4
end

function ThreeEliminationBattleView:unbindEvents()
	ThreeEliminationBattleView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnOnekey)
	GameUtil.rmClickHandler(self._btnAddSpeed)
end

function ThreeEliminationBattleView:bindEvents()
	ThreeEliminationBattleView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnOneKey, self._onClickOneKey, self)
	GameUtil.addClickHandler(self._btnAddSpeed, self._onClickAddSpeed, self)
end

function ThreeEliminationBattleView:buildUI()
	ThreeEliminationBattleView.super.buildUI(self)

	self._battleLinesGo = self:getGo("battleLines")
	self._battleLines = {}

	for i = 1, self._linesCount do
		local go = goutil.findChild(self._battleLinesGo, "line_" .. i)
		local pos = {}

		for j = 1, go.transform.childCount do
			pos[j] = goutil.findChild(go, "pos" .. j)
		end

		self._battleLines[i] = {
			go = go,
			pos = pos
		}
	end

	self._container = self:getGo("Container")
	self._freeContainer = self:getGo("FreeContainer")
	self._cellObjClone = self:getGo("petCell")
	self._freeCellAreaObj = self:getGo("freeCellArea")
	self._eventCell = self:getGo("eventCell")
	self._btnOneKey = self:getGo("btnOneKey")
	self._txtGroup = self:getTxt("txtGroup")
	self._btnAddSpeed = self:getGo("btnAddSpeed")
	self._txtAddSpeed = self:getTxt("btnAddSpeed/txt")
	self._txtTotalPower = self:getTxt("txtTotalPower")
	self._effectDoorCon = {}

	for i = 1, self._linesCount do
		for j = 1, 2 do
			table.insert(self._effectDoorCon, goutil.findChild(self._battleLinesGo, string.format("lineUp%d/effectDoor%d", i, j)))
		end
	end
end

function ThreeEliminationBattleView:onExit()
	ThreeEliminationBattleView.super.onExit(self)

	self._gameStart = nil

	removetimer(self._start, self)

	if not ViewMgr.instance:isOpen(ViewName.ThreeEliminationView) and not ViewMgr.instance:isOpen(ViewName.ThreeEliminationBattleView) then
		-- block empty
	end

	for i, v in ipairs(self._doorEffect) do
		UIEffectManager.instance:stopEffect(v)
	end

	for lineIndex = self._linesCount, 1, -1 do
		local count = self._linesPetData[lineIndex]:count()

		for i = 1, count do
			local data = self._linesPetData[lineIndex]:dequeue()

			GameUtil.SetActive(data.go, false)
			self._cellPetPools:returnObject(data.go)
			self._showList:enqueue(data.mo)
		end
	end
end

function ThreeEliminationBattleView:onExitFinished()
	if self._eventCellPools then
		self._eventCellPools:clear()
	end

	if self._cellPetPools then
		self._cellPetPools:clear()
	end
end

function ThreeEliminationBattleView:onEnter()
	ThreeEliminationBattleView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._startGroup = params[2]
	self._startStage = params[3]
	self._groupId = self._startGroup
	self._stageId = self._startStage
	self._activityCfg = ThreeEliminationConfig.instance:getActivityCfg(self._activityId)
	self._passGroup = 1
	self._addSpeedGear = #ThreeEliminationBattleView.GearSpeed
	self._timeScale = ThreeEliminationBattleView.GearSpeed[self._addSpeedGear]
	self._txtAddSpeed.text = langPara("加速x%d", self._addSpeedGear)

	local allPet = ThreeEliminationOtherModel.instance:getAllPet()
	local allPetList = {}

	for k, v in pairs(allPet) do
		table.insert(allPetList, {
			type = k,
			num = v
		})
	end

	table.sort(allPetList, function(a, b)
		local cfgA = ThreeEliminationConfig.instance:getPetCfg(self._activityId, a.type)
		local cfgB = ThreeEliminationConfig.instance:getPetCfg(self._activityId, b.type)

		if cfgA.quality ~= cfgB.quality then
			return cfgA.quality > cfgB.quality
		else
			return cfgA.uniqueId < cfgB.uniqueId
		end
	end)

	local totalPower = 0

	self._showList = Queue.New()

	for i, v in ipairs(allPetList) do
		for j = 1, v.num do
			local battleMo = ThreeEliminationBattleCellMO.New()

			battleMo:initCell(self._activityId, v.type)
			self._showList:enqueue(battleMo)

			totalPower = totalPower + battleMo:getPower()
		end
	end

	self._txtTotalPower.text = langPara("总战力：<color=#FEE372FF>%d万</color>", totalPower)

	ThreeEliminationOtherModel.instance:resetPrizeInOnceBattle()

	local doorEffectName = "20240209/xiaoyouxi/fx_ui_xiaoyouxi_chuansongmen.prefab"

	self._doorEffect = {}

	for i, v in ipairs(self._effectDoorCon) do
		local doorEffect = UIEffectManager.instance:playEffect(self, doorEffectName, nil, 0, 0, true)

		table.insert(self._doorEffect, doorEffect)
		doorEffect:setScale(1)
		doorEffect:setParent(v.transform)
		doorEffect:setLocalPos(0, 0, 0)
	end

	self:initData()
	self:_resetStgeEvent()
	self:_createStageEvent()
	self:_onReadyStartStart()

	self._effects = {}
end

function ThreeEliminationBattleView:initData()
	self._txtGroup.text = langPara("波次：<color=#FEE372FF>%d-%d</color>", self._groupId, self._stageId)
	self._stageCfg = ThreeEliminationConfig.instance:getStageCfg(self._activityId, self._groupId, self._stageId)
	self._linesPetData = {}
	self._linesRoadData = {}
	self._linesShowData = {}

	local stageInfoIndex = 1

	for i = 1, self._linesCount do
		self._linesPetData[i] = Queue.New()
		self._linesShowData[i] = Queue.New()
		self._linesRoadData[i] = {}

		local lastType = ThreeEliminationBattleView.TypeStart

		for j = 1, #self._battleLines[i].pos do
			if j == 1 then
				self._linesRoadData[i][j] = {
					type = ThreeEliminationBattleView.TypeStart,
					go = self._battleLines[i].pos[j]
				}
				lastType = ThreeEliminationBattleView.TypeEvent
			elseif j == #self._battleLines[i].pos then
				self._linesRoadData[i][j] = {
					type = ThreeEliminationBattleView.TypeDestination,
					go = self._battleLines[i].pos[j]
				}
				lastType = ThreeEliminationBattleView.TypeEvent
			elseif lastType ~= ThreeEliminationBattleView.TypeEvent then
				lastType = ThreeEliminationBattleView.TypeEvent

				local rivalCfg = ThreeEliminationConfig.instance:getRivalCfg(self._stageCfg.rivalPlanIds[stageInfoIndex])

				self._linesRoadData[i][j] = {
					type = ThreeEliminationBattleView.TypeEvent,
					go = self._battleLines[i].pos[j],
					data = {
						cfg = rivalCfg,
						curPower = rivalCfg.zdl
					}
				}
				stageInfoIndex = stageInfoIndex + 1
			else
				lastType = ThreeEliminationBattleView.TypePos
				self._linesRoadData[i][j] = {
					type = ThreeEliminationBattleView.TypePos,
					go = self._battleLines[i].pos[j]
				}
			end
		end
	end
end

function ThreeEliminationBattleView:_createStageEvent()
	for i, v in ipairs(self._linesRoadData) do
		for j, k in ipairs(v) do
			if k.type == ThreeEliminationBattleView.TypeEvent then
				self:_genarateEventCell(k.data, self._eventCell, k.go)
			end
		end
	end
end

function ThreeEliminationBattleView:_resetStgeEvent()
	for i, v in ipairs(self._linesRoadData) do
		for j, k in ipairs(v) do
			if k.type == ThreeEliminationBattleView.TypeEvent then
				local go = goutil.findChild(k.go, "eventObj")

				if go then
					GameUtil.SetActive(go, false)
					self._eventCellPools:returnObject(go)
				end
			end
		end
	end
end

function ThreeEliminationBattleView:_genarateEventCell(eventData, cellObjClone, parentGo)
	function resetFunc(obj)
		self:_resetEventFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposeEventFunc(obj)
	end

	self._eventCellPools = self._eventCellPools or ObjectPool.New(20, nil, disposeFunc, resetFunc)

	local cellObj

	if self._eventCellPools then
		cellObj = self._eventCellPools:fetchObject()
	end

	if not cellObj then
		cellObj = goutil.clone(cellObjClone)

		if cellObj then
			cellObj.name = "eventObj"

			GameUtil.SetActive(cellObj, true)
			goutil.addChildToParent(cellObj.gameObject, parentGo.gameObject.transform)
			self:_initEventCell(cellObj, eventData)
		end
	else
		GameUtil.SetActive(cellObj, true)
		goutil.addChildToParent(cellObj.gameObject, parentGo.gameObject.transform)
		self:_initEventCell(cellObj, eventData)
	end

	return cellObj
end

function ThreeEliminationBattleView:_initEventCell(cellGo, eventData)
	local go = cellGo.gameObject
	local txtPower = goutil.findChildTextComponent(go, "txt")
	local imageChange = goutil.findChildComponent(go, "img", "UIImageSpriteChange")
	local imgEnemyGo = goutil.findChild(go, "imgEnemy")
	local imgTreasureGo = goutil.findChild(go, "imgTreasure")
	local imgTreasureChange = goutil.findChildComponent(go, "imgTreasure", "UIImageSpriteChange")
	local img = goutil.findChild(go, "img")

	GameUtil.setLocalPos(go, 0, 0, 0)

	local cfg = eventData.cfg

	txtPower.text = langPara("%d万", eventData.curPower)

	GameUtil.SetActive(txtPower, eventData.curPower > 0)
	GameUtil.SetActive(imgEnemyGo, false)
	GameUtil.SetActive(imgTreasureGo, false)

	if eventData.curPower > 0 then
		GameUtil.SetActive(imgEnemyGo, true)

		if cfg.isBoss == true then
			GameUtil.setLocalScale(imgEnemyGo, 1)
		else
			GameUtil.setLocalScale(imgEnemyGo, 0.8)
		end
	elseif not string.nilorempty(cfg.prize) then
		GameUtil.SetActive(imgTreasureGo, true)
	end

	imgTreasureChange:SetState(0)
end

function ThreeEliminationBattleView:_resetEventFunc(cellGo)
	local go = cellGo.gameObject
	local imageChange = goutil.findChildComponent(go, "imgTreasure", "UIImageSpriteChange")

	imageChange:SetState(0)
	goutil.addChildToParent(go.gameObject, self._freeContainer.gameObject.transform)

	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	local tweenFade = go:GetComponent(UnityTweensType.UITweenFadeOut)

	if tweenFade then
		tweenFade:RemoveListener()
	end

	if self._effects[go] then
		UIEffectManager.instance:stopEffect(self._effects[go])

		self._effects[go] = nil
	end
end

function ThreeEliminationBattleView:_disposeEventFunc(cellGo)
	local go = cellGo.gameObject

	if self._effects[go] then
		UIEffectManager.instance:stopEffect(self._effects[go])

		self._effects[go] = nil
	end

	goutil.destroy(go)
end

function ThreeEliminationBattleView:_start()
	self._maxReachLine = 1
	self._gameStart = true

	local count = self._showList:count()

	for i = 1, count do
		local mo = self._showList:dequeue()

		if self._linesShowData[self._maxReachLine] then
			self._linesShowData[self._maxReachLine]:enqueue(mo)
		end
	end

	for i = 1, self._linesCount do
		self:_genaratePetAll(i)
	end
end

function ThreeEliminationBattleView:_genaratePetAll(lineIndex)
	if self._linesShowData[lineIndex]:count() <= 0 and self._linesPetData[lineIndex]:count() <= 0 and lineIndex <= self._maxReachLine then
		if lineIndex < self._maxReachLine then
			return
		end

		self:_checkGameEnd()
	end

	if not self._gameStart then
		return
	end

	local createCount = 0

	if self._linesPetData[lineIndex]:peek() then
		local topData = self._linesPetData[lineIndex]:peek()
		local nextPos = topData.target

		for i = nextPos + 1, #self._linesRoadData[lineIndex] do
			if self._linesRoadData[lineIndex][i].type == ThreeEliminationBattleView.TypePos or self._linesRoadData[lineIndex][i].type == ThreeEliminationBattleView.TypeDestination then
				nextPos = i

				break
			end
		end

		createCount = nextPos - topData.target
	else
		createCount = self._linesShowData[lineIndex]:count() > 0 and 1 or 0
	end

	local lineStartPos = GameUtil.getLocalPos(self._linesRoadData[lineIndex][1].go)
	local lineSecondPos = GameUtil.getLocalPos(self._linesRoadData[lineIndex][2].go)
	local offset = lineSecondPos - lineStartPos

	for i = 1, createCount do
		local mo = self._linesShowData[lineIndex]:dequeue()

		if mo then
			local obj = self:_genaratePetCell(mo, self._cellObjClone, self._battleLines[lineIndex].go)

			GameUtil.setLocalPos(obj, (lineStartPos - offset * (i - 1)).x, (lineStartPos - offset * (i - 1)).y, (lineStartPos - offset * (i - 1)).z)
			self._linesPetData[lineIndex]:enqueue({
				target = 1,
				go = obj,
				mo = mo
			})
		end
	end

	self:_movePet(lineIndex)
end

function ThreeEliminationBattleView:_eventStart(lineIndex)
	if not self._gameStart then
		return
	end

	if self._linesPetData[lineIndex]:peek() then
		local topData = self._linesPetData[lineIndex]:peek()

		if self._linesRoadData[lineIndex][topData.target + 1] and self._linesRoadData[lineIndex][topData.target + 1].type == ThreeEliminationBattleView.TypeEvent then
			self:_eventShow(lineIndex, topData, self._linesRoadData[lineIndex][topData.target + 1])
		elseif self._linesRoadData[lineIndex][topData.target].type == ThreeEliminationBattleView.TypeDestination then
			if self._linesShowData[lineIndex + 1] then
				self._linesShowData[lineIndex + 1]:enqueue(topData.mo)

				if self._maxReachLine < lineIndex + 1 then
					self._maxReachLine = lineIndex + 1
				end
			else
				self:_gameEnd()
			end

			self:_eventEnd(lineIndex)
		else
			self:_eventEnd(lineIndex)
		end
	else
		self:_eventEnd(lineIndex)
	end
end

function ThreeEliminationBattleView:_eventShow(lineIndex, petData, roadData)
	if roadData.data then
		local event = self:_checkEventType(roadData)

		if event == ThreeEliminationBattleView.EventBattle then
			self:_battleShow(petData, roadData, lineIndex, GameUtil.handler(function()
				self:_eventEnd(lineIndex)
			end, self))
		elseif event == ThreeEliminationBattleView.EventTreasure then
			self:_treasureShow(petData, roadData, GameUtil.handler(function()
				self:_eventEnd(lineIndex)
			end, self))
		else
			self:_eventEnd(lineIndex)
		end
	else
		self:_eventEnd(lineIndex)
	end
end

function ThreeEliminationBattleView:_eventEnd(lineIndex)
	local data = self._linesPetData[lineIndex]:peek()

	if data and (data.mo:getPower() <= 0 or self._linesRoadData[lineIndex][data.target].type == ThreeEliminationBattleView.TypeDestination) then
		GameUtil.SetActive(data.go, false)
		self._cellPetPools:returnObject(data.go)
		self._linesPetData[lineIndex]:dequeue()
	end

	self:_genaratePetAll(lineIndex)
end

function ThreeEliminationBattleView:_movePet(lineIndex)
	if not self._gameStart then
		return
	end

	if self._linesPetData[lineIndex]:peek() then
		local topData = self._linesPetData[lineIndex]:peek()
		local nextPos = topData.target
		local isReachDestination = false

		for i = nextPos + 1, #self._linesRoadData[lineIndex] do
			if self._linesRoadData[lineIndex][i].type == ThreeEliminationBattleView.TypePos then
				nextPos = i

				break
			elseif self._linesRoadData[lineIndex][i].type == ThreeEliminationBattleView.TypeDestination then
				nextPos = i
				isReachDestination = true

				break
			end
		end

		self._linesPetData[lineIndex]:traversal(function(index, data)
			data.target = math.max(nextPos - index + 1, 1)

			local targetPos = GameUtil.getLocalPos(self._linesRoadData[lineIndex][data.target].go)
			local formPos = GameUtil.getLocalPos(data.go)
			local tween = data.go:GetComponent(UnityTweensType.TweenPosition)

			tween:Stop()

			tween.from = formPos
			tween.to = targetPos
			tween.time = isReachDestination == true and 0.5 * self._timeScale or 1 * self._timeScale
			tween.delay = 0 * self._timeScale

			tween:Begin()

			if index == 1 then
				tween:AddListener(function()
					self:_eventStart(lineIndex)
				end)
			end
		end)
	else
		settimer(2 * self._timeScale, function()
			if self then
				self:_eventStart(lineIndex)
			end
		end, self, false)
	end
end

function ThreeEliminationBattleView:_checkEventType(roadData)
	if roadData.data.curPower > 0 then
		return ThreeEliminationBattleView.EventBattle
	elseif not string.nilorempty(roadData.data.cfg.prize) then
		return ThreeEliminationBattleView.EventTreasure
	else
		return ThreeEliminationBattleView.EventNone
	end
end

function ThreeEliminationBattleView:_battleShow(petData, roadData, lineIndex, callBack)
	local petDestory = false
	local petPower = petData.mo:getPower()
	local enemyPower = roadData.data.curPower

	roadData.data.curPower = math.max(roadData.data.curPower - petPower, 0)

	local envntGo = goutil.findChild(roadData.go, "eventObj")

	self:_initEventCell(envntGo, roadData.data)
	petData.mo:battleWithPower(enemyPower)
	self:_initPetCell(petData.go, petData.mo)

	if petData.mo:getPower() <= 0 then
		local data = self._linesPetData[lineIndex]:dequeue()
		local tween = petData.go:GetComponent(UnityTweensType.UITweenFadeOut)

		tween:Stop()

		petDestory = true
		tween.time = 0.1 * self._timeScale
		tween.delay = 0 * self._timeScale

		tween:Begin()

		if self._effects[data.go] then
			UIEffectManager.instance:stopEffect(self._effects[data.go])

			self._effects[data.go] = nil
		end

		local effectName = "20240209/xiaoyouxi/fx_ui_xiaoyouxi_chuansongmen_shan.prefab"
		local effect = UIEffectManager.instance:playEffect(self, effectName, nil, 0, 0, false, false, function()
			GameUtil.SetActive(data.go, false)
			self._cellPetPools:returnObject(data.go)
		end)

		self._effects[data.go] = effect

		local effectFollowGo = goutil.findChild(petData.go, "imgBg")

		effect:setParent(effectFollowGo.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
	end

	if roadData.data.curPower <= 0 then
		local tween = envntGo:GetComponent(UnityTweensType.UITweenFadeOut)

		tween:Stop()

		tween.time = 0.1 * self._timeScale
		tween.delay = 0 * self._timeScale

		tween:Begin()

		if self._effects[envntGo] then
			UIEffectManager.instance:stopEffect(self._effects[envntGo])

			self._effects[envntGo] = nil
		end

		local effectName = "20240209/xiaoyouxi/fx_ui_xiaoyouxi_die.prefab"
		local effect = UIEffectManager.instance:playEffect(self, effectName, nil, 0, 0, false)

		self._effects[envntGo] = effect

		effect:setParent(envntGo.transform)
		effect:setScale(1)
		effect:setLocalPos(0, 0, 0)
	end

	GameUtil.callBack(callBack)
end

function ThreeEliminationBattleView:_treasureShow(petData, roadData, callBack)
	local envntGo = goutil.findChild(roadData.go, "eventObj")
	local imageChange = goutil.findChildComponent(envntGo, "imgTreasure", "UIImageSpriteChange")

	imageChange:SetState(1)

	local tween = envntGo:GetComponent(UnityTweensType.UITweenFadeOut)

	GameUtil.callBack(callBack)
	tween:Stop()

	tween.time = 0.1 * self._timeScale
	tween.delay = 0.5 * self._timeScale

	tween:Begin()

	if self._effects[envntGo] then
		UIEffectManager.instance:stopEffect(self._effects[envntGo])

		self._effects[envntGo] = nil
	end

	local effectName = "20240209/xiaoyouxi/fx_ui_xiaoyouxi_baoxiang.prefab"
	local effect = UIEffectManager.instance:playEffect(self, effectName, nil, 0, 0, false)

	self._effects[envntGo] = effect

	effect:setParent(envntGo.transform)
	effect:setScale(1)
	effect:setLocalPos(0, 0, 0)
end

function ThreeEliminationBattleView:_genaratePetCell(battleMo, cellObjClone, parentGo)
	function resetFunc(obj)
		self:_resetPetFunc(obj)
	end

	function disposeFunc(obj)
		self:_disposePetFunc(obj)
	end

	self._cellPetPools = self._cellPetPools or ObjectPool.New(20, nil, disposeFunc, resetFunc)

	local cellObj

	if self._cellPetPools then
		cellObj = self._cellPetPools:fetchObject()
	end

	if not cellObj then
		cellObj = goutil.clone(cellObjClone)

		if cellObj then
			goutil.addChildToParent(cellObj.gameObject, parentGo.gameObject.transform)
			GameUtil.SetActive(cellObj, true)
			self:_initPetCell(cellObj, battleMo)
		end
	else
		goutil.addChildToParent(cellObj.gameObject, parentGo.gameObject.transform)
		GameUtil.SetActive(cellObj, true)
		self:_initPetCell(cellObj, battleMo)
	end

	return cellObj
end

function ThreeEliminationBattleView:_initPetCell(cellGo, battleMo)
	local go = cellGo.gameObject
	local icon = goutil.findChild(go, "imgBg/imgIcon")
	local qualityChange = go:GetComponent(ComponentType.UIChangeGroup)
	local txtPower = goutil.findChildTextComponent(go, "imgBg/txtPower")
	local qualityBgGo = goutil.findChild(go, "imgBg/bg")
	local cfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, battleMo.type)

	txtPower.text = langPara("%d万", battleMo:getPower())

	qualityChange:SetState(cfg.quality - 1)
	GameUtil.setLocalScale(qualityBgGo, ThreeEliminationBattleView.QualityScale[cfg.quality])
	GameUtil.setLocalScale(icon, ThreeEliminationBattleView.QualityScale[cfg.quality])
	MaterialMgr.setIcon(icon, MatType.Pet, cfg.raceId)
end

function ThreeEliminationBattleView:_resetPetFunc(cellGo)
	local go = cellGo.gameObject
	local icon = goutil.findChild(go, "imgMask/imgIcon")
	local canvasGroup = go:GetComponent(ComponentType.CanvasGroup)

	canvasGroup.alpha = 1

	goutil.addChildToParent(go.gameObject, self._freeContainer.gameObject.transform)

	local tweenPos = go:GetComponent(UnityTweensType.TweenPosition)

	if tweenPos then
		tweenPos:RemoveListener()
	end

	local tweenFade = go:GetComponent(UnityTweensType.UITweenFadeOut)

	if tweenFade then
		tweenFade:RemoveListener()
	end

	MaterialMgr.resetAll(icon)

	if self._effects[go] then
		UIEffectManager.instance:stopEffect(self._effects[go])

		self._effects[go] = nil
	end
end

function ThreeEliminationBattleView:_disposePetFunc(cellGo)
	local go = cellGo.gameObject
	local icon = goutil.findChild(go, "imgMask/imgIcon")

	goutil.addChildToParent(go.gameObject, self._freeContainer.gameObject.transform)

	local tweenPos = go:GetComponent(UnityTweensType.TweenPosition)

	if tweenPos then
		tweenPos:RemoveListener()
	end

	local tweenFade = go:GetComponent(UnityTweensType.UITweenFadeOut)

	if tweenFade then
		tweenFade:RemoveListener()
	end

	MaterialMgr.resetAll(icon)

	if self._effects[go] then
		UIEffectManager.instance:stopEffect(self._effects[go])

		self._effects[go] = nil
	end

	goutil.destroy(go)
end

function ThreeEliminationBattleView:_checkGameEnd()
	if not self._gameStart then
		return
	end

	local isNoPet = true

	for lineIndex = 1, self._linesCount do
		if self._linesShowData[lineIndex]:count() > 0 or self._linesPetData[lineIndex]:count() > 0 then
			isNoPet = false

			break
		end
	end

	if isNoPet == true and self._gameStart == true then
		self._gameStart = false

		self:_gameEnd()
	end
end

function ThreeEliminationBattleView:_gameEnd()
	self._gameStart = false

	for lineIndex = self._linesCount, 1, -1 do
		local count = self._linesPetData[lineIndex]:count()

		for i = 1, count do
			local data = self._linesPetData[lineIndex]:dequeue()

			GameUtil.SetActive(data.go, false)
			self._cellPetPools:returnObject(data.go)
			self._showList:enqueue(data.mo)
		end
	end

	if self._showList:count() > 0 then
		local isEnd = false

		if ThreeEliminationConfig.instance:getStageCfg(self._activityId, self._groupId, self._stageId + 1) then
			self._stageId = self._stageId + 1
		elseif self._passGroup < self._activityCfg.maxGroupPerRound and ThreeEliminationConfig.instance:getGroupCfg(self._activityId, self._groupId + 1) then
			self._passGroup = self._passGroup + 1
			self._groupId = self._groupId + 1
			self._stageId = 1
		else
			isEnd = true
		end

		if not isEnd then
			self:initData()
			self:_resetStgeEvent()
			self:_createStageEvent()
			self:_onReadyStartStart()
		else
			self:calcAllPrizeGain()
			UIStateManager.instance:push(ViewName.ThreeEliminationResultView)
		end
	else
		self:calcAllPrizeGain()
		UIStateManager.instance:push(ViewName.ThreeEliminationResultView)
	end
end

function ThreeEliminationBattleView:calcAllPrizeGain()
	for groupId = 1, self._startGroup - 1 do
		local groupCfg = ThreeEliminationConfig.instance:getGroupCfg(self._activityId, groupId)

		for stageId, stageCfg in ipairs(groupCfg) do
			for i, planId in ipairs(stageCfg.rivalPlanIds) do
				local rivalCfg = ThreeEliminationConfig.instance:getRivalCfg(planId)

				ThreeEliminationOtherModel.instance:addPrizeInOnceBattle(rivalCfg.prize)
			end
		end
	end

	local curGroup = self._startGroup
	local curStage = self._startStage
	local curIndex = 0
	local allPet = ThreeEliminationOtherModel.instance:getAllPet()
	local allPetList = {}

	for k, v in pairs(allPet) do
		table.insert(allPetList, {
			type = k,
			num = v
		})
	end

	table.sort(allPetList, function(a, b)
		local cfgA = ThreeEliminationConfig.instance:getPetCfg(self._activityId, a.type)
		local cfgB = ThreeEliminationConfig.instance:getPetCfg(self._activityId, b.type)

		if cfgA.quality ~= cfgB.quality then
			return cfgA.quality > cfgB.quality
		else
			return cfgA.uniqueId < cfgB.uniqueId
		end
	end)

	local petList = Queue.New()

	for i, v in ipairs(allPetList) do
		for j = 1, v.num do
			local battleMo = ThreeEliminationBattleCellMO.New()

			battleMo:initCell(self._activityId, v.type)
			petList:enqueue(battleMo)
		end
	end

	local curEnemyPower = 0

	while petList:peek() do
		local data = petList:peek()
		local eventCfg

		if curEnemyPower <= 0 then
			local planId = 0
			local stageCfg = ThreeEliminationConfig.instance:getStageCfg(self._activityId, curGroup, curStage)

			if stageCfg.rivalPlanIds[curIndex + 1] then
				curIndex = curIndex + 1
				planId = stageCfg.rivalPlanIds[curIndex]
			else
				curIndex = 1
				curStage = curStage + 1
				stageCfg = ThreeEliminationConfig.instance:getStageCfg(self._activityId, curGroup, curStage)

				if stageCfg then
					planId = stageCfg.rivalPlanIds[curIndex]
				else
					curStage = 1
					curGroup = curGroup + 1
					groupCfg = ThreeEliminationConfig.instance:getGroupCfg(self._activityId, curGroup)

					if groupCfg then
						stageCfg = ThreeEliminationConfig.instance:getStageCfg(self._activityId, curGroup, curStage)
						planId = stageCfg.rivalPlanIds[curIndex]
					else
						break
					end
				end
			end

			eventCfg = ThreeEliminationConfig.instance:getRivalCfg(planId)
			curEnemyPower = eventCfg.zdl
		else
			local curStageCfg = ThreeEliminationConfig.instance:getStageCfg(self._activityId, curGroup, curStage)
			local planId = curStageCfg.rivalPlanIds[curIndex]

			eventCfg = ThreeEliminationConfig.instance:getRivalCfg(planId)
		end

		local tempEnemyPower = curEnemyPower - data:getPower()

		data:battleWithPower(curEnemyPower)

		curEnemyPower = math.max(tempEnemyPower, 0)

		if data:getPower() <= 0 then
			petList:dequeue()
		end

		if curEnemyPower == 0 then
			ThreeEliminationOtherModel.instance:addPrizeInOnceBattle(eventCfg.prize)
		end
	end

	for i = 1, petList:count() do
		local mo = petList:dequeue()
		local petCfg = ThreeEliminationConfig.instance:getPetCfg(self._activityId, mo.type)

		ThreeEliminationOtherModel.instance:addPrizeInOnceBattle(mo.aliveReturnMp)
	end
end

function ThreeEliminationBattleView:_onReadyStartStart()
	settimer(2 * self._timeScale, self._start, self, false)
end

function ThreeEliminationBattleView:_onClickOneKey()
	if self._gameStart == true then
		self._gameStart = false

		self:calcAllPrizeGain()
		UIStateManager.instance:push(ViewName.ThreeEliminationResultView)
	else
		FloatWordMgr.instance:show(lang("正在结算"))
	end
end

function ThreeEliminationBattleView:_onClickAddSpeed()
	self._addSpeedGear = self._addSpeedGear + 1

	if self._addSpeedGear > #ThreeEliminationBattleView.GearSpeed then
		self._addSpeedGear = 1
	end

	self._timeScale = ThreeEliminationBattleView.GearSpeed[self._addSpeedGear]
	self._txtAddSpeed.text = langPara("加速x%d", self._addSpeedGear)
end

return ThreeEliminationBattleView
