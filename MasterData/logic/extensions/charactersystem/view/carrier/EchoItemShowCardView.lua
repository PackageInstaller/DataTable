-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/carrier/EchoItemShowCardView.lua

module("logic.extensions.charactersystem.view.carrier.EchoItemShowCardView", package.seeall)

local M = class("EchoItemShowCardView")
local ECHO_BG_WIDTH = 1122
local ECHO_BG_HEIGHT = 1160

function M:ctor(compContainer)
	self._compContainer = compContainer
	self._mainGo = self._compContainer.gameObject
	self._registry = ViewElementsRegistry.New(self._mainGo)
	self._gyros = Astral.LuaComponentContainer.Add(self._mainGo, EchoItemGyros)

	self._gyros:maskTransition(true)

	self._showGyros = false
	self._ignoreCheckEchoChange = false
	self._curX = 0
	self._startX = 0
	self._hasDragTrigger = true

	self:_buildUI()
end

function M:OnDestroy()
	self:_destroyUI()
end

function M:_buildUI()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)

	self._goZhengmian = goutil.findChild(self._mainGo, "zhengmian")
	self._goBeimian = goutil.findChild(self._mainGo, "beimian")
	self._goNormal = self._registry:getGo("echo_show_card_-610472002")
	self._goNormal2 = self._registry:getGo("echo_show_card_-1526686625")
	self._goEmpty = self._registry:getGo("echo_show_card_-220283103")
	self._imgQuality = self._registry:getImage("echo_show_card_-334549635")
	self._imgQuality1 = self._registry:getImage("echo_show_card_-1730385815")
	self._rawImg = self._registry:findUIElement("echo_show_card_1724307928", UIComponentType.RawImage)
	self._rawImgShow = self._registry:findUIElement("echo_show_card_1276320532", UIComponentType.RawImage)
	self._rawImgReflect = self._registry:findUIElement("echo_show_card_1115613356", UIComponentType.RawImage)
	self._rawStaticImg = self._registry:findUIElement("echo_show_card_-614303563", UIComponentType.Image)
	self._btnAdd = self._registry:getBtn("echo_show_card_-609721434")
	self._effect1Go = self._registry:getGo("echo_show_card_-1195155987")
	self._effect2Go = self._registry:getGo("echo_show_card_1861155846")
	self._guiAnimation = goutil.addComponentOnce(self._mainGo, typeof(Astral.GUITimelineAniLua))

	goutil.setActive(self._rawImg.gameObject, false)
	goutil.setActive(self._btnAdd.gameObject, false)

	self._goEchoUpgradeVFX = self._registry:getGo("echo_show_card_-1973529237")
	self._goEchoReadyUpgradeVFX = self._registry:getGo("echo_show_card_-556869675")

	self:setUpgradeVFXVisible(false)
	self:setUpgradeReadyVFXVisible(false)

	self._echoEffect = {
		[5] = self._registry:getGo("echo_show_card_521060431"),
		[4] = self._registry:getGo("echo_show_card_178355730"),
		[3] = self._registry:getGo("echo_show_card_-974813751")
	}
	self._goEchoShowEffect = goutil.findChild(self._mainGo, "zhengmian/vfx")
	self._echoShowEffect = {
		[5] = self._registry:getGo("echo_show_card_925808287"),
		[4] = self._registry:getGo("echo_show_card_122757532"),
		[3] = self._registry:getGo("echo_show_card_-1644021386")
	}
	self._uiAnimation = self._mainGo:GetComponent(ComponentType.Animation)
	self._uiAnimEvent = Astral.AnimationEventListener.Get(self._mainGo)
	self._effect12Go = goutil.findChild(self._goZhengmian, "normal2/effect1_2")

	local goFind = self._registry:getGo("echo_show_card_119336645")

	goutil.setActive(goFind, false)

	local goClick = self._registry:getGo("echo_show_card_1894924632")

	goutil.setActive(goClick, true)

	self._clickEmptyRayCast = goClick:GetComponent(UIComponentType.EmptyRaycast)
	self._clickEmptyRayCast.enabled = true
	self._compositeTouch = UICompositeTouch.Get(goClick)

	local clickChecker = ClickTouchChecker.New()

	clickChecker:AddClickListener(self._onClick, self)

	local DragTouchChecker = DragTouchChecker.New()

	DragTouchChecker:SetBeginDragListener(self._onDragBegin, self)
	DragTouchChecker:SetDragListener(self._onDrag, self)
	DragTouchChecker:SetEndDragListener(self._onEndDrag, self)
	self._compositeTouch:AddChecker(clickChecker)
	self._compositeTouch:AddChecker(DragTouchChecker)

	self._goBack = goutil.findChild(self._mainGo, "beimian")

	self:setIsEnableDrag(true)
	self:_bindEvents()
