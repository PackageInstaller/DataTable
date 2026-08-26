-- chunkname: @modules/logic/chessgame/game/interact/ChessInteractBase.lua

module("modules.logic.chessgame.game.interact.ChessInteractBase", package.seeall)

local ChessInteractBase = class("ChessInteractBase")

function ChessInteractBase:init(targetObj)
	self._target = targetObj
	self._isMoving = false
end

function ChessInteractBase:onSelectCall()
	return
end

function ChessInteractBase:onCancelSelect()
	return
end

function ChessInteractBase:onSelectPos(x, y)
	return
end

function ChessInteractBase:updatePos(x, y)
	self._srcX, self._srcY = self._target.mo.posX, self._target.mo.posY
	self._target.mo.posX = x
	self._target.mo.posY = y
end

function ChessInteractBase:moveTo(x, y, callback, callbackObj)
	if self._target.avatar then
		local pos = {
			z = 0,
			x = x,
			y = y
		}
		local v3 = ChessGameHelper.nodePosToWorldPos(pos)
		local avatar = self._target.avatar

		self:killMoveTween()

		self._moveCallback = callback
		self._moveCallbackObj = callbackObj
		self._isMoving = true
		self._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(avatar.sceneTf, v3.x, v3.y, v3.z, 0.225, self.onMoveCompleted, self, nil, EaseType.Linear)

		self:onMoveBegin()

		local dir = ChessGameHelper.ToDirection(self._srcX or self._target.mo.posX, self._srcY or self._target.mo.posY, x, y)

		self:faceTo(dir)
		self:_setDirNodeShow(false)
	elseif callback then
		callback(callbackObj)
	end
end

function ChessInteractBase:faceTo(dir)
	self._curDir = dir

	if self._target.avatar then
		if not ChessInteractComp.DirectionSet[self._curDir] then
			return
		end

		for i, tmpDir in ipairs(ChessInteractComp.DirectionList) do
			local child = self._target.avatar["goFaceTo" .. tmpDir]

			if not gohelper.isNil(child) then
				local show = dir == tmpDir

				gohelper.setActive(child, show)
			end

			local movetoDir = self._target.avatar["goMovetoDir" .. tmpDir]

			if not gohelper.isNil(movetoDir) then
				gohelper.setActive(movetoDir, dir == tmpDir)
			end
		end

		if self._target.mo then
			self._target.mo:setDirection(dir)
		end
	end

	if self._target.chessEffectObj and self._target.chessEffectObj.refreshEffectFaceTo then
		self._target.chessEffectObj:refreshEffectFaceTo()
	end
end

function ChessInteractBase:_setDirNodeShow(isShow)
	if self._target.avatar then
		local goDirNode = self._target.avatar.goNextDirection

		if not gohelper.isNil(goDirNode) then
			gohelper.setActive(goDirNode, isShow)
		end
	end
end

function ChessInteractBase:onMoveBegin()
	return
end

function ChessInteractBase:onMoveCompleted()
	self:_setDirNodeShow(true)
	self:refreshAlarmArea()

	if self._moveCallback then
		-- block empty
	end
end

function ChessInteractBase:onDrawAlert(map)
	return
end

function ChessInteractBase:setAlertActive(isActive)
	return
end

function ChessInteractBase:refreshAlarmArea()
	return
end

function ChessInteractBase:onAvatarLoaded()
	local var_14_0 = self._curDir

	if not self._curDir then
		var_14_0 = self._target.mo.direction

		if not self._target.mo.direction then
			local defaultDir = self._target.mo:getConfig().dir

			if defaultDir ~= nil and defaultDir ~= 0 then
				self:faceTo(defaultDir)
			end

			local loader = self._target.avatar.loader

			if not loader then
				return
			end

			local go = loader:getInstGO()

			if not gohelper.isNil(go) then
				self._animSelf = go:GetComponent(typeof(UnityEngine.Animator))
			end
		end
	end
end

function ChessInteractBase:showDestoryAni(callback, callbackObj)
	if self._animSelf then
		self._animSelf:Update(0)
		self._animSelf:Play("close", 0, 0)

		self._closeAnimCallback = callback
		self._closeAnimCallbackObj = callbackObj

		TaskDispatcher.runDelay(self._closeAnimCallback, self._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
	else
		callback(callbackObj)
	end
end

function ChessInteractBase:killMoveTween()
	if self._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(self._tweenIdMoveScene)

		self._tweenIdMoveScene = nil
	end
end

function ChessInteractBase:dispose()
	self:killMoveTween()
	TaskDispatcher.cancelTask(self._closeAnimCallback, self._closeAnimCallbackObj, ChessGameEnum.CloseAnimTime)
end

return ChessInteractBase
