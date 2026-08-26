-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionExploreTweenCamera.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionExploreTweenCamera", package.seeall)

local WaitGuideActionExploreTweenCamera = class("WaitGuideActionExploreTweenCamera", BaseGuideAction)

function WaitGuideActionExploreTweenCamera:onStart(context)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.MoveCamera)

	local map = ExploreController.instance:getMap()

	if not map then
		logError("不在密室中？？？")
		self:onDone(true)
	else
		local arr = string.split(self.actionParam, "#")
		local pos, moveTime

		if arr[1] == "POS" then
			local x = tonumber(arr[2]) or 0
			local y = tonumber(arr[3]) or 0

			moveTime = tonumber(arr[4]) or 0

			local node = ExploreMapModel.instance:getNode(ExploreHelper.getKeyXY(x, y))

			pos = Vector3.New(x + 0.5, (node or nil) and node.rawHeight, y + 0.5)
		elseif arr[1] == "ID" then
			local unit = map:getUnit(tonumber(arr[2]))

			if unit then
				pos = unit:getPos()
			end

			moveTime = tonumber(arr[3]) or 0
		elseif arr[1] == "HERO" then
			local hero = map:getHero()

			if hero then
				pos = hero:getPos()
			end

			moveTime = tonumber(arr[2]) or 0

			ExploreController.instance:registerCallback(ExploreEvent.OnCharacterPosChange, self.onHeroPosChange, self)
		else
			logError("暂不支持相机移动类型")
		end

		if not pos then
			self:onDone(true)
		else
			self._movePos = pos
			self._moveTime = moveTime

			if moveTime > 0 then
				GuideBlockMgr.instance:startBlock(moveTime)
			end

			self:_beginMove()
		end
	end
end

function WaitGuideActionExploreTweenCamera:onHeroPosChange(pos)
	self._movePos = pos
	self._offPos = self._movePos - self._beginPos
end

function WaitGuideActionExploreTweenCamera:_beginMove()
	local focusTrs = CameraMgr.instance:getFocusTrs()

	self._beginPos = focusTrs.position
	self._offPos = self._movePos - self._beginPos

	if self._offPos.sqrMagnitude > 100 then
		ViewMgr.instance:openView(ViewName.ExploreBlackView)
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	else
		self._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, self._moveTime, self._moveToTar, self._moveToTarDone, self)
	end
end

function WaitGuideActionExploreTweenCamera:_moveToTar(value)
	local pos = self._beginPos + self._offPos * value

	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, pos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, pos)
end

function WaitGuideActionExploreTweenCamera:_moveToTarDone()
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, self._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self._movePos)
	self:onDone(true)
end

function WaitGuideActionExploreTweenCamera:onOpenViewFinish(viewName)
	if viewName ~= ViewName.ExploreBlackView then
		return
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos, self._movePos)
	ExploreController.instance:dispatchEvent(ExploreEvent.SetCameraPos, self._movePos)
	TaskDispatcher.runDelay(self._delayLoadObj, self, 0.1)
end

function WaitGuideActionExploreTweenCamera:_delayLoadObj()
	ExploreController.instance:registerCallback(ExploreEvent.SceneObjAllLoadedDone, self._onBlackEnd, self)
	ExploreController.instance:getMap():markWaitAllSceneObj()
	ExploreController.instance:getMap():clearUnUseObj()
end

function WaitGuideActionExploreTweenCamera:_onBlackEnd()
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ViewMgr.instance:closeView(ViewName.ExploreBlackView)
end

function WaitGuideActionExploreTweenCamera:_onCloseViewFinish(viewName)
	if viewName == ViewName.ExploreBlackView then
		self:onDone(true)
	end
end

function WaitGuideActionExploreTweenCamera:clearWork()
	ExploreController.instance:dispatchEvent(ExploreEvent.SetFovTargetPos)
	TaskDispatcher.cancelTask(self._delayLoadObj, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.MoveCamera)
	ExploreController.instance:unregisterCallback(ExploreEvent.OnCharacterPosChange, self.onHeroPosChange, self)
	ExploreController.instance:unregisterCallback(ExploreEvent.SceneObjAllLoadedDone, self._onBlackEnd, self)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)

	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

return WaitGuideActionExploreTweenCamera
