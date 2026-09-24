-- chunkname: @modules/logic/story/view/StoryHeroItem.lua

module("modules.logic.story.view.StoryHeroItem", package.seeall)

local StoryHeroItem = class("StoryHeroItem")
local screenSplitLeftStencilRef = 10
local screenSplitRightStencilRef = 30
local screenSplitStencilComp = 3
local screenSplitStencilOp = 0
local stencilPropName = "_Stencil"
local stencilCompPropName = "_StencilComp"
local stencilOpPropName = "_StencilOp"

function StoryHeroItem:init(go)
	self.viewGO = go
	self._heroCo = nil
	self._heroGo = nil
	self._heroSpine = {}
	self._isLightSpine = false
	self._heroEffects = {}
	self._heroSkeletonGraphic = nil

	StoryController.instance:registerCallback(StoryEvent.OnFollowPicture, self._playFollowPicture, self)
	StoryController.instance:registerCallback(StoryEvent.OnFollowPictureEnd, self._endFollowPicture, self)

	self._effectClearMethods = {
		[StoryEnum.HeroEffect.SetFlash] = self._clearHeroFlash,
		[StoryEnum.HeroEffect.SetDissolve] = self._clearHeroDissolve,
		[StoryEnum.HeroEffect.DissolveAndSoft] = self._clearHeroDissolveAndSoft,
		[StoryEnum.HeroEffect.WaterWave] = self._clearHeroWaterWave,
		[StoryEnum.HeroEffect.Erase] = self._clearHeroErase,
		[StoryEnum.HeroEffect.Glow] = self._clearHeroGlow,
		[StoryEnum.HeroEffect.BlackFog] = self._clearHeroBlackFog,
		[StoryEnum.HeroEffect.SetMaterial] = self._clearHeroMaterialScheme,
		[StoryEnum.HeroEffect.DLKBloom] = self._clearHeroDLKBloom
	}
	self._effectHandlers = {
		[StoryEnum.HeroEffect.Gray] = self.showGray,
		[StoryEnum.HeroEffect.StyDissolve] = self.showStyDissolve,
		[StoryEnum.HeroEffect.KeepAction] = self.showDefaultAction,
		[StoryEnum.HeroEffect.SetFlash] = self._setHeroFlash,
		[StoryEnum.HeroEffect.SetDissolve] = self._setHeroDissolve,
		[StoryEnum.HeroEffect.WaterWave] = self._setHeroWaterWave,
		[StoryEnum.HeroEffect.Erase] = self._setHeroErase,
		[StoryEnum.HeroEffect.Glow] = self._setHeroGlow,
		[StoryEnum.HeroEffect.BlackFog] = self._setHeroBlackFog,
		[StoryEnum.HeroEffect.DissolveAndSoft] = self._setHeroDissolveAndSoft,
		[StoryEnum.HeroEffect.SetAlpha] = self.showDefaultAction,
		[StoryEnum.HeroEffect.DLKBloom] = self.showDLKBloom,
		[StoryEnum.HeroEffect.SetMaterial] = self._setHeroMaterialScheme,
		[StoryEnum.HeroEffect.SetFadeIn] = self._setHeroFadeInParam,
		[StoryEnum.HeroEffect.SetFadeOut] = self._setHeroFadeOutParam
	}
end

function StoryHeroItem:_playFollowPicture(picGo, heroId)
	if self._heroCo.heroIndex ~= heroId then
		return
	end

	self._picGo = picGo

	TaskDispatcher.runRepeat(self._followPicture, self, 0.02)
end

function StoryHeroItem:_endFollowPicture(picGo, heroId)
	if self._heroCo.heroIndex ~= heroId then
		return
	end

	TaskDispatcher.cancelTask(self._followPicture, self)
end

function StoryHeroItem:_followPicture()
	if not self._picGo then
		TaskDispatcher.cancelTask(self._followPicture, self)

		return
	end

	local posX, posY = transformhelper.getLocalPos(self._picGo.transform)

	transformhelper.setLocalPosXY(self._heroGo.transform, posX, posY)

	self._heroGo.transform.localScale = self._picGo.transform.localScale
end

function StoryHeroItem:hideHero()
	self:_fadeOut()
end

