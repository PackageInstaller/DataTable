-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/uispine/UISpine.lua

module("logic.uispine.UISpine", package.seeall)

local UISpine = class("UISpine")

if Spine then
	UISpine.SkeletonGraphicType = typeof(Spine.Unity.SkeletonGraphic)
end

function UISpine.Get(go)
	return Astral.LuaComponentContainer.Add(go, UISpine)
end

function UISpine:ctor(componentContainer)
	self._go = componentContainer.gameObject
	self._size = Vector2.New()
	self._url = nil
	self._skeletonLoader = PrefabLoader.Get(self._go)
	self._skeletonGraphic = nil
	self._weaponResPath = nil
	self._defaultAnimState = UnitAnimState.Idle
	self._curAnimState = nil
	self._isLoop = true
	self._isFlipX = false
	self._enableClick = false
	self._clickGO = nil
	self._hangPointPath1 = "ssrguadian_01"
	self._hangPointPath2 = "ssrguadian_02"
	self._effectUrl1 = nil
	self._effectRes1 = nil
	self._effectGo1 = nil
	self._effectUrl2 = nil
	self._effectRes2 = nil
	self._effectGo2 = nil
	self._showAnimIndex = 1
	self._showAnims = {}
	self._playTime = 1
	self._huanHuaZhong = false
	self._actionHandler = nil
	self._actionHandlerObj = nil
	self._playSpeed = 1
	self._isPause = false
	self._defaultMat = nil
end

function UISpine:setDirection(dir)
	local isFlipX = dir ~= UnitSpineDir.Default

	if self._isFlipX == isFlipX then
		return
	end

	self._isFlipX = isFlipX

	if self._skeletonGraphic then
		self._skeletonGraphic.Skeleton.FlipX = self._isFlipX
	end
end

function UISpine:getDirection()
	if not self._isFlipX then
		return UnitSpineDir.Default
	elseif UnitSpineDir.Default == UnitSpineDir.Right then
		return UnitSpineDir.Left
	else
		return UnitSpineDir.Right
	end
end

function UISpine:setBodyLoadedParm(parmTable)
	self._bodyLoadedParmTable = parmTable
end

function UISpine:getBodyLoadedParm()
	return self._bodyLoadedParmTable
end

function UISpine:setBodyLoadedCallBack(func, handle)
	self._bodyLoadedCallBackFunc = func
	self._bodyLoadedCallBackHandle = handle
end

function UISpine:getSize()
	return self._size
end

function UISpine:autoFixedSize(fixedSize, maxScale, forMaxSide)
	self._fixedSize = fixedSize
	self._maxScale = maxScale

	if self._skeletonGraphic == nil or self._fixedSize == nil or self._fixedSize == 0 then
		return
	end

	local size = self:getSize()
	local scale = 1

	if size.x > 0 and size.y > 0 then
		if not forMaxSide then
			scale = fixedSize / math.min(size.x, size.y)
		else
			scale = fixedSize / math.max(size.x, size.y)
		end

		if self._maxScale then
			scale = math.min(scale, self._maxScale)
		end
	end

	Astral.TransformUtil.SetLocalScale(self._go.transform, scale, scale, 1)
end

function UISpine:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._skeletonLoader:load(url, self._onBodyLoaded, self, true)
end

function UISpine:attachEffect(effectUrl1, effectUrl2)
	if self._effectUrl1 == effectUrl1 and self._effectUrl2 == effectUrl2 then
		return
	end

	self:removeEffect()

	if string.nilorempty(effectUrl1) and string.nilorempty(effectUrl2) then
		return
	end

	self._effectUrl1 = effectUrl1
	self._effectUrl2 = effectUrl2

	local spineGo = self._skeletonLoader:getInst()

	if spineGo then
		if self._effectUrl1 then
			getres(langpath(self._effectUrl1), self._onEffect1Loaded, self, 0, true)
		end

		if self._effectUrl2 then
			getres(langpath(self._effectUrl2), self._onEffect2Loaded, self, 0, true)
		end
	end
end

function UISpine:removeEffect()
	if self._effectUrl1 ~= nil then
		goutil.destroy(self._effectGo1)

		if self._effectRes1 ~= nil then
			self._effectRes1:Release()
		else
			removeresl(langpath(self._effectUrl1), self._onEffect1Loaded, self)
		end

		self._effectRes1 = nil
		self._effectUrl1 = nil
		self._effectGo1 = false
	end

	if self._effectUrl2 ~= nil then
		goutil.destroy(self._effectGo2)

		if self._effectRes2 ~= nil then
			self._effectRes2:Release()
		else
			removeresl(langpath(self._effectUrl2), self._onEffect2Loaded, self)
		end

		self._effectRes2 = nil
		self._effectUrl2 = nil
		self._effectGo2 = nil
	end
