-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/SceneMainPlayer.lua

module("logicscene.scene.component.mainplayer.SceneMainPlayer", package.seeall)

local SceneMainPlayer = class("SceneMainPlayer")

SceneMainPlayer.localScale = 0.75
SceneMainPlayer.MainPlayerName = "MainPlayer"

local sceneRoot

function SceneMainPlayer:ctor()
	self.userVar = UserVar.New()
end

function SceneMainPlayer:createMainPlayer()
	local unitGo = goutil.create(SceneMainPlayer.MainPlayerName, false)
	local unitPlayer = UnitMainPlayer.New(unitGo)

	unitPlayer:Awake()

	unitPlayer.id = RoleModel.instance:getUserId()
	unitGo.transform.localScale = Vector3.one * SceneMainPlayer.localScale
	sceneRoot = sceneRoot or goutil.find("SCENEROOT")

	goutil.addChildToParent(unitGo, sceneRoot)

	self._mainPlayer = unitPlayer
end

function SceneMainPlayer:destroyMainPlayer()
	if self._mainPlayer then
		self._mainPlayer:onUnitDestroyed()

		self._mainPlayer = nil
	end

	self._mainPlayerPet = nil

	self.userVar:clear()
end

function SceneMainPlayer:showOutline(show)
	local var_4_0 = self._mainPlayer

	if self._mainPlayer then
		var_4_0 = self._mainPlayer.spine

		if self._mainPlayer.spine then
			local _avatar = self._mainPlayer.spine:getAvatar()
			local _partsCtrl = _avatar and _avatar.partsCtrl

			if _partsCtrl then
				_partsCtrl:showOutline(show)
			end
		end
	end
end

function SceneMainPlayer:getMainPlayer()
	return self._mainPlayer
end

function SceneMainPlayer:getMainPlayerPet()
	return self._mainPlayerPet
end

function SceneMainPlayer:forceSyncMountState()
	local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

	if not mainPlayer then
		return
	end

	if mainPlayer.idleAnimation and mainPlayer.idleAnimation.isPlayingIdleAnim and mainPlayer.idleAnimation:isPlayingIdleAnim() then
		return
	end

	local isMainPlayerMount = mainPlayer and mainPlayer.isMounting
	local mountId = MountModel.instance:getCurMountId()

	if mountId and mountId > 0 and not isMainPlayerMount then
		MountController.instance:mountChange(0)
	end
end

function SceneMainPlayer:forceMainPlayerIdle()
	local mainPlayer = self:getMainPlayer()

	if mainPlayer and mainPlayer:isVisible() then
		mainPlayer:stopAllActions()
		TaskController.instance:stopAction()
		mainPlayer.spineMover:forceIdleAnim()
	end
end

function SceneMainPlayer:onEnterScene(scene)
	if self._mainPlayer then
		self._mainPlayer.mover:disable(true)
		self._mainPlayer.syncPos:disable(true)
	end

	self._curScene = scene

	GlobalDispatcher:addListener(GlobalNotify.OnPlayerVariables, self._onPlayerVariables, self)
end

function SceneMainPlayer:onEnterSceneFinished(scene)
	self._mainPlayer:setVisible(false)
	self._mainPlayer.mover:disable(nil)
	self._mainPlayer.syncPos:disable(nil)

	self._mainPlayer.scene = scene
	self._mainPlayer.go.layer = self._mainPlayer:getLayer()

	self._mainPlayer.spineMover:playDefaultIdleAnim()
	self._mainPlayer.spineMover:playBornEffect()
	self._mainPlayer.hud:updateUserName()
	self._mainPlayer:updateSceneParams()
	self._mainPlayer.sceneUnit:EnabledObstacleChecking(true)

	self._curScene = scene

	if not scene:isSwithFestival() then
		self._mainPlayer.birthEff:playEnterScene()
	end

	self._mainPlayer:unfrozenMove()
end

function SceneMainPlayer:updatePlayerPosition(scene)
	local mainUnit = scene.stage.wholeScene:AddMainPlayerUnit(self._mainPlayer.go)

	self._mainPlayer.mover:setMainPlayerUnit(mainUnit)
	self._mainPlayer:setSceneUnit(mainUnit)
	self:_modifyBirthPoints(scene)
