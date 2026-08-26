-- chunkname: @modules/logic/story/view/StoryLeadRoleSpineView.lua

module("modules.logic.story.view.StoryLeadRoleSpineView", package.seeall)

local StoryLeadRoleSpineView = class("StoryLeadRoleSpineView", BaseView)

function StoryLeadRoleSpineView:onInitView()
	self._gospineroot = gohelper.findChild(self.viewGO, "#go_spineroot")
	self._gospine = gohelper.findChild(self.viewGO, "#go_spineroot/mask/#go_spine")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryLeadRoleSpineView:addEvents()
	return
end

function StoryLeadRoleSpineView:removeEvents()
	return
end

function StoryLeadRoleSpineView:_editableInitView()
	self._heroSpines = {}

	local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

	for i = 1, #leadHeroSpineCos do
		if leadHeroSpineCos[i].resType == StoryEnum.IconResType.Spine then
			if not self._heroSpines[i] then
				local goSpine = gohelper.create2d(self._gospine, "spine" .. i)

				self._heroSpines[i] = GuiSpine.Create(goSpine, true)
			end

			local path = "rolesstory/" .. leadHeroSpineCos[i].path

			self._heroSpines[i]:setResPath(path, self["_onHeroSpineLoaded" .. i], self)
		end
	end

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gospineroot, false)
end

function StoryLeadRoleSpineView:onOpen()
	self:_addSelfEvents()
end

function StoryLeadRoleSpineView:_addSelfEvents()
	StoryController.instance:registerCallback(StoryEvent.ShowLeadRole, self._showLeadHero, self)
	StoryController.instance:registerCallback(StoryEvent.LeadRoleViewShow, self._showView, self)
	StoryController.instance:registerCallback(StoryEvent.ConversationShake, self._actShake, self)
end

function StoryLeadRoleSpineView:_removeSelfEvents()
	StoryController.instance:unregisterCallback(StoryEvent.ShowLeadRole, self._showLeadHero, self)
	StoryController.instance:unregisterCallback(StoryEvent.LeadRoleViewShow, self._showView, self)
	StoryController.instance:unregisterCallback(StoryEvent.ConversationShake, self._actShake, self)
end

function StoryLeadRoleSpineView:_showView(show, heroIcon)
	gohelper.setActive(self.viewGO, show)

	if heroIcon then
		gohelper.setActive(self._gospineroot, true)

		local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

		for roleType, spineCo in pairs(leadHeroSpineCos) do
			if heroIcon == spineCo.icon then
				self:_showLeadHeroByRoleType(roleType)

				return
			end
		end
	end
end

function StoryLeadRoleSpineView:_hideAll()
	for _, heroSpine in pairs(self._heroSpines) do
		local gospine = heroSpine:getSpineGo()

		gohelper.setActive(gospine, false)
	end
end

function StoryLeadRoleSpineView:_showLeadHeroByRoleType(roleType)
	self:_hideAll()

	if self._heroSpines[roleType] then
		local goSpine = self._heroSpines[roleType]:getSpineGo()

		gohelper.setActive(goSpine, true)
	else
		local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

		for type, spineCo in pairs(leadHeroSpineCos) do
			if type == roleType and spineCo.resType == StoryEnum.IconResType.Spine then
				local goSpine = gohelper.create2d(self._gospine, "spine" .. roleType)

				gohelper.setActive(goSpine, true)

				self._heroSpines[roleType] = GuiSpine.Create(goSpine, true)

				local path = "rolesstory/" .. spineCo.path

				self._heroSpines[roleType]:setResPath(path)
			end
		end
	end
end

function StoryLeadRoleSpineView:_keepSpineAni(roleType)
	local isKeepShow = self:_isSpineKeepShow(roleType)

	if not isKeepShow then
		return false
	end

	if self._mainheroco and (self._mainheroco.motion ~= "" or self._mainheroco.face ~= "" or self._mainheroco.mouth ~= "") and self._mainheroco.motion == self._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and self._mainheroco.face == self._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and self._mainheroco.mouth == self._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] then
		return true
	end

	return false
end

function StoryLeadRoleSpineView:_isSpineKeepShow(roleType)
	if not self._gospineroot.activeSelf then
		return false
	end

	if not self._heroSpines[roleType] then
		return false
	end

	local gospine = self._heroSpines[roleType]:getSpineGo()

	if not gospine or not gospine.activeSelf then
		return false
	end

	return true
end

