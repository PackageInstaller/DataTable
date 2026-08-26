-- chunkname: @modules/live2d/BaseLive2d.lua

module("modules.live2d.BaseLive2d", package.seeall)

local BaseLive2d = class("BaseLive2d", LuaCompBase)

BaseLive2d.BodyTrackIndex = 0
BaseLive2d.FaceTrackIndex = 1
BaseLive2d.MouthTrackIndex = 2
BaseLive2d.TransitionTrackIndex = 3
BaseLive2d.enableMainInterfaceLight = false

function BaseLive2d:init(gameObj)
	self._gameObj = gameObj
	self._gameTr = gameObj.transform
	self._resLoader = SpinePrefabInstantiate.Create(self._gameObj)
	self._resPath = nil
	self._cubismController = nil
	self._spineGo = nil
	self._spineTr = nil
	self._isLoop = false
	self._lookDir = SpineLookDir.Left
	self._bFreeze = false
	self._actionCb = nil
	self._actionCbObj = nil
	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
end

function BaseLive2d:setResPath(resPath, loadedCb, loadedCbObj)
	if not resPath then
		return
	end

	if self._resPath == resPath and not gohelper.isNil(self._spineGo) then
		if loadedCb then
			loadedCb(loadedCbObj)
		end

		return
	end

	self:_clear()

	self._resPath = resPath
	self._resLoadedCb = loadedCb
	self._resLoadedCbObj = loadedCbObj

	self._resLoader:startLoad(self._resPath, self._resPath, self._onResLoaded, self)
end

function BaseLive2d:setHeroId(id)
	self._heroId = id
end

function BaseLive2d:setSkinId(id)
	self._skinId = id
end

function BaseLive2d:getResPath()
	return self._resPath
end

function BaseLive2d:doClear()
	self:_clear()
end

function BaseLive2d:_clear()
	if self.customEffectComp then
		MonoHelper.removeLuaComFromGo(self._gameObj, BaseLive2dSpecialEffect)

		self.customEffectComp = nil
	end

	if self._resLoader then
		self._resLoader:dispose()
	end

	if self._roleEffectComp then
		self._roleEffectComp:onDestroy()

		self._roleEffectComp = nil
	end

	if self._roleFaceComp then
		self._roleFaceComp:onDestroy()

		self._roleFaceComp = nil
	end

	self._cubismController = nil
	self._cubismParameterModifider = nil
	self._resPath = nil

	if self._spineGo then
		Live2dMaskController.instance:removeLive2dGo(self._spineGo)

		self._spineGo = nil
	end

	self._spineTr = nil
	self._bFreeze = false
	self._renderer = nil
	self._curBodyName = nil
end

function BaseLive2d:setInMainView()
	self._isInMainView = true
end

function BaseLive2d:isInMainView()
	return self._isInMainView
end

function BaseLive2d:setBodyChangeCallback(callback, callbackObj)
	self._bodyChangeCallback = callback
	self._bodyChangeCallbackObj = callbackObj
end

function BaseLive2d:isPlayingVoice()
	return self._live2dVoice and self._live2dVoice:playing()
end

function BaseLive2d:isPlayingVoiceId(id)
	return self._live2dVoice and self._live2dVoice:isPlayingVoiceId(id)
end

function BaseLive2d:getPlayVoiceStartTime()
	return self._live2dVoice and self._live2dVoice:getPlayVoiceStartTime()
end

function BaseLive2d:_initVoice()
	self._live2dVoice = self._live2dVoice or Live2dVoice.New()
end

function BaseLive2d:playVoice(config, callback, txtContent, txtEnContent, bgGo)
	self:_initVoice()
	self._live2dVoice:playVoice(self, config, callback, txtContent, txtEnContent, bgGo)
end

function BaseLive2d:stopVoice()
	if self._live2dVoice then
		self._live2dVoice:stopVoice()
	end
end

function BaseLive2d:setSwitch(switchGroup, switchState)
	self:_initVoice()
	self._live2dVoice:setSwitch(self, switchGroup, switchState)
