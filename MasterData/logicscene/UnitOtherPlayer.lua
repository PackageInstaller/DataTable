-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/impl/UnitOtherPlayer.lua

module("logicscene.scene.unit.impl.UnitOtherPlayer", package.seeall)

local UnitOtherPlayer = class("UnitOtherPlayer", UnitAvatar)

function UnitOtherPlayer:getTag()
	return UnitTag.Player
end

function UnitOtherPlayer:getLayer()
	return SceneLayer.Unit_Value
end

function UnitOtherPlayer:_initComponents()
	UnitOtherPlayer.super._initComponents(self)
	self:_addComponent("spineMover", UnitCompAnimatorMover)
	self:_addUnitCompHudOthersPlayer()
	self:_addComponent("shadow", UnitCompShadowOther)
	self:_addComponent("idleAnimation", UnitCompIdleAnimation)
	self:_addComponent("moveTrace", UnitCompPlayerMoveTrace)
end

function UnitOtherPlayer:_addUnitCompHudOthersPlayer()
	self:_addComponent("hud", UnitCompHudOthersPlayer)
	self:_addComponent("subhud", UnitCompSubHudPlayer)
end

function UnitOtherPlayer:onUnitCreated(params)
	self.transform:setPos(params.posX, params.posY, 0)
	self.transform:addListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.spineMover:playDefaultIdleAnim()
	self:setSceneUnit(self.scene.stage.wholeScene:AddSceneUnit(self.go))

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		self:setUnderBridge(playerMo.underBridge)
	end

	self:updateSceneParams()
end

function UnitOtherPlayer:onUnitDestroyed()
	self.spine:removeListener(UnitNotify.SpineLoaded, self._onPlayerBodyLoaded, self)
	self.scene:removeAllUnitPet(self)
	self.transform:removeListener(UnitNotify.PosChanged, self._onUnitPosChanged, self)
	self.actions:stopAllActions()

	self._wholeScene = nil
	self.isRunningCmdAction = nil
	self._playIdleDelay = nil

	self:clearSceneUnit()
	self:OnDestroy()
end

function UnitOtherPlayer:pushMoveCmd(x, y, underBridge, isteleport)
	if not self:isInFrustum() and not GameUtil.isInFrustum(x, y) then
		self.isRunningCmdAction = nil

		self:_removeCmd(UnitCmdType.Move)
		self.transform:setPos(x, y, nil, isteleport)
		self:setUnderBridge(underBridge)
		self.actions:stopAllActions()
		self:_runNextCmd()
	else
		local cmd = UnitCmdPos.New(x, y, isteleport)

		cmd.underBridge = underBridge

		self:pushCmd(cmd)
	end
end