function StoryHeroItem:resetHero(v, mat, hasBottomEffect, conAudioId)
	local lastHeroCo = self._heroCo

	self._heroCo = v

	self:initEffsCo()

	local replacePath = StoryModel.instance:getReplaceHeroPath(v.heroIndex)

	if replacePath then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, v)
		gohelper.setActive(self._heroSpineGo, false)

		return
	end

	self._noChangeBody = false

	TaskDispatcher.cancelTask(self._waitHeroSpineLoaded, self)

	self._conAudioId = conAudioId

	if self._heroGo.activeSelf then
		self._noChangeBody = self._heroSpineGo and self:hasHeroEffect(StoryEnum.HeroEffect.KeepAction)

		local typeIndex = GameLanguageMgr.instance:getVoiceTypeStoryIndex()

		if v.anims[typeIndex] ~= "" or v.expressions[typeIndex] ~= "" or v.mouses[typeIndex] ~= "" then
			local isAuto = string.find(v.mouses[typeIndex], "_auto")

			if not isAuto and v.anims[typeIndex] == lastHeroCo.anims[typeIndex] and v.expressions[typeIndex] == lastHeroCo.expressions[typeIndex] and v.mouses[typeIndex] == lastHeroCo.mouses[typeIndex] then
				if not self._isLightSpine then
					self:_setHeroMat(mat)
				end

				return
			end
		end
	end

	self._hasBottomEffect = hasBottomEffect

	ZProj.TweenHelper.KillByObj(self._heroGo.transform)

	if not self._isLightSpine then
		self:_setHeroMat(mat)

		if self._heroGo.activeSelf then
			if self._heroSpineGo then
				ZProj.TweenHelper.DOLocalMoveX(self._heroSpineGo.transform, self._heroCo.heroPos[1], 0.4)
				ZProj.TweenHelper.DOLocalMoveY(self._heroSpineGo.transform, self._heroCo.heroPos[2], 0.4)
				ZProj.TweenHelper.DOScale(self._heroSpineGo.transform, self._heroCo.heroScale, self._heroCo.heroScale, 1, 0.1)
			end

			self:_fadeIn()
			self:_playHeroVoice()
		else
			if self._heroSpineGo then
				transformhelper.setLocalPosXY(self._heroSpineGo.transform, self._heroCo.heroPos[1], self._heroCo.heroPos[2])
				transformhelper.setLocalScale(self._heroSpineGo.transform, self._heroCo.heroScale, self._heroCo.heroScale, 1)
			end

			self:_fadeIn()
			self:_playHeroVoice()
		end
	end

	gohelper.setActive(self._heroGo, true)
end

function StoryHeroItem:_fadeIn()
	if self._isLightSpine or not self._isLive2D and not self._heroSkeletonGraphic then
		gohelper.setActive(self._heroSpineGo, true)

		return
	end

	self:_checkMatKeyWord()

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	local targetAlpha = 1

	if self:hasHeroEffect(StoryEnum.HeroEffect.SetAlpha) then
		local effs = self._effectCoDict[StoryEnum.HeroEffect.SetAlpha]

		if effs then
			targetAlpha = tonumber(effs[2])
		end
	end

	if self._targetAlpha and self._targetAlpha == targetAlpha then
		self:_fadeUpdate(targetAlpha)

		return
	end

	if not self._targetAlpha then
		local startAlpha = 0

		self._targetAlpha = targetAlpha

		if self:hasHeroEffect(StoryEnum.HeroEffect.SetFadeIn) then
			local effs = self._effectCoDict[StoryEnum.HeroEffect.SetFadeIn]

			if effs then
				self._fadeInTime = tonumber(effs[2])
			end
		end

		if not self._fadeInTime then
			local duration = 0.5
			local easeType = EaseType.Linear

			if self:hasHeroEffect(StoryEnum.HeroEffect.DLKBloom) then
				duration = 1
				easeType = EaseType.InBounce
			end

			self._fadeInTweenId = ZProj.TweenHelper.DOTweenFloat(startAlpha, self._targetAlpha, duration, self._fadeUpdate, self._fadeInFinished, self, nil, easeType)
		end
	end
end

function StoryHeroItem:_fadeUpdate(value)
	if not self._heroSpine then
		return
	end

	if not self._heroSpineGo then
		return
	end

	if self._isLive2D then
		self._heroSpine:setAlpha(value)
	else
		local x, y, z = transformhelper.getLocalPos(self._heroSpineGo.transform)

		transformhelper.setLocalPos(self._heroSpineGo.transform, x, y, 1 - value)
	end

	local customEffectComp = self._heroSpine:getCustomEffectComp()

	if customEffectComp and customEffectComp.setAlpha then
		customEffectComp:setAlpha(value)
	end

	self:_setHeroFadeMat()
end

function StoryHeroItem:_setHeroFadeMat()
	local bgImgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()
	local posx, posy = transformhelper.getLocalPos(bgImgGo.transform)
	local scalex, scaley = transformhelper.getLocalScale(bgImgGo.transform)
	local vec4 = Vector4.New(scalex, scaley, posx, posy)
	local texture = self._blitEff.capturedTexture

	if self._heroSpine and self._isLive2D then
		self._heroSpine:setSceneTexture(texture)
	elseif self._heroSkeletonGraphic then
		self._heroSkeletonGraphic.materialForRendering:SetTexture("_SceneMask", texture)
		self._heroSkeletonGraphic.materialForRendering:SetVector("_SceneMask_ST", vec4)
	end
