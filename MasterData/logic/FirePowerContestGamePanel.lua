-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/game/FirePowerContestGamePanel.lua

module("logic.extensions.firepowercontest.game.FirePowerContestGamePanel", package.seeall)

local FirePowerContestGamePanel = class("FirePowerContestGamePanel")

function FirePowerContestGamePanel:ctor(mainGo, pool, view, bMine)
	self._mainGo = mainGo
	self._pool = pool
	self._view = view
	self._bMine = bMine

	self:_initRes()
	self:_initData()
end

function FirePowerContestGamePanel:_initRes()
	self._itemContainer = goutil.findChild(self._mainGo, "itemContainer")
	self._imgBulletTag = goutil.findChild(self._mainGo, "imgBulletTag")
	self._launchPoint = goutil.findChild(self._mainGo, "launchPoint")
	self._txtScore = goutil.findChildTextComponent(self._mainGo, "txtScore")
	self._txtPopup = goutil.findChildTextComponent(self._mainGo, "txtPopup")
	self._txtLevel = goutil.findChildTextComponent(self._mainGo, "level/txtLevel")
	self._perfect = goutil.findChild(self._mainGo, "prefect")
	self._perfectPos = GameUtil.getLocalPos(self._perfect)
	self._popGo = goutil.findChild(self._mainGo, "pop")
	self._txtPopup = goutil.findChildTextComponent(self._popGo, "txtPopup")
	self._imgIcon = goutil.findChild(self._mainGo, "imgIcon")
	self._bg = goutil.findChild(self._mainGo, "bg")

	goutil.setActive(self._bg, false)

	self._bulletCounters = {}
	self._bulletCounterCell = goutil.findChild(self._mainGo, "imgBulletTag/bulletCell")

	goutil.setActive(self._bulletCounterCell, false)

	self._containerWidth = GameUtil.getWidth(self._itemContainer)
	self._containerHeight = GameUtil.getHeight(self._itemContainer)
	self._halfContainerWidth = self._containerWidth * 0.5
	self._halfContainerHeight = self._containerWidth * 0.5

	local mainWidth = GameUtil.getWidth(self._mainGo)
	local mainHeight = GameUtil.getHeight(self._mainGo)
	local halfMainWidth = mainWidth * 0.5
	local halfMainHeight = mainHeight * 0.5

	self._mainGoTransform = self._mainGo:GetComponent("RectTransform")
	self._itemContainerTransform = self._itemContainer:GetComponent("RectTransform")

	local uiCamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
	local pos = goutil.screenToLocalPos(uiCamera:WorldToScreenPoint(GameUtil.getPos(self._mainGo)), self._itemContainerTransform)

	self._bounds = UnityEngine.Rect.New(pos.x - halfMainWidth, pos.y - halfMainHeight, mainWidth, mainHeight)
	self._launchPos = goutil.screenToLocalPos(uiCamera:WorldToScreenPoint(GameUtil.getPos(self._launchPoint)), self._itemContainerTransform)
	self._launchPos = Vector3.New(self._launchPos.x, self._launchPos.y, 0)
end

function FirePowerContestGamePanel:_initData()
	self._bulletCells = {}
	self._bullet2Infos = {}
	self._itemCells = {}
	self._item2Infos = {}
	self._data = FirePowerContestModel.instance.handler.data
	self._mapInfo = {}
	self._bLeaveGame = false
	self._hasStart = false
	self._comboAnim = {}
	self._addScoreAnim = {}
	self._effectMaps = {}
	self._lastDelta = 0
	self._bRoundDone = false
	self._launchLock = false
end

function FirePowerContestGamePanel:_clearShowPerfectTween()
	return
end

function FirePowerContestGamePanel:lock()
	if not self._launchLock then
		self._launchLock = true

		self:resetMap()
	end
end

