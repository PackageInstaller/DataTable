-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/impl/CreateRoleScene.lua

module("logicscene.scene.impl.CreateRoleScene", package.seeall)

local createrole_male2female_hash = UnityEngine.Animator.StringToHash("createrole_male2female")
local createrole_male2female = UnityEngine.Animator.StringToHash("Base Layer.createrole_male2female")
local createrole_female_hash = UnityEngine.Animator.StringToHash("createrole_female")
local createrole_female = UnityEngine.Animator.StringToHash("Base Layer.createrole_female")
local createrole_female2male_hash = UnityEngine.Animator.StringToHash("createrole_female2male")
local createrole_female2male = UnityEngine.Animator.StringToHash("Base Layer.createrole_female2male")
local createrole_male_hash = UnityEngine.Animator.StringToHash("createrole_male")
local createrole_male = UnityEngine.Animator.StringToHash("Base Layer.createrole_male")
local createrole_enterscene_hash = UnityEngine.Animator.StringToHash("createrole_enterscene")
local createrole_enterscene = UnityEngine.Animator.StringToHash("Base Layer.createrole_enterscene")
local createrole_create = UnityEngine.Animator.StringToHash("create")
local createrole_select = UnityEngine.Animator.StringToHash("select")
local xiaonuo_select = UnityEngine.Animator.StringToHash("male")
local createrole_hudong = UnityEngine.Animator.StringToHash("hudong")
local CreateRoleScene = class("CreateRoleScene", SceneBase)

function CreateRoleScene:_initComponents()
	self:_addComponent("stage", CreateRoleSceneStage)
	self:_addComponent("bgm", CRSceneBgmMgr)
end

function CreateRoleScene:getSceneType()
	return SceneType.CreateRole
end

function CreateRoleScene:onEnter(sceneId, bornX, bornZ)
	HardwareQuality.pushRuntimeQualityPreset(HardwareQuality.QualityLevelType.High)
	HardwareQuality.setDynamicResolutionSwitch(false)
	CreateRoleScene.super.onEnter(self, sceneId, bornX, bornZ)
	GlobalDispatcher:addListener(GlobalNotify.PlayCreateRoleSelGenderAnim, self._onPlayerSelRoleAnim, self)
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
end

function CreateRoleScene:onEnterFinished()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()

	mainCam.gameObject:SetActive(false)
	SDKManager.sensorsTrackLoadingOnce("进入创角场景", "stl_enter_createrole")
	SDKManager.sensorsTrack(BootstrapConstdef.ECPCreateAnimEnd)
	CreateRoleScene.super.onEnterFinished(self)
	ViewMgr.instance:close(ViewName.Login)
	GlobalModel.instance.gameStart:SetActive(false)

	self._stageIns = self.stage:getStageIns()

	self:_initCamera()
	self:_initShip()
	self:_createAvatars()
	self:_createOthers()
	self:_createXiaoNuo()
	self:_loadLightMap(function()
		local _lightDir = self._lmRes[1]:GetMainAsset()
		local _lightTex = self._lmRes[2]:GetMainAsset()
		local _lightmapData = UnityEngine.LightmapData.New()

		_lightmapData.lightmapDir = _lightDir
		_lightmapData.lightmapColor = _lightTex
		UnityEngine.LightmapSettings.lightmaps = {
			_lightmapData
		}
	end)
end

function CreateRoleScene:onExit()
	self._createrolecamera = nil

	self:_clearAoheEffect()
	self:_destroyBeginHuDongTimer()
	self:_destroyStopHuDongAniTimer()
	self:_destroyPlayHuDongLoopTimer()
end