end

function M:_destroyUI()
	self:_unbindEvents()
	self._gyros:clear()

	self._goNormal = nil
	self._goNormal2 = nil
	self._goEmpty = nil
	self._imgQuality = nil
	self._imgQuality1 = nil
	self._rawImg = nil
	self._btnAdd = nil
	self._guiAnimation = nil
	self._rawImgReflect = nil

	self._compositeTouch:ClearCheckerList()

	self._compositeTouch = false

	if self._tweener then
		self._tweener:Kill(false)
	end

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem_Com)
end

function M:_bindEvents()
	self._btnAdd:AddClickListener(self._onClickAdd, self)
	self._uiAnimEvent:AddListener(self._onAnimEvent, self)
end

function M:_unbindEvents()
	self._btnAdd:RemoveClickListener()
	self._uiAnimEvent:RemoveListener()
end

function M:onEnter()
	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("open")
	goutil.setActive(self._rawImg.gameObject, false)

	self._canClickNext = false
	self._showAnimation = false
end

function M:onExit()
	self._echoItemId = nil

	self._guiAnimation:StopTimelineAni()
	self._guiAnimation:PlayAniByName("close")
	self._gyros:clear()

	if self._imgEffect1 then
		self._imgEffect1:clear()
	end

	if self._imgEffect2 then
		self._imgEffect2:clear()
	end

	if self._imgEffect12 then
		self._imgEffect12:clear()
	end

	self._showGyros = false

	removetimer(self._resetToMid, self)

	if self._tweener then
		self._tweener:Kill(false)
	end
end

function M:getMainGo()
	return self._mainGo
end

function M:setIsSimulateAllTime(value)
	self.isSimulateAllTime = value

	self._gyros:setIsSimulate(value)
end

function M:setEnabledRaycast(enabled)
	self._clickEmptyRayCast.enabled = enabled
end

function M:setIsEnableDrag(value)
	self._isEnableDrag = value
end

function M:_onDragBegin(posX, posY)
	if not self._hasDragTrigger then
		return
	end

	if not self._isEnableDrag then
		return
	end

	if self._inAutoRotation then
		return
	end

	removetimer(self._resetToMid, self)

	self._startX = posX
end

function M:_onDrag(posX, posY)
	if not self._hasDragTrigger then
		return
	end

	if not self._isEnableDrag then
		return
	end

	if self._inAutoRotation then
		return
	end

	self._curX = (posX - self._startX) / 200

	if self._curX < -1 then
		self._curX = -1
	elseif self._curX > 1 then
		self._curX = 1
	end

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, MainPerformEnum.GyrosEventTyp.Echo, true, self._curX, 0, 0)
end

function M:_onEndDrag(posX, posY)
	if not self._hasDragTrigger then
		return
	end

	if not self._isEnableDrag then
		return
	end

	if self._inAutoRotation then
		return
	end

	self._speed = self._curX > 0 and -20 or 20

	settimer(0.033, self._resetToMid, self, true)
end

function M:_resetToMid()
	if self._speed > 0 and self._curX >= 0 then
		removetimer(self._resetToMid, self)

		self._curX = 0
	elseif self._speed < 0 and self._curX <= 0 then
		removetimer(self._resetToMid, self)

		self._curX = 0
	elseif self._curX == 0 then
		removetimer(self._resetToMid, self)
	else
		self._curX = self._curX + self._speed * Time.deltaTime
	end

	GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, MainPerformEnum.GyrosEventTyp.Echo, true, self._curX, 0, 0)

	if self._curX == 0 and not self.isSimulateAllTime then
		settimer(0.1, function()
			GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, MainPerformEnum.GyrosEventTyp.Echo, false)
		end, nil, false)
	end
