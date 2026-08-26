-- chunkname: @modules/live2d/GuiModelAgent.lua

module("modules.live2d.GuiModelAgent", package.seeall)

local GuiModelAgent = class("GuiModelAgent", LuaCompBase)

function GuiModelAgent.Create(go, isStory)
	local agent = MonoHelper.addNoUpdateLuaComOnceToGo(go, GuiModelAgent)

	agent._isStory = isStory

	return agent
end

function GuiModelAgent:showDragEffect(value)
	if not self._dragEffectGoList then
		return
	end

	for i, v in ipairs(self._dragEffectGoList) do
		gohelper.setActive(v, value)
	end
end

function GuiModelAgent:initSkinDragEffect(skinId)
	self._dragEffectGoList = self._dragEffectGoList or {}

	tabletool.clear(self._dragEffectGoList)

	local config = lua_skin_fullscreen_effect.configDict[skinId]

	if not config then
		return
	end

	local spineGo = self:getSpineGo()
	local list = string.split(config.effectList, "|")

	for i, v in ipairs(list) do
		local go = gohelper.findChild(spineGo, v)

		if go then
			table.insert(self._dragEffectGoList, go)
		end
	end
end

function GuiModelAgent:init(go)
	self._go = go
end

function GuiModelAgent:setUIMask(isActive)
	if self:isLive2D() then
		local l2d = self:_getLive2d()

		if l2d:isCancelCamera() then
			l2d:setUIMaskKeyword(isActive)
		else
			l2d:setImageUIMask(isActive)
		end
	elseif self:isSpine() then
		self:_getSpine():setImageUIMask(isActive)
	end
end

function GuiModelAgent:useRT()
	if self:isSpine() then
		self:_getSpine():useRT()
	end
end

function GuiModelAgent:setImgPos(posx, posy)
	if self:isSpine() then
		self:_getSpine():setImgPos(posx, posy)
	end
end

function GuiModelAgent:setImgSize(width, height)
	if self:isSpine() then
		self:_getSpine():setImgSize(width, height)
	end
end

function GuiModelAgent:setAlphaBg(texture)
	if self:isLive2D() then
		self:setSceneTexture(texture)
	elseif self:isSpine() then
		local skeletonGraphic = self:getSkeletonGraphic()

		if skeletonGraphic then
			skeletonGraphic.materialForRendering:SetTexture("_SceneMask", texture)
		end
	end
end

function GuiModelAgent:_getSpine()
	self._spine = self._spine or GuiSpine.Create(self._go, self._isStory)

	return self._spine
end

function GuiModelAgent:_getLive2d()
	self._live2d = self._live2d or GuiLive2d.Create(self._go, self._isStory)

	return self._live2d
end

function GuiModelAgent:getLive2d()
	return self._live2d
end

function GuiModelAgent:getRootTransform()
	return self._go.transform
end

function GuiModelAgent:openBloomView(value)
	self._openBloomView = value
end

function GuiModelAgent:setShareRT(value, viewName)
	self._shareRT = value
	self._rtViewName = viewName

	if value == CharacterVoiceEnum.RTShareType.Normal and not viewName then
		logError("CharacterVoiceEnum.RTShareType.Normal viewName is nil")
	end
end

function GuiModelAgent:setResPath(skinCfg, loadedCb, loadedCbObj, cameraSize)
	local lastModel = self._curModel
	local lastIsLive2D = self._isLive2D

	if string.nilorempty(skinCfg.live2d) then
		self._isLive2D = false
		self._curModel = self:_getSpine()

		self._curModel:setHeroId(skinCfg.characterId)
		self._curModel:setSkinId(skinCfg.id)
		self._curModel:showModel()
		self._curModel:setResPath(ResUrl.getRolesPrefabStory(skinCfg.verticalDrawing), loadedCb, loadedCbObj)
	else
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		self._curModel:setHeroId(skinCfg.characterId)
		self._curModel:setSkinId(skinCfg.id)
		self._curModel:openBloomView(self._openBloomView)
		self._curModel:showModel()
		self._curModel:setShareRT(self._shareRT, self._rtViewName)

		if self._shareRT == CharacterVoiceEnum.RTShareType.BloomAuto then
			self._curModel:setCreateType(CharacterVoiceEnum.CreateType.GuiModelAgent)
			self._curModel:setCameraSize(CharacterVoiceEnum.BloomFullScreenEffectCameraSize)
		elseif self._shareRT == CharacterVoiceEnum.RTShareType.Normal then
			self._curModel:setCreateType(CharacterVoiceEnum.CreateType.GuiModelAgent)
			self._curModel:setCameraSize(CharacterVoiceEnum.NormalFullScreenEffectCameraSize)
		else
			self._curModel:setCameraSize(cameraSize or skinCfg.cameraSize)
		end

		self._curModel:setResPath(ResUrl.getLightLive2d(skinCfg.live2d), loadedCb, loadedCbObj)
	end

	if lastModel and self._isLive2D ~= lastIsLive2D then
		lastModel:hideModel()
	end
end

function GuiModelAgent:setLive2dCameraLoadedCallback(callback, callbackObj)
	local live2d = self:_getLive2d()

	if live2d then
		live2d:setCameraLoadedCallback(callback, callbackObj)
	end