function CreateRoleScene:onExitFinished()
	local mainCamera = CameraTargetMgr.instance:getMainCameraTarget()
	local mainCam = mainCamera:getCamera()

	mainCam.gameObject:SetActive(true)
	HardwareQuality.startFpsMonitor()
	CreateRoleScene.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.StartEnterGame, self._onStartEnterGame, self)
	GlobalDispatcher:removeListener(GlobalNotify.PlayCreateRoleSelGenderAnim, self._onPlayerSelRoleAnim, self)

	if self._female2maleAnimListener then
		self._female2maleAnimListener:RemoveListener()
	end

	if self._male2femaleAnimListener then
		self._male2femaleAnimListener:RemoveListener()
	end

	if self._maleAnimListener then
		self._maleAnimListener:RemoveListener()
	end

	if self._femaleAnimListener then
		self._femaleAnimListener:RemoveListener()
	end

	if self._enterSceneAnimListener then
		self._enterSceneAnimListener:RemoveListener()
	end

	if self._effectObject1 then
		GameEffectManager.instance:stopEffect(self._effectObject1)

		self._effectObject1 = nil
	end

	if self._effectObject2 then
		GameEffectManager.instance:stopEffect(self._effectObject2)

		self._effectObject2 = nil
	end

	if self._avatarMale then
		self._avatarMale:removeListener(AvatarNotify.OnAvatarLoaded, self._onMaleBodyLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarMale)

		self._avatarMale = nil
	end

	if self._avatarFemale then
		self._avatarFemale:removeListener(AvatarNotify.OnAvatarLoaded, self._onFemaleBodyLoaded, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarFemale)

		self._avatarFemale = nil
	end

	if self._avatarPet then
		self._avatarPet:removeListener(AvatarNotify.OnAvatarLoaded, self._createPigComplete1, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarPet)

		self._avatarPet = nil
	end

	if self._avatarPet2 then
		self._avatarPet2:removeListener(AvatarNotify.OnAvatarLoaded, self._createPigComplete2, self)
		AvatarsMgrNew.instance:removeAvatar(self._avatarPet2)

		self._avatarPet2 = nil
	end

	if self._avatarXiaoNuo then
		AvatarsMgrNew.instance:removeAvatar(self._avatarXiaoNuo)

		self._avatarXiaoNuo = nil
	end

	if self._avatarArui then
		AvatarsMgrNew.instance:removeAvatar(self._avatarArui)

		self._avatarArui = nil
	end

	if self._avatarAxiu then
		AvatarsMgrNew.instance:removeAvatar(self._avatarAxiu)

		self._avatarAxiu = nil
	end

	if self._avatarXiaoTian then
		AvatarsMgrNew.instance:removeAvatar(self._avatarXiaoTian)

		self._avatarXiaoTian = nil
	end

	if self._avatarXiaoYan then
		AvatarsMgrNew.instance:removeAvatar(self._avatarXiaoYan)

		self._avatarXiaoYan = nil
	end

	self._currSelStateHash = nil
	self._enteringScene = nil
	self._startEnterScene = nil

	self:_clearLightMapRes()
	HardwareQuality.popRuntimeQualityPreset()
end

function CreateRoleScene:update(deltaTime)
	if self._enteringScene then
		return
	end

	if self._startEnterScene then
		self:_doEnterScene()

		return
	end

	if not goutil.isNil(self._createrolecamera) then
		if UGUIToolHelper.IsTouchDown() then
			self:_onTouchDown()
		elseif UGUIToolHelper.IsTouchUp() then
			self:_onTouchUp()
		end
	end
end

function CreateRoleScene:_doEnterScene()
	self._startEnterScene = nil
	self._enteringScene = true

	self._cameraAnim:CrossFadeInFixedTime(createrole_enterscene_hash, 0)
end

function CreateRoleScene:_getRaycastHitObject()
	local mousePos = UGUIToolHelper.GetTouchPosition()
	local ray = self._createrolecamera:ScreenPointToRay(mousePos)
	local isHit, hitResult = UnityEngine.Physics.Raycast(ray, nil)

	if isHit then
		return hitResult.collider.gameObject
	end
end

function CreateRoleScene:_onTouchDown()
	if not UGUIToolHelper.IsOverUI() then
		if not self._isTouchedDown then
			self._isTouchedDown = true
			self._touchDonwPos = UGUIToolHelper.GetTouchPosition()
			self._timeOnTouchDown = UnityEngine.Time.unscaledTime
			self._ratCastHitObj = self:_getRaycastHitObject()
		end
	else
		self._isTouchedDown = nil
		self._ratCastHitObj = nil
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
	end
end

