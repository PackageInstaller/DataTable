-- chunkname: @modules/logic/explore/map/unit/ExploreHero.lua

module("modules.logic.explore.map.unit.ExploreHero", package.seeall)

local ExploreHero = class("ExploreHero", Explore3DRoleBase)

function ExploreHero:onInit()
	self._hangPoints = {}
	self._baton = UnityEngine.GameObject.New("baton")

	gohelper.setActive(self._baton, false)

	self._batonLoader = PrefabInstantiate.Create(self._baton)

	self._batonLoader:startLoad("modules/explore/roles/prefabs/zhihuibang.prefab", self._onBatonLoadEnd, self)
	ExploreHero.super.onInit(self)
end

function ExploreHero:_onBatonLoadEnd()
	local go = self._batonLoader:getInstGO()

	self._batonEffectLoader = PrefabInstantiate.Create(go.transform:Find("zhihuibang/Point001").gameObject)

	self._batonEffectLoader:startLoad(ResUrl.getExploreEffectPath("open_chest"))
end

function ExploreHero:onDestroy()
	if self._batonLoader then
		self._batonLoader:dispose()

		self._batonLoader = nil
	end

	if self._batonEffectLoader then
		self._batonEffectLoader:dispose()

		self._batonEffectLoader = nil
	end

	gohelper.destroy(self._baton)

	self._hangPoints = nil

	ExploreHero.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._onFrame, self)
end

function ExploreHero:setHeroStatus(status, ...)
	local hangType = ExploreAnimEnum.UseBatonAnim[status]
	local trans = self._hangPoints[hangType]

	if trans then
		self._baton.transform:SetParent(trans, false)
		gohelper.setActive(self._baton, true)
	else
		gohelper.setActive(self._baton, false)
	end

	ExploreHero.super.setHeroStatus(self, status, ...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuStart, status)
end

function ExploreHero:delaySetNormalStatus(...)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroStatuEnd, self._curStatus)
	gohelper.setActive(self._baton, false)

	if not ExploreModel.instance.isRoleInitDone then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
	end

	ExploreHero.super.delaySetNormalStatus(self, ...)
end

function ExploreHero:setResPath(url)
	if url and self._resPath ~= url then
		self._resPath = url
		self._assetId = ResMgr.getAbAsset(self._resPath, self._onResLoaded, self, self._assetId)
	elseif url and self._resPath == url and self._displayGo == nil then
		self._assetId = ResMgr.getAbAsset(self._resPath, self._onResLoaded, self, self._assetId)
	else
		self:onResLoaded()
	end
end

function ExploreHero:onResLoaded()
	self._hangPoints = {}

	for k, v in pairs(ExploreAnimEnum.RoleHangPointPath) do
		self._hangPoints[k] = self._displayTr:Find(v)
	end

	if ExploreModel.instance.isFirstEnterMap == ExploreEnum.EnterMode.First then
		self:setActive(false)
	else
		self.dir = ExploreMapModel.instance:getHeroDir()

		self:setRotate(0, self.dir, 0)
	end

	local node = ExploreMapModel.instance:getNode(ExploreHelper.getKey(self.nodePos))

	if node and self.position.y ~= node.height then
		self.position.y = node.height

		transformhelper.setPos(self.trans, self.position.x, node.height, self.position.z)
		ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, self.position)
	end

	if self._waitAssetLoaded then
		self._waitAssetLoaded = nil

		self:onRoleFirstEnter()
	end
end

function ExploreHero:onRoleFirstEnter()
	if not self._displayTr then
		self._waitAssetLoaded = true

		return
	end

	self:setActive(true)

	if ExploreModel.instance:hasUseItemOrUnit() then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)

		return
	end

	self.dir = ExploreMapModel.instance:getHeroDir()

	self:setRotate(0, self.dir, 0)

	local haveSpike = false
	local units = ExploreController.instance:getMap():getUnitByPos(self.nodePos)

	for _, unit in pairs(units) do
		if unit:getUnitType() == ExploreEnum.ItemType.Spike then
			haveSpike = true

			break
		end
	end

	if haveSpike then
		return
	end

	if ExploreModel.instance.isFirstEnterMap ~= ExploreEnum.EnterMode.First then
		ExploreModel.instance.isRoleInitDone = true

		ExploreController.instance:dispatchEvent(ExploreEvent.HeroResInitDone)
		ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)

		return
	end

	self:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Entry, true, true)
	ExploreController.instance:dispatchEvent(ExploreEvent.HeroFirstAnimEnd)
end

function ExploreHero:onUpdateExploreInfo()
	self.go:SetActive(true)

	local posx, posy = ExploreMapModel.instance:getHeroPos()

	self:setTilemapPos(Vector2(posx, posy))
end

function ExploreHero:setMap(exploreMap)
	self._exploreMap = exploreMap
end

function ExploreHero:getHangTrans(type)
	return self._hangPoints[type]
end

function ExploreHero:onStartMove(preNode, nowNode)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterStartMove, self.nodePos, self._nextNodePos)
end

