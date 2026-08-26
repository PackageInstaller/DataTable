-- chunkname: @modules/logic/scene/summon/comp/SummonSceneDirector.lua

module("modules.logic.scene.summon.comp.SummonSceneDirector", package.seeall)

local SummonSceneDirector = class("SummonSceneDirector", BaseSceneComp)

function SummonSceneDirector:onSceneStart(sceneId, levelId)
	self._scene = self:getCurScene()
	self._hasSummonView = false
	self._allStepReady = false

	self._scene.selector:registerCallback(SummonSceneEvent.OnSceneGOInited, self._onSelectorGOInited, self)

	self._hasCharPreload = VirtualSummonScene.instance:isABLoaded(true)

	if not self._hasEquipPreload or not self._hasCharPreload then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinish, self._onPreloadFinish, self)
	end

	if self._scene.selector:isSceneGOInited(true) then
		self:_onSelectorGOInited(true)
	end

	if VirtualSummonScene.instance:isOpenImmediately() then
		VirtualSummonScene.instance:checkNeedLoad(true, true)
	end

	self._scene.view:registerCallback(SummonSceneEvent.OnViewFinish, self._onViewReady, self)
	self._scene.view:openView()
end

function SummonSceneDirector:onScenePrepared()
	self:dispatchEvent(SummonSceneEvent.OnEnterScene)
end

function SummonSceneDirector:_onPreloadFinish(isChar)
	if isChar then
		self._hasCharPreload = true
	else
		self._hasEquipPreload = true
	end

	self:_checkAllResPrepared()
	VirtualSummonScene.instance:dispatchEvent(SummonSceneEvent.OnPreloadFinishAtScene, isChar)
end

function SummonSceneDirector:_onSelectorGOInited(isChar)
	if isChar then
		local sceneCharGO = self._scene.selector:getCharSceneGo()

		self._drawCompChar = MonoHelper.addLuaComOnceToGo(sceneCharGO, SummonDrawComp, sceneCharGO)

		local animGO = gohelper.findChild(sceneCharGO, "anim")

		if animGO then
			local anim = animGO:GetComponent(typeof(UnityEngine.Animator))

			if SummonController.instance:isInSummonGuide() then
				anim:Play(SummonEnum.SummonFogAnimationName, 0, 0)
			else
				anim:Play(SummonEnum.InitialStateAnimationName, 0, 0)
			end

			anim.speed = 0
		end
	else
		local sceneEquipGO = self._scene.selector:getEquipSceneGo()

		self._drawCompEquip = MonoHelper.addLuaComOnceToGo(sceneEquipGO, SummonDrawEquipComp, sceneEquipGO)

		local animGO = gohelper.findChild(sceneEquipGO, "anim")

		if animGO then
			local anim = animGO:GetComponent(typeof(UnityEngine.Animator))

			anim:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			anim.speed = 0
		end
	end

	SummonController.instance:prepareSummon()
end

function SummonSceneDirector:_onViewReady()
	self._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, self._onViewReady, self)

	self._hasSummonView = true

	self:_checkAllResPrepared()
end

function SummonSceneDirector:_checkAllResPrepared()
	if VirtualSummonScene.instance:isOpenImmediately() then
		if self._hasCharPreload then
			self._scene.selector:initSceneGO(true)

			if self._hasSummonView then
				self._allStepReady = true

				self._scene:onPrepared()
			end
		end
	elseif self._hasSummonView then
		self._allStepReady = true

		self._scene:onPrepared()
	end
end

function SummonSceneDirector:isPreloadReady(isChar)
	if isChar then
		return self._hasCharPreload
	else
		return self._hasEquipPreload
	end

	return false
end

function SummonSceneDirector:isReady()
	return self._allStepReady
end

function SummonSceneDirector:getDrawComp(resultType)
	if resultType == SummonEnum.ResultType.Equip then
		return self._drawCompEquip
	else
		return self._drawCompChar
	end
end

function SummonSceneDirector:onSceneClose()
	self._scene.selector:unregisterCallback(SummonSceneEvent.OnSceneGOInited, self._onSelectorGOInited, self)
	self._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, self._onViewReady, self)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinish, self._onPreloadFinish, self)

	self._drawCompChar = nil
	self._drawCompEquip = nil
	self._allStepReady = false
	self._hasCharPreload = false
	self._hasEquipPreload = false
end

function SummonSceneDirector:onSceneHide()
	self:onSceneClose()
end

return SummonSceneDirector
