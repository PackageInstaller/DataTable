-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/photo/PhotoBlurEffect.lua

module("logic.common.photo.PhotoBlurEffect", package.seeall)

local PhotoBlurEffect = class("PhotoBlurEffect")
local lightCode = 4

function PhotoBlurEffect.Get(go)
	return Astral.LuaComponentContainer.Add(go, PhotoBlurEffect)
end

function PhotoBlurEffect:ctor(container)
	self._go = container.gameObject
	self._photo = Astral.PhotoBase.Add(self._go)

	local unitGo = goutil.create("PhotoBlurEffect", false)

	self._unit = Astral.LuaComponentContainer.Add(unitGo, UnitPhotoSpine)
	self._isTurnOn = false
	self._isEnableScanLine = false
	self._instanceId = self._go:GetInstanceID()
	self._targetGoes = {}
	self._multiLoader = MultiResLoader.New()
	self._bgMaterialSetter = false

	goutil.addChildToParent(unitGo, self._go)
	unitGo:SetActive(false)

	self._spineLoadedCallback = nil
	self._spineLoadedCallbackObj = nil

	self._unit:addInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)

	self._showAnimIndex = 1
	self._showAnims = {}
	self._randomTimes = 0
	self._showEggAnim = false
	self._randomXxTimes = 0
	self._xxAnimaTimes = 0
	self._showShadow = false
end

function PhotoBlurEffect:getUnit()
	return self._unit
end

function PhotoBlurEffect:setSpineLoadedCallback(callback, callbackObj)
	self._spineLoadedCallback = callback
	self._spineLoadedCallbackObj = callbackObj
end

function PhotoBlurEffect:setShowXinMaoSlot(needCache)
	self._needCacheXinmao = needCache

	if needCache then
		if not self._xinmaoSlotMap then
			self._xinmaoSlotMap = {}
		end
	else
		self._xinmaoSlotMap = false
	end
end

function PhotoBlurEffect:_onSpineLoaded()
	self:setFace(self._faceResName)

	if self._needCacheXinmao then
		self:_cacheSlotData()
	end

	Astral.TransformUtil.SetLocalPosZ(self._unit.go.transform, self._showShadow and -0.2 or 0)
	self:setAnimation()

	if self._spineLoadedCallback then
		if self._spineLoadedCallbackObj then
			self._spineLoadedCallback(self._spineLoadedCallbackObj, self._unit.spine, self._bodyLoadedParmTable)
		else
			self._spineLoadedCallback(self._unit.spine)
		end
	end
end

function PhotoBlurEffect:showBg(name)
	local bgPath = GameUrl.getCharacterBg(name)

	self:showBgByPath(bgPath)
	self:_setBgShadow(self._showShadow)
end

function PhotoBlurEffect:setLightCode(newlightCode)
	if not newlightCode then
		return
	end

	lightCode = newlightCode
end

function PhotoBlurEffect:_setBgShadow(enable)
	if self._bgMaterialSetter then
		self._bgMaterialSetter:SetBool("_SHADOW", enable)
	end
end

function PhotoBlurEffect:showBgByPath(bgPath)
	local _uiCommonBg = CommonPreloader.instance:getAsset(CommonResPath.UICommonBg)

	if goutil.isNil(self._bgInst) then
		self._bgInst = goutil.clone(_uiCommonBg)
	end

	local inst = self._bgInst

	self._photo:ShowTarget(inst, true)

	self._targetGoes[CommonResPath.UICommonBg] = inst
	self._bgMaterialSetter = MaterialSetter.Get(inst)

	self._bgMaterialSetter:SetGameObject(inst)
	self._multiLoader:addResPath(bgPath, true)
	self._multiLoader:load(self._onAllLoaded, self._onOneBgLoaded, self)
end

function PhotoBlurEffect:getLineRenderer()
	return self._lineRenderer
end

function PhotoBlurEffect:getLineHorizontal()
	return self._lineHorizontal