function FirePowerContestGamePanel:resetMap()
	self:_clearShowPerfectTween()
	self:hidePopMsg()
	goutil.setActive(self._perfect, false)

	for i = #self._bulletCells, 1, -1 do
		self:_destroyBullet(self._bulletCells[i])
	end

	for i = #self._itemCells, 1, -1 do
		self:_destroyItem(self._itemCells[i])
	end

	for combo, _ in pairs(self._comboAnim) do
		self:_destroyCombo(combo)
	end

	for addScore, _ in pairs(self._addScoreAnim) do
		self:_destroyAddScore(addScore)
	end

	for effectContainer, _ in pairs(self._effectMaps) do
		self:_destroyEffect(effectContainer)
	end

	self._bulletCells = {}
	self._itemCells = {}
	self._comboAnim = {}
	self._addScoreAnim = {}
	self._effectMaps = {}
end

function FirePowerContestGamePanel:setBg()
	self._txtLevel.text = langPara("FirePowerContestGamePanel__2", self._data.curStage, self._data.maxStage)

	goutil.setActive(self._bg, true)

	local bgName = FirePowerContestConfig.instance:getInteractiveBg(self._data.gameStageConf.pathType)

	uGuiUtil.clearImage(self._bg)
	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("firepowercontest", bgName))
end

function FirePowerContestGamePanel:reset()
	self._strategy = FPC_MoveStrategyFactory.getStrategy()

	local pathConfig = self._data.pathConfig

	self._mapInfo.gridSize = math.min(self._containerWidth / pathConfig.x, self._containerHeight / pathConfig.y)
	self._mapInfo.anchorPos = Vector2.New(-self._mapInfo.gridSize * pathConfig.x * 0.5, self._mapInfo.gridSize * pathConfig.y * 0.5)
	self._mapInfo.curStage = self._data.curStage
	self._lastDelta = 0

	self:resetMap()
	self:setBg()
	self:updateBulletCount(self._data.gameStageConf.bulletNum)

	if not self._bLeaveGame then
		self:hidePopMsg()

		local itemInfoByPosId = self._data.itemInfoByPosId

		for _, itemInfo in pairs(itemInfoByPosId) do
			local item, colliderRange, effectUrl = self:_createItem(itemInfo.itemId)
			local itemConf = FirePowerContestConfig.instance:getItemConf(itemInfo.itemId)
			local beginGrid = self._data:getNodeData(itemInfo.posId)
			local endGrid = self._data:getTargetGrid(beginGrid)

			table.insert(self._itemCells, item)

			self._item2Infos[item] = {
				item = item,
				posId = itemInfo.posId,
				score = itemConf.score,
				beginGrid = beginGrid,
				endGrid = endGrid,
				vertices = self:_createVertices(colliderRange),
				movePaths = {},
				effectUrl = effectUrl
			}
		end

		self:tick()
	else
		self:syncLeaveGame()
	end

	self._curStage = self._data.curStage
	self._bRoundDone = false
	self._launchLock = false
	self._hasStart = true
end

function FirePowerContestGamePanel:dispose()
	self:resetMap()

	for _, bullet in ipairs(self._bulletCounters) do
		goutil.destroy(bullet)
	end

	self._bulletCounters = {}

	uGuiUtil.clearImage(self._bg)
end

function FirePowerContestGamePanel:tick()
	if not self._bLeaveGame and self._hasStart and not self._launchLock then
		if self._curStage ~= nil and self._curStage == self._data.curStage then
			self:_updateMove()
			self:_checkHit()
			self:_checkBulletOutOfBounds()
			self:_checkEnd()
		else
			print(string.format(".............................................stage has changed self._curStage=%s, self._data.curStage", tostring(self._curStage), tostring(self._data.curStage)))
		end
	end
end

function FirePowerContestGamePanel:_checkEnd()
	if not self._bRoundDone and #self._itemCells == 0 and not self._launchLock then
		self._bRoundDone = true

		self:_flyPerfect()
	end
end

function FirePowerContestGamePanel:getComboScores(hitCounter)
	for i = 1, #self._data.continueHitScore do
		if hitCounter >= self._data.continueHitScore[i].hit then
			return self._data.continueHitScore[i].score
		end
	end

	return 0
end