function UnitOtherPlayer:pushCmd(cmd)
	self._cmds = self._cmds or {}
	self._cmds[#self._cmds + 1] = cmd

	self:_runNextCmd()
end

function UnitOtherPlayer:runAllCmds()
	if self._cmds then
		local cnt = #self._cmds

		for i = 1, cnt do
			self._cmds[i]:runCmd(self)
		end

		self._cmds = nil
	end
end

function UnitOtherPlayer:getUnitName()
	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		return playerMo.name
	end
end

function UnitOtherPlayer:getUnitHudType()
	return SceneHudMgr.HUD_OTHERS_PLAYER
end

function UnitOtherPlayer:getAvatarName()
	return "Player_" .. self.id
end

function UnitOtherPlayer:_removeCmd(typeCmd)
	if self._cmds then
		local cnt = #self._cmds
		local i = 1

		while i <= cnt do
			if self._cmds[i]:cmdType() == typeCmd then
				table.remove(self._cmds, i)

				cnt = cnt - 1
			else
				i = i + 1
			end
		end
	end
end

function UnitOtherPlayer:_removeCmdIndex(index)
	if self._cmds and index then
		local cmd = self._cmds[index]

		if cmd then
			table.remove(self._cmds, index)
		end
	end
end

function UnitOtherPlayer:_runNextCmd()
	if not self.isRunningCmdAction and self._cmds then
		local cmd = self._cmds[1]

		if cmd then
			self:_removeCmdIndex(1)

			local action, hander, handerTgt = cmd:toAction()

			self._hander = hander
			self._handerTgt = handerTgt

			if action then
				self.isRunningCmdAction = true
				action.onFinished = self._onCmdActionFinish
				action.onStoped = self._onCmdActionFinish
				action.onFinishedObj = self
				action.onStopedObj = self

				self.actions:runAction(action)
			else
				cmd:runCmd(self)
				self:_runNextCmd()
			end

			return true
		end
	end
end

function UnitOtherPlayer:stopAllActions()
	UnitCompActions.doNotStopAnimOnMoveActionFinish = true

	self.actions:stopAllActions()

	UnitCompActions.doNotStopAnimOnMoveActionFinish = nil
	self.isRunningCmdAction = nil
end

function UnitOtherPlayer:update(deltaTime)
	UnitCompActions.doNotStopAnimOnMoveActionFinish = true

	self.actions:update(deltaTime)

	UnitCompActions.doNotStopAnimOnMoveActionFinish = nil

	self:_updateIdle(deltaTime)
	self.transform:updateRoatationY(deltaTime)
	self.spine:update()
	self.idleAnimation:update(deltaTime)
	self.moveTrace:update(deltaTime)
end

function UnitOtherPlayer:_updateIdle(deltaTime)
	if not self.isRunningCmdAction and self._playIdleDelay and self._playIdleDelay > 0 then
		self._playIdleDelay = self._playIdleDelay - deltaTime

		if self._playIdleDelay <= 0 then
			self.spineMover:playIdleAnim()
		end
	end
end

function UnitOtherPlayer:_onUnitPosChanged(x, y, z, isSetPosDirectly)
	self._wholeScene = self._wholeScene or self.scene.stage.wholeScene

	if self._wholeScene then
		local posX, posY = self.transform:getPos()

		self._wholeScene:UpdatePlayerUnitPosition(self.id, posX, posY)

		if self._needSyncMPPos then
			local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

			if mainPlayer then
				mainPlayer.syncPos:syncPosition(posX, posY)
				mainPlayer.transform:setPos(posX, posY)
			end
		end
	end
end

function UnitOtherPlayer:_onCmdActionFinish()
	self.isRunningCmdAction = nil
	self._playIdleDelay = 0.15

	if self._hander then
		if self._handerTgt then
			self._hander(self._handerTgt, self)
		else
			self:_hander()
		end
	end

	self._hander = nil
	self._handerTgt = nil

	self:_runNextCmd()
end

function UnitOtherPlayer:onUnitVisible(go)
	self._isClipping = nil

	self:updateUserVariables()
end

function UnitOtherPlayer:onUnitInVisible(go)
	self._gameObject = nil
	self._isClipping = true

	if self._compList then
		local cnt = #self._compList

		for i = 1, cnt do
			local comp = self._compList[i]

			if comp.onUnitInVisible then
				comp:onUnitInVisible(go)
			end
		end
	end
end

function UnitOtherPlayer:updateUserVariables()
	self:updateModel()
	self:updateTitle()
	self:updatePet()
	self:updateCutePet()
	self:setupNameFrame()
	self:updateMoveTrace()
	self:updateTeamMountState()
end

function UnitOtherPlayer:updateModel()
	if self._isClipping then
		return
	end

	if self.spine then
		local playerMo = self:getModelInstance():getPlayerMo(self.id)

		if playerMo then
			local avatarMo = DressModel.instance:getAvatarByUserVar(playerMo.userVar)

			self.spine:setBody(avatarMo)
			self.spine:onUnitVisible()
		end
	end
end

function UnitOtherPlayer:_onPlayerBodyLoaded()
	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		UnitOtherPlayer.super._onPlayerBodyLoaded(self)

		local go = self.spine:getAvatarGo()

		if self._compList then
			for i = 1, #self._compList do
				local comp = self._compList[i]

				if comp ~= self.spine and comp.onUnitVisible then
					comp:onUnitVisible(go)
				end
			end
		end

		self.idleAnimation:onPlayerBodyLoaded()

		if self:getIsCoDriver() then
			self:setVisible(false)
		end
	end
end

function UnitOtherPlayer:updateTitle()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo and self.hud then
		self.hud:setupTitle(playerMo.userVar)
	end
end

function UnitOtherPlayer:setupNameFrame()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo and self.hud then
		self.hud:setupNameFrame(playerMo.userVar)
	end
end

function UnitOtherPlayer:updatePet()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		local obj = playerMo.userVar:getOriginVar(UserVarKey.ANIMALS)

		if obj and checknumber(obj.petId) > 0 then
			local petId = obj.petId
			local petdata = obj.petdata
			local petName = playerMo.userVar:getOriginVar(UserVarKey.ANIMAL_NAME)
			local petUnit = self:getPetUnit(SceneUnitBase.UnitPet)

			if petUnit then
				petUnit:setUnitName(petName)
				petUnit:SetAvatarData(petdata)
				petUnit:updateModel()
			else
				self.scene:createUnitPet(self, petId, petdata, petName, SceneUnitBase.UnitPet)
			end
		else
			self.scene:removeUnitPet(self, SceneUnitBase.UnitPet)
		end
	end
end

function UnitOtherPlayer:updateCutePet()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		local raceId = playerMo.userVar:getOriginVar(UserVarKey.CUTE_PET_RACE)

		if raceId then
			local petdata = {}
			local petName = playerMo.userVar:getOriginVar(UserVarKey.CUTE_PET_NAME)
			local petUnit = self:getPetUnit(SceneUnitBase.UnitCute)

			if petUnit then
				petUnit:setUnitName(petName)
				petUnit:SetAvatarData(petdata)
				petUnit:updateModel()
			else
				self.scene:createUnitPet(self, raceId, petdata, petName, SceneUnitBase.UnitCute)
			end
		else
			self.scene:removeUnitPet(self, SceneUnitBase.UnitCute)
		end
	end
end

function UnitOtherPlayer:updateZoo()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		local obj = playerMo.userVar:getOriginVar(UserVarKey.ZOO_ANIMAL)

		if obj and checknumber(obj.petId) > 0 then
			local petId = obj.petId
			local zooData = obj
			local petUnit = self:getPetUnit(SceneUnitBase.UnitZoo)

			if petUnit then
				petUnit:SetAvatarData(zooData)
				petUnit:updateModel()
			else
				self.scene:createUnitZoo(self, petId, zooData)
			end
		else
			self.scene:removeUnitPet(self, SceneUnitBase.UnitZoo)
		end
	end
end

function UnitOtherPlayer:updateMoveTrace()
	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		local hasTrace = playerMo.userVar:getOriginVar(UserVarKey.FOOT_MOVE_TRACE)

		if hasTrace then
			local resPath = CommonResPath.PlayerWalkTrace
			local gender = playerMo.userVar:getOriginVar(UserVarKey.GENDER)

			if gender == GameEnum.Gender.Female then
				self.moveTrace:setShowEachTime(UnitCompPlayerMoveTrace.TIME_GENDER_FEMALE)
			else
				self.moveTrace:setShowEachTime(UnitCompPlayerMoveTrace.TIME_GENDER_MALE)
			end

			self.moveTrace:setTraceRes(resPath)
		else
			self.moveTrace:setTraceRes()
		end
	end
end

function UnitOtherPlayer:getModelInstance()
	return CityModel.instance
end

function UnitOtherPlayer:updateTeamMountState()
	self._needSyncMPPos = false

	if self._isClipping then
		return
	end

	local playerMo = self:getModelInstance():getPlayerMo(self.id)

	if playerMo then
		local teamMountMemberId = checknumber(playerMo.userVar:getOriginVar(UserVarKey.MOUNT_TEAM))

		if checknumber(teamMountMemberId) == checknumber(RoleModel.instance:getUserId()) then
			self._needSyncMPPos = true
		end

		if self.spine then
			local avatar = self.spine:getAvatar()

			if avatar then
				if teamMountMemberId > 0 then
					local teamPlayerUserVar

					if self._needSyncMPPos then
						teamPlayerUserVar = SceneMainPlayer.instance.userVar
					else
						local playerMo = CityModel.instance:getPlayerMo(tostring(teamMountMemberId))

						if playerMo then
							teamPlayerUserVar = playerMo.userVar
						end
					end

					if teamPlayerUserVar then
						local teamAvatarMo = DressModel.instance:getAvatarByUserVar(teamPlayerUserVar)

						teamAvatarMo.mount = 0
						teamAvatarMo.isMount = false

						avatar.mountCtrl:setFakeAvatarMo(teamAvatarMo)

						if avatar.mountCtrl:isMountLoaded() then
							self.subhud:setFollowTarget(avatar.mountCtrl:getMountBoneByPointType(AvatarHangPointType.SubMount))
						end
					end
				else
					avatar.mountCtrl:resetFakeAvatar()
				end

				local teamMountCaptainId = playerMo.userVar:getOriginVar(UserVarKey.MOUNT_CAPTAIN)

				self:setIsCoDriver(checknumber(teamMountCaptainId) > 0)
				self:setIsMainDriver(checknumber(teamMountMemberId) > 0)
				self.subhud:setCurSubUserId(teamMountMemberId)
				self:setSyncUserVarUserId(teamMountCaptainId)
			end
		end
	end
end

function UnitOtherPlayer:setVisible(visible)
	UnitOtherPlayer.super.setVisible(self, visible)

	if self:getIsCoDriver() and visible then
		self:setVisible(false)
	end
end

return UnitOtherPlayer