function StoryLeadRoleSpineView:_showLeadHero(co, show, fadeIn, fadeOut)
	if self._stepCo then
		local isSameStep = self._stepCo.id == co.id

		self._stepCo = co

		local heroIcon = string.split(self._stepCo.conversation.heroIcon, ".")[1]

		self._roleType = self._roleType or 1

		if self._stepCo.conversation.iconShow then
			local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

			for index, v in ipairs(leadHeroSpineCos) do
				if heroIcon == v.icon then
					self._roleType = index
				end
			end
		end

		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		if not isSameStep and self:_keepSpineAni(self._roleType) then
			return
		end

		if not show then
			self._mainheroco = nil

			self._animator:Play(UIAnimationName.Idle)

			self._animator.enabled = false

			gohelper.setActive(self._gospineroot, false)

			for _, heroSpine in pairs(self._heroSpines) do
				local gospine = heroSpine:getSpineGo()

				gohelper.setActive(gospine, false)
			end

			return
		end

		gohelper.setActive(self._gospineroot, true)
		self:_playHeroLeadSpineVoice(self._roleType)

		fadeIn = fadeIn and not self:_isSpineKeepShow(self._roleType)
		fadeOut = fadeOut and not self:_isSpineKeepShow(self._roleType)

		if not fadeIn and not fadeOut then
			self:_fadeUpdate(1)
		end

		if fadeIn then
			self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, self._fadeUpdate, self._fadeInFinished, self, nil, EaseType.Linear)
		end

		if fadeOut then
			self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.35, self._fadeUpdate, self._fadeOutFinished, self, nil, EaseType.Linear)
		end
	end
end

function StoryLeadRoleSpineView:_playHeroLeadSpineVoice(roleType)
	self:_showLeadHeroByRoleType(roleType)

	if self._stepCo.conversation.heroIcon == "" or not self._stepCo.conversation.iconShow then
		return
	end

	local hasOptionPlayed = StoryModel.instance:hasBranchPlayed(self._stepCo)

	self._mainheroco = {}
	self._mainheroco.motion = self._stepCo.mainRole.anims[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	self._mainheroco.face = self._stepCo.mainRole.expressions[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	self._mainheroco.mouth = hasOptionPlayed and "" or self._stepCo.mainRole.mouses[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	for index, heroSpine in pairs(self._heroSpines) do
		if index == roleType then
			heroSpine:playVoice(self._mainheroco)
		else
			heroSpine:stopVoice()
		end
	end
end

function StoryLeadRoleSpineView:_fadeUpdate(value)
	for _, heroSpine in pairs(self._heroSpines) do
		local gospine = heroSpine:getSpineGo()

		if gospine then
			local x, y, _ = transformhelper.getLocalPos(gospine.transform)

			transformhelper.setLocalPos(gospine.transform, x, y, 1 - value)
		end
	end

	self:_setHeroFadeMat()
end

function StoryLeadRoleSpineView:_fadeInFinished()
	return
end

function StoryLeadRoleSpineView:_fadeOutFinished()
	self:_fadeUpdate(0)
end

function StoryLeadRoleSpineView:_actShake(co, shake, level, immediate)
	self._stepCo = co

	if self._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		shake = false
	end

	if not shake then
		self._animator.speed = self._stepCo.conversation.effRate

		if immediate then
			self._animator:Play(UIAnimationName.Idle)

			self._animator.enabled = false
		else
			self._animator:SetBool("stoploop", true)
		end

		return
	end

	self._animator.enabled = true

	self._animator:SetBool("stoploop", false)

	local aniName = {
		"low",
		"middle",
		"high"
	}

	self._animator:Play(aniName[level])

	self._animator.speed = self._stepCo.conversation.effRate
end

function StoryLeadRoleSpineView:_setHeroFadeMat()
	local blitEff = StoryViewMgr.instance:getStoryBlitEff()

	if not blitEff then
		return
	end

	local texture = blitEff.capturedTexture

	if not texture then
		return
	end

	local bgGo = StoryViewMgr.instance:getStoryFrontBgImgGo()

	if not bgGo then
		return
	end

	local posx, posy = transformhelper.getLocalPos(bgGo.transform)
	local scalex, scaley = transformhelper.getLocalScale(bgGo.transform)
	local vec4 = Vector4.New(scalex, scaley, posx, posy)

	for _, heroSpine in pairs(self._heroSpines) do
		local sg = heroSpine:getSkeletonGraphic()

		if sg then
			sg.materialForRendering:SetTexture("_SceneMask", texture)
			sg.materialForRendering:SetVector("_SceneMask_ST", vec4)
		end
	end
end

function StoryLeadRoleSpineView:onClose()
	self:_removeSelfEvents()
end

function StoryLeadRoleSpineView:onDestroyView()
	return
end

return StoryLeadRoleSpineView