end

function StoryHeroItem:_fadeInFinished()
	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	if self._targetAlpha < 1 then
		return
	end

	if self._heroSkeletonGraphic then
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if self._heroSpine and self._isLive2D then
		self._heroSpine:disableSceneAlpha()
	end
end

function StoryHeroItem:_isSpMat()
	if self:hasHeroEffect(StoryEnum.HeroEffect.Erase) then
		local effs = self._effectCoDict[StoryEnum.HeroEffect.Erase]

		if tonumber(effs[2]) == 0 then
			return true
		end
	end

	return false
end

function StoryHeroItem:_setHeroMat(mat)
	if self._isLightSpine then
		return
	end

	if self:_isSpMat() then
		return
	end

	if not self._isLive2D and not self._heroSkeletonGraphic then
		return
	end

	if not self._heroSpine then
		return
	end

	if self._isLive2D then
		if string.match(mat.name, "spine_ui_default") and self._initMat then
			mat = self._initMat
		end

		if string.match(mat.name, "spine_ui_dark") then
			self._heroSpine:SetDark()
		else
			self._heroSpine:SetBright()
		end

		return
	end

	if self._heroSkeletonGraphic then
		if self._initMat then
			if self._heroSkeletonGraphic.material and string.match(self._heroSkeletonGraphic.material.name, mat.name) then
				return
			end

			if string.match(mat.name, "spine_ui_default") then
				mat = self._initMat

				local color = Color.New(1, 1, 1, 1)

				mat:SetColor("_Color", color)
			else
				mat = self._initMat

				local color = Color.New(0.6, 0.6, 0.6, 1)

				mat:SetColor("_Color", color)
			end
		end

		self._heroSkeletonGraphic.material = mat
	end
end

function StoryHeroItem:_checkMatKeyWord()
	if self._heroSpine and self._isLive2D then
		self._heroSpine:enableSceneAlpha()
	end

	if not self._heroSkeletonGraphic then
		gohelper.setActive(self._heroSpineGo, true)

		return
	end

	if self._hasBottomEffect then
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		self._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA2_ON")
	else
		self._heroSkeletonGraphic.material:EnableKeyword("_SCENEMASKALPHA_ON")
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	TaskDispatcher.runDelay(self._onDelay, self, 0.05)
end

function StoryHeroItem:_onDelay()
	local replacePath = StoryModel.instance:getReplaceHeroPath(self._heroCo.heroIndex)

	if replacePath then
		StoryController.instance:dispatchEvent(StoryEvent.OnReplaceHero, self._heroCo)
		gohelper.setActive(self._heroSpineGo, false)

		return
	end

	gohelper.setActive(self._heroSpineGo, true)
end

function StoryHeroItem:_fadeOut()
	if not self._heroSpine then
		return
	end

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	if self._isLightSpine or not self._isLive2D and not self._heroSkeletonGraphic then
		self._heroSpine:stopVoice()
		gohelper.setActive(self._heroGo, false)

		return
	end

	if not self._fadeOutTime then
		local fadeOutDuration = 0.35

		if self._heroGlowCls then
			self._heroGlowCls:startFadeOut(fadeOutDuration)
			self:_setHeroFadeMat()
		end

		self:_checkMatKeyWord()

		if self._fadeOutTweenId then
			ZProj.TweenHelper.KillById(self._fadeOutTweenId)

			self._fadeOutTweenId = nil
		end

		if not self._targetAlpha then
			local startAlpha = 1
			local easeType = EaseType.Linear

			if self:hasHeroEffect(StoryEnum.HeroEffect.DLKBloom) then
				fadeOutDuration = 0.7
			end

			self._fadeOutTweenId = ZProj.TweenHelper.DOTweenFloat(startAlpha, 0, fadeOutDuration, self._fadeUpdate, self._fadeOutFinished, self, nil, easeType)

			if self:hasHeroEffect(StoryEnum.HeroEffect.DLKBloom) and self._heroDlkBloomCls then
				self._heroDlkBloomCls:onFadeOut()
			end

			self.fadeOutCls = self.fadeOutCls or StoryHeroEffectFadeOut.New()

			self.fadeOutCls:fadeOut(self._heroSpine:getSpineGo(), fadeOutDuration)
		end
	end
end

function StoryHeroItem:_fadeOutFinished()
	if not self._heroSpine then
		return
	end

	gohelper.setActive(self._heroGo, false)
	self:_fadeUpdate(1)

	if self._heroSkeletonGraphic then
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if self._heroSpine and self._isLive2D then
		self._heroSpine:disableSceneAlpha()
	end

	self:onDestroy()
end

