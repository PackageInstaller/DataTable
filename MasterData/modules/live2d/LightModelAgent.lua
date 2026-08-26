-- chunkname: @modules/live2d/LightModelAgent.lua

module("modules.live2d.LightModelAgent", package.seeall)

local LightModelAgent = class("LightModelAgent", LuaCompBase)

function LightModelAgent.Create(go, isStory)
	local agent = MonoHelper.addNoUpdateLuaComOnceToGo(go, LightModelAgent)

	agent._isStory = isStory

	return agent
end

function LightModelAgent:init(go)
	self._go = go
end

function LightModelAgent:clear()
	self._curModel:doClear()
end

function LightModelAgent:_getSpine()
	self._spine = self._spine or LightSpine.Create(self._go, self._isStory)

	return self._spine
end

function LightModelAgent:_getLive2d()
	self._live2d = self._live2d or LightLive2d.Create(self._go, self._isStory)

	return self._live2d
end

function LightModelAgent:getLive2d()
	return self:_getLive2d()
end

function LightModelAgent:fadeIn()
	local go = self:getSpineGo()

	self._ppEffectMask = gohelper.onceAddComponent(go, PostProcessingMgr.PPEffectMaskType)
	self._ppEffectMask.useLocalBloom = true
	self._ppEffectMask.enabled = true
	self._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 0.5, self._onFadeInUpdate, self._onFadeInFinish, self, nil, EaseType.Linear)
end

function LightModelAgent:_onFadeInUpdate(value)
	local go = self:getSpineGo()

	if gohelper.isNil(go) then
		if self._tweenId then
			ZProj.TweenHelper.KillById(self._tweenId)

			self._tweenId = nil
		end

		return
	end

	local vec4Param = Vector4(0, 0, value, 0)

	if not self._isLive2D then
		local mats = self._curModel:getRenderer().materials
		local len = mats.Length

		for i = 0, len - 1 do
			local material = mats[i]

			material:EnableKeyword("USE_INVISIBLE")
			self._ppEffectMask:SetPassEnable(material, "useInvisible", true)
			material:SetVector("_InvisibleOffset", vec4Param)
		end

		return
	end

	local list = go:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, list.Length - 1 do
		local meshRenderer = list[i]

		if not gohelper.isNil(meshRenderer) then
			local material = meshRenderer.sharedMaterial

			if not gohelper.isNil(material) then
				material:EnableKeyword("USE_INVISIBLE")
				self._ppEffectMask:SetPassEnable(material, "useInvisible", true)
				material:SetVector("_InvisibleOffset", vec4Param)
			end
		end
	end
end

function LightModelAgent:_onFadeInFinish()
	local go = self:getSpineGo()

	if gohelper.isNil(go) then
		return
	end

	if self._ppEffectMask then
		self._ppEffectMask.enabled = false
	end

	if not self._isLive2D then
		self._curModel:getRenderer().materials = self._curModel:getSharedMats()

		return
	end

	local list = go:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for i = 0, list.Length - 1 do
		local meshRenderer = list[i]

		if not gohelper.isNil(meshRenderer) then
			local material = meshRenderer.sharedMaterial

			if not gohelper.isNil(material) then
				material:DisableKeyword("USE_INVISIBLE")

				if self._ppEffectMask then
					self._ppEffectMask:SetPassEnable(material, "useInvisible", false)
				end
			end
		end
	end

	self._curModel:clearSharedMaterials()
end

function LightModelAgent:setResPath(skinCfg, loadedCb, loadedCbObj)
	if string.nilorempty(skinCfg.live2d) then
		self._isLive2D = false
		self._curModel = self:_getSpine()

		self._curModel:setHeroId(skinCfg.characterId)
		self._curModel:setSkinId(skinCfg.id)
		self._curModel:setResPath(ResUrl.getLightSpine(skinCfg.verticalDrawing), loadedCb, loadedCbObj)
	else
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		self._curModel:setHeroId(skinCfg.characterId)
		self._curModel:setSkinId(skinCfg.id)
		self._curModel:setResPath(ResUrl.getLightLive2d(skinCfg.live2d), loadedCb, loadedCbObj)
	end
end

function LightModelAgent:setInMainView()
	self._curModel:setInMainView()
end

function LightModelAgent:setSkipBodyEffect(value)
	self._curModel:setSkipBodyEffect(value)
end

function LightModelAgent:setBodyChangeCallback(callback, callbackObj)
	self._curModel:setBodyChangeCallback(callback, callbackObj)
end

function LightModelAgent:setMainColor(color)
	self._curModel:setMainColor(color)
end

function LightModelAgent:setLumFactor(value)
	self._curModel:setLumFactor(value)
end

function LightModelAgent:setEmissionColor(color)
	if self._isLive2D then
		self._curModel:setEmissionColor(color)
	end
end

function LightModelAgent:processModelEffect()
	if self._isLive2D then
		self._curModel:processModelEffect()
	end
end

function LightModelAgent:setEffectVisible(value)
	if self._isLive2D then
		self._curModel:setEffectVisible(value)
	end
end

function LightModelAgent:setLayer(layer)
	if self._isLive2D then
		local go = self._curModel:getSpineGo()

		gohelper.setLayer(go, layer, true)
	end
end

function LightModelAgent:setEffectFrameVisible(value)
	if self._isLive2D then
		self._curModel:setEffectFrameVisible(value)
	end
end

function LightModelAgent:addParameter(name, mode, value)
	if self._isLive2D then
		return self._curModel:addParameter(name, mode, value)
	end
end

function LightModelAgent:updateParameter(index, value)
	if self._isLive2D then
		self._curModel:updateParameter(index, value)
	end
end

function LightModelAgent:removeParameter(name)
	if self._isLive2D then
		self._curModel:removeParameter(name)
	end
end

function LightModelAgent:changeSortingMode(mode)
	if self._isLive2D then
		self._curModel:changeSortingMode(mode)
	end
end

function LightModelAgent:getSpineGo()
	return self._curModel:getSpineGo()
end

function LightModelAgent:getRenderer()
	return self._curModel:getRenderer()
end

function LightModelAgent:changeRenderQueue(value)
	self._curModel:changeRenderQueue(value)
end

function LightModelAgent:setStencilRef(iValue)
	self._curModel:setStencilRef(iValue)
end

function LightModelAgent:setStencilValues(ref, comp, op)
	self._curModel:setStencilValues(ref, comp, op)
end

function LightModelAgent:isPlayingVoice()
	return self._curModel:isPlayingVoice()
end

function LightModelAgent:getPlayVoiceStartTime()
	return self._curModel:getPlayVoiceStartTime()
end

function LightModelAgent:getBoundsMinMaxPos()
	return self._curModel:getBoundsMinMaxPos()
end

function LightModelAgent:playVoice(config, callback, txtContent, txtEnContent, bgGo)
	self._curModel:playVoice(config, callback, txtContent, txtEnContent, bgGo)
end

function LightModelAgent:stopVoice()
	if not self._curModel then
		return
	end

	self._curModel:stopVoice()
end

function LightModelAgent:play(bodyName, loop)
	if not self._curModel then
		return
	end

	self._curModel:play(bodyName, loop)
end

function LightModelAgent:doDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self:stopVoice()
	self:onDestroy()
	self:clear()
end

return LightModelAgent
