-- chunkname: @modules/logic/versionactivity3_3/arcade/controller/game/skill/hit/ArcadeSkillHitCollision.lua

module("modules.logic.versionactivity3_3.arcade.controller.game.skill.hit.ArcadeSkillHitCollision", package.seeall)

local ArcadeSkillHitCollision = class("ArcadeSkillHitCollision", ArcadeSkillHitAlertBase)

function ArcadeSkillHitCollision:onCtor()
	local params = self._params

	self._changeName = params[1]

	local round = tonumber(params[2])

	self._dirStr = params[3]
	self._hp = tonumber(params[4])
	self._baseTargetId = tonumber(params[5])
	self._alertEffId = tonumber(params[6])
	self._skillTarget = ArcadeSkillFactory.instance:createSkillTargetById(self._baseTargetId)
	self._curRound = 0
	self._nextDir = nil
	self._alertGridList = {}

	self:setAlertRound(round)
end

function ArcadeSkillHitCollision:onHitAction()
	local target = self._context.target
	local dir = self:getNextDir()

	self._nextDir = nil

	local x, y = ArcadeSkillHitNormalMove.tryMoveGridXY(target, dir, ArcadeGameEnum.Const.RoomSize)
	local scene = ArcadeGameController.instance:getGameScene()
	local curRoom = ArcadeGameController.instance:getCurRoom()

	if x and y and scene and curRoom then
		local entity = scene.entityMgr:getEntityWithType(target:getEntityType(), target:getUid())

		curRoom:tryMoveEntity(entity, x, y)
	end

	target:setDirection(dir)
	self._skillTarget:findByContext(self._context)

	local unitMOList = self._skillTarget:getTargetList()

	tabletool.removeValue(unitMOList, target)
	self:addHiterList(unitMOList)

	local hitHpVal = -self._hp

	for _, unitMO in ipairs(unitMOList) do
		ArcadeGameController.instance:changeEntityHp(unitMO, hitHpVal)
	end

	for _, unitMO in ipairs(unitMOList) do
		if unitMO:getHp() <= 0 then
			ArcadeGameController.instance:dispatchEvent(ArcadeEvent.OnSkillKillDeathSettle, unitMO, target)
		end
	end
end

function ArcadeSkillHitCollision:onAlertAction()
	local target = self._context.target

	if not target:getIsDead() and target:getHp() > 0 then
		local gameScene = ArcadeGameController.instance:getGameScene()

		if gameScene then
			self:findAlertGrid(target)

			local direction = target:getDirection()

			for _, gridMO in ipairs(self._alertGridList) do
				local gridX, gridY = gridMO:getGridPos()

				gameScene.effectMgr:playAlertEffect(self._alertEffId, gridX, gridY, direction)
			end
		end
	end
end

function ArcadeSkillHitCollision:getNextDir()
	if self._nextDir == nil then
		self._nextDir = ArcadeGameHelper.getStr2Dir(self._dirStr)
	end

	return self._nextDir
end

function ArcadeSkillHitCollision:findAlertGrid(target)
	self:clearList(self._alertGridList)

	local gridX, gridY = target:getGridPos()
	local sizeX, sizeY = target:getSize()
	local dir = self:getNextDir()

	if dir == ArcadeEnum.Direction.Up then
		for i = 1, sizeX do
			local gx = gridX + i - 1
			local gy = gridY + sizeY - 1

			self:addGridDir(gx, gy, dir)
		end
	elseif dir == ArcadeEnum.Direction.Down then
		for i = 1, sizeX do
			local gx = gridX + i - 1
			local gy = gridY

			self:addGridDir(gx, gy, dir)
		end
	elseif dir == ArcadeEnum.Direction.Left then
		for i = 1, sizeY do
			local gx = gridX
			local gy = gridY + i - 1

			self:addGridDir(gx, gy, dir)
		end
	elseif dir == ArcadeEnum.Direction.Right then
		for i = 1, sizeY do
			local gx = gridX + sizeX - 1
			local gy = gridY + i - 1

			self:addGridDir(gx, gy, dir)
		end
	end
end

function ArcadeSkillHitCollision:addGridDir(gx, gy, dir)
	local roomSize = ArcadeGameEnum.Const.RoomSize
	local tArcadeGameModel = ArcadeGameModel.instance

	for i = 1, roomSize do
		local nx, ny = ArcadeGameHelper.getNextXYByDir(gx, gy, dir)

		if not nx or not ny or nx == gx and ny == gy or nx < 1 or roomSize < nx or ny < 1 or roomSize < ny then
			return
		else
			gy = ny
			gx = nx

			local gridMO = tArcadeGameModel:getGridMOByXY(nx, ny)

			table.insert(self._alertGridList, gridMO)
		end
	end
end

function ArcadeSkillHitCollision:onHitPrintLog()
	logNormal(string.format("%s ==> 方向：%s 伤害：%s 预警:(%s/%s)", self:getLogPrefixStr(), self._dirStr, self._hp, self._curRound, self._alertRound))
end

return ArcadeSkillHitCollision
