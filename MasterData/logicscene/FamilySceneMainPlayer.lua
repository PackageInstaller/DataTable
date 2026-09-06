-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/FamilySceneMainPlayer.lua

module("logicscene.scene.component.mainplayer.FamilySceneMainPlayer", package.seeall)

local FamilySceneMainPlayer = class("FamilySceneMainPlayer")

FamilySceneMainPlayer.localScale = 8
FamilySceneMainPlayer.MainPlayerName = "FamilyMainPlayer"
FamilySceneMainPlayer.OffsetY3D = 18

local sceneRoot

function FamilySceneMainPlayer:ctor()
	self.userVar = UserVar.New()
end

function FamilySceneMainPlayer:createMainPlayer()
	local unitGo = goutil.create(FamilySceneMainPlayer.MainPlayerName, false)
	local unitPlayer = FamilyUnitMainPlayer.New(unitGo)

	unitPlayer:Awake()

	unitPlayer.id = RoleModel.instance:getUserId()
	unitGo.transform.localScale = Vector3.one * FamilySceneMainPlayer.localScale

	GameUtil.setLocalRotation(unitGo, 15, 0, 0)

	sceneRoot = sceneRoot or goutil.find("SCENEROOT")

	goutil.addChildToParent(unitGo, sceneRoot)

	self._mainPlayer = unitPlayer
end

function FamilySceneMainPlayer:destroyMainPlayer()
	if self._mainPlayer then
		self._mainPlayer:onUnitDestroyed()

		self._mainPlayer = nil
	end

	self._mainPlayerPet = nil
end

function FamilySceneMainPlayer:showOutline(show)
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

function FamilySceneMainPlayer:getMainPlayer()
	return self._mainPlayer
end

function FamilySceneMainPlayer:getMainPlayerPet()
	return self._mainPlayerPet
end

function FamilySceneMainPlayer:forceSyncMountState()
	local mainPlayer = FamilySceneMainPlayer.instance:getMainPlayer()

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

function FamilySceneMainPlayer:forceMainPlayerIdle()
	local mainPlayer = self:getMainPlayer()

	if mainPlayer and mainPlayer:isVisible() then
		mainPlayer:stopAllActions()
		mainPlayer.spineMover:forceIdleAnim()
	end
end

function FamilySceneMainPlayer:onEnterScene(scene)
	if self._mainPlayer then
		self._mainPlayer.mover:disable(true)
		self._mainPlayer.syncPos:disable(true)
	end

	self._curScene = scene

	GlobalDispatcher:addListener(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, self._onPlayerVariables, self)
end

function FamilySceneMainPlayer:onEnterSceneFinished(scene)
	self._mainPlayer.mover:disable(nil)
	self._mainPlayer.syncPos:disable(nil)

	self._mainPlayer.scene = scene
	self._mainPlayer.go.layer = self._mainPlayer:getLayer()

	self._mainPlayer.spineMover:playDefaultIdleAnim()
	self._mainPlayer.spineMover:playBornEffect()
	self._mainPlayer.hud:updateUserName()
	self._mainPlayer:updateSceneParams()

	self._curScene = scene

	self._mainPlayer:unfrozenMove()
	self._mainPlayer.hud:setOffsetY3D(FamilySceneMainPlayer.OffsetY3D)

	local scale = FamilySceneMainPlayer.localScale

	Framework.TransformUtil.SetLocalScale(self._mainPlayer.go.transform, scale, scale, scale)
end

function FamilySceneMainPlayer:updatePlayerPosition(scene)
	self._mainPlayer.mover:setMainPlayerUnit(scene.stage.wholeScene)
	self:_modifyBirthPoints(scene)
end

function FamilySceneMainPlayer:_modifyBirthPoints(scene)
	local x = scene:getBornX()
	local y = scene:getBornZ()

	self._mainPlayer.syncPos:setLastPos(x, y)
	self._mainPlayer.transform:setPos(x, 0, y)
	self._mainPlayer:setUnderBridge(underBridge)
end

function FamilySceneMainPlayer:onExitScene()
	if self._mainPlayer then
		self._mainPlayer.actions:stopAllActionsOnCrossScene()

		self._mainPlayer.triggerId = nil
		self._mainPlayer.transmitGroupId = nil
		self._mainPlayer.transmitPoint = nil
	end

	GlobalDispatcher:removeListener(GlobalNotify.FamilySceneNotifyVariablesUpdateRes, self._onPlayerVariables, self)
end

function FamilySceneMainPlayer:onExitSceneFinished(scene)
	self._mainPlayerPet = nil

	if self._mainPlayer then
		self._mainPlayer:clearBridgeState()
		self._mainPlayer.sceneUnit:EnabledObstacleChecking(false)
		scene:removeAllUnitPet(self._mainPlayer)
		self._mainPlayer:setVisible(false)
	end
end

function FamilySceneMainPlayer:updateVariablesView()
	self:updateModel()
end

function FamilySceneMainPlayer:updateModel()
	if self._mainPlayer and self._mainPlayer.spine then
		local avatarMo = DressModel.instance:getAvatarByUserVar(self.userVar)

		self._mainPlayer.spine:setBody(avatarMo)
		self._mainPlayer:onUnitVisible()
		self._mainPlayer:setVisible(true)
	end
end

function FamilySceneMainPlayer:updatePet()
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

function FamilySceneMainPlayer:updateCutePet()
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

function FamilySceneMainPlayer:_removeMainPet()
	if self._mainPlayerPet then
		self._curScene:removeUnitPet(self._mainPlayer, SceneUnitBase.UnitMainPlayerPet)

		self._mainPlayerPet = nil
	end
end

function FamilySceneMainPlayer:_onPlayerVariables(userId)
	if checknumber(userId) == LoginModel.instance.userId then
		self:updateVariablesView()
	end
end

function FamilySceneMainPlayer:updateVariables(variables)
	self.userVar:updateData(variables)
end

FamilySceneMainPlayer.instance = FamilySceneMainPlayer.New()

return FamilySceneMainPlayer