function ExploreHero:setPos(pos, notDispatchEvent, isUseModelPos)
	ExploreHero.super.setPos(self, pos, true)

	local pos = self:getPos()

	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, (ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.MoveUnit or isUseModelPos) and self._displayTr.position)
end

function ExploreHero:moveTo(pos, callback, callbackObj)
	if ExploreModel.instance:isHeroInControl() then
		if ExploreHelper.isPosEqual(self.nodePos, pos) then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnClickHero)
		end

		ExploreHero.super.moveTo(self, pos, callback, callbackObj)
	end
end

function ExploreHero:moveToTar(unitMO)
	if ExploreModel.instance:isHeroInControl() then
		local pos = unitMO:getTriggerPos()

		self._tarUnitMO = unitMO

		self:_startMove(pos)
	end
end

function ExploreHero:clearTarget()
	self._tarUnitMO = nil
end

function ExploreHero:onEndMove()
	ExploreHero.super.onEndMove(self)

	if not self._tarUnitMO or ExploreHelper.getDistance(self._tarUnitMO.nodePos, self.nodePos) > 1 then
		-- block empty
	elseif self._tarUnitMO.enterTriggerType == false and self._tarUnitMO.triggerByClick ~= false and self._tarUnitMO:canTrigger(self.nodePos) then
		local useItemUid = ExploreModel.instance:getUseItemUid()
		local itemMo = ExploreBackpackModel.instance:getById(useItemUid)

		if itemMo and itemMo.itemEffect == ExploreEnum.ItemEffect.Active and self._tarUnitMO.type ~= ExploreEnum.ItemType.Rune then
			ToastController.instance:showToast(ExploreConstValue.Toast.CantTrigger)
		else
			ExploreController.instance:dispatchEvent(ExploreEvent.TryTriggerUnit, self._tarUnitMO.id)
		end
	end

	ExploreController.instance:dispatchEvent(ExploreEvent.OnHeroMoveEnd, self.nodePos)

	self._tarUnitMO = nil
end

function ExploreHero:setTilemapPos(pos)
	self:setPosByNode(pos)
	self:sendMoveRequest(self.nodePos)
end

function ExploreHero:sendMoveRequest(pos)
	return
end

function ExploreHero:onMoveTick()
	self:_moving()
end

function ExploreHero:updateSceneY(y)
	ExploreHero.super.updateSceneY(self, y)

	local pos = self:getPos()

	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterPosChange, pos)
end

function ExploreHero:_checkAndPutoffPot()
	local carryUnit = ExploreModel.instance:getCarryUnit()

	if carryUnit then
		local nodePos = self.nodePos
		local dirXY = ExploreHelper.dirToXY(self.dir)
		local backPos = {
			x = nodePos.x - dirXY.x,
			y = nodePos.y - dirXY.y
		}
		local nodeKey = ExploreHelper.getKey(backPos)
		local node = ExploreMapModel.instance:getNode(nodeKey)

		if not node or not node:isWalkable(nil, true) then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		local canPlace = true
		local units = ExploreController.instance:getMap():getUnitByPos(nodePos)

		for _, unit in pairs(units) do
			if unit:isEnter() and not unit.mo.canUseItem then
				canPlace = false

				break
			end
		end

		if not canPlace then
			ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantPlacePot)

			return
		end

		local params = backPos.x .. "#" .. backPos.y

		ExploreRpc.instance:sendExploreInteractRequest(carryUnit.id, 0, params)

		return true
	end

	return false
end

function ExploreHero:_startMove(pos, callback, callbackObj)
	self._gotoCallback = callback
	self._gotoCallbackObj = callbackObj
	self._endPos = pos

	local beginPos = self.nodePos

	if not beginPos or ExploreHelper.isPosEqual(beginPos, self._endPos) and not self._isMoving then
		if self:_checkAndPutoffPot() then
			return
		end

		self:_onEndMoveCallback()

		return
	end

	if isDebugBuild and not self:isMoving() and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftShift) and UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftControl) then
		local node = ExploreMapModel.instance:getNode(ExploreHelper.getKey(pos))

		if node and node:isWalkable() then
			self:_onEndMoveCallback()
			GMRpc.instance:sendGMRequest("set explore pos " .. ExploreModel.instance:getMapId() .. "#" .. pos.x .. "#" .. pos.y)
			self:setPosByNode(pos)
			ExploreMapModel.instance:updatHeroPos(pos.x, pos.y, 0)
			ExploreModel.instance:setHeroControl(true)

			return
		end
	end

	if self.nodePos and pos then
		local nodeKey1 = ExploreHelper.getKey(self.nodePos)
		local node1 = ExploreMapModel.instance:getNode(nodeKey1)
		local nodeKey2 = ExploreHelper.getKey(pos)
		local node2 = ExploreMapModel.instance:getNode(nodeKey2)

		if not node1 or not node2 or node1.height ~= node2.height then
			return
		end
	end

	self._pathArray = self._exploreMap:startFindPath(beginPos, self._endPos, self._nextNodePos)

	local pathLen = #self._pathArray

	if pathLen == 0 then
		if not self:isMoving() then
			self:_onEndMoveCallback()
		elseif self._runStartTime <= self._runTotalTime / 2 then
			self:onCheckDir(self._nextNodePos, self.nodePos)

			self._nextWorldPos, self._oldWorldPos = self._oldWorldPos, self._nextWorldPos
			self._runStartTime = self._runTotalTime - self._runStartTime
			self._nextNodePos = self.nodePos
		else
			self:stopMoving()
		end

		return
	end

	local lastPos = self._pathArray[1]
	local wayImpassable = true

	wayImpassable = self._tarUnitMO and ExploreHelper.getDistance(self._tarUnitMO.nodePos, lastPos) <= 1 or self._endPos.x == lastPos.x and self._endPos.y == lastPos.y

	if wayImpassable == false then
		self:stopMoving()

		return
	end

	self._walkDistance = pathLen

	self:_startMove2()
	self:onStartMove()