end

function GuiModelAgent:setLive2dCameraLoadFinishCallback(callback, callbackObj)
	local live2d = self:_getLive2d()

	if live2d then
		live2d:setCameraLoadFinishCallback(callback, callbackObj)
	end
end

function GuiModelAgent:setVerticalDrawing(path, loadedCb, loadedCbObj)
	local list = string.split(path, "/")
	local name = list and list[#list]
	local live2dName
	local lastModel = self._curModel
	local lastIsLive2D = self._isLive2D

	if name then
		name = string.gsub(name, ".prefab", "")
		live2dName = SkinConfig.instance:getLive2dSkin(name)
	end

	if not live2dName then
		self._isLive2D = false
		self._curModel = self:_getSpine()

		self._curModel:showModel()
		self._curModel:setResPath(path, loadedCb, loadedCbObj)
	else
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		self._curModel:showModel()
		self._curModel:cancelCamera()
		self._curModel:setResPath(ResUrl.getLightLive2d(live2dName), loadedCb, loadedCbObj)
	end

	if self._isLive2D ~= lastIsLive2D then
		lastModel:hideModel()
	end
end

function GuiModelAgent:setModelVisible(value)
	if not self._curModel then
		return
	end

	gohelper.setActive(self._go, value)

	if value then
		if self._curModel.showModel then
			self._curModel:showModel()
		end
	elseif self._curModel.hideModel then
		self._curModel:hideModel()
	end
end

function GuiModelAgent:hideCamera()
	if self:isLive2D() then
		self._curModel:hideCamera()
	end
end

function GuiModelAgent:setLayer(layer)
	if self:isLive2D() then
		local go = self._curModel:getSpineGo()

		gohelper.setLayer(go, layer, true)
	end
end

function GuiModelAgent:setAllLayer(layer)
	if self:isLive2D() then
		self:setLayer(layer)
		self._curModel:setCameraLayer(layer)
	end
end

function GuiModelAgent:processModelEffect()
	if self:isLive2D() then
		self._curModel:processModelEffect()
	end
end

function GuiModelAgent:hideModelEffect()
	if self:isLive2D() then
		self._curModel:hideModelEffect()
	end
end

function GuiModelAgent:showModelEffect()
	if self:isLive2D() then
		self._curModel:showModelEffect()
	end
end

function GuiModelAgent:getSpineGo()
	if self._curModel then
		return self._curModel:getSpineGo()
	end
end

function GuiModelAgent:getSkeletonGraphic()
	if self._curModel and self._curModel.getSkeletonGraphic then
		return self._curModel:getSkeletonGraphic()
	end
end

function GuiModelAgent:setSortingOrder(value)
	if self._curModel and self._curModel.setSortingOrder then
		return self._curModel:setSortingOrder(value)
	end
end

function GuiModelAgent:setAlpha(alpha)
	if self._curModel and self:isLive2D() then
		self._curModel:setAlpha(alpha)
	end
end

function GuiModelAgent:enableSceneAlpha()
	if self._curModel and self:isLive2D() then
		self._curModel:enableSceneAlpha()
	end
end

function GuiModelAgent:disableSceneAlpha()
	if self._curModel and self:isLive2D() then
		self._curModel:disableSceneAlpha()
	end
end

function GuiModelAgent:setSceneTexture(texture)
	if self._curModel and self:isLive2D() then
		self._curModel:setSceneTexture(texture)
	end
end

function GuiModelAgent:isLive2D()
	return self._isLive2D == true
end

function GuiModelAgent:isSpine()
	return self._isLive2D ~= true
end

function GuiModelAgent:getSpineVoice()
	if self._curModel then
		return self._curModel:getSpineVoice()
	end
end

function GuiModelAgent:isPlayingVoice()
	if self._curModel then
		return self._curModel:isPlayingVoice()
	end
end

function GuiModelAgent:getPlayVoiceStartTime()
	if self._curModel then
		return self._curModel:getPlayVoiceStartTime()
	end
end

function GuiModelAgent:playVoice(config, callback, txtContent, txtEnContent, bgGo, showBg)
	if self._curModel then
		self._curModel:playVoice(config, callback, txtContent, txtEnContent, bgGo, showBg)
	end
end

function GuiModelAgent:stopVoice()
	if self._curModel then
		self._curModel:stopVoice()
	end
end

function GuiModelAgent:setSwitch(switchGroup, switchState)
	if self._curModel then
		self._curModel:setSwitch(switchGroup, switchState)
	end
end

function GuiModelAgent:playSpecialMotion(motion, loop, mixTime)
	if self._curModel and self._isLive2D then
		self._curModel:stopVoice()
		self._curModel:setBodyAnimation(motion, loop, mixTime)
	end
end

function GuiModelAgent:setActionEventCb(callback, callbackObj)
	if self._curModel then
		self._curModel:setActionEventCb(callback, callbackObj)
	end
end

function GuiModelAgent:onDestroy()
	if self._dragEffectGoList then
		tabletool.clear(self._dragEffectGoList)
	end
end

return GuiModelAgent