function CreateRoleScene:_onTouchUp()
	if not self._isTouchedDown then
		return
	end

	local mousePos = UGUIToolHelper.GetTouchPosition()

	if GameUtil.getVector2Distance(mousePos, self._touchDonwPos) >= UGUIToolHelper.touchDragThreshold then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	if UnityEngine.Time.unscaledTime - self._timeOnTouchDown >= 0.2 then
		self._touchDonwPos = nil
		self._timeOnTouchDown = nil
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	self._touchDonwPos = nil
	self._timeOnTouchDown = nil

	if UGUIToolHelper.IsOverUI() then
		self._isTouchedDown = nil
		self._ratCastHitObj = nil

		return
	end

	local hitGo = self:_getRaycastHitObject()

	if hitGo and hitGo == self._ratCastHitObj then
		local name = hitGo.name

		if name == "malePos" then
			GlobalDispatcher:dispatch(GlobalNotify.CreateRoleSelSceneGender, GameEnum.Gender.Male)
		elseif name == "femalePos" then
			GlobalDispatcher:dispatch(GlobalNotify.CreateRoleSelSceneGender, GameEnum.Gender.Female)
		end
	end

	self._isTouchedDown = nil
	self._ratCastHitObj = nil
end

function CreateRoleScene:_initCamera()
	self._cameraNode = goutil.findChild(self._stageIns, "ship/camPos")
	self._createrolecamera = goutil.findChild(self._stageIns, "ship/camPos/createrolecamera"):GetComponent(ComponentType.Camera)
	self._cameraAnim = self._cameraNode:GetComponent(ComponentType.Animator)

	local behaviours = self._cameraAnim:GetBehaviours(createrole_female, 0)

	if behaviours and behaviours.Length > 0 then
		self._femaleAnimListener = behaviours[0]

		self._femaleAnimListener:AddListener(self._onSelectRoleAnimFinished, self)
	end

	behaviours = self._cameraAnim:GetBehaviours(createrole_male, 0)

	if behaviours and behaviours.Length > 0 then
		self._maleAnimListener = behaviours[0]

		self._maleAnimListener:AddListener(self._onSelectRoleAnimFinished, self)
	end

	behaviours = self._cameraAnim:GetBehaviours(createrole_male2female, 0)

	if behaviours and behaviours.Length > 0 then
		self._male2femaleAnimListener = behaviours[0]

		self._male2femaleAnimListener:AddListener(self._onSelectRoleAnimFinished, self)
	end

	behaviours = self._cameraAnim:GetBehaviours(createrole_female2male, 0)

	if behaviours and behaviours.Length > 0 then
		self._female2maleAnimListener = behaviours[0]

		self._female2maleAnimListener:AddListener(self._onSelectRoleAnimFinished, self)
	end

	behaviours = self._cameraAnim:GetBehaviours(createrole_enterscene, 0)

	if behaviours and behaviours.Length > 0 then
		self._enterSceneAnimListener = behaviours[0]

		self._enterSceneAnimListener:AddListener(self._onEnterSceneAnimFinished, self)
	end
end

function CreateRoleScene:_initShip()
	self._shipNode = goutil.findChild(self._stageIns, "ship")
	self._malePos = goutil.findChild(self._stageIns, "ship/malePos")
	self._femalePos = goutil.findChild(self._stageIns, "ship/femalePos")
	self._othersPos1 = goutil.findChild(self._stageIns, "ship/othersPos1")
	self._othersPos2 = goutil.findChild(self._stageIns, "ship/othersPos2")
	self._othersPos3 = goutil.findChild(self._stageIns, "ship/othersPos3")
	self._othersPos4 = goutil.findChild(self._stageIns, "ship/othersPos4")
	self._othersPos5 = goutil.findChild(self._stageIns, "ship/othersPos5")
	self._othersPos6 = goutil.findChild(self._stageIns, "ship/othersPos6")
	self._othersPos7 = goutil.findChild(self._stageIns, "ship/othersPos7")
	self._shipAnim = self._shipNode:GetComponent(ComponentType.Animator)

	Framework.TransformUtil.SetLocalPos(self._shipNode.transform, 0, 0, 0)
end

