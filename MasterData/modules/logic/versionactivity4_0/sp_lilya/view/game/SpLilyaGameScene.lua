-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/view/game/SpLilyaGameScene.lua

module("modules.logic.versionactivity4_0.sp_lilya.view.game.SpLilyaGameScene", package.seeall)

local SpLilyaGameScene = class("SpLilyaGameScene", BaseView)

function SpLilyaGameScene:onInitView()
	self._gosceneRoot = gohelper.findChild(self.viewGO, "root/#go_sceneRoot")
	self._gobarRoot = gohelper.findChild(self.viewGO, "root/#go_barRoot")
	self._goaimRoot = gohelper.findChild(self.viewGO, "root/#go_aimRoot")
	self._godamageRoot = gohelper.findChild(self.viewGO, "root/#go_damageRoot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SpLilyaGameScene:addEvents()
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyCreate, self._onEnemyCreate, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyDestroy, self._onEnemyDestroy, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyMove, self._onEnemyMove, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyStateChange, self._onEnemyStateChange, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyLifeChange, self._onEnemyLifeChange, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyAimChange, self._onEnemyAimChange, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletCreate, self._onBulletCreate, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletExplode, self._onBulletExplode, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletDestroy, self._onBulletDestroy, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletMove, self._onBulletMove, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self.addEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.DamageNumUpdate, self._onDamageNum, self)
end

function SpLilyaGameScene:removeEvents()
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyCreate, self._onEnemyCreate, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyDestroy, self._onEnemyDestroy, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyMove, self._onEnemyMove, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyStateChange, self._onEnemyStateChange, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyLifeChange, self._onEnemyLifeChange, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.EnemyAimChange, self._onEnemyAimChange, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletCreate, self._onBulletCreate, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletExplode, self._onBulletExplode, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletDestroy, self._onBulletDestroy, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.BulletMove, self._onBulletMove, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.GameReset, self._onGameReset, self)
	self.removeEventCb(self, SpLilyaGameController.instance, SpLilyaEvent.DamageNumUpdate, self._onDamageNum, self)
end

