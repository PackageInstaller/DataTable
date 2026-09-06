-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinexingjiangclg/view/DivinexjClgGameMainView.lua

module("logic.extensions.divinexingjiangclg.view.DivinexjClgGameMainView", package.seeall)

local DivinexjClgGameMainView = class("DivinexjClgGameMainView", ViewComponent)

function DivinexjClgGameMainView:buildUI()
	DivinexjClgGameMainView.super.buildUI(self)

	self._hpIcon = self:getGo("hp/hpIcon")
	self._hpContainers = self:getGo("hp/containers")

	goutil.setActive(self._hpIcon, false)

	self._txtScore = self:getTxt("score/txt")
	self._txtTime = self:getTxt("time/txt")
	self._btnStartGame = self:getBtn("btnStartGame")
	self._containersList = {}

	local pathPrefix = "main/containers/cell"

	for i = 1, DivineXingJiangClgGameModel.PillarNum do
		local go = self:getGo(pathPrefix .. i)

		goutil.setActive(go, true)

		local cell = {}

		cell.txtDesc = goutil.findChildTextComponent(go, "txtDesc")
		cell.iconChange = goutil.findChild(go, "icon"):GetComponent(ComponentType.UIImageSpriteChange)
		cell.descColorChange = cell.txtDesc:GetComponent(ComponentType.UITextColorChange)
		cell.astroId = 0

		table.insert(self._containersList, cell)
	end

	self._pillarsList = {}

	local pillarPathPrefix = "main/pillars/pole"

	for i = 1, DivineXingJiangClgGameModel.PillarNum do
		local go = self:getGo(pillarPathPrefix .. i)

		goutil.setActive(go, true)

		local cell = {}

		cell.rectTrans = go:GetComponent(goutil.Type_RectTransform)

		table.insert(self._pillarsList, cell)
	end

	self._dropItemArea = self:getGo("main/dropItemArea")
	self._dropItem = self:getGo("main/dropItem")

	goutil.setActive(self._dropItem, false)

	self._horizontalPoleArea = self:getGo("main/horizontalPoleArea")
	self._horizontalPole = self:getGo("main/horizontalPole")

	goutil.setActive(self._horizontalPole, false)

	self._btnClickArea = self:getBtn("main/clickArea")
	self._mainRectTrans = self:getGo("main"):GetComponent(goutil.Type_RectTransform)
	self._dropItemObjectPool = self:_getDropItemObjectPool()
	self._horizontalPoleObjectPool = self:_getHorizontalPoleObjectPool()

	self:_initPosPointsList()

	self._effectList = {}

	local effectPathPrefix = "main/effects/effect"

	for i = 1, DivineXingJiangClgGameModel.PillarNum do
		self._effectList[i] = self:getGo(effectPathPrefix .. i)
	end
end

function DivinexjClgGameMainView:destroyUI()
	self._dropItemObjectPool:clear()
	self._horizontalPoleObjectPool:clear()
end

function DivinexjClgGameMainView:bindEvents()
	DivinexjClgGameMainView.super.bindEvents(self)
	self._btnStartGame:AddClickListener(self._onClickStartGame, self)
	self._btnClickArea:AddClickListener(self._onClickArea, self)
end

function DivinexjClgGameMainView:unbindEvents()
	DivinexjClgGameMainView.super.unbindEvents(self)
	self._btnStartGame:RemoveClickListener()
	self._btnClickArea:RemoveClickListener()
end

function DivinexjClgGameMainView:onEnter()
	DivinexjClgGameMainView.super.onEnter(self)
	DivineXingJiangClgGameController.instance:registerLocalNotify(DivineXingJiangClgGameController.EventCaculateScore, self._onDropItemToContainer, self)
	DivineXingJiangClgGameController.instance:registerLocalNotify(DivineXingJiangClgGameController.EventRemoveHorizontalPole, self._onRemoveHorizontalPole, self)
	DivineXingJiangClgGameModel.instance:onInit()
	self:_initVariables()
	self:_initGameStartGo()
	self:_initHpGos()
	self:_initGameTime()
	self:_initGameScore()
	self:_initContainers()
	settimer(0, self._onUpdate, self)
end

function DivinexjClgGameMainView:onExit()
	DivinexjClgGameMainView.super.onExit(self)
	DivineXingJiangClgGameController.instance:unregisterLocalNotify(DivineXingJiangClgGameController.EventCaculateScore, self._onDropItemToContainer, self)
	DivineXingJiangClgGameController.instance:unregisterLocalNotify(DivineXingJiangClgGameController.EventRemoveHorizontalPole, self._onRemoveHorizontalPole, self)
	removetimer(self._onUpdate, self)
	self:_clearContainerTweens()
	self:_clearDropItems()
	self:_clearHorizontalPoles()