function CreateRoleScene:_createAvatars()
	LightMgr.instance:setLightForCreateRole()

	self._isMaleLoaded = false
	self._isFemaleLoaded = false
	self._avatarMale = AvatarsMgrNew.instance:getAvatarByType(1)

	self._avatarMale:setParent(self._malePos.transform)
	self._avatarMale:setLayer(SceneLayer.Invisible_Value)
	self._avatarMale:addListener(AvatarNotify.OnAvatarLoaded, self._onMaleBodyLoaded, self)

	self._avatarFemale = AvatarsMgrNew.instance:getAvatarByType(1)

	self._avatarFemale:setParent(self._femalePos.transform)
	self._avatarFemale:setLayer(SceneLayer.Invisible_Value)
	self._avatarFemale:addListener(AvatarNotify.OnAvatarLoaded, self._onFemaleBodyLoaded, self)
	self._avatarFemale:updateByMo(DressModel.instance:getAvatarMoWithDefaultSuit(GameEnum.Gender.Female))
	self._avatarMale:updateByMo(DressModel.instance:getAvatarMoWithDefaultSuit(GameEnum.Gender.Male))
end

function CreateRoleScene:_onMaleBodyLoaded()
	self._isMaleLoaded = true

	goutil.setActive(self._avatarMale:getGameObject(), true)
	self._avatarMale.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
	self._avatarMale.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))
	self._avatarMale.animatorCtrl:setBool(createrole_create, true)
	self._avatarMale:setLayer(SceneLayer.UI3DEx_Value)

	self._effectObject1 = GameEffectManager.instance:playEffect("effect/prefabs/ui/fx_aoqinv_lizi.prefab", true, 0, 0, 0, 0, nil, function(ref, eff)
		local obj = goutil.findChild(self._avatarMale:getGameObject(), "Bone015")

		goutil.addChildToParent(eff.effGo, obj)
		eff.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer)):Clear()
	end)

	self:_createAoheEffect()
	self:_startShowShip()
end

function CreateRoleScene:_createAoheEffect()
	self._mofangEffect = GameEffectManager.instance:playEffect("effect/prefabs/ui/fx_chouka/mofang/30010_aohe/chuangjue_aohe.prefab", true, 0, 0, 0, 0, nil, function(ref, eff)
		local obj = goutil.findChild(self._avatarMale:getGameObject(), "Bip001/Bip001 Pelvis/Bip001 Spine/Bip001 Spine1/Bip001 Spine2/Bip001 L Clavicle/Bip001 L UpperArm/Bip001 L Forearm/Bip001 L Hand/")

		goutil.addChildToParent(eff.effGo, obj)
		GameUtil.setLocalPos(eff.effGo, -0.091, 0.45, -0.025)

		self._mofangEffectAnimator = eff.effGo:GetComponent(ComponentType.Animator)
	end)
end

function CreateRoleScene:_clearAoheEffect()
	if self._mofangEffect then
		GameEffectManager.instance:stopEffect(self._mofangEffect)

		self._mofangEffect = nil
	end

	self._mofangEffectAnimator = nil
end

function CreateRoleScene:_onFemaleBodyLoaded()
	self._isFemaleLoaded = true

	goutil.setActive(self._avatarFemale:getGameObject(), true)
	self._avatarFemale.animatorCtrl:resetCurAnimators()
	self._avatarFemale.animatorCtrl:setBool(UnityEngine.Animator.StringToHash("ui"), false)
	self._avatarFemale.animatorCtrl:playAnim(UnityEngine.Animator.StringToHash("Base Layer.idle"))
	self._avatarFemale.animatorCtrl:setBool(createrole_create, true)
	self._avatarFemale:setLayer(SceneLayer.UI3DEx_Value)

	self._effectObject2 = GameEffectManager.instance:playEffect("effect/prefabs/ui/fx_aoqinv_lizi.prefab", true, 0, 0, 0, 0, nil, function(ref, eff)
		local obj = goutil.findChild(self._avatarFemale:getGameObject(), "Bip001/Bip001 Pelvis/qunzi_kong/Bone099")

		goutil.addChildToParent(eff.effGo, obj)
		eff.effGo:GetComponentInChildren(typeof(UnityEngine.TrailRenderer)):Clear()
	end)

	self:_startShowShip()
end

function CreateRoleScene:_startShowShip()
	if self._isFemaleLoaded and self._isMaleLoaded then
		self._startEnterScene = true
	end