end

function M:setIgnoreCheckEchoChange(isIgnore)
	self._ignoreCheckEchoChange = isIgnore
end

function M:setImgForShowVisible(visible)
	goutil.setActive(self._rawImgShow.gameObject, visible)
end

function M:maskTransition(value)
	if self._gyros then
		self._gyros:maskTransition(value)
	end
end

function M:updateDynamicEffect(echoItemData)
	if not echoItemData then
		self._gyros:maskTransition(true)

		return
	end

	self._gyros:maskTransition(not echoItemData:isUnlockDynamicEffect())
end

function M:autoRotation()
	if self._tweener then
		self._tweener:Kill(false)
	end

	self._inAutoRotation = true
	self._tweener = DoTweenUtil.ToWithEase(-1, 2, 4, DG.Tweening.Ease.InOutSine, function(value)
		if value > 1 then
			value = 2 - value
		end

		GlobalDispatcher:dispatchEvent(EventType.GYRO_PERFORM_SIMULATE, MainPerformEnum.GyrosEventTyp.Echo, true, value, 0, 0)
	end)

	self._tweener:OnComplete(function()
		self._inAutoRotation = false
	end)
	self._tweener:SetTarget(self._mainGo)
end

function M:refreshView(echoItemId, isFullScreenShow)
	if echoItemId == nil or echoItemId == false then
		echoItemId = 0
	end

	if echoItemId > 0 then
		local echoChange = true

		if self._echoItemId then
			echoChange = self._echoItemId ~= echoItemId
		end

		if not self._ignoreCheckEchoChange and not echoChange then
			goutil.setActive(self._rawImg.gameObject, true)

			return
		end

		goutil.setActive(self._rawImg.gameObject, true)
		goutil.setActive(self._rawImgReflect.gameObject, true)
		goutil.setActive(self._rawStaticImg.gameObject, false)

		self._echoItemId = echoItemId

		local cfg = BackpackConfig.instance:getItemInfoByItemId(echoItemId)
		local quality = cfg.quality

		self._quality = quality

		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, GameUrl.getEchoItemQualityUrl(quality))
		IconLoader.setSprite(self._imgQuality1, IconType.DynSpriteAtlas_CharacterSystem, GameUrl.getEchoItemQuality1Url(quality))
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goNormal2, true)
		goutil.setActive(self._goEmpty, false)
		self._rawImg:DOKill(false)

		self._rawImg.color = Astral.ColorUtil.ParseColor("#FFFFFF00")

		self._rawImgShow:DOKill(false)

		self._rawImgShow.color = Astral.ColorUtil.ParseColor("#FFFFFF00")

		self._gyros:clear()

		if isFullScreenShow then
			self:_setEffect34(cfg.icon)
		else
			self:_setEffect12(cfg.icon)
		end
	else
		self._echoItemId = echoItemId

		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goNormal2, false)
		goutil.setActive(self._goEmpty, true)
	end
end

function M:showStaticView(echoItemId)
	if echoItemId == nil or echoItemId == false then
		echoItemId = 0
	end

	if echoItemId > 0 then
		local echoChange = true

		if self._echoItemId then
			echoChange = self._echoItemId ~= echoItemId
		end

		if not self._ignoreCheckEchoChange and not echoChange then
			return
		end

		goutil.setActive(self._rawImg.gameObject, false)
		goutil.setActive(self._rawImgReflect.gameObject, false)
		goutil.setActive(self._rawStaticImg.gameObject, true)

		self._echoItemId = echoItemId

		local cfg = BackpackConfig.instance:getItemInfoByItemId(echoItemId)
		local quality = cfg.quality

		self._quality = quality

		IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_CharacterSystem_Com, GameUrl.getEchoItemQualityUrl(quality))
		IconLoader.setSprite(self._imgQuality1, IconType.DynSpriteAtlas_CharacterSystem, GameUrl.getEchoItemQuality1Url(quality))
		goutil.setActive(self._goNormal, true)
		goutil.setActive(self._goNormal2, true)
		goutil.setActive(self._goEmpty, false)
		self._rawImg:DOKill(false)

		self._rawImg.color = Astral.ColorUtil.ParseColor("#FFFFFF00")

		self._rawImgShow:DOKill(false)

		self._rawImgShow.color = Astral.ColorUtil.ParseColor("#FFFFFF00")

		self._gyros:clear()

		local icon = cfg and cfg.icon or nil

		if not string.nilorempty(icon) then
			IconLoader.setSprite(self._rawStaticImg, IconType.EchoItemBigIcon, string.format("%s_1", icon))
		end
	else
		self._echoItemId = echoItemId

		goutil.setActive(self._goNormal, false)
		goutil.setActive(self._goNormal2, false)
		goutil.setActive(self._goEmpty, true)
	end
