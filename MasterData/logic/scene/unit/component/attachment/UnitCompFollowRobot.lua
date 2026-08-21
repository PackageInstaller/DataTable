-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/attachment/UnitCompFollowRobot.lua

module("logic.scene.unit.component.attachment.UnitCompFollowRobot", package.seeall)

local M = class("UnitCompFollowRobot", UnitComponentBase)
local PlayerStatus = HouseEnum.PlayerStatus
local FollowInterval = 2
local AddSpeedInterval = 3
local DefualtSpeed = CommEnum.NavMeshAgentSpeed.RobotWalk
local vec3Temp1 = Vector3.New()
local vec3Temp2 = Vector3.New()

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._unitRobot = nil
	self._followSwitch = nil
	self._transportGoods = nil
end

function M:onInit()
	self._unitRobot = nil
	self._followSwitch = false
	self._transportGoods = nil
end

function M:onReset()
	self:_removeRobotListener()
	self:removeTransportGoods()

	self._unitRobot = false
	self._followSwitch = false
end

function M:onDestroy()
	self:_removeRobotListener()

	self._unitRobot = nil
	self._followSwitch = false

	self:removeTransportGoods()
end

function M:_removeRobotListener()
	if self._unitRobot then
		DG.Tweening.DOTween.Kill(self._unitRobot.go)
		self._unitRobot:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._initFlyRobot, self)
	end
end

function M:createRobot(pos)
	if not self._unitRobot then
		local entityInfo = {}

		entityInfo.entityCode = self._unit.heroId

		if pos then
			entityInfo.x = pos.x
			entityInfo.y = pos.y
			entityInfo.z = pos.z
		else
			entityInfo.x, entityInfo.y, entityInfo.z = self._unit.navMesh:getNavMeshGoPos()
		end

		local curScene = SceneMgr.instance:getCurScene()

		self._unitRobot = curScene.unitFactory:createUnit(UnitTag.Npc, entityInfo)

		self._unitRobot.navMesh:setAgentSpeed(DefualtSpeed)
		self._unitRobot.navMesh:setAvoidancePriority(self._unit.navMesh:getAvoidancePriority())
		self._unitRobot.navMeshMover:setModifyDestination(false)
	end

	return self._unitRobot
end

function M:destroyRobot()
	if self._unitRobot then
		self:_removeRobotListener()
		self._unitRobot.meshModel:clear()

		local curScene = SceneMgr.instance:getCurScene()

		curScene.unitFactory:removeUnit(self._unitRobot:getTag(), self._unitRobot.id)

		self._unitRobot = nil
	end
end

function M:flyNewRobot(luaTable)
	self._flyData = luaTable

	self:switchFollow(false)
	self:createRobot()

	if not self._unitRobot.meshModel:getInst() then
		self._unitRobot:addInnerEventListener(UnitActionType.MeshModelLoaded, self._initFlyRobot, self)
	else
		self:_initFlyRobot()
	end

	return self._unitRobot
end

function M:_initFlyRobot()
	if self._flyData.flyStartCallback then
		self._flyData.flyStartCallback(self._flyData.flyStartTarget, self._unitRobot)
	end

	self._unitRobot:removeInnerEventListener(UnitActionType.MeshModelLoaded, self._initFlyRobot, self)

	local modelGO = self._unitRobot.meshModel:getInst()

	self._unitRobot.meshModel:play(self._flyData.flyActionName, true)
	self._unitRobot.navMesh:setNavMeshAgentStatus(false)
	self._unitRobot.navMeshMover:setStopChangeAngle(true)
	Astral.TransformUtil.SetPos(self._unitRobot.go.transform, self._flyData.unitPos.x, self._flyData.unitPos.y, self._flyData.unitPos.z)
	Astral.TransformUtil.SetLocalPos(modelGO.transform, self._flyData.baseOffset.x + self._flyData.moveOffset.x, self._flyData.baseOffset.y + self._flyData.moveOffset.y, self._flyData.baseOffset.z + self._flyData.moveOffset.z)
	self._unitRobot.navMeshMover:setDirection(self._flyData.direction)
	vec3Temp1:Set(self._flyData.baseOffset.x, self._flyData.baseOffset.y, self._flyData.baseOffset.z)

	local sequence = DG.Tweening.DOTween.Sequence()

	sequence:InsertCallback(0, self._doAlphaRobit, self)
	sequence:Append(modelGO.transform:DOLocalMove(vec3Temp1, self._flyData.flyTime, false))
	sequence:AppendCallback(self._flyData.flyFinCallback, self._flyData.flyFinTarget, self._unitRobot)
	sequence:SetTarget(self._unitRobot.go)