end

function CreateRoleScene:_onEnterSceneAnimFinished(state, animator, stateInfo, layerIndex)
	if state == AnimatorListener.STATE_FINISH and createrole_enterscene_hash == stateInfo.shortNameHash then
		self._enteringScene = nil

		local info = RoleModel.instance.PreCreatePlayerInfo

		if info and not string.nilorempty(info.userName) then
			self:_onPlayerSelRoleAnim(-1, checknumber(info.gender))
			ViewMgr.instance:open(ViewName.CreateRole, checknumber(info.gender))

			if info.validResultCode == 0 then
				ViewMgr.instance:open(ViewName.PreroleView)
			else
				local msg = lang("您在预创角活动中起的角色名不符合文明用语喔，请重新起名。")

				TipsFacade.instance:openTipWindowNoX(lang("tip"), msg .. "[" .. info.validResultCode .. "]")
			end
		else
			ViewMgr.instance:open(ViewName.CreateRole)
		end
	end
end

function CreateRoleScene:_onSelectRoleAnimFinished(state, animator, stateInfo, layerIndex)
	if state == AnimatorListener.STATE_FINISH and self._currSelStateHash == stateInfo.shortNameHash then
		GlobalDispatcher:dispatch(GlobalNotify.FinishCreateRoleSelGenderAnim)
	end
end

function CreateRoleScene:_onPlayerSelRoleAnim(preGender, currGender, test)
	self._currSelStateHash = nil

	if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_select, false)
	end

	self:_destroyStopHuDongAniTimer()
	self:_destroyPlayHuDongLoopTimer()

	if currGender < 0 then
		if preGender ~= -1 then
			self._startEnterScene = nil
			self._enteringScene = true

			self._cameraAnim:CrossFadeInFixedTime(createrole_enterscene_hash, 0)

			if self._avatarFemale then
				self._avatarFemale.animatorCtrl:setBool(createrole_select, false)
				self._avatarFemale.animatorCtrl:setBool(createrole_create, true)
			end

			if self._avatarMale then
				self._avatarMale.animatorCtrl:setBool(createrole_select, false)
				self._avatarMale.animatorCtrl:setBool(createrole_create, true)
			end

			if self._mofangEffectAnimator then
				self._mofangEffectAnimator:SetBool(createrole_hudong, false)
			end

			LightMgr.instance:setLightParam(LightMgr.LightType.FarSceneLight)

			if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
				self._avatarXiaoNuo.animatorCtrl:setBool(createrole_select, false)
			end
		end

		return
	end

	if currGender == GameEnum.Gender.Female then
		LightMgr.instance:setLightParam(LightMgr.LightType.NearSceneLight)
	end

	if currGender == GameEnum.Gender.Male then
		LightMgr.instance:setLightParam(LightMgr.LightType.NearSceneLight)
	end

	if preGender < 0 and currGender == GameEnum.Gender.Female then
		self._currSelStateHash = createrole_female_hash
	elseif preGender < 0 and currGender == GameEnum.Gender.Male then
		self._currSelStateHash = createrole_male_hash
	elseif preGender == GameEnum.Gender.Male and currGender == GameEnum.Gender.Female then
		self._currSelStateHash = createrole_male2female_hash
	elseif preGender == GameEnum.Gender.Female and currGender == GameEnum.Gender.Male then
		self._currSelStateHash = createrole_female2male_hash
	end

	local maleSelect = currGender == GameEnum.Gender.Male

	if preGender ~= currGender then
		if self._avatarMale and self._avatarMale.animatorCtrl then
			self._avatarMale.animatorCtrl:setBool(createrole_select, maleSelect)
		end

		if self._avatarFemale and self._avatarFemale.animatorCtrl then
			self._avatarFemale.animatorCtrl:setBool(createrole_select, not maleSelect)
		end

		if self._cameraAnim then
			self._cameraAnim:CrossFadeInFixedTime(self._currSelStateHash, 0)
		end

		self._playHuDongLoopMaleSelect = maleSelect

		if preGender == -1 then
			self:_beginHuDong()
		else
			settimer(0.05, self._beginHuDongTimer, self, false)
		end
	end

	if maleSelect then
		if not GameEnum.RoleCV.Male then
			local voiceTab = GameEnum.RoleCV.Female

			self.lastRandom = self.lastRandom or {}

			local indexNew

			for i = 1, 5 do
				indexNew = math.random(1, #voiceTab)

				if indexNew ~= self.lastRandom[currGender] then
					break
				end
			end

			self.lastRandom[currGender] = indexNew

			local voiceId = voiceTab[indexNew]

			AudioPlayerEx.instance:playVoice(voiceId)
			print(">>>>>>>>>>>>>>>  AudioPlayerEx.instance:playVoice(voiceId) ", test)
		end
	end
end

function CreateRoleScene:_beginHuDong()
	if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
		self._avatarXiaoNuo.animatorCtrl:setBool(xiaonuo_select, self._playHuDongLoopMaleSelect)
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_select, true)
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_hudong, true)
	end

	if self._avatarMale and self._avatarMale.animatorCtrl then
		self._avatarMale.animatorCtrl:setBool(createrole_hudong, self._playHuDongLoopMaleSelect)
	end

	if self._mofangEffectAnimator then
		self._mofangEffectAnimator:SetBool(createrole_hudong, self._playHuDongLoopMaleSelect)
	end

	if self._avatarFemale and self._avatarFemale.animatorCtrl then
		self._avatarFemale.animatorCtrl:setBool(createrole_hudong, not self._playHuDongLoopMaleSelect)
	end

	self:_stopHuDongAnimation()
