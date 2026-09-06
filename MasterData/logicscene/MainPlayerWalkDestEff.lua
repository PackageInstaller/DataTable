-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/mainplayer/MainPlayerWalkDestEff.lua

module("logicscene.scene.component.mainplayer.MainPlayerWalkDestEff", package.seeall)

local MainPlayerWalkDestEff = class("MainPlayerWalkDestEff", SceneComponentBase)

function MainPlayerWalkDestEff:ctor()
	self._groundEffectParent = UnityEngine.GameObject.New("fx_dianjidimian")

	self._groundEffectParent:SetActive(false)

	self._groundRes = nil
	self._isVisible = true

	self:_resetLocalInfo()
	self:_createGoundEffect()
	self:setVisible(false)
end

function MainPlayerWalkDestEff:_resetLocalInfo()
	self:setLocalPos(0, 0, -5)
	self:SetLocalScale(0.7, 0.7, 0.7)
	self:setLocalRotation(0, 0, 0)
end

function MainPlayerWalkDestEff:onExitScene()
	self:setVisible(false)
	self:_resetLocalInfo()
end

function MainPlayerWalkDestEff:_createGoundEffect()
	getres("effect/prefabs/common/scene/fx_dianji.prefab", self._onGoundEffectLoaded, self)
end

function MainPlayerWalkDestEff:_onGoundEffectLoaded(res)
	if not self._groundEffect and res then
		self._groundRes = res

		self._groundRes:Retain()

		local prefab = res:GetMainAsset()

		if prefab then
			self._groundEffect = goutil.clone(prefab)

			self._groundEffect.transform:SetParent(self._groundEffectParent.transform)
			Framework.TransformUtil.SetLocalPos(self._groundEffect.transform, self._localPos.x, self._localPos.y, self._localPos.z)
			Framework.TransformUtil.SetLocalScale(self._groundEffect.transform, self._localScale.x, self._localScale.y, self._localScale.z)
			Framework.TransformUtil.SetLocalRotation(self._groundEffect.transform, self._localEulerAngle.x, self._localEulerAngle.y, self._localScale.z)
		end
	end
end

function MainPlayerWalkDestEff:update(deltaTime)
	if self._isVisible and self._effTime > 0 then
		self._effTime = self._effTime - deltaTime

		if self._effTime <= 0 then
			self:setVisible(false)
		end
	end
end

function MainPlayerWalkDestEff:setVisible(visible)
	if self._isVisible == false and self._isVisible == visible then
		return
	end

	self._effTime = 1

	if visible and self._isVisible then
		goutil.setActive(self._groundEffectParent, false)
	end

	self._isVisible = visible

	goutil.setActive(self._groundEffectParent, visible)
end

function MainPlayerWalkDestEff:setPosition(x, y, z)
	Framework.TransformUtil.SetPos(self._groundEffectParent.transform, x or 0, y or 0, z or 0)
end

function MainPlayerWalkDestEff:setLocalPos(x, y, z)
	self._localPos = self._localPos or Vector3.New(0, 0, 0)
	self._localPos.x = x
	self._localPos.y = y
	self._localPos.z = z

	if not goutil.isNil(self._groundEffect) then
		Framework.TransformUtil.SetLocalPos(self._groundEffect.transform, self._localPos.x, self._localPos.y, self._localPos.z)
	end
end

function MainPlayerWalkDestEff:SetLocalScale(x, y, z)
	self._localScale = self._localScale or Vector3.New(0, 0, 0)
	self._localScale.x = x
	self._localScale.y = y
	self._localScale.z = z

	if not goutil.isNil(self._groundEffect) then
		Framework.TransformUtil.SetLocalScale(self._groundEffect.transform, self._localScale.x, self._localScale.y, self._localScale.z)
	end
end

function MainPlayerWalkDestEff:setLocalRotation(x, y, z)
	self._localEulerAngle = self._localEulerAngle or Vector3.New(0, 0, 0)
	self._localEulerAngle.x = x
	self._localEulerAngle.y = y
	self._localEulerAngle.z = z

	if not goutil.isNil(self._groundEffect) then
		Framework.TransformUtil.SetLocalRotation(self._groundEffect.transform, self._localEulerAngle.x, self._localEulerAngle.y, self._localEulerAngle.z)
	end
end

return MainPlayerWalkDestEff
