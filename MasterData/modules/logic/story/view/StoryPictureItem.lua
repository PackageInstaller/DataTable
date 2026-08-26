-- chunkname: @modules/logic/story/view/StoryPictureItem.lua

module("modules.logic.story.view.StoryPictureItem", package.seeall)

local StoryPictureItem = class("StoryPictureItem")

function StoryPictureItem:_isSpImg()
	local isJp = GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.JP
	local isSp = string.match(self._picCo.picture, "v2a5_liangyue_story")

	return isSp and not isJp
end

function StoryPictureItem:init(go, name, picCo)
	self.viewGO = go
	self._picParentGo = gohelper.create2d(self.viewGO, name)
	self._picName = name
	self._picCo = picCo
	self._picGo = nil
	self._picImg = nil
	self._picLoaded = false

	if picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(self._build, self, picCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		self:_build()
	end

	StoryController.instance:registerCallback(StoryEvent.OnHeroShowed, self._checkFollowHero, self)
end

function StoryPictureItem:_checkFollowHero()
	if self._picCo.picType ~= StoryEnum.PictureType.HeroFollow then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.OnFollowPicture, self._picGoRoot, tonumber(self._picCo.picture))
end

function StoryPictureItem:_build()
	if not self._picParentGo then
		return
	end

	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		return
	end

	if self._picCo.layer == StoryEnum.PicLayer.BetweenBgAndHero3 then
		self._picRootCanvas = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.Canvas))
		self._picRootCanvas.overrideSorting = true
		self._picRootCanvas.sortingLayerName = "Unit"
		self._picRootCanvas.sortingOrder = 6
	end

	TaskDispatcher.cancelTask(self._realDestroy, self)

	if self._pictureLoader then
		self._pictureLoader:dispose()

		self._pictureLoader = nil
	end

	if self:_isSpImg() then
		return
	end

	if self._picCo.picType == StoryEnum.PictureType.FullScreen then
		local path = "ui/viewres/story/view/storyfullfocusitem.prefab"

		self._pictureLoader = PrefabInstantiate.Create(self._picParentGo)

		self._pictureLoader:startLoad(path, self._onFullFocusPictureLoaded, self)
	else
		local path = "ui/viewres/story/view/storynormalpicitem.prefab"

		self._pictureLoader = PrefabInstantiate.Create(self._picParentGo)

		self._pictureLoader:startLoad(path, self._onPicPrefabLoaded, self)
	end
end