end

function CreateRoleScene:_beginHuDongTimer()
	self:_destroyBeginHuDongTimer()
	self:_beginHuDong()
end

function CreateRoleScene:_destroyBeginHuDongTimer()
	removetimer(self._beginHuDongTimer, self)
end

function CreateRoleScene:_stopHuDongAnimation()
	local _frameCount = self._playHuDongLoopMaleSelect and 180 or 200

	settimer(_frameCount / 30, self._stopHuDongAniTimer, self, false)
end

function CreateRoleScene:_stopHuDongAniTimer()
	self:_destroyStopHuDongAniTimer()
	self:_playHuDongLoop(self._playHuDongLoopMaleSelect)
end

function CreateRoleScene:_destroyStopHuDongAniTimer()
	removetimer(self._stopHuDongAniTimer, self)

	if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_hudong, false)
	end

	if self._avatarMale and self._avatarMale.animatorCtrl then
		self._avatarMale.animatorCtrl:setBool(createrole_hudong, false)
	end

	if self._mofangEffectAnimator then
		self._mofangEffectAnimator:SetBool(createrole_hudong, false)
	end

	if self._avatarFemale and self._avatarFemale.animatorCtrl then
		self._avatarFemale.animatorCtrl:setBool(createrole_hudong, false)
	end
end

function CreateRoleScene:_playHuDongLoop()
	local _frameCount = self._playHuDongLoopMaleSelect and 320 or 472

	if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_select, true)
	end

	settimer(_frameCount / 30, self._playHuDongLoopTimer, self, false)
end

function CreateRoleScene:_playHuDongLoopTimer()
	self:_destroyPlayHuDongLoopTimer()

	if self._avatarXiaoNuo and self._avatarXiaoNuo.animatorCtrl then
		self._avatarXiaoNuo.animatorCtrl:setBool(createrole_hudong, true)
	end

	if self._avatarMale and self._avatarMale.animatorCtrl then
		self._avatarMale.animatorCtrl:setBool(createrole_hudong, self._playHuDongLoopMaleSelect)
	end

	if self._mofangEffectAnimator then
		self._mofangEffectAnimator:SetBool(createrole_hudong, self._playHuDongLoopMaleSelect)
	end

	if self._avatarFemale and self._avatarFemale.animatorCtrl then
		self._avatarFemale.animatorCtrl:setBool(createrole_hudong, not self._playHuDongLoopMaleSelect)
	end

	self:_stopHuDongAnimation()
end

function CreateRoleScene:_destroyPlayHuDongLoopTimer()
	removetimer(self._playHuDongLoopTimer, self)
end

function CreateRoleScene:_onStartEnterGame()
	return
end

