-- chunkname: @modules/logic/story/view/StoryEffectItem.lua

module("modules.logic.story.view.StoryEffectItem", package.seeall)

local StoryEffectItem = class("StoryEffectItem")
local stencilPropName = "_Stencil"
local stencilCompPropName = "_StencilComp"
local stencilOpPropName = "_StencilOp"

function StoryEffectItem:init(go, path, effCo, order, callback, callbackObj)
	self.viewGO = go
	self._effectPath = path
	self._effectGo = nil
	self._uieffectGo = nil
	self._effectCo = effCo
	self._fadeHelper = nil
	self._effOrder = order

	if effCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(self._buildNormalEffect, self, effCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		self:_buildNormalEffect()
	end
end

function StoryEffectItem:reset(go, effCo, order)
	TaskDispatcher.cancelTask(self._buildNormalEffect, self)
	TaskDispatcher.cancelTask(self._followBg, self)

	if not self._effectGo then
		return
	end

	self.viewGO = go
	self._effectCo = effCo
	self._effOrder = order

	self._effectGo.transform:SetParent(self._uieffectTransform, false)
	self._effectOrderContainer:SetBaseOrder(self._effOrder)

	if self._effectCo.layer == 11 or self._effectCo.layer == 13 then
		self:_setParticleStencil(10, 3, 0)
	elseif self._effectCo.layer == 12 or self._effectCo.layer == 14 then
		self:_setParticleStencil(30, 3, 0)
	elseif self._setStencil and self._effectCo.layer ~= 11 and self._effectCo.layer ~= 12 and self._effectCo.layer ~= 13 and self._effectCo.layer ~= 14 then
		self:_resetParticleStencil()
	end
end

function StoryEffectItem:_buildNormalEffect()
	self._uieffectGo = gohelper.create2d(self.viewGO, "effect")
	self._uieffectTransform = self._uieffectGo.transform
	self._canvas = gohelper.onceAddComponent(self._uieffectGo, typeof(UnityEngine.CanvasGroup))

	local width, height = UnityEngine.Screen.width, UnityEngine.Screen.height

	if width / height > 1.7777777777777777 then
		if not (1080 * width / (1920 * height)) then
			local scalex = 1
			local scaley = width / height < 2 and 1 or 1080 * width / (1920 * height * scalex)
			local isMatch = self._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale or self._effectCo.orderType == StoryEnum.EffectOrderType.SingleUnscale or self._effectCo.orderType == StoryEnum.EffectOrderType.NoSettingUnScale

			if isMatch then
				scalex = 1
				scaley = 1
			end

			transformhelper.setLocalPosXY(self._uieffectTransform, self._effectCo.pos[1], self._effectCo.pos[2])
			transformhelper.setLocalScale(self._uieffectTransform, scalex, scaley, 1)

			self._effectLoader = PrefabInstantiate.Create(self._uieffectGo)

			self._effectLoader:startLoad(self._effectPath, self._onNormalEffectLoaded, self)
		end
	end
end

function StoryEffectItem:_onNormalEffectLoaded()
	self._effectGo = self._effectLoader:getInstGO()
	self._effectAnim = self._effectGo:GetComponent(typeof(UnityEngine.Animator))
	self._fadeHelper = StoryEffectFadeHelper.New()

	self._fadeHelper:init(self._effectGo)

	if self._effectCo.layer < 4 then
		local layer = self.viewGO.layer

		gohelper.setLayer(self._effectGo, layer, true)
	elseif self._effectCo.layer < 10 then
		gohelper.setLayer(self._effectGo, UnityLayer.UISecond, true)
	elseif self._effectCo.layer == 12 or self._effectCo.layer == 11 then
		gohelper.setLayer(self._effectGo, UnityLayer.UI, true)
	elseif self._effectCo.layer == 14 or self._effectCo.layer == 13 then
		gohelper.setLayer(self._effectGo, UnityLayer.UISecond, true)
	else
		gohelper.setLayer(self._effectGo, UnityLayer.UITop, true)
	end

	local inTime = self._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	local needSet = inTime > 0.1 and self._effectCo.orderType ~= StoryEnum.EffectOrderType.NoSettingUnScale and self._effectCo.orderType ~= StoryEnum.EffectOrderType.NoSetting and self._effectCo.orderType ~= StoryEnum.EffectOrderType.NoSettingFollowBg

	if needSet then
		local loop = self._effectCo.orderType == StoryEnum.EffectOrderType.Continuity or self._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale

		self._fadeHelper:setEffectLoop(loop)
		self:_doEffectFade(0, 1, inTime)
	end

	if self._effectCo.orderType == StoryEnum.EffectOrderType.FollowBg or self._effectCo.orderType == StoryEnum.EffectOrderType.NoSettingFollowBg then
		self:_playFollowBg()
	end

	if self._effectCo.orderType == StoryEnum.EffectOrderType.FollowDialog then
		self:_playFollowDialog()
	end

	if self._effectCo.layer == 11 or self._effectCo.layer == 13 then
		self:_setParticleStencil(10, 3, 0)
	elseif self._effectCo.layer == 12 or self._effectCo.layer == 14 then
		self:_setParticleStencil(30, 3, 0)
	elseif self._setStencil and self._effectCo.layer ~= 11 and self._effectCo.layer ~= 12 and self._effectCo.layer ~= 13 and self._effectCo.layer ~= 14 then
		self:_resetParticleStencil()
	end

	self._effectOrderContainer = gohelper.onceAddComponent(self._effectGo, typeof(ZProj.EffectOrderContainer))

	self._effectOrderContainer:SetBaseOrder(self._effOrder)
end

function StoryEffectItem:_setParticleStencil(stencilValue, stencilComp, stencilOp)
	if not self._effectGo or not self._effectGo.transform then
		return
	end

	self._setStencil = true

	local particles = self._effectGo.transform:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem))

	for i = 0, particles.Length - 1 do
		local renderer = particles[i].gameObject:GetComponent(typeof(UnityEngine.Renderer))

		if renderer then
			local materials = renderer.materials

			for j = 0, materials.Length - 1 do
				local material = materials[j]

				if not gohelper.isNil(material) then
					if material:HasProperty(stencilPropName) then
						material:SetFloat(stencilPropName, stencilValue)
					end

					if material:HasProperty(stencilCompPropName) then
						material:SetFloat(stencilCompPropName, stencilComp)
					end

					if material:HasProperty(stencilOpPropName) then
						material:SetFloat(stencilOpPropName, stencilOp)
					end
				end
			end
		end
	end
