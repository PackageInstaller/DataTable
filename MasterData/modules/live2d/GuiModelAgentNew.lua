-- chunkname: @modules/live2d/GuiModelAgentNew.lua

module("modules.live2d.GuiModelAgentNew", package.seeall)

local GuiModelAgentNew = class("GuiModelAgentNew", LuaCompBase)

function GuiModelAgentNew.Create(go, isStory)
	local agent = MonoHelper.addNoUpdateLuaComOnceToGo(go, GuiModelAgentNew)

	agent._isStory = isStory

	return agent
end

function GuiModelAgentNew:init(go)
	self._go = go
end

function GuiModelAgentNew:_getSpine()
	self._spine = self._spine or LightSpine.Create(self._go, self._isStory)

	return self._spine
end

function GuiModelAgentNew:_getLive2d()
	self._live2d = self._live2d or GuiLive2d.Create(self._go, self._isStory)

	self._live2d:cancelCamera()

	return self._live2d
end

function GuiModelAgentNew:setSkinCfg(skinCfg, loadedCb, loadedCbObj)
	local lastModel = self._curModel
	local lastIsLive2D = self._isLive2D

	self.loadedCb = loadedCb
	self.loadedCbObj = loadedCbObj

	if string.nilorempty(skinCfg.live2d) then
		self._isLive2D = false
		self._curModel = self:_getSpine()

		gohelper.setActive(self._curModel._spineGo, true)
		self._curModel:setResPath(ResUrl.getLightSpine(skinCfg.verticalDrawing), self._loadResCb, self)
	else
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		gohelper.setActive(self._curModel._spineGo, true)
		self._curModel:setResPath(ResUrl.getLightLive2d(skinCfg.live2d), self._loadResCb, self)
	end

	if lastModel and self._isLive2D ~= lastIsLive2D then
		gohelper.setActive(lastModel._spineGo, false)
	end
end

function GuiModelAgentNew:setResPath(url, isLive2D, loadedCb, loadedCbObj)
	local lastModel = self._curModel
	local lastIsLive2D = self._isLive2D

	self.loadedCb = loadedCb
	self.loadedCbObj = loadedCbObj

	if isLive2D then
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		gohelper.setActive(self._curModel._spineGo, true)
		self._curModel:setResPath(url, self._loadResCb, self)
	else
		self._isLive2D = false
		self._curModel = self:_getSpine()

		gohelper.setActive(self._curModel._spineGo, true)
		self._curModel:setResPath(url, self._loadResCb, self)
	end

	if lastModel and self._isLive2D ~= lastIsLive2D then
		gohelper.setActive(lastModel._spineGo, false)
	end
end

function GuiModelAgentNew:setVerticalDrawing(path, loadedCb, loadedCbObj)
	local list = string.split(path, "/")
	local name = list and list[#list]
	local live2dName
	local lastModel = self._curModel
	local lastIsLive2D = self._isLive2D

	if name then
		name = string.gsub(name, ".prefab", "")
		live2dName = SkinConfig.instance:getLive2dSkin(name)
	end

	self.loadedCb = loadedCb
	self.loadedCbObj = loadedCbObj

	if not live2dName then
		self._isLive2D = false
		self._curModel = self:_getSpine()

		self._curModel:showModel()
		self._curModel:setResPath(path, self._loadResCb, self)
	else
		self._isLive2D = true
		self._curModel = self:_getLive2d()

		self._curModel:showModel()
		self._curModel:cancelCamera()
		self._curModel:setResPath(ResUrl.getLightLive2d(live2dName), self._loadResCb, self)
	end

	if self._isLive2D ~= lastIsLive2D then
		lastModel:hideModel()
	end
end

function GuiModelAgentNew:_loadResCb()
	local modelGo = self._curModel:getSpineGo()
	local baseGo = modelGo
	local goRoleeffect, ppEffectMask

	if self._isLive2D then
		local drawables = gohelper.findChild(modelGo, "Drawables")

		baseGo = drawables.transform:GetChild(0).gameObject
	end

	goRoleeffect = gohelper.findChild(baseGo, "roleeffect_for_ui")

	if goRoleeffect == nil then
		goRoleeffect = gohelper.create2d(baseGo, "roleeffect_for_ui")
	end

	gohelper.onceAddComponent(baseGo, typeof(UrpCustom.PPEffectMask)).useLocalBloom = true

	gohelper.setActive(goRoleeffect, false)

	if self._curModel.setLocalScale then
		self._curModel:setLocalScale(1)
	else
		transformhelper.setLocalScale(modelGo.transform, 1, 1, 1)
	end

	local roleEffectCtrl = gohelper.onceAddComponent(goRoleeffect, typeof(ZProj.RoleEffectCtrl))

	roleEffectCtrl.forUI = true

	gohelper.setActive(goRoleeffect, true)

	if self.loadedCb then
		self.loadedCb(self.loadedCbObj)
	end
end

function GuiModelAgentNew:setModelVisible(value)
	if not self._curModel then
		return
	end

	gohelper.setActive(self._go, value)
end

function GuiModelAgentNew:processModelEffect()
	if self:isLive2D() then
		self._curModel:processModelEffect()
	end
end

function GuiModelAgentNew:hideModelEffect()
	if self:isLive2D() then
		self._curModel:hideModelEffect()
	end
end

function GuiModelAgentNew:getSpineGo()
	if self._curModel then
		return self._curModel:getSpineGo()
	end
end

function GuiModelAgentNew:setSortingOrder(value)
	if self._curModel and self._curModel.setSortingOrder then
		return self._curModel:setSortingOrder(value)
	end
end

function GuiModelAgentNew:setAlpha(alpha)
	if self._curModel and self:isLive2D() then
		self._curModel:setAlpha(alpha)
	end
end

function GuiModelAgentNew:isLive2D()
	return self._isLive2D == true
end

function GuiModelAgentNew:isSpine()
	return self._isLive2D ~= true
end

function GuiModelAgentNew:getSpineVoice()
	if self._curModel then
		return self._curModel:getSpineVoice()
	end
end

function GuiModelAgentNew:isPlayingVoice()
	if self._curModel then
		return self._curModel:isPlayingVoice()
	end
end

function GuiModelAgentNew:playVoice(config, callback, txtContent, txtEnContent, bgGo)
	if self._curModel then
		self._curModel:playVoice(config, callback, txtContent, txtEnContent, bgGo)
	end
end

function GuiModelAgentNew:stopVoice()
	if self._curModel then
		self._curModel:stopVoice()
	end
end

function GuiModelAgentNew:setSwitch(switchGroup, switchState)
	if self._curModel then
		self._curModel:setSwitch(switchGroup, switchState)
	end
end

return GuiModelAgentNew