end

function UISpine:_onEffect1Loaded(res)
	if res.IsSuccess then
		self._effectRes1 = res

		self._effectRes1:Retain()

		local spineGo = self._skeletonLoader:getInst()
		local hangPoint = GoUtil.FindChildRecursively(spineGo, self._hangPointPath1)

		if hangPoint then
			self._effectGo1 = Astral.GameObjectUtil.CloneAndSetParent(res:GetAsset(nil, nil), hangPoint.transform)
		else
			self._effectGo1 = UnityEngine.GameObject.Instantiate(res:GetAsset(nil, nil))
		end

		if self._go.layer == SceneLayer.UI_Value then
			Astral.GameObjectUtil.SetLayerRecursively(self._effectGo1, self._go.layer)
		end
	end
end

function UISpine:_onEffect2Loaded(res)
	if res.IsSuccess then
		self._effectRes2 = res

		self._effectRes2:Retain()

		local spineGo = self._skeletonLoader:getInst()
		local hangPoint = GoUtil.FindChildRecursively(spineGo, self._hangPointPath2)

		if hangPoint then
			self._effectGo2 = Astral.GameObjectUtil.CloneAndSetParent(res:GetAsset(nil, nil), hangPoint.transform)
		else
			self._effectGo2 = UnityEngine.GameObject.Instantiate(res:GetAsset(nil, nil))
		end

		if self._go.layer == SceneLayer.UI_Value then
			Astral.GameObjectUtil.SetLayerRecursively(self._effectGo2, self._go.layer)
		end
	end
end

function UISpine:_onBodyLoaded(loader)
	local skeletonGO = self._skeletonLoader:getInst()

	self._skeletonGraphic = skeletonGO:GetComponent(UISpine.SkeletonGraphicType)

	if not self._skeletonGraphic then
		self._skeletonGraphic = goutil.addComponentOnce(skeletonGO, UISpine.SkeletonGraphicType)

		local skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)

		skeletonAnimation:Initialize(false)

		self._skeletonGraphic.skeletonDataAsset = skeletonAnimation.skeletonDataAsset
	end

	self._skeletonGraphic:Initialize(false)
	self._skeletonGraphic:UpdateMesh()

	self._defaultMat = self._skeletonGraphic.material

	self:_enableClickShow()

	self._skeletonGraphic.Skeleton.FlipX = self._isFlipX

	if self._effectUrl1 and not self._effectGo1 then
		getres(langpath(self._effectUrl1), self._onEffect1Loaded, self, 0, true)
	end

	if self._effectUrl2 and not self._effectGo2 then
		getres(langpath(self._effectUrl2), self._onEffect2Loaded, self, 0, true)
	end

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState then
		self:play(self._defaultAnimState, self._isLoop)
	end

	local animCount = self._skeletonGraphic:GetAnimationCount()

	table.clear(self._showAnims)

	local runAnim, hitAnim, dieAnim

	for i = 1, animCount do
		local animName = self._skeletonGraphic:GetAnimationName(i - 1)

		if animName ~= self._defaultAnimState then
			if animName == UnitAnimState.Walk then
				runAnim = animName
			elseif animName == UnitAnimState.Hit then
				hitAnim = animName
			elseif animName == UnitAnimState.Die then
				dieAnim = animName
			else
				table.insert(self._showAnims, animName)
			end
		end
	end

	table.sort(self._showAnims)

	if runAnim then
		table.insert(self._showAnims, 1, runAnim)
	end

	if hitAnim then
		table.insert(self._showAnims, hitAnim)
	end

	if dieAnim then
		table.insert(self._showAnims, dieAnim)
	end

	self:autoFixedSize(self._fixedSize, self._maxScale)

	if self._bodyLoadedCallBackFunc then
		self._bodyLoadedCallBackFunc(self._bodyLoadedCallBackHandle, self._skeletonLoader:getInst(), self._bodyLoadedParmTable)
	end

	if not self._isPause then
		self:_updatePlaySpeed()
	end
end

