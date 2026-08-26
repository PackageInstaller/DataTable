-- chunkname: @modules/logic/versionactivity1_3/va3chess/game/interacts/Va3ChessInteractBase.lua

module("modules.logic.versionactivity1_3.va3chess.game.interacts.Va3ChessInteractBase", package.seeall)

local Va3ChessInteractBase = class("Va3ChessInteractBase")

function Va3ChessInteractBase:init(targetObj)
	self._target = targetObj
end

function Va3ChessInteractBase:onSelectCall()
	return
end

function Va3ChessInteractBase:onCancelSelect()
	return
end

function Va3ChessInteractBase:onSelectPos(x, y)
	return
end

function Va3ChessInteractBase:updatePos(x, y)
	self._srcX, self._srcY = self._target.originData.posX, self._target.originData.posY
	self._target.originData.posX = x
	self._target.originData.posY = y
end

function Va3ChessInteractBase:moveTo(x, y, callback, callbackObj)
	if self._target.avatar and self._target.avatar.sceneTf then
		local sceneX, sceneY, sceneZ = Va3ChessGameController.instance:calcTilePosInScene(x, y, self._target.avatar.order, true)
		local avatar = self._target.avatar

		self:killMoveTween()

		self._moveCallback = callback
		self._moveCallbackObj = callbackObj
		self._tweenIdMoveScene = ZProj.TweenHelper.DOLocalMove(avatar.sceneTf, sceneX, sceneY, sceneZ, 0.225, self.onMoveCompleted, self, nil, EaseType.Linear)

		self:onMoveBegin()

		local dir = Va3ChessMapUtils.ToDirection(self._srcX, self._srcY, x, y)

		self:faceTo(dir)
		self:_setDirNodeShow(false)
	elseif callback then
		callback(callbackObj)
	end
end

function Va3ChessInteractBase:faceTo(dir)
	self._curDir = dir

	if self._target.avatar then
		if not Va3ChessInteractObject.DirectionSet[self._curDir] then
			return
		end

		for i, tmpDir in ipairs(Va3ChessInteractObject.DirectionList) do
			local child = self._target.avatar["goFaceTo" .. tmpDir]

			if not gohelper.isNil(child) then
				gohelper.setActive(child, dir == tmpDir)
			end

			local movetoDir = self._target.avatar["goMovetoDir" .. tmpDir]

			if not gohelper.isNil(movetoDir) then
				gohelper.setActive(movetoDir, dir == tmpDir)
			end
		end

		if self._target.originData then
			self._target.originData:setDirection(dir)
		end
	end

	if self._target.chessEffectObj and self._target.chessEffectObj.refreshEffectFaceTo then
		self._target.chessEffectObj:refreshEffectFaceTo()
	end
end

function Va3ChessInteractBase:_setDirNodeShow(isShow)
	if self._target.avatar then
		local goDirNode = self._target.avatar.goNextDirection

		if not gohelper.isNil(goDirNode) then
			gohelper.setActive(goDirNode, isShow)
		end
	end
end

function Va3ChessInteractBase:onMoveBegin()
	return
end

function Va3ChessInteractBase:onMoveCompleted()
	self:_setDirNodeShow(true)

	if self._moveCallback then
		-- block empty
	end
end

function Va3ChessInteractBase:onDrawAlert(map)
	return
end

function Va3ChessInteractBase:setAlertActive(isActive)
	return
end

function Va3ChessInteractBase:onAvatarLoaded()
	if not self._curDir then
		if self._curDir ~= nil and self._curDir ~= 0 then
			self:faceTo(self._curDir)
		end
	end
end

function Va3ChessInteractBase:killMoveTween()
	if self._tweenIdMoveScene then
		ZProj.TweenHelper.KillById(self._tweenIdMoveScene)

		self._tweenIdMoveScene = nil
	end
end

function Va3ChessInteractBase:dispose()
	self:killMoveTween()
end

return Va3ChessInteractBase