end

function BaseLive2d:getSpineVoice()
	self:_initVoice()

	return self._live2dVoice
end

function BaseLive2d:initSkeletonComponent()
	self._cubismController = self._spineGo:GetComponent(typeof(ZProj.CubismController))
	self._cubismMouthController = self._spineGo:AddComponent(typeof(CubismMouthProxy))

	if self._cubismController and BaseLive2d.enableMainInterfaceLight then
		self._cubismController:SetMainColor(Color.white)
	end
end

function BaseLive2d:setAlwaysFade(value)
	if self._cubismController then
		Live2dSpecialLogic.setAlwaysFade(self._cubismController, self._resPath, value)
	end
end

function BaseLive2d:onAnimEventCallback(actName)
	if self._actionCb then
		self._actionCb(self._actionCbObj, actName, SpineAnimEvent.ActionComplete)
	end

	if self._live2dVoice then
		self._live2dVoice:onAnimationEvent(actName, SpineAnimEvent.ActionComplete)
	end
end

function BaseLive2d:getSpineGo()
	return self._spineGo
end

function BaseLive2d:getRenderer()
	if gohelper.isNil(self._spineGo) then
		return nil
	end

	self._renderer = self._renderer or self._spineGo:GetComponentInChildren(typeof(UnityEngine.Renderer))

	return self._renderer
end

function BaseLive2d:getSpineTr()
	return self._spineTr
end

function BaseLive2d:_onResLoaded()
	self._spineGo = self._resLoader:getInstGO()

	Live2dMaskController.instance:addLive2dGo(self._spineGo)

	self._spineTr = self._spineGo.transform
	self._renderer = nil

	self:initSpecialEffect(self._resPath)
	self:_initRoleEffect()
	self:_initFaceEffect()
	self:initSkeletonComponent()
	self:_changeLookDir()

	if self._isStory then
		self._cubismController:SetAnimEventCallback(self.onAnimEventCallback, self)

		self._curBodyName = self._curBodyName or CharacterVoiceController.instance:getIdle(self._heroId)
		self._curFaceName = self._curFaceName or StoryAnimName.E_ZhengChang

		self:playStory(self._curBodyName, self._curFaceName)
	else
		self._curBodyName = self._curBodyName or SpineAnimState.idle1

		self:setBodyAnimation(self._curBodyName, true, 0.5)
	end

	if self._resLoadedCb then
		self._resLoadedCb(self._resLoadedCbObj)
	end

	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
end

function BaseLive2d:_initRoleEffect()
	local roleEffectConfig

	self._roleEffectComp, roleEffectConfig = self:_getRoleEffectComp(self._resPath)

	if self._roleEffectComp then
		self._roleEffectComp:setSpine(self)
		self._roleEffectComp:init(roleEffectConfig)
	end
end

function BaseLive2d:_getRoleEffectComp(resPath)
	for i, v in ipairs(lua_character_motion_effect.configList) do
		if string.find(resPath, v.heroResName) then
			local effectCompName = v.effectCompName
			local cls = _G[effectCompName]

			return cls.New(), v
		end
	end
end

function BaseLive2d:_initFaceEffect()
	local faceEffectConfig

	self._faceEffectComp, faceEffectConfig = self:_getRoleFaceEffectComp(self._resPath)

	if self._faceEffectComp then
		self._faceEffectComp:setSpine(self)
		self._faceEffectComp:init(faceEffectConfig)
	end
end

function BaseLive2d:_getRoleFaceEffectComp(resPath)
	for i, v in ipairs(lua_character_face_effect.configList) do
		if string.find(resPath, v.heroResName) then
			local effectCompName = v.effectCompName
			local cls = _G[effectCompName]

			return cls.New(), v
		end
	end
end

function BaseLive2d:setSkipBodyEffect(skip)
	self._isSkipBodyEffect = skip
end

