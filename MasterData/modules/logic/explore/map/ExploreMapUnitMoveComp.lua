-- chunkname: @modules/logic/explore/map/ExploreMapUnitMoveComp.lua

module("modules.logic.explore.map.ExploreMapUnitMoveComp", package.seeall)

local ExploreMapUnitMoveComp = class("ExploreMapUnitMoveComp", ExploreMapBaseComp)

function ExploreMapUnitMoveComp:onInit()
	self._path = "modules/explore/common/sprite/prefabs/msts_icon_yidong.prefab"
	self._cloneGo = nil
	self._anim = nil
	self._curMoveUnit = nil
	self._useList = {}
	self._legalPosDic = {}
	self._loader = SequenceAbLoader.New()

	self._loader:addPath(self._path)
	self._loader:startLoad(self.onLoaded, self)
end

function ExploreMapUnitMoveComp:addEventListeners()
	self.addEventCb(self, ExploreController.instance, ExploreEvent.SetMoveUnit, self.changeStatus, self)
end

function ExploreMapUnitMoveComp:removeEventListeners()
	self.removeEventCb(self, ExploreController.instance, ExploreEvent.SetMoveUnit, self.changeStatus, self)
end

function ExploreMapUnitMoveComp:onLoaded()
	local cloneGo = gohelper.clone(self._loader:getFirstAssetItem():GetResource(), self._mapGo)

	self._cloneGo = cloneGo
	self._useList[1] = gohelper.findChild(cloneGo, "top")
	self._useList[2] = gohelper.findChild(cloneGo, "down")
	self._useList[3] = gohelper.findChild(cloneGo, "left")
	self._useList[4] = gohelper.findChild(cloneGo, "right")
	self._anim = cloneGo:GetComponent(typeof(UnityEngine.Animator))

	for i = 1, 4 do
		gohelper.setActive(self._useList[i], false)
	end

	if self._curMoveUnit then
		self:setMoveUnit(self._curMoveUnit, true)
	end
end

function ExploreMapUnitMoveComp:changeStatus(unit)
	if not self:beginStatus() then
		return
	end

	self:setMoveUnit(unit)
end

function ExploreMapUnitMoveComp:_onCloseAnimEnd()
	for i = 1, 4 do
		gohelper.setActive(self._useList[i], false)
	end
end

function ExploreMapUnitMoveComp:setMoveUnit(unit, force)
	if not force then
		if self._curMoveUnit == unit then
			return
		end

		if self._curMoveUnit then
			self._curMoveUnit:endPick()
		end

		if unit then
			unit:beginPick()
		end
	end

	self._curMoveUnit = unit

	if not self._useList[1] then
		return
	end

	if not self._unitMoving and self._curMoveUnit then
		self:roleMoveToUnit(self._curMoveUnit)
	end

	if self._anim then
		TaskDispatcher.cancelTask(self._onCloseAnimEnd, self)

		if self._curMoveUnit then
			self._anim:Play("open", 0, 0)
		else
			self._anim:Play("close", 0, 0)
			TaskDispatcher.runDelay(self._onCloseAnimEnd, self, 0.167)
		end
	else
		for i = 1, 4 do
			gohelper.setActive(self._useList[i], false)
		end
	end

	self._legalPosDic = {}

	local nodeKey1, nodeKey2

	if self._curMoveUnit then
		local heroPos = self._map:getHeroPos()
		local unitPos = unit.nodePos

		if ExploreHelper.getDistance(heroPos, unitPos) ~= 1 then
			self._curMoveUnit = nil

			logError("隔空抓取物品？？")

			return
		end

		local unitWorldPos = unit:getPos()

		transformhelper.setPos(self._cloneGo.transform, unitWorldPos.x, unitWorldPos.y, unitWorldPos.z)

		if heroPos.x == unitPos.x then
			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x, math.max(heroPos.y, unitPos.y) + 1)

			self:updateUse(nodeKey1, nodeKey2, 1, heroPos.y > unitPos.y and heroPos)

			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x, math.min(heroPos.y, unitPos.y) - 1)

			self:updateUse(nodeKey1, nodeKey2, 2, heroPos.y < unitPos.y and heroPos)

			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x - 1, unitPos.y)
			nodeKey2 = ExploreHelper.getKeyXY(heroPos.x - 1, heroPos.y)

			self:updateUse(nodeKey1, nodeKey2, 3)

			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x + 1, unitPos.y)
			nodeKey2 = ExploreHelper.getKeyXY(heroPos.x + 1, heroPos.y)

			self:updateUse(nodeKey1, nodeKey2, 4)
		else
			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x, unitPos.y + 1)
			nodeKey2 = ExploreHelper.getKeyXY(heroPos.x, heroPos.y + 1)

			self:updateUse(nodeKey1, nodeKey2, 1)

			nodeKey1 = ExploreHelper.getKeyXY(unitPos.x, unitPos.y - 1)
			nodeKey2 = ExploreHelper.getKeyXY(heroPos.x, heroPos.y - 1)

			self:updateUse(nodeKey1, nodeKey2, 2)

			nodeKey2 = nil
			nodeKey1 = ExploreHelper.getKeyXY(math.min(heroPos.x, unitPos.x) - 1, unitPos.y)

			self:updateUse(nodeKey1, nil, 3, heroPos.x < unitPos.x and heroPos)

			nodeKey1 = ExploreHelper.getKeyXY(math.max(heroPos.x, unitPos.x) + 1, unitPos.y)

			self:updateUse(nodeKey1, nodeKey2, 4, heroPos.x > unitPos.x and heroPos)
		end
	end