function StoryPictureItem:_onPicPrefabLoaded()
	if not self._pictureLoader then
		return
	end

	self._picLoaded = true
	self._picGo = self._pictureLoader:getInstGO()
	self._picAni = self._picGo:GetComponent(typeof(UnityEngine.Animator))
	self._picAni.enabled = false
	self._picGoRoot = gohelper.findChild(self._picGo, "root")

	transformhelper.setLocalPosXY(self._picGoRoot.transform, self._picCo.pos[1], self._picCo.pos[2])

	self._simg = gohelper.findChildSingleImage(self._picGo, "root/result")
	self._gotmptxt = gohelper.findChild(self._picGo, "root/#go_tmptxt")
	self._tmpTxts = {}

	for i = 1, 3 do
		local tmpTxt = gohelper.findChildText(self._gotmptxt, "txt" .. i)

		table.insert(self._tmpTxts, tmpTxt)
	end

	self._gosptxt = gohelper.findChild(self._picGo, "root/#go_sptxt")
	self._spTxts = {}

	for i = 1, 3 do
		local spTxt = gohelper.findChildText(self._gosptxt, "txt" .. i)

		table.insert(self._spTxts, spTxt)
	end

	transformhelper.setLocalPosXY(self._gotmptxt.transform, 0, 0)
	transformhelper.setLocalPosXY(self._gosptxt.transform, 0, 0)

	if self._picCo.picType == StoryEnum.PictureType.PicTxt then
		gohelper.setActive(self._simg.gameObject, false)

		local index = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
		local curLang = GameLanguageMgr.instance:getShortCutByStoryIndex(index)
		local txtCo = string.splitToNumber(self._picCo.picture, "#")
		local picTxtCo = StoryConfig.instance:getStoryPicTxtConfig(tonumber(txtCo[1]))
		local fontType = 0
		local hasCn = LuaUtil.containChinese(picTxtCo[LangSettings.shortcutTab[LangSettings.zh]])

		fontType = hasCn and picTxtCo.fontType ~= 0 and self._picCo.inType == StoryEnum.PictureInType.TxtFadeIn and 0 or picTxtCo.fontType + 1

		if fontType ~= 0 and not self._spTxts[fontType] then
			logError(string.format("配置异常，目前还未设置相关fontType：%s的字体设定,请检查配置！", fontType))

			return
		end

		local useTmp = self._picCo.inType == StoryEnum.PictureInType.SoftLight or self._picCo.inType == StoryEnum.PictureInType.GostMagic

		gohelper.setActive(self._gotmptxt, useTmp)
		gohelper.setActive(self._gosptxt, not useTmp)

		if useTmp then
			self._useTxts = self._tmpTxts or self._spTxts
		end

		for i = 1, 3 do
			gohelper.setActive(self._useTxts[i].gameObject, fontType == i)
		end

		local txt = picTxtCo[curLang]
		local time = 0.1 * LuaUtil.getStrLen(txt) * txtCo[2]
		local playDoText = not useTmp and self._picCo.inType ~= StoryEnum.PictureInType.TxtFadeIn and fontType ~= 0

		if playDoText then
			self._dtTweenId = ZProj.TweenHelper.DOText(self._useTxts[fontType], txt, time, nil, nil, nil, EaseType.Linear)
		end

		if self._picCo.inType == StoryEnum.PictureInType.SoftLight or self._picCo.inType == StoryEnum.PictureInType.GostMagic then
			self:_playTextEffect(true, self._useTxts[fontType], self._picCo.inType)
		end

		if self._picCo.inType == StoryEnum.PictureInType.FadeIn or self._picCo.inType == StoryEnum.PictureInType.TxtFadeIn then
			if fontType == 0 then
				fontType = picTxtCo.fontType + 1

				local filterResult = StoryTool.filterMarkTop(txt)

				gohelper.setActive(self._useTxts[fontType].gameObject, true)

				self._useTxts[fontType].text = filterResult
			else
				self._useTxts[fontType].text = txt
			end

			ZProj.TweenHelper.DOFadeCanvasGroup(self._picGoRoot, 0, 1, self._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		else
			self._picGoRoot:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1
		end

		if self._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if self._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			transformhelper.setLocalPosXY(self._gotmptxt.transform, self._picCo.pos[1], self._picCo.pos[2])
			transformhelper.setLocalPosXY(self._gosptxt.transform, self._picCo.pos[1], self._picCo.pos[2])

			if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				self:_playShake()
			else
				TaskDispatcher.runDelay(self._playShake, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif self._picCo.effType == StoryEnum.PictureEffectType.Scale then
			transformhelper.setLocalPosXY(self._gotmptxt.transform, self._picCo.pos[1], self._picCo.pos[2])
			transformhelper.setLocalPosXY(self._gosptxt.transform, self._picCo.pos[1], self._picCo.pos[2])

			if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				self:_playScale()
			else
				TaskDispatcher.runDelay(self._playScale, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif self._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			self:_playFollowBg()
		end

		return
	end

	if self._picCo.picType == StoryEnum.PictureType.HeroFollow then
		gohelper.setActive(self._simg.gameObject, false)
		gohelper.setActive(self._gotmptxt, false)
		gohelper.setActive(self._gosptxt, false)
		self:_onPicImageLoaded()

		return
	end

	gohelper.setActive(self._simg.gameObject, true)
	gohelper.setActive(self._gotmptxt, false)
	gohelper.setActive(self._gosptxt, false)
	self._simg:LoadImage(ResUrl.getStoryItem(self._picCo.picture), self._onPicImageLoaded, self)
end

function StoryPictureItem:_onPicImageLoaded()
	if self._picCo.picType ~= StoryEnum.PictureType.HeroFollow then
		self._picAni.enabled = false

		ZProj.UGUIHelper.SetImageSize(self._simg.gameObject)

		self._picImg = self._simg.gameObject:GetComponent(gohelper.Type_Image)

		local w, h = ZProj.UGUIHelper.GetImageSpriteSize(self._picImg, 0, 0)

		if w >= 1920 or h > 1080 then
			gohelper.onceAddComponent(self._simg.gameObject, typeof(ZProj.UIBgFitHeightAdapter))
		end

		local color = SLFramework.UGUI.GuiHelper.ParseColor(self._picCo.picColor)
		local alpha = 1

		if self._picCo.picType ~= StoryEnum.PictureType.Transparency then
			self._picImg.color.a = alpha
		else
			self._picImg.color = color
			alpha = color.a
		end

		if self._picCo.inType == StoryEnum.PictureInType.FadeIn then
			ZProj.TweenHelper.DOFadeCanvasGroup(self._picGoRoot, 0, alpha, self._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
		end
	end

	if self._picCo.effType == StoryEnum.PictureEffectType.Shake then
		if self._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			return
		end

		if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_playShake()
		else
			TaskDispatcher.runDelay(self._playShake, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif self._picCo.effType == StoryEnum.PictureEffectType.Scale then
		if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
			self:_playScale()
		else
			TaskDispatcher.runDelay(self._playScale, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end
	elseif self._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
		self:_playFollowBg()
	end
end

function StoryPictureItem:_playShake()
	self._picAni.enabled = true

	local aniName = {
		"low",
		"middle",
		"high"
	}

	self._picAni:Play(aniName[self._picCo.effDegree])

	self._picAni.speed = self._picCo.effRate

	TaskDispatcher.runDelay(self._shakeStop, self, self._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryPictureItem:_shakeStop()
	self._picAni.speed = self._picCo.effRate

	self._picAni:SetBool("stoploop", true)
end

function StoryPictureItem:_playFollowBg()
	local bgRootGo = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	self._bgGo = gohelper.findChild(bgRootGo, "#go_upbg")

	local picTransX, picTransY = transformhelper.getLocalPos(self._picGoRoot.transform)

	self._deltaPos = {
		picTransX,
		picTransY
	}

	TaskDispatcher.runRepeat(self._followBg, self, 0.02)
end

function StoryPictureItem:_followBg()
	local scaleX, scaleY = transformhelper.getLocalScale(self._bgGo.transform)

	transformhelper.setLocalPosXY(self._picGoRoot.transform, scaleX * self._deltaPos[1], scaleY * self._deltaPos[2])
	transformhelper.setLocalScale(self._picGoRoot.transform, scaleY, scaleY, 1)
end

function StoryPictureItem:_playScale()
	if not self._picCo then
		return
	end

	local transTime = self._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local color = SLFramework.UGUI.GuiHelper.ParseColor(self._picCo.picColor)

	if transTime < 0.1 then
		transformhelper.setLocalScale(self._picGoRoot.transform, self._picCo.effRate, self._picCo.effRate, 1)
		transformhelper.setLocalPosXY(self._picGoRoot.transform, self._picCo.pos[1], self._picCo.pos[2])

		if self._picCo.picType ~= StoryEnum.PictureType.Transparency then
			return
		end

		if not self._picImg then
			return
		end

		self._picImg.color = color

		return
	end

	self._posTweenId = ZProj.TweenHelper.DOAnchorPos(self._picGoRoot.transform, self._picCo.pos[1], self._picCo.pos[2], transTime, nil, nil, nil, self._picCo.effDegree)
	self._scaleTweenId = ZProj.TweenHelper.DOScale(self._picGoRoot.transform, self._picCo.effRate, self._picCo.effRate, 1, transTime)

	if self._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	if not self._picImg then
		return
	end

	self._alphaTweenId = ZProj.TweenHelper.DoFade(self._picImg, self._picImg.color.a, color.a, transTime, nil, nil, nil, EaseType.Linear)
end

function StoryPictureItem:resetStep()
	TaskDispatcher.cancelTask(self._playShake, self)
	ZProj.TweenHelper.KillByObj(self._picGoRoot)
end

function StoryPictureItem:_killTweenId()
	if self._dtTweenId then
		ZProj.TweenHelper.KillById(self._dtTweenId)

		self._dtTweenId = nil
	end

	if self._posTweenId then
		ZProj.TweenHelper.KillById(self._posTweenId)

		self._posTweenId = nil
	end

	if self._scaleTweenId then
		ZProj.TweenHelper.KillById(self._scaleTweenId)

		self._scaleTweenId = nil
	end

	if self._alphaTweenId then
		ZProj.TweenHelper.KillById(self._alphaTweenId)

		self._alphaTweenId = nil
	end

	ZProj.TweenHelper.KillByObj(self._picGoRoot)
end

function StoryPictureItem:reset(go, picCo)
	if not self._picGo then
		return
	end

	self.viewGO = go
	self._picCo = picCo

	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._followBg, self)
	TaskDispatcher.cancelTask(self._playScale, self)
	TaskDispatcher.cancelTask(self._playShake, self)
	self:_killTweenId()

	if self:_isSpImg() then
		return
	end

	if self._picCo.picType == StoryEnum.PictureType.FullScreen then
		self:_setFullPicture()
	else
		self._picAni.enabled = false

		self:_setNormalPicture()

		if self._picCo.effType == StoryEnum.PictureEffectType.Shake then
			if self._picCo.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				return
			end

			if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				self:_playShake()
			else
				TaskDispatcher.runDelay(self._playShake, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif self._picCo.effType == StoryEnum.PictureEffectType.Scale then
			if self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
				self:_playScale()
			else
				TaskDispatcher.runDelay(self._playScale, self, self._picCo.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
			end
		elseif self._picCo.effType == StoryEnum.PictureEffectType.FollowBg then
			self:_playFollowBg()
		end
	end
end

function StoryPictureItem:isFloatType()
	return self._picCo.picType == StoryEnum.PictureType.Float
end

function StoryPictureItem:_setNormalPicture()
	if self._picCo.picType == StoryEnum.PictureType.PicTxt or self._picCo.picType == StoryEnum.PictureType.HeroFollow then
		return
	end

	self._simg:UnLoadImage()
	self._simg:LoadImage(ResUrl.getStoryItem(self._picCo.picture), self._onPicImageLoaded, self)

	if self._picCo.picType ~= StoryEnum.PictureType.Transparency then
		return
	end

	if not self._picImg then
		return
	end

	local color = SLFramework.UGUI.GuiHelper.ParseColor(self._picCo.picColor)

	self._picImg.color = Color.New(color.r, color.g, color.b, self._picImg.color.a)
end

function StoryPictureItem:_setFullPicture()
	if not self._picParentGo then
		return
	end

	self._picParentGo.transform:SetParent(self.viewGO.transform)

	self._picImg = self._picGo:GetComponent(gohelper.Type_Image)

	local color = SLFramework.UGUI.GuiHelper.ParseColor(self._picCo.picColor)

	self._picImg.color = color

	ZProj.TweenHelper.DOFadeCanvasGroup(self._picGoRoot, 0, color.a, self._picCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], nil, nil, nil, EaseType.Linear)
end

function StoryPictureItem:_onFullFocusPictureLoaded()
	if not self._pictureLoader then
		return
	end

	self._picLoaded = true
	self._picGo = self._pictureLoader:getInstGO()
	self._picGo.name = self._picName
	self._picGoRoot = self._picGo

	self:_setFullPicture()

	if self._setDestroy then
		TaskDispatcher.runDelay(self._realDestroy, self, 0.1)
	end
end

function StoryPictureItem:_playTextEffect(isVisible, textComp, effectType)
	if isVisible then
		self._textLightComp = self._textLightComp or MonoHelper.addNoUpdateLuaComOnceToGo(self._picParentGo, StoryTextLightComp)

		self._textLightComp:playTextEffect(textComp, effectType)
	elseif self._textLightComp then
		self._textLightComp:hideTextEffect()
	end
end

function StoryPictureItem:destroyPicture(picCo, isSkip, keepTime)
	self._picDestroyCo = picCo
	self._destroyKeepTime = keepTime or 0

	if not self._picDestroyCo then
		return
	end

	if not self._picCo or isSkip then
		self:onDestroy()

		return
	end

	TaskDispatcher.cancelTask(self._build, self)
	TaskDispatcher.cancelTask(self._playShake, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._startDestroy, self)
	TaskDispatcher.cancelTask(self._checkDestroyItem, self)

	if self._picDestroyCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runDelay(self._startDestroy, self, 0.1 + self._destroyKeepTime)
	elseif self._picDestroyCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(self._startDestroy, self, self._picDestroyCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		self:_startDestroy()
	end
end

function StoryPictureItem:_startDestroy()
	self._setDestroy = true

	if self._picDestroyCo.outType == StoryEnum.PictureOutType.Hard then
		self:onDestroy()
	else
		if not self._picGoRoot or not self._picLoaded then
			self:_releaseLoader()

			return
		end

		ZProj.TweenHelper.KillByObj(self._picImg)

		if self._picDestroyCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
			local startAlpha = self._picGoRoot:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha

			ZProj.TweenHelper.DOFadeCanvasGroup(self._picGoRoot, startAlpha, 0, self._picDestroyCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] - 0.1, self.onDestroy, self, nil, EaseType.Linear)
		else
			self:onDestroy()
		end
	end
end

function StoryPictureItem:onDestroy()
	UIBlockMgr.instance:endBlock("waitHero")
	StoryController.instance:unregisterCallback(StoryEvent.OnHeroShowed, self._checkFollowHero, self)
	TaskDispatcher.cancelTask(self._build, self)
	TaskDispatcher.cancelTask(self._checkDestroyItem, self)

	if self._picDestroyCo and self._picDestroyCo.picType == StoryEnum.PictureType.FullScreen then
		TaskDispatcher.runRepeat(self._checkDestroyItem, self, 0.1)
	else
		self:_realDestroy()
	end
end

function StoryPictureItem:_checkDestroyItem()
	if not self._picLoaded then
		return
	end

	TaskDispatcher.cancelTask(self._checkDestroyItem, self)
	self:_realDestroy()
end

function StoryPictureItem:_releaseLoader()
	if self._pictureLoader then
		if self._pictureLoader:getAssetItem() then
			self._pictureLoader:getAssetItem():Release()
		end

		self._pictureLoader:dispose()

		self._pictureLoader = nil
	end
end

function StoryPictureItem:_realDestroy()
	if gohelper.isNil(self.viewGO) then
		TaskDispatcher.cancelTask(self._checkDestroyItem, self)

		return
	end

	if self._picRootCanvas then
		self._picRootCanvas.sortingOrder = 1008
		self._picRootCanvas.overrideSorting = true
		self._picRootCanvas.sortingLayerName = "Default"
	end

	self:_killTweenId()

	if not self._picLoaded then
		return
	end

	self:_releaseLoader()
	TaskDispatcher.cancelTask(self._playShake, self)
	TaskDispatcher.cancelTask(self._followBg, self)
	TaskDispatcher.cancelTask(self._realDestroy, self)
	TaskDispatcher.cancelTask(self._checkDestroyItem, self)
	TaskDispatcher.cancelTask(self._startDestroy, self)
	TaskDispatcher.cancelTask(self._build, self)
	ZProj.TweenHelper.KillByObj(self._picGoRoot)
	TaskDispatcher.cancelTask(self._shakeStop, self)

	if self._simg then
		self._simg:UnLoadImage()

		self._simg = nil
	end

	gohelper.destroy(self._picParentGo)

	if self._picCo.picType == StoryEnum.PictureType.HeroFollow and self._picGoRoot then
		StoryController.instance:dispatchEvent(StoryEvent.OnFollowPictureEnd, self._picGoRoot, tonumber(self._picCo.picture))
	end
end

return StoryPictureItem