end

function StoryEffectItem:_resetParticleStencil()
	self._setStencil = false

	local stepId = StoryModel.instance:getCurStepId()
	local stepCo = StoryStepModel.instance:getStepListById(stepId)
	local bgCo = stepCo.bg

	if bgCo.transType == StoryEnum.BgTransType.ScreenSplitExit then
		TaskDispatcher.runDelay(self._doResetParticleStencil, self, 1)
	else
		self:_doResetParticleStencil()
	end
end

function StoryEffectItem:_doResetParticleStencil()
	self:_setParticleStencil(0, 8, 0)
end

function StoryEffectItem:_addLateUpdateHandle(callback, callbackObj)
	self._lateUpdateGroup = self._lateUpdateGroup or LateUpdateHandleGroup.New()

	self._lateUpdateGroup:add(callback, callbackObj)
end

function StoryEffectItem:_removeLateUpdateHandle(callback, callbackObj)
	if self._lateUpdateGroup then
		self._lateUpdateGroup:remove(callback, callbackObj)
	end
end

function StoryEffectItem:_playFollowBg()
	self._bgFrontGo = StoryViewMgr.instance:getStoryFrontBgImgGo()

	local frontTransX, frontTransY = transformhelper.getLocalPos(self._bgFrontGo.transform)

	self._initFrontPos = {
		frontTransX,
		frontTransY
	}

	local picTransX, picTransY = transformhelper.getLocalPos(self._uieffectTransform)

	self._deltaPos = {
		picTransX,
		picTransY
	}

	TaskDispatcher.runRepeat(self._followBg, self, 0.02)
end

function StoryEffectItem:_followBg()
	local bgGo = StoryViewMgr.instance:getStoryFrontBgGo()
	local scaleX, scaleY = transformhelper.getLocalScale(bgGo.transform)
	local frontTransX, frontTransY = transformhelper.getLocalPos(self._bgFrontGo.transform)
	local posX = scaleX * (self._deltaPos[1] + frontTransX - self._initFrontPos[1])
	local posY = scaleY * (self._deltaPos[2] + frontTransY - self._initFrontPos[2])

	transformhelper.setLocalPosXY(self._uieffectTransform, posX, posY)
	transformhelper.setLocalScale(self._uieffectTransform, scaleY, scaleY, 1)
