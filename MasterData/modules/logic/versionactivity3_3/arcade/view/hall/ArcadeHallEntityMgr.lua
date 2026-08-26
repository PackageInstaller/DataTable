-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallEntityMgr.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallEntityMgr", package.seeall)

local ArcadeHallEntityMgr = class("ArcadeHallEntityMgr", ArcadeBaseSceneComp)

function ArcadeHallEntityMgr:onInit()
	transformhelper.setLocalPos(self.trans, 0, 0, -0.1)

	self._characterEntity = {}

	self:createCharacterEntity()
	self:createInteractiveEntity()
	self:_onInitEntity()
end

function ArcadeHallEntityMgr:addEventListeners()
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnMoveToInteractive, self._onMoveToInteractive, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._onEquipHero, self)
	self.addEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeHallEntityMgr:removeEventListeners()
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnMoveToInteractive, self._onMoveToInteractive, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.OnEquipHero, self._onEquipHero, self)
	self.removeEventCb(self, ArcadeController.instance, ArcadeEvent.NPCTalkBlock, self._setNPCBlock, self)
end

function ArcadeHallEntityMgr:_setNPCBlock(isBlock)
	self._isNpcTalkBlock = isBlock
end

function ArcadeHallEntityMgr:_onEquipHero(characterId)
	for id, entity in pairs(self._characterEntity) do
		entity:showEntity(id == characterId)
	end

	self._characterMO = self._scene:getCharacterMO()

	local entity = self._characterEntity[characterId]

	if entity then
		local curGridX, curGridY = ArcadeHallModel.instance:getHeroGrid()

		self._characterMO:setGridPos(curGridX, curGridY)
		entity:refreshEntity(self._characterMO)
		self:_refreshHeroEntity(characterId)
	else
		self:createCharacterEntity()
	end
end

function ArcadeHallEntityMgr:_refreshHeroEntity(id)
	for _id, entity in pairs(self._characterEntity) do
		gohelper.setActive(entity.go, _id == id)
	end
end

function ArcadeHallEntityMgr:onOpen()
	self:_onInitEntity()

	self._nearInteractiveId = nil
end

function ArcadeHallEntityMgr:_onInitEntity()
	self:_refreshEntitySibling()

	if self._characterMO then
		self._characterMO:initGrid()
	end

	self:_delayBornCharacter()
	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()
end

function ArcadeHallEntityMgr:_delayBornCharacter()
	TaskDispatcher.cancelTask(self._bornCharacter, self)

	local characterEntity = self:getCharacterEntity()

	if characterEntity then
		characterEntity:showEntity(false)
		characterEntity:refreshPosition()
		TaskDispatcher.runDelay(self._bornCharacter, self, ArcadeHallEnum.DelayShowCharacterTime)
	end
end

function ArcadeHallEntityMgr:_bornCharacter()
	local characterEntity = self:getCharacterEntity()

	if characterEntity then
		characterEntity:showEntity(true)
		characterEntity:playBornAni()
	end
end

function ArcadeHallEntityMgr:onClose()
	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()
end

function ArcadeHallEntityMgr:_onMoveToInteractive(interactiveId)
	TaskDispatcher.cancelTask(self._onAutoMove, self)

	if not self:isCanMove() then
		return
	end

	self:_setAutoMoveToInteractiveId(interactiveId)

	if not self._linkMO then
		self._linkMO = ArcadeHallQuickLinkMO.New()

		self._linkMO:initMo()
	end

	local curGridX, curGridY = self._characterMO:getGridPos()

	self._autoGridList = self._linkMO:findPath(interactiveId, curGridX, curGridY)

	if self._autoGridList and #self._autoGridList > 0 then
		local targetGridX, targetGridY = self._autoGridList[1].x, self._autoGridList[1].y

		ArcadeOutSideRpc.instance:sendArcadeGamePlayerMOveRequest(targetGridX, targetGridY)
		self:_onAutoMove()
	else
		self:_onFinishAutoMove()
	end
end