end

function ExploreMapUnitMoveComp:updateUse(nodeKey1, nodeKey2, index, placePos)
	local node = ExploreMapModel.instance:getNode(nodeKey1)
	local node2

	if nodeKey2 then
		node2 = ExploreMapModel.instance:getNode(nodeKey2)
	end

	if node and node:isWalkable() and (not nodeKey2 or node2 and node2:isWalkable()) then
		gohelper.setActive(self._useList[index], true)

		if placePos then
			nodeKey1 = ExploreHelper.getKey(placePos)

			local placeNode = ExploreMapModel.instance:getNode(nodeKey1)

			if placeNode and placeNode:isWalkable() then
				self._legalPosDic[nodeKey1] = index
			else
				gohelper.setActive(self._useList[index], false)
			end
		else
			self._legalPosDic[nodeKey1] = index
		end

		return
	end

	gohelper.setActive(self._useList[index], false)
end

function ExploreMapUnitMoveComp:onMapClick(mousePosition)
	if self._isRoleMoving or self._unitMoving then
		return
	end

	local unitWorldPos = self._curMoveUnit:getPos()
	local _, _, hitPos = self._map:GetTilemapMousePos(mousePosition, true)
	local pos

	if hitPos then
		local clickDir = hitPos - unitWorldPos

		if clickDir.magnitude <= 1.5 then
			local angle = math.deg(math.atan2(clickDir.x, clickDir.z))

			angle = ExploreHelper.getDir(math.floor((angle + 45) / 90) * 90)

			local angleV2 = ExploreHelper.dirToXY(angle)
			local nodePos = self._curMoveUnit.nodePos

			pos = {
				x = angleV2.x + nodePos.x,
				y = angleV2.y + nodePos.y
			}
		end
	end

	if pos then
		local key = ExploreHelper.getKey(pos)

		if self._legalPosDic[key] then
			self:sendUnitMoveReq(pos)

			return
		end
	end

	self:setMoveUnit(nil)
	self:roleMoveBack()
end

function ExploreMapUnitMoveComp:roleMoveToUnit(unit)
	self._isRoleMoving = true

	local hero = self:getHero()
	local dir = ExploreHelper.xyToDir(unit.nodePos.x - hero.nodePos.x, unit.nodePos.y - hero.nodePos.y)
	local finalPos = (hero:getPos() - unit:getPos()):SetNormalize():Mul(0.4):Add(unit:getPos())

	hero:setTrOffset(dir, finalPos, nil, self.onRoleMoveToUnitEnd, self)
	hero:setMoveSpeed(0.3)
end

function ExploreMapUnitMoveComp:onRoleMoveToUnitEnd()
	self._isRoleMoving = false

	self:getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Pull)
	self:getHero():setMoveSpeed(0)
end

function ExploreMapUnitMoveComp:roleMoveBack()
	self._isRoleMoving = true

	self:setMoveUnit(nil)

	local hero = self:getHero()
	local finalPos = hero:getPos()

	hero:setMoveSpeed(0.3)
	hero:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.None)
	hero:setTrOffset(nil, finalPos, nil, self.onRoleMoveBackEnd, self)
end

function ExploreMapUnitMoveComp:getHero()
	return ExploreController.instance:getMap():getHero()
end

function ExploreMapUnitMoveComp:onRoleMoveBackEnd()
	self:getHero():setMoveSpeed(0)

	self._isRoleMoving = false

	self._map:setMapStatus(ExploreEnum.MapStatus.Normal)
end

function ExploreMapUnitMoveComp:onStatusEnd()
	self:setMoveUnit(nil)
end

