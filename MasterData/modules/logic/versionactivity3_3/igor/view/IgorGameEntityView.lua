-- chunkname: @modules/logic/versionactivity3_3/igor/view/IgorGameEntityView.lua

module("modules.logic.versionactivity3_3.igor.view.IgorGameEntityView", package.seeall)

local IgorGameEntityView = class("IgorGameEntityView", BaseView)

function IgorGameEntityView:onInitView()
	self.goPool = gohelper.findChild(self.viewGO, "root/pool")
	self.entityCloneDict = {}
	self.entityCloneDict[IgorEnum.SoldierType.Infantry] = gohelper.findChild(self.goPool, "infantryItem")
	self.entityCloneDict[IgorEnum.SoldierType.Cavalry] = gohelper.findChild(self.goPool, "cavalryItem")
	self.entityCloneDict[IgorEnum.SoldierType.Artillery] = gohelper.findChild(self.goPool, "artilleryItem")
	self.entityCloneDict[IgorEnum.SoldierType.Chariot] = gohelper.findChild(self.goPool, "chariotItem")

	gohelper.setActive(self.goPool, false)

	self.goOutsideRoot = gohelper.findChild(self.viewGO, "root/entity/ourside")
	self.goEnemyRoot = gohelper.findChild(self.viewGO, "root/entity/enemy")
	self.ourSideBase = gohelper.findChild(self.viewGO, "root/entity/base/oursideBase")
	self.enemyBase = gohelper.findChild(self.viewGO, "root/entity/base/enemyBase")
	self.goHpRoot = gohelper.findChild(self.viewGO, "root/info/hpInfo")
	self.goOursideHp = gohelper.findChild(self.goHpRoot, "ourside")
	self.goEnemyHp = gohelper.findChild(self.goHpRoot, "enemy")

	local goEntityArea = gohelper.findChild(self.viewGO, "root/entity/entityArea")

	self.entityArea = goEntityArea.transform

	if self._editableInitView then
		self:_editableInitView()
	end
end

function IgorGameEntityView:addEvents()
	self.addEventCb(self, IgorController.instance, IgorEvent.OnEntityAdd, self.onEntityAdd, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnEntityDel, self.onEntityDel, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnEntityHpChange, self.onEntityHpChange, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameFrameUpdate, self.onGameFrameUpdate, self)
	self.addEventCb(self, IgorController.instance, IgorEvent.OnGameReset, self.onGameReset, self)
	self.addEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function IgorGameEntityView:removeEvents()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnEntityAdd, self.onEntityAdd, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnEntityDel, self.onEntityDel, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnEntityHpChange, self.onEntityHpChange, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameFrameUpdate, self.onGameFrameUpdate, self)
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnGameReset, self.onGameReset, self)
	self.removeEventCb(self, GameGlobalMgr.instance, GameStateEvent.OnScreenResize, self._onScreenSizeChange, self)
end

function IgorGameEntityView:onEntityHpChange(mo)
	if mo.type == IgorEnum.SoldierType.Base then
		if mo.campType == IgorEnum.CampType.Ourside then
			self.ourSideHpComp:refreshHp(true)
		else
			self.enemyHpComp:refreshHp(true)
		end
	else
		local entity = self:getSoldierByMo(mo)

		if entity then
			entity:refreshHp(true)
		end
	end
end

function IgorGameEntityView:_onScreenSizeChange()
	self:initPos()
end

function IgorGameEntityView:onEntityAdd(mo)
	self:createSoldier(mo)
end

function IgorGameEntityView:onEntityDel(mo)
	self:delSoldier(mo)
end

function IgorGameEntityView:onGameFrameUpdate(deltaTime)
	for _, entitydict in pairs(self.soldierItemDict) do
		for _, entity in pairs(entitydict) do
			entity:onUpdate(deltaTime)
		end
	end

	if self.ourSideHpComp then
		self.ourSideHpComp:onUpdate(deltaTime)
	end

	if self.enemyHpComp then
		self.enemyHpComp:onUpdate(deltaTime)
	end
end

function IgorGameEntityView:onGameReset()
	self:initGame()
end

function IgorGameEntityView:onOpen()
	return
end

function IgorGameEntityView:initGame()
	if self.soldierItemDict then
		for _, entitydict in pairs(self.soldierItemDict) do
			for _, entity in pairs(entitydict) do
				local pool = self:getSoldierPool(entity.soldierType)

				entity:onRelease()
				pool:putObject(entity.go)
			end
		end
	end

	self.soldierItemDict = {}

	for _, campType in pairs(IgorEnum.CampType) do
		self.soldierItemDict[campType] = {}
	end

	self:initPos()
	self:initCampBase()
	self:initTempEntity()
end

