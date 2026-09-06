-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/season/UnitSeasonTeamLeader.lua

module("logicscene.scene.unit.impl.season.UnitSeasonTeamLeader", package.seeall)

local UnitSeasonTeamLeader = class("UnitSeasonTeamLeader", SceneUnitBase)

function UnitSeasonTeamLeader:ctor(componetContainer)
	UnitSeasonTeamLeader.super.ctor(self, componetContainer)

	self._isRunningActionChange = false
end

function UnitSeasonTeamLeader:getTag()
	return UnitTag.Player
end

function UnitSeasonTeamLeader:getLayer()
	return SceneLayer.Unit_Value
end

function UnitSeasonTeamLeader:_initComponents()
	self:_addComponent("transform", UnitCompTransform)
	self:_addComponent("actions", UnitCompActions)
	self:_addComponent("hud", UnitCompHudCommon)
	self:_addComponent("leaderIcon", UnitCompSeasonHead)
	self:_addComponent("spineMover", UnitCompSpineMoverNone)
	self:_addComponent("spine", UnitCompSpineNone)
	self:_addComponent("syncPos", UnitCompSeasonSyncPos)
end

function UnitSeasonTeamLeader:update(deltaTime)
	self.actions:update(deltaTime)
end

function UnitSeasonTeamLeader:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY - 0.2, params.posZ)
	self.transform:setMoveSpeed(params.moveSpeed)

	if not params.moveSpeed or params.moveSpeed <= 0 then
		self.transform:setMoveSpeed(1)
	end

	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self:_checkWholeScene()
	self:setSceneUnit(self._wholeScene:AddSceneUnit(self.go))
end

function UnitSeasonTeamLeader:onUnitVisible(go)
	UnitSeasonTeamLeader.super.onUnitVisible(self, go)

	if not goutil.isNil(self._gameObject) then
		Framework.TransformUtil.SetLocalRotation(self._gameObject.transform, 0, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._gameObject.transform, 0, 0.2, 0)
	end
end

function UnitSeasonTeamLeader:onUnitDestroyed()
	self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.actions:stopAllActions()
	self:OnDestroy()
	self:clearSceneUnit()
end

function UnitSeasonTeamLeader:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self:_checkWholeScene()

	if self._wholeScene then
		self._wholeScene:UpdateCommonUnitPosition(UnitTag.Player, self.id, x, y)
	end
end

function UnitSeasonTeamLeader:_checkWholeScene()
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene
end

function UnitSeasonTeamLeader:getUnitName()
	return
end

function UnitSeasonTeamLeader:getUnitHudType()
	return SceneHudMgr.HUD_NPC
end

function UnitSeasonTeamLeader:getUnitHudOffset()
	return 0, 0, 0
end

function UnitSeasonTeamLeader:runPath(destX, destY, onfinished, onfinishedObj)
	self:stopAllActions(true)

	local gridX, gridY = -1, -1

	if self.teamData then
		local teamMo = self.teamData

		gridX, gridY = teamMo:getClientCurGridXY()
	end

	if gridX == destX and gridY == destY then
		if onfinished then
			if onfinishedObj then
				onfinished(onfinishedObj)
			else
				onfinished()
			end
		end
	else
		local action = UnitActionSeasonGridPathTo.New(destX, destY, gridX, gridY)

		action.onFinished = onfinished
		action.onFinishedObj = onfinishedObj

		action:setNextStepCallBack(self._onReachNewGrid, self)
		self.actions:runAction(action)

		return action
	end
end

function UnitSeasonTeamLeader:_onReachNewGrid(action)
	local gridPaths, pathIdx = action:getGridPathsAndIdx()

	if pathIdx and gridPaths and #gridPaths >= 2 then
		local lastIdx = pathIdx - 2
		local gridX, gridY = gridPaths[lastIdx], gridPaths[lastIdx + 1]

		GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamClientPosUpdated, self, gridX, gridY, false)
	elseif gridPaths and #gridPaths >= 2 then
		local lastIdx = #gridPaths
		local gridX, gridY = gridPaths[lastIdx - 1], gridPaths[lastIdx]

		GlobalDispatcher:dispatch(GlobalNotify.SeasonTeamClientPosUpdated, self, gridX, gridY, false)
	end
end

return UnitSeasonTeamLeader
