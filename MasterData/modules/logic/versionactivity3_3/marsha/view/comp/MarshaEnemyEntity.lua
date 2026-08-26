-- chunkname: @modules/logic/versionactivity3_3/marsha/view/comp/MarshaEnemyEntity.lua

module("modules.logic.versionactivity3_3.marsha.view.comp.MarshaEnemyEntity", package.seeall)

local MarshaEnemyEntity = class("MarshaEnemyEntity", MarshaBaseEntity)

function MarshaEnemyEntity:init(go)
	MarshaEnemyEntity.super.init(self, go)

	self.goNodeDespair = gohelper.findChild(go, "node_despair")
	self.txtWeight = gohelper.findChildText(go, "txt_Weight")
end

function MarshaEnemyEntity:onDestroy()
	TaskDispatcher.cancelTask(self.checkMove, self)
	TaskDispatcher.cancelTask(self.randomDirection, self)
	MarshaEnemyEntity.super.onDestroy(self)
end

function MarshaEnemyEntity:initData(unitCo, uid)
	self:initBase(unitCo.unitType, uid)
	self:setWeight(unitCo.weight)
	self:setPos(unitCo.posX, unitCo.posY)
	self:setSpeed(unitCo.speed)
	TaskDispatcher.runRepeat(self.checkMove, self, MarshaEnum.CheckMoveInterval)
end

function MarshaEnemyEntity:setWeight(weight)
	MarshaEnemyEntity.super.setWeight(self, weight)

	if self.txtWeight then
		self.txtWeight.text = weight
	end
end

function MarshaEnemyEntity:checkMove()
	if string.nilorempty(self.config.action) then
		return
	end

	local moveType
	local moveParams = GameUtil.splitString2(self.config.action)

	for _, moveParam in ipairs(moveParams) do
		if moveParam[1] == MarshaEnum.MoveType.ClosePlayer or moveParam[1] == MarshaEnum.MoveType.LeavePlayer then
			local condition = moveParam[2]
			local playerEntity = MarshaEntityMgr.instance:getPlayerEntity()

			if condition == "dis" then
				local dis = Vector2.Distance(playerEntity:getAnchorPos(), self:getAnchorPos()) - (playerEntity.width + self.width)

				if MarshaHelper.checkValueCondition(tonumber(moveParam[3]), dis) then
					moveType = moveParam[1]

					break
				end
			elseif condition == "weight" then
				local type = tonumber(moveParam[3])

				if type == 1 and self.weight > playerEntity.weight then
					moveType = moveParam[1]

					break
				elseif type == 2 and self.weight <= playerEntity.weight then
					moveType = moveParam[1]

					break
				end
			else
				logError(string.format("221_玛尔纱角色活动 情绪球表action字段不支持 %s 的判断条件", condition))
			end
		elseif moveParam[1] == MarshaEnum.MoveType.RanToward then
			moveType = moveParam[1]
			self.randomInterval = tonumber(moveParam[2])

			break
		end
	end

	if moveType == MarshaEnum.MoveType.RanToward then
		if self.moveType ~= moveType then
			self:randomDirection()
			TaskDispatcher.runRepeat(self.randomDirection, self, self.randomInterval)
		end
	elseif moveType == MarshaEnum.MoveType.ClosePlayer then
		TaskDispatcher.cancelTask(self.randomDirection, self)

		local playerEntity = MarshaEntityMgr.instance:getPlayerEntity()
		local endDir = playerEntity:getAnchorPos() - self:getAnchorPos()
		local angle = MarshaHelper.SignedAngle(Vector2.right, endDir)

		if self.goNodeDespair then
			transformhelper.setEulerAngles(self.goNodeDespair.transform, 0, 0, angle)
		end

		self.radian = angle * Mathf.Deg2Rad
	elseif moveType == MarshaEnum.MoveType.LeavePlayer then
		TaskDispatcher.cancelTask(self.randomDirection, self)

		local playerEntity = MarshaEntityMgr.instance:getPlayerEntity()
		local endDir = self:getAnchorPos() - playerEntity:getAnchorPos()
		local angle = MarshaHelper.SignedAngle(Vector2.right, endDir)

		if self.goNodeDespair then
			transformhelper.setEulerAngles(self.goNodeDespair.transform, 0, 0, angle)
		end

		self.radian = angle * Mathf.Deg2Rad
	end

	self.moveType = moveType
end

function MarshaEnemyEntity:randomDirection()
	local angle = math.random(-180, 180)

	if self.goNodeDespair then
		transformhelper.setEulerAngles(self.goNodeDespair.transform, 0, 0, angle)
	end

	self.radian = angle * Mathf.Deg2Rad
end

function MarshaEnemyEntity:tick(dt)
	if not self.moveType then
		return
	end

	if self.unControl then
		if not self.unControlSpeed then
			local fixSpeed = self:getFixSpeed()
			local xDis = fixSpeed * math.cos(self.radian) * dt
			local yDis = fixSpeed * math.sin(self.radian) * dt
			local x, y = MarshaHelper.fitBounds(self, xDis, yDis)

			if self.x ~= x or self.y ~= y then
				self:setPos(x, y)
			end
		end
	end
end

return MarshaEnemyEntity