end

local quality2DissolveAnim = {
	nil,
	nil,
	"echo_card_s1",
	"echo_card_s1",
	"echo_card_s1"
}

function M:playAnimByName(name)
	if string.nilorempty(name) then
		return
	end

	if self._uiAnimation then
		self._uiAnimation:Stop()
		self._uiAnimation:Play(name)
	end
end

function M:resetAnimByName(name)
	if self._uiAnimation then
		self:playAnimByName(name)
		AnimationUtils.ResetToLastFrame(self._uiAnimation)
		self._uiAnimation:Stop()
	end
end

function M:showResultAnim()
	if self._uiAnimation then
		local animName = quality2DissolveAnim[self._quality] or "echo_card_s1"

		self._uiAnimation:Stop()
		self._uiAnimation:Play(animName)
	end
end

function M:closeAnim()
	if self._uiAnimation and self._canClickNext and self._showAnimation then
		self._uiAnimation:Play("echo_card_close")

		for k, v in pairs(self._echoShowEffect) do
			goutil.setActive(v, self._quality == k)
		end
	end
end

function M:stopEchoAnim()
	if self._uiAnimation then
		self._uiAnimation:Stop()
	end
end

function M:forceCloseAnim()
	if self._uiAnimation then
		self._uiAnimation:Play("echo_card_close")

		for k, v in pairs(self._echoShowEffect) do
			goutil.setActive(v, self._quality == k)
		end
	end
end

function M:showQualityEffect(value)
	goutil.setActive(self._goEchoShowEffect, value)

	for k, v in pairs(self._echoShowEffect) do
		goutil.setActive(v, self._quality == k and value)
	end
end

function M:_onAnimEvent(animEvent)
	if animEvent then
		local curIndex = animEvent.intParameter

		if curIndex > 0 then
			local stringParam = animEvent.stringParameter

			if not string.nilorempty(stringParam) then
				self._uiAnimation:Play("echo_card_loop")

				return
			end

			self._canClickNext = true

			self._uiAnimation:Play("echo_card_loop")

			if self._callBack then
				self._callBack(self._callBackHandle, self._canClickNext)
			end
		end
	end
end

function M:_onClickAdd()
	GlobalDispatcher:dispatchEvent(EventType.ECHO_ADD_BTN_CLICK)
end

function M:getBackActiveState()
	return self._goBack.activeSelf
end

function M:setBackActiveState(value)
	goutil.setActive(self._goBack, value)
end

function M:_onClick()
	if not self._clickFunc then
		return
	end

	if self._clickHandler then
		self._clickFunc(self._clickHandler, self)
	else
		self._clickFunc(self)
	end
end

function M:setClickFunction(fun, handler)
	self._clickFunc = fun
	self._clickHandler = handler
end

function M:setAddBtnVisible(visible)
	self._btnAdd.gameObject:SetActive(visible)
end

function M:setUpgradeVFXVisible(visible)
	goutil.setActive(self._goEchoUpgradeVFX, visible)
end

function M:setUpgradeReadyVFXVisible(visible)
	goutil.setActive(self._goEchoReadyUpgradeVFX, visible)
end

function M:setIsVertical(isVertical)
	self._gyros:setIsVertical(isVertical)
end

function M:getIsVertical()
	return self._gyros:getIsVertical()
end

