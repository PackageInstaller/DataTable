-- chunkname: @modules/spine/BaseSpine.lua

module("modules.spine.BaseSpine", package.seeall)

local BaseSpine = class("BaseSpine", LuaCompBase)

BaseSpine.BodyTrackIndex = 0
BaseSpine.FaceTrackIndex = 1
BaseSpine.MouthTrackIndex = 2
BaseSpine.TransitionTrackIndex = 3

function BaseSpine:init(gameObj)
	self._gameObj = gameObj
	self._gameTr = gameObj.transform
	self._resLoader = SpinePrefabInstantiate.Create(self._gameObj)
	self._resPath = nil
	self._skeletonComponent = nil
	self._spineGo = nil
	self._spineTr = nil
	self._isLoop = false
	self._lookDir = SpineLookDir.Left
	self._bFreeze = false
	self._actionCb = nil
	self._actionCbObj = nil
	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
	self._videoList = {}
end

function BaseSpine:setResPath(resPath, loadedCb, loadedCbObj)
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

function BaseSpine:setHeroId(id)
	self._heroId = id
end

function BaseSpine:setSkinId(id)
	self._skinId = id
end

function BaseSpine:getResPath()
	return self._resPath
end

function BaseSpine:doClear()
	self:_clear()
end

function BaseSpine:_clear()
	if self._resLoader then
		self._resLoader:dispose()
	end

	if self._roleEffectComp then
		self._roleEffectComp:onDestroy()

		self._roleEffectComp = nil
	end

	self._skeletonComponent = nil
	self._resPath = nil
	self._spineGo = nil
	self._spineTr = nil
	self._bFreeze = false
	self._effectGo = nil
	self._renderer = nil
	self._curBodyName = nil
end

function BaseSpine:setInMainView()
	self._isInMainView = true
end

function BaseSpine:isInMainView()
	return self._isInMainView
end

function BaseSpine:setBodyChangeCallback(callback, callbackObj)
	self._bodyChangeCallback = callback
	self._bodyChangeCallbackObj = callbackObj
end

function BaseSpine:isPlayingVoice()
	return self._spineVoice and self._spineVoice:playing()
end

function BaseSpine:getPlayVoiceStartTime()
	return self._spineVoice and self._spineVoice:getPlayVoiceStartTime()
end

function BaseSpine:playVoice(config, callback, txtContent, txtEnContent, bgGo, showBg)
	self._spineVoice = self._spineVoice or SpineVoice.New()

	self._spineVoice:playVoice(self, config, callback, txtContent, txtEnContent, bgGo, showBg)
end

function BaseSpine:stopVoice()
	if self._spineVoice then
		self._spineVoice:stopVoice()
	end
end

function BaseSpine:setSwitch(switchGroup, switchState)
	self._spineVoice = self._spineVoice or SpineVoice.New()

	self._spineVoice:setSwitch(self, switchGroup, switchState)
end

function BaseSpine:getSpineVoice()
	self._spineVoice = self._spineVoice or SpineVoice.New()

	return self._spineVoice
end

function BaseSpine:initSkeletonComponent()
	return
end

function BaseSpine:onAnimEventCallback(actName, evtName, args)
	if self._actionCb then
		self._actionCb(self._actionCbObj, actName, evtName, args)
	end

	if self._spineVoice then
		self._spineVoice:onAnimationEvent(actName, evtName, args)
	end
end

function BaseSpine:getSpineGo()
	return self._spineGo
end

function BaseSpine:getRenderer()
	if gohelper.isNil(self._spineGo) then
		return nil
	end

	self._renderer = self._renderer or self._spineGo:GetComponent(typeof(UnityEngine.Renderer))

	return self._renderer
end

function BaseSpine:getSpineTr()
	return self._spineTr
end

function BaseSpine:_onResLoaded()
	self._spineGo = self._resLoader:getInstGO()
	self._spineTr = self._spineGo.transform
	self._renderer = nil

	self:_initRoleEffect()
	self:_initFaceEffect()
	self:initSkeletonComponent()
	self:_changeLookDir()

	if self._isStory then
		local csUISpineEvt = self._spineGo:GetComponent(self._animationEvent)

		csUISpineEvt:SetAnimEventCallback(self.onAnimEventCallback, self)

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

function BaseSpine:_initRoleEffect()
	local roleEffectConfig

	self._roleEffectComp, roleEffectConfig = self:_getRoleEffectComp(self._resPath)

	if self._roleEffectComp then
		self._roleEffectComp:setSpine(self)
		self._roleEffectComp:init(roleEffectConfig)
	end
end

function BaseSpine:_getRoleEffectComp(resPath)
	for i, v in ipairs(lua_character_motion_effect.configList) do
		if string.find(resPath, v.heroResName) then
			local effectCompName = v.effectCompName
			local cls = _G[effectCompName]

			return cls.New(), v
		end
	end
end

function BaseSpine:setSkipBodyEffect(skip)
	self._isSkipBodyEffect = skip
end

