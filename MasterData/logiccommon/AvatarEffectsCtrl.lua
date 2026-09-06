-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/new/avatarcontroller/AvatarEffectsCtrl.lua

module("logiccommon.common.avatar.avatarcontroller.AvatarEffectsCtrl", package.seeall)

local AvatarEffectsCtrl = class("AvatarEffectsCtrl", AvatarController)

function AvatarEffectsCtrl:ctor(avatarBase)
	AvatarEffectsCtrl.super.ctor(self, avatarBase)

	self._effs = nil
	self._layer = nil
	self._suitEffects = nil
	self._effsPlayType = AvatarFXEffType.IdleOnly
end

function AvatarEffectsCtrl:_getControllerType()
	return AvatarControllerType.Effect
end

function AvatarEffectsCtrl:onAvatarLoaded()
	AvatarEffectsCtrl.super.onAvatarLoaded(self)
end

function AvatarEffectsCtrl:onAvatarLoadedCallBack()
	AvatarEffectsCtrl.super.onAvatarLoadedCallBack(self)
	self:buildEffsByCfg()
	self:updateEffStates()
end

function AvatarEffectsCtrl:onAvatarInvisible()
	AvatarEffectsCtrl.super.onAvatarInvisible(self)
	self:onAvatarReset()
end

function AvatarEffectsCtrl:onAvatarVisible()
	AvatarEffectsCtrl.super.onAvatarVisible(self)
	self:updateEffStates()
	self:updateSuitEffStates()
end

function AvatarEffectsCtrl:onAvatarReset()
	AvatarEffectsCtrl.super.onAvatarReset(self)

	if self._effs then
		for _, eff in pairs(self._effs) do
			eff:destroy()
		end
	end

	self._effs = nil
	self._layer = nil
	self._effsPlayType = AvatarFXEffType.IdleOnly

	self:clearAllSiutEffects()
end

function AvatarEffectsCtrl:onAvatarDestroy()
	AvatarEffectsCtrl.super.onAvatarDestroy(self)
end

function AvatarEffectsCtrl:setLayer(layer)
	self._layer = layer

	if self._effs then
		for _, eff in pairs(self._effs) do
			eff:setLayer(layer)
		end
	end
end

function AvatarEffectsCtrl:setEffect(effectPath, hangPointName, fxEffType)
	self._effs = self._effs or {}

	local hangPoint = self._avatar:getBoneByName(hangPointName)
	local key = effectPath .. "--" .. hangPointName

	if self._effs then
		local eff = self._effs[key]

		if not self._effs then
			eff = AvatarFxEffect.New()

			self._effs:setPlayType(fxEffType)
			self._effs:setLayer(self._layer)
			self._effs:setParent(hangPoint)
			self._effs:load(effectPath)
			self._effs:updateEffState(self._effsPlayType)

			self._effs[key] = self._effs
		end
	end
end

function AvatarEffectsCtrl:updateEffStates(updateType)
	self._effsPlayType = updateType or AvatarFXEffType.IdleOnly

	if self._effs then
		for _, eff in pairs(self._effs) do
			eff:updateEffState(self._effsPlayType)
		end
	end
end

function AvatarEffectsCtrl:clearAllEffects()
	if self._effs then
		for _, eff in pairs(self._effs) do
			eff:destroy()
		end
	end

	self._effs = nil
end

function AvatarEffectsCtrl:buildEffsByCfg()
	if self._avatar then
		local mo = self._avatar.avatarmo

		if mo then
			self:clearAllEffects()

			local list = mo:getOwnPartTypeNames()

			for k, v in pairs(list) do
				local type = table.keyof(AvatarPartTypeName, v)
				local value = type and mo:getDataByType(type)
				local cfg = AvatarConfig.instance:getPartCfgById(value)
				local pathStr = cfg and cfg.fxEffPath

				if not GameUtil.isEmptyString(pathStr) then
					local effStr = string.split(pathStr, "#")

					if effStr then
						for _, v in pairs(effStr) do
							local effParams = string.split(v, ":")
							local bone = effParams[1]
							local effPath = "avatars/skinedmeshes/otherres/fxeffests/" .. effParams[2] .. ".prefab"

							self:setEffect(effPath, bone)
						end
					else
						local effParams = string.split(pathStr, ":")
						local bone = effParams[1]
						local effPath = "avatars/skinedmeshes/otherres/fxeffests/" .. effParams[2] .. ".prefab"

						self:setEffect(effPath, bone)
					end
				end
			end
		end
	end
end

function AvatarEffectsCtrl:clearAllSiutEffects()
	if self._suitEffects then
		for _, eff in pairs(self._suitEffects) do
			eff:destroy()
		end
	end

	self._suitEffects = nil
end

function AvatarEffectsCtrl:updateSuitEffStates()
	self._effsPlayType = updateType or AvatarFXEffType.IdleOnly

	if self._suitEffects then
		for _, eff in pairs(self._suitEffects) do
			eff:updateEffState(AvatarFXEffType.Always)
		end
	end
end

function AvatarEffectsCtrl:buildSuitEffsByCfg()
	if self._avatar then
		if not self._avatar then
			return
		end

		self:clearAllSiutEffects()

		local suits = DressConfig.instance:getAllSuitCfgs()
		local suitEffect

		for i = 1, #suits do
			if self._avatar:isDressSuit(suits[i].include) then
				suitEffect = suits[i].effects

				break
			end
		end

		if string.nilorempty(suitEffect) then
			return
		end

		local effStr = string.split(suitEffect, "#")

		if not effStr then
			return
		end

		for _, v in pairs(effStr) do
			self:_buildOneSuitPartEff(v)
		end
	end
end

function AvatarEffectsCtrl:_buildOneSuitPartEff(effStr)
	local effParams = string.split(effStr, ":")
	local defineId = checknumber(effParams[1])
	local dressCo = DressConfig.instance:getDressCfgById(defineId)

	if not dressCo then
		return
	end

	local partCo = AvatarConfig.instance:getPartCfgById(dressCo.partId)

	if not partCo then
		return
	end

	local part = self._avatar.partsCtrl:getPartByType(partCo.partType)

	if not part then
		return
	end

	local boneName = effParams[2]
	local go = part:getGameObject()
	local bone

	if go then
		bone = GameUtil.findChildEx(go, boneName)
	end

	bone = bone or self._avatar:getBoneByName(boneName)

	if not bone then
		return
	end

	local effPath = "avatars/skinedmeshes/otherres/fxeffests/" .. effParams[3] .. ".prefab"

	self._suitEffects = self._suitEffects or {}

	local key = effPath .. "--" .. boneName

	if self._suitEffects then
		local eff = self._suitEffects[key]

		if not self._suitEffects then
			eff = AvatarFxEffect.New()

			self._suitEffects:setPlayType(AvatarFXEffType.Always)
			self._suitEffects:setLayer(self._layer)
			self._suitEffects:setParent(bone.transform)
			self._suitEffects:load(effPath)
			self._suitEffects:updateEffState(AvatarFXEffType.Always)

			self._suitEffects[key] = self._suitEffects
		end
	end
end

return AvatarEffectsCtrl