function StoryHeroItem:buildHero(v, mat, hasBottomEffect, callback, callbackObj, conAudioId)
	self._noChangeBody = false
	self._conAudioId = conAudioId
	self._heroCo = v

	self:initEffsCo()

	self._heroGo = gohelper.create2d(self.viewGO, "rolespine")

	local canvas = gohelper.onceAddComponent(self._heroGo, typeof(UnityEngine.Canvas))

	canvas.overrideSorting = true

	local siblingIndex = gohelper.getSibling(self._heroGo)
	local baseOrder = 10

	self._blitEff = StoryViewMgr.instance:getStoryBlitEff()

	gohelper.setLayer(self._heroGo, self.viewGO.layer, true)

	local heroCo = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(self._heroCo.heroIndex)

	if not heroCo then
		return
	end

	local path = heroCo.type == 0 and string.format("rolesstory/%s", heroCo.prefab) or string.format("live2d/roles/%s", heroCo.live2dPrefab)
	local tags = string.split(path, "_")

	self._isLive2D = false
	self._isLightSpine = string.split(tags[#tags], ".")[1] == "light"

	if self._isLightSpine then
		self._heroSpine = LightSpine.Create(self._heroGo, true)

		self._heroSpine:setResPath(path, function()
			self._heroSpineGo = self._heroSpine:getSpineGo()

			self:_playHeroVoice()
			self:_setHeroMat(mat)

			if callback then
				callback(callbackObj)
			end

			transformhelper.setLocalPos(self._heroSpineGo.transform, self._heroCo.heroPos[1], self._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(self._heroSpineGo.transform, self._heroCo.heroScale, self._heroCo.heroScale, 1)
		end)
	elseif heroCo.type == 0 then
		self._heroSpine = GuiSpine.Create(self._heroGo, true)

		self._heroSpine:setResPath(path, function()
			self._heroSkeletonGraphic = self._heroSpine:getSkeletonGraphic()
			self._heroSpineGo = self._heroSpine:getSpineGo()

			gohelper.setLayer(self._heroSpineGo, self._heroGo.layer, true)
			gohelper.setActive(self._heroSpineGo, false)

			canvas.sortingOrder = (siblingIndex + 1) * 10 + baseOrder

			if self._heroSkeletonGraphic and not string.match(self._heroSkeletonGraphic.material.name, "spine_ui_default") then
				self._initMat = self._heroSkeletonGraphic.material
			end

			self:_setHeroMat(mat)
			self:_fadeIn()
			self:_playHeroVoice()

			if StoryModel.instance:isInScreenSplitMode() then
				self:setScreenSplitStencil(self._heroCo.heroPos[1] < 0)
			end

			if callback then
				callback(callbackObj)
			end

			transformhelper.setLocalPos(self._heroSpineGo.transform, self._heroCo.heroPos[1], self._heroCo.heroPos[2], 0)
			transformhelper.setLocalScale(self._heroSpineGo.transform, self._heroCo.heroScale, self._heroCo.heroScale, 1)
		end)
	else
		self._isLive2D = true
		self._heroSpine = GuiLive2d.Create(self._heroGo, true)

		self._heroSpine:cancelCamera()
		self._heroSpine:setResPath(path, function()
			if not self._heroSpine then
				return
			end

			self._heroSpineGo = self._heroSpine:getSpineGo()

			if string.match(self._heroSpineGo.name, "306301_pikelesi") then
				local dianzi = gohelper.findChild(self._heroSpineGo, "Drawables/ArtMesh188")

				gohelper.setActive(dianzi, false)
			end

			gohelper.setActive(self._heroSpineGo, false)
			self._heroSpine:setSortingOrder(siblingIndex * 10 + baseOrder)

			canvas.sortingOrder = (siblingIndex + 1) * 10 + baseOrder

			gohelper.setLayer(self._heroSpineGo, self._heroGo.layer, true)
			self:_setHeroMat(mat)
			self:_fadeIn()
			self:_playHeroVoice()

			if StoryModel.instance:isInScreenSplitMode() then
				self:setScreenSplitStencil(self._heroCo.heroPos[1] < 0)
			end

			if callback then
				callback(callbackObj)
			end

			transformhelper.setLocalPos(self._heroSpineGo.transform, self._heroCo.heroPos[1], self._heroCo.heroPos[2], 0)
			self._heroSpine:setLocalScale(self._heroCo.heroScale)
		end)
	end
end

function StoryHeroItem:_grayUpdate(value)
	if self._isLive2D then
		if not self._heroSpineGo then
			return
		end

		local cubctrl = self._heroSpineGo:GetComponent(typeof(ZProj.CubismController))

		if cubctrl then
			for i = 0, cubctrl.InstancedMaterials.Length - 1 do
				cubctrl.InstancedMaterials[i]:SetFloat("_LumFactor", value)
			end
		end
	elseif self._heroSkeletonGraphic then
		local mat = self._heroSkeletonGraphic.material

		if mat then
			mat:SetFloat("_LumFactor", value)
		end
	end
end

function StoryHeroItem:_grayFinished()
	self:_grayUpdate(1)

	if self._grayTweenId then
		ZProj.TweenHelper.KillById(self._grayTweenId)

		self._grayTweenId = nil
	end
end

function StoryHeroItem:_playHeroVoice()
	TaskDispatcher.cancelTask(self._waitHeroSpineLoaded, self)

	if not self._heroSpineGo then
		TaskDispatcher.runRepeat(self._waitHeroSpineLoaded, self, 0.01)

		return
	end

	self:_waitHeroSpineLoaded()
end

function StoryHeroItem:_waitHeroSpineLoaded()
	if not self._heroSpine then
		return
	end

	if not self._heroSpineGo then
		return
	end

	local heroCo = StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(self._heroCo.heroIndex)

	if not LuaUtil.isEmptyStr(heroCo.hideNodes) then
		local hideNodePaths = string.split(heroCo.hideNodes, "|")

		for _, hideNodePath in ipairs(hideNodePaths) do
			if string.find(hideNodePath, StoryEnum.HeroEffect.SetSkin) then
				local skinName = string.split(hideNodePath, "#")[2]
				local sg = self._heroSpine:getSkeletonGraphic()

				sg.Skeleton:SetSkin(skinName)
				sg.Skeleton:SetSlotsToSetupPose()
			elseif string.find(hideNodePath, StoryEnum.HeroEffect.SetParam) then
				local params = string.split(hideNodePath, "#")
				local paramName = params[2]

				if #params > 2 then
					if not params[3] then
						local paramValue = 0
						local cubctrl = self._heroSpineGo:GetComponent(typeof(ZProj.CubismController))

						if cubctrl then
							local cubParamModifider = cubctrl:GetCubismParameterModifier()

							if cubParamModifider then
								cubParamModifider:AddParameter(paramName, 0, paramValue)
							end
						end
					end
				end
			elseif string.find(hideNodePath, StoryEnum.HeroEffect.HideNode) then
				local nodeName = string.split(hideNodePath, "#")[2]
				local go = gohelper.findChild(self._heroSpineGo, nodeName)

				gohelper.setActive(go, false)
			elseif string.find(hideNodePath, StoryEnum.HeroEffect.ShowNode) then
				local nodeName = string.split(hideNodePath, "#")[2]
				local go = gohelper.findChild(self._heroSpineGo, nodeName)

				gohelper.setActive(go, true)
			else
				local go = gohelper.findChild(self._heroSpineGo, hideNodePath)

				gohelper.setActive(go, false)
			end
		end
	end

	self:_grayUpdate(0)
	TaskDispatcher.cancelTask(self._waitHeroSpineLoaded, self)

	local motion = self._heroCo.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local needStopVoice = true
	local skipStopVoiceFlag = "flag_skipvoicestop|"

	if string.find(motion, skipStopVoiceFlag) then
		needStopVoice = false
		motion = string.gsub(motion, skipStopVoiceFlag, "")
	end

	if needStopVoice and not self._noChangeBody then
		self._heroSpine:stopVoice()
	end

	local co = {}

	co.motion = motion
	co.face = self._heroCo.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	co.mouth = self._heroCo.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	co.storyAudioId = self._conAudioId
	co.storyHeroIndex = self._heroCo.heroIndex
	co.noChangeBody = self._noChangeBody
	co.initCut = self:hasHeroEffect("flag_initcut")

	local spineVoice = self._heroSpine:getSpineVoice()

	spineVoice:setDiffFaceBiYan(true)
	spineVoice:setInStory()
	self._heroSpine:playVoice(co)
	self:_checkAndPlayHeroEffect()
	TaskDispatcher.cancelTask(self._delayHide, self)

	if co.initCut then
		if self._fadeInTweenId then
			self:_fadeUpdate(0)
		end

		self._frameIndex = 0

		TaskDispatcher.runRepeat(self._delayHide, self, 0)
	end
end

function StoryHeroItem:_delayHide()
	self._frameIndex = self._frameIndex + 1

	if self._frameIndex >= 6 then
		TaskDispatcher.cancelTask(self._delayHide, self)
	end

	if self._fadeInTweenId then
		self:_fadeUpdate(0)
	end
end

function StoryHeroItem:initEffsCo()
	local effCo = self._heroCo.effs[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	self._effCo = effCo
	self._effectCos = GameUtil.splitString2(effCo, false, "|", "#")
	self._effectCoDict = {}

	if self._effectCos then
		for _, effs in ipairs(self._effectCos) do
			self._effectCoDict[effs[1]] = effs
		end
	end
end

function StoryHeroItem:hasHeroEffect(effectName)
	return self._effectCoDict[effectName] ~= nil
end

function StoryHeroItem:getHeroEffectParam(effectName)
	return self._effectCoDict[effectName]
end

function StoryHeroItem:clearAllHeroEffects()
	for _, methodFunc in pairs(self._effectClearMethods) do
		methodFunc(self)
	end
end

function StoryHeroItem:_checkAndPlayHeroEffect()
	if self._grayTweenId then
		ZProj.TweenHelper.KillById(self._grayTweenId)

		self._grayTweenId = nil
	end

	local effCo = self._effCo

	if string.nilorempty(effCo) then
		self:clearAllHeroEffects()

		return
	end

	local effectCos = self._effectCos

	if not effectCos or #effectCos < 1 then
		return
	end

	local activeEffects = {}

	for _, group in ipairs(effectCos) do
		if group[1] then
			activeEffects[group[1]] = true
		end
	end

	for effectName, methodFunc in pairs(self._effectClearMethods) do
		if not activeEffects[effectName] then
			methodFunc(self)
		end
	end

	local customEffectList = {}

	for _, effs in ipairs(effectCos) do
		if self:_applySingleEffect(effs) then
			table.insert(customEffectList, effs)
		end
	end

	if customEffectList then
		self:_playGenericHeroEffect(customEffectList)
	end
end

function StoryHeroItem:_applySingleEffect(effs)
	local handler = self._effectHandlers[effs[1]]

	if handler then
		handler(self, effs)
	else
		return true
	end
end

function StoryHeroItem:_playGenericHeroEffect(effectCos)
	if not self._heroSpineGo then
		return
	end

	if self._heroLoader then
		self._heroLoader:dispose()
	end

	if not effectCos or #effectCos < 1 then
		return
	end

	self._heroLoader = MultiAbLoader.New()

	for _, v in ipairs(effectCos) do
		if not v or #v < 2 or string.find(v[2], "roomcritteremoji") then
			return
		end

		self._heroLoader:addPath(string.format("effects/prefabs/story/%s.prefab", v[2]))
	end

	self._heroLoader:startLoad(function()
		for _, v in ipairs(effectCos) do
			local path = string.format("effects/prefabs/story/%s.prefab", v[2])
			local prefab = self._heroLoader:getAssetItem(path):GetResource(path)
			local go = gohelper.findChild(self._heroSpineGo, string.format("root/%s", v[1]))
			local effGo = gohelper.clone(prefab, go)
			local scale = transformhelper.getLocalScale(effGo.transform)

			transformhelper.setLocalPos(effGo.transform, tonumber(v[3]), tonumber(v[4]), 0)
			transformhelper.setLocalScale(effGo.transform, scale * tonumber(v[5]), scale * tonumber(v[5]), 1)
		end
	end)
end

function StoryHeroItem:showDefaultAction()
	return
end

function StoryHeroItem:showGray(params)
	local grayTime = tonumber(params[2])

	if grayTime and grayTime > 0.1 then
		self._grayTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, grayTime, self._grayUpdate, self._grayFinished, self, nil, EaseType.Linear)
	else
		self:_grayUpdate(1)
	end
end

function StoryHeroItem:showStyDissolve(params)
	self._heroLoader = MultiAbLoader.New()

	local styMatPath = "ui/materials/dynamic/spine_ui_stydissolve.mat"
	local styPrefabPath = "ui/viewres/story/v1a9_role_stydissolve.prefab"

	self._heroLoader:addPath(styMatPath)
	self._heroLoader:addPath(styPrefabPath)
	self._heroLoader:startLoad(function()
		self._styDissolveMat = self._heroLoader:getAssetItem(styMatPath):GetResource(styMatPath)
		self._styDissolvePrefab = self._heroLoader:getAssetItem(styPrefabPath):GetResource(styPrefabPath)

		local dissolveTime = tonumber(params[2])

		if dissolveTime and dissolveTime > 0.1 then
			TaskDispatcher.runDelay(self._setStyDissolve, self, dissolveTime)
		else
			self:_setStyDissolve()
		end
	end)
end

function StoryHeroItem:_clearHeroMaterialScheme()
	if self._heroMaterialInitValues and self._heroSkeletonGraphic then
		local mat = self._heroSkeletonGraphic.material

		StoryTool.applyMaterialBySchemeValues(mat, self._heroMaterialInitValues)
	end
end

function StoryHeroItem:_setHeroMaterialScheme(param)
	if self._heroSkeletonGraphic then
		local schemeId = tonumber(param[2])
		local mat = self._heroSkeletonGraphic.material

		self._heroMaterialInitValues = StoryTool.getMaterialSchemeInitValues(mat, schemeId)

		StoryTool.applyMaterialScheme(mat, schemeId)
	end
end

function StoryHeroItem:_setHeroFadeInParam(param)
	self._fadeInTime = tonumber(param[2]) or 0
end

function StoryHeroItem:_setHeroFadeOutParam(param)
	self._fadeOutTime = tonumber(param[2]) or 0
end

function StoryHeroItem:showDLKBloom(param)
	if self._isLive2D and self._heroSpine then
		self._heroDlkBloomCls = self._heroDlkBloomCls or StoryHeroEffsDlkBloom.New()

		self._heroDlkBloomCls:init(self._heroSpine)

		local bloom = tonumber(param[2])

		self._heroDlkBloomCls:showDLKBloom(bloom)
	end
end

function StoryHeroItem:_clearHeroDLKBloom()
	if self._heroDlkBloomCls then
		self._heroDlkBloomCls:destroy()

		self._heroDlkBloomCls = nil
	end
end

function StoryHeroItem:_setHeroFlash(param)
	self._heroFlashCls = self._heroFlashCls or StoryHeroEffsFlash.New()

	self._heroFlashCls:init(self._heroSpineGo, param[2])
	self._heroFlashCls:start()
end

function StoryHeroItem:_clearHeroFlash()
	if self._heroFlashCls then
		self._heroFlashCls:destroy()

		self._heroFlashCls = nil
	end
end

function StoryHeroItem:_setHeroDissolve(param)
	self._heroDissolveCls = self._heroDissolveCls or StoryHeroEffsDissolve.New()

	self._heroDissolveCls:init(self._heroSpineGo)
	self._heroDissolveCls:start(param[2])
end

function StoryHeroItem:_clearHeroDissolve()
	if self._heroDissolveCls then
		self._heroDissolveCls:destroy()

		self._heroDissolveCls = nil
	end
end

function StoryHeroItem:_setHeroDissolveAndSoft(param)
	self._heroDissolveAndSoftCls = self._heroDissolveAndSoftCls or StoryHeroEffsDissolveAndSoft.New()

	self._heroDissolveAndSoftCls:init(self._heroSpineGo)
	self._heroDissolveAndSoftCls:start(param[2])
end

function StoryHeroItem:_clearHeroDissolveAndSoft()
	if self._heroDissolveAndSoftCls then
		self._heroDissolveAndSoftCls:destroy()

		self._heroDissolveAndSoftCls = nil
	end
end

function StoryHeroItem:_setHeroWaterWave()
	self._heroWaterWaveCls = self._heroWaterWaveCls or StoryHeroEffsWaterWave.New()

	self._heroWaterWaveCls:init(self._heroSpineGo)
	self._heroWaterWaveCls:start()
end

function StoryHeroItem:_clearHeroWaterWave()
	if self._heroWaterWaveCls then
		self._heroWaterWaveCls:destroy()

		self._heroWaterWaveCls = nil
	end
end

function StoryHeroItem:_setHeroErase(param)
	local eraseparam = tonumber(param[2])

	if not self._heroEraseCls then
		if eraseparam == 1 then
			return
		end

		self._heroEraseCls = StoryHeroEffsErase.New()

		self._heroEraseCls:init(self._heroSpineGo, self._heroSpine)
		self._heroEraseCls:start(eraseparam)
	else
		self._heroEraseCls:reset(eraseparam)
	end
end

function StoryHeroItem:_clearHeroErase()
	if self._heroEraseCls then
		self._heroEraseCls:destroy()

		self._heroEraseCls = nil
	end
end

function StoryHeroItem:_setHeroGlow()
	self._heroGlowCls = self._heroGlowCls or StoryHeroEffsGlow.New()

	self._heroGlowCls:init(self._heroSpineGo)
	self._heroGlowCls:start()
end

function StoryHeroItem:_clearHeroGlow()
	if self._heroGlowCls then
		self._heroGlowCls:destroy()

		self._heroGlowCls = nil
	end
end

function StoryHeroItem:_setHeroBlackFog()
	self._heroBlackFogCls = self._heroBlackFogCls or StoryHeroEffsBlackFog.New()

	self._heroBlackFogCls:init(self._heroSpineGo)
	self._heroBlackFogCls:start()
end

function StoryHeroItem:_clearHeroBlackFog()
	if self._heroBlackFogCls then
		self._heroBlackFogCls:destroy()

		self._heroBlackFogCls = nil
	end
end

function StoryHeroItem:_setStyDissolve()
	self._heroSkeletonGraphic.material = UnityEngine.Material.Instantiate(self._styDissolveMat)

	gohelper.clone(self._styDissolvePrefab, self._heroSpineGo)
end

function StoryHeroItem:setScreenSplitStencil(isLeft)
	self._inScrennSplitStencil = true

	if isLeft then
		if not screenSplitLeftStencilRef then
			local stencilRef = screenSplitRightStencilRef
			local heroSkeletonGraphic = self._heroSkeletonGraphic

			if heroSkeletonGraphic and heroSkeletonGraphic.material then
				local material = heroSkeletonGraphic.material

				self:_setScreenSplitStencilOnMaterial(material, stencilRef)

				return
			end

			local heroSpineGo = self._heroSpineGo

			if not heroSpineGo or gohelper.isNil(heroSpineGo) then
				return
			end

			local cubctrl = heroSpineGo:GetComponent(typeof(ZProj.CubismController))

			if cubctrl then
				for i = 0, cubctrl.InstancedMaterials.Length - 1 do
					local material = cubctrl.InstancedMaterials[i]

					self:_setScreenSplitStencilOnMaterial(material, stencilRef)
				end
			end
		end
	end
end

function StoryHeroItem:revertScreenSplitStencil()
	self._inScrennSplitStencil = false

	self:_restoreScreenSplitStencil()
end

function StoryHeroItem:_setScreenSplitStencilOnMaterial(material, stencilRef)
	if gohelper.isNil(material) then
		return
	end

	self:_recordScreenSplitStencil(material)

	if material:HasProperty(stencilPropName) then
		material:SetFloat(stencilPropName, stencilRef)
	end

	if material:HasProperty(stencilCompPropName) then
		material:SetFloat(stencilCompPropName, screenSplitStencilComp)
	end

	if material:HasProperty(stencilOpPropName) then
		material:SetFloat(stencilOpPropName, screenSplitStencilOp)
	end
end

function StoryHeroItem:_recordScreenSplitStencil(material)
	if gohelper.isNil(material) then
		return
	end

	self._screenSplitStencilData = self._screenSplitStencilData or {}

	if self._screenSplitStencilData[material] then
		return
	end

	local data = {}

	if material:HasProperty(stencilPropName) then
		data.stencil = material:GetFloat(stencilPropName)
	end

	if material:HasProperty(stencilCompPropName) then
		data.stencilComp = material:GetFloat(stencilCompPropName)
	end

	if material:HasProperty(stencilOpPropName) then
		data.stencilOp = material:GetFloat(stencilOpPropName)
	end

	self._screenSplitStencilData[material] = data
end

function StoryHeroItem:_restoreScreenSplitStencil()
	if not self._screenSplitStencilData then
		return
	end

	for material, data in pairs(self._screenSplitStencilData) do
		if not gohelper.isNil(material) then
			if data.stencil ~= nil and material:HasProperty(stencilPropName) then
				material:SetFloat(stencilPropName, data.stencil)
			end

			if data.stencilComp ~= nil and material:HasProperty(stencilCompPropName) then
				material:SetFloat(stencilCompPropName, data.stencilComp)
			end

			if data.stencilOp ~= nil and material:HasProperty(stencilOpPropName) then
				material:SetFloat(stencilOpPropName, data.stencilOp)
			end
		end
	end

	self._screenSplitStencilData = nil
end

function StoryHeroItem:stopVoice()
	if self._heroSpine then
		self._heroSpine:stopVoice()
	end
end

function StoryHeroItem:onDestroy()
	StoryController.instance:unregisterCallback(StoryEvent.OnFollowPicture, self._playFollowPicture, self)
	StoryController.instance:unregisterCallback(StoryEvent.OnFollowPictureEnd, self._endFollowPicture, self)
	TaskDispatcher.cancelTask(self._followPicture, self)
	self:clearAllHeroEffects()
	self:revertScreenSplitStencil()
	TaskDispatcher.cancelTask(self._onDelay, self)
	TaskDispatcher.cancelTask(self._delayHide, self)
	self:_grayUpdate(0)

	if self._fadeInTweenId then
		ZProj.TweenHelper.KillById(self._fadeInTweenId)

		self._fadeInTweenId = nil
	end

	if self._fadeOutTweenId then
		ZProj.TweenHelper.KillById(self._fadeOutTweenId)

		self._fadeOutTweenId = nil
	end

	if self._grayTweenId then
		ZProj.TweenHelper.KillById(self._grayTweenId)

		self._grayTweenId = nil
	end

	if self._heroSpineGo then
		gohelper.destroy(self._heroSpineGo)

		self._heroSpineGo = nil
	end

	if self._heroGo then
		ZProj.TweenHelper.KillByObj(self._heroGo.transform)
		gohelper.destroy(self._heroGo)
	end

	if self._heroSkeletonGraphic then
		ZProj.TweenHelper.KillByObj(self._heroSkeletonGraphic)
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA_ON")
		self._heroSkeletonGraphic.material:DisableKeyword("_SCENEMASKALPHA2_ON")
	end

	if self._heroLoader then
		self._heroLoader:dispose()

		self._heroLoader = nil
	end

	if self._heroSpine then
		self._heroSpine:onDestroy()

		self._heroSpine = nil
	end

	if self.fadeOutCls then
		self.fadeOutCls:destroy()

		self.fadeOutCls = nil
	end
end

return StoryHeroItem