function ArcadeHallEntityMgr:_onAutoMove()
	if LuaUtil.tableNotEmpty(self._autoGridList) then
		local grid = self._autoGridList[#self._autoGridList]

		if not grid then
			self:_onFinishAutoMove()

			return
		end

		self:_refreshEntitySibling()
		self._characterMO:setGridPos(grid.x, grid.y)
		ArcadeHeroModel.instance:setCharacterPos(grid.x, grid.y)
		table.remove(self._autoGridList, #self._autoGridList)

		local characterEntity = self:getCharacterEntity()

		characterEntity:doMove(self._onAutoMove, self)

		return
	end

	self:_onFinishAutoMove()
end

function ArcadeHallEntityMgr:_onFinishAutoMove()
	ArcadeController.instance:enterInteractive(self._isAutoMoveToInteractiveId)
	self:_setAutoMoveToInteractiveId()
end

function ArcadeHallEntityMgr:createCharacterEntity()
	self._characterMO = self._scene:getCharacterMO()

	local resPath = self._characterMO:getResPath()

	if not string.nilorempty(resPath) then
		self._scene.loader:loadRes(resPath, self._onLoadCharacterEntity, self)
	end
end

function ArcadeHallEntityMgr:_onLoadCharacterEntity()
	local id = ArcadeHeroModel.instance:getEquipHeroId()

	if self._characterMO then
		local resPath = self._characterMO:getResPath()
		local characterAssetRes = self._scene.loader:getResource(resPath)

		if characterAssetRes then
			local goCharacter = gohelper.clone(characterAssetRes, self.go, string.format("character-%s", self._characterMO:getId()))

			self._characterEntity[id] = MonoHelper.addNoUpdateLuaComOnceToGo(goCharacter, ArcadeHallEntity)

			self._characterEntity[id]:initEntity(goCharacter, self._characterMO, self._scene.loader)
			self:_delayBornCharacter()
		end
	end
end

function ArcadeHallEntityMgr:getCharacterEntity()
	local id = ArcadeHeroModel.instance:getEquipHeroId()

	return self._characterEntity[id]
end

function ArcadeHallEntityMgr:_setAutoMoveToInteractiveId(interactiveId)
	self._isAutoMoveToInteractiveId = interactiveId
end

function ArcadeHallEntityMgr:isCanMove()
	if not self._characterMO then
		return
	end

	local characterEntity = self:getCharacterEntity()

	if not characterEntity or not characterEntity:isShowEntity() then
		return
	end

	if self._isAutoMoveToInteractiveId then
		return
	end

	if self._isNpcTalkBlock then
		return
	end

	for _, param in pairs(ArcadeHallEnum.HallInteractiveParams) do
		local viewName = param.ViewName

		if viewName and ViewMgr.instance:isOpen(viewName) then
			return
		end
	end

	return true
end

function ArcadeHallEntityMgr:playerActOnDirection(direction)
	if not self:isCanMove() then
		return
	end

	local curGridX, curGridY = self._characterMO:getGridPos()
	local targetGridX = curGridX + (ArcadeEnum.DirChangeGridX[direction] or 0)
	local targetGridY = curGridY + (ArcadeEnum.DirChangeGridY[direction] or 0)

	self:_onHeroMove(targetGridX, targetGridY)
end

function ArcadeHallEntityMgr:_checkInteractiveEvent(interactiveId, nearInteractiveId)
	if interactiveId then
		local param = ArcadeHallEnum.HallInteractiveParams[interactiveId]

		if param and param.isOpenTip then
			self._scene:openBuildingTipView(interactiveId)
		else
			ArcadeController.instance:enterInteractive(interactiveId)
		end
	elseif nearInteractiveId then
		local param = ArcadeHallEnum.HallInteractiveParams[nearInteractiveId]

		if param then
			if param.isOpenTip then
				self._scene:openBuildingTipView(nearInteractiveId)
			else
				ArcadeController.instance:enterInteractive(nearInteractiveId)
			end
		end
	else
		if self._nearInteractiveId then
			ArcadeController.instance:closeTipView()
		end

		ArcadeController.instance:exitInteractive()
	end

	self._nearInteractiveId = nearInteractiveId
end

function ArcadeHallEntityMgr:_onHeroMove(targetGridX, targetGridY)
	if self:overRange(targetGridX, targetGridY) then
		return
	end

	local entity = self:getCharacterEntity()
	local interactiveId = self:isInteractiveRange(targetGridX, targetGridY)
	local nearInteractiveId = self:isNearInteractive(targetGridX, targetGridY)

	local function callback()
		entity:refreshPosition()
		self:_checkInteractiveEvent(interactiveId, nearInteractiveId)
	end

	if not interactiveId then
		self._characterMO:setGridPos(targetGridX, targetGridY)
		ArcadeHeroModel.instance:setCharacterPos(targetGridX, targetGridY)
	end

	self:_refreshEntitySibling()
	entity:doMove(callback, self)
	self:_setAutoMoveToInteractiveId()
end

function ArcadeHallEntityMgr:overRange(targetGridX, targetGridY)
	local maxGrid = ArcadeHallModel.instance:getHallGridSize()

	return targetGridX < 1 or targetGridX > maxGrid[1] or targetGridY < 1 or targetGridY > maxGrid[2]
end

function ArcadeHallEntityMgr:createInteractiveEntity()
	self._interactiveMos = self._scene:getInteractiveMOs()
	self._interactiveEntity = {}
	self._pathList = {}

	for i, mo in pairs(self._interactiveMos) do
		local resPath = mo:getResPath()

		if not string.nilorempty(resPath) then
			table.insert(self._pathList, resPath)
		end
	end

	self._scene.loader:loadResList(self._pathList, self._onLoadInteractiveEntity, self)
end

function ArcadeHallEntityMgr:_onLoadInteractiveEntity()
	for i, mo in pairs(self._interactiveMos) do
		local resPath = mo:getResPath()

		if not string.nilorempty(resPath) then
			local res = self._scene.loader:getResource(resPath)

			if res then
				local go = gohelper.clone(res, self.go, "building_" .. i)

				self._interactiveEntity[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, ArcadeHallEntity)

				self._interactiveEntity[i]:initEntity(go, mo)

				if i == ArcadeHallEnum.HallInteractiveId.NPC then
					self._interactiveEntity[i]:playIdleAnim()
				end
			end
		end
	end
end

function ArcadeHallEntityMgr:isInteractiveRange(curGridX, curGridY)
	for i, mo in pairs(self._interactiveMos) do
		if mo:isEnterRange(curGridX, curGridY) then
			return i
		end
	end
end

function ArcadeHallEntityMgr:isNearInteractive(curGridX, curGridY)
	local interactiveId

	for i, mo in pairs(self._interactiveMos) do
		for j = 1, 4 do
			local dirHexPoint = ArcadeHallEnum.Directions[j]

			if mo:isEnterRange(curGridX + dirHexPoint.x, curGridY + dirHexPoint.y) then
				interactiveId = interactiveId and math.max(interactiveId, i) or i
			end
		end
	end

	return interactiveId
end

function ArcadeHallEntityMgr:_refreshEntitySibling()
	local _, gridY = self._characterMO:getGridPos()
	local npcMo = self._interactiveMos[ArcadeHallEnum.HallInteractiveId.NPC]
	local _, npcGridY = npcMo:getGridPos()

	if npcGridY < gridY then
		self._characterMO:setPosZ(0.001)
	else
		self._characterMO:setPosZ(0)
	end
end

function ArcadeHallEntityMgr:onClear()
	TaskDispatcher.cancelTask(self._onAutoMove, self)
	TaskDispatcher.cancelTask(self._bornCharacter, self)

	if self._characterEntity then
		for _, entity in pairs(self._characterEntity) do
			entity:clear()
		end
	end

	self:_setAutoMoveToInteractiveId()
	self:_setNPCBlock()

	self._nearInteractiveId = nil
end

return ArcadeHallEntityMgr
