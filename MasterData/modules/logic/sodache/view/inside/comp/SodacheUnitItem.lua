-- chunkname: @modules/logic/sodache/view/inside/comp/SodacheUnitItem.lua

module("modules.logic.sodache.view.inside.comp.SodacheUnitItem", package.seeall)

local SodacheUnitItem = class("SodacheUnitItem", LuaCompBase)

function SodacheUnitItem:init(go)
	self.go = go
	self.trans = go.transform
	self._mapCo = SodacheModel.instance:getInsideMo().mapCo
	self._modelGo = gohelper.create3d(go, "unit")
	self._loader = PrefabInstantiate.Create(self._modelGo)
end

function SodacheUnitItem:addEventListeners()
	SodacheController.instance:registerCallback(SodacheEvent.RefreshUnitShow, self.refreshIsTop, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnScenePropUpdate, self.refreshIsTop, self)
	SodacheController.instance:registerCallback(SodacheEvent.ContainerFinish, self.onContainerFinish, self)
	SodacheController.instance:registerCallback(SodacheEvent.OnPlayerDieAnim, self.playDieAnim, self)
end

function SodacheUnitItem:removeEventListeners()
	SodacheController.instance:unregisterCallback(SodacheEvent.RefreshUnitShow, self.refreshIsTop, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnScenePropUpdate, self.refreshIsTop, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.ContainerFinish, self.onContainerFinish, self)
	SodacheController.instance:unregisterCallback(SodacheEvent.OnPlayerDieAnim, self.playDieAnim, self)
end

function SodacheUnitItem:updateMo(unitMo)
	self._unitMo = unitMo

	if self._loader:getPath() ~= self._unitMo.prefabPath then
		self._loader:dispose()

		if not string.nilorempty(self._unitMo.prefabPath) then
			self._loader:startLoad(self._unitMo.prefabPath, self._onUnitLoaded, self)
		end
	end

	self:updatePos()

	if self._unitMo.type == SodacheEnum.UnitType.Player then
		local insideMo = SodacheModel.instance:getInsideMo()

		if insideMo.prop.status > SodacheEnum.InsideSceneStatus.Normal and not insideMo.prop.win then
			self:playDieAnim()
		end
	end
end

function SodacheUnitItem:_onUnitLoaded()
	self:refreshIsTop()
end

function SodacheUnitItem:refreshIsTop()
	if not self._unitMo.isMove then
		local isTop = true

		if SodacheModel.instance:getInsideMo():getTopUnitId(self._unitMo.locationId) ~= self._unitMo.uid then
			isTop = false

			goto label_6_0
		end

		gohelper.setActive(self._modelGo, isTop or not self._unitMo:isHide())
	end
end

function SodacheUnitItem:updatePos()
	local pos = self:getPos(self._unitMo.locationId)
	local offsetPos = self._unitMo:getOffsetPos(self._unitMo.locationId)
	local x = offsetPos.x + pos.x
	local y = offsetPos.y + pos.y
	local z = y / 1000

	transformhelper.setLocalPos(self.trans, x, y, z)
end

function SodacheUnitItem:getPos(nodeId)
	local nodeInfo = self._mapCo.nodes[nodeId]

	if not nodeInfo then
		logError("元件不在点位上！" .. self._unitMo.uid .. " " .. nodeId)

		return Vector3()
	end

	return nodeInfo.pos
end