function UISpine:_onSpineAction(actionName, eventName, eventPara)
	if self._actionHandler then
		if self._actionHandlerObj then
			self._actionHandler(self._actionHandlerObj, actionName, eventName, eventPara)
		else
			self._actionHandler(actionName, eventName, eventPara)
		end
	end
end

function UISpine:setActionEventListener(handler, handlerObj)
	self._actionHandler = handler
	self._actionHandlerObj = handlerObj
end

function UISpine:setMyFashion(modelClothesId)
	if CollectionEquipFacade.instance:getIsHuaHua() == true then
		self._huanHuaZhong = true
	else
		self._huanHuaZhong = false
	end

	local modelId = false

	if modelClothesId then
		modelId = modelClothesId
	else
		modelId = RoleFacade.instance:getModelId()
	end

	local sex = RoleFacade.instance:getRoleSex()
	local weaponId = EquipmentFacade.instance:getMainRoleWeapon()
	local weaponCode

	if self._huanHuaZhong == false then
		if weaponId then
			weaponCode = BagFacade.instance:getCodeById(weaponId)
		end
	else
		weaponCode = CollectionEquipFacade.instance:getHuaHuaCode()
	end

	self:setFashion(modelId, weaponCode, sex)
end

function UISpine:setFashion(modelId, weaponCode, sex)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	if string.nilorempty(modelCO.resName) and enableWarnLog then
		printWarn("未配置资源名字: ", modelId)
	end

	self:setWeaponWithSex(weaponCode, sex)
end

function UISpine:setWeaponWithSex(weaponCode, sex)
	if not weaponCode or weaponCode == 0 then
		self:setWeapon(nil)

		return
	end

	local weaponCO = EquipmentConfig.instance:getEquipmentCO(weaponCode)

	if not weaponCO then
		if enableWarnLog then
			printWarn("can't find EquipmentCO,weaponCode=", weaponCode)
		end

		return nil
	end

	local weaponUrl

	if sex == 0 then
		if not string.nilorempty(weaponCO.maleWeaponName) then
			weaponUrl = GameUrl.getWeaponUrl(weaponCO.maleWeaponName)
		end
	elseif not string.nilorempty(weaponCO.femaleWeaponName) then
		weaponUrl = GameUrl.getWeaponUrl(weaponCO.femaleWeaponName)
	end

	if enableWarnLog then
		printWarn(modelId, weaponCode, sex, weaponUrl)
	end

	self:setWeapon(weaponUrl)
end

function UISpine:setWeapon(weaponResPath)
	return
end

function UISpine:_handleChangeWeapon()
	local spineGo = self._skeletonLoader:getInst()

	if spineGo then
		local obj = Spine.SpineChangeWeapon.Get(spineGo)

		obj.WeaponResPath = self._weaponResPath
	end
end

function UISpine:play(animState, isLoop, isForceRestart)
	if not animState or isLoop == true and self._curAnimState == animState then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop or false

	if self._isPause then
		self:resumePlay()
	end

	if self._skeletonGraphic then
		if isForceRestart then
			self._skeletonGraphic:PlayAnimation(animState, self._isLoop, true)
		else
			self._skeletonGraphic.startingLoop = self._isLoop
			self._skeletonGraphic.AnimationName = animState
		end
	end
end

function UISpine:playDefault(isLoop)
	if isLoop == nil then
		isLoop = true
	end

	self:play(self._defaultAnimState, isLoop)
end

function UISpine:stopPlay()
	self:play("", false)
	self:pausePlay()
end

function UISpine:pausePlay()
	if not self._skeletonGraphic then
		return
	end

	self._isPause = true
	self._skeletonGraphic.timeScale = 0
end

function UISpine:resumePlay()
	self._isPause = false

	self:setPlaySpeed(self._playSpeed)
end

function UISpine:_enableClickShow()
	if self._enableClick and self._skeletonGraphic then
		local trigger

		if self._clickGO then
			trigger = Astral.UIClickTrigger.Get(self._clickGO)
			self._skeletonGraphic.raycastTarget = false
		else
			self._skeletonGraphic.raycastTarget = true
			trigger = Astral.UIClickTrigger.Get(self._skeletonGraphic.gameObject)
		end

		trigger:AddClickListener(self._onClick, self, nil)
	end
end

function UISpine:enableClickShow(clickGo)
	self._enableClick = true
	self._clickGO = clickGo

	self:_enableClickShow()
end