function FirePowerContestGamePanel:handleOneHit(bulletId, posId, itemInfo, bulletInfo)
	if not self._bLeaveGame then
		itemInfo = itemInfo or self:_searchItemInfo(posId)
		bulletInfo = bulletInfo or self:_searchBulletInfo(bulletId)

		local comboScore = 0

		if bulletInfo then
			bulletInfo.hitCounter = (bulletInfo.hitCounter or 0) + 1
			comboScore = self:getComboScores(bulletInfo.hitCounter) or comboScore
		end

		if itemInfo then
			local itemScore = itemInfo.score

			self:_flyItemScore(itemScore, itemInfo)
			self:_flyComboScore(comboScore, itemInfo)
		end
	end
end

local BulletColliderRange = {
	8,
	8,
	0,
	0
}

function FirePowerContestGamePanel:launchBullet(angle, bulletId, launchTimes)
	if not self._bLeaveGame then
		local bullet = self:_createBullet()
		local effectUrl = self._data.activityConf.bulletPath

		effectUrl = FirePowerContestConfig.instance:getEffectUrl(effectUrl)

		local eff = UIEffectManager.instance:playEffect(self._view, effectUrl, bullet.transform, 0, 0, true)

		eff:setParent(bullet.transform)
		eff:setScale(1)
		eff:setLocalPos(0, 0, 0)

		local rad = math.rad(angle)
		local x = math.cos(rad)
		local y = math.sin(rad)
		local speed = Vector3.New(x, y, 0):SetNormalize() * ((not self._data.activityConf.bulletSpeed or nil) and FirePowerContestConfig.BulletSpeed) / FirePowerContestConfig.SpeedZoom
		local delta = UnityEngine.Time.realtimeSinceStartup * 1000 - (launchTimes + self._data.startTimeClient)
		local delta2SpeedZoom = delta / FirePowerContestConfig.tickMs
		local beginPos = Vector3.New(self._launchPos.x, self._launchPos.y, 0)
		local targetPos = beginPos + speed * delta2SpeedZoom

		GameUtil.setLocalPos(bullet, targetPos.x, targetPos.y, 0)
		GameUtil.setLocalRotation(self._imgIcon, 0, 0, angle - 90)
		table.insert(self._bulletCells, bullet)

		self._bullet2Infos[bullet] = {
			bDestroying = false,
			hitCounter = 0,
			bulletId = bulletId,
			bullet = bullet,
			speed = speed,
			vertices = self:_createVertices(BulletColliderRange, rad),
			movePaths = {},
			effect = eff
		}

		local launchEffectUrl = self._data.activityConf.bulletEffectPath
		local launchEffectContainer = self._pool:createFromPool(FirePowerContestPool.Effect, self._itemContainer.transform)

		GameUtil.setLocalPos(launchEffectContainer, self._launchPos.x, self._launchPos.y, 0)

		launchEffectUrl = FirePowerContestConfig.instance:getEffectUrl(launchEffectUrl)

		local launchEffect = UIEffectManager.instance:playEffect(self._view, launchEffectUrl, launchEffectContainer.transform, 0, 0, false, nil, GameUtil.handler(function()
			self:_destroyEffect(launchEffectContainer)
		end, self))

		launchEffect:setParent(launchEffectContainer.transform)
		launchEffect:setScale(1)
		launchEffect:setLocalPos(0, 0, 0)

		self._effectMaps[launchEffectContainer] = launchEffect

		if self._bMine then
			self:updateBulletCount(self._data.bulletCount)
		else
			self._data:useRivalBullet()
			self:updateBulletCount(self._data.rivalBulletCount)
		end
	end
end

function FirePowerContestGamePanel:_checkHit()
	for _, bulletInfo in pairs(self._bullet2Infos) do
		for _, itemInfo in pairs(self._item2Infos) do
			if not itemInfo.bDestroying and self:_checkOverlap(bulletInfo, itemInfo) then
				self:handleOneHit(bulletInfo.bulletId, itemInfo.posId, itemInfo, bulletInfo)

				break
			end
		end
	end

	for _, bulletInfo in pairs(self._bullet2Infos) do
		bulletInfo.movePaths = {}
	end

	for _, itemInfo in pairs(self._item2Infos) do
		itemInfo.movePaths = {}
	end
