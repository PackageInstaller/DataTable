-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/UnitCompSpineAnims.lua

module("logicscene.scene.unit.component.UnitCompSpineAnims", package.seeall)

local UnitCompSpineAnims = class("UnitCompSpineAnims", UnitCompSpine)

function UnitCompSpineAnims:ctor(unit)
	UnitCompSpineAnims.super.ctor(self, unit)

	self._spineCtrl = SimpleSpineCtrl.New()
end

function UnitCompSpineAnims:isAnimExists(animName)
	if self._allAnims then
		return self._allAnims[animName]
	end
end

function UnitCompSpineAnims:_onBodyLoaded(loader)
	local go = self._skeletonLoader:getInst()

	self:_recordAnims(go)

	self.isSpineLoaded = true

	self._spineCtrl:onInit(go)
	UnitCompSpineAnims.super._onBodyLoaded(self, loader)
	self:changeSkin("default")
end

function UnitCompSpineAnims:_recordAnims(go)
	if not self._allAnims then
		local animNames = GoUtil.GetAllSpineAnimNames(go)

		if animNames then
			self._allAnims = {}

			for i = 0, animNames.Length - 1 do
				self._allAnims[animNames[i]] = true
			end
		end
	end
end

function UnitCompSpineAnims:changeSkin(skinName)
	if self._spineCtrl:getSpineGo() ~= nil then
		self._spineCtrl:changeSkin(skinName)
	end
end

function UnitCompSpineAnims:getSkinNameList()
	if self._spineCtrl:getSpineGo() ~= nil then
		return self._spineCtrl:getSkinNameList()
	end

	return {}
end

function UnitCompSpineAnims:play(animState, isLoop, isForceRestart)
	if not self.isSpineLoaded then
		self._curAnimState = nil
		self._defaultAnimState = animState
		self._isLoop = isLoop or false

		return 0
	end

	if self._curAnimState == animState and isLoop then
		return 0
	end

	if self:isAnimExists(animState) then
		self._curAnimState = animState
		self._isLoop = isLoop or false

		if not goutil.isNil(self._skeletonAnimation) then
			GoUtil.PlaySpineAnim(self._skeletonAnimation.gameObject, animState, self._isLoop, isForceRestart or false)
		end

		if isLoop then
			return -1
		end

		local instance = self:getInst()

		if not goutil.isNil(instance) then
			return GoUtil.GetSpineAnimTime(self:getInst(), animState)
		end
	end

	self._curAnimState = animState
	self._isLoop = isLoop or false

	return 0
end

function UnitCompSpineAnims:playHitMatAnim()
	if self._animator == nil then
		local skeletonGO = self._skeletonLoader:getInst()
		local compType = typeof(UnityEngine.Animator)

		self._animator = skeletonGO:GetComponent(compType)

		if self._animator == nil then
			self._animator = skeletonGO:AddComponent(compType)
		end

		local resPath = "ui/animations/character_mat_hit.controller"

		getres(resPath, self._onResLoaded, self, ResType.AssetBunble, false)
	else
		self:_replayAnim()
	end
end

function UnitCompSpineAnims:_onResLoaded(res)
	if res.IsSuccess then
		res:Retain()

		self._animRes = res
		self._animator.runtimeAnimatorController = res:GetMainAsset()

		self._animator:Rebind()
		self:_replayAnim()
	end
end

function UnitCompSpineAnims:_replayAnim()
	self._animator:Play("character_mat_hit", 0, 0)
	self._animator:Update(0)

	self._animator.enabled = false
	self._animator.enabled = true
end

function UnitCompSpineAnims:clear()
	UnitCompSpineAnims.super.clear(self)

	if self._animRes then
		self._animRes:Release()
	end

	self._spineCtrl:onClear()

	self.isSpineLoaded = nil
	self._isLoop = true
	self._defaultAnimState = "idle"
	self._curAnimState = nil
	self._allAnims = nil
	self._animRes = nil

	local resPath = "ui/animations/character_mat_hit.controller"

	removeresl(resPath, self._onResLoaded, self)
end

function UnitCompSpineAnims:onDestroy()
	UnitCompSpineAnims.super.onDestroy(self)

	self._unit = nil
end

return UnitCompSpineAnims
