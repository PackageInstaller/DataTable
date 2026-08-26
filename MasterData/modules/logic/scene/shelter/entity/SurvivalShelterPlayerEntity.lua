-- chunkname: @modules/logic/scene/shelter/entity/SurvivalShelterPlayerEntity.lua

module("modules.logic.scene.shelter.entity.SurvivalShelterPlayerEntity", package.seeall)

local SurvivalShelterPlayerEntity = class("SurvivalShelterPlayerEntity", SurvivalShelterUnitEntity)

function SurvivalShelterPlayerEntity.Create(unitType, unitId, root)
	local playerMo = SurvivalShelterModel.instance:getPlayerMo()
	local go = gohelper.create3d(root, tostring(playerMo.pos))
	local param = {
		unitType = unitType,
		unitId = unitId,
		playerMo = playerMo
	}

	return MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalShelterPlayerEntity, param)
end

function SurvivalShelterPlayerEntity:onCtor(param)
	self._unitMo = param.playerMo
end

function SurvivalShelterPlayerEntity:onInit()
	if SurvivalMapHelper.instance:isInCollectionRoom() then
		self:setPosAndDir(SurvivalHexNode.New(-1, 2), 1)
	else
		self._unitMo:initPos()
		self:setPosAndDir(self._unitMo.pos, self._unitMo.dir)
	end

	self._loader = PrefabInstantiate.Create(self.go)

	local survivalShelterRoleMo = SurvivalShelterModel.instance:getWeekInfo().survivalShelterRoleMo
	local roleRes = survivalShelterRoleMo:getRoleModelRes()

	self._loader:startLoad(roleRes, self._onResLoadEnd, self)
	self:playAnim("idle")
end

function SurvivalShelterPlayerEntity:addEventListeners()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterMapPlayerPosChange, self._onPlayerPosChange, self)
end

function SurvivalShelterPlayerEntity:removeEventListeners()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterMapPlayerPosChange, self._onPlayerPosChange, self)
end

function SurvivalShelterPlayerEntity:_onPlayerPosChange()
	self:updateEntity()
end

function SurvivalShelterPlayerEntity:onPosChange(newPos, newDir)
	self._unitMo:setPosAndDir(newPos, newDir)
end

function SurvivalShelterPlayerEntity:setPosAndDir(pos, dir)
	self:onPosChange(pos, dir)

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(pos.q, pos.r)

	transformhelper.setLocalPos(self.trans, x, y, z)
	transformhelper.setLocalRotation(self.trans, 0, dir * 60, 0)
end

function SurvivalShelterPlayerEntity:getWorldPos()
	return transformhelper.getLocalPos(self.trans)
end

function SurvivalShelterPlayerEntity:getPos()
	local x, y, z = self:getWorldPos()
	local q, r, s = SurvivalHelper.instance:worldPointToHex(x, y, z)

	self._playerPos = self._playerPos or SurvivalHexNode.New(q, r, s)

	self._playerPos:set(q, r, s)

	return self._playerPos
end

function SurvivalShelterPlayerEntity:moveToByPosList(posList, callback, callObj, callParam, followerPlayer)
	if not posList or not next(posList) then
		self:stopMove()

		if callback then
			callback(callObj, callParam)
		end

		return
	end

	local playerPos = self:getPos()

	if tabletool.indexOf(posList, playerPos) then
		self:stopMove()

		if callback then
			callback(callObj, callParam)
		end

		return
	end

	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local walkables = mapCo.walkables
	local path = SurvivalAStarFindPath.instance:findNearestPath(playerPos, posList, walkables, true)

	if path then
		self:moveToByPath(path, callback, callObj, callParam, followerPlayer)
	else
		self:stopMove()

		if callback then
			callback(callObj, callParam)
		end
	end
end

function SurvivalShelterPlayerEntity:moveToByPos(hexPos, callback, callObj, callParam, followerPlayer)
	local playerPos = self:getPos()

	if playerPos == hexPos then
		self:stopMove()

		if callback then
			callback(callObj, callParam)
		end

		return
	end

	local mapCo = SurvivalConfig.instance:getShelterMapCo()
	local walkables = mapCo.walkables
	local path = SurvivalAStarFindPath.instance:findPath(playerPos, hexPos, walkables, true)

	if path then
		self:moveToByPath(path, callback, callObj, callParam, followerPlayer)
	else
		self:stopMove()

		if callback then
			callback(callObj, callParam)
		end
	end
end

function SurvivalShelterPlayerEntity:moveToByPath(path, callback, callObj, callParam, followerPlayer)
	self:stopMove()

	self._path = path
	self._pathcallback = callback
	self._pathcallObj = callObj
	self._pathcallParam = callParam

	SurvivalMapHelper.instance:getScene().path:showPath(self._path)

	if followerPlayer then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.CameraFollowerTarget, self.go)
	end

	self:_moveToNext()
end