end

function PhotoBlurEffect:getBgGo()
	return self._bgInst
end

function PhotoBlurEffect:disableLineRenderer()
	if self._lineRenderer ~= nil and self._lineHorizontal ~= nil then
		self._lineRenderer.enabled = false
		self._lineHorizontal.enabled = false
	end
end

function PhotoBlurEffect:_adjustBgSize()
	local _camera = self:getCamera()
	local background = self._bgInst.transform
	local bgPosX, bgPosY, bgPosZ = Astral.TransformUtil.GetPos(background, 0, 0, 0)
	local cameraPosX, cameraPosY, cameraPosZ = Astral.TransformUtil.GetPos(_camera.transform, 0, 0, 0)
	local fieldOfView = _camera.fieldOfView
	local distance = Vector3.Distance(Vector3.New(bgPosX, bgPosY, bgPosZ), Vector3.New(cameraPosX, cameraPosY, cameraPosZ))
	local newheight = Mathf.Tan(fieldOfView / 2 * Mathf.Deg2Rad) * distance * 2
	local newwidth = newheight * _camera.aspect

	Astral.TransformUtil.SetLocalScale(background, newwidth, newheight, 1)
end

function PhotoBlurEffect:_onOneBgLoaded(res)
	if res.IsSuccess then
		local bgTexture = res:GetAsset()

		self._bgMaterialSetter:SetTexture(UnityEngine.Shader.PropertyToID("_BaseMap"), bgTexture)
	end
end

function PhotoBlurEffect:_openBlurEffect()
	self:setCameraTag(SceneTag.RendererFeatureCamera)
	SpaceX.UIBlurUtils.SetUIBlurEffect(3, 2, false)
	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.UIBLUR, true, self._instanceId)
end

function PhotoBlurEffect:showUnit(modelId)
	self._modelId = modelId

	local defualtFace = ExpressionConfig.instance:getDefaultFace(self._modelId)

	defualtFace = defualtFace or "changtai"
	self._defaultFace = defualtFace

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._unit.spine:setBody(GameUrl.getSpineUrl(modelCO.resName))
	self:_turnOn()
end

function PhotoBlurEffect:showUnitLiveWholeByID(modelId, faceResName)
	self._modelId = modelId

	local defualtFace = ExpressionConfig.instance:getDefaultFace(self._modelId)

	defualtFace = defualtFace or "changtai"
	self._defaultFace = defualtFace

	local modelCO = ModelConfig.instance:getModelConfig(modelId)

	if not modelCO then
		if enableWarnLog then
			printWarn("can't find ModelCO,modelId=", modelId)
		end

		return nil
	end

	self._faceResName = faceResName

	local url = GameUrl.getSpineUrl(modelCO.liveWholeIconName)

	if url == self._unit.spine._url then
		self:_onSpineLoaded()
	else
		self._unit.spine:setBody(url)
		self:_turnOn()
	end

	self:_openBlurEffect()
end

function PhotoBlurEffect:showUnitLiveWhole(res)
	if not res then
		if enableWarnLog then
			printWarn("can't find res,res=", res)
		end

		return nil
	end

	self._unit.spine:setBody(GameUrl.getSpineUrl(res))
	self:_turnOn()
end

function PhotoBlurEffect:showEffects(...)
	local urls = {
		...
	}

	if not urls then
		return
	end

	self:_turnOn()
	self:_clearAllEffect()

	local len = #urls

	for i = 1, len do
		self._multiLoader:addResPath(urls[i], true)
	end

	self._multiLoader:load(self._onAllLoaded, self._onOneLoaded, self)
end

function PhotoBlurEffect:_onOneLoaded(res)
	if res.IsSuccess then
		local inst = goutil.clone(res:GetAsset(nil, nil))

		self._photo:ShowTarget(inst, true)

		self._targetGoes[res.ResPath] = inst

		if self._effectLoadedCallback then
			if self._effectLoadedCallbackObj then
				self._effectLoadedCallback(self._effectLoadedCallbackObj, inst, res)
			else
				self._effectLoadedCallback(inst, res)
			end
		end
	end