function M:_setEffect12(icon)
	self._isSetCam = false
	self._imgEffect12 = PhotoEffect.Get(self._effect12Go)

	self._imgEffect12:clear()
	self._imgEffect12:setRtFormat(UnityEngine.RenderTextureFormat.RGB111110Float)
	self._imgEffect12:setEffectLoadedCallback(self._loadEffect12Done, self)
	self._imgEffect12:showEffects(string.format("ui/views/charactersystem/carryitem/echo_effect/%s_1.prefab", icon), string.format("ui/views/charactersystem/carryitem/echo_effect/%s_2.prefab", icon))
	self._imgEffect12:setCameraPosition(0, 0, -10)
end

function M:_setEffect34(icon)
	self._isSetCam = false
	self._imgEffect12 = PhotoEffect.Get(self._effect12Go)

	self._imgEffect12:clear()
	self._imgEffect12:setRtFormat(UnityEngine.RenderTextureFormat.RGB111110Float)
	self._imgEffect12:setEffectLoadedCallback(self._loadEffect34Done, self)
	self._imgEffect12:showEffects(string.format("ui/views/charactersystem/carryitem/echo_effect/%s_1.prefab", icon), string.format("ui/views/charactersystem/carryitem/echo_effect/%s_2.prefab", icon))
	self._imgEffect12:setCameraPosition(0, 0, -10)
end

function M:_setEffect1(icon)
	self._imgEffect1 = PhotoEffect.Get(self._effect1Go)

	self._imgEffect1:clear()
	self._imgEffect1:setRtFormat(UnityEngine.RenderTextureFormat.RGB111110Float)
	self._imgEffect1:setEffectLoadedCallback(self._loadEffect1Done, self)
	self._imgEffect1:showEffects(string.format("ui/views/charactersystem/carryitem/echo_effect/%s_1.prefab", icon))
	self._imgEffect1:setCameraPosition(0, 0, -2.9)
end

function M:_setEffect2(icon)
	self._imgEffect2 = PhotoEffect.Get(self._effect2Go)

	self._imgEffect2:clear()
	self._imgEffect2:setRtFormat(UnityEngine.RenderTextureFormat.RGB111110Float)
	self._imgEffect2:setEffectLoadedCallback(self._loadEffect2Done, self)
	self._imgEffect2:showEffects(string.format("ui/views/charactersystem/carryitem/echo_effect/%s_2.prefab", icon))
	self._imgEffect2:setCameraPosition(0, 0, -2.9)
end

function M:_loadEffect1Done(inst, res)
	Astral.TransformUtil.SetLocalRotation(inst.transform, 0, 0, 90)

	local rawImage = self._effect1Go:GetComponent(UIComponentType.RawImage)
	local kUICameraAdditionalData = goutil.addComponentOnce(self._imgEffect1:getPhoto().producer.rtCamera.gameObject, ComponentType.UniversalAdditionalCameraData)

	self._rawImg.texture = rawImage.texture
	self._rawImgShow.texture = rawImage.texture
	rawImage.enabled = false

	goutil.setActive(self._rawImg.gameObject, true)
	self._rawImg:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)
	self._rawImgShow:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)

	kUICameraAdditionalData.renderPostProcessing = false

	self._gyros:setEchoItemEffectCam(inst)

	if self._showGyros then
		self._gyros:openGyros()
	end

	self._gyros:openRotation(false)

	local mask = goutil.findChild(inst, "Mask")
	local beijing = goutil.findChild(inst, "01").transform:GetChild(0)

	TransformUtils.SetLocalScale(mask.transform, 1.077, 0, 0.6880000000000001)
	TransformUtils.SetLocalScale(beijing.transform, 5.61, 6.79, 0)

	local activationNode

	for i = 0, inst.transform.childCount - 1 do
		local child = inst.transform:GetChild(i)

		if string.match(child.name, "activation") then
			activationNode = child.gameObject
		end
	end

	self._gyros:setActivationNode(activationNode)
end