end

function SceneMainPlayer:_modifyBirthPoints(scene)
	local x = scene:getBornX()
	local y = scene:getBornZ()
	local underBridge = scene:isUnderBridge()

	scene.stage.wholeScene:SetBirthPoint(x, y)
	self._mainPlayer.syncPos:setLastPos(x, y)
	self._mainPlayer.transform:setPos(x, y)
	self._mainPlayer:setUnderBridge(underBridge)
end

function SceneMainPlayer:onExitScene()
	if self._mainPlayer then
		self._mainPlayer.birthEff:stopEnterScene()
		self._mainPlayer.actions:stopAllActionsOnCrossScene()

		self._mainPlayer.triggerId = nil
		self._mainPlayer.transmitGroupId = nil
		self._mainPlayer.transmitPoint = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.OnPlayerVariables, self._onPlayerVariables, self)
end

function SceneMainPlayer:onExitSceneFinished(scene)
	self._mainPlayerPet = nil

	if self._mainPlayer then
		self._mainPlayer:clearBridgeState()
		self._mainPlayer.sceneUnit:EnabledObstacleChecking(false)
		scene:removeAllUnitPet(self._mainPlayer)
		self._mainPlayer:setVisible(false)
	end
end

function SceneMainPlayer:updateVariablesView()
	if not self._curScene or not self._curScene.stage or not self._curScene.stage.wholeScene then
		return
	end

	if self._curScene then
		local type = self._curScene:getSceneType()

		if type == SceneType.SeasonTiling or type == SceneType.Battle or type == SceneType.TreasureRaider or type == SceneType.CutePet then
			return
		end
	end

	self:updateModel()
	self:updatePet()
	self:updateCutePet()
	self:updateMoveTrace()
	self:updateTeamMountState()
end

function SceneMainPlayer:updateModel()
	if self._mainPlayer and self._mainPlayer.spine then
		local avatarMo = DressModel.instance:getAvatarByUserVar(self.userVar)

		self._mainPlayer.spine:setBody(avatarMo)
		self._mainPlayer:onUnitVisible()
	end
end

function SceneMainPlayer:updatePet()
	if self._mainPlayer then
		local obj = self.userVar:getOriginVar(UserVarKey.ANIMALS)

		if obj and checknumber(obj.petId) > 0 then
			local petId = obj.petId
			local petdata = obj.petdata
			local petUnit = self._mainPlayer:getPetUnit(SceneUnitBase.UnitPet)
			local petName = self.userVar:getOriginVar(UserVarKey.ANIMAL_NAME)

			if petUnit then
				petUnit:setUnitName(petName)
				petUnit:SetAvatarData(petdata)
				petUnit:updateModel()
			else
				self._curScene:createUnitPet(self._mainPlayer, petId, petdata, petName, SceneUnitBase.UnitPet)
			end
		else
			self._curScene:removeUnitPet(self._mainPlayer, SceneUnitBase.UnitPet)
		end
	end
end

function SceneMainPlayer:updateCutePet()
	self:_removeMainPet()

	if self._mainPlayer then
		local raceId = self.userVar:getOriginVar(UserVarKey.CUTE_PET_RACE)

		if raceId then
			local petdata = {}
			local petName = self.userVar:getOriginVar(UserVarKey.CUTE_PET_NAME)
			local petUnit = self._mainPlayer:getPetUnit(SceneUnitBase.UnitCute)

			if petUnit then
				petUnit:setUnitName(petName)
				petUnit:SetAvatarData(petdata)
				petUnit:updateModel()
			else
				self._curScene:createUnitPet(self._mainPlayer, raceId, petdata, petName, SceneUnitBase.UnitCute)
			end
		else
			self._curScene:removeUnitPet(self._mainPlayer, SceneUnitBase.UnitCute)

			self._mainPlayerPet = self._curScene:createMainPlayerPet()
		end
	end
end