end

function StoryEffectItem:_playFollowDialog()
	self._followDialogEff = self._followDialogEff or StoryEffectFollowDialog.New(self)

	self._followDialogEff:start()
end

function StoryEffectItem:setEffectVisible(isVisible, needFade)
	if self._visible == isVisible then
		return
	end

	self._visible = isVisible

	if needFade and self:fadeByAnimator(isVisible) then
		return
	end

	gohelper.setActive(self._uieffectGo, isVisible)
end

function StoryEffectItem:_doEffectFade(from, to, duration, destroy)
	TaskDispatcher.cancelTask(self._effFinished, self)

	local isFadeIn = to == 1

	if self:fadeByAnimator(isFadeIn) then
		self._needDestroy = destroy

		TaskDispatcher.runDelay(self._effFinished, self, duration)

		return
	end

	if duration < 0.1 then
		self:_effUpdate(to)

		if destroy then
			self:onDestroy()
		end
	else
		self._needDestroy = destroy

		if self._effTweenId then
			ZProj.TweenHelper.KillById(self._effTweenId)

			self._effTweenId = nil
		end

		self._effTweenId = ZProj.TweenHelper.DOTweenFloat(from, to, duration, self._effUpdate, self._effFinished, self, nil, EaseType.Linear)
	end
end

function StoryEffectItem:fadeByAnimator(fadeIn)
	if not self._effectAnim then
		return
	end

	if fadeIn then
		gohelper.setActive(self._uieffectGo, false)
		gohelper.setActive(self._uieffectGo, true)
	else
		gohelper.setActive(self._uieffectGo, true)
		self._effectAnim:Play("close", 0, 0)
	end

	return true
end

function StoryEffectItem:_effUpdate(value)
	local viewOpen = ViewMgr.instance:isOpen(ViewName.StoryHeroView)

	if not viewOpen or not self._fadeHelper then
		if self._effTweenId then
			ZProj.TweenHelper.KillById(self._effTweenId)

			self._effTweenId = nil
		end

		return
	end

	if self._canvas then
		self._canvas.alpha = value

		if self._fadeHelper then
			self._fadeHelper:setTransparency(value)
		end
	elseif self._effTweenId then
		ZProj.TweenHelper.KillById(self._effTweenId)

		self._effTweenId = nil
	end
end

function StoryEffectItem:_effFinished()
	if not self._needDestroy then
		return
	end

	self:onDestroy()
end

function StoryEffectItem:destroyEffect(effCo, param)
	if effCo then
		self._effectCo = effCo
	end

	self._destroyParam = param

	TaskDispatcher.cancelTask(self._buildNormalEffect, self)

	if self._effectCo.outType == StoryEnum.EffectOutType.Hard then
		self:onDestroy()
	else
		self:_doEffectFade(1, 0, self._effectCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], true)
	end
end

function StoryEffectItem:onDestroy()
	if self._lateUpdateGroup then
		self._lateUpdateGroup:destroy()

		self._lateUpdateGroup = nil
	end

	if self._followDialogEff then
		self._followDialogEff:destroy()

		self._followDialogEff = nil
	end

	TaskDispatcher.cancelTask(self._effFinished, self)

	if self._destroyParam then
		self._destroyParam.callback(self._destroyParam.callbackObj, self._effectPath)
	end

	TaskDispatcher.cancelTask(self._buildNormalEffect, self)
	TaskDispatcher.cancelTask(self._followBg, self)

	if self._fadeHelper then
		self._fadeHelper:destroy()

		self._fadeHelper = nil
	end

	self._canvas = nil

	if self._effTweenId then
		ZProj.TweenHelper.KillById(self._effTweenId)

		self._effTweenId = nil
	end

	if self._effectLoader then
		self._effectLoader:dispose()

		self._effectLoader = nil
	end

	if self._effectGo then
		gohelper.destroy(self._effectGo)

		self._effectGo = nil
	end

	if self._uieffectGo then
		gohelper.destroy(self._uieffectGo)

		self._uieffectGo = nil
	end
end

return StoryEffectItem