end

function FirePowerContestGamePanel:_checkOverlap(bulletInfo, itemInfo)
	local map = {}

	for _, itemMovePath in ipairs(itemInfo.movePaths) do
		local itemVerts = {}

		for _, itemVert in ipairs(itemInfo.vertices) do
			table.insert(itemVerts, itemVert + itemMovePath)
		end

		for _, bulletMovePath in ipairs(bulletInfo.movePaths) do
			local bulletVerts = map[bulletInfo]

			if not bulletVerts then
				bulletVerts = {}

				for _, bulletInfoVert in pairs(bulletInfo.vertices) do
					table.insert(bulletVerts, bulletInfoVert + bulletMovePath)
				end
			end

			if ObbSAT.insect(itemVerts, bulletVerts) then
				return true
			end
		end
	end

	return false
end

function FirePowerContestGamePanel:_crossProduct(a, b1, b2)
	return (a.x - b1.x) * (b2.y - b1.y) - (b2.x - b1.x) * (a.y - b1.y)
end

function FirePowerContestGamePanel:_checkBulletOutOfBounds()
	local bottom = self._bounds.y

	for i = #self._bulletCells, 1, -1 do
		local bullet = self._bulletCells[i]
		local pos = GameUtil.getLocalPos(bullet)

		if bottom < pos.y and not self._bounds:Contains(pos) then
			self:_destroyBullet(bullet)
		end
	end
end

function FirePowerContestGamePanel:_updateMove()
	local delta = UnityEngine.Time.realtimeSinceStartup * 1000 - self._data.startTimeClient
	local delta2SpeedZoom = (delta - self._lastDelta) / FirePowerContestConfig.tickMs

	if self._strategy then
		self._strategy:simulateMove(delta / FirePowerContestConfig.tickMs, self._itemCells, self._item2Infos, self._mapInfo, true)
	end

	for _, bullet in ipairs(self._bulletCells) do
		local bulletInfo = self._bullet2Infos[bullet]
		local pos = GameUtil.getLocalPos(bullet)
		local targetPos = pos + bulletInfo.speed * delta2SpeedZoom

		GameUtil.setLocalPos(bullet, targetPos.x, targetPos.y, targetPos.z)
		goutil.setActive(bullet, self._bounds:Contains(targetPos))
		table.insert(bulletInfo.movePaths, targetPos)
	end

	self._lastDelta = delta
end

function FirePowerContestGamePanel:_searchItemInfo(posId)
	for _, v in pairs(self._item2Infos) do
		if v.posId == posId then
			return v
		end
	end
end

function FirePowerContestGamePanel:_searchBulletInfo(bulletId)
	for _, v in pairs(self._bullet2Infos) do
		if v.bulletId == bulletId then
			return v
		end
	end
end

function FirePowerContestGamePanel:_destroyItem(targetItem)
	if not goutil.isNil(targetItem) then
		table.removebyvalue(self._itemCells, targetItem)

		self._item2Infos[targetItem] = nil

		goutil.setActive(targetItem, false)
		uGuiUtil.clearImage(goutil.findChild(targetItem, "item"))
		self._pool:recover(FirePowerContestPool.Item, targetItem)
	end
end

function FirePowerContestGamePanel:_createItem(itemId)
	local item = self._pool:createFromPool(FirePowerContestPool.Item, self._itemContainer.transform)
	local itemConf = FirePowerContestConfig.instance:getItemConf(itemId)
	local innerItem = goutil.findChild(item, "item")

	uGuiUtil.clearImage(innerItem)
	uGuiUtil.setSpriteToImage(innerItem, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("firepowercontest", itemConf.resImg))

	return item, itemConf.colliderRange, itemConf.effect
end

function FirePowerContestGamePanel:_destroyBullet(targetItem)
	if not goutil.isNil(targetItem) then
		table.removebyvalue(self._bulletCells, targetItem)

		local effect = self._bullet2Infos[targetItem].effect

		UIEffectManager.instance:stopEffect(effect)

		self._bullet2Infos[targetItem] = nil

		self._pool:recover(FirePowerContestPool.Bullet, targetItem)
	end