function IgorGameEntityView:initPos()
	local campWidth = 200
	local oursidePosX, oursidePosY = recthelper.uiPosToScreenPos2(self.ourSideBase.transform)
	local enemyPosX, enemyPosY = recthelper.uiPosToScreenPos2(self.enemyBase.transform)
	local gameMO = IgorModel.instance:getCurGameMo()
	local startScreenPosX = oursidePosX + campWidth
	local endScreenPosX = enemyPosX - campWidth
	local startAnchorPosX, startAnchorPosY = recthelper.screenPosToAnchorPos2(Vector2(startScreenPosX, 0), self.entityArea.parent)
	local endAnchorPosX, endAnchorPosY = recthelper.screenPosToAnchorPos2(Vector2(endScreenPosX, 0), self.entityArea.parent)
	local areaWidth = math.abs(endAnchorPosX - startAnchorPosX)
	local areaPosX = (startAnchorPosX + endAnchorPosX) / 2

	recthelper.setAnchorX(self.entityArea, areaPosX)
	recthelper.setWidth(self.entityArea, areaWidth)

	local areaHeight = recthelper.getHeight(self.entityArea)
	local areaAnchorPosY = recthelper.getAnchorY(self.entityArea)
	local topAnchorY = areaAnchorPosY + areaHeight / 2
	local bottomAnchorY = areaAnchorPosY - areaHeight / 2
	local dummyAnchorX = 0
	local dummyScreenY = 0

	recthelper.setAnchorY(self.entityArea, topAnchorY)

	dummyAnchorX, dummyScreenY = recthelper.uiPosToScreenPos2(self.entityArea)

	local startScreenPosY = dummyScreenY

	recthelper.setAnchorY(self.entityArea, bottomAnchorY)

	dummyAnchorX, dummyScreenY = recthelper.uiPosToScreenPos2(self.entityArea)

	recthelper.setAnchorY(self.entityArea, areaAnchorPosY)

	local endScreenPosY = dummyScreenY

	if endScreenPosY < startScreenPosY then
		endScreenPosY = startScreenPosY
		startScreenPosY = endScreenPosY
	end

	gameMO:setStartAndEndPos(startScreenPosX, endScreenPosX, startScreenPosY, endScreenPosY, campWidth)
end

function IgorGameEntityView:initCampBase()
	local gameMO = IgorModel.instance:getCurGameMo()

	gameMO:initCampMo()

	if not self.ourSideHpComp then
		self.ourSideHpComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goOursideHp, IgorCampHpComp)

		self.ourSideHpComp:setCampRoot(self.ourSideBase)
	end

	self.ourSideHpComp:setData(gameMO.oursideMo)

	if not self.enemyHpComp then
		self.enemyHpComp = MonoHelper.addNoUpdateLuaComOnceToGo(self.goEnemyHp, IgorCampHpComp)

		self.enemyHpComp:setCampRoot(self.enemyBase)
	end

	self.enemyHpComp:setData(gameMO.enemyMo)
end

function IgorGameEntityView:createSoldier(mo)
	local campType = mo.campType
	local pool = self:getSoldierPool(mo.type)
	local go = pool:getObject()

	if campType == IgorEnum.CampType.Ourside then
		if not self.goOutsideRoot then
			local parent = self.goEnemyRoot

			gohelper.addChild(parent, go)

			local comp = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorSoldierComp)

			gohelper.setActive(go, false)
			comp:setUnitId(mo.unitId, campType, mo.type)
			comp:setDeadCallback(self.onSoldierDeadFinish, self)

			self.soldierItemDict[campType][mo.unitId] = comp

			self:sortSoldier(campType)
		end
	end
end

function IgorGameEntityView:delSoldier(mo)
	local comp = self:getSoldierByMo(mo)

	if not comp then
		return
	end

	self.soldierItemDict[mo.campType][mo.unitId] = nil
end

function IgorGameEntityView:onSoldierDeadFinish(comp)
	local pool = self:getSoldierPool(comp.soldierType)

	pool:putObject(comp.go)
end

function IgorGameEntityView:getSoldierByMo(mo)
	local campType = mo.campType

	return self.soldierItemDict[campType][mo.unitId]
end

function IgorGameEntityView:getSoldierPool(type)
	self.soldierPoolDict = self.soldierPoolDict or {}
	self.soldierPoolDict[type] = self.soldierPoolDict[type] or IgorObjPool.New(32, self.newSoldierFunc, self.releaseSoldierFunc, self.resetSoldierFunc, self, type)

	return self.soldierPoolDict[type]
end

function IgorGameEntityView:newSoldierFunc(type)
	local goClone = self.entityCloneDict[type]

	return (gohelper.cloneInPlace(goClone))
end

function IgorGameEntityView:releaseSoldierFunc(go)
	gohelper.destroy(go)
end

function IgorGameEntityView:resetSoldierFunc(go)
	gohelper.addChild(self.goPool, go)
end

function IgorGameEntityView:initTempEntity()
	if not self.tempEntity then
		local go = gohelper.findChild(self.viewGO, "root/entity/tempItem")

		gohelper.setActive(go, true)

		self.tempEntity = MonoHelper.addNoUpdateLuaComOnceToGo(go, IgorEntityPosComp)

		local cardArea = gohelper.findChild(self.viewGO, "root/info/cardArea")

		self.tempEntity:setCardArea(cardArea.transform)
	end

	self.tempEntity:setPos()
end

function IgorGameEntityView:sortSoldier(campType)
	local compDict = self.soldierItemDict[campType]
	local compList = {}

	for _, comp in pairs(compDict) do
		table.insert(compList, comp)
	end

	table.sort(compList, function(a, b)
		local posY_a = recthelper.getAnchorY(a.transform)
		local posY_b = recthelper.getAnchorY(b.transform)

		return posY_a < posY_b
	end)

	for i, comp in ipairs(compList) do
		gohelper.setAsFirstSibling(comp.go)
	end
end

function IgorGameEntityView:onClose()
	return
end

return IgorGameEntityView