end

function DivinexjClgGameMainView:_onClickStartGame()
	self:_startGame()
end

function DivinexjClgGameMainView:_onClickArea()
	self:_attempAddHorizontalPoleItem()
end

function DivinexjClgGameMainView:_onDropItemToContainer(astroId, instanceId, pillarIndex)
	printInfo("test DivinexjClgGameMainView:_onDropItemToContainer", astroId, instanceId, pillarIndex)

	local cls = self._dropItemClsDic[instanceId]

	if cls then
		self._dropItemObjectPool:returnObject(cls:getMainGO())

		self._dropItemClsDic[instanceId] = nil
	end

	local container = self._containersList[pillarIndex]

	self._tweenContainerDic = self._tweenContainerDic or {}

	if self._tweenContainerDic[pillarIndex] then
		self._tweenContainerDic[pillarIndex]:Kill()

		self._tweenContainerDic[pillarIndex] = nil
	end

	GameUtil.SetActive(container.txtDesc, true)

	self._tweenContainerDic[pillarIndex] = TweenUtil.DoDelay(2, function()
		GameUtil.SetActive(container.txtDesc, false)
	end)

	printInfo("test container.astroId == astroId", container.astroId, astroId, container.astroId == astroId)

	if container.astroId == astroId then
		container.txtDesc.text = "数量 +1"

		container.descColorChange:SetState(1)
		self:_addGameScore()
		self:_playEffect(pillarIndex)
	else
		container.txtDesc.text = "生命值 -1"

		container.descColorChange:SetState(0)
		self:_subHp()
	end
end

function DivinexjClgGameMainView:_onRemoveHorizontalPole(instanceId)
	self:_removeHorizontalPoleItem(instanceId)
end

function DivinexjClgGameMainView:_onUpdate()
	if DivineXingJiangClgGameModel.instance:getGameState() == DivineXingJiangClgGameModel.GamePlaying then
		DivineXingJiangClgGameModel.instance:updateCountdown()
		self:_updateGameTime()
		self:_estimateGameOver()
		self:_updateDropItem()
	end
end

function DivinexjClgGameMainView:_getDropItemObjectPool()
	local function createFunc()
		local go = goutil.cloneAndSetParent(self._dropItem, self._dropItemArea.transform, "dropItem")

		goutil.setActive(go, true)

		return go
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		local cls = GameUtil.AddLuaOnce(go, DivinexjDropItem)

		cls:onReset()
		goutil.setActive(go, false)

		go.name = "dropItem(recycle)"
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function DivinexjClgGameMainView:_getHorizontalPoleObjectPool()
	local function createFunc()
		local go = goutil.cloneAndSetParent(self._horizontalPole, self._horizontalPoleArea.transform, "horizontalPole")

		goutil.setActive(go, true)

		return go
	end

	local function disposeFunc(go)
		goutil.destroy(go)
	end

	local function resetFunc(go)
		goutil.setActive(go, false)

		go.name = "horizontalPole(recycle)"
	end

	return ObjectPool.New(20, createFunc, disposeFunc, resetFunc)
end

function DivinexjClgGameMainView:_initVariables()
	math.randomseed(os.time())

	self._hpGos = self._hpGos or {}
	self._dropItemIntervalTime = 0
	self._runDropItemIntervalTime = 0
	self._dropItemIntervalRange = DivineXingJiangClgGameModel.instance:getDropItemInterval()
	self._dropItemClsDic = {}
	self._horizontalPoleClsDic = {}
	self._tweenContainerDic = {}
	self._randomAstroIds = {}
end

function DivinexjClgGameMainView:_initGameStartGo()
	goutil.setActive(self._btnStartGame.gameObject, true)
end

function DivinexjClgGameMainView:_initHpGos()
	local maxHp = DivineXingJiangClgGameModel.instance:getMaxHp()

	for i = 1, maxHp do
		if self._hpGos[i] then
			goutil.setActive(self._hpGos[i], true)
		else
			local go = goutil.cloneAndSetParent(self._hpIcon, self._hpContainers.transform, "hp" .. i)

			goutil.setActive(go, true)
			table.insert(self._hpGos, go)
		end
	end

	local count = #self._hpGos

	if maxHp < count then
		for i = maxHp + 1, count do
			goutil.setActive(self._hpGos[i], false)
		end
	end