end

function FirePowerContestGamePanel:_createBullet()
	return (self._pool:createFromPool(FirePowerContestPool.Bullet, self._itemContainer.transform))
end

function FirePowerContestGamePanel:_createCombo()
	return (self._pool:createFromPool(FirePowerContestPool.Combo, self._itemContainer.transform))
end

function FirePowerContestGamePanel:_destroyCombo(targetItem)
	if not goutil.isNil(targetItem) then
		local tween = self._comboAnim[targetItem]

		tween:Kill(false)

		self._comboAnim[targetItem] = nil

		GameUtil.setLocalScale(targetItem, 1)
		self._pool:recover(FirePowerContestPool.Combo, targetItem)
	end
end

function FirePowerContestGamePanel:_createAddScore()
	return (self._pool:createFromPool(FirePowerContestPool.AddScore, self._itemContainer.transform))
end

function FirePowerContestGamePanel:_destroyAddScore(targetItem)
	if not goutil.isNil(targetItem) then
		local tween = self._addScoreAnim[targetItem]

		tween:Kill(false)

		self._addScoreAnim[targetItem] = nil

		GameUtil.setLocalScale(targetItem, 1)
		self._pool:recover(FirePowerContestPool.AddScore, targetItem)
	end
end

function FirePowerContestGamePanel:_destroyEffect(targetItem)
	if not goutil.isNil(targetItem) then
		local effect = self._effectMaps[targetItem]

		UIEffectManager.instance:stopEffect(effect)

		self._effectMaps[targetItem] = nil

		self._pool:recover(FirePowerContestPool.Effect, targetItem)
	end
end

function FirePowerContestGamePanel:updateScoreCount(value)
	self._txtScore.text = langPara("FirePowerContestGamePanel__3", value)
end