function SodacheUnitItem:moveTo(newLocationId, subPosId, reason, callback, callobj)
	self._moveEndCallback = callback
	self._moveEndCallObj = callobj

	if newLocationId ~= self._unitMo.locationId then
		self._unitMo.isMove = true

		SodacheController.instance:dispatchEvent(SodacheEvent.RefreshUnitShow)

		local exPoints = SodacheModel.instance:getInsideMo().mapCo:getLineExPoints(self._unitMo.locationId, newLocationId)

		self._unitMo:setLocationId(newLocationId, subPosId)

		local newPos = self:getPos(newLocationId)
		local totalDis = 0
		local allTargetPoints = {}
		local nowPos = self.trans.localPosition
		local offsetPos = self._unitMo:getOffsetPos(newLocationId)
		local targetPos = Vector3(offsetPos.x + newPos.x, offsetPos.y + newPos.y, offsetPos.z + newPos.z)

		if exPoints and exPoints[1] then
			for i = 1, #exPoints do
				local dis = 0

				dis = i == 1 and Vector3.Distance(nowPos, exPoints[i]) or Vector3.Distance(exPoints[i - 1], exPoints[i])
				totalDis = totalDis + dis

				table.insert(allTargetPoints, {
					point = exPoints[i],
					dis = dis
				})
			end

			local dis = Vector3.Distance(exPoints[#exPoints], targetPos)

			totalDis = totalDis + dis

			table.insert(allTargetPoints, {
				point = targetPos,
				dis = dis
			})
		else
			local dis = Vector3.Distance(nowPos, targetPos)

			totalDis = totalDis + dis

			table.insert(allTargetPoints, {
				point = targetPos,
				dis = dis
			})
		end

		for i, v in ipairs(allTargetPoints) do
			v.costTime = v.dis / totalDis * SodacheEnum.MapPlayerMoveTime
		end

		self.moveTargetPoints = allTargetPoints

		self:moveToTargetPoint(reason)

		return
	end

	self._unitMo:setLocationId(newLocationId, subPosId)
	self:updatePos()
	self:doMoveCallback()
end

function SodacheUnitItem:moveToTargetPoint(reason)
	if not self.moveTargetPoints or not self.moveTargetPoints[1] then
		self:_onMoveEnd()

		return
	end

	if reason == 3001 and self._unitMo.type == SodacheEnum.UnitType.Player then
		local lastPoint = self.moveTargetPoints[#self.moveTargetPoints]

		transformhelper.setLocalPos(self.trans, lastPoint.point.x, lastPoint.point.y, lastPoint.point.y / 1000)
		SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, self._unitMo.locationId, self._unitMo.locationNo, self._onMoveEnd, self)

		return
	end

	local target = table.remove(self.moveTargetPoints, 1)
	local point = target.point
	local costTime = target.costTime

	ZProj.TweenHelper.DOLocalMove(self.trans, point.x, point.y, point.y / 1000, costTime, self.moveToTargetPoint, self, nil, EaseType.Linear)
end

function SodacheUnitItem:_onMoveEnd()
	self:doMoveCallback()

	self._unitMo.isMove = nil

	SodacheController.instance:dispatchEvent(SodacheEvent.RefreshUnitShow)
end

function SodacheUnitItem:doMoveCallback()
	local callback = self._moveEndCallback
	local callobj = self._moveEndCallObj

	self._moveEndCallback = nil
	self._moveEndCallObj = nil

	if callback then
		self._moveEndCallback(callobj)
	end
end

function SodacheUnitItem:onContainerFinish(uid, callback, callobj)
	if uid ~= self._unitMo.uid then
		return
	end

	self._containerFinishCallback = callback
	self._containerFinishCallObj = callobj

	if string.nilorempty(self._unitMo.prefabPath) then
		self:doContainerFinishCallback()

		return
	end

	local effectGo = gohelper.create3d(self._modelGo, "effect")
	local loader = PrefabInstantiate.Create(effectGo)

	loader:startLoad("modules/sodache/scene/vx/prefab/v3a7_map_smoke.prefab")
	TaskDispatcher.runDelay(self.delayFinishAnim, self, 1.5)
end

function SodacheUnitItem:delayFinishAnim()
	self:doContainerFinishCallback()
end

function SodacheUnitItem:doContainerFinishCallback()
	local callback = self._containerFinishCallback
	local callobj = self._containerFinishCallObj

	self._containerFinishCallback = nil
	self._containerFinishCallObj = nil

	if callback then
		self._containerFinishCallback(callobj)
	end
end

function SodacheUnitItem:playDieAnim()
	if self._unitMo.type == SodacheEnum.UnitType.Player then
		SodacheController.instance:dispatchEvent(SodacheEvent.TweenCameraToNode, self._unitMo.locationId)

		if self._loader then
			local go = self._loader:getInstGO()

			if not go then
				return
			end

			local anim = gohelper.findComponentAnim(go)

			if anim then
				anim:Play("die")
			end

			gohelper.setActive(gohelper.findChild(go, "m_s08_hddt_biao"), false)
			gohelper.setActive(gohelper.findChild(go, "m_s08_hddt_qizi_light"), false)
		end
	end
end

function SodacheUnitItem:destory()
	gohelper.destroy(self.go)
end

function SodacheUnitItem:onDestroy()
	TaskDispatcher.cancelTask(self.delayFinishAnim, self)

	if self._unitMo then
		self._unitMo.isMove = nil
	end

	ZProj.TweenHelper.KillByObj(self.trans)
end

return SodacheUnitItem
