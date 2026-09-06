-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarPendantsCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarPendantsCtrl", package.seeall)

local AvatarPendantsCtrl = class("AvatarPendantsCtrl", AvatarController)

function AvatarPendantsCtrl:ctor(avatarBase)
	AvatarPendantsCtrl.super.ctor(self, avatarBase)

	self._pendants = nil
	self._layer = nil
	self._isInit = nil

	self.addListener(self, AvatarNotify.OnPendantLoaded, self._onPendantLoaded, self)
end

function AvatarPendantsCtrl:_getControllerType()
	return AvatarControllerType.Pendant
end

function AvatarPendantsCtrl:onAvatarLoaded()
	AvatarPendantsCtrl.super.onAvatarLoaded(self)
end

function AvatarPendantsCtrl:onAvatarLoadedCallBack()
	AvatarPendantsCtrl.super.onAvatarLoadedCallBack(self)

	local avatarMo = self._avatar.avatarmo

	self:updatePendantsByMo(avatarMo)
end

function AvatarPendantsCtrl:onAvatarInvisible()
	AvatarPendantsCtrl.super.onAvatarInvisible(self)
	self:onAvatarReset()
end

function AvatarPendantsCtrl:onAvatarVisible()
	AvatarPendantsCtrl.super.onAvatarVisible(self)

	local avatarMo = self._avatar.avatarmo

	self:updatePendantsByMo(avatarMo)
end

function AvatarPendantsCtrl:onAvatarReset()
	AvatarPendantsCtrl.super.onAvatarReset(self)

	if self._pendants then
		for _, p in pairs(self._pendants) do
			p:reset()
		end
	end
end

function AvatarPendantsCtrl:onAvatarDestroy()
	AvatarPendantsCtrl.super.onAvatarDestroy(self)
	self:removeAllListener(AvatarNotify.OnPendantLoaded)

	if self._pendants then
		for _, p in pairs(self._pendants) do
			p:destroy()
		end
	end

	self._layer = nil
	self._pendants = nil
end

function AvatarPendantsCtrl:setLayer(layer)
	self._layer = layer

	if self._pendants then
		for _, p in pairs(self._pendants) do
			p:setLayer(self._layer)
		end
	end
end

function AvatarPendantsCtrl:updatePendantsByMo(mo)
	if not mo then
		return
	end

	self._isInit = false

	for k, v in pairs(mo:getOwnPendanttTypeNames()) do
		local id = mo[v].value

		if id and id > 0 then
			-- block empty
		else
			local type = table.keyof(AvatarPendantTypeName, v)

			self:removePendantByType(type)
		end
	end

	for k, v in pairs(mo:getOwnPendanttTypeNames()) do
		local id = mo[v].value

		if id and id > 0 then
			local type = table.keyof(AvatarPendantTypeName, v)

			self:addPendant(type, id)
		end
	end

	self._isInit = true

	if self._pendants then
		if table.nums(self._pendants) == 0 then
			self._avatar:dispatch(AvatarNotify.OnAllPendantsLoaded)
		elseif self:isAllPendantLoaded() then
			self._avatar:dispatch(AvatarNotify.OnAllPendantsLoaded)
		end
	else
		self._avatar:dispatch(AvatarNotify.OnAllPendantsLoaded)
	end
end

function AvatarPendantsCtrl:addPendant(type, id)
	self._pendants = self._pendants or {}

	local pendantCfg = AvatarConfig.instance:getPartCfgById(id)

	if not pendantCfg or not pendantCfg.asset then
		printError("pendantcfg get Error Id : " .. (id or "nil"))

		return
	end

	local resPath = GameUrl.getAvatarPart(pendantCfg.asset, AvatarPendantTypeName[type], self._avatar.useType, pendantCfg.isResSame)
	local exitPendant = self._pendants[type]

	if exitPendant then
		if exitPendant:getResPath() ~= resPath then
			exitPendant:reset()
			exitPendant:setPendantId(id)

			local hangPoint = self._avatar:getBoneByPointType(AvatarPendantTypeParent[type])

			exitPendant:setParent(hangPoint)
		end

		exitPendant:load(resPath)

		return
	end

	local pendant = AvatarPendant.New(self)

	pendant:setPendantType(type)
	pendant:setLayer(self._layer)

	local hangPoint = self._avatar:getBoneByPointType(AvatarPendantTypeParent[type])

	pendant:setParent(hangPoint)
	pendant:setPendantId(id)

	self._pendants[type] = pendant

	pendant:load(resPath)
end

function AvatarPendantsCtrl:removePendantByType(type)
	if self._pendants and self._pendants[type] then
		self._pendants[type]:reset()
	end
end

function AvatarPendantsCtrl:isAllPendantLoaded()
	if not self._isInit then
		return false
	end

	if self._pendants then
		for _, p in pairs(self._pendants) do
			if not p:isObjLoaded() then
				return false
			end
		end

		if table.nums(self._pendants) == 0 then
			return true
		end
	end

	return true
end

function AvatarPendantsCtrl:_onPendantLoaded(pendant)
	if pendant and pendant:isObjLoaded() then
		if self:isAllPendantLoaded() then
			self._avatar:dispatch(AvatarNotify.OnAllPendantsLoaded)
		end
	else
		print("avatar pendant is not loaded")
	end
end

function AvatarPendantsCtrl:setVisibleByType(type, isVisible)
	if self._pendants then
		if self._pendants then
			if isVisible == nil then
				self._pendants:setVisible(true)
			else
				self._pendants:setVisible(isVisible)
			end
		end
	end
end

function AvatarPendantsCtrl:updateMountState(type, pointType)
	if pointType then
		::label_16_0::

		local point = self._avatar:getBoneByPointType(pointType)

		if self._pendants then
			local p = self._pendants[type]

			if p then
				local avatarMo = self._avatar.avatarmo

				if avatarMo.isMount then
					local id = avatarMo:getDataByType(type)
					local pendantCfg = AvatarConfig.instance:getPartCfgById(id)
					local pGo = p:getGameObject()

					if pGo and pendantCfg then
						if not pendantCfg.mountStatePos then
							if not pendantCfg.mountStateRotate then
								local rotate = {
									90,
									0,
									0
								}

								if point then
									goutil.addChildToParent(pGo, point)
								end

								Framework.TransformUtil.SetLocalPos(pGo.transform, checknumber(pendantCfg.mountStatePos[1]), checknumber(pendantCfg.mountStatePos[2]), checknumber(pendantCfg.mountStatePos[3]))
								Framework.TransformUtil.SetLocalRotation(pGo.transform, checknumber(rotate[1]), checknumber(rotate[2]), checknumber(rotate[3]))
							end
						end
					end
				else
					p:resetState()
				end
			end
		end
	end
end

return AvatarPendantsCtrl