function ExploreMapUnitMoveComp:sendUnitMoveReq(pos)
	self._unitMoving = true
	self._moveTempUnit = self._curMoveUnit
	self._movePos = pos

	ExploreModel.instance:setStepPause(true)
	ExploreRpc.instance:sendExploreMoveRequest(pos.x, pos.y, self._curMoveUnit.id, self._onMoveReply, self)
	self:setMoveUnit(nil)
end

function ExploreMapUnitMoveComp:_onMoveReply(cmd, resultCode, msg)
	if resultCode == 0 then
		local pos = self._movePos

		self._movePos = nil

		self:doUnitMove(pos)
	else
		ExploreModel.instance:setStepPause(false)

		self._unitMoving = false
		self._movePos = nil
		self._moveTempUnit = nil

		self:roleMoveBack()
	end
end

function ExploreMapUnitMoveComp:doUnitMove(pos)
	local effName, isOnce, audioId, isBindGo = ExploreConfig.instance:getUnitEffectConfig(self._moveTempUnit:getResPath(), "drag")

	ExploreHelper.triggerAudio(audioId, isBindGo, self._moveTempUnit.go)

	local moveX = pos.x - self._moveTempUnit.nodePos.x
	local moveY = pos.y - self._moveTempUnit.nodePos.y
	local heroPos = self._map:getHeroPos()
	local hero = self:getHero()
	local newHeroPos = {
		x = heroPos.x + moveX,
		y = heroPos.y + moveY
	}
	local dir1 = ExploreHelper.xyToDir(self._moveTempUnit.nodePos.x - heroPos.x, self._moveTempUnit.nodePos.y - heroPos.y)
	local dir2 = ExploreHelper.xyToDir(moveX, moveY)
	local finalDir = ExploreHelper.getDir(dir2 - dir1)
	local nowUnit = self._moveTempUnit

	self._unitMoving = true

	local function cb()
		nowUnit:setEmitLight(false)
		ExploreModel.instance:setStepPause(false)
		self:setMoveUnit(nowUnit)

		self._unitMoving = false
		self._allSameDirLightMos = nil

		TaskDispatcher.cancelTask(self._everyFrameSetLightLen, self)
	end

	local allSameDirLightMos = {}
	local mapLight = ExploreController.instance:getMapLight()

	for _, lightMo in pairs(mapLight:getAllLightMos()) do
		if lightMo.endEmitUnit == nowUnit and ExploreHelper.getDir(lightMo.dir - dir2) % 180 == 0 then
			table.insert(allSameDirLightMos, lightMo)
		end
	end

	if allSameDirLightMos[1] then
		self._allSameDirLightMos = allSameDirLightMos

		TaskDispatcher.runRepeat(self._everyFrameSetLightLen, self, 0, -1)
	end

	self._moveTempUnit:setEmitLight(true)

	if ExploreHelper.isPosEqual(pos, heroPos) then
		self._map:getHero():moveByPath({
			newHeroPos
		}, finalDir, dir1)
		self._moveTempUnit:moveByPath({
			pos
		}, nil, nil, cb)
	else
		self._moveTempUnit:moveByPath({
			pos
		}, nil, nil, cb)
		self._map:getHero():moveByPath({
			newHeroPos
		}, finalDir, dir1)
	end

	self:setMoveUnit(nil)

	self._moveTempUnit = nil
end

function ExploreMapUnitMoveComp:_everyFrameSetLightLen()
	for _, lightMO in pairs(self._allSameDirLightMos) do
		lightMO.lightLen = Vector3.Distance(lightMO.curEmitUnit:getPos(), lightMO.endEmitUnit:getPos())

		lightMO.curEmitUnit:onLightDataChange(lightMO)
	end
end

function ExploreMapUnitMoveComp:canSwitchStatus(toStatus)
	if toStatus == ExploreEnum.MapStatus.UseItem then
		return false
	end

	if self._unitMoving or self._isRoleMoving then
		return false
	end

	return true
end

function ExploreMapUnitMoveComp:onDestroy()
	TaskDispatcher.cancelTask(self._onCloseAnimEnd, self)
	TaskDispatcher.cancelTask(self._everyFrameSetLightLen, self)

	for i = 1, 4 do
		self._useList[i] = nil
	end

	if self._cloneGo then
		gohelper.destroy(self._cloneGo)

		self._cloneGo = nil
	end

	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	self._anim = nil
	self._allSameDirLightMos = nil
	self._mapGo = nil
	self._map = nil
	self._curMoveUnit = nil

	ExploreMapUnitMoveComp.super.onDestroy(self)
end

return ExploreMapUnitMoveComp