function M:_loadEffect2Done(inst, res)
	Astral.TransformUtil.SetLocalRotation(inst.transform, 0, 0, 90)

	local rawImage = self._effect2Go:GetComponent(UIComponentType.RawImage)
	local kUICameraAdditionalData = goutil.addComponentOnce(self._imgEffect2:getPhoto().producer.rtCamera.gameObject, ComponentType.UniversalAdditionalCameraData)

	rawImage.enabled = false
	kUICameraAdditionalData.renderPostProcessing = false

	local mat = UnityEngine.Material.New(self._rawImg.material)

	self._rawImg.material = mat

	local matReflect = UnityEngine.Material.New(self._rawImgReflect.material)

	self._rawImgReflect.material = matReflect

	self._rawImg.material:SetTexture("_BlendTex", rawImage.texture)
	self._rawImg.material:SetTextureOffset("_BlendTex", Vector2.New(0, 0))
	self._rawImg.material:SetFloat("_BlendFactor", 0)
	self._gyros:setEchoItemMatSetter(self._rawImg.material)
	self._gyros:setEchoItemEffectCam(inst)
	self._gyros:setEchoItemEffectCam(self._goZhengmian)
	self._gyros:setEchoMatReflect(self._rawImgReflect.material)

	if self._showGyros then
		self._gyros:openGyros()
	end

	self._gyros:openRotation(false)

	local mask = goutil.findChild(inst, "Mask")
	local beijing = goutil.findChild(inst, "01").transform:GetChild(0)

	TransformUtils.SetLocalScale(mask.transform, 1.077, 0, 0.6880000000000001)
	TransformUtils.SetLocalScale(beijing.transform, 5.61, 6.79, 0)

	local activationNode

	for i = 0, inst.transform.childCount - 1 do
		local child = inst.transform:GetChild(i)

		if string.match(child.name, "activation") then
			activationNode = child.gameObject
		end
	end

	self._gyros:setActivationNode(activationNode)
end

function M:_loadEffect12Done(inst, res)
	local rawImage = self._effect12Go:GetComponent(UIComponentType.RawImage)
	local rawImg = self._rawImg
	local rawImgReflect = self._rawImgReflect

	if not self._isSetCam then
		self._isSetCam = true

		local kUICameraAdditionalData = goutil.addComponentOnce(self._imgEffect12:getPhoto().producer.rtCamera.gameObject, ComponentType.UniversalAdditionalCameraData)

		kUICameraAdditionalData.renderPostProcessing = false

		self._imgEffect12:setCameraOrthographic(ECHO_BG_HEIGHT * 3 * 0.5 * 0.01)
		RawImageUtil.SetUvRect(rawImg, 0, 0, 1, 0.3333333333333333)
		RawImageUtil.SetUvRect(self._rawImgShow, 0, 0, 1, 0.3333333333333333)

		local mat = UnityEngine.Material.New(rawImg.material)

		rawImg.material = mat

		local matReflect = UnityEngine.Material.New(rawImgReflect.material)

		rawImgReflect.material = matReflect
		rawImg.texture = rawImage.texture

		rawImg.material:SetTexture("_BlendTex", rawImage.texture)
		rawImg.material:SetTextureOffset("_BlendTex", Vector2.New(0, 0.6666666666666666))
		rawImg.material:SetFloat("_BlendFactor", 0)

		rawImage.enabled = false

		goutil.setActive(rawImg.gameObject, true)
		rawImg:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)

		self._rawImgShow.texture = rawImage.texture

		self._rawImgShow:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)
		self._gyros:setEchoItemMatSetter(rawImg.material)
		self._gyros:setEchoMatReflect(rawImgReflect.material)
		self._gyros:setEchoItemEffectCam(self._goZhengmian)
	end

	self._gyros:setEchoItemEffectCam(inst)

	if self._showGyros then
		self._gyros:openGyros()
	end

	if string.match(res.ResPath, "_1") then
		local mask = goutil.findChild(inst, "Mask")

		TransformUtils.SetLocalScale(mask.transform, ECHO_BG_WIDTH * 0.001, 0, ECHO_BG_HEIGHT * 0.001)
		TransformUtils.SetLocalPosition(inst.transform, 0, ECHO_BG_HEIGHT * -0.01, 0)
	elseif string.match(res.ResPath, "_2") then
		local mask = goutil.findChild(inst, "Mask")

		TransformUtils.SetLocalScale(mask.transform, ECHO_BG_WIDTH * 0.001, 0, ECHO_BG_HEIGHT * 0.001)
		TransformUtils.SetLocalPosition(inst.transform, 0, ECHO_BG_HEIGHT * 0.01, 0)

		local activationNode

		for i = 0, inst.transform.childCount - 1 do
			local child = inst.transform:GetChild(i)

			if string.match(child.name, "activation") then
				activationNode = child.gameObject
			end
		end

		self._gyros:setActivationNode(activationNode)
	end
