-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/effect/AnimatorEffect.lua

module("logiccommon.common.effect.AnimatorEffect", package.seeall)

local AnimatorEffect = class("AnimatorEffect")

function AnimatorEffect:ctor()
	self._resLoader = MultiResLoader.New()
	self._animatorPath = nil
	self._finishCallBack = nil
	self._param = nil
end

function AnimatorEffect:onPlayEffect(raceIdBefore, raceIdAfter, animatorPath, func, param)
	self._finishCallBack = func
	self._param = param
	self._animatorPath = animatorPath
	self._resLoader.loadedCount = 0
	self._resPaths = {}
	self._raceIdBefore = raceIdBefore
	self._raceIdAfter = raceIdAfter

	self:_addRes(raceIdBefore)
	self:_addRes(raceIdAfter)
	self._resLoader:load(self._onModelResourcesLoaded, nil, self)
end

function AnimatorEffect:_addRes(raceId, func)
	local petCO = CharacterConfig.instance:getPetCo(raceId)
	local modelCo = CharacterConfig.instance:getModelCo(checknumber(petCO.faceIds))

	self._resPaths[raceId] = GameUrl.getSpineUrl(modelCo.resName)

	self._resLoader:addResPath(self._resPaths[raceId])
end

function AnimatorEffect:_onModelResourcesLoaded()
	self._modelBefore = self:_getResInstance(self._resPaths[self._raceIdBefore])
	self._modelBefore.layer = Framework.LayerUtil.NameToLayer("SkillAnimation")

	self._modelBefore.gameObject:SetActive(true)

	self._modelAfter = self:_getResInstance(self._resPaths[self._raceIdAfter])
	self._modelAfter.layer = Framework.LayerUtil.NameToLayer("SkillAnimation")

	self._modelAfter.gameObject:SetActive(true)
	self:_allModelLoaded()
end

function AnimatorEffect:_allModelLoaded()
	AnimationPlayer.instance:PlayAnim(self._animatorPath, 1, true, {
		self._modelAfter,
		self._modelBefore
	})
	AnimationPlayer.instance:setFinishCallback(self._onFinish, self)
end

function AnimatorEffect:_getResInstance(path)
	local res = self._resLoader:getResource(path)

	if res then
		local prefab = res:GetMainAsset()

		if prefab then
			return goutil.clone(prefab)
		end
	end

	return nil
end

function AnimatorEffect:_onFinish()
	goutil.destroy(self._modelBefore.gameObject)
	goutil.destroy(self._modelAfter.gameObject)

	if self._finishCallBack then
		self._finishCallBack()
	end
end

function AnimatorEffect:handlePlayerEvent(eventName, player)
	if eventName == "start" then
		-- block empty
	elseif eventName == "break" then
		goutil.find("UIROOT").gameObject:SetActive(true)
	elseif eventName == "stop" then
		goutil.destroy(self._modelBefore.gameObject)
		goutil.destroy(self._modelAfter.gameObject)

		if self._finishCallBack then
			self._finishCallBack()
		end
	end
end

function AnimatorEffect:handlerEvent()
	return
end

AnimatorEffect.instance = AnimatorEffect.New()

return AnimatorEffect