function CreateRoleScene:_createOthers()
	self._avatarPet = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)
	self._avatarPet2 = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local avatarPigMo = AvatarConfig.instance:getAvatarMoByCfgId(3)

	avatarPigMo:setDataByCfgId(1035801)
	avatarPigMo:setDataByCfgId(1035811)
	self._avatarPet:updateByMo(avatarPigMo)
	avatarPigMo:setDataByCfgId(1035803)
	avatarPigMo:setDataByCfgId(1035812)
	self._avatarPet2:updateByMo(avatarPigMo)
	self._avatarPet:addListener(AvatarNotify.OnAvatarLoaded, self._createPigComplete1, self)
	self._avatarPet2:addListener(AvatarNotify.OnAvatarLoaded, self._createPigComplete2, self)
	self._avatarPet:setLayer(SceneLayer.UI3DEx_Value)
	self._avatarPet2:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_createPigComplete1()
	if not self._avatarPet then
		return
	end

	self._avatarPet:setParent(self._othersPos1.transform)
end

function CreateRoleScene:_createPigComplete2()
	if not self._avatarPet2 then
		return
	end

	self._avatarPet2:setParent(self._othersPos2.transform)
end

function CreateRoleScene:_createXiaoNuo()
	self._avatarXiaoNuo = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local avatarWuWangMo = AvatarConfig.instance:getAvatarMoByCfgId(4)

	self._avatarXiaoNuo:updateByMo(avatarWuWangMo)
	self._avatarXiaoNuo:setParent(self._othersPos3.transform)
	self._avatarXiaoNuo:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_createArui()
	self._avatarArui = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local _avatarAruiMo = AvatarConfig.instance:getAvatarMoByCfgId(5)

	self._avatarArui:updateByMo(_avatarAruiMo)
	self._avatarArui:setParent(self._othersPos4.transform)
	self._avatarArui:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_createAxiu()
	self._avatarAxiu = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local _avatarAxiuMo = AvatarConfig.instance:getAvatarMoByCfgId(6)

	self._avatarAxiu:updateByMo(_avatarAxiuMo)
	self._avatarAxiu:setParent(self._othersPos5.transform)
	self._avatarAxiu:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_createXiaoTian()
	self._avatarXiaoTian = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local _avatarXiaoTianMo = AvatarConfig.instance:getAvatarMoByCfgId(7)

	self._avatarXiaoTian:updateByMo(_avatarXiaoTianMo)
	self._avatarXiaoTian:setParent(self._othersPos6.transform)
	self._avatarXiaoTian:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_createXiaoYan()
	self._avatarXiaoYan = AvatarsMgrNew.instance:getAvatarByType(AvatarCreateType.Pig)

	local _avatarXiaoYanMo = AvatarConfig.instance:getAvatarMoByCfgId(8)

	self._avatarXiaoYan:updateByMo(_avatarXiaoYanMo)
	self._avatarXiaoYan:setParent(self._othersPos7.transform)
	self._avatarXiaoYan:setLayer(SceneLayer.UI3DEx_Value)
end

function CreateRoleScene:_loadLightMap(_call_back)
	if self._lmRes then
		return
	end

	self._lmResLoader = MultiResLoader.New()
	self._lmResourcesList = {}

	table.insert(self._lmResourcesList, "lightmap/createrolescene/lightmap-0_comp_dir.png")
	table.insert(self._lmResourcesList, "lightmap/createrolescene/lightmap-0_comp_light.exr")
	self._lmResLoader:setResPaths(self._lmResourcesList)
	self._lmResLoader:load(function()
		self._lmRes = {}

		for i = 1, #self._lmResourcesList do
			self._lmRes[i] = self._lmResLoader:getResource(self._lmResourcesList[i])
		end

		if _call_back then
			_call_back()
		end
	end, nil, self)
end

function CreateRoleScene:_clearLightMapRes()
	if self._lmResLoader then
		GameUtil.unloadMultiResLoaderResource(self._lmResLoader)

		self._lmResLoader = nil
	end

	if self._lmRes then
		for i = 1, #self._lmRes do
			if self._lmRes[i] ~= nil then
				self._lmRes[i] = nil
			end
		end

		self._lmRes = nil
	end
end

return CreateRoleScene