function SpLilyaGameScene:_onEnemyCreate(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		self:_addEnemyItem(mo)
	end
end

function SpLilyaGameScene:_onEnemyDestroy(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		self:_recycleEnemyItem(mo)
	end

	self:_resolveBarOverlaps()
end

function SpLilyaGameScene:_onEnemyMove(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		local item = self:_findEnemyItem(mo)

		if item then
			item:setPos(mo.posX, mo.posY)
		end
	end
end

function SpLilyaGameScene:_onEnemyStateChange(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		local item = self:_findEnemyItem(mo)

		if item then
			item:setState(mo.state)
		end
	end
end

function SpLilyaGameScene:_onEnemyLifeChange(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		local item = self:_findEnemyItem(mo)

		if item then
			item:setLife(mo.curLife, mo.life)
		end
	end
end

function SpLilyaGameScene:_onEnemyAimChange(aimAddedList, aimRemovedList)
	for _, mo in ipairs(aimAddedList or {}) do
		local item = self:_findEnemyItem(mo)

		if item then
			item:setAimState(true)
		end
	end

	for _, mo in ipairs(aimRemovedList or {}) do
		local item = self:_findEnemyItem(mo)

		if item then
			item:setAimState(false)
		end
	end
end

function SpLilyaGameScene:_onBulletCreate(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		self:_addBulletItem(mo)
	end
end

function SpLilyaGameScene:_onBulletExplode(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		local item = self:_findBulletItem(mo)
		local boomType = mo.explodeReason == SpLilyaEnum.ExplodeReason.CollisionHit and 2 or 1
		local boomItem = self:_getBoomFromPool(boomType)

		if boomItem then
			local boomGo = boomItem.go

			transformhelper.setLocalPos(boomGo.transform, mo.posX, mo.posY, 0)

			if not mo.explodeRadius then
				local explodeRadius = 0
				local effectW = SpLilyaEnum.BulletEffectSize.Width
				local effectH = SpLilyaEnum.BulletEffectSize.Height

				if effectW > 0 then
					if not (explodeRadius * 2 / effectW) then
						local scaleX = 1

						if effectH > 0 then
							if not (explodeRadius * 2 / effectH) then
								local scaleY = 1

								transformhelper.setLocalScale(boomGo.transform, scaleX, scaleY, 1)
								gohelper.setActive(boomGo, true)

								if item then
									item:setExplodeState(true)

									item._activeBoom = boomItem
								else
									TaskDispatcher.runDelay(function()
										self:_recycleBoom(boomItem)
									end, nil, SpLilyaEnum.BulletExplodeDelayTime)
								end
							end
						end
					end
				end
			end
		end
	end
end

function SpLilyaGameScene:_onBulletDestroy(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		self:_recycleBulletItem(mo)
	end
end

function SpLilyaGameScene:_onBulletMove(moList)
	if not moList or #moList <= 0 then
		return
	end

	for _, mo in ipairs(moList) do
		local item = self:_findBulletItem(mo)

		if item then
			item:setPos(mo.posX, mo.posY)
			item:setRotation(mo.rotationZ)
		end
	end
end

function SpLilyaGameScene:_onGameReset()
	if not self._useEnemyItemDic then
		return
	end

	for _, item in pairs(self._useEnemyItemDic) do
		self:_recycleItemSpine(item)
		item:hide()
		table.insert(self._unuseEnemyItemList, item)

		self._unuseEnemyCount = self._unuseEnemyCount + 1
	end

	self._useEnemyItemDic = {}
	self._useEnemyItemList = {}

	for _, item in pairs(self._useBulletItemDic) do
		if item._activeBoom then
			gohelper.setActive(item._activeBoom.go, false)
			self:_recycleBoom(item._activeBoom)

			item._activeBoom = nil
		end

		item:hide()
		table.insert(self._unuseBulletItemList, item)

		self._unuseBulletCount = self._unuseBulletCount + 1
	end

	self._useBulletItemDic = {}
	self._useBulletItemList = {}

	self:_clearAllDamageNum()
	self:initEntity()
end

function SpLilyaGameScene:_addEnemyItem(mo)
	local item

	if self._unuseEnemyCount > 0 then
		item = table.remove(self._unuseEnemyItemList)
		self._unuseEnemyCount = self._unuseEnemyCount - 1
	else
		item = self:_createEnemy()

		if not item then
			return
		end
	end

	item.moUid = mo.uid
	item.mo = mo

	item:resetBarLift()

	local aimDic = SpLilyaGameSceneMgr.instance:getAimDic()

	item:setAimState(aimDic ~= nil and aimDic[mo.uid] ~= nil)
	item:setState(mo.state)
	item:setBarOffset(mo.radius)
	item:setPos(mo.posX, mo.posY)
	item:show()
	item:setLife(mo.curLife, mo.life)
	table.insert(self._useEnemyItemList, item)

	self._useEnemyItemDic[mo.uid] = item

	self:_setEnemySpine(item, mo.res)
end

function SpLilyaGameScene:_createEnemy()
	local enemyGo = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gosceneRoot)
	local barGo = self:getResInst(self.viewContainer._viewSetting.otherRes[4], self._gobarRoot)
	local aimGo = self:getResInst(self.viewContainer._viewSetting.otherRes[5], self._goaimRoot)
	local enemyItem = MonoHelper.addNoUpdateLuaComOnceToGo(enemyGo, SpLilyaEnemyEntity)

	enemyItem:attachBarAndAim(barGo, aimGo)

	local hitController = self.viewContainer:getRes(self.viewContainer._viewSetting.otherRes[8])

	if hitController then
		enemyItem:attachHitAnimator(hitController)
	end

	return enemyItem
end

function SpLilyaGameScene:_findEnemyItem(mo)
	return self._useEnemyItemDic[mo.uid]
end

function SpLilyaGameScene:_recycleEnemyItem(mo)
	local item = self._useEnemyItemDic[mo.uid]

	if not item then
		return
	end

	self._useEnemyItemDic[mo.uid] = nil

	self:_recycleItemSpine(item)
	item:hide()
	table.insert(self._unuseEnemyItemList, item)

	self._unuseEnemyCount = self._unuseEnemyCount + 1
end

function SpLilyaGameScene:_setEnemySpine(item, res)
	if string.nilorempty(res) then
		return
	end

	if item:isCurSpine(res) then
		item:resumeSpine()

		return
	end

	self:_recycleItemSpine(item)

	local spineGO = self:_getSpineFromPool(res)

	if spineGO then
		item:setSpine(spineGO, res)

		return
	end

	self:_loadEnemySpine(item, res)
end

function SpLilyaGameScene:_loadEnemySpine(item, res)
	self._loader = self._loader or LoaderComponent.New()

	local resPath = string.format(SpLilyaEnum.EnemySpineResPath, res)

	self._loader:loadAsset(resPath, self._onEnemySpineLoaded, self, self._onEnemySpineLoadFail, {
		item = item,
		res = res,
		moUid = item.moUid
	})
end

function SpLilyaGameScene:_onEnemySpineLoaded(assetItem, params)
	local item = params and params.item
	local res = params and params.res

	if not item or gohelper.isNil(item.go) then
		return
	end

	local resPath = string.format(SpLilyaEnum.EnemySpineResPath, res)
	local prefab = assetItem:GetResource(resPath)

	if not prefab then
		logError(string.format("SpLilyaGameScene:_onEnemySpineLoaded error, res:%s prefab is nil", tostring(res)))

		return
	end

	local spineGO = gohelper.clone(prefab, self._gosceneRoot)

	if self._useEnemyItemDic[params.moUid] ~= item or item:isCurSpine(res) then
		self:_recycleSpine(res, spineGO)

		return
	end

	item:setSpine(spineGO, res)
end

function SpLilyaGameScene:_onEnemySpineLoadFail(resPath, params)
	logError(string.format("SpLilyaGameScene:_onEnemySpineLoadFail, resPath:%s, res:%s", tostring(resPath), tostring(params and params.res)))
end

function SpLilyaGameScene:_getSpineFromPool(res)
	local list = self._unUseSpineListDic[res]

	if list and #list > 0 then
		return table.remove(list)
	end
end

function SpLilyaGameScene:_recycleSpine(res, spineGO)
	if not res or not spineGO or gohelper.isNil(spineGO) then
		return
	end

	gohelper.setActive(spineGO, false)
	gohelper.setParent(spineGO, self._gosceneRoot, false)
	transformhelper.setLocalPos(spineGO.transform, 0, 0, 0)

	local list = GameUtil.tabletool_checkDictTable(self._unUseSpineListDic, res)

	table.insert(list, spineGO)
end

function SpLilyaGameScene:_recycleItemSpine(item)
	local spineGO, res = item:removeSpine()

	if spineGO then
		self:_recycleSpine(res, spineGO)
	end
end

function SpLilyaGameScene:_resolveBarOverlaps()
	if not SpLilyaEnum.isHPMove then
		return
	end

	if not self._useEnemyItemDic then
		return
	end

	local bars = self._resolveBarList
	local barCount = 0

	for _, item in pairs(self._useEnemyItemDic) do
		barCount = barCount + 1
		bars[barCount] = item
	end

	for i = #bars, barCount + 1, -1 do
		bars[i] = nil
	end

	if barCount <= 1 then
		if barCount == 1 then
			bars[1]:setBarLiftLevel(0)
		end

		return
	end

	table.sort(bars, function(a, b)
		return a.moUid < b.moUid
	end)

	local step = SpLilyaEnum.EnemyBarLiftStep
	local maxLevel = SpLilyaEnum.EnemyBarLiftMaxLevel
	local placed = self._placedBarRects
	local placedCount = 0

	for i = 1, barCount do
		local item = bars[i]
		local x, y = item:getBarBasePos()
		local hw, hh = item:getBarHalfSize()
		local level = 0

		while level < maxLevel do
			local y2 = y + level * step
			local overlap = false

			for j = 1, placedCount, 4 do
				if math.abs(x - placed[j]) < hw + placed[j + 2] and math.abs(y2 - placed[j + 1]) < hh + placed[j + 3] then
					overlap = true

					break
				end
			end

			if not overlap then
				break
			end

			level = level + 1
		end

		local curLevel = item:getBarLiftLevel()

		if level < curLevel then
			level = math.max(level, curLevel - 1)
		end

		placedCount = placedCount + 4
		placed[placedCount - 3] = x
		placed[placedCount - 2] = y + level * step
		placed[placedCount - 1] = hw
		placed[placedCount] = hh

		item:setBarLiftLevel(level)
	end
end

function SpLilyaGameScene:_barOverlapTick()
	self:_resolveBarOverlaps()
	TaskDispatcher.cancelTask(self._barOverlapTick, self)
	TaskDispatcher.runDelay(self._barOverlapTick, self, 0.2)
end

function SpLilyaGameScene:_addBulletItem(mo)
	local bulletDic = SpLilyaGameSceneMgr.instance:getBulletDic()

	if not bulletDic or not bulletDic[mo.uid] then
		return
	end

	local item

	if self._unuseBulletCount > 0 then
		item = table.remove(self._unuseBulletItemList)
		self._unuseBulletCount = self._unuseBulletCount - 1
	else
		item = self:_createBullet()

		if not item then
			return
		end
	end

	item.moUid = mo.uid

	item:setPos(mo.posX, mo.posY)
	item:setRotation(mo.rotationZ)
	item:setRadius(mo.radius)
	item:setExplodeRadius(mo.explodeRadius)
	item:setExplodeState(mo.dying == true)
	item:show()
	table.insert(self._useBulletItemList, item)

	self._useBulletItemDic[mo.uid] = item
end

function SpLilyaGameScene:_createBullet()
	local bulletGo = self:getResInst(self.viewContainer._viewSetting.otherRes[3], self._gosceneRoot)

	if not SpLilyaEnum.BulletScale then
		transformhelper.setLocalScale(bulletGo.transform, SpLilyaEnum.BulletScale, SpLilyaEnum.BulletScale, 1)

		return (MonoHelper.addNoUpdateLuaComOnceToGo(bulletGo, SpLilyaBulletEntity))
	end
end

function SpLilyaGameScene:_findBulletItem(mo)
	return self._useBulletItemDic[mo.uid]
end

function SpLilyaGameScene:_recycleBulletItem(mo)
	local item = self._useBulletItemDic[mo.uid]

	if not item then
		return
	end

	self._useBulletItemDic[mo.uid] = nil

	if item._activeBoom then
		gohelper.setActive(item._activeBoom.go, false)
		self:_recycleBoom(item._activeBoom)

		item._activeBoom = nil
	end

	item:hide()
	table.insert(self._unuseBulletItemList, item)

	self._unuseBulletCount = self._unuseBulletCount + 1
end

function SpLilyaGameScene:_getBoomFromPool(boomType)
	local pool = self._boomPool[boomType]

	if not pool then
		return nil
	end

	local boomGo

	if #pool > 0 then
		boomGo = table.remove(pool)
	else
		local resIndex = boomType == 2 and 7 or 6

		boomGo = self:getResInst(self.viewContainer._viewSetting.otherRes[resIndex], self._gosceneRoot)
	end

	gohelper.setActive(boomGo, false)
	transformhelper.setLocalPos(boomGo.transform, 0, 0, 0)
	transformhelper.setLocalScale(boomGo.transform, 1, 1, 1)

	return {
		go = boomGo,
		boomType = boomType
	}
end

function SpLilyaGameScene:_recycleBoom(boomItem)
	if not boomItem or not boomItem.go or gohelper.isNil(boomItem.go) then
		return
	end

	local pool = self._boomPool[boomItem.boomType]

	if pool then
		table.insert(pool, boomItem.go)
	end
end

function SpLilyaGameScene:_onDamageNum(damage, posX, posY, isPlayer, enemyUid)
	if not damage or damage <= 0 then
		return
	end

	local item = self:_getDamageNum()

	if not item then
		return
	end

	if item.txt then
		item.txt.text = tostring(math.floor(damage))
	end

	if isPlayer then
		if not SpLilyaEnum.DamageNumScale.Player then
			local scale = SpLilyaEnum.DamageNumScale.Enemy

			transformhelper.setLocalScale(item.go.transform, scale, scale, 1)

			local displayY = posY

			if isPlayer then
				displayY = posY + SpLilyaEnum.PlayerDamageNumOffsetY
			else
				local enemyItem = self._useEnemyItemDic[enemyUid]

				if enemyItem then
					local headOffsetY = enemyItem:_getBarOffsetY()

					displayY = posY + headOffsetY
				end
			end

			local samePosCount = 0

			for _, activeItem in pairs(self._useDamageNumDic) do
				if activeItem and activeItem ~= item then
					if not activeItem.basePosX then
						if not activeItem.basePosY then
							local baseY = 0

							if math.abs(activeItem.basePosX - posX) < 30 and math.abs(baseY - displayY) < 30 then
								samePosCount = samePosCount + 1
							end
						end
					end
				end
			end

			local offsetY = samePosCount * 30

			item.basePosX = posX
			item.basePosY = displayY

			transformhelper.setLocalPos(item.go.transform, posX, displayY + offsetY, 0)

			if item.canvasGroup then
				item.canvasGroup.alpha = 1
			end

			gohelper.setActive(item.go, true)

			local animTime = SpLilyaEnum.DamageNumTime
			local startY = displayY + offsetY
			local targetY = startY + 50

			item.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, animTime, self._onDamageNumUpdate, self._onDamageNumFinish, self, {
				item = item,
				startY = startY,
				endY = targetY
			})
		end
	end
end

function SpLilyaGameScene:_onDamageNumUpdate(t, params)
	local item = params.item

	if not item or not item.go or gohelper.isNil(item.go) then
		return
	end

	local y = params.startY + (params.endY - params.startY) * t
	local curX = item.go.transform.localPosition.x

	transformhelper.setLocalPos(item.go.transform, curX, y, 0)

	if item.canvasGroup then
		item.canvasGroup.alpha = 1 - t
	end
end

function SpLilyaGameScene:_onDamageNumFinish(params)
	local item = params and params.item

	if not item then
		return
	end

	self:_recycleDamageNum(item)
end

function SpLilyaGameScene:_getDamageNum()
	local item = #self._unuseDamageNumList > 0 and table.remove(self._unuseDamageNumList) or self:_createDamageNum()

	if not item then
		return nil
	end

	self._damageNumUid = self._damageNumUid + 1
	item.uid = self._damageNumUid
	self._useDamageNumDic[item.uid] = item

	return item
end

function SpLilyaGameScene:_createDamageNum()
	local damageGo = self:getResInst(self.viewContainer._viewSetting.otherRes[9], self._godamageRoot)

	if not damageGo then
		return nil
	end

	local txt = gohelper.findChildText(damageGo, "total_damage/x/txtNum1")
	local canvasGroup = gohelper.onceAddComponent(damageGo, gohelper.Type_CanvasGroup)

	gohelper.setActive(damageGo, false)

	return {
		uid = 0,
		go = damageGo,
		txt = txt,
		canvasGroup = canvasGroup
	}
end

function SpLilyaGameScene:_recycleDamageNum(item)
	if not item then
		return
	end

	if item.tweenId then
		ZProj.TweenHelper.KillById(item.tweenId, false)

		item.tweenId = nil
	end

	self._useDamageNumDic[item.uid] = nil

	gohelper.setActive(item.go, false)
	table.insert(self._unuseDamageNumList, item)
end

function SpLilyaGameScene:_clearAllDamageNum()
	for uid, item in pairs(self._useDamageNumDic) do
		if item then
			if item.tweenId then
				ZProj.TweenHelper.KillById(item.tweenId, false)

				item.tweenId = nil
			end

			gohelper.setActive(item.go, false)
			table.insert(self._unuseDamageNumList, item)
		end
	end

	self._useDamageNumDic = {}
end

function SpLilyaGameScene:_editableInitView()
	self._useEnemyItemList = {}
	self._useEnemyItemDic = {}
	self._unuseEnemyItemList = {}
	self._unuseEnemyCount = 0
	self._useBulletItemList = {}
	self._useBulletItemDic = {}
	self._unuseBulletItemList = {}
	self._unuseBulletCount = 0
	self._unUseSpineListDic = {}
	self._boomPool = {
		{},
		{}
	}
	self._useDamageNumDic = {}
	self._unuseDamageNumList = {}
	self._damageNumUid = 0
	self._resolveBarList = {}
	self._placedBarRects = {}
	self._gosceneRootWidth = recthelper.getWidth(self._gosceneRoot.transform)
	self._gosceneRootHeight = recthelper.getHeight(self._gosceneRoot.transform)

	SpLilyaGameController.instance:setSceneSize(self._gosceneRootWidth, self._gosceneRootHeight)

	local sceneMo = SpLilyaGameModel.instance:getGameMO() and SpLilyaGameModel.instance:getGameMO().sceneMo

	logWarn(string.format("[SpLilya] setSceneSize: width=%s, height=%s, halfWidth=%s, groundPosX=%s, enemyEndPosX=%s", tostring(self._gosceneRootWidth), tostring(self._gosceneRootHeight), tostring(sceneMo and sceneMo:getHalfWidth()), tostring(sceneMo and sceneMo.groundPosX), tostring(SpLilyaGameModel.instance:getGameMO() and SpLilyaGameModel.instance:getGameMO().enemyEndPosX)))

	if SpLilyaEnum.isHPMove then
		TaskDispatcher.cancelTask(self._barOverlapTick, self)
		TaskDispatcher.runDelay(self._barOverlapTick, self, 0.2)
	end

	if self._loader then
		self._loader:releaseSelf()

		self._loader = nil
	end
end

function SpLilyaGameScene:onUpdateParam()
	return
end

function SpLilyaGameScene:onOpen()
	self:initEntity()
end

function SpLilyaGameScene:initEntity()
	if not self._useEnemyItemDic then
		return
	end

	local enemyDic = SpLilyaGameSceneMgr.instance:getEnemyDic()

	if enemyDic then
		for _, mo in pairs(enemyDic) do
			if mo and not self._useEnemyItemDic[mo.uid] then
				self:_addEnemyItem(mo)
			end
		end
	end

	local bulletDic = SpLilyaGameSceneMgr.instance:getBulletDic()

	if bulletDic then
		for _, mo in pairs(bulletDic) do
			if mo and not self._useBulletItemDic[mo.uid] then
				self:_addBulletItem(mo)
			end
		end
	end
end

function SpLilyaGameScene:onClose()
	return
end

function SpLilyaGameScene:onDestroyView()
	TaskDispatcher.cancelTask(self._barOverlapTick, self)

	if self._loader then
		self._loader:releaseSelf()

		self._loader = nil
	end

	self._unUseSpineListDic = nil
	self._boomPool = nil

	self:_clearAllDamageNum()

	self._useDamageNumDic = nil
	self._unuseDamageNumList = nil
end

return SpLilyaGameScene