function FirePowerContestGamePanel:updateBulletCount(value)
	local length = math.max(#self._bulletCounters, value)

	for i = length, 1, -1 do
		local bullet = self._bulletCounters[i]

		if not bullet then
			bullet = goutil.cloneAndSetParent(self._bulletCounterCell, self._imgBulletTag.transform)
			self._bulletCounters[i] = bullet

			local localPos = GameUtil.getLocalPos(bullet)
			local width = GameUtil.getWidth(bullet)

			GameUtil.setLocalPos(bullet, localPos.x - width * (i - 1), localPos.y, 0)
		end

		goutil.setActive(bullet, i <= value)
	end
end

function FirePowerContestGamePanel:syncHit(msg)
	if not self._bLeaveGame then
		self:handleOneHit(msg.bulletId, msg.posId)
	end
end

function FirePowerContestGamePanel:syncLeaveGame()
	self._bLeaveGame = true

	self:setPopMsg(lang("FirePowerContestGamePanel__1"))
end

function FirePowerContestGamePanel:setPopMsg(strContent)
	goutil.setActive(self._popGo, true)

	self._txtPopup.text = strContent
end

function FirePowerContestGamePanel:hidePopMsg()
	goutil.setActive(self._popGo, false)
end

function FirePowerContestGamePanel:_flyPerfect(callback)
	local effectUrl = "fx_ui_hyll_wm"
	local effectContainer = self._pool:createFromPool(FirePowerContestPool.Effect, self._itemContainer.transform)

	GameUtil.setLocalPos(effectContainer, self._perfectPos.x, self._perfectPos.y, self._perfectPos.z)

	effectUrl = FirePowerContestConfig.instance:getEffectUrl(effectUrl)

	local eff = UIEffectManager.instance:playEffect(self._view, effectUrl, effectContainer.transform, 0, 0, false, nil, GameUtil.handler(function()
		self:_destroyEffect(effectContainer)

		if callback then
			callback()
		end
	end, self))

	eff:setParent(effectContainer.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._effectMaps[effectContainer] = eff
end

function FirePowerContestGamePanel:_flyItemScore(value, itemInfo)
	local addScore = self:_createAddScore()
	local itemPos = GameUtil.getLocalPos(itemInfo.item)

	GameUtil.setLocalPos(addScore, itemPos.x + 30, itemPos.y + 20, 0)

	local effectUrl = itemInfo.effectUrl
	local effectContainer = self._pool:createFromPool(FirePowerContestPool.Effect, self._itemContainer.transform)

	GameUtil.setLocalPos(effectContainer, itemPos.x, itemPos.y, 0)

	effectUrl = FirePowerContestConfig.instance:getEffectUrl(effectUrl)

	local eff = UIEffectManager.instance:playEffect(self._view, effectUrl, effectContainer.transform, 0, 0, false, nil, GameUtil.handler(function()
		self:_destroyEffect(effectContainer)
	end, self))

	eff:setParent(effectContainer.transform)
	eff:setScale(1)
	eff:setLocalPos(0, 0, 0)

	self._effectMaps[effectContainer] = eff

	local txtAddScore = addScore:GetComponent("Text")

	txtAddScore.text = string.format("+%d", value)

	GameUtil.setLocalScale(addScore, 1)
	self:_destroyItem(itemInfo.item)

	self._addScoreAnim[addScore] = self:_doTween(addScore, 2, 1, function()
		self:_destroyAddScore(addScore)
	end)
end

function FirePowerContestGamePanel:_flyComboScore(value, itemInfo)
	if value > 0 then
		local itemPos = GameUtil.getLocalPos(itemInfo.item)
		local comboPos = Vector3.New(itemPos.x - 60, itemPos.y + 20, 0)
		local effectUrl = FirePowerContestConfig.ComboAnimUrls[tostring(value)]

		print("........................." .. tostring(value))
		print("......................" .. tostring(effectUrl))

		if not string.nilorempty(effectUrl) then
			local effectContainer = self._pool:createFromPool(FirePowerContestPool.Effect, self._itemContainer.transform)

			GameUtil.setLocalPos(effectContainer, comboPos.x, comboPos.y, comboPos.z)

			effectUrl = FirePowerContestConfig.instance:getEffectUrl(effectUrl)

			local eff = UIEffectManager.instance:playEffect(self._view, effectUrl, effectContainer.transform, 0, 0, false, nil, function()
				self:_destroyEffect(effectContainer)
			end, function(_, effT)
				return
			end, self)

			eff:setParent(effectContainer.transform)
			eff:setScale(1)
			eff:setLocalPos(0, 0, 0)

			self._effectMaps[effectContainer] = eff
		end
	end
end

function FirePowerContestGamePanel:_doTween(targetGo, endScale, duration, onCompleteCallback)
	local transform = targetGo.transform
	local s = DG.Tweening.DOTween.Sequence()

	s:Join(transform:DOScale(endScale, duration))
	s:OnComplete(function()
		if onCompleteCallback then
			onCompleteCallback()
		end
	end)

	return s
end

function FirePowerContestGamePanel:_createVertices(colliderRange, rad)
	local halfColliderRangeWidth = colliderRange[1] * 0.5
	local halfColliderRangeHeight = colliderRange[2] * 0.5
	local vertices = {
		Vector2.New(-halfColliderRangeWidth + colliderRange[3], -halfColliderRangeHeight + colliderRange[4]),
		Vector2.New(halfColliderRangeWidth + colliderRange[3], -halfColliderRangeHeight + colliderRange[4]),
		Vector2.New(halfColliderRangeWidth + colliderRange[3], halfColliderRangeHeight + colliderRange[4]),
		Vector2.New(-halfColliderRangeWidth + colliderRange[3], halfColliderRangeHeight + colliderRange[4])
	}

	if rad ~= nil then
		local cs = math.cos(rad)
		local sn = math.sin(rad)

		for i = 1, #vertices do
			local x = vertices[i].x
			local y = vertices[i].y

			vertices[i].x = x * cs - y * sn
			vertices[i].y = x * sn + y * cs
		end
	end

	return vertices
end

return FirePowerContestGamePanel