function UISpine:_onClick()
	if self._skeletonGraphic then
		if self._curAnimState and self._curAnimState ~= self._defaultAnimState then
			if enableLog then
				print("reset")
			end

			self._curAnimState = nil

			self:play(self._defaultAnimState, true)
		else
			self:_showNext()
		end
	end
end

function UISpine:_showNext()
	if self._showAnimIndex <= #self._showAnims then
		local toState = self._showAnims[self._showAnimIndex]

		self:play(toState, true)
	end

	self._showAnimIndex = self._showAnimIndex + 1

	if self._showAnimIndex > #self._showAnims then
		self._showAnimIndex = 1
	end
end

function UISpine:showMainCharacter(defaultAction)
	if defaultAction then
		self._defaultAnimState = defaultAction
	else
		self._defaultAnimState = UnitAnimState.Idle
	end

	self._showAnimIndex = 1
	self._curAnimState = nil

	self:play(self._defaultAnimState, true)
	self:setMyFashion()
end

function UISpine:showUnit(modelId, defaultAction)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	if defaultAction then
		self._defaultAnimState = defaultAction
	else
		self._defaultAnimState = UnitAnimState.Idle
	end

	self._showAnimIndex = 1
	self._curAnimState = nil
	self._playTime = 1

	self:play(self._defaultAnimState, true)
	self:setFashion(modelId)
end

function UISpine:showUnitByEquipCodeAndSex(modelId, weaponCode, sex)
	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._defaultAnimState = UnitAnimState.Idle
	self._showAnimIndex = 1
	self._curAnimState = nil
	self._playTime = 1

	self:play(self._defaultAnimState, true)
	self:setFashion(modelId, weaponCode, sex)
end

function UISpine:setSkeletonGraphicColor(color)
	if self._skeletonGraphic then
		self._skeletonGraphic.color = color
	end
end

function UISpine:getSkeletonGraphicColor()
	if self._skeletonGraphic then
		return self._skeletonGraphic.color
	end
end

function UISpine:setGray()
	if self._skeletonGraphic then
		local grayMat = CommonPreloader.instance:getSkinlibAsset("ui/skinlib/ui_gray.mat")

		self._skeletonGraphic.material = grayMat
	end
end

function UISpine:setDefaultMat()
	if self._skeletonGraphic then
		self._skeletonGraphic.material = self._defaultMat
	end
end

function UISpine:setFace(facestr)
	if self._skeletonGraphic then
		self._skeletonGraphic:Initialize(false)

		if self._skeletonGraphic.Skeleton then
			facestr = facestr or "changtai"

			if not self._skeletonGraphic.SkeletonData:FindSkin(facestr) then
				if enableWarnLog then
					printWarn(string.format("could not find skin ,skinname:%s in this spine object,and then will set default for this object", facestr))
				end

				facestr = "default"
			end

			self._skeletonGraphic.Skeleton:SetSkin(facestr)
			self._skeletonGraphic.Skeleton:SetSlotsToSetupPose()
		elseif enableWarnLog then
			printWarn("miss skeleton，could not set face,faceinfo:" .. facestr)
		end
	end
end

function UISpine:doColor(endValue, duration)
	if self._skeletonGraphic then
		self._skeletonGraphic:DOColor(endValue, duration)
	end
end

function UISpine:doFofade(to, duration)
	if self._skeletonGraphic then
		self._skeletonGraphic:DOFade(to, duration)
	end
end

function UISpine:doScale(value, duration)
	if self._skeletonGraphic and self._skeletonGraphic.transform then
		self._skeletonGraphic.transform:DOScale(value, duration)
	end
end

function UISpine:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UISpine:getPlaySpeed()
	return self._playSpeed
end

function UISpine:_updatePlaySpeed()
	if not self._skeletonGraphic then
		return
	end

	self._skeletonGraphic.timeScale = self._playSpeed
end

function UISpine:clear()
	self:removeEffect()

	if self._skeletonLoader then
		self._skeletonLoader:clear()
	end

	self._skeletonGraphic = nil
	self._url = nil
end

function UISpine:OnDestroy()
	if self._enableClick and self._clickGO then
		local trigger = Astral.UIClickTrigger.Get(self._clickGO)

		if not goutil.isNil(trigger) then
			trigger:RemoveClickListener()
		end
	end

	self:removeEffect()

	self._skeletonLoader = nil
	self._skeletonGraphic = nil
	self._url = nil
end

return UISpine