function SceneMainPlayer:updateMoveTrace()
	if self._mainPlayer then
		self._mainPlayer.moveTrace:setTraceRes()

		local hasTrace = self.userVar:getOriginVar(UserVarKey.FOOT_MOVE_TRACE)

		if hasTrace then
			local resPath = CommonResPath.PlayerWalkTrace
			local gender = self.userVar:getOriginVar(UserVarKey.GENDER)

			if gender == GameEnum.Gender.Female then
				self._mainPlayer.moveTrace:setShowEachTime(UnitCompPlayerMoveTrace.TIME_GENDER_FEMALE)
			else
				self._mainPlayer.moveTrace:setShowEachTime(UnitCompPlayerMoveTrace.TIME_GENDER_MALE)
			end

			self._mainPlayer.moveTrace:setTraceRes(resPath)
		end
	end
end

function SceneMainPlayer:_removeMainPet()
	if self._mainPlayerPet then
		self._curScene:removeUnitPet(self._mainPlayer, SceneUnitBase.UnitMainPlayerPet)

		self._mainPlayerPet = nil
	end
end

function SceneMainPlayer:_onPlayerVariables(userId)
	if checknumber(userId) == LoginModel.instance.userId then
		self:updateVariablesView()
	end
end

function SceneMainPlayer:updateVariables(variables)
	self.userVar:updateData(variables)

	if self._mainPlayer then
		local syncUserVarUserId = self._mainPlayer:getSyncUserVarUserId()

		if checknumber(syncUserVarUserId) > 0 then
			local syncUnit = self._curScene.unitFactory:getUnit(UnitTag.Player, tostring(syncUserVarUserId))

			if syncUnit then
				syncUnit:updateUserVariables()
			end
		end
	end
end

function SceneMainPlayer:ResetPlayerVariables()
	self.userVar:deleteVar(UserVarKey.CONVOY_STATE)
	self.userVar:deleteVar(UserVarKey.CONVOY_BOX_ID)
	self:updateVariablesView()
end

function SceneMainPlayer:updateTeamMountState()
	self._isTeamMountMenber = nil

	if self._mainPlayer then
		local teamMountCaptainId = checknumber(self.userVar:getOriginVar(UserVarKey.MOUNT_CAPTAIN))

		if teamMountCaptainId > 0 then
			local playerMo = CityModel.instance:getPlayerMo(tostring(teamMountCaptainId))

			if playerMo then
				self._mainPlayer.syncPos:syncPosition(playerMo.x, playerMo.y)
				self._mainPlayer.transform:setPos(playerMo.x, playerMo.y)
			end

			self._isTeamMountMenber = true
		else
			self._isTeamMountMenber = false
		end

		local teamMountMemberId = checknumber(self.userVar:getOriginVar(UserVarKey.MOUNT_TEAM))
		local var_24_0 = self._mainPlayer

		if self._mainPlayer then
			var_24_0 = self._mainPlayer.spine

			if self._mainPlayer.spine then
				local avatar = self._mainPlayer.spine:getAvatar()

				if avatar then
					if teamMountMemberId > 0 then
						local playerMo = CityModel.instance:getPlayerMo(tostring(teamMountMemberId))

						if playerMo then
							local avatarMo = DressModel.instance:getAvatarByUserVar(playerMo.userVar)

							avatarMo.mount = 0
							avatarMo.isMount = false

							avatar.mountCtrl:setFakeAvatarMo(avatarMo)
						end

						self._mainPlayer.subhud:setFollowTarget(avatar.mountCtrl:getMountBoneByPointType(AvatarHangPointType.SubMount))
					else
						avatar.mountCtrl:resetFakeAvatar()
					end
				end

				self._mainPlayer:setIsCoDriver(self._isTeamMountMenber)
				self._mainPlayer:setIsMainDriver(teamMountMemberId > 0)
				self._mainPlayer.subhud:setCurSubUserId(teamMountMemberId)
				self._mainPlayer:setSyncUserVarUserId(teamMountCaptainId)
				self._curScene:recordForcedVisiblePlayers(teamMountCaptainId)
			end
		end
	end
end

SceneMainPlayer.instance = SceneMainPlayer.New()

return SceneMainPlayer