end

function PhotoBlurEffect:_turnOn()
	if self._isTurnOn then
		return
	end

	self._isTurnOn = true

	self._photo:TurnOn()
	self._photo:ShowTarget(self._unit.go, false)
	self._unit.go:SetActive(true)
	self._photo:SetCameraPosition(0, 0, 0)
	self._photo:SetCameraRotation(0, 0, 0)
	PhotoBaseExtension.ResetCamera(self._photo)
end

function PhotoBlurEffect:_clearAllEffect()
	for k, v in pairs(self._targetGoes) do
		goutil.destroy(v)

		self._targetGoes[k] = nil
	end

	self._multiLoader:clear()
end

function PhotoBlurEffect:getCamera()
	return self._photo.producer.rtCamera
end

function PhotoBlurEffect:setCameraPosition(x, y, z)
	self._photo:SetCameraPosition(x, y, z)
end

function PhotoBlurEffect:setCameraRotation(x, y, z)
	self._photo:SetCameraRotation(x, y, z)
end

function PhotoBlurEffect:setCameraPerspective(fieldOfView)
	PhotoBaseExtension.SetCameraPerspective(self._photo, fieldOfView)
end

function PhotoBlurEffect:setCameraOrthographic(orthographicSize)
	PhotoBaseExtension.SetCameraOrthographic(self._photo, orthographicSize)
end

function PhotoBlurEffect:setCameraPostProcessing(renderPostProcessing, volumeLayerMask)
	PhotoBaseExtension.SetCameraPostProcessing(self._photo, renderPostProcessing, volumeLayerMask)
end

function PhotoBlurEffect:setBgColor(colorStr)
	PhotoBaseExtension.SetCameraBgColor(self._photo, colorStr)
end

function PhotoBlurEffect:setCameraTag(tag)
	PhotoBaseExtension.SetCameraTag(self._photo, tag)
end

function PhotoBlurEffect:setMaterial(material)
	PhotoBaseExtension.SetMaterial(self._photo, material)
end

function PhotoBlurEffect:getGO()
	return self._go
end

function PhotoBlurEffect:clear()
	self:_setSpineEvent(false)

	if self._unit.spine._skeletonLoader then
		self._unit.spine:clear()
	end

	if self._unit.go then
		if not goutil.isNil(self._go) then
			goutil.addChildToParent(self._unit.go, self._go)
		end

		self._unit.go:SetActive(false)
	end

	self:_clearAllEffect()
	self._photo:TurnOff()

	self._isTurnOn = false
	self._isShowEnter = false
	self._showEnterFromLeft = false
	self._faceResName = false
	self._randomTimes = 0
	self._showXiuXainAnim = false
	self._showEggAnim = false
	self._randomXxTimes = 0
	self._xxAnimaTimes = 0

	RendererFeatureUtil.toggleRendererFeature(RendererFeatureName.UIBLUR, false, self._instanceId)
	self:_setBgShadow(false)

	self._showShadow = false
end

function PhotoBlurEffect:OnDestroy()
	self:clear()
	goutil.destroy(self._unit.go)

	if self._unit then
		self._unit:removeInnerEventListener(UnitActionType.SpineLoaded, self._onSpineLoaded, self)
	end

	self._unit = nil
	self._photo = nil
	self._material = nil
end

function PhotoBlurEffect:setDirection(direction)
	self._unit.spine:setDirection(direction)
end