function SurvivalShelterPlayerEntity:_moveToNext()
	if not self._path or #self._path == 0 then
		self._callback = self._pathcallback
		self._callObj = self._pathcallObj
		self._callParam = self._pathcallParam
		self._pathcallback = nil
		self._pathcallObj = nil
		self._pathcallParam = nil

		self:_endMove(true)

		return
	end

	local nextPos = table.remove(self._path, 1)
	local dir = SurvivalHelper.instance:getDir(self:getPos(), nextPos)

	self.moveTo(self, nextPos, dir, self._moveToNext, self)
end

function SurvivalShelterPlayerEntity:moveTo(pos, dir, callback, callObj)
	self._targetPos = pos
	self._callback = callback
	self._callObj = callObj

	if self._unitMo.dir ~= dir then
		self._tweenId = ZProj.TweenHelper.DOLocalRotate(self.trans, 0, dir * 60, 0, 0.05, self._beginMove, self)
	else
		self:_beginMove()
	end

	self:onPosChange(self._targetPos, dir)
end

function SurvivalShelterPlayerEntity:_beginMove()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_move)
	self:playAnim("run")

	local x, y, z = SurvivalHelper.instance:hexPointToWorldPoint(self._targetPos.q, self._targetPos.r)
	local curX, curY, curZ = self:getWorldPos()
	local distance = math.sqrt((curX - x)^2 + (curZ - z)^2)
	local speed = 2.3
	local time = distance / speed

	self._tweenId = ZProj.TweenHelper.DOLocalMove(self.trans, x, y, z, time, self._endMove, self, nil, EaseType.Linear)
end

function SurvivalShelterPlayerEntity:_endMove(isEnd)
	self:playAnim("idle")

	self._targetPos = nil

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	local callback = self._callback
	local callObj = self._callObj
	local callParam = self._callParam

	self._callback = nil
	self._callObj = nil
	self._callParam = nil

	if isEnd then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.CameraFollowerTarget)
		SurvivalMapHelper.instance:getScene().path:hidePath()
	end

	self:updateEntity()

	if callback then
		self._callback(callObj, callParam)
	end
end

function SurvivalShelterPlayerEntity:stopMove()
	self:playAnim("idle")

	self._targetPos = nil

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._callback = nil
	self._callObj = nil
	self._callParam = nil
	self._pathcallback = nil
	self._pathcallObj = nil
	self._pathcallParam = nil

	SurvivalMapHelper.instance:getScene().path:hidePath()
end

function SurvivalShelterPlayerEntity:playAnim(animName)
	self._curAnimName = animName

	if self._anim and self._anim.isActiveAndEnabled then
		self._anim:Play(animName, 0, 0)
	end
end

function SurvivalShelterPlayerEntity:_onResLoadEnd()
	local go = self._loader:getInstGO()
	local trans = go.transform

	self.goModel = go

	transformhelper.setLocalPos(trans, 0, 0, 0)
	transformhelper.setLocalRotation(trans, 0, 0, 0)
	transformhelper.setLocalScale(trans, 1, 1, 1)

	self._anim = gohelper.findChildAnim(go, "")

	if self._curAnimName then
		self:playAnim(self._curAnimName)
	end

	self:onLoadedEnd()
end

function SurvivalShelterPlayerEntity:isIdle()
	return self._curAnimName == "idle" and not self._targetPos and (not self._path or #self._path == 0)
end

function SurvivalShelterPlayerEntity:canShow()
	if not self:isIdle() then
		return true
	end

	local allEntity = SurvivalMapHelper.instance:getAllShelterEntity()

	if allEntity then
		for unitType, unitDict in pairs(allEntity) do
			if unitType ~= SurvivalEnum.ShelterUnitType.Player then
				for _, unit in pairs(unitDict) do
					if unit:isVisible() and unit:isInPlayerPos() then
						return false
					end
				end
			end
		end
	end

	return true
end

function SurvivalShelterPlayerEntity:isInPos(pos)
	if not self:isIdle() then
		return false
	end

	return pos == self:getPos()
end

function SurvivalShelterPlayerEntity:isInPosList(posDict)
	if not posDict then
		return false
	end

	if not self:isIdle() then
		return false
	end

	local curPos = self:getPos()

	return SurvivalHelper.instance:getValueFromDict(posDict, curPos)
end

function SurvivalShelterPlayerEntity:onUpdateEntity()
	return
end

function SurvivalShelterPlayerEntity:needUI()
	return true
end

function SurvivalShelterPlayerEntity:onClickPlayer()
	if not self:isIdle() then
		self:focusEntity()

		return
	end

	local allEntity = SurvivalMapHelper.instance:getAllShelterEntity()

	if allEntity then
		for unitType, unitDict in pairs(allEntity) do
			if unitType ~= SurvivalEnum.ShelterUnitType.Player then
				for unitId, unit in pairs(unitDict) do
					if unit:isInPlayerPos() then
						SurvivalMapHelper.instance:gotoUnit(unitType, unitId)

						return
					end
				end
			end
		end
	end

	self:focusEntity()
end

return SurvivalShelterPlayerEntity
