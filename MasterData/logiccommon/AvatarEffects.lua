-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/AvatarEffects.lua

module("logiccommon.common.avatar.AvatarEffects", package.seeall)

local AvatarEffects = class("AvatarEffects", AvatarAnimCtrl)

function AvatarEffects:getHagPoint(name)
	local hagPoint

	if self._bonesRef then
		hagPoint = self._bonesRef:GetBone(name)
	end

	if not hagPoint and self._animator then
		local go = self._animator.gameObject

		hagPoint = GameUtil.findChildEx(go, name)

		if hagPoint then
			return hagPoint.transform
		end
	end

	return hagPoint
end

function AvatarEffects:setLayer(layer)
	self.layer = layer

	if self._effects then
		for i = 1, #self._effects do
			self._effects[i]:setLayer(layer)
		end
	end
end

function AvatarEffects:setEffect(effectPath, hagPointName, fxEffType)
	self._effects = self._effects or {}

	local hagPoint = self:getHagPoint(hagPointName)
	local eff = AvatarFxEff.New()

	eff:load(effectPath, hagPoint, fxEffType)
	eff:setLayer(self.layer)
	eff:updateParent()
	table.insert(self._effects, eff)
	self:_updateEffState(eff)
end

function AvatarEffects:playAnim(currAnim, layer, normalizeTime)
	AvatarEffects.super.playAnim(self, currAnim, layer, normalizeTime)

	if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
		self:onWalk()
	else
		self:onIdle()
	end
end

function AvatarEffects:crossFadeInFixedTime(currAnim, layer, crossFadeFixed, normalizeTime)
	AvatarEffects.super.crossFadeInFixedTime(self, currAnim, layer, crossFadeFixed, normalizeTime)

	if currAnim == AnimatorHash.animWalk or currAnim == MainPlayerAnimState.Walk then
		self:onWalk()
	else
		self:onIdle()
	end
end

function AvatarEffects:setBool(id, val)
	AvatarEffects.super.setBool(self, id, val)

	if id == AnimatorHash.animWalk then
		if val then
			self:onWalk()
		else
			self:onIdle()
		end
	elseif val then
		self:onIdle()
	end
end

function AvatarEffects:onWalk()
	self._isWalking = true

	self:_updateAllEffStates()
end

function AvatarEffects:onIdle()
	self._isWalking = nil

	self:_updateAllEffStates()
end

function AvatarEffects:_updateAllEffStates()
	if self._effects then
		for i = 1, #self._effects do
			self:_updateEffState(self._effects[i])
		end
	end
end

function AvatarEffects:_updateEffState(eff)
	if eff.fxEffType == AvatarFXEffType.Always then
		eff:setVisible(true)

		return
	end

	if self._isWalking then
		eff:setVisible(eff.fxEffType == AvatarFXEffType.WalkOnly)
	else
		eff:setVisible(eff.fxEffType == AvatarFXEffType.IdleOnly)
	end
end

function AvatarEffects:clearEffects()
	self._isWalking = nil

	if self._effects then
		for i = 1, #self._effects do
			self._effects[i]:destroy()
		end

		self._effects = nil
	end
end

return AvatarEffects