end

function M:_loadEffect34Done(inst, res)
	Astral.TransformUtil.SetLocalRotation(inst.transform, 0, 0, 0)

	local rawImage = self._effect12Go:GetComponent(UIComponentType.RawImage)
	local rawImg = self._rawImg
	local rawImgReflect = self._rawImgReflect

	if not self._isSetCam then
		self._isSetCam = true

		local kUICameraAdditionalData = goutil.addComponentOnce(self._imgEffect12:getPhoto().producer.rtCamera.gameObject, ComponentType.UniversalAdditionalCameraData)

		kUICameraAdditionalData.renderPostProcessing = false

		self._imgEffect12:setCameraOrthographic(ECHO_BG_HEIGHT * 3 * 0.5 * 0.01)
		RawImageUtil.SetUvRect(rawImg, 0, 0, 1, 0.3333333333333333)
		RawImageUtil.SetUvRect(self._rawImgShow, 0, 0, 1, 0.3333333333333333)

		local mat = UnityEngine.Material.New(rawImg.material)

		rawImg.material = mat

		local matReflect = UnityEngine.Material.New(rawImgReflect.material)

		rawImgReflect.material = matReflect
		rawImg.texture = rawImage.texture

		rawImg.material:SetTexture("_BlendTex", rawImage.texture)
		rawImg.material:SetTextureOffset("_BlendTex", Vector2.New(0, 0.6666666666666666))
		rawImg.material:SetFloat("_BlendFactor", 0)

		rawImage.enabled = false

		goutil.setActive(rawImg.gameObject, true)
		rawImg:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)

		self._rawImgShow.texture = rawImage.texture

		self._rawImgShow:DOFade(1, 0.15):SetEase(DG.Tweening.Ease.Linear)
		self._gyros:setEchoItemMatSetter(rawImg.material)
		self._gyros:setEchoMatReflect(rawImgReflect.material)
		self._gyros:setEchoItemEffectCam(self._goZhengmian)
	end

	self._gyros:setEchoItemEffectCam(inst)
	self._gyros:openRotation(false)

	if self._showGyros then
		self._gyros:openGyros()
	end

	if string.match(res.ResPath, "_1") then
		local mask = goutil.findChild(inst, "Mask")

		TransformUtils.SetLocalScale(mask.transform, ECHO_BG_WIDTH * 0.001, 0, ECHO_BG_HEIGHT * 0.001)
		TransformUtils.SetLocalPosition(inst.transform, 0, ECHO_BG_HEIGHT * -0.01, 0)
	elseif string.match(res.ResPath, "_2") then
		local mask = goutil.findChild(inst, "Mask")

		TransformUtils.SetLocalScale(mask.transform, ECHO_BG_WIDTH * 0.001, 0, ECHO_BG_HEIGHT * 0.001)
		TransformUtils.SetLocalPosition(inst.transform, 0, ECHO_BG_HEIGHT * 0.01, 0)

		local activationNode

		for i = 0, inst.transform.childCount - 1 do
			local child = inst.transform:GetChild(i)

			if string.match(child.name, "activation") then
				activationNode = child.gameObject
			end
		end

		self._gyros:setActivationNode(activationNode)
	end
end

function M:showGyros()
	self._showGyros = true
end

function M:setOtherPlayerUI(isOther)
	goutil.setActive(self._btnAdd.gameObject, not isOther)
end

function M:openEchoTestView()
	if Astral.OSDef.isEditor then
		self._gyros:maskTransition(false)
		ViewMgr.instance:open(ViewName.EchoGyrosTest, self._gyros)
	end
end

return M