function BaseLive2d:_showBodyEffect(bodyName)
	if self._isSkipBodyEffect then
		return
	end

	if self._roleEffectComp then
		self._roleEffectComp:showBodyEffect(bodyName, self._onBodyEffectShow, self)
	end
end

function BaseLive2d:forceHideBodyEffect()
	if self._roleEffectComp and self._roleEffectComp.forceHideBodyEffect then
		self._roleEffectComp:forceHideBodyEffect()
	end
end

function BaseLive2d:_onBodyEffectShow(visible)
	return
end

function BaseLive2d:showEverNodes(value)
	if self._roleEffectComp and self._roleEffectComp.showEverNodes then
		self._roleEffectComp:showEverNodes(value)
	end
end

function BaseLive2d:hasEverNodes()
	return self._roleEffectComp and self._roleEffectComp.isShowEverEffect and self._roleEffectComp:isShowEverEffect()
end

function BaseLive2d:_showFaceEffect(faceName)
	if self._faceEffectComp then
		self._faceEffectComp:showFaceEffect(faceName)
	end
end

function BaseLive2d:play(bodyName, loop)
	self._curBodyName = bodyName

	self:setBodyAnimation(bodyName, loop, 0.5)
end

function BaseLive2d:playStory(bodyName, faceName)
	self._curBodyName = bodyName
	self._curFaceName = faceName

	if bodyName ~= StoryAnimName.B_IDLE or self:hasAnimation(bodyName) then
		self:setBodyAnimation(bodyName, true, 0.5)
	end

	if faceName ~= StoryAnimName.E_ZhengChang or self:hasAnimation(faceName) then
		self:setFaceAnimation(faceName, true, 0.5)
	end
end

function BaseLive2d:setBodyAnimation(bodyName, loop, mixTime)
	local oldBodyName = self._curBodyName

	self._curBodyName = bodyName

	self:_setBodyAnimation(BaseLive2d.BodyTrackIndex, bodyName, loop, mixTime)
	self:_showBodyEffect(bodyName)

	if self._bodyChangeCallback then
		self._bodyChangeCallback(self._bodyChangeCallbackObj, oldBodyName, bodyName)
	end

	if self.customEffectComp then
		self.customEffectComp:onBodyChange(oldBodyName, bodyName)
	end
end

function BaseLive2d:getCurBody()
	return self._curBodyName
end

function BaseLive2d:setFaceAnimation(faceName, loop, mixTime)
	self._curFaceName = faceName

	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:PlayExpression(faceName)
	self:_showFaceEffect(faceName)
end

function BaseLive2d:getCurFace()
	return self._curFaceName
end

function BaseLive2d:getCurMouth()
	return self._curMouthName
end

function BaseLive2d:setSortingOrder(value)
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController.SortingOrder = value
end

function BaseLive2d:setAlpha(alpha)
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetAlpha(alpha)
end

function BaseLive2d:setSceneTexture(texture)
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetSceneTexture(texture)
end

function BaseLive2d:setUIMaskKeyword(enable)
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetUIMaskKeyword(enable)
end

function BaseLive2d:enableSceneAlpha()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetSceneAlphaKeyword(true)
end

function BaseLive2d:disableSceneAlpha()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetSceneAlphaKeyword(false)
end

function BaseLive2d:SetDark()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetColorFactor(0.6)
end

function BaseLive2d:SetBright()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:SetColorFactor(1)
end

function BaseLive2d:setMouthAnimation(mouthName, loop, mixTime)
	self._curMouthName = mouthName

	self:SetAnimation(BaseLive2d.MouthTrackIndex, mouthName, loop, mixTime)
end

function BaseLive2d:setTransition(transitionName, loop, mixTime)
	self:SetAnimation(BaseLive2d.TransitionTrackIndex, transitionName, loop, mixTime)
end

function BaseLive2d:SetAnimation(trackIndex, animationName, loop, mixTime)
	if gohelper.isNil(self._cubismController) then
		return
	end

	if self:hasAnimation(animationName) == false then
		return
	end

	if trackIndex <= BaseLive2d.MouthTrackIndex then
		self._cubismController:PlayAnimation(animationName, loop, 1, trackIndex)
	end