function BaseSpine:_showBodyEffect(bodyName)
	if self._isSkipBodyEffect then
		return
	end

	if self._roleEffectComp then
		self._roleEffectComp:showBodyEffect(bodyName)
	end
end

function BaseSpine:play(bodyName, loop)
	self._curBodyName = bodyName

	self:setBodyAnimation(bodyName, loop, 0.5)
end

function BaseSpine:playStory(bodyName, faceName)
	self._curBodyName = bodyName
	self._curFaceName = faceName

	if bodyName ~= StoryAnimName.B_IDLE or self:hasAnimation(bodyName) then
		self:setBodyAnimation(bodyName, true, 0.5)
	end

	if faceName ~= StoryAnimName.E_ZhengChang or self:hasAnimation(faceName) then
		self:setFaceAnimation(faceName, true, 0.5)
	end
end

function BaseSpine:setBodyAnimation(bodyName, loop, mixTime)
	local oldBodyName = self._curBodyName

	self._curBodyName = bodyName

	self:SetAnimation(BaseSpine.BodyTrackIndex, bodyName, loop, mixTime)
	self:_showBodyEffect(bodyName)

	if self._bodyChangeCallback then
		self._bodyChangeCallback(self._bodyChangeCallbackObj, oldBodyName, bodyName)
	end
end

function BaseSpine:getCurBody()
	return self._curBodyName
end

function BaseSpine:setFaceAnimation(faceName, loop, mixTime)
	self._curFaceName = faceName

	self:SetAnimation(BaseSpine.FaceTrackIndex, faceName, loop, mixTime)
	self:_showFaceEffect(faceName)
end

function BaseSpine:_initFaceEffect()
	local faceEffectConfig

	self._faceEffectComp, faceEffectConfig = self:_getRoleFaceEffectComp(self._resPath)

	if self._faceEffectComp then
		self._faceEffectComp:setSpine(self)
		self._faceEffectComp:init(faceEffectConfig)
	end
end

function BaseSpine:_getRoleFaceEffectComp(resPath)
	for i, v in ipairs(lua_character_face_effect.configList) do
		if string.find(resPath, v.heroResName) then
			local effectCompName = v.effectCompName
			local cls = _G[effectCompName]

			return cls.New(), v
		end
	end
end

function BaseSpine:_showFaceEffect(faceName)
	if self._faceEffectComp then
		self._faceEffectComp:showFaceEffect(faceName)
	end
end

function BaseSpine:getCurFace()
	return self._curFaceName
end

function BaseSpine:getCurMouth()
	return self._curMouthName
end

function BaseSpine:setMouthAnimation(mouthName, loop, mixTime)
	self._curMouthName = mouthName

	self:SetAnimation(BaseSpine.MouthTrackIndex, mouthName, loop, mixTime)
end

function BaseSpine:setTransition(transitionName, loop, mixTime)
	self:SetAnimation(BaseSpine.TransitionTrackIndex, transitionName, loop, mixTime)
end

function BaseSpine:SetAnimation(trackIndex, animationName, loop, mixTime)
	if not self._skeletonComponent then
		return
	end

	if self:hasAnimation(animationName) == false then
		return
	end

	self._skeletonComponent:SetAnimation(trackIndex, animationName, loop, mixTime)
end

function BaseSpine:hasAnimation(animationName)
	return self._skeletonComponent and self._skeletonComponent:HasAnimation(animationName)
end

function BaseSpine:stopMouthAnimation()
	if not self._skeletonComponent then
		return
	end

	self._skeletonComponent:SetEmptyAnimation(BaseSpine.MouthTrackIndex, 0)
end

function BaseSpine:stopTransition()
	if not self._skeletonComponent or gohelper.isNil(self._spineGo) then
		return
	end

	self._skeletonComponent:SetEmptyAnimation(BaseSpine.TransitionTrackIndex, 0)
end

function BaseSpine:setActionEventCb(animEvtCb, animEvtCbObj)
	if self._isStory then
		self._actionCb = animEvtCb
		self._actionCbObj = animEvtCbObj
	end
end

function BaseSpine:changeLookDir(dir)
	if dir == self._lookDir then
		return
	end

	self._lookDir = dir

	self:_changeLookDir()
end

function BaseSpine:_changeLookDir()
	if not gohelper.isNil(self._gameTr) and self._skeletonComponent then
		self._skeletonComponent:SetScaleX(self._lookDir)
	end
end

function BaseSpine:getLookDir()
	return self._lookDir
end

function BaseSpine:onDestroy()
	if self._resLoader then
		self._resLoader:onDestroy()

		self._resLoader = nil
	end

	if self._spineVoice then
		self._spineVoice:onDestroy()

		self._spineVoice = nil
	end

	if self._roleEffectComp then
		self._roleEffectComp:onDestroy()

		self._roleEffectComp = nil
	end

	self._gameObj = nil
	self._resPath = nil
	self._skeletonComponent = nil
	self._spineGo = nil
	self._renderer = nil
	self._actionCb = nil
	self._actionCbObj = nil
	self._resLoadedCb = nil
	self._resLoadedCbObj = nil
end

return BaseSpine