end

function M:_doAlphaRobit()
	self._unitRobot.material:doScreenDoorAlpha(0, 1, self._flyData.flyTime)
end

function M:switchFollow(enabled)
	self._followSwitch = enabled

	if self._unitRobot then
		if enabled then
			self._unitRobot.navMeshMover:setRotationTarget(self._unit.navMesh:getNavMeshGo())
		else
			self._unitRobot.navMeshMover:setRotationTarget(false)
		end
	end
end

function M:getFollowUnit()
	return self._unitRobot
end

function M:update()
	local isDrag = self._unit.model:judgeStatus(PlayerStatus.Draging)

	if self._followSwitch and not self._unit.gravity:isWeightless() and not isDrag and self._unitRobot and self._unitRobot.navMesh:getIsEnable() then
		self:_followUnitFrame()
	end
end

function M:_followUnitFrame()
	if self._unitRobot then
		local rangeZ = 0.1
		local masterPosX, masterPosY, masterPosZ = self._unit.navMesh:getNavMeshGoPos()
		local masterPos = vec3Temp1

		masterPos:Set(masterPosX, masterPosY, masterPosZ)

		local robotPosX, robotPosY, robotPosZ = self._unitRobot.navMesh:getNavMeshGoPos()
		local robotPos = vec3Temp2

		robotPos:Set(robotPosX, robotPosY, robotPosZ)

		local targetZ = masterPosZ + CommEnum.NavMeshRadius.Common * 2
		local distance = Vector3.Distance(masterPos, robotPos)

		if distance > FollowInterval then
			local moveRate = 0.3
			local targetX = (masterPosX - robotPosX) * moveRate + robotPosX
			local targetY = (masterPosY - robotPosY) * moveRate + robotPosY

			vec3Temp1:Set(targetX, targetY, masterPosZ)
			self._unitRobot.navMesh:setDestination(vec3Temp1)

			local speed = distance > AddSpeedInterval and DefualtSpeed * 2 or DefualtSpeed

			self._unitRobot.navMesh:setAgentSpeed(speed)
		elseif robotPosZ < targetZ - rangeZ or robotPosZ > targetZ + rangeZ then
			vec3Temp2:Set(robotPosX, robotPosY, targetZ)
			self._unitRobot.navMesh:setDestination(vec3Temp2)
		end
	end
end

function M:setDestination(pos, offsetScreenX, offsetZ)
	if self._unitRobot then
		offsetScreenX = checknumber(offsetScreenX)

		if offsetScreenX ~= 0 then
			local angle = NavMeshUtil.calculateMoveAngle(pos.x, pos.y)
			local posX, posY = HouseSceneUtil.worldPosByScreenOffset(angle, pos.x, pos.y, offsetScreenX, 0)

			pos.x = posX
			pos.y = posY
		end

		pos.z = pos.z + checknumber(offsetZ)

		self._unitRobot.navMesh:setDestination(pos)
		self._unitRobot.navMesh:resumeNavMesh()
	end
end

function M:setRadius(radius)
	if self._unitRobot then
		self._unitRobot.navMesh.radius = radius or CommEnum.NavMeshRadius.Common
	end
end

function M:setPos(gapX, gapY, gapZ, offsetScreenX, offsetScreenY)
	if self._unitRobot then
		offsetScreenX = checknumber(offsetScreenX)
		offsetScreenY = checknumber(offsetScreenY)

		if offsetScreenX ~= 0 or offsetScreenY ~= 0 then
			local angle = NavMeshUtil.calculateMoveAngle(gapX, gapY)

			gapX, gapY = HouseSceneUtil.worldPosByScreenOffset(angle, gapX, gapY, offsetScreenX, offsetScreenY)
		end

		self._unitRobot.navMesh:setNavMeshAgentStatus(false)
		self._unitRobot.navMesh:setNavAgentPos(gapX, gapY, gapZ)
	end
end

function M:setNavMeshAgentStatus(status)
	if self._unitRobot then
		self._unitRobot.navMesh:setNavMeshAgentStatus(status)
	end
end

function M:setEleVatorSpeed()
	if self._unitRobot then
		self._unitRobot.navMesh:setAgentSpeed(DefualtSpeed - 0.1)
	end
end

function M:setTransportGoods(goodsUnit)
	self._transportGoods = goodsUnit
end

function M:getTransportGoods()
	return self._transportGoods
end

function M:removeTransportGoods()
	if self._transportGoods then
		self._transportGoods:returnSelf()

		self._transportGoods = nil
	end
end

return M
