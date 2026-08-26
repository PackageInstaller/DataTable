-- chunkname: @modules/logic/versionactivity3_8/echosong/view/comp/V3a8EchoSongEnemy2EntityComp.lua

module("modules.logic.versionactivity3_8.echosong.view.comp.V3a8EchoSongEnemy2EntityComp", package.seeall)

local V3a8EchoSongEnemy2EntityComp = class("V3a8EchoSongEnemy2EntityComp", V3a8EchoSongEnemyBaseEntityComp)

function V3a8EchoSongEnemy2EntityComp:_onInit(go)
	local enemy1Go = gohelper.findChild(self._go, "Image_Enemy1")
	local enemy2Go = gohelper.findChild(self._go, "Image_Enemy2")

	gohelper.setActive(enemy1Go, false)
	gohelper.setActive(enemy2Go, true)
end

function V3a8EchoSongEnemy2EntityComp:_getUnitType()
	return V3a8EchoSongEnum.UnitType.Enemy2
end

function V3a8EchoSongEnemy2EntityComp:_getSpeed()
	return V3a8EchoSongEnum.EnemyConst.Enemy2Speed
end

function V3a8EchoSongEnemy2EntityComp:_getHurtDistance()
	return V3a8EchoSongEnum.EnemyConst.Enemy2HurtDistance
end

function V3a8EchoSongEnemy2EntityComp:_onInitComp()
	self._wayPointList = {}
	self._wayPointIndex = 1

	if self._params.go then
		local posX, posY = recthelper.getAnchor(self._params.go.transform)

		table.insert(self._wayPointList, Vector2(posX, posY))
		recthelper.setAnchor(self._go.transform, posX, posY)
	end
end

function V3a8EchoSongEnemy2EntityComp:_canFrameUpdate()
	return not self._isDead
end

function V3a8EchoSongEnemy2EntityComp:_onStartLogic()
	if not self._initWayPoint then
		self._initWayPoint = true

		if not self._params.wayPointList then
			for i, id in ipairs(self._params.wayPointList) do
				local comp = self._view:getCompById(id)

				if comp then
					local posX, posY = recthelper.getAnchor(comp:getGo().transform)

					table.insert(self._wayPointList, Vector2(posX, posY))
				else
					logError("V3a8EchoSongEnemy2EntityComp:startLogic() comp is nil id:", tostring(id))
				end
			end
		end
	end

	self:_moveToNextWayPoint()
end

function V3a8EchoSongEnemy2EntityComp:rollback(info)
	self._rawRecordInfo = self._rawRecordInfo or self:getRecordInfo()
	info = info or tabletool.copy(self._rawRecordInfo)
	self._recordInfo = info
	self._wayPointIndex = info.wayPointIndex
	self._isDead = info.isDead

	gohelper.setActive(self._go, not self._isDead)

	if not self._isDead then
		self._projAnimator:Play("open")
	end

	local anchorPos = self._wayPointList[self._wayPointIndex]

	if anchorPos then
		recthelper.setAnchor(self._go.transform, anchorPos.x, anchorPos.y)

		self._curPos.x = anchorPos.x
		self._curPos.y = anchorPos.y

		self:_moveToNextWayPoint()
	else
		logError("V3a8EchoSongEnemy2EntityComp:rollback anchorPos is nil", self._id, self._wayPointIndex)
	end
end

function V3a8EchoSongEnemy2EntityComp:getRecordInfo()
	self._recordInfo.isDead = self._isDead
	self._recordInfo.wayPointIndex = 1

	return tabletool.copy(self._recordInfo)
end

function V3a8EchoSongEnemy2EntityComp:_moveDone()
	if #self._wayPointList > 1 then
		self:_moveToNextWayPoint()
	else
		logError("V3a8EchoSongEnemy2EntityComp wayPointList is less:", #self._wayPointList)
	end
end

function V3a8EchoSongEnemy2EntityComp:_moveToNextWayPoint()
	self._wayPointIndex = self._wayPointIndex + 1

	if self._wayPointIndex > #self._wayPointList then
		self._wayPointIndex = 1
	end

	local anchorPos = self._wayPointList[self._wayPointIndex]

	self:_setTarget(anchorPos)
end

function V3a8EchoSongEnemy2EntityComp:checkHitParticle(ballItem)
	if self._isDead then
		return
	end

	if not ballItem then
		return
	end

	if not self._cachedWorldX or not self._cachedWorldY then
		return
	end

	local triggerType = ballItem:getTriggerType()
	local validType = triggerType == V3a8EchoSongEnum.ParticleType.MainPlayer or triggerType == V3a8EchoSongEnum.ParticleType.Explore

	if not validType then
		return
	end

	local worldPos = ballItem:getPos()
	local dx = worldPos.x - self._cachedWorldX
	local dy = worldPos.y - self._cachedWorldY

	if dx * dx + dy * dy < 1 then
		self._isDead = true

		self._projAnimator:Play("close")

		local posX, posY = transformhelper.getPos(self._go.transform)

		self._tempPos.x = posX
		self._tempPos.y = posY

		V3a8EchoSongController.instance:dispatchEvent(V3a8EchoSongEvent.EmittedParticle, self._tempPos, V3a8EchoSongEnum.ParticleType.Enemy2, V3a8EchoSongEnum.ParticleLifeTime.Enemy2)
	end
end

return V3a8EchoSongEnemy2EntityComp