function PhotoBlurEffect:setFace(skinName)
	self._faceResName = skinName or self._defaultFace

	if self._unit and self._unit.spine:getSkeletonAnimation() and self._unit.spine:getSkeletonAnimation().Skeleton.Data:FindSkin(self._faceResName) then
		local skeletonAnimation = self._unit.spine:getSkeletonAnimation()
		local skin = skeletonAnimation.Skeleton.Skin

		if skin then
			local curSkinName = skin.Name

			if curSkinName == self._faceResName then
				return
			end
		end

		skeletonAnimation.initialSkinName = self._faceResName

		skeletonAnimation.Skeleton:SetSkin(self._faceResName)
		skeletonAnimation.Skeleton:SetSlotsToSetupPose()
		skeletonAnimation.AnimationState:Apply(skeletonAnimation.Skeleton)
	end
end

function PhotoBlurEffect:_cacheSlotData()
	if not self._xinmaoSlotMap then
		self._xinmaoSlotMap = {}
	else
		table.clear(self._xinmaoSlotMap)
	end

	local skeletonAnimation = self._unit.spine:getSkeletonAnimation()

	if skeletonAnimation then
		local maxSlotCount = skeletonAnimation.Skeleton.Slots.Count

		for i = 0, maxSlotCount - 1 do
			local slot = skeletonAnimation.Skeleton.Slots.Items[i]

			if slot and string.starts(slot.Data.Name, "xinmao_") then
				self._xinmaoSlotMap[slot.Data.Name] = slot.Data.AttachmentName
			end
		end
	end
end

function PhotoBlurEffect:setAnchoringAttachment(active)
	if self._xinmaoSlotMap then
		for slotName, attachementName in pairs(self._xinmaoSlotMap) do
			self:setAttachment(slotName, active and attachementName or nil)
		end
	end
end

function PhotoBlurEffect:setAttachment(slotName, attachmentName)
	local skeletonAnimation = self._unit.spine:getSkeletonAnimation()

	if skeletonAnimation then
		local slot = skeletonAnimation.Skeleton:FindSlot(slotName)

		if slot then
			skeletonAnimation.Skeleton:SetAttachment(slotName, attachmentName)
		end
	end
end

function PhotoBlurEffect:setBodyLoadedParm(parmTable)
	self._bodyLoadedParmTable = parmTable
end

function PhotoBlurEffect:setIsShowEgg(isShowEgg)
	self._isShowEgg = isShowEgg
end

function PhotoBlurEffect:setIsShowEnter(isShowEnter)
	self._isShowEnter = isShowEnter
end

function PhotoBlurEffect:setShowEnterFromLeft(fromLeft)
	self._showEnterFromLeft = fromLeft
end

function PhotoBlurEffect:setIsShowXiuXian(isShowXiuXian)
	self._isShowXiuXian = isShowXiuXian
end

function PhotoBlurEffect:setShadow(enable)
	self._showShadow = enable
end

function PhotoBlurEffect:getBodyLoadedParm()
	return self._bodyLoadedParmTable
end

function PhotoBlurEffect:setSpineColor(colorStr)
	self._unit.material:setMainColor(colorStr)
end

function PhotoBlurEffect:getSpineColor()
	self._unit.material:getMainColor()
end

function PhotoBlurEffect:doColor(endValue, duration)
	self._unit.material:doColor(endValue, duration)
end

function PhotoBlurEffect:doFofade(to, duration)
	self._unit.material:doMainAlpha(to, duration)
end

function PhotoBlurEffect:killAll(complete)
	self._unit.material:killAll(complete)
end

function PhotoBlurEffect:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
	if self._isEnableScanLine == enable then
		return
	end

	self._isEnableScanLine = enable

	self._unit.material:ToggleScanLine(enable, scanLineMap, flickerMap, mainColorAnim)
end

function PhotoBlurEffect:toggleMask(enable, maskPos, maskFactor)
	if self._isEnableMask == enable then
		return
	end

	self._isEnableMask = enable

	self._unit.material:toggleMask(enable, maskPos, maskFactor)
end

function PhotoBlurEffect:play(animState, isLoop)
	self._unit.spine:play(animState, isLoop)
end

function PhotoBlurEffect:getShowEggAnim()
	return self._showEggAnim
end