end

function ExploreHero:onNodeChange(preNode, nowNode)
	ExploreController.instance:dispatchEvent(ExploreEvent.OnCharacterNodeChange, nowNode, preNode, self._nextNodePos)

	if self:isMoving() then
		self:checkMoveAudio()
	end
end

function ExploreHero:checkMoveAudio()
	if not self.nodePos then
		return
	end

	local key = ExploreHelper.getKey(self.nodePos)
	local node = ExploreMapModel.instance:getNode(key)
	local audioType = ExploreEnum.WalkAudioType.Normal

	if node.nodeType == ExploreEnum.NodeType.Ice then
		audioType = ExploreEnum.WalkAudioType.Ice
	end

	if self._playAudioType ~= audioType then
		self:stopMoveAudio()

		self._playAudioType = audioType

		if self._playAudioType == ExploreEnum.WalkAudioType.Ice then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlide)
		end

		if self._playAudioType == ExploreEnum.WalkAudioType.Normal then
			AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalk)
		end
	end
end

function ExploreHero:stopMoveAudio()
	if self._playAudioType == ExploreEnum.WalkAudioType.Ice then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroGlideStop)
	end

	if self._playAudioType == ExploreEnum.WalkAudioType.Normal then
		AudioMgr.instance:trigger(AudioEnum.Explore.HeroWalkStop)
	end
end

function ExploreHero:setMoveState(state)
	ExploreHero.super.setMoveState(self, state)

	if state == ExploreAnimEnum.RoleMoveState.Move then
		self:checkMoveAudio()
	else
		self:stopMoveAudio()

		self._playAudioType = ExploreEnum.WalkAudioType.None
	end
end

function ExploreHero:_startMove2()
	if self._nextWorldPos then
		local nowPos = self:getPos()
		local toPos = ExploreHelper.tileToPos(self._pathArray[#self._pathArray])

		toPos.y = nowPos.y

		local newDir = toPos - nowPos

		newDir.y = 0

		local normal1 = newDir:Normalize()
		local oldDir = self._nextWorldPos - nowPos

		oldDir.y = 0

		local normal2 = oldDir:Normalize()

		if Mathf.Approximately(normal1.x, normal2.x) and Mathf.Approximately(normal1.z, normal2.z) or self._runStartTime > self._runTotalTime / 2 then
			-- block empty
		else
			self:onCheckDir(self._nextNodePos, self.nodePos)

			self._nextWorldPos, self._oldWorldPos = self._oldWorldPos, self._nextWorldPos
			self._runStartTime = self._runTotalTime - self._runStartTime
			self._nextNodePos = self.nodePos
		end
	end

	self._isMoving = true

	TaskDispatcher.runRepeat(self.onMoveTick, self, 0)
	self:onMoveTick()
end

function ExploreHero:_onFrame()
	do return end

	local map = ExploreController.instance:getMap()

	if not map then
		return
	end

	if map:getNowStatus() ~= ExploreEnum.MapStatus.Normal then
		return
	end

	if self:isMoving() then
		return
	end

	local inputController = PCInputController.instance
	local up, left, down, right = inputController:getThirdMoveKey()

	if inputController:getKeyPress(up) then
		local xy = self:RealMoveDir(0)

		if xy == nil then
			return
		end

		self:moveTo(Vector2(self.nodePos.x + xy.x, self.nodePos.y + xy.y))
	elseif inputController:getKeyPress(down) then
		local xy = self:RealMoveDir(180)

		if xy == nil then
			return
		end

		self:moveTo(Vector2(self.nodePos.x + xy.x, self.nodePos.y + xy.y))
	elseif inputController:getKeyPress(left) then
		local xy = self:RealMoveDir(270)

		if xy == nil then
			return
		end

		self:moveTo(Vector2(self.nodePos.x + xy.x, self.nodePos.y + xy.y))
	elseif inputController:getKeyPress(right) then
		local xy = self:RealMoveDir(90)

		if xy == nil then
			return
		end

		self:moveTo(Vector2(self.nodePos.x + xy.x, self.nodePos.y + xy.y))
	end
end

function ExploreHero:RealMoveDir(dir)
	local mapRatation = ExploreMapModel.instance.nowMapRotate

	return ExploreHelper.dirToXY(dir + mapRatation)
end

return ExploreHero