end

function DivinexjClgGameMainView:_subHp()
	local oldCurHp = DivineXingJiangClgGameModel.instance:getCurHp()

	DivineXingJiangClgGameModel.instance:subHp()

	if oldCurHp > 0 then
		goutil.setActive(self._hpGos[oldCurHp], false)
	end
end

function DivinexjClgGameMainView:_initGameTime()
	local maxCountdown = DivineXingJiangClgGameModel.instance:getMaxCountdown()

	self._txtTime.text = string.format("倒计时：<color=#FFB639>%d</color>秒", maxCountdown)
end

function DivinexjClgGameMainView:_updateGameTime()
	local countdown = DivineXingJiangClgGameModel.instance:getCountdown()

	self._txtTime.text = string.format("倒计时：<color=#FFB639>%d</color>秒", Mathf.Ceil(countdown))
end

function DivinexjClgGameMainView:_initGameScore()
	self._txtScore.text = string.format("收集星座数量：%d", 0)
end

function DivinexjClgGameMainView:_addGameScore()
	DivineXingJiangClgGameModel.instance:addGameScore()

	local score = DivineXingJiangClgGameModel.instance:getGameScore()

	self._txtScore.text = string.format("收集星座数量：%d", score)
end

function DivinexjClgGameMainView:_initContainers()
	local astroIds = DivineXingJiangClgGameController.instance:getRandomAstroIds()

	self._randomAstroIds = astroIds

	for i, v in ipairs(self._containersList) do
		v.astroId = astroIds[i]

		v.iconChange:SetState(v.astroId - 1)
		GameUtil.SetActive(v.txtDesc, false)
	end
end

function DivinexjClgGameMainView:_startGame()
	goutil.setActive(self._btnStartGame.gameObject, false)
	DivineXingJiangClgGameModel.instance:startGame()
	self:_updateDropItem(true)
end

function DivinexjClgGameMainView:_gameOver()
	DivineXingJiangClgGameModel.instance:gameOver()

	local score = DivineXingJiangClgGameModel.instance:getGameScore()

	UIStateManager.instance:push(ViewName.DivinexjClgGameResultView, score)
end

function DivinexjClgGameMainView:_estimateGameOver()
	if DivineXingJiangClgGameModel.instance:isDead() then
		self:_gameOver()
	elseif DivineXingJiangClgGameModel.instance:isNoTime() then
		self:_gameOver()
	end
end

function DivinexjClgGameMainView:_initPosPointsList()
	self._posPointsList = {}

	for i = 1, DivineXingJiangClgGameModel.PillarNum do
		local info = {}
		local rectTrans = self._pillarsList[i].rectTrans

		info.birthPos = Vector2.New(rectTrans.anchoredPosition.x, rectTrans.anchoredPosition.y + rectTrans.rect.height)
		info.deathPos = rectTrans.anchoredPosition

		if i >= 2 then
			self._posPointsList[i - 1].middleX = (info.birthPos.x + self._posPointsList[i - 1].birthPos.x) / 2
		end

		if i == DivineXingJiangClgGameModel.PillarNum then
			info.middleX = self._posPointsList[i - 1].middleX
		end

		table.insert(self._posPointsList, info)
	end
end

function DivinexjClgGameMainView:_updateDropItem(forceCreate)
	for k, v in pairs(self._dropItemClsDic) do
		v:updateDropItemPos(self._horizontalPoleClsDic)
	end

	if forceCreate then
		printInfo("test 创建掉落物 forceCreate = ", os.date("%Y-%m-%d %H:%M:%S", ServerTime.now()))

		self._dropItemIntervalTime = DivineXingJiangClgGameModel.instance:getRandomDropInterval()
		self._runDropItemIntervalTime = 0

		self:_createDropItem()
	else
		local isCanCreate = self._runDropItemIntervalTime >= self._dropItemIntervalTime

		if isCanCreate then
			printInfo("test 创建掉落物 = ", os.date("%Y-%m-%d %H:%M:%S", ServerTime.now()))

			self._dropItemIntervalTime = DivineXingJiangClgGameModel.instance:getRandomDropInterval()
			self._runDropItemIntervalTime = 0

			self:_createDropItem()
		else
			self._runDropItemIntervalTime = self._runDropItemIntervalTime + Time.deltaTime
		end
	end
end