function PhotoBlurEffect:setAnimation()
	local skeAnim = self._unit.spine:getSkeletonAnimation()

	if not skeAnim then
		return
	end

	local isNormalFace = false

	if string.find(self._defaultFace, self._faceResName) then
		isNormalFace = true
	end

	local xiuxianList = self:findAnima(UnitAnimState.XiuXian)
	local isShowAnim = #xiuxianList > 0 and self._isShowEgg and isNormalFace
	local hasEnterAni = skeAnim:ContainsAnimation(UnitAnimState.Enter)
	local hasEnterLeftAni = skeAnim:ContainsAnimation(UnitAnimState.LeftEnter)
	local animState

	if self._isShowEnter then
		if self._showEnterFromLeft and hasEnterLeftAni then
			animState = UnitAnimState.LeftEnter
		elseif hasEnterAni then
			animState = UnitAnimState.Enter
		end
	end

	local isShowXiuXian = #xiuxianList > 0 and self._isShowXiuXian and isNormalFace

	self:_setSpineEvent(true)
	table.clear(self._showAnims)

	if isShowAnim then
		self._showAnimIndex = 0
		self._showEggAnim = true
		self._randomXxTimes = math.random(1, 2)
		self._randomTimes = math.random(1, 2)
		self._xxAnimaTimes = 0

		if animState then
			self:play(animState)
		else
			self:play(UnitAnimState.Idle)
		end
	elseif animState then
		self:play(animState)
	else
		self:play(UnitAnimState.Idle, true)
	end
end

function PhotoBlurEffect:_onSpineEvent(eventId, actionType, animationName, eventName, eventParam)
	if eventName == SpineEventName.Complete then
		self._unit.spine:resetCurAnimState()

		if self._isShowEnter then
			self:play(UnitAnimState.Idle, not self._showEggAnim)

			self._isShowEnter = false
		elseif self._showEggAnim then
			if animationName == UnitAnimState.Idle then
				self._showAnimIndex = self._showAnimIndex + 1

				if self._randomTimes <= self._showAnimIndex then
					self._xxAnimaTimes = self._xxAnimaTimes + 1

					local tmpAnimList = self:findAnima(UnitAnimState.XiuXian)
					local aimaName = tmpAnimList[math.random(#tmpAnimList)]

					self:play(aimaName)
				else
					self:play(UnitAnimState.Idle)
				end
			elseif string.find(animationName, UnitAnimState.XiuXian) ~= nil then
				if self._xxAnimaTimes == self._randomXxTimes then
					self._xxAnimaTimes = 0
					self._showAnimIndex = 0
					self._randomTimes = math.random(1, 2)
					self._randomXxTimes = math.random(1, 2)

					local tmpAnimList = self:findAnima(UnitAnimState.Show)

					if #tmpAnimList > 0 then
						local aimaName = tmpAnimList[math.random(#tmpAnimList)]

						self:play(aimaName)
					else
						local tmpAnimList = self:findAnima(UnitAnimState.XiuXian)
						local aimaName = tmpAnimList[math.random(#tmpAnimList)]

						self:play(aimaName)
					end
				else
					self:play(UnitAnimState.Idle)
				end
			else
				self:play(UnitAnimState.Idle)
			end
		end
	end
end

function PhotoBlurEffect:_setSpineEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.SpineEvent, self._onSpineEvent, self)
	end
end

function PhotoBlurEffect:findAnima(animationName)
	local result = {}
	local skeAnim = self._unit.spine:getSkeletonAnimation()

	if not skeAnim then
		return
	end

	local hasFind = skeAnim:ContainsAnimation(animationName)

	if hasFind then
		table.insert(result, animationName)
	end

	for i = 1, 9 do
		local tempAimaName = animationName .. i
		local hasFind2 = skeAnim:ContainsAnimation(tempAimaName)

		if hasFind2 then
			table.insert(result, tempAimaName)
		end
	end

	return result
end

return PhotoBlurEffect