end

function BaseLive2d:_setBodyAnimation(trackIndex, animationName, loop, mixTime)
	if gohelper.isNil(self._cubismController) then
		return
	end

	if self:hasAnimation(animationName) == false then
		return
	end

	if trackIndex <= BaseLive2d.MouthTrackIndex then
		self._cubismController:PlayAnimation(animationName, loop, mixTime == 0 and 0 or 1, trackIndex)
	end
end

function BaseLive2d:hasAnimation(animationName)
	return not gohelper.isNil(self._cubismController) and self._cubismController:HasAnimation(animationName)
end

function BaseLive2d:hasExpression(name)
	return not gohelper.isNil(self._cubismController) and self._cubismController:HasExpression(name)
end

function BaseLive2d:setParameterStoreEnabled(value)
	return not gohelper.isNil(self._cubismController) and self._cubismController:SetParameterStoreEnabled(value)
end

function BaseLive2d:stopMouthAnimation()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:StopAnimation(BaseLive2d.MouthTrackIndex)
end

function BaseLive2d:stopTransition()
	if gohelper.isNil(self._cubismController) then
		return
	end

	self._cubismController:StopAnimation(BaseLive2d.TransitionTrackIndex)
end

function BaseLive2d:setActionEventCb(animEvtCb, animEvtCbObj)
	if self._isStory then
		self._actionCb = animEvtCb
		self._actionCbObj = animEvtCbObj
	end
end

function BaseLive2d:changeLookDir(dir)
	if dir == self._lookDir then
		return
	end

	self._lookDir = dir

	self:_changeLookDir()
end

function BaseLive2d:_changeLookDir()
	return
end

function BaseLive2d:getLookDir()
	return self._lookDir
end

function BaseLive2d:getMouthController()
	return self._cubismMouthController
end

function BaseLive2d:initSpecialEffect(resPath)
	if not self.customEffectComp then
		local skinName = string.match(resPath, "([^/]-)%.[^.]*$")
		local clsName = string.format("Live2dSpecialEffect_%s", skinName)
		local cls = _G[clsName]

		if cls then
			self.customEffectComp = MonoHelper.addNoUpdateLuaComOnceToGo(self._gameObj, cls)
		end
	end

	if self.customEffectComp then
		self.customEffectComp:setLive2d(self)
	end
end

function BaseLive2d:addParameter(name, mode, value)
	if not self._cubismController then
		return
	end

	self._cubismParameterModifider = self._cubismParameterModifider or self._cubismController:GetCubismParameterModifier()

	return self._cubismParameterModifider:AddParameter(name, mode, value)
end

function BaseLive2d:updateParameter(index, value)
	if not self._cubismParameterModifider then
		return
	end

	self._cubismParameterModifider:UpdateParameter(index, value)
end

function BaseLive2d:removeParameter(name)
	if not self._cubismParameterModifider then
		return
	end

	self._cubismParameterModifider:RemoveParameter(name)
end

function BaseLive2d:onDestroy()
	if self._resLoader then
		self._resLoader:onDestroy()

		self._resLoader = nil
	end

	if self._live2dVoice then
		self._live2dVoice:onDestroy()

		self._live2dVoice = nil
	end

	if self._roleEffectComp then
		self._roleEffectComp:onDestroy()

		self._roleEffectComp = nil
	end

	if self._roleFaceComp then
		self._roleFaceComp:onDestroy()

		self._roleFaceComp = nil
	end

	self._gameObj = nil
	self._resPath = nil
	self._cubismController = nil
	self._cubismMouthController = nil

	if self._spineGo then
		Live2dMaskController.instance:removeLive2dGo(self._spineGo)

		self._spineGo = nil
	end

	self._renderer = nil
	self._actionCb = nil
	self._actionCbObj = nil
	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
end

return BaseLive2d