function DivinexjClgGameMainView:_createDropItem()
	local createNum = DivineXingJiangClgGameModel.instance:getRandomCreateNum()
	local indexes = DivineXingJiangClgGameController.instance:getRandomIndexs(createNum)

	for i, index in ipairs(indexes) do
		local dropItemGo = self._dropItemObjectPool:fetchObject()

		goutil.setActive(dropItemGo, true)

		local cls = GameUtil.AddLuaOnce(dropItemGo, DivinexjDropItem)
		local posInfo = self._posPointsList[index]

		cls:init(index, posInfo.birthPos, posInfo.deathPos, DivineXingJiangClgGameController.instance:getAstroIdByRandom(self._randomAstroIds))

		self._dropItemClsDic[dropItemGo:GetInstanceID()] = cls
	end
end

function DivinexjClgGameMainView:_attempAddHorizontalPoleItem()
	local screenPos = UGUIToolHelper.GetTouchPosition()
	local anchoredPos = goutil.screenToLocalPos(screenPos, self._mainRectTrans)
	local space = DivineXingJiangClgGameModel.instance:getHorizontalPoleSpace()
	local halfHeight = DivineXingJiangClgGameModel.instance:getHorizontalPoleHeight() / 2
	local topY = anchoredPos.y + halfHeight + space + halfHeight
	local bottomY = anchoredPos.y - halfHeight - space - halfHeight
	local leftIndex = self:_getPillarIndexByPosX(anchoredPos.x)
	local isOverLap = false

	for k, cls in pairs(self._horizontalPoleClsDic) do
		isOverLap = isOverLap or cls:isOverLap(leftIndex, topY, bottomY)

		if isOverLap then
			break
		end
	end

	if not isOverLap then
		self:_createHorizontalPoleItem(leftIndex, anchoredPos.y)
	else
		FloatWordMgr.instance:show("该位置有阻挡不可放置")
	end
end

function DivinexjClgGameMainView:_createHorizontalPoleItem(leftIndex, posY)
	local horizontalPoleGo = self._horizontalPoleObjectPool:fetchObject()

	goutil.setActive(horizontalPoleGo, true)

	local cls = GameUtil.AddLuaOnce(horizontalPoleGo, DivinexjHorizontalPoleItem)

	cls:init(leftIndex, self._posPointsList[leftIndex].middleX, posY, self._posPointsList[leftIndex].birthPos.x, self._posPointsList[leftIndex + 1].birthPos.x)

	self._horizontalPoleClsDic[horizontalPoleGo:GetInstanceID()] = cls
end

function DivinexjClgGameMainView:_removeHorizontalPoleItem(instanceId)
	local cls = self._horizontalPoleClsDic[instanceId]

	if cls then
		local go = cls:getMainGO()

		self._horizontalPoleObjectPool:returnObject(go)

		self._horizontalPoleClsDic[instanceId] = nil
	end
end

function DivinexjClgGameMainView:_getPillarIndexByPosX(clickPosX)
	local leftIndex = 1
	local count = #self._posPointsList

	for i = 1, count - 1 do
		local nextIndex = i + 1

		if nextIndex == 2 then
			if clickPosX < self._posPointsList[nextIndex].birthPos.x then
				leftIndex = i

				break
			end
		elseif nextIndex == count then
			if clickPosX >= self._posPointsList[i].birthPos.x then
				leftIndex = i

				break
			end
		elseif clickPosX >= self._posPointsList[i].birthPos.x and clickPosX < self._posPointsList[nextIndex].birthPos.x then
			leftIndex = i

			break
		end
	end

	return leftIndex
end

function DivinexjClgGameMainView:_clearContainerTweens()
	for i, v in pairs(self._tweenContainerDic) do
		v:Kill()
	end

	table.clear(self._tweenContainerDic)
end

function DivinexjClgGameMainView:_clearDropItems()
	for k, v in pairs(self._dropItemClsDic) do
		local go = v:getMainGO()

		self._dropItemObjectPool:returnObject(go)
	end
end

function DivinexjClgGameMainView:_clearHorizontalPoles()
	for k, v in pairs(self._horizontalPoleClsDic) do
		local go = v:getMainGO()

		self._horizontalPoleObjectPool:returnObject(go)
	end
end

function DivinexjClgGameMainView:_playEffect(index)
	local parentGo = self._effectList[index]
	local uiEffect = UIEffectManager.instance:playEffect(self, DivinexjClgGameMainViewPresentor.EffectPath, parentGo.transform, 0, 0, false, false)

	uiEffect:setParent(parentGo.transform)
	uiEffect:setLocalPos(0, 0, 0)
	uiEffect:setScale(1)
end

return DivinexjClgGameMainView
